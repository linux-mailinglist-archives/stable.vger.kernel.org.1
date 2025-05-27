Return-Path: <stable+bounces-146743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B71AC545C
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 18:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7A11BA4AA8
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA2027FB37;
	Tue, 27 May 2025 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eVSdSS5u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD827A900;
	Tue, 27 May 2025 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365172; cv=none; b=eKb2990QRiMutHMmn7Q56Acfq41eWqm3M5R1i/Q1SQn/MXb6faL5Ny5SeHQLVmE+6e3DRcj498KKPqpnTrnTeziuKMNh84msz1WuFYldi5GNYsSem7XELlP+L7b+1mfjXdtOkwG2rPt+FGmSjto7hZWtoGpLyAtha2wPsM6V2j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365172; c=relaxed/simple;
	bh=/viEIa8QjSnjOYUrfYe8gdEv6j9bcYoiG++6On4HssE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPCVy6LicLmeyrpjnl/gtR8LMygvhhN9BqRsnotX+HJ4AYTd3FzqgtUtaa1Xx2rLM5blgbH4CjBxCXw3mgJICxjlif5ytjWdQbuBOv+yEhTUL3L/cN1aKViG6ygmEdACoYFqJHbtV3TKhQ2t5SbF/EGeUU0NXOjqc8wZHFSVQu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eVSdSS5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3545C4CEE9;
	Tue, 27 May 2025 16:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748365171;
	bh=/viEIa8QjSnjOYUrfYe8gdEv6j9bcYoiG++6On4HssE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eVSdSS5uJFPD3PSL7QdGWBrQN6UEqJrxrBAJRuk/tnBRAIWVmUylRSJ5okfg8UfRL
	 ukjs0oEb70a62pTuMDyeit6ReVjxwxk7j21o9iC+ztmlnO69yMoRfgcyM89qWWOLz6
	 HUCLH/n1snhjme2Pezknh/njfbmNc8kGXLl6uV/E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"=?UTF-8?q?N=C3=ADcolas=20F . =20R . =20A . =20Prado?=" <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 290/626] ASoC: mediatek: mt8188: Treat DMIC_GAINx_CUR as non-volatile
Date: Tue, 27 May 2025 18:23:03 +0200
Message-ID: <20250527162456.815587569@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit 7d87bde21c73731ddaf15e572020f80999c38ee3 ]

The DMIC_GAINx_CUR registers contain the current (as in present) gain of
each DMIC. During capture, this gain will ramp up until a target value
is reached, and therefore the register is volatile since it is updated
automatically by hardware.

However, after capture the register's value returns to the value that
was written to it. So reading these registers returns the current gain,
and writing configures the initial gain for every capture.

>From an audio configuration perspective, reading the instantaneous gain
is not really useful. Instead, reading back the initial gain that was
configured is the desired behavior. For that reason, consider the
DMIC_GAINx_CUR registers as non-volatile, so the regmap's cache can be
used to retrieve the values, rather than requiring pm runtime resuming
the device.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patch.msgid.link/20250225-genio700-dmic-v2-3-3076f5b50ef7@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
index 73e5c63aeec87..d36520c6272dd 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
@@ -2855,10 +2855,6 @@ static bool mt8188_is_volatile_reg(struct device *dev, unsigned int reg)
 	case AFE_DMIC3_SRC_DEBUG_MON0:
 	case AFE_DMIC3_UL_SRC_MON0:
 	case AFE_DMIC3_UL_SRC_MON1:
-	case DMIC_GAIN1_CUR:
-	case DMIC_GAIN2_CUR:
-	case DMIC_GAIN3_CUR:
-	case DMIC_GAIN4_CUR:
 	case ETDM_IN1_MONITOR:
 	case ETDM_IN2_MONITOR:
 	case ETDM_OUT1_MONITOR:
-- 
2.39.5




