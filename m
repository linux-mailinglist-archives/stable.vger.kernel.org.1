Return-Path: <stable+bounces-155864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 118F2AE4406
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2285188D0D2
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7843A2505A9;
	Mon, 23 Jun 2025 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nY/Lbrqz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A0524679C;
	Mon, 23 Jun 2025 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685534; cv=none; b=IN+E2+LMhOhDKRxjUbmvIZEXTB6ks8CnpxDjbzzgk0ApXLsgDbxmrt+UtItBO7Y3Li2q/WZo6wBjxOct7TKCy6WX4MHyA50XaFHG/eO80gHf2/QcqVWY/s2pAKcfC60hjqGNS0DcwMeMBA5kbJiWavlBj9qXMT43U6ypI6GlG9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685534; c=relaxed/simple;
	bh=AWvVqQ5Bd/XnJWucLfFFwqJGeTatIxtGppgD9YNNPsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTfy//E3ttWsaDRiIvRKXUn5w9jJo0MPNpK7PEv1h0R3R63HUAAwEkoiyDFbrAfvysy9TAm6pkqd9ym1yVbOG+RF/vb/ODM7oaJMVuCqFn4AFpFvVeIRyN5cMA/pWnezzFxWpQj1AfYS4q3RHIDAR76AGgorq03Iefo6Wz0XAWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nY/Lbrqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB51EC4CEEA;
	Mon, 23 Jun 2025 13:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750685534;
	bh=AWvVqQ5Bd/XnJWucLfFFwqJGeTatIxtGppgD9YNNPsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nY/LbrqzZ+qbJ8ahr92PvNOTDqAkJub3piYpVaPgmjUoHLjcjxJPJPIWkvo7YEcr6
	 UbwuJtKNl9hvdaqKuEvnTf6zSmRiS7etdn31H9D/ydbCrzyoCX/Ax9XUClFlVXMS4H
	 aI0Wbs1hzUVb6N/e9sidN4WIhlR1Y2SSfrZUaus4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 057/355] net: phy: mscc: Stop clearing the the UDPv4 checksum for L2 frames
Date: Mon, 23 Jun 2025 15:04:18 +0200
Message-ID: <20250623130628.541139579@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Horatiu Vultur <horatiu.vultur@microchip.com>

[ Upstream commit 57a92d14659df3e7e7e0052358c8cc68bbbc3b5e ]

We have noticed that when PHY timestamping is enabled, L2 frames seems
to be modified by changing two 2 bytes with a value of 0. The place were
these 2 bytes seems to be random(or I couldn't find a pattern).  In most
of the cases the userspace can ignore these frames but if for example
those 2 bytes are in the correction field there is nothing to do.  This
seems to happen when configuring the HW for IPv4 even that the flow is
not enabled.
These 2 bytes correspond to the UDPv4 checksum and once we don't enable
clearing the checksum when using L2 frames then the frame doesn't seem
to be changed anymore.

Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Link: https://patch.msgid.link/20250523082716.2935895-1-horatiu.vultur@microchip.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mscc/mscc_ptp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index b97ee79f3cdfc..85102e895665e 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -943,7 +943,9 @@ static int vsc85xx_ip1_conf(struct phy_device *phydev, enum ts_blk blk,
 	/* UDP checksum offset in IPv4 packet
 	 * according to: https://tools.ietf.org/html/rfc768
 	 */
-	val |= IP1_NXT_PROT_UDP_CHKSUM_OFF(26) | IP1_NXT_PROT_UDP_CHKSUM_CLEAR;
+	val |= IP1_NXT_PROT_UDP_CHKSUM_OFF(26);
+	if (enable)
+		val |= IP1_NXT_PROT_UDP_CHKSUM_CLEAR;
 	vsc85xx_ts_write_csr(phydev, blk, MSCC_ANA_IP1_NXT_PROT_UDP_CHKSUM,
 			     val);
 
-- 
2.39.5




