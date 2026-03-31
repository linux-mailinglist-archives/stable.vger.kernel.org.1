Return-Path: <stable+bounces-232062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIbkFAz9y2naNAYAu9opvQ
	(envelope-from <stable+bounces-232062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:57:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CC336D84B
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92FAA30224C5
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0769413225;
	Tue, 31 Mar 2026 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cNTGM/eS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A357C2C15B2;
	Tue, 31 Mar 2026 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975777; cv=none; b=PRQZm/Sd/KZaXFI7/6bZAWoFRASt1lJvW0+jAXwcQ7vkUvzSeuuWqNrWUbWPTTGCJJsnUe9UyjTLQf7Tbju4driW/M8YYlw4rqckHqG/vliud0khHCPlgjX/perX8LDh6k5QpRAvplV1/EEfbRRXfMpwNLgavVJXL1lYdpx8N4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975777; c=relaxed/simple;
	bh=DUcM354bLPMx2KxbgheHEXO0/w3Zlgu4JhxNAZ+4+G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZPNqDgv73vmIdIOhgoG1lujbw3GOeQcqN73ZP12XqifyXPlbZlyYL8xPSOP5rVqSp/LkXXBT17XWETVuDjxzjAth0gBihojAu8eDDdGppF3/XVmkvn15SBtVGp0uJUi3us9lZ9CoymS9vRevfW0OPSIWV0r8VwVjeCvsy+33HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cNTGM/eS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0323DC19423;
	Tue, 31 Mar 2026 16:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975777;
	bh=DUcM354bLPMx2KxbgheHEXO0/w3Zlgu4JhxNAZ+4+G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cNTGM/eSLCY9JMInYg2dA9WkQvSkAIA5t5ymtWP1bvBdoWfucNEGcahv5k2G/CiBp
	 9S4Y9+WzalQVbRGi5CKvVW9i/uM6AGf9VpNCz4B52Q6bR6mIOfbUIC7Nk0Fi1619Tq
	 62hBW6Qh4h9BAaIwpgQT/UWSiRlLzGI495aFlwHs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Oros <poros@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Patryk Holda <patryk.holda@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 083/244] ice: use ice_update_eth_stats() for representor stats
Date: Tue, 31 Mar 2026 18:20:33 +0200
Message-ID: <20260331161744.747072877@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232062-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: E3CC336D84B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Oros <poros@redhat.com>

[ Upstream commit 2526e440df2725e7328d59b835a164826f179b93 ]

ice_repr_get_stats64() and __ice_get_ethtool_stats() call
ice_update_vsi_stats() on the VF's src_vsi. This always returns early
because ICE_VSI_DOWN is permanently set for VF VSIs - ice_up() is never
called on them since queues are managed by iavf through virtchnl.

In __ice_get_ethtool_stats() the original code called
ice_update_vsi_stats() for all VSIs including representors, iterated
over ice_gstrings_vsi_stats[] to populate the data, and then bailed out
with an early return before the per-queue ring stats section. That early
return was necessary because representor VSIs have no rings on the PF
side - the rings belong to the VF driver (iavf), so accessing per-queue
stats would be invalid.

Move the representor handling to the top of __ice_get_ethtool_stats()
and call ice_update_eth_stats() directly to read the hardware GLV_*
counters. This matches ice_get_vf_stats() which already uses
ice_update_eth_stats() for the same VF VSI in legacy mode. Apply the
same fix to ice_repr_get_stats64().

Note that ice_gstrings_vsi_stats[] contains five software ring counters
(rx_buf_failed, rx_page_failed, tx_linearize, tx_busy, tx_restart) that
are always zero for representors since the PF never processes packets on
VF rings. This is pre-existing behavior unchanged by this patch.

Fixes: 7aae80cef7ba ("ice: add port representor ethtool ops and stats")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Patryk Holda <patryk.holda@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 14 +++++++++++---
 drivers/net/ethernet/intel/ice/ice_repr.c    |  3 ++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index b2183d5670b8c..606994fa99da9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1930,6 +1930,17 @@ __ice_get_ethtool_stats(struct net_device *netdev,
 	int i = 0;
 	char *p;
 
+	if (ice_is_port_repr_netdev(netdev)) {
+		ice_update_eth_stats(vsi);
+
+		for (j = 0; j < ICE_VSI_STATS_LEN; j++) {
+			p = (char *)vsi + ice_gstrings_vsi_stats[j].stat_offset;
+			data[i++] = (ice_gstrings_vsi_stats[j].sizeof_stat ==
+				     sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
+		}
+		return;
+	}
+
 	ice_update_pf_stats(pf);
 	ice_update_vsi_stats(vsi);
 
@@ -1939,9 +1950,6 @@ __ice_get_ethtool_stats(struct net_device *netdev,
 			     sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
 	}
 
-	if (ice_is_port_repr_netdev(netdev))
-		return;
-
 	/* populate per queue stats */
 	rcu_read_lock();
 
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 1b1288d243248..e8a9b6a5dd7ab 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2019-2021, Intel Corporation. */
 
 #include "ice.h"
+#include "ice_lib.h"
 #include "ice_eswitch.h"
 #include "devlink/devlink.h"
 #include "devlink/devlink_port.h"
@@ -67,7 +68,7 @@ ice_repr_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
 		return;
 	vsi = repr->src_vsi;
 
-	ice_update_vsi_stats(vsi);
+	ice_update_eth_stats(vsi);
 	eth_stats = &vsi->eth_stats;
 
 	stats->tx_packets = eth_stats->tx_unicast + eth_stats->tx_broadcast +
-- 
2.51.0




