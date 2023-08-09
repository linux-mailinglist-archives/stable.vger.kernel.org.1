Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18306775989
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjHILBZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjHILBY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:01:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5C51724
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:01:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2F4B62496
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0BDC433C7;
        Wed,  9 Aug 2023 11:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578883;
        bh=J8Etr6OZ8uVTd0lbk93PmgOhB8ZasD1aff4i4QOaYh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qYtA+DI17p3GTn6aY9P4Ed3lU2EloinRWOO0vOeKgNgW5A/Vrbu/yGN1pX9k3UB9X
         cBFt0f+Y+phRnXOUC4TwixYw0ue3GNlq8MS4bTwOtZeuUhqxKDFfBiwbC+sN8QRsiZ
         1Jn5VlSsKHCJM4PSUQZ8Rk3qk6HWTgcn0Xuu+7VI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 83/92] mtd: rawnand: fsl_upm: Fix an off-by one test in fun_exec_op()
Date:   Wed,  9 Aug 2023 12:41:59 +0200
Message-ID: <20230809103636.408576920@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit c6abce60338aa2080973cd95be0aedad528bb41f ]

'op-cs' is copied in 'fun->mchip_number' which is used to access the
'mchip_offsets' and the 'rnb_gpio' arrays.
These arrays have NAND_MAX_CHIPS elements, so the index must be below this
limit.

Fix the sanity check in order to avoid the NAND_MAX_CHIPS value. This
would lead to out-of-bound accesses.

Fixes: 54309d657767 ("mtd: rawnand: fsl_upm: Implement exec_op()")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/cd01cba1c7eda58bdabaae174c78c067325803d2.1689803636.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/fsl_upm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
index b3cc427100a22..636e65328bb32 100644
--- a/drivers/mtd/nand/raw/fsl_upm.c
+++ b/drivers/mtd/nand/raw/fsl_upm.c
@@ -135,7 +135,7 @@ static int fun_exec_op(struct nand_chip *chip, const struct nand_operation *op,
 	unsigned int i;
 	int ret;
 
-	if (op->cs > NAND_MAX_CHIPS)
+	if (op->cs >= NAND_MAX_CHIPS)
 		return -EINVAL;
 
 	if (check_only)
-- 
2.40.1



