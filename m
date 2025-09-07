Return-Path: <stable+bounces-178237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7234B47DCD
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5BC216B5B3
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45381D88D0;
	Sun,  7 Sep 2025 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O2DwJI0j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629FA1B424F;
	Sun,  7 Sep 2025 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276200; cv=none; b=dNzacI4lyhCRKF7j96xf3GSJu24w41H+152ap8cG0n0F3L3RzE3dd+Ciirdmg2SUikjgRKZ0TKx5dOn5jpvXruj3kokJeBd4Wb424RW5NRfucyBq8mZ72QbVObtouPAQNpjXRvi2jK5m1NbtKhHPh0RfePmcANSP6hpEmfG7sG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276200; c=relaxed/simple;
	bh=E9EiEqxr9pY/MtCZfTYwfI1YSTa3cxkDVXcWmXftQew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0emQpVTdbG8dQUhTIOUkaXiWkFBAfoSy7hUJYMOSXKZxy71qTL4frdp+fEDpAtK8i/YWl4g7BGORK0DkKxgGfPhAFQaw3/IWPWxiCQqlzEv76QdxRhs9IcZskmY7FM7DKUBDrM5h1LGDo8BQd+S0rjwXetORKnKISKijsaAAGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O2DwJI0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5FEC4CEF0;
	Sun,  7 Sep 2025 20:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276200;
	bh=E9EiEqxr9pY/MtCZfTYwfI1YSTa3cxkDVXcWmXftQew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2DwJI0j++v7OQb1IXM8pG5q31+Kk3ga7S8dAIm8UzwCfb1EmDdWa0KMyPqP6/Rxv
	 FS8bG/28AoPM/GESDFjj092eObraLHAocqiD1lhA4G5HAw6A8HwMusbh9n/hmNRN4t
	 er6tRVGIiKY4T0B0q/viYwcVoAY9GkWxShHiRWQE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rosen Penev <rosenp@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 030/104] net: thunder_bgx: add a missing of_node_put
Date: Sun,  7 Sep 2025 21:57:47 +0200
Message-ID: <20250907195608.482468650@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195607.664912704@linuxfoundation.org>
References: <20250907195607.664912704@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rosen Penev <rosenp@gmail.com>

[ Upstream commit 9d28f94912589f04ab51fbccaef287d4f40e0d1f ]

phy_np needs to get freed, just like the other child nodes.

Fixes: 5fc7cf179449 ("net: thunderx: Cleanup PHY probing code.")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250901213018.47392-1-rosenp@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/cavium/thunder/thunder_bgx.c  | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 8c955eefc7e4f..d054c519cd617 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1492,13 +1492,17 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		 * this cortina phy, for which there is no driver
 		 * support, ignore it.
 		 */
-		if (phy_np &&
-		    !of_device_is_compatible(phy_np, "cortina,cs4223-slice")) {
-			/* Wait until the phy drivers are available */
-			pd = of_phy_find_device(phy_np);
-			if (!pd)
-				goto defer;
-			bgx->lmac[lmac].phydev = pd;
+		if (phy_np) {
+			if (!of_device_is_compatible(phy_np, "cortina,cs4223-slice")) {
+				/* Wait until the phy drivers are available */
+				pd = of_phy_find_device(phy_np);
+				if (!pd) {
+					of_node_put(phy_np);
+					goto defer;
+				}
+				bgx->lmac[lmac].phydev = pd;
+			}
+			of_node_put(phy_np);
 		}
 
 		lmac++;
-- 
2.50.1




