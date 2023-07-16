Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820CF7556BB
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjGPUxd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjGPUxc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:53:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148A110D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91C5960E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A419FC433C9;
        Sun, 16 Jul 2023 20:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540810;
        bh=R0QNjeLgR9Vga4TfzejPaAfL22GXEdlss4H5o8JRznM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gj+ZhyozCPtq3EwO2ydRzW8jrCryM06m0dLigjSw4QvuwN4eMTKYq1OTZ2yU5cKJD
         txE/Zpf4PCThLLzRBXH0xuUrPTJcbEyamXD4dD5PbfndbWhsPWjGQlJxYSMdmROZzj
         Ej7PRt3lyeS8FTVLurXCVCiBmt7Xe4vFwkygu6sE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 468/591] f2fs: check return value of freeze_super()
Date:   Sun, 16 Jul 2023 21:50:07 +0200
Message-ID: <20230716194936.013034051@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chao Yu <chao@kernel.org>

[ Upstream commit 8bec7dd1b3f7d7769d433d67bde404de948a2d95 ]

freeze_super() can fail, it needs to check its return value and do
error handling in f2fs_resize_fs().

Fixes: 04f0b2eaa3b3 ("f2fs: ioctl for removing a range from F2FS")
Fixes: b4b10061ef98 ("f2fs: refactor resize_fs to avoid meta updates in progress")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3de887d07c060..aa4d513daa8f8 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2186,7 +2186,9 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	if (err)
 		return err;
 
-	freeze_super(sbi->sb);
+	err = freeze_super(sbi->sb);
+	if (err)
+		return err;
 
 	if (f2fs_readonly(sbi->sb)) {
 		thaw_super(sbi->sb);
-- 
2.39.2



