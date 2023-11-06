Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD377E22E0
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjKFNGZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjKFNGY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:06:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849E8A9
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:06:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65C2C433C7;
        Mon,  6 Nov 2023 13:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699275981;
        bh=OFjUQ7tPlqOG8B5g+dImc3pXmBCFSlfa+h/pcdDV84E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2rsdOhHIgckZBK1ZBNLTotW/qZoYJ9A1eAWTxR0rETz/6UN/26aasNJUrnrqvTHyX
         rkIERDYqfZXHPCF+p4IE0/z/FNok4WSCjzhnJ42rB9ed6fEDTPDqE1JQ5M8L6SZJ7A
         D/8cmds5MVTiFc1rsh9xQ32hdMNevHd/KGwp4+h0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 29/48] ASoC: simple-card: fixup asoc_simple_probe() error handling
Date:   Mon,  6 Nov 2023 14:03:20 +0100
Message-ID: <20231106130258.860021281@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130257.862199836@linuxfoundation.org>
References: <20231106130257.862199836@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 41bae58df411f9accf01ea660730649b2fab1dab ]

asoc_simple_probe() is used for both "DT probe" (A) and "platform probe"
(B). It uses "goto err" when error case, but it is not needed for
"platform probe" case (B). Thus it is using "return" directly there.

	static int asoc_simple_probe(...)
	{
 ^		if (...) {
 |			...
(A)			if (ret < 0)
 |				goto err;
 v		} else {
 ^			...
 |			if (ret < 0)
(B)				return -Exxx;
 v		}

		...
 ^		if (ret < 0)
(C)			goto err;
 v		...

	err:
(D)		simple_util_clean_reference(card);

		return ret;
	}

Both case are using (C) part, and it calls (D) when err case.
But (D) will do nothing for (B) case.
Because of these behavior, current code itself is not wrong,
but is confusable, and more, static analyzing tool will warning on
(B) part (should use goto err).

To avoid static analyzing tool warning, this patch uses "goto err"
on (B) part.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87o7hy7mlh.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/generic/simple-card.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 6959a74a6f491..c5db2d9d44edd 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -441,10 +441,12 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	} else {
 		struct asoc_simple_card_info *cinfo;
 
+		ret = -EINVAL;
+
 		cinfo = dev->platform_data;
 		if (!cinfo) {
 			dev_err(dev, "no info for asoc-simple-card\n");
-			return -EINVAL;
+			goto err;
 		}
 
 		if (!cinfo->name ||
@@ -453,7 +455,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 		    !cinfo->platform ||
 		    !cinfo->cpu_dai.name) {
 			dev_err(dev, "insufficient asoc_simple_card_info settings\n");
-			return -EINVAL;
+			goto err;
 		}
 
 		card->name		= (cinfo->card) ? cinfo->card : cinfo->name;
-- 
2.42.0



