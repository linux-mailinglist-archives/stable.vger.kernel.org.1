Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A80B713F81
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjE1TqI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjE1TqH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:46:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0F3BB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:46:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0828C61F5E
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FEEC433D2;
        Sun, 28 May 2023 19:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303165;
        bh=lDq33r+Xd6bsnUfmK0/am/43ciafYDk9OkG43+eN9qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XdlMZHUzExSjVnonoPYgor9N/RZrX0na7ggR6Ly2ANZp9EC35YTxsX4omkXOZf06q
         D0dVEl5gx3HKbJB1Kskn1af386RrWZN/Pvm3ZmEPvC80iMTxJ6MxX8+xEdx6DUkGdV
         1cZ3AwaTll+01bqUsIQIHIdpSFA+Ql1cAQzXPX9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 5.10 143/211] statfs: enforce statfs[64] structure initialization
Date:   Sun, 28 May 2023 20:11:04 +0100
Message-Id: <20230528190847.067007767@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ilya Leoshkevich <iii@linux.ibm.com>

commit ed40866ec7d328b3dfb70db7e2011640a16202c3 upstream.

s390's struct statfs and struct statfs64 contain padding, which
field-by-field copying does not set. Initialize the respective structs
with zeros before filling them and copying them to userspace, like it's
already done for the compat versions of these structs.

Found by KMSAN.

[agordeev@linux.ibm.com: fixed typo in patch description]
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/r/20230504144021.808932-2-iii@linux.ibm.com
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/statfs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -130,6 +130,7 @@ static int do_statfs_native(struct kstat
 	if (sizeof(buf) == sizeof(*st))
 		memcpy(&buf, st, sizeof(*st));
 	else {
+		memset(&buf, 0, sizeof(buf));
 		if (sizeof buf.f_blocks == 4) {
 			if ((st->f_blocks | st->f_bfree | st->f_bavail |
 			     st->f_bsize | st->f_frsize) &
@@ -158,7 +159,6 @@ static int do_statfs_native(struct kstat
 		buf.f_namelen = st->f_namelen;
 		buf.f_frsize = st->f_frsize;
 		buf.f_flags = st->f_flags;
-		memset(buf.f_spare, 0, sizeof(buf.f_spare));
 	}
 	if (copy_to_user(p, &buf, sizeof(buf)))
 		return -EFAULT;
@@ -171,6 +171,7 @@ static int do_statfs64(struct kstatfs *s
 	if (sizeof(buf) == sizeof(*st))
 		memcpy(&buf, st, sizeof(*st));
 	else {
+		memset(&buf, 0, sizeof(buf));
 		buf.f_type = st->f_type;
 		buf.f_bsize = st->f_bsize;
 		buf.f_blocks = st->f_blocks;
@@ -182,7 +183,6 @@ static int do_statfs64(struct kstatfs *s
 		buf.f_namelen = st->f_namelen;
 		buf.f_frsize = st->f_frsize;
 		buf.f_flags = st->f_flags;
-		memset(buf.f_spare, 0, sizeof(buf.f_spare));
 	}
 	if (copy_to_user(p, &buf, sizeof(buf)))
 		return -EFAULT;


