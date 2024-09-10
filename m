Return-Path: <stable+bounces-74339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B3C972ED0
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243A31C2404B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14D9191F9F;
	Tue, 10 Sep 2024 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XTp4YwZG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F963192B7B;
	Tue, 10 Sep 2024 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961517; cv=none; b=jiEbuOmqj6n+WHBkAqH0egcJZG2VkigmSKhPghYnm3gjVtm7MLDwBSXwn+WmwYyhjquvSLHxQl45yHlDkdK0qdxjkTVHiAvwJUVNF51TFsOGJ87wu88Xj1EHkUEK9z2ow0M/eouGXEfY6g+ATyX4WgMdwYYNh6i64HbcVawsCvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961517; c=relaxed/simple;
	bh=0yLZnMzVS0ULLRyD0z2YgDyNYrb30MuIC6kSp/JJM+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnI7a/fNOK6E+Yg/cc0hZ8vAD+AcwK0jmt3JBNrpL0Eth7bEUth0gjCGSBl36H7np54ODckI+LRoFn8x/DKdhDLCx+icBy3IDIKToQLUL3xi6Li76qH+ABk+V6p81v7Sm4Z3MwKClDIos6L1jOKkwWXTCUnhkwK+8r6tQYqYUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XTp4YwZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB088C4CEC3;
	Tue, 10 Sep 2024 09:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961517;
	bh=0yLZnMzVS0ULLRyD0z2YgDyNYrb30MuIC6kSp/JJM+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XTp4YwZGeVZ3Bx5vrFzwPxI5BJ0JmGael6aV2DwDXDAzgs2ouh1E0eoq4Zj09N544
	 nCxny/vNu2ZOzVOFeXPFnaLyqFHODMAlLPwdt8tgK+sAZ/ntu1JLDDXAc89SVa1YBG
	 hGyHNVYc8uojc6Fo2dfUhy8MoP2ir1z6LM5QptT4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ajith C <quic_ajithc@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 096/375] wifi: ath12k: fix firmware crash due to invalid peer nss
Date: Tue, 10 Sep 2024 11:28:13 +0200
Message-ID: <20240910092625.467440205@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ajith C <quic_ajithc@quicinc.com>

[ Upstream commit db163a463bb93cd3e37e1e7b10b9726fb6f95857 ]

Currently, if the access point receives an association
request containing an Extended HE Capabilities Information
Element with an invalid MCS-NSS, it triggers a firmware
crash.

This issue arises when EHT-PHY capabilities shows support
for a bandwidth and MCS-NSS set for that particular
bandwidth is filled by zeros and due to this, driver obtains
peer_nss as 0 and sending this value to firmware causes
crash.

Address this issue by implementing a validation step for
the peer_nss value before passing it to the firmware. If
the value is greater than zero, proceed with forwarding
it to the firmware. However, if the value is invalid,
reject the association request to prevent potential
firmware crashes.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Ajith C <quic_ajithc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://patch.msgid.link/20240613053528.2541645-1-quic_ajithc@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 71b4ec7717d5..7037004ce977 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3847,6 +3847,11 @@ static int ath12k_station_assoc(struct ath12k *ar,
 
 	ath12k_peer_assoc_prepare(ar, vif, sta, &peer_arg, reassoc);
 
+	if (peer_arg.peer_nss < 1) {
+		ath12k_warn(ar->ab,
+			    "invalid peer NSS %d\n", peer_arg.peer_nss);
+		return -EINVAL;
+	}
 	ret = ath12k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to run peer assoc for STA %pM vdev %i: %d\n",
-- 
2.43.0




