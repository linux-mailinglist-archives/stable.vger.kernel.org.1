Return-Path: <stable+bounces-43267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D74568BF10B
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7681BB2459A
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED78F13B792;
	Tue,  7 May 2024 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfzDXk2I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB1113B78E;
	Tue,  7 May 2024 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122881; cv=none; b=GSe+X66mROBI6w9ZPRdxSXnUkmRUVXLa4/t5GMEMrmhIreIw/kU0gtuaNocmcW4z8cHv9vAbTyuUFX2LeLt5dJLQ8R5qAumUGPG0b9G0YwUJZNLvQLpIydL6mmYA7bbtUefP/0lfxnRNze6ayV7bYByLHUIK5WBa+c7DvXm1QlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122881; c=relaxed/simple;
	bh=rFAC8oNtjUVBchYHdF8+lnywIFKHivJ6mH4y+PqvvW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZ0QKE0RbCOCZZxISlL6xWf3G8BxZyhnBoIMf6v3GlIHAuni4DP1yakgzIcTyJD1tMp5R9nJNwwzrnd88fJqjEwqpzia+0bzKnEOgrvt34WMm6Zkns9OC46tJRZ02joN+a3tUZ9Jukxge6RtR9CsbfRPk9VkQjuqTeywJfEIdYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfzDXk2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5667C4AF17;
	Tue,  7 May 2024 23:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122881;
	bh=rFAC8oNtjUVBchYHdF8+lnywIFKHivJ6mH4y+PqvvW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dfzDXk2If9DqyP2OSdNXqmdslfPiWI68Fa/0paak/Pd/UU6AtVAbCxCEPwNZOspu7
	 c/IYzE34xVvNlvNrdDvWJiiXdtwTqpUxGA6lVULH+E1msGZaRrkYpx6w4dm49rlBvn
	 NkVrEObqKCLVXmZQ15CVQPkEL0TfOx+0obStFHo9lKs1XjZ8uwAJ92zi7t92Bb37Og
	 ex+o4XkTQY3whNZBcL5nyZJQgme6/OuFwkj46xN1o9tZeK/+ZAZiPWK14wTXD1J1BQ
	 jtWM3lstdSLRAXCEtklXSD0XEzz5MI9qxKSRJ8nRejXnzSTOwbhwyj0R94Tv05JavU
	 /iptvHDfISeSg==
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
	cristian.ciocaltea@collabora.com,
	andy.yan@rock-chips.com,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 2/5] dt-bindings: rockchip: grf: Add missing type to 'pcie-phy' node
Date: Tue,  7 May 2024 19:01:06 -0400
Message-ID: <20240507230115.391725-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230115.391725-1-sashal@kernel.org>
References: <20240507230115.391725-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.158
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
index dfebf425ca49c..8fe31a7083db8 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -141,6 +141,7 @@ allOf:
           unevaluatedProperties: false
 
         pcie-phy:
+          type: object
           description:
             Documentation/devicetree/bindings/phy/rockchip-pcie-phy.txt
 
-- 
2.43.0


