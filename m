Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC056FAC8A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbjEHLZx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbjEHLZi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:25:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ED43A5FD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:25:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E9E962D5D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A752FC4339B;
        Mon,  8 May 2023 11:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545119;
        bh=yHu5V06KxGEBfdYq5NX4EMNjP7VX1iZ3Eb3tT7JztvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8RuELiAfYSUxzth5pLsvU0bSMpHDndfAzHlCFS8ck97jXye4S2ymymhCeYf4j4L4
         FQBlfuwTl11lrGuq93w0wpWtk67/9r9NlyzNwwQXKBHQ4oliHAAHOYpIN/rrcxTPgJ
         KUPjJCdD7LoJKi5fCK7Hmho+VPUW7MGquP9Se+oM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bharath SM <bharathsm@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 6.3 630/694] SMB3: Add missing locks to protect deferred close file list
Date:   Mon,  8 May 2023 11:47:45 +0200
Message-Id: <20230508094456.060204628@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bharath SM <bharathsm@microsoft.com>

[ Upstream commit ab9ddc87a9055c4bebd6524d5d761d605d52e557 ]

cifs_del_deferred_close function has a critical section which modifies
the deferred close file list. We must acquire deferred_lock before
calling cifs_del_deferred_close function.

Fixes: ca08d0eac020 ("cifs: Fix memory leak on the deferred close")
Signed-off-by: Bharath SM <bharathsm@microsoft.com>
Acked-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/misc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 7f085ed2d866b..f76e9bb7d7423 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -749,7 +749,9 @@ cifs_close_deferred_file(struct cifsInodeInfo *cifs_inode)
 	list_for_each_entry(cfile, &cifs_inode->openFileList, flist) {
 		if (delayed_work_pending(&cfile->deferred)) {
 			if (cancel_delayed_work(&cfile->deferred)) {
+				spin_lock(&cifs_inode->deferred_lock);
 				cifs_del_deferred_close(cfile);
+				spin_unlock(&cifs_inode->deferred_lock);
 
 				tmp_list = kmalloc(sizeof(struct file_list), GFP_ATOMIC);
 				if (tmp_list == NULL)
@@ -780,7 +782,9 @@ cifs_close_all_deferred_files(struct cifs_tcon *tcon)
 	list_for_each_entry(cfile, &tcon->openFileList, tlist) {
 		if (delayed_work_pending(&cfile->deferred)) {
 			if (cancel_delayed_work(&cfile->deferred)) {
+				spin_lock(&CIFS_I(d_inode(cfile->dentry))->deferred_lock);
 				cifs_del_deferred_close(cfile);
+				spin_unlock(&CIFS_I(d_inode(cfile->dentry))->deferred_lock);
 
 				tmp_list = kmalloc(sizeof(struct file_list), GFP_ATOMIC);
 				if (tmp_list == NULL)
@@ -815,7 +819,9 @@ cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon, const char *path)
 		if (strstr(full_path, path)) {
 			if (delayed_work_pending(&cfile->deferred)) {
 				if (cancel_delayed_work(&cfile->deferred)) {
+					spin_lock(&CIFS_I(d_inode(cfile->dentry))->deferred_lock);
 					cifs_del_deferred_close(cfile);
+					spin_unlock(&CIFS_I(d_inode(cfile->dentry))->deferred_lock);
 
 					tmp_list = kmalloc(sizeof(struct file_list), GFP_ATOMIC);
 					if (tmp_list == NULL)
-- 
2.39.2



