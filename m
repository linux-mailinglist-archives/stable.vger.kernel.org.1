Return-Path: <stable+bounces-187449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD82BEA5CF
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B90B25821DE
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D65330B2E;
	Fri, 17 Oct 2025 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f1rlUtui"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D320C330B04;
	Fri, 17 Oct 2025 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716103; cv=none; b=UT03/ozL98blBOYZc9kemIGcU8djsFIB9bZx3au52fKvd3i+nbtIpAPIY3XIXOUryAcg3NbS4aHr3IdNq2w+aI0j/RBAXeBXIY8eMOMwaYcgsuG/1T+y7tPXjfHKDkUftO2V2YOZxs6C98YZhEpKi+RVLeFwNoBDhmypMm+XaUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716103; c=relaxed/simple;
	bh=2iyent4SlktjJZXMIxTrdOqeegLGaPSAw56YpWwEvt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlfpxuXw2juYbKAdoEf60JUaYig9yIKe5E7JnhuaSpkEIbROrFGEIjZlHlRLpIEgCHP8FONajW/hF0Y+BWlrOzGWTVWx6JQrz4LzHzJP7cHwasVTXvsravEv+TMjRGirC2ckftCCdXMjBUWZtAjxKizmX2FnJQzcyqHgIBegJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f1rlUtui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508A2C4CEE7;
	Fri, 17 Oct 2025 15:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716103;
	bh=2iyent4SlktjJZXMIxTrdOqeegLGaPSAw56YpWwEvt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1rlUtui313mlggw+KsyD/Asnt2Yw6ymejMFi9KI3uU3XjPx7XtOkQFr+ioEXS8k7
	 iX8cwGmKhl3FIM+NWhyaGlxbZLwB8axtjkQfPr80PHY7RKua7VOC9cfEyYHV41moep
	 QRhlcj83oCeXyxSr4QHbDoLMQD9CNAhu9jnHSOZs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Fei Shao <fshao@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 041/276] arm64: dts: mediatek: mt8516-pumpkin: Fix machine compatible
Date: Fri, 17 Oct 2025 16:52:14 +0200
Message-ID: <20251017145143.904485161@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit ffe6a5d1dd4d4d8af0779526cf4e40522647b25f ]

This devicetree contained only the SoC compatible but lacked the
machine specific one: add a "mediatek,mt8516-pumpkin" compatible
to the list to fix dtbs_check warnings.

Fixes: 9983822c8cf9 ("arm64: dts: mediatek: add pumpkin board dts")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Fei Shao <fshao@chromium.org>
Link: https://lore.kernel.org/r/20250724083914.61351-39-angelogioacchino.delregno@collabora.com
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
index cce642c538128..3d3db33a64dc6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
@@ -11,7 +11,7 @@
 
 / {
 	model = "Pumpkin MT8516";
-	compatible = "mediatek,mt8516";
+	compatible = "mediatek,mt8516-pumpkin", "mediatek,mt8516";
 
 	memory@40000000 {
 		device_type = "memory";
-- 
2.51.0




