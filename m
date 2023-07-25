Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175FC761700
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjGYLn5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbjGYLn0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:43:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200F81FC9
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:43:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 256B5616C1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3064CC433C8;
        Tue, 25 Jul 2023 11:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285336;
        bh=PlqqDo3CY92dCOIM/LGBz3jwW3wh0VH/VCNdwJBXRNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DouRHZ/0kPHBgytdEZtq+sl8R403w18OAuKuY3TBHTHSJcQLM5e9MEd6haNsQmw+0
         o1lCcT7xn2UEy/AFgPMuj3i0BowJxQQ7ErU8HQ/mnzzgdNJk4iskkbFmiMuTIOURuN
         AqkrSfUGucmMdBswpQ0jredn+2rVDeFtCrV/fUoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.4 169/313] fs: avoid empty option when generating legacy mount string
Date:   Tue, 25 Jul 2023 12:45:22 +0200
Message-ID: <20230725104528.267626898@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
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
@@ -598,7 +598,8 @@ static int legacy_parse_param(struct fs_
 			return -ENOMEM;
 	}
 
-	ctx->legacy_data[size++] = ',';
+	if (size)
+		ctx->legacy_data[size++] = ',';
 	len = strlen(param->key);
 	memcpy(ctx->legacy_data + size, param->key, len);
 	size += len;


