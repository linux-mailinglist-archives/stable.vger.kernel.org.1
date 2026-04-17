Return-Path: <stable+bounces-238470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO6SLdb64Wn50AAAu9opvQ
	(envelope-from <stable+bounces-238470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 11:18:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2EE419278
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 11:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E40A03027312
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506E73AD502;
	Fri, 17 Apr 2026 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="dc+T+LvX"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73D53822B1
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776417489; cv=none; b=bfdrLim21Fd1T0QYnisdtD+6rVtLYAWmkBHPLbSVvUl3lanbq6ASFOW/EL0FYkyJcsBkRpH8aixU7dZ5W09i2jpCKurOLQS187HWOI2tUj6qFZx33dmmqKX1QEI15FuW501aRv6C8ee2ud8cjXwWK4T3l+o0U1CzHPM0MF/SQj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776417489; c=relaxed/simple;
	bh=l/VsInp3cv5Y2ECuouOOnaCEWrth9QJ1JX3CLUiPCew=;
	h=From:To:Subject:Date:Message-Id; b=QsvK+rWmj9nADo6A2fHRFrSGo2xRKe23gXQUJXHcG8u8DDJRVgG61aN3sCcMerZJPE5csTGJhPrBrC+VF6+nrIrACqn6MrPWU2CJA1VI2kQPZw0R+Tfpp0J17vGrFkfSDd5Xtl+m8aT5rTNTOIziuq5BXepZF2DxIcwFRTX/Hz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=dc+T+LvX; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=dc+T+LvXCwbFfJ7Hda+PHZLx50DY2lJOqD+Indhm83fsD48C0d+2yRS2/pQscmzHKdIXwCue7aWI5
	 Hgi9NvoRWnKA+CwKWnaPWPJsnz392crdB2Lj7WxWrb6XswDxMUWdODPNa1gYecZCxzV6Qm1XiqRryj
	 Nd9ibfYx+abzv5S8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[183.241.248.246])
	by rmsmtp-lg-appmail-02-12080 (RichMail) with SMTP id 2f3069e1fac6f02-29b69;
	Fri, 17 Apr 2026 17:17:59 +0800 (CST)
X-RM-TRANSID:2f3069e1fac6f02-29b69
From: Rajani Kantha <681739313@139.com>
To: zilin@seu.edu.cn,
	pmenzel@molgen.mpg.de,
	aleksandr.loktionov@intel.com,
	sx.rinitha@intel.com,
	anthony.l.nguyen@intel.com,
	stable@vger.kernel.org
Subject: [PATCH 6.6.y] ice: Fix memory leak in ice_set_ringparam()
Date: Fri, 17 Apr 2026 17:17:53 +0800
Message-Id: <20260417091753.4175-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238470-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[139.com];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	NEURAL_SPAM(0.00)[0.889];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[681739313@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,139.com:mid,139.com:email]
X-Rspamd-Queue-Id: 4E2EE419278
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit fe868b499d16f55bbeea89992edb98043c9de416 ]

In ice_set_ringparam, tx_rings and xdp_rings are allocated before
rx_rings. If the allocation of rx_rings fails, the code jumps to
the done label leaking both tx_rings and xdp_rings. Furthermore, if
the setup of an individual Rx ring fails during the loop, the code jumps
to the free_tx label which releases tx_rings but leaks xdp_rings.

Fix this by introducing a free_xdp label and updating the error paths to
ensure both xdp_rings and tx_rings are properly freed if rx_rings
allocation or setup fails.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
Fixes: efc2214b6047 ("ice: Add support for XDP")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 448ca855df90..c254484e9b6b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2847,7 +2847,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 	rx_rings = kcalloc(vsi->num_rxq, sizeof(*rx_rings), GFP_KERNEL);
 	if (!rx_rings) {
 		err = -ENOMEM;
-		goto done;
+		goto free_xdp;
 	}
 
 	ice_for_each_rxq(vsi, i) {
@@ -2877,7 +2877,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 			}
 			kfree(rx_rings);
 			err = -ENOMEM;
-			goto free_tx;
+			goto free_xdp;
 		}
 	}
 
@@ -2928,6 +2928,13 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 	}
 	goto done;
 
+free_xdp:
+	if (xdp_rings) {
+		ice_for_each_xdp_txq(vsi, i)
+			ice_free_tx_ring(&xdp_rings[i]);
+		kfree(xdp_rings);
+	}
+
 free_tx:
 	/* error cleanup if the Rx allocations failed after getting Tx */
 	if (tx_rings) {
-- 
2.17.1



