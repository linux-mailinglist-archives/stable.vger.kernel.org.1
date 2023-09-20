Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9547A805B
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbjITMgp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbjITMgp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:36:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5213892
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:36:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8936EC433C9;
        Wed, 20 Sep 2023 12:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213397;
        bh=lvSJuONdWZZOOwnlJKdtfRyDoomvZ7C7f2/X3i7OiFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekgKNyv4Kr2BjnWlOlxsanCtoMFH+HCmadcvdzZQSO4+yTpb6jGCEtyrvCQxGfR73
         fmwl6l7wlXnM/eeMrquDxFxenP1tAnVmpH8xLLjpCxlhj8DndCqIMRwFD0lD5JsLr3
         /TCM0Sts4AE0umt3T3O87T8c9WVlgqDvefIiDyv8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.4 223/367] procfs: block chmod on /proc/thread-self/comm
Date:   Wed, 20 Sep 2023 13:30:00 +0200
Message-ID: <20230920112904.360439766@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksa Sarai <cyphar@cyphar.com>

commit ccf61486fe1e1a48e18c638d1813cda77b3c0737 upstream.

Due to an oversight in commit 1b3044e39a89 ("procfs: fix pthread
cross-thread naming if !PR_DUMPABLE") in switching from REG to NOD,
chmod operations on /proc/thread-self/comm were no longer blocked as
they are on almost all other procfs files.

A very similar situation with /proc/self/environ was used to as a root
exploit a long time ago, but procfs has SB_I_NOEXEC so this is simply a
correctness issue.

Ref: https://lwn.net/Articles/191954/
Ref: 6d76fa58b050 ("Don't allow chmod() on the /proc/<pid>/ files")
Fixes: 1b3044e39a89 ("procfs: fix pthread cross-thread naming if !PR_DUMPABLE")
Cc: stable@vger.kernel.org # v4.7+
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
Message-Id: <20230713141001.27046-1-cyphar@cyphar.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/base.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3412,7 +3412,8 @@ static int proc_tid_comm_permission(stru
 }
 
 static const struct inode_operations proc_tid_comm_inode_operations = {
-		.permission = proc_tid_comm_permission,
+		.setattr	= proc_setattr,
+		.permission	= proc_tid_comm_permission,
 };
 
 /*


