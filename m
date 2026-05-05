Return-Path: <stable+bounces-243979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL2qC0l9+WmZ9AIAu9opvQ
	(envelope-from <stable+bounces-243979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:16:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E112C4C6C65
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2F55301AA5C
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049073CBE77;
	Tue,  5 May 2026 05:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bb+2xclN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36BD3C8700;
	Tue,  5 May 2026 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958146; cv=none; b=JzYOYCaou5WgvhFBFfmuLfvWKlnd5tewYfQI2ZkLW4j3L8Ct0jwADfo3RElma93F/DYJ9SW3bPj/HPaNstdZO0/D04yRf+L7+n1YQSPlDRgUqNX9cAYI2CahSm6ypeinXJhWtA0LiIxRDH+gz8FvKqLOJ06ZynYfdKIE/gkmm0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958146; c=relaxed/simple;
	bh=YLjFki62a5oOQqEFFf8SszsHR4sTr7mY8+C81ZB2tE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d2sXCzsSgvdje6sqU547ZX3tSkPUKubInK2PJCd4wztccESi9zULOLRc7FKC0Ybw/25JH5jKhL/y/Y5gW9Hzof7lKmKulWMCyq8jSBOaP2zyKlRj27/dE8TCsFlbt6WzWXX+2AMfDSLLUEMbKin6izvMTklQVc371tJxsRp2NRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bb+2xclN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777958145; x=1809494145;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=YLjFki62a5oOQqEFFf8SszsHR4sTr7mY8+C81ZB2tE8=;
  b=Bb+2xclNRCt/saQCqycaapYTkiOVEn2TR6wA7g5u5PIxWx6vVam1lxS7
   PJpuCy2TVhoXpfiQax5AXSanKrAl5hJHyHpW3lMapx79HoejDD9IRXCBA
   VRaGV5HTfKg0w75MJBJobxKgCmZlOSMwGNkjuaCYMkj65eNhOwnL9atQJ
   i0U07n+cL5WWHoUKsmdr7ElgX4laZT1zIRtJQcmPS0tCvy4iMVmzE5Vji
   WXW26uMhy479aybBVFQykdDLnD0XnK9TaxMD3/WcKvUBlO2ZGQHcIngBz
   ennl7Fv+h0bay+w8xanykZhjT6ugV0OZ4+4/Jaa1rMNkk+rN4zpXYoNng
   w==;
X-CSE-ConnectionGUID: 5uT1qG6UQi2QW5GV8RR/7g==
X-CSE-MsgGUID: jXLXb776RWe6KvLw0zoEcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89126491"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89126491"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:38 -0700
X-CSE-ConnectionGUID: ewAyWPGgRuO01BBQHxsV+A==
X-CSE-MsgGUID: GHUg39z6SkemrUUKn6QCPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239683519"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:38 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 04 May 2026 22:14:24 -0700
Subject: [PATCH net 11/13] ice: fix PTP hang for E825C devices
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-jk-iwl-net-2026-05-04-v1-11-a222a88bd962@intel.com>
References: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
In-Reply-To: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Joshua Hay <joshua.a.hay@intel.com>, 
 Madhu Chittim <madhu.chittim@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Dave Ertman <david.m.ertman@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>, 
 Rinitha S <sx.rinitha@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2462;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=iI4ScMU3ILa3GIAQXZEqO3NlFEEDbS6ziZzKecX9dgc=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyfNd8Vl/5JnPxTeP3n4we2XWzh6nv3+EJpu7qtr1Nh2
 1Rpp4ryjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACby24vhD3egpVfUz42Z58rP
 p7YEL5lz1GeBFvu0+8Z9ZzK5uT2X7GX4Z7rzidB7gXhrq0/tPwPLX2xYdnWVnGmk/+OFr7PXBZ6
 axQUA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: E112C4C6C65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-243979-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

Change the order of PTP reconfiguration when port goes down or up
(ice_down and ice_up calls) to be more graceful and consistent from
timestamp interrupts processing perspective.

For both calls (ice_up and ice_down), accompanying ice_ptp_link_change
is called which starts/stops PTP timer. This patch changes the order:
- while link goes down: disable net device Tx first (netif_carrier_off,
  netif_tx_disable), then call ice_ptp_link_change
- while link goes up: ice_ptp_link_change called first, then re-enable
  net device Tx (netif_tx_start_all_queues)

Otherwise, there is a narrow window in which PTP timestamp request has
been triggered and timestamp processing occurs when PTP timer is not
enabled yet (up case) or already disabled (down case). This may lead to
undefined behavior and receiving invalid timestamps. This case was
observed on E825C devices only.

Fixes: 6b1ff5d39228 ("ice: always call ice_ptp_link_change and make it void")
Cc: stable@vger.kernel.org
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c52c465280f7..8cc9d0521988 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6732,10 +6732,10 @@ static int ice_up_complete(struct ice_vsi *vsi)
 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
 	    ((vsi->netdev && (vsi->type == ICE_VSI_PF ||
 			      vsi->type == ICE_VSI_SF)))) {
+		ice_ptp_link_change(pf, true);
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
-		ice_ptp_link_change(pf, true);
 	}
 
 	/* Perform an initial read of the statistics registers now to
@@ -7263,9 +7263,9 @@ int ice_down(struct ice_vsi *vsi)
 
 	if (vsi->netdev) {
 		vlan_err = ice_vsi_del_vlan_zero(vsi);
-		ice_ptp_link_change(vsi->back, false);
 		netif_carrier_off(vsi->netdev);
 		netif_tx_disable(vsi->netdev);
+		ice_ptp_link_change(vsi->back, false);
 	}
 
 	ice_vsi_dis_irq(vsi);

-- 
2.54.0.rc2.531.gaf818d63126a


