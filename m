Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8536FA4F5
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjEHKEz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbjEHKEy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:04:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D773014C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:04:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D6B362310
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E70C433D2;
        Mon,  8 May 2023 10:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540292;
        bh=r+PfYF5hzajNL+Cb+Zs/8DoBMoPG8fQ6KkReIIijeLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AkNJzNx7J1210mXfF79FIWlh9UXch+dJsBs2YoiYOG9m9zDaR+gqt20/9aRAYNE5d
         +v5QujZHFP4HlE3Z9JxklHtJxaliaKDnfVyDw7xR11LL+aq80tb6/Kszo7f8BciNqD
         nvA77U61mbb0SzpNKvL8td1MXJzgPYYE57Iya4Aw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 308/611] crypto: caam - Clear some memory in instantiate_rng
Date:   Mon,  8 May 2023 11:42:30 +0200
Message-Id: <20230508094432.443458948@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 9c19fb86a8cb2ee82a832c95e139f29ea05c4d08 ]

According to the comment at the end of the 'for' loop just a few lines
below, it looks needed to clear 'desc'.

So it should also be cleared for the first iteration.

Move the memset() to the beginning of the loop to be safe.

Fixes: 281922a1d4f5 ("crypto: caam - add support for SEC v5.x RNG4")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/caam/ctrl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 32253a064d0fe..3b79e0d83d40a 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -284,6 +284,10 @@ static int instantiate_rng(struct device *ctrldev, int state_handle_mask,
 		const u32 rdsta_if = RDSTA_IF0 << sh_idx;
 		const u32 rdsta_pr = RDSTA_PR0 << sh_idx;
 		const u32 rdsta_mask = rdsta_if | rdsta_pr;
+
+		/* Clear the contents before using the descriptor */
+		memset(desc, 0x00, CAAM_CMD_SZ * 7);
+
 		/*
 		 * If the corresponding bit is set, this state handle
 		 * was initialized by somebody else, so it's left alone.
@@ -327,8 +331,6 @@ static int instantiate_rng(struct device *ctrldev, int state_handle_mask,
 		}
 
 		dev_info(ctrldev, "Instantiated RNG4 SH%d\n", sh_idx);
-		/* Clear the contents before recreating the descriptor */
-		memset(desc, 0x00, CAAM_CMD_SZ * 7);
 	}
 
 	kfree(desc);
-- 
2.39.2



