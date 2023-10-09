Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DC27BDD38
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376714AbjJINIf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376672AbjJINIf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:08:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B6799
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:08:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E647CC433C7;
        Mon,  9 Oct 2023 13:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696856913;
        bh=smE67Mfi6IVQGvl+SuyNhMeuNAl8wnJM7KY3H9BZrao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KLW4dBISare5P4u4zbjXuk/HtUqp8xtllnbuUcrIu2w/ppLVOZHTpF1XEkSsn29c5
         yPiQNjInpZteUAxESrfGqXQhGEZUD6bF7ooxDOk5Uq8Ue7kOBcDiBE8+fKcf/Ce0R+
         poV1PDM8OfPXegSFcqfOpH1aK9OxpZ5P9hY0n5z8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sameer Pujar <spujar@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 006/163] ASoC: soc-utils: Export snd_soc_dai_is_dummy() symbol
Date:   Mon,  9 Oct 2023 14:59:30 +0200
Message-ID: <20231009130124.198299801@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sameer Pujar <spujar@nvidia.com>

[ Upstream commit f101583fa9f8c3f372d4feb61d67da0ccbf4d9a5 ]

Export symbol snd_soc_dai_is_dummy() for usage outside core driver
modules. This is required by Tegra ASoC machine driver.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Link: https://lore.kernel.org/r/1694098945-32760-2-git-send-email-spujar@nvidia.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 11607c5f5d5a8..9c746e4edef71 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -217,6 +217,7 @@ int snd_soc_dai_is_dummy(struct snd_soc_dai *dai)
 		return 1;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_soc_dai_is_dummy);
 
 int snd_soc_component_is_dummy(struct snd_soc_component *component)
 {
-- 
2.40.1



