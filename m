Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0434672700F
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbjFGVEV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbjFGVD4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:03:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6784C2D41
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:03:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09D8B649AA
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 21:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F692C433D2;
        Wed,  7 Jun 2023 21:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171817;
        bh=YDF06t5nD5XZiviinEp+UiP1Pdh4ogkQi46WvsT/GjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNCaOUxsQftdX4dts5GQBrE6seMhIJhJk1pVVxhO5LJJH9jZFLC8wnxRhCm529yUz
         qoDzn1D415VKrcAvNyUmVeIi3Kif+rWZlwI+hU8Ow4BS60ZJOtFKDtygnRgMS0D89j
         qpi09RUkvSB/wfwzI80BvSsfkZaTg2y231hzOCKQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 145/159] ksmbd: fix incorrect AllocationSize set in smb2_get_info
Date:   Wed,  7 Jun 2023 22:17:28 +0200
Message-ID: <20230607200908.413993085@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

commit 6cc2268f5647cbfde3d4fc2e4ee005070ea3a8d2 upstream.

If filesystem support sparse file, ksmbd should return allocated size
using ->i_blocks instead of stat->size. This fix generic/694 xfstests.

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2pdu.c |   21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -4359,21 +4359,6 @@ static int get_file_basic_info(struct sm
 	return 0;
 }
 
-static unsigned long long get_allocation_size(struct inode *inode,
-					      struct kstat *stat)
-{
-	unsigned long long alloc_size = 0;
-
-	if (!S_ISDIR(stat->mode)) {
-		if ((inode->i_blocks << 9) <= stat->size)
-			alloc_size = stat->size;
-		else
-			alloc_size = inode->i_blocks << 9;
-	}
-
-	return alloc_size;
-}
-
 static void get_file_standard_info(struct smb2_query_info_rsp *rsp,
 				   struct ksmbd_file *fp, void *rsp_org)
 {
@@ -4388,7 +4373,7 @@ static void get_file_standard_info(struc
 	sinfo = (struct smb2_file_standard_info *)rsp->Buffer;
 	delete_pending = ksmbd_inode_pending_delete(fp);
 
-	sinfo->AllocationSize = cpu_to_le64(get_allocation_size(inode, &stat));
+	sinfo->AllocationSize = cpu_to_le64(inode->i_blocks << 9);
 	sinfo->EndOfFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
 	sinfo->NumberOfLinks = cpu_to_le32(get_nlink(&stat) - delete_pending);
 	sinfo->DeletePending = delete_pending;
@@ -4453,7 +4438,7 @@ static int get_file_all_info(struct ksmb
 	file_info->Attributes = fp->f_ci->m_fattr;
 	file_info->Pad1 = 0;
 	file_info->AllocationSize =
-		cpu_to_le64(get_allocation_size(inode, &stat));
+		cpu_to_le64(inode->i_blocks << 9);
 	file_info->EndOfFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
 	file_info->NumberOfLinks =
 			cpu_to_le32(get_nlink(&stat) - delete_pending);
@@ -4642,7 +4627,7 @@ static int get_file_network_open_info(st
 	file_info->ChangeTime = cpu_to_le64(time);
 	file_info->Attributes = fp->f_ci->m_fattr;
 	file_info->AllocationSize =
-		cpu_to_le64(get_allocation_size(inode, &stat));
+		cpu_to_le64(inode->i_blocks << 9);
 	file_info->EndOfFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
 	file_info->Reserved = cpu_to_le32(0);
 	rsp->OutputBufferLength =


