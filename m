Return-Path: <stable+bounces-43257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C448BF0D9
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF6B1C21B97
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188C080032;
	Tue,  7 May 2024 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knJ4GvmE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C9B137C54;
	Tue,  7 May 2024 23:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122840; cv=none; b=I5ROAoE5xm91LB0jyU7ZUPI0CiddkOLTNIHC1ULGuZkjk8gmbAg/dT6vtK6D47EkEkFAgjaRSjz7txsGidoOSTabDoK4nIqFf/l0spl2q7WIxSsauLsxea312fc2V1gVCH+Z25FNpA+S5f2FwghgQfYjQtKCTAJ2sR21XzwOWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122840; c=relaxed/simple;
	bh=VyDzfSvgygGoJ6vgcUYx97XIpCc+SJbIDApetEfwgow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlY0qLBcL+qdI7rKCMwY1LwI+SK4mMJ6g3Jhb7OZk6qreKiQDmNq939C5rvX73kOApS96pEb0XqM0zb/s36tSu39YdiRaJZVOoGhzRAAzYcQOXpcWgS/A7IkpWBwmbEM+ULLGJa7v1TqFTzTqghwjHDj5acbcvt4gAyVHRI27aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knJ4GvmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19E0C2BBFC;
	Tue,  7 May 2024 23:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122840;
	bh=VyDzfSvgygGoJ6vgcUYx97XIpCc+SJbIDApetEfwgow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=knJ4GvmEM6d5YJ7Wx3Nqh7G0CIFr64pbuARoobRbPKTKQL7LxBDh2LWPmxqxTpyXE
	 2B8IENtKNg9OqzXsYIeV/2fwmWqudwdhki27OpDkdxHZnhMyw0PFUtmoyCOviTKbBG
	 nHCz+zm8U12wmxbGhYQWAZBJBvR9X0oDAQ6vPOGd/hxegv0lebFlSpkYXqEacgPCrn
	 7xrsDb2iAyEYTiDn/txAB/ebNYGyh5jeYxLde1DjgWi6lCr1roq7z9hQoq2CCxMzw0
	 m8g3RFy9NOg85ehxaOh4mS0C7umtYrY7OiYt1fxzFM7ViVZgKdrYGzqliA1r3Hg9Mz
	 Nz5oZtD+kaT0A==
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
Subject: [PATCH AUTOSEL 6.1 04/12] dt-bindings: rockchip: grf: Add missing type to 'pcie-phy' node
Date: Tue,  7 May 2024 19:00:06 -0400
Message-ID: <20240507230031.391436-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230031.391436-1-sashal@kernel.org>
References: <20240507230031.391436-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
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
index 2ed8cca79b59c..e4eade2661f6b 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -151,6 +151,7 @@ allOf:
           unevaluatedProperties: false
 
         pcie-phy:
+          type: object
           description:
             Documentation/devicetree/bindings/phy/rockchip-pcie-phy.txt
 
-- 
2.43.0


