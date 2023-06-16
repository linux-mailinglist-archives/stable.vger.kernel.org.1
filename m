Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7535733315
	for <lists+stable@lfdr.de>; Fri, 16 Jun 2023 16:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjFPOHo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 16 Jun 2023 10:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjFPOHn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Jun 2023 10:07:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35664270B
        for <stable@vger.kernel.org>; Fri, 16 Jun 2023 07:07:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ADC121F899;
        Fri, 16 Jun 2023 14:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686924461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dmuBd6wfu7xPrmCdhUYbYsyqzue8SYpjsKk5yr/LlrU=;
        b=UFBkavSSIUO0QX52+bC3F5Hj1U8z2HKjUglAKZXCyqzpakAQbxNCc1QsIlC7STxxeHnrRO
        k5zr44z66v5bt3WUO79x3zChdemXYt7AA7Q6SWw/O5ER8euekm6b8Jf90zhBEWnZTR8RDV
        Wa2a2J09IqZGHkETp3MIE/qjHxqmENM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686924461;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dmuBd6wfu7xPrmCdhUYbYsyqzue8SYpjsKk5yr/LlrU=;
        b=A8Jrx1yi1h1mMdoNLveY0JtXRr9Yqkgxg0qTBN68gy6IFVjgbI1cMkQ51vgfMdn6dAgP3H
        K1ORVKXrVXjq6jBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 815CE1391E;
        Fri, 16 Jun 2023 14:07:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yBh0Hq1sjGTfWgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 16 Jun 2023 14:07:41 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     airlied@redhat.com, jfalempe@redhat.com, daniel@ffwll.ch,
        jammy_huang@aspeedtech.com
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: [PATCH 01/14] drm/ast: Fix DRAM init on AST2200
Date:   Fri, 16 Jun 2023 15:52:23 +0200
Message-ID: <20230616140739.32042-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230616140739.32042-1-tzimmermann@suse.de>
References: <20230616140739.32042-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Fix the test for the AST2200 in the DRAM initialization. The value
in ast->chip has to be compared against an enum constant instead of
a numerical value.

This bug got introduced when the driver was first imported into the
kernel.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 312fec1405dd ("drm: Initial KMS driver for AST (ASpeed Technologies) 2000 series (v2)")
Cc: Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v3.5+
---
 drivers/gpu/drm/ast/ast_post.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
index a005aec18a020..0262aaafdb1c5 100644
--- a/drivers/gpu/drm/ast/ast_post.c
+++ b/drivers/gpu/drm/ast/ast_post.c
@@ -291,7 +291,7 @@ static void ast_init_dram_reg(struct drm_device *dev)
 				;
 			} while (ast_read32(ast, 0x10100) != 0xa8);
 		} else {/* AST2100/1100 */
-			if (ast->chip == AST2100 || ast->chip == 2200)
+			if (ast->chip == AST2100 || ast->chip == AST2200)
 				dram_reg_info = ast2100_dram_table_data;
 			else
 				dram_reg_info = ast1100_dram_table_data;
-- 
2.41.0

