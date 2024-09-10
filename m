Return-Path: <stable+bounces-74659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 331F0973083
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657FC1C24020
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF2B19004D;
	Tue, 10 Sep 2024 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TAbOZAXO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FA418FDBD;
	Tue, 10 Sep 2024 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962448; cv=none; b=RgW5sj2HAlGJS//iFkFxvfUV8C/77pN9wx1sxUntVHUs79GLiYqXBMw6hdLOjAsDetplF7unZmyuCH3o4/HY62pvO3QyDITYLkAQfuOZV4iUwDJNboYNw6xn+nYM1/3lfUNtwh5KeMKz+Wz9LbGNIRiLavHgh1uOi4TRpvJ+iY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962448; c=relaxed/simple;
	bh=GXvmt9agX6RCDXZfPXDFRnYqMOcCVfxiyyVp/JAskH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXp/r+mqnTZgQFffYxZLxEDIcmOO8npPHr7iUVH7fGyRQpcdPi7R5eoWnK21a3/AhOp7dEjQ7R4AXLPCslHVGkbfzcRPoAjI4JDwHMegU26lSpSPZTXlPVRFkRcvj5kiuN2oOH9ATVqiVVzQSuw1OyPGilruTP5VobbrnqvJZ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TAbOZAXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF9CC4CEC3;
	Tue, 10 Sep 2024 10:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962448;
	bh=GXvmt9agX6RCDXZfPXDFRnYqMOcCVfxiyyVp/JAskH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAbOZAXOwlO34zi78DiL4/sBZcrHuO2pTK2GOA3D438KVAwV1uqpHXIHY/WXpvB44
	 zAL0BEnShizcEJPek4XcdVnFFtU5ZQpgSWMR+Iyuap+Us/h6zmCS+xTyeFaPvvaAWM
	 iN3wspJH33MIH/yPFR3WJYXMLLfE1sb/Y1sF5JuE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 5.4 038/121] clk: qcom: clk-alpha-pll: Fix the trion pll postdiv set rate API
Date: Tue, 10 Sep 2024 11:31:53 +0200
Message-ID: <20240910092547.532507267@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092545.737864202@linuxfoundation.org>
References: <20240910092545.737864202@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>

commit 4ad1ed6ef27cab94888bb3c740c14042d5c0dff2 upstream.

Correct the pll postdiv shift used in clk_trion_pll_postdiv_set_rate
API. The shift value is not same for different types of plls and
should be taken from the pll's .post_div_shift member.

Fixes: 548a909597d5 ("clk: qcom: clk-alpha-pll: Add support for Trion PLLs")
Cc: stable@vger.kernel.org
Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240731062916.2680823-3-quic_skakitap@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/qcom/clk-alpha-pll.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -1257,8 +1257,8 @@ clk_trion_pll_postdiv_set_rate(struct cl
 	}
 
 	return regmap_update_bits(regmap, PLL_USER_CTL(pll),
-				  PLL_POST_DIV_MASK(pll) << PLL_POST_DIV_SHIFT,
-				  val << PLL_POST_DIV_SHIFT);
+				  PLL_POST_DIV_MASK(pll) << pll->post_div_shift,
+				  val << pll->post_div_shift);
 }
 
 const struct clk_ops clk_trion_pll_postdiv_ops = {



