Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0367B8737
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243718AbjJDSCz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243711AbjJDSCz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:02:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525B5A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:02:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9E3C433C8;
        Wed,  4 Oct 2023 18:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442571;
        bh=Jhq9r6JKpAg3FGbFY97GUNK8kqFTzV42wOqRlgMKiLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kmXDrLMoGUe0V2XG7EUXICAEXoe2Im4vgRPU2PxrpsIZNpMhRmEVayRr6rK4LwS9A
         5j3QJV08Khs5kSqorz3c3+MF8KoNPRP5CsgF7gXdBL36IQs5FdDKlMSNKo7H88BnJp
         zId53mU2HcbkRg3LkHUtx6vZwbeRjqH54meySlsY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Keeping <john@metanate.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 007/183] tracing: Make trace_marker{,_raw} stream-like
Date:   Wed,  4 Oct 2023 19:53:58 +0200
Message-ID: <20231004175204.288156815@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Keeping <john@metanate.com>

[ Upstream commit 2972e3050e3517a85ca1813b227d4c302e804343 ]

The tracing marker files are write-only streams with no meaningful
concept of file position.  Using stream_open() to mark them as
stream-link indicates this and has the added advantage that a single
file descriptor can now be used from multiple threads without contention
thanks to clearing FMODE_ATOMIC_POS.

Note that this has the potential to break existing userspace by since
both lseek(2) and pwrite(2) will now return ESPIPE when previously lseek
would have updated the stored offset and pwrite would have appended to
the trace.  A survey of libtracefs and several other projects found to
use trace_marker(_raw) [1][2][3] suggests that everyone limits
themselves to calling write(2) and close(2) on these file descriptors so
there is a good chance this will go unnoticed and the benefits of
reduced overhead and lock contention seem worth the risk.

[1] https://github.com/google/perfetto
[2] https://github.com/intel/media-driver/
[3] https://w1.fi/cgit/hostap/

Link: https://lkml.kernel.org/r/20211207142558.347029-1-john@metanate.com

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Stable-dep-of: f5ca233e2e66 ("tracing: Increase trace array ref count on enable and filter files")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6adacfc880d6c..5aa23a4382c5e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4887,6 +4887,12 @@ int tracing_open_generic_tr(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static int tracing_mark_open(struct inode *inode, struct file *filp)
+{
+	stream_open(inode, filp);
+	return tracing_open_generic_tr(inode, filp);
+}
+
 static int tracing_release(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
@@ -7225,9 +7231,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if (tt)
 		event_triggers_post_call(tr->trace_marker_file, tt);
 
-	if (written > 0)
-		*fpos += written;
-
 	return written;
 }
 
@@ -7286,9 +7289,6 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 
 	__buffer_unlock_commit(buffer, event);
 
-	if (written > 0)
-		*fpos += written;
-
 	return written;
 }
 
@@ -7699,16 +7699,14 @@ static const struct file_operations tracing_free_buffer_fops = {
 };
 
 static const struct file_operations tracing_mark_fops = {
-	.open		= tracing_open_generic_tr,
+	.open		= tracing_mark_open,
 	.write		= tracing_mark_write,
-	.llseek		= generic_file_llseek,
 	.release	= tracing_release_generic_tr,
 };
 
 static const struct file_operations tracing_mark_raw_fops = {
-	.open		= tracing_open_generic_tr,
+	.open		= tracing_mark_open,
 	.write		= tracing_mark_raw_write,
-	.llseek		= generic_file_llseek,
 	.release	= tracing_release_generic_tr,
 };
 
-- 
2.40.1



