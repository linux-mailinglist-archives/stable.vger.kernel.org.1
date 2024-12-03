Return-Path: <stable+bounces-97422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 278849E2481
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E87516D6D4
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2909B1FA82C;
	Tue,  3 Dec 2024 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QiNaaieY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE2E1FA240;
	Tue,  3 Dec 2024 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240454; cv=none; b=DrcXGwTbn/xYRYIGiNIrFgEPgttxD6b4KL6EGMrQAcCi8EYfljJHckVKCrK+mXHHIi2LhzTWHCQXzCUgSUzdY9VWGuGB6ZGz4LGs3RrZDLBwRUK/qk447xQ8ZS0/ZmpgUJ6KwhIae0nMKZXhgVv0CD42UhL7WRB8c4bHP3VFf7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240454; c=relaxed/simple;
	bh=2XpOV5MkphAp3pozTa6IpFAiNMw2q92POmA7jVRWwGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdV5f0YRMP0ULQ0e4JtYF63vIv1Ut794+oH5610V0MZdu1pI8/tPZCy517z+jXtxiHbdWRNmyOVNNdoViMMaeFg6v3vIG8MGr7hccl+QLOcpwqiDFmW0GLvIIH8CJuWPNSsJHGabMCVTh1LX9CT1hF66aHbvXEbXvW0p9W4U38w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QiNaaieY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D32C4CECF;
	Tue,  3 Dec 2024 15:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240454;
	bh=2XpOV5MkphAp3pozTa6IpFAiNMw2q92POmA7jVRWwGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QiNaaieYQrzysl0KEeHH2dhscYfOSGYsMl24swRmkQlExXDoyC6ZykmnZDaaUsgQo
	 sjlS3qyuDBa6IbyNrM3/uwoWVSMQm0kKcVVDEH4wsGTuaymwlwVFzIHlwEX/8dSMW1
	 ct7P69kZQZBOWfAYN0SF+tKeRjzyDCPgFPRF9ukw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 108/826] arm64: dts: mt8195: Fix dtbs_check error for infracfg_ao node
Date: Tue,  3 Dec 2024 15:37:15 +0100
Message-ID: <20241203144747.958812598@linuxfoundation.org>
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

From: Macpaul Lin <macpaul.lin@mediatek.com>

[ Upstream commit c14ab45f5d458073248ddc62d31045d5d616806f ]

The infracfg_ao node in mt8195.dtsi was causing a dtbs_check error.
The error message was:

syscon@10001000: compatible: ['mediatek,mt8195-infracfg_ao', 'syscon',
                 'simple-mfd'] is too long

To resolve this, remove 'simple-mfd' from the 'compatible' property of the
infracfg_ao node.

Fixes: 37f2582883be ("arm64: dts: Add mediatek SoC mt8195 and evaluation board")
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20241002051620.2050-1-macpaul.lin@mediatek.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 3a2ba8aac66bb..ade685ed2190b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -487,7 +487,7 @@ topckgen: syscon@10000000 {
 		};
 
 		infracfg_ao: syscon@10001000 {
-			compatible = "mediatek,mt8195-infracfg_ao", "syscon", "simple-mfd";
+			compatible = "mediatek,mt8195-infracfg_ao", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
-- 
2.43.0




