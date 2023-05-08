Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AD16FA60A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjEHKPf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjEHKPe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:15:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06203A281
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:15:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 241C46248A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B32C433D2;
        Mon,  8 May 2023 10:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540931;
        bh=ftWWElOnL/oMVd6/TR1RbBiXJoodE2EhuMa1gDAAdPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pV2/rXkwUHPxfTWIgP70g6LDoaBSVlrHfQzQ8XCoY3mHee/19jxEmqzRFG1172lrn
         bVAHBMsudasL0VQh2JAkHBaM2bpOhunrwhPIdgHsXCjw5EsXYMXQcLYqQ+RgHptUlK
         H+iskI7qI/MY0PFdx5LbGlFSrFdP3j6yDlyBX90E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bharath SM <bharathsm@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 6.1 521/611] SMB3: Add missing locks to protect deferred close file list
Date:   Mon,  8 May 2023 11:46:03 +0200
Message-Id: <20230508094438.958311552@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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
index cf19e6a81ed99..f3903ae0cc6b8 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -742,7 +742,9 @@ cifs_close_deferred_file(struct cifsInodeInfo *cifs_inode)
 	list_for_each_entry(cfile, &cifs_inode->openFileList, flist) {
 		if (delayed_work_pending(&cfile->deferred)) {
 			if (cancel_delayed_work(&cfile->deferred)) {
+				spin_lock(&cifs_inode->deferred_lock);
 				cifs_del_deferred_close(cfile);
+				spin_unlock(&cifs_inode->deferred_lock);
 
 				tmp_list = kmalloc(sizeof(struct file_list), GFP_ATOMIC);
 				if (tmp_list == NULL)
@@ -773,7 +775,9 @@ cifs_close_all_deferred_files(struct cifs_tcon *tcon)
 	list_for_each_entry(cfile, &tcon->openFileList, tlist) {
 		if (delayed_work_pending(&cfile->deferred)) {
 			if (cancel_delayed_work(&cfile->deferred)) {
+				spin_lock(&CIFS_I(d_inode(cfile->dentry))->deferred_lock);
 				cifs_del_deferred_close(cfile);
+				spin_unlock(&CIFS_I(d_inode(cfile->dentry))->deferred_lock);
 
 				tmp_list = kmalloc(sizeof(struct file_list), GFP_ATOMIC);
 				if (tmp_list == NULL)
@@ -808,7 +812,9 @@ cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon, const char *path)
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



