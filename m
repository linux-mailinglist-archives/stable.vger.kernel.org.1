Return-Path: <stable+bounces-156449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAD8AE4F9F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3167A3BE137
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51031221FDC;
	Mon, 23 Jun 2025 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XvpRRGoj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBFA1EDA0F;
	Mon, 23 Jun 2025 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713439; cv=none; b=NnE12VimLkCUkyDYxNFzYoSy2QFhd9QFOrjP68JNreb/m+GWPIq64eHQoWofkHeDDJo+M1tMBsvbx7qABuT2gEJVv+QrFykJuSatc6i49aR/yAWN3DfRUuwBIfzvq4JF3nCRJEte8FbyYCsZcCdeHsax5Ggz08CgnEFR9tEQ418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713439; c=relaxed/simple;
	bh=fO2qcASyEXtm0u3ir/qxoUPZ6zsl658aWwz8gPWG6fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=od54/ulcSLQdEGSJiC+T3wtWLtIXEGFYgzXlEe+gE4InF3BS6cZ+qj9aGxzMIs+IjfJv+GO6SuZeOgE9N0lkbo0ddVA2b9CZM/Q3ZVJ2mLr6cZKwNiaUooWwgpemYOLcOj9aSw+N2QNF+uMpJ87mmJJYh4BymDOVlJHk0KrEIw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XvpRRGoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97755C4CEEA;
	Mon, 23 Jun 2025 21:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713438;
	bh=fO2qcASyEXtm0u3ir/qxoUPZ6zsl658aWwz8gPWG6fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XvpRRGojm779VBC+je8ofvzLU591JdQMtOhpeqktPFP8k7noM7q2Re6LThX0JOxqw
	 PHh/qSH7nccEUpIKYHbilbxnkaY+Z40E26w2OWizL3491kxRe2sLBt5U+wUqgjpjnZ
	 RKUM983QKmGPTzYyadfBdysr3cHBMp+s3d76Qeqo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"=?UTF-8?q?N=C3=ADcolas=20F . =20R . =20A . =20Prado?=" <nfraprado@collabora.com>,
	Vignesh Raman <vignesh.raman@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 123/508] arm64: defconfig: mediatek: enable PHY drivers
Date: Mon, 23 Jun 2025 15:02:48 +0200
Message-ID: <20250623130648.322277931@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vignesh Raman <vignesh.raman@collabora.com>

[ Upstream commit f52cd248d844f9451858992f924988ac413fdc7e ]

The mediatek display driver fails to probe on mt8173-elm-hana and
mt8183-kukui-jacuzzi-juniper-sku16 in v6.14-rc4 due to missing PHY
configurations.

Commit 924d66011f24 ("drm/mediatek: stop selecting foreign drivers")
stopped selecting the MediaTek PHY drivers, requiring them to be
explicitly enabled in defconfig.

Enable the following PHY drivers for MediaTek platforms:
CONFIG_PHY_MTK_HDMI=m for HDMI display
CONFIG_PHY_MTK_MIPI_DSI=m for DSI display
CONFIG_PHY_MTK_DP=m for DP display

Fixes: 924d66011f24 ("drm/mediatek: stop selecting foreign drivers")
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
Link: https://lore.kernel.org/r/20250512131933.1247830-1-vignesh.raman@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 623e9f308f38a..4543b292b50b4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1230,6 +1230,9 @@ CONFIG_PHY_HISTB_COMBPHY=y
 CONFIG_PHY_HISI_INNO_USB2=y
 CONFIG_PHY_MVEBU_CP110_COMPHY=y
 CONFIG_PHY_MTK_TPHY=y
+CONFIG_PHY_MTK_HDMI=m
+CONFIG_PHY_MTK_MIPI_DSI=m
+CONFIG_PHY_MTK_DP=m
 CONFIG_PHY_QCOM_EDP=m
 CONFIG_PHY_QCOM_PCIE2=m
 CONFIG_PHY_QCOM_QMP=m
-- 
2.39.5




