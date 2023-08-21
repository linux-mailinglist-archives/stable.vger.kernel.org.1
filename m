Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A22378330F
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjHUT7p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjHUT7o (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:59:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C6012C
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:59:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E621664728
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BC8C433C8;
        Mon, 21 Aug 2023 19:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647981;
        bh=L+mTf/1+qJx1s5szTWHPFSNXECVQcE1MRLfqz8by02M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rZ6D7YITNNG6BJj5+rCcYMuiQGp7kQ7BUlzpoNxyeowBm/caF1/HfiX/H7TWaSMqM
         lSmCABlzuTaAKHyZfqeyiTJR4dAJHIICv5jqxB2hkUXWp1HCcsspDbPEquxmupGx2I
         Xb0V7wBXX3jChBKHkXaB2QKlaUAeh4NGTSiSY0nU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 013/234] ASoC: cs35l56: Move DSP part string generation so that it is done only once
Date:   Mon, 21 Aug 2023 21:39:36 +0200
Message-ID: <20230821194129.336957572@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

[ Upstream commit 608f1b0dbddec6b2fd766c10bcce2b651995e936 ]

Each time we go through dsp_work() it does a devm_kasprintf() to
allocate memory to hold the part name string. It's not strictly a memory
leak because devm will free it all if the driver is removed. But we keep
allocating more and more memory to hold the same string.

Move the allocation so that it is performed after the version and
secured state information is gathered and handle allocation errors.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://lore.kernel.org/r/Message-Id: <20230518150250.1121006-2-rf@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l56.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index e0d2b9bb23262..f3fee448d759e 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -834,12 +834,6 @@ static void cs35l56_dsp_work(struct work_struct *work)
 	if (!cs35l56->init_done)
 		return;
 
-	cs35l56->dsp.part = devm_kasprintf(cs35l56->dev, GFP_KERNEL, "cs35l56%s-%02x",
-					   cs35l56->secured ? "s" : "", cs35l56->rev);
-
-	if (!cs35l56->dsp.part)
-		return;
-
 	pm_runtime_get_sync(cs35l56->dev);
 
 	/*
@@ -1505,6 +1499,12 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	dev_info(cs35l56->dev, "Cirrus Logic CS35L56%s Rev %02X OTP%d\n",
 		 cs35l56->secured ? "s" : "", cs35l56->rev, otpid);
 
+	/* Populate the DSP information with the revision and security state */
+	cs35l56->dsp.part = devm_kasprintf(cs35l56->dev, GFP_KERNEL, "cs35l56%s-%02x",
+					   cs35l56->secured ? "s" : "", cs35l56->rev);
+	if (!cs35l56->dsp.part)
+		return -ENOMEM;
+
 	/* Wake source and *_BLOCKED interrupts default to unmasked, so mask them */
 	regmap_write(cs35l56->regmap, CS35L56_IRQ1_MASK_20, 0xffffffff);
 	regmap_update_bits(cs35l56->regmap, CS35L56_IRQ1_MASK_1,
-- 
2.40.1



