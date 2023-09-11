Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACCF79ADB4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351480AbjIKVnO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242381AbjIKP33 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:29:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4C2F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:29:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325BBC433C9;
        Mon, 11 Sep 2023 15:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694446164;
        bh=B3qWL0oyHG+gHGmguR+gJtrTD60yoX6w06f7hWvGft0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nOg/dHF+iCYakiV6AMEdS2xlg/iZ+uWucfl/B1L5IQr3hYJ/mYBct30Ve+Ym4NweH
         VgTQF4i0FxJmaXmyDX8BYOGu5+/FOOMZmP4B6fc5ldJEAmybuhRt+sU4Shn2Z41g9O
         NeU5XLTbuhEWCc9qDgGKFBPMC6cWWv+nqMVHJcqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Thomas Bourgoin <thomas.bourgoin@foss.st.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.1 578/600] crypto: stm32 - fix loop iterating through scatterlist for DMA
Date:   Mon, 11 Sep 2023 15:50:11 +0200
Message-ID: <20230911134650.680639598@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>

commit d9c83f71eeceed2cb54bb78be84f2d4055fd9a1f upstream.

We were reading the length of the scatterlist sg after copying value of
tsg inside.
So we are using the size of the previous scatterlist and for the first
one we are using an unitialised value.
Fix this by copying tsg in sg[0] before reading the size.

Fixes : 8a1012d3f2ab ("crypto: stm32 - Support for STM32 HASH module")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/stm32/stm32-hash.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -565,9 +565,9 @@ static int stm32_hash_dma_send(struct st
 	}
 
 	for_each_sg(rctx->sg, tsg, rctx->nents, i) {
+		sg[0] = *tsg;
 		len = sg->length;
 
-		sg[0] = *tsg;
 		if (sg_is_last(sg)) {
 			if (hdev->dma_mode == 1) {
 				len = (ALIGN(sg->length, 16) - 16);


