Return-Path: <stable+bounces-97415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFDD9E2937
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFBE0BC7998
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784441F4276;
	Tue,  3 Dec 2024 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ubGE1Vi4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0BA1FA166;
	Tue,  3 Dec 2024 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240433; cv=none; b=MIGR5u3Hn6Rtmfk15agMxoLhnSbCJIUtuHBD17FPTFkFC4wZ64/Tj+Pdlgax8Q+NphyBxSvJLVZSWkmgNG0vAAbMI0eoZ9E2v7HxHp88ZMrdld38Ue6LrYej4qKyfOE4kIBoI6SjeH5q+Sc6/gDYX8hL2EMRYQbJHsBb44FG6qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240433; c=relaxed/simple;
	bh=ecL81Gt32jai8EFXfJxCwmYRZkUOLviiIfZwnlQ/bNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFSLOvNUey1jj6BKPZ9zUwXsEV6eBO8KO3/9xixgunVNqYywcX51+xrwDO0euMVRmOVOu5kVfNPD5tLHcGXMisA2NxbzZeIto9pGhXFfITbOeMwIlBM4hkzo0cDUNNoaF1GK0ThQO5u6rbK0epROIIoBoLaMaHbSardqDGbSQzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ubGE1Vi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9333FC4CEDD;
	Tue,  3 Dec 2024 15:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240433;
	bh=ecL81Gt32jai8EFXfJxCwmYRZkUOLviiIfZwnlQ/bNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ubGE1Vi4NpPqM+ekpdqTvNWccfAUDknIgrFYdbwCUuJvPh1nBJ1WEBRt37Z5nGXfE
	 8IjiNl67JbR1tfPXrfsq1Rt478byHnH46fuyOQ0LFEOwAMaf4TH5TJEqfynvre7GO+
	 JNfFTLOVdxOisDqmvTUISWASsyKlypNOkBTtwuSg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 132/826] arm64: dts: mediatek: mt8173-elm-hana: Add vdd-supply to second source trackpad
Date: Tue,  3 Dec 2024 15:37:39 +0100
Message-ID: <20241203144748.889772461@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit f766fae08f6a2eaeb45d8d2c053724c91526835c ]

The Hana device has a second source option trackpad, but it is missing
its regulator supply. It only works because the regulator is marked as
always-on.

Add the regulator supply, but leave out the post-power-on delay. Instead,
document the post-power-on delay along with the reason for not adding
it in a comment.

Fixes: 689b937bedde ("arm64: dts: mediatek: add mt8173 elm and hana board")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20241018082001.1296963-1-wenst@chromium.org
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
index 8d1cbc92bce32..ae0379fd42a91 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
@@ -49,6 +49,14 @@ trackpad2: trackpad@2c {
 		interrupts-extended = <&pio 117 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x2c>;
 		hid-descr-addr = <0x0020>;
+		/*
+		 * The trackpad needs a post-power-on delay of 100ms,
+		 * but at time of writing, the power supply for it on
+		 * this board is always on. The delay is therefore not
+		 * added to avoid impacting the readiness of the
+		 * trackpad.
+		 */
+		vdd-supply = <&mt6397_vgp6_reg>;
 		wakeup-source;
 	};
 };
-- 
2.43.0




