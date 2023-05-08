Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762A46FAC43
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjEHLWn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbjEHLWk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:22:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AA238F1E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:22:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2D5062CAE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B23C433D2;
        Mon,  8 May 2023 11:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544947;
        bh=KAjYB6ti13f9wuDbnoHFG3N9xOQDs7WBjB0qrkRKfxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pfanL3xPKRwMqpvt+Qh8x/J84YNfMZm788zZIY3YG9mApt7aAH/sLbGPdqxg4dri8
         TNDhAhbC8Nps6QjlwTzvjzSOGaeYLkiJ5qkyGodsrYYmHVNWM1pFRSMyz3N37EdVli
         ZwrFKwv9PijzfTjsw/eZEEnLwNzFo2v1/MUjh2PQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Doug Cook <dcook@linux.microsoft.com>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 573/694] tracing/user_events: Ensure write index cannot be negative
Date:   Mon,  8 May 2023 11:46:48 +0200
Message-Id: <20230508094453.464610229@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

[ Upstream commit cd98c93286a30cc4588dfd02453bec63c2f4acf4 ]

The write index indicates which event the data is for and accesses a
per-file array. The index is passed by user processes during write()
calls as the first 4 bytes. Ensure that it cannot be negative by
returning -EINVAL to prevent out of bounds accesses.

Update ftrace self-test to ensure this occurs properly.

Link: https://lkml.kernel.org/r/20230425225107.8525-2-beaub@linux.microsoft.com

Fixes: 7f5a08c79df3 ("user_events: Add minimal support for trace_event into ftrace")
Reported-by: Doug Cook <dcook@linux.microsoft.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_user.c                  | 3 +++
 tools/testing/selftests/user_events/ftrace_test.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 908e8a13c675b..625cab4b9d945 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1398,6 +1398,9 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 	if (unlikely(copy_from_iter(&idx, sizeof(idx), i) != sizeof(idx)))
 		return -EFAULT;
 
+	if (idx < 0)
+		return -EINVAL;
+
 	rcu_read_lock_sched();
 
 	refs = rcu_dereference_sched(info->refs);
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index 404a2713dcae8..1bc26e6476fc3 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -294,6 +294,11 @@ TEST_F(user, write_events) {
 	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 3));
 	after = trace_bytes();
 	ASSERT_GT(after, before);
+
+	/* Negative index should fail with EINVAL */
+	reg.write_index = -1;
+	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 3));
+	ASSERT_EQ(EINVAL, errno);
 }
 
 TEST_F(user, write_fault) {
-- 
2.39.2



