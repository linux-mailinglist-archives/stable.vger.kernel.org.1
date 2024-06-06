Return-Path: <stable+bounces-48651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697AC8FE9EC
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5241C25E92
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF481198A3C;
	Thu,  6 Jun 2024 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nvBAWhAf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD47198E72;
	Thu,  6 Jun 2024 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683080; cv=none; b=T2tP7F5ac1aSDEwA6oLDwTH2nxdT9RmVr/8SwboKLeG4FVqsWbFXzuv+6oxLSRWfkeO5fn2YheQZtJ1bhzlyUI4tAQ+zBRq9lQTCq/FW+OQhjgz7fcpAR2tfzhVAyAG+9TC4OarxpH8ul8+oAoQ1S0gqN4IvBokYu2D0zq1C810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683080; c=relaxed/simple;
	bh=uY/LcTZpnYBKs5cJg6MTdoOrfFdB8o9U7wDF0IFMGps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3arRvkuJIvZVwKqe7YI+rbZJ+efDGCu3Xs8v2PlWjpenFpem0J4Y/DEPtFyw+W5g/1H5nqCN6gTxGTcEWReGU3paGUN6m9ucD3gZ8tdP9kpSFrJ3XxO7ReoUqOXUXlYIptqHPc+/SBwGurEvB15b5ud9XtlqZF9K6feKEgWV7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nvBAWhAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A030C32781;
	Thu,  6 Jun 2024 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683080;
	bh=uY/LcTZpnYBKs5cJg6MTdoOrfFdB8o9U7wDF0IFMGps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nvBAWhAfHRxqVvuN06itsEQRZCb9mUsFAxKwEtmIGA2Oa9eeleftyLYfkqIU3RgU2
	 VUE+fBB0fleigJQlWv/zhSlnTHhvfjPAV0NqTfI78Z5JgaFLurKrDnix++ZvYlzLlH
	 CBz5uI9Q5tcl3uDHJbcx6dlMEtmjwfO6kFo3j5VQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tristram Ha <tristram.ha@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Jerry Ray <jerry.ray@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 350/374] net: dsa: microchip: fix RGMII error in KSZ DSA driver
Date: Thu,  6 Jun 2024 16:05:29 +0200
Message-ID: <20240606131703.592860429@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tristram Ha <tristram.ha@microchip.com>

[ Upstream commit 278d65ccdadb5f0fa0ceaf7b9cc97b305cd72822 ]

The driver should return RMII interface when XMII is running in RMII mode.

Fixes: 0ab7f6bf1675 ("net: dsa: microchip: ksz9477: use common xmii function")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
Acked-by: Jerry Ray <jerry.ray@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/1716932066-3342-1-git-send-email-Tristram.Ha@microchip.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/microchip/ksz_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 2b510f150dd88..2a5861a88d0e6 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3050,7 +3050,7 @@ phy_interface_t ksz_get_xmii(struct ksz_device *dev, int port, bool gbit)
 		else
 			interface = PHY_INTERFACE_MODE_MII;
 	} else if (val == bitval[P_RMII_SEL]) {
-		interface = PHY_INTERFACE_MODE_RGMII;
+		interface = PHY_INTERFACE_MODE_RMII;
 	} else {
 		interface = PHY_INTERFACE_MODE_RGMII;
 		if (data8 & P_RGMII_ID_EG_ENABLE)
-- 
2.43.0




