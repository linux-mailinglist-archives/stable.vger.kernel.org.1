Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2585F79B345
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344217AbjIKVNe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241016AbjIKO7u (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:59:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23261B9
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:59:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015AFC433C8;
        Mon, 11 Sep 2023 14:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444386;
        bh=Rd2pgj+FEY+vqvXa8mUu1oKZMHjDYj18GDkrmnA+uT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cTVFz6JAKevfVrrHIdwYVpPCz2D+alCfEQ1MIFwqCkA0AoLHZSFLlcnZ2XfMrLu3N
         k3nnuKxlzzxTjNuSTXESpZKKMx61nZ0qbKue4hWiPRrVyM6oIBvN6B5Up1UpEwvaj3
         jRWYS1aGCILim/0R2d8GJ+JMYDULlGS2Gi7Pzq5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>,
        Thomas Bourgoin <thomas.bourgoin@foss.st.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.4 712/737] crypto: stm32 - fix MDMAT condition
Date:   Mon, 11 Sep 2023 15:49:31 +0200
Message-ID: <20230911134710.409981152@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>

commit a4adfbc2544933ac12e7fbd50708290265546dbc upstream.

If IP has MDMAT support, set or reset the bit MDMAT in Control Register.

Fixes: b56403a25af7 ("crypto: stm32/hash - Support Ux500 hash")
Cc: stable@vger.kernel.org
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/stm32/stm32-hash.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -492,7 +492,7 @@ static int stm32_hash_xmit_dma(struct st
 
 	reg = stm32_hash_read(hdev, HASH_CR);
 
-	if (!hdev->pdata->has_mdmat) {
+	if (hdev->pdata->has_mdmat) {
 		if (mdma)
 			reg |= HASH_CR_MDMAT;
 		else


