Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C9775D338
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjGUTIN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjGUTIM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:08:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6657B1BF4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:08:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFFE861D95
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E312C433C7;
        Fri, 21 Jul 2023 19:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966490;
        bh=e/erS0Qtrc5BnQazcB/s7JaCf9/gvGHjAnjvLvqbeRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yFq5kKo+cJ1fA505fS2wtjmXBVpS8qBYbHHiT4aeYLZFtkq+FdVJ29T2xOWMhXpcJ
         T0j0IuG1arPb/Um2BkIDPk0XYh/VZe4+YJmbXA3iQh2FfZ8+4/d7nMOUMFWVnW/Ilr
         ClsZ7vTIlG6viwg9e3cLGCP9pFVMRcihJIFyMiQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.15 363/532] fs: avoid empty option when generating legacy mount string
Date:   Fri, 21 Jul 2023 18:04:27 +0200
Message-ID: <20230721160634.145778087@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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


