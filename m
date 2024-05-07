Return-Path: <stable+bounces-43237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714228BF073
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D74F283D80
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07241311B9;
	Tue,  7 May 2024 22:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Flrksmiy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB5C1311A9;
	Tue,  7 May 2024 22:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122759; cv=none; b=LmhpeZKs7OHnQtXYNf/8BxjjOlSbX15+pFq+bEfIX/hDEF51NWWs3tZ4PCeKEp8QHBtinmINm1LWDHStmJ+FgW7dqfzbDZYrYi3TSz9pSgxLDbmOgVHKLE1vheHTWev/DOXP1pIjWUuGYrzAtMhVMtmK0jiMbvDuTPIdBnGkNqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122759; c=relaxed/simple;
	bh=uHVexuiQEyLGa/+Bpi1sAob8fjUD7bOIr0rbWd3nEPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrTNiR1NCkecDXsZ9Vj/itrU6Euf5t2o2Ve7wFRdjkuZLEt7eOpFXMBjmnip646FU1FQyooYU27Mz5gcQeJJIyZrIYfFy+tNvurf/tFePBEdNVyFS1TPux3km5gssX7SUquP4Y9tvRGdcGzJyic8p1VdGB2n3hsmh547WituAyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Flrksmiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF198C4AF17;
	Tue,  7 May 2024 22:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122759;
	bh=uHVexuiQEyLGa/+Bpi1sAob8fjUD7bOIr0rbWd3nEPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Flrksmiy0kJfG0XNQgHAHx1dcjBWBYFfBucjydqW8zAnj/Awuwgte2RN+kO4TRPuB
	 2TXegU7ktZzy9bJzazljjqltpUXi12zNBddQNYrjYkpejR86pNkqxZUbmF/CTftp3t
	 KMqKF7HtH/BcvR4aqMMBKzivWlaYEjaepf3rOiHy0h2QOC4spllF/fuojEps1xIGMK
	 zav2Hohp9hYm3DdWJzMMTD9rSke/kls4pTMU5thUM9byVvTG+xW+eAqq/oKCNTshTe
	 JSoPLORgkD9Lu89yDX298d4wSukLup46r6IKMQafriIozj4BlwFPr4QlahxwkH7Vxy
	 /Y+TB9QaH+Hkg==
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
	s.hauer@pengutronix.de,
	cristian.ciocaltea@collabora.com,
	andy.yan@rock-chips.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 04/19] dt-bindings: rockchip: grf: Add missing type to 'pcie-phy' node
Date: Tue,  7 May 2024 18:58:26 -0400
Message-ID: <20240507225910.390914-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225910.390914-1-sashal@kernel.org>
References: <20240507225910.390914-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
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
index e4fa6a07b4fa2..be6ffec2b0749 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -163,6 +163,7 @@ allOf:
           unevaluatedProperties: false
 
         pcie-phy:
+          type: object
           description:
             Documentation/devicetree/bindings/phy/rockchip-pcie-phy.txt
 
-- 
2.43.0


