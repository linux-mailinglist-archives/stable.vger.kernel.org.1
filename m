Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408117A7E4C
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjITMRD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbjITMRD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:17:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F489CE8
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:16:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FDDC433B6;
        Wed, 20 Sep 2023 12:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212188;
        bh=/0eGUFvhZlgzcqyGR3uO+0rf5VH2ijssEVXagZKnZcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xl0kLlJ2txChoOwUkmd/kMa49912kbI/forEfb3P5IvndVMqjY/61daywTNO3UM47
         qsuhpW2D5DcRNUfeHZKXlAzjB9NosZ+6C43N5MjQnvL+ml9DHgOS8wI62DT9+oD7Sg
         nJpdzLcz5efbjaAVqdAjhMcjLmQr8LRrEKGswBSE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 4.19 183/273] procfs: block chmod on /proc/thread-self/comm
Date:   Wed, 20 Sep 2023 13:30:23 +0200
Message-ID: <20230920112852.168453672@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3338,7 +3338,8 @@ static int proc_tid_comm_permission(stru
 }
 
 static const struct inode_operations proc_tid_comm_inode_operations = {
-		.permission = proc_tid_comm_permission,
+		.setattr	= proc_setattr,
+		.permission	= proc_tid_comm_permission,
 };
 
 /*


