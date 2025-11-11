Return-Path: <stable+bounces-193844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E87DFC4A866
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7454034C4EA
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4353446AA;
	Tue, 11 Nov 2025 01:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="evEiCpnK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4C22652AF;
	Tue, 11 Nov 2025 01:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824139; cv=none; b=Y+Rl0V6ezJvF/xI3WNK3eiAP6k5NfoiM00+vLkrWL4Yw8IH2znV4hTAAG573OiqwQA43bveTg1rDARHp6zC8sQ9ddfCnzdccdkHZ62h0ye581LIJBKsw6QIsE3uWiVM4BnYgaOg4MV5Ojtaj7saVPSjy0f+opqB+GdhiPWzfZvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824139; c=relaxed/simple;
	bh=vE5yw0OV+aaEGrlUbuu8j5ZiCKSS+9y5hNwtv2yJ/Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bp9nRvRUANrC1pag/0uRdaq7QFPAvQj5Lga+9y4DpeilT5JqmUpOSk6lGS+ZvZ6gA795kffXoqcax/4X/TDUO3oUc/2AL8v1eaGLfLBeTUtuKkAC7jpeAWIwg444emccnnqG3bJefNuSyvoF/8BHJPTkjR3Z5Xsjj+JknJH5zy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=evEiCpnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F75C16AAE;
	Tue, 11 Nov 2025 01:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762824139;
	bh=vE5yw0OV+aaEGrlUbuu8j5ZiCKSS+9y5hNwtv2yJ/Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=evEiCpnKdGYa55qlvVaVFHFm53yZU9Iekb3jF967t4XdubX4QUMbbbjv9Xw0fh96X
	 1zwQdvT2mDzcUvGSFZyVF3uhanprggpQAknKOBlZ6m0N++CDuw4CuEIeMQEDVxBrq6
	 AXzkEWWo1mG1CTOKvCm+ToyGoyhIA43XyYcX4mQg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Colin Foster <colin.foster@in-advantage.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 444/849] smsc911x: add second read of EEPROM mac when possible corruption seen
Date: Tue, 11 Nov 2025 09:40:14 +0900
Message-ID: <20251111004547.168217801@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Foster <colin.foster@in-advantage.com>

[ Upstream commit 69777753a8919b0b8313c856e707e1d1fe5ced85 ]

When the EEPROM MAC is read by way of ADDRH, it can return all 0s the
first time. Subsequent reads succeed.

This is fully reproduceable on the Phytec PCM049 SOM.

Re-read the ADDRH when this behaviour is observed, in an attempt to
correctly apply the EEPROM MAC address.

Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
Link: https://patch.msgid.link/20250903132610.966787-1-colin.foster@in-advantage.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/smsc/smsc911x.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 6ca290f7c0dfb..3ebd0664c697f 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2162,10 +2162,20 @@ static const struct net_device_ops smsc911x_netdev_ops = {
 static void smsc911x_read_mac_address(struct net_device *dev)
 {
 	struct smsc911x_data *pdata = netdev_priv(dev);
-	u32 mac_high16 = smsc911x_mac_read(pdata, ADDRH);
-	u32 mac_low32 = smsc911x_mac_read(pdata, ADDRL);
+	u32 mac_high16, mac_low32;
 	u8 addr[ETH_ALEN];
 
+	mac_high16 = smsc911x_mac_read(pdata, ADDRH);
+	mac_low32 = smsc911x_mac_read(pdata, ADDRL);
+
+	/* The first mac_read in some setups can incorrectly read 0. Re-read it
+	 * to get the full MAC if this is observed.
+	 */
+	if (mac_high16 == 0) {
+		SMSC_TRACE(pdata, probe, "Re-read MAC ADDRH\n");
+		mac_high16 = smsc911x_mac_read(pdata, ADDRH);
+	}
+
 	addr[0] = (u8)(mac_low32);
 	addr[1] = (u8)(mac_low32 >> 8);
 	addr[2] = (u8)(mac_low32 >> 16);
-- 
2.51.0




