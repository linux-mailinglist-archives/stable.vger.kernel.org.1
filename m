Return-Path: <stable+bounces-5786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B57F80D6E9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1630A2821EB
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E82751C3B;
	Mon, 11 Dec 2023 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BMpoMfCI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240DCFBE0;
	Mon, 11 Dec 2023 18:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E073C433C8;
	Mon, 11 Dec 2023 18:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319660;
	bh=zjIQWzd1ZIHQCgGY5opte3ZPShNG+zLUjv7oaXP26Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BMpoMfCIZv7Qv2z1VU6Z1Ru4tPq5bZWNAzKICA1X0URKOdVSygWem3HFps/BD3GEJ
	 bbx5xixco+OaMF1QrecPfV2CoHnhjeunSkuMOjeyrEq8Yn47fA7qSyPWCVCMgPPeTw
	 eSN112s7IkmuvGE30ZqpxzAe+QilAy1z4cVQ3mYE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 6.6 188/244] arm64: dts: mediatek: mt8186: Change gpu speedbin nvmem cell name
Date: Mon, 11 Dec 2023 19:21:21 +0100
Message-ID: <20231211182054.373950393@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

commit 59fa1e51ba54e1f513985a8177969b62973f7fd5 upstream.

MT8186's GPU speedbin value must be interpreted, or the value will not
be meaningful.
Use the correct "gpu-speedbin" nvmem cell name for the GPU speedbin to
allow triggering the cell info fixup handler, hence feeding the right
speedbin number to the users.

Cc: stable@vger.kernel.org
Fixes: 263d2fd02afc ("arm64: dts: mediatek: mt8186: Add GPU speed bin NVMEM cells")
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Link: https://lore.kernel.org/r/20231005151150.355536-1-angelogioacchino.delregno@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1668,7 +1668,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			gpu_speedbin: gpu-speed-bin@59c {
+			gpu_speedbin: gpu-speedbin@59c {
 				reg = <0x59c 0x4>;
 				bits = <0 3>;
 			};



