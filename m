Return-Path: <stable+bounces-68480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E954953287
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BB41C25C4C
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7890A1A01AE;
	Thu, 15 Aug 2024 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H+K75C5l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BAF1A00F5;
	Thu, 15 Aug 2024 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730703; cv=none; b=oXm6I6e+21eB1gBa8TQ0XSuBRHRlKbEGt2yvqNbqAHtFdR8Ik/PtJyDHf9XnJkhGpQV719IIiSJKbpTR0yvGDzcBaSNduHLIArXw1XKpof0zuHzFTskVaJNLjar8MTXxgECcGvJiZaG76EgWseBgf68EuB8bH3/SfxlOukJJDkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730703; c=relaxed/simple;
	bh=FlboqxrMcOtJhKIBFADqJkNQJ79yHVF8m5acUTmmepg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osdkqIK25TkzOoCarGEuYiJKs38sxNoYk8cashoS5durBCQxuWRw4eF9AAiOtTAsSg9YLlOD9L9PnMrk0pTydKxdOeRB0W3Z3TTObCW89pp8iEVSPOcR7Jwnw2fDLtK1sWzPLLWlWdLQwGMOBuNdJozhll3KCebxKWqpGA48THw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H+K75C5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14FFC32786;
	Thu, 15 Aug 2024 14:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730703;
	bh=FlboqxrMcOtJhKIBFADqJkNQJ79yHVF8m5acUTmmepg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H+K75C5lOxYxr97o06Ol+PLQY1agY5VUW6kcLX0kAZ3UEpQrJ+QrYpjOdqc5BGyo0
	 4/eVeRwR1NTqiYedUn61xqpboYRRpCsKKIIAi6LejaW+0qzPJd9nL9+STix5MG9uf3
	 9FjJ91yq+Y4585EdesV/PfrCR+CbAiQE0NgMPjng=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH 5.15 471/484] net: stmmac: Enable mac_managed_pm phylink config
Date: Thu, 15 Aug 2024 15:25:29 +0200
Message-ID: <20240815131959.669102793@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shenwei Wang <shenwei.wang@nxp.com>

commit f151c147b3afcf92dedff53f5f0e965414e4fd2c upstream

Enable the mac_managed_pm configuration in the phylink_config
structure to avoid the kernel warning during system resume.

Fixes: 744d23c71af3 ("net: phy: Warn about incorrect mdio_bus_phy_resume() state")
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1286,6 +1286,8 @@ static int stmmac_phy_setup(struct stmma
 	if (!fwnode)
 		fwnode = dev_fwnode(priv->device);
 
+	priv->phylink_config.mac_managed_pm = true;
+
 	phylink = phylink_create(&priv->phylink_config, fwnode,
 				 mode, &stmmac_phylink_mac_ops);
 	if (IS_ERR(phylink))



