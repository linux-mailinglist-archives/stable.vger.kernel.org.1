Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB5E7556F9
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjGPUzy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjGPUzx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:55:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6D6E41
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:55:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C067660EBC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A11C433C8;
        Sun, 16 Jul 2023 20:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540952;
        bh=e/erS0Qtrc5BnQazcB/s7JaCf9/gvGHjAnjvLvqbeRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mYMT6J9f+e+T4u4t1Cpb4hH71A6K1ZRNnDn7oAsdVg1WNwz6VUh5xZHxsRbgZwInv
         ZnDtZrMVUhwgtKdnakMCIwm3ouEEc4u0ATfCUr6YH1BkJc81oP42DswW/MF1OY+IbT
         bIxTUhH7mTI1lGLfmJdbdhUwKZiu4BjXp9um8A/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.1 546/591] fs: avoid empty option when generating legacy mount string
Date:   Sun, 16 Jul 2023 21:51:25 +0200
Message-ID: <20230716194937.987984790@linuxfoundation.org>
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

From: Thomas Weißschuh <linux@weissschuh.net>

commit 62176420274db5b5127cd7a0083a9aeb461756ee upstream.

As each option string fragment is always prepended with a comma it would
happen that the whole string always starts with a comma. This could be
interpreted by filesystem drivers as an empty option and may produce
errors.

For example the NTFS driver from ntfs.ko behaves like this and fails
when mounted via the new API.

Link: https://github.com/util-linux/util-linux/issues/2298
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock creation/configuration context")
Cc: stable@vger.kernel.org
Message-Id: <20230607-fs-empty-option-v1-1-20c8dbf4671b@weissschuh.net>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fs_context.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -561,7 +561,8 @@ static int legacy_parse_param(struct fs_
 			return -ENOMEM;
 	}
 
-	ctx->legacy_data[size++] = ',';
+	if (size)
+		ctx->legacy_data[size++] = ',';
 	len = strlen(param->key);
 	memcpy(ctx->legacy_data + size, param->key, len);
 	size += len;


