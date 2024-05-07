Return-Path: <stable+bounces-43216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3837B8BF018
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 00:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BD82817DA
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 22:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488C684DF0;
	Tue,  7 May 2024 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfNMyBoZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EA084DE6;
	Tue,  7 May 2024 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122659; cv=none; b=oHhDPhXsiH+vtDVFjMYAg38dLu480NcODbR64ZZ80lcoEDpRLj6PsBuADQ6DGVl6XgrjljKZsavTHmZ/XmSS3B6Heu4J56lpP3w3nSSRRrwE3x9yz2XMwfMAO6WN1erx+23R3w3ShJQ8EbqOnp3+GxSmWGirxkJTNJMj3msKOxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122659; c=relaxed/simple;
	bh=rl58UGSDXiOQtAtALxX1AesGxhJWgrq4HBhX/WX/mTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tg8RQ1RXlmERkDpd/EK9K6y1l1uwO7OTjYkgr9sJ7En7bQV1hXzwBIHVOi/JuAFolsbT8Zms1V3qxXiAyJ83/8Svu5FpHVGORsMW+yvVnEaIZfWpSKWlhzmP3nDDkqlHcFvbBr9G39XfzEPGnbpgYhNCYa+w8Mr7PnrnbiXSSbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfNMyBoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDC8C2BBFC;
	Tue,  7 May 2024 22:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122658;
	bh=rl58UGSDXiOQtAtALxX1AesGxhJWgrq4HBhX/WX/mTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TfNMyBoZAhMgD47ZLQN/r1wGsNff1TDtcoKWmDCFX/cXWUfkFrL6fzjWGC9pUTUZk
	 ZLth9qDKKIN8lLtJa+2PlKQzgVzVuAR4hkAo2j0PzxfSjUWc24icvwSixor8AN8nJV
	 i2vFx0ICMPqAzuGFhrhijKi9Qn5I/ibrKBXdF+k7uYzbrGP95V37WJ8REEAsVBbomi
	 jQuNwx/hhWrGDPF40/nE8Mps7d6rCBPIlr11O9yo1Y0/kDyRbElrA0pMNeBCv0QFv4
	 7sTWOoCSoQCsoRevczt46XGzf8BmM7vukwayOLr+MdbuDMFFT/ZTJzzIXjoRybQiqL
	 lqqJbEbhcYuSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sasha Levin <sashal@kernel.org>,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	sebastian.reichel@collabora.com,
	andy.yan@rock-chips.com,
	cristian.ciocaltea@collabora.com,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 06/23] dt-bindings: rockchip: grf: Add missing type to 'pcie-phy' node
Date: Tue,  7 May 2024 18:56:32 -0400
Message-ID: <20240507225725.390306-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225725.390306-1-sashal@kernel.org>
References: <20240507225725.390306-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Rob Herring <robh@kernel.org>

[ Upstream commit d41201c90f825f19a46afbfb502f22f612d8ccc4 ]

'pcie-phy' is missing any type. Add 'type: object' to indicate it's a
node.

Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20240401204959.1698106-1-robh@kernel.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 9793ea6f0fe65..575555810c2c2 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -165,6 +165,7 @@ allOf:
           unevaluatedProperties: false
 
         pcie-phy:
+          type: object
           description:
             Documentation/devicetree/bindings/phy/rockchip-pcie-phy.txt
 
-- 
2.43.0


