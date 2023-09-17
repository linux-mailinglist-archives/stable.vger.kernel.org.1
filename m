Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12587A3945
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbjIQTrO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240030AbjIQTqu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:46:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0126F12F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:46:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3170DC433C8;
        Sun, 17 Sep 2023 19:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980004;
        bh=+AuWhvgK8yBaEgnxhQqwzkn0VjYNuxU2qAFSFXQolyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUkhY8eAkgoQVKRnHDkf3IZtKDlmsJ8+fE94hWnis7Qgy7B1Z5ns1qWIzwwiVXTGM
         Jpv1R8BwPIS2+JqX5KvtM5cKMhin41xAr2D54eipzi/tbiC1zHW1Qf7rpfm9shV0BZ
         gRAg6+WcClgDwCuSaQ+GWeT7TfsAqwnobD8EvmK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bharath SM <bharathsm@microsoft.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.5 041/285] cifs: update desired access while requesting for directory lease
Date:   Sun, 17 Sep 2023 21:10:41 +0200
Message-ID: <20230917191053.092955161@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,TVD_PH_SUBJ_META1,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bharath SM <bharathsm@microsoft.com>

commit b6d44d42313baa45a81ce9b299aeee2ccf3d0ee1 upstream.

We read and cache directory contents when we get directory
lease, so we should ask for read permission to read contents
of directory.

Signed-off-by: Bharath SM <bharathsm@microsoft.com>
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cached_dir.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -218,7 +218,7 @@ int open_cached_dir(unsigned int xid, st
 		.tcon = tcon,
 		.path = path,
 		.create_options = cifs_create_options(cifs_sb, CREATE_NOT_FILE),
-		.desired_access = FILE_READ_ATTRIBUTES,
+		.desired_access =  FILE_READ_DATA | FILE_READ_ATTRIBUTES,
 		.disposition = FILE_OPEN,
 		.fid = pfid,
 	};


