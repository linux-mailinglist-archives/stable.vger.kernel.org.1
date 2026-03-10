Return-Path: <stable+bounces-224442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FG+AfUDsGkWegIAu9opvQ
	(envelope-from <stable+bounces-224442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:43:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD4A24B6CF
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B35530810BF
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CBB423141;
	Tue, 10 Mar 2026 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LG6582Ho"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47855421F0E;
	Tue, 10 Mar 2026 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142175; cv=none; b=CxWel5979kC6eOf3pCuvVkOZIvmDFc/nvG7spCGZzfoE7938/J9m3xEhQUvDid0hldqfENZcdmQA95gLMAyJYZerd3QWzR90/Ktw/U9i9eeoKQYxhCzwaUOMyQ+53a59vmUxLG2HEOcT9xnkgF4bfRPptSQHq0Slq0Xp7oDSXEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142175; c=relaxed/simple;
	bh=N7Wyh5ramUXGxgblyxj6McCO9h990p/XpTpfY9fEEbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSS5PUJ3/spYjLcFQAus5M3ulCB3VLGD/22jtDIO4zQrp06TgoiWBFI7ouMUkoQgJl4Ms1aqZKbDDP9M0vGgwNUOfm6w6xBN69SmCIL/BFLBLCfJ+SFe0DcDzRJuy8E2g4sVLvhfX7Wc/3yVgqenBPuEXpni/5Odnz8T0tuy/dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LG6582Ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B05C2BCAF;
	Tue, 10 Mar 2026 11:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142175;
	bh=N7Wyh5ramUXGxgblyxj6McCO9h990p/XpTpfY9fEEbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LG6582HoksGu4muVYX/ZP9rcpaal6tsWV08jo5hphmLwVSzMVI/jmcVMNXbQDgux3
	 AEGawvXuxW1crHF0mnEorxPD2twf3evqY+rX3Lna2blx7QZ9QqWIurp/O3aXf7eid0
	 24gNZ5ufv4qyyQEuVOMeoENn+6T9BuWrRQH/9Sd1jMoWBdK9hBU87Bl+qGp0Iuy9Zp
	 YpruWTEtcF68XD7agv0Mshp6CAKTx/PAl3wy5ScYw4DaM2ctZG3dGKNcS8Zv5GLKnN
	 alyem0N6rfjT7h3Lvw4B/q9X8tL8YyW6I44Ds47AfgmoiHrqb/6VnAV0IGa8SQdmnD
	 eJ1fYpb5tdmSg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kohei Enju <kohei@enjuk.jp>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 263/314] iavf: fix netdev->max_mtu to respect actual hardware limit
Date: Tue, 10 Mar 2026 07:18:42 -0400
Message-ID: <6469b12943208edf008b38254f35f495b17a484b.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9DD4A24B6CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224442-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,enjuk.jp:email]
X-Rspamd-Action: no action

From: Kohei Enju <kohei@enjuk.jp>

[ Upstream commit b84852170153671bb0fa6737a6e48370addd8e1a ]

iavf sets LIBIE_MAX_MTU as netdev->max_mtu, ignoring vf_res->max_mtu
from PF [1]. This allows setting an MTU beyond the actual hardware
limit, causing TX queue timeouts [2].

Set correct netdev->max_mtu using vf_res->max_mtu from the PF.

Note that currently PF drivers such as ice/i40e set the frame size in
vf_res->max_mtu, not MTU. Convert vf_res->max_mtu to MTU before setting
netdev->max_mtu.

[1]
 # ip -j -d link show $DEV | jq '.[0].max_mtu'
 16356

[2]
 iavf 0000:00:05.0 enp0s5: NETDEV WATCHDOG: CPU: 1: transmit queue 0 timed out 5692 ms
 iavf 0000:00:05.0 enp0s5: NIC Link is Up Speed is 10 Gbps Full Duplex
 iavf 0000:00:05.0 enp0s5: NETDEV WATCHDOG: CPU: 6: transmit queue 3 timed out 5312 ms
 iavf 0000:00:05.0 enp0s5: NIC Link is Up Speed is 10 Gbps Full Duplex
 ...

Fixes: 5fa4caff59f2 ("iavf: switch to Page Pool")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 4b0fc8f354bc9..53a0366fbf998 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2797,7 +2797,22 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 	netdev->watchdog_timeo = 5 * HZ;
 
 	netdev->min_mtu = ETH_MIN_MTU;
-	netdev->max_mtu = LIBIE_MAX_MTU;
+
+	/* PF/VF API: vf_res->max_mtu is max frame size (not MTU).
+	 * Convert to MTU.
+	 */
+	if (!adapter->vf_res->max_mtu) {
+		netdev->max_mtu = LIBIE_MAX_MTU;
+	} else if (adapter->vf_res->max_mtu < LIBETH_RX_LL_LEN + ETH_MIN_MTU ||
+		   adapter->vf_res->max_mtu >
+			   LIBETH_RX_LL_LEN + LIBIE_MAX_MTU) {
+		netdev_warn_once(adapter->netdev,
+				 "invalid max frame size %d from PF, using default MTU %d",
+				 adapter->vf_res->max_mtu, LIBIE_MAX_MTU);
+		netdev->max_mtu = LIBIE_MAX_MTU;
+	} else {
+		netdev->max_mtu = adapter->vf_res->max_mtu - LIBETH_RX_LL_LEN;
+	}
 
 	if (!is_valid_ether_addr(adapter->hw.mac.addr)) {
 		dev_info(&pdev->dev, "Invalid MAC address %pM, using random\n",
-- 
2.51.0


