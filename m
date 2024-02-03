Return-Path: <stable+bounces-18408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7475C84829B
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A816B1C22A2F
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC694BAA6;
	Sat,  3 Feb 2024 04:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HQFievIS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE4C1BC39;
	Sat,  3 Feb 2024 04:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933777; cv=none; b=XINTVL/5GwvbpU+0mqjdrR9l3DrlqZkechmYetLLeZMHOlzZsYeou1FNJzeBcaBQhU6V5Rm0LFx52/bR1yU2gi70QcKlo9rg3frtrYnZ964D+y1owcnTVx2iu8GiizsAupA16m+8elO8vM1FwL+wIIg4LBOlPIj+SZ51mndKEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933777; c=relaxed/simple;
	bh=r5tD2/OGXtxO4J9pQAZPA6lrPLtyAcCuTyp63hkumQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liM/cci7D4Dh7dus5Olbm97rbrmAvOXX3gDQZZ3bziPJNs2RtWJjTbZkQn4cQQA52kcgOx9GmiKWC1PIxmGSw1eG7xscRxfVRDK4F/FhDgVyOjWqogtr5IeHMvvTdDos168+qIvKlQan/eHkpITl2XDRe75sXprGLtpLC7ulrQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HQFievIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E0EC433F1;
	Sat,  3 Feb 2024 04:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933776;
	bh=r5tD2/OGXtxO4J9pQAZPA6lrPLtyAcCuTyp63hkumQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQFievISRZR7dnCCMrqJjPiYM+pctT1klXvmspKWeP7d4xGGzz63JKqqXHVYfVzF6
	 RPECCxTPeMTMkwL7BKtOBZgAa2zbsPXtedx5ha+T7sWVXzCexhhpaEJO56dHN6ye42
	 h2Fk4XUSc+46aZQVbPO6IKWGci5FpdtQPi9Pc6cE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 080/353] net: phy: micrel: fix ts_info value in case of no phc
Date: Fri,  2 Feb 2024 20:03:18 -0800
Message-ID: <20240203035406.342170794@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kory Maincent <kory.maincent@bootlin.com>

[ Upstream commit 915d25a9d69be969c1cc6c1dd0c3861f6da7b55e ]

In case of no phc we should not return SOFTWARE TIMESTAMPING flags as we do
not know whether the netdev supports of timestamping.
Remove it from the lan8841_ts_info and simply return 0.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/micrel.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 858175ca58cd..ca2db4adcb35 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3650,12 +3650,8 @@ static int lan8841_ts_info(struct mii_timestamper *mii_ts,
 
 	info->phc_index = ptp_priv->ptp_clock ?
 				ptp_clock_index(ptp_priv->ptp_clock) : -1;
-	if (info->phc_index == -1) {
-		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE |
-					 SOF_TIMESTAMPING_RX_SOFTWARE |
-					 SOF_TIMESTAMPING_SOFTWARE;
+	if (info->phc_index == -1)
 		return 0;
-	}
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
-- 
2.43.0




