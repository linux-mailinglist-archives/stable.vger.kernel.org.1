Return-Path: <stable+bounces-88961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD909B283D
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86E4B20E82
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A407824A3;
	Mon, 28 Oct 2024 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HBAzuo58"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D0F2AF07;
	Mon, 28 Oct 2024 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098513; cv=none; b=sFLuXXtJetxDFAACgTn4Ic+6Oi5RqW3Sg+ydssLod9yDXAuCnFMOugjXCl+dc/NezOzK4DULllkJWbgKap9akU44oiCf+Y25hs7GT50ZTu69Cl50Iv7s5NMxPM0ED9t31vHduZa0nOPN40Qp3qchHc9enrb/32XBwdzmM9u54YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098513; c=relaxed/simple;
	bh=ypXm9Ud+ZwbKuI4aKS5Dw50Jw71+SRm2ZiuXfOmahjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwcSUy9PmbhyAr3xIHs3k/ctIEQn8b72p6Ifkq+hfM5doagX8prFC1I0jtD4/GISv2Bf6gZZWU2soGeZURcnLDi4qg5zcw0HR+l+gv7bFp477NUt8j4s3PXTK2of0LsLLpclsqZ87R7z4M1J4TYO62M0FSbCudj/gDVFFtzE9jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HBAzuo58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C6BC4CEC3;
	Mon, 28 Oct 2024 06:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730098513;
	bh=ypXm9Ud+ZwbKuI4aKS5Dw50Jw71+SRm2ZiuXfOmahjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HBAzuo58OZGVre+LxaA0cJbILU7sIZcAfWbTekGbCQJoExh/RlzjJy1+5H+bIGSA3
	 I0LOnoLIQLdDonmyqyElrMED8QE7prQK+ZE7iLbaVitGfPTPcTJJB6dmZM1M8ntUgN
	 Zwes4Rm8lPHIY93NQ6A4TckbK+OiWKsuEjMnkh/0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.11 261/261] ASoC: qcom: Select missing common Soundwire module code on SDM845
Date: Mon, 28 Oct 2024 07:26:43 +0100
Message-ID: <20241028062318.622277699@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>
References: <20241028062312.001273460@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit b930d8647869802a0d430aae6b1b05c3acb24a41 upstream.

SDM845 sound card driver uses qcom_snd_sdw_startup() from the common
Soundwire module, so select it to fix build failures:

  ERROR: modpost: "qcom_snd_sdw_startup" [sound/soc/qcom/snd-soc-sdm845.ko] undefined!

Fixes: d0e806b0cc62 ("ASoC: qcom: sdm845: add missing soundwire runtime stream alloc")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://patch.msgid.link/20241012100957.129103-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/qcom/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -157,6 +157,7 @@ config SND_SOC_SDM845
 	depends on COMMON_CLK
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
+	select SND_SOC_QCOM_SDW
 	select SND_SOC_RT5663
 	select SND_SOC_MAX98927
 	imply SND_SOC_CROS_EC_CODEC



