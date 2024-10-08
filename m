Return-Path: <stable+bounces-82541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27826994D3C
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70AD1F23DE1
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721361C9B99;
	Tue,  8 Oct 2024 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HddNDoHj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F93A1DE2A5;
	Tue,  8 Oct 2024 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392610; cv=none; b=ZJYvzgLhQJ2Vu+ApjN98DBk44+3mDv0cJgkRiwMXGYg6WCHkLHFB+NM2cOg2NH7Wg7AiksywtUSH1P9D4tgrPcVkopug4n3zNRnsUAC/PEVwv7RU8oyedWLjvxBbM1oay6xKl49u+JVyeNI/h/P6604au0LDZdvkkZLV8Iu43Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392610; c=relaxed/simple;
	bh=DYr51f09AySUHTVIfIl4402lnhRLyzN7gSYm5HJ/LFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+g/3kKBplZseP0KJg/FHKS50uBq/zHzH58cL9qPlzztWwHyUxRUGeE4cOQc3vAponzRsnDb5qtsx+VMBsrtrx8P9TCYSbcbW/dYwqoVZiXnO8NNTBzqUgajFY0l9iRDd4nfhGdSP+hOe7s+8x3mr+LqDtfWF549c0W9oYVhodY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HddNDoHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F4EC4CEC7;
	Tue,  8 Oct 2024 13:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392610;
	bh=DYr51f09AySUHTVIfIl4402lnhRLyzN7gSYm5HJ/LFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HddNDoHjiufigUCTkJoaPEbsfa6HIY80+MWtKXRJPrhHwnfTCVk0VV5La6WL4tPu8
	 omHgPIaiCHf83HTCwpDvP97plwbLRHJ3pPcEdR5QEC067bdnImJ/mQERYmujQ6o+pe
	 /OYx3qXEfqLGO5Xd66tRTwK2SescHbgAlQq0v8AE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.11 466/558] clk: qcom: clk-alpha-pll: Fix CAL_L_VAL override for LUCID EVO PLL
Date: Tue,  8 Oct 2024 14:08:16 +0200
Message-ID: <20241008115720.588488488@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ajit Pandey <quic_ajipan@quicinc.com>

commit fff617979f97c773aaa9432c31cf62444b3bdbd4 upstream.

In LUCID EVO PLL CAL_L_VAL and L_VAL bitfields are part of single
PLL_L_VAL register. Update for L_VAL bitfield values in PLL_L_VAL
register using regmap_write() API in __alpha_pll_trion_set_rate
callback will override LUCID EVO PLL initial configuration related
to PLL_CAL_L_VAL bit fields in PLL_L_VAL register.

Observed random PLL lock failures during PLL enable due to such
override in PLL calibration value. Use regmap_update_bits() with
L_VAL bitfield mask instead of regmap_write() API to update only
PLL_L_VAL bitfields in __alpha_pll_trion_set_rate callback.

Fixes: 260e36606a03 ("clk: qcom: clk-alpha-pll: add Lucid EVO PLL configuration interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Link: https://lore.kernel.org/r/20240611133752.2192401-2-quic_ajipan@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/qcom/clk-alpha-pll.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -1713,7 +1713,7 @@ static int __alpha_pll_trion_set_rate(st
 	if (ret < 0)
 		return ret;
 
-	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+	regmap_update_bits(pll->clkr.regmap, PLL_L_VAL(pll), LUCID_EVO_PLL_L_VAL_MASK,  l);
 	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
 
 	/* Latch the PLL input */



