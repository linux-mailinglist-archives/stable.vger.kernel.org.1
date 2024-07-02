Return-Path: <stable+bounces-56392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA6A92442B
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7578F281C30
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55C91BE22B;
	Tue,  2 Jul 2024 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HxRMgQ2k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732A9178381;
	Tue,  2 Jul 2024 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940033; cv=none; b=BELfUwmWaEtrhB2upLOfVdlQr7Bp7lwbqIclSGouUPQE8cUJwkSD1EtbAYHO+pOuWqWtmri99Nl7+WzK3t+sA4TkBWxGvXtb8VcUxBvvudp9D8/ywP60nDo+F2kj5ABk3gdfat+1MlnSBXNopDPoW/IZYxn1efzJJHXOteRoS0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940033; c=relaxed/simple;
	bh=Os3qFv+l2R8GoLtH9D3QP9XQc72tnYQsxvIloXyaDjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdYJeMbgIB14udk5d07H4kJSpQfLJzURsxfsWxDeDLiiwz6PQ+9inFFCZjKkGFBch+2r0TRjgU4FlgkH9ZEtGcmnd5DS8+rHAhB6OGZlYhOf/7fX5DZeW4Vidr28KEGiUgcGWsQLFrVuNJVn6mUt27TxSlpeYZyZQbiCDgeUK94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HxRMgQ2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43A6C116B1;
	Tue,  2 Jul 2024 17:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940033;
	bh=Os3qFv+l2R8GoLtH9D3QP9XQc72tnYQsxvIloXyaDjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HxRMgQ2kwMqLGdbKZ07cjPJ/n+SIP921fSfvSNFBzpACvyj5ebP2b3IhRvuHjTU1x
	 dM8CfmKw9j44/+xfmlfgyIZ2esDrpyQRXp3ITuffc3bCtj54ibWFluPRQTfqzNRRap
	 YNdaKIvHtlWobdnbbetnyJHZaAobux7ypScarAa8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liang Li <liali@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 032/222] bonding: fix incorrect software timestamping report
Date: Tue,  2 Jul 2024 19:01:10 +0200
Message-ID: <20240702170245.205400213@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>
References: <20240702170243.963426416@linuxfoundation.org>
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

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit a95b031c6796bf9972da2d4b4b524a57734f3a0a ]

The __ethtool_get_ts_info function returns directly if the device has a
get_ts_info() method. For bonding with an active slave, this works correctly
as we simply return the real device's timestamping information. However,
when there is no active slave, we only check the slave's TX software
timestamp information. We still need to set the phc index and RX timestamp
information manually. Otherwise, the result will be look like:

  Time stamping parameters for bond0:
  Capabilities:
          software-transmit
  PTP Hardware Clock: 0
  Hardware Transmit Timestamp Modes: none
  Hardware Receive Filter Modes: none

This issue does not affect VLAN or MACVLAN devices, as they only have one
downlink and can directly use the downlink's timestamping information.

Fixes: b8768dc40777 ("net: ethtool: Refactor identical get_ts_info implementations.")
Reported-by: Liang Li <liali@redhat.com>
Closes: https://issues.redhat.com/browse/RHEL-42409
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index bceda85f0dcf6..cb66310c8d76b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5773,6 +5773,9 @@ static int bond_ethtool_get_ts_info(struct net_device *bond_dev,
 	if (real_dev) {
 		ret = ethtool_get_ts_info_by_layer(real_dev, info);
 	} else {
+		info->phc_index = -1;
+		info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
+					SOF_TIMESTAMPING_SOFTWARE;
 		/* Check if all slaves support software tx timestamping */
 		rcu_read_lock();
 		bond_for_each_slave_rcu(bond, slave, iter) {
-- 
2.43.0




