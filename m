Return-Path: <stable+bounces-199269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 074F5CA05BA
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45F8F31919D3
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C65B35E550;
	Wed,  3 Dec 2025 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bc5XuRMZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD8A35E556;
	Wed,  3 Dec 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779239; cv=none; b=bo2Z+u+jNEEzkZptmaQ0lpJRKa8c3JepLW6RM5QjJ608zJ4tyiJrGitF7yTg7uZuczcGw+w/oaFxW/CoSJaFbq1aZwlUrwo4AN1FPo8On9YhTypTaowLE36Y9EqLsv1V/Fh10JHkGUJiDRO89bOt8mVcuOMKZRyRsuZP88o1T5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779239; c=relaxed/simple;
	bh=N+/TWSQ1vVzpe0M8wFxmkDUXIBPJwzhaL/kal3pPUoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4mbvNle3SpmBzMDFqC+dTmFgBFvGFEjU1WO/ayv1Tc6zSEWfzes9s5obzvQkQdhB6ClRgb4C+85vMRnhjElvGVhryfPsabfjHnAU6bXkem73bq6P8N3r6ts0heQY5hs9cnd6eupskGfMtK2ygLxRFgXLrbal+EaHP4CYDtBhog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bc5XuRMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FC0C4CEF5;
	Wed,  3 Dec 2025 16:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764779239;
	bh=N+/TWSQ1vVzpe0M8wFxmkDUXIBPJwzhaL/kal3pPUoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bc5XuRMZgBNE1gW2DpGDTqhiNu0XeeEgDXu7ZIitf5xjb7qkF7y4PQFBjn7x6cBCt
	 HW721HNrwZXXMsF4BfyVueTK2SlA8QqfVfeL1AulNk0nS7/jESEWCNu8BTGdLMWOlZ
	 /KLpjXqIZw0CoMQNSf357xTz5GUvQ0hHh42k19Kw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Colin Foster <colin.foster@in-advantage.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 197/568] smsc911x: add second read of EEPROM mac when possible corruption seen
Date: Wed,  3 Dec 2025 16:23:19 +0100
Message-ID: <20251203152447.941981728@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152440.645416925@linuxfoundation.org>
References: <20251203152440.645416925@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index a690d139e1770..a1bb16ba36595 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2165,10 +2165,20 @@ static const struct net_device_ops smsc911x_netdev_ops = {
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




