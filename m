Return-Path: <stable+bounces-96643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5074B9E20EB
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF30316904A
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82911EF0BC;
	Tue,  3 Dec 2024 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n/H7rmWN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871891F7065;
	Tue,  3 Dec 2024 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238175; cv=none; b=cYCJy6Hg4OOn5nwYe+bhUOKoQGLWlxfvL3jW9ysXIKBfufC/Qvbk55gJtlfpt4+R8oHpSdkgNpIOeGaIurFlhsxbUv3W35B6bLflkBjF2AiC2BsJqLGw98iu09w5CH1eYsYNTfoTOlNJdrvcM9tnuJCcWDLaMuQMjwXjelvz18M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238175; c=relaxed/simple;
	bh=3hz7pIfjV8ng/ItavyUt07Lf5L9Wr38+mHDJaQixuS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkTfm9ZT3S8i3fjLBBxJ9Q4yUe0FQ+Mj3rhJKHIDa1mbpSF2uWSdJ1mv5xNnC9/BVAiTj8kck6wf8Q6NFieUqxlwISEdBPYMXQHW3vyZO663OkY9uk6aq6iRQKcE91eg/JhzaBmQKztRtG+l1PXAt4zuvMe24oz1crV1sXIMsZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n/H7rmWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C20BC4CED6;
	Tue,  3 Dec 2024 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238175;
	bh=3hz7pIfjV8ng/ItavyUt07Lf5L9Wr38+mHDJaQixuS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n/H7rmWN6fW0WJCILtDlA/T8y9onnutov1oT3FJLZqxmDGPTrJHEwJlozDp98sxjB
	 7EjAB9Ls620Q26AWEwCDtSaz3y+AJ74LNN8P0gv0gSZAzKQQL8vtNMHEl0CyNj+E96
	 oPIaEysew7DzoXc0Ma485rRGuilzfJy8pktvGbi0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fei Shao <fshao@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 170/817] arm64: dts: mediatek: mt8188: Fix USB3 PHY port default status
Date: Tue,  3 Dec 2024 15:35:42 +0100
Message-ID: <20241203144002.362130389@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

From: Fei Shao <fshao@chromium.org>

[ Upstream commit 6bb64877a41561bc78e0f4e9e04d524a0155d6aa ]

The T-PHY controller at 0x11e40000 controls two underlying USB2 and USB3
PHY ports. The USB3 port works normally just like the others, so there's
no point in disabling it separately. Otherwise, board DTs would have to
enable both the T-PHY controller and one of its sub-nodes in particular,
which is slightly redundant and confusing.

Remove the status line in the u3port1 node, so it's ready to be used
once the T-PHY controller is enabled.

Fixes: 9461e0caac9e ("arm64: dts: Add MediaTek MT8188 dts and evaluation board and Makefile")
Signed-off-by: Fei Shao <fshao@chromium.org>
Link: https://lore.kernel.org/r/20241021081311.543625-1-fshao@chromium.org
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 041a85e1d9b55..b6193d73f688c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1219,7 +1219,6 @@ u3port1: usb-phy@700 {
 					 <&clk26m>;
 				clock-names = "ref", "da_ref";
 				#phy-cells = <1>;
-				status = "disabled";
 			};
 		};
 
-- 
2.43.0




