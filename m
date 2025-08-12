Return-Path: <stable+bounces-168713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C76DAB23671
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C70317B1E35
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C202FE571;
	Tue, 12 Aug 2025 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZNRsmKoN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C402C2F6573;
	Tue, 12 Aug 2025 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025088; cv=none; b=SJkftMuOHJirfEDCU+0ejuVUemiMvVbNni4qiQV6IdY3oEq9WFkRpqumEVaNw70zjG2WfwnQzbZh+S0SMigPze93HvfOF3+z9QBUkmqWz++57MqMVEOQ56oRlv60dxOEdia/fd2PASvDRKrfNi9iN1IDlEHcYNVYEia51W4qvs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025088; c=relaxed/simple;
	bh=YqDJUGfDhc3deXURXEiBUgsmq+KSqOqVs0abFUHoyzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/HyedVGY6qXq4ibomhIiHZ+zgQRoBEXcTVnhzOpnCB9QRrTU2sUvnL0wRadLwNyNB0ABFoSS6p0vnFksJGy39oLcG6rxd5/KJgJUFykWHrWd+kMfoTjdqdC4Vm3hMYRSHIu1MQufjSXviQIIrlytboRIFjzGh+anY69tfMsIKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZNRsmKoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32302C4CEF0;
	Tue, 12 Aug 2025 18:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025088;
	bh=YqDJUGfDhc3deXURXEiBUgsmq+KSqOqVs0abFUHoyzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZNRsmKoNxDiumUjc/2FAaX2I/7vfwjxIeQRGxy9cJWBP6HJMAZqK5fubIISUeJeWu
	 vLCLWHcpiF26+A7++Om/YLZJ8WNatj1S0pdM4iBDROQx1Yb/WM7Bb6QAn+u5nBXSCZ
	 9ZW5kwGY3kbHQ+coyRPvJnDHa+g8K2W0I73p+bVE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 533/627] net: mdio: mdio-bcm-unimac: Correct rate fallback logic
Date: Tue, 12 Aug 2025 19:33:48 +0200
Message-ID: <20250812173452.192395013@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <florian.fainelli@broadcom.com>

[ Upstream commit a81649a4efd382497bf3d34a623360263adc6993 ]

When the parent clock is a gated clock which has multiple parents, the
clock provider (clk-scmi typically) might return a rate of 0 since there
is not one of those particular parent clocks that should be chosen for
returning a rate. Prior to ee975351cf0c ("net: mdio: mdio-bcm-unimac:
Manage clock around I/O accesses"), we would not always be passing a
clock reference depending upon how mdio-bcm-unimac was instantiated. In
that case, we would take the fallback path where the rate is hard coded
to 250MHz.

Make sure that we still fallback to using a fixed rate for the divider
calculation, otherwise we simply ignore the desired MDIO bus clock
frequency which can prevent us from interfacing with Ethernet PHYs
properly.

Fixes: ee975351cf0c ("net: mdio: mdio-bcm-unimac: Manage clock around I/O accesses")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250730202533.3463529-1-florian.fainelli@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/mdio/mdio-bcm-unimac.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index b6e30bdf5325..7baab230008a 100644
--- a/drivers/net/mdio/mdio-bcm-unimac.c
+++ b/drivers/net/mdio/mdio-bcm-unimac.c
@@ -209,10 +209,9 @@ static int unimac_mdio_clk_set(struct unimac_mdio_priv *priv)
 	if (ret)
 		return ret;
 
-	if (!priv->clk)
+	rate = clk_get_rate(priv->clk);
+	if (!rate)
 		rate = 250000000;
-	else
-		rate = clk_get_rate(priv->clk);
 
 	div = (rate / (2 * priv->clk_freq)) - 1;
 	if (div & ~MDIO_CLK_DIV_MASK) {
-- 
2.39.5




