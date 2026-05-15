Return-Path: <stable+bounces-248891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL2jAf5kB2qE1gIAu9opvQ
	(envelope-from <stable+bounces-248891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:25:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E22D2556238
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3997E3005AA5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356C030C164;
	Fri, 15 May 2026 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tb3uBGP6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E47330C172;
	Fri, 15 May 2026 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869470; cv=none; b=GZD5AdDjER0EAi29jywUkILVgJvrz5AAaNlpeV8TWtMxwdyj17CvqMYEMBChIeM66Utx54IKS2IaMBPC0UjBrPcVoXxgYW1cmmNhdy9TwDlG2jAMXOjzaJdf1yceT2QlPiJg91dzjH5F2eRCxr5Icnmj3KalUS7lYwXXERXFGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869470; c=relaxed/simple;
	bh=mNXewhxHiQCVS/xDwKifIZWo/oiq5zGz7/91I73Tv00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ypl2z2vwuf68q+CVFxXGJo2yHuJyw7eTOfKcC4MscuL6sQ0OwIL22D3VveIP/TmDYPtZd+fwFVfJy0ICKx8tTf6TTXGkbIHdWnWazrwQ6FWBexptFiqSpZz84hTVuTUbxuyv72UywEGt00/RDGWm9l7QY07JfNDvfasHzLw9hr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tb3uBGP6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778869469; x=1810405469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mNXewhxHiQCVS/xDwKifIZWo/oiq5zGz7/91I73Tv00=;
  b=Tb3uBGP6DSwjD1erg2QvlFtJSgpg08XpzTSDaPdKVipk2HpbSR8oQedO
   roYVI/SP3jM2oF0MuK+iR5eCtPKHUXEtWQpdi05AG8QEnfmlZ0oxZSWEP
   2zB/t8ecjOOGGM20w4okghCey9whJPXfeyd2rPuQbDF2+9qV2VItyGuiu
   2avnt7uCpwHd5q2YD5bFSb84SzzWkXb2VR2gfHi+Yuz/K3FbP+CSTCgWz
   Klfmkxa+A0HLwcE83aIPT+qdbwrtQgAyLM8ZMi7yfDaLv/o19LdLTWcLL
   81pAHZq3Wc2S2lpiTR/iFu4nfseGu0TXPWuqgtGXJNGmNcqXZq2cUD2vQ
   g==;
X-CSE-ConnectionGUID: jTgPZV0yRciSzCwFwaGAfg==
X-CSE-MsgGUID: Wzu0TxcnTLmgA2YJfW6Z6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="83701140"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="83701140"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 11:24:27 -0700
X-CSE-ConnectionGUID: 0E/tz6ZPQ32e9roJyCBSlg==
X-CSE-MsgGUID: ONxzxQcdRdqnqMXSo+iyJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="238647442"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 15 May 2026 11:24:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@intel.com>,
	anthony.l.nguyen@intel.com,
	ivecera@redhat.com,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 03/10] ice: fix setting promisc mode while adding VID filter
Date: Fri, 15 May 2026 11:24:10 -0700
Message-ID: <20260515182419.1597859-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260515182419.1597859-1-anthony.l.nguyen@intel.com>
References: <20260515182419.1597859-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E22D2556238
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248891-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Marcin Szycik <marcin.szycik@intel.com>

There are at least two paths through which VSI promiscuous mode can be
independently configured via ice_fltr_set_vsi_promisc():
- ice_vlan_rx_add_vid() (netdev op)
- ice_service_task() -> ... -> ice_set_promisc()

Both paths may try to program promiscuous mode concurrently. One such
scenario is:

1. Add ice netdev to bond
2. Add the bond netdev to bridge
3. ice netdev enters allmulticast mode (IFF_ALLMULTI)
4. Service task programs promisc mode filter
5. Bridge -> bond calls ice_vlan_rx_add_vid()

Crucially, ice_vlan_rx_add_vid() fails if ice_fltr_set_vsi_promisc()
returns any error, including -EEXIST. This causes VLAN filtering setup
to fail on the bond interface. ice_set_promisc() already handles -EEXIST
correctly.

Fix by adding the same -EEXIST check to ice_vlan_rx_add_vid(): if the
promisc filter is already programmed, continue without returning error.

Fixes: 1273f89578f2 ("ice: Fix broken IFF_ALLMULTI handling")
Cc: stable@vger.kernel.org
Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c52c465280f7..66642232b282 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3682,7 +3682,7 @@ int ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
 		ret = ice_fltr_set_vsi_promisc(&vsi->back->hw, vsi->idx,
 					       ICE_MCAST_VLAN_PROMISC_BITS,
 					       vid);
-		if (ret)
+		if (ret && ret != -EEXIST)
 			goto finish;
 	}
 
-- 
2.47.1


