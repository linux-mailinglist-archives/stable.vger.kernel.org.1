Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9300A76116E
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjGYKv2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjGYKux (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:50:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0513D26AF
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:50:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50CA66166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F764C433C8;
        Tue, 25 Jul 2023 10:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282235;
        bh=XL9Urdfo/A7cpSPaDhGWGuuan9jOf8n4fE6u+KEAefo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AjYX4OI+kNEsAJsRF/I5ZDu4mVYnV0s4ULKajqFBFO/qxaqHbcOjS/EzfHEEu5p4P
         Zizwhhd1WAHqyBirp7rsmtYaq3gLgHX8mwah4v7zsP3XYYT5QIXrkaNUDNp0qFVzug
         yJrNfgDNGZgjay9oUpptHJ4xUSN/U/9WZocTxhh8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Matus Gajdos <matuszpd@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.4 056/227] ASoC: fsl_sai: Disable bit clock with transmitter
Date:   Tue, 25 Jul 2023 12:43:43 +0200
Message-ID: <20230725104517.089302040@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
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

From: Matus Gajdos <matuszpd@gmail.com>

commit 269f399dc19f0e5c51711c3ba3bd06e0ef6ef403 upstream.

Otherwise bit clock remains running writing invalid data to the DAC.

Signed-off-by: Matus Gajdos <matuszpd@gmail.com>
Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230712124934.32232-1-matuszpd@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/fsl/fsl_sai.c |    2 +-
 sound/soc/fsl/fsl_sai.h |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -719,7 +719,7 @@ static void fsl_sai_config_disable(struc
 	u32 xcsr, count = 100;
 
 	regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
-			   FSL_SAI_CSR_TERE, 0);
+			   FSL_SAI_CSR_TERE | FSL_SAI_CSR_BCE, 0);
 
 	/* TERE will remain set till the end of current frame */
 	do {
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -91,6 +91,7 @@
 /* SAI Transmit/Receive Control Register */
 #define FSL_SAI_CSR_TERE	BIT(31)
 #define FSL_SAI_CSR_SE		BIT(30)
+#define FSL_SAI_CSR_BCE		BIT(28)
 #define FSL_SAI_CSR_FR		BIT(25)
 #define FSL_SAI_CSR_SR		BIT(24)
 #define FSL_SAI_CSR_xF_SHIFT	16


