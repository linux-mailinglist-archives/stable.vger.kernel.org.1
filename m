Return-Path: <stable+bounces-232934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDkzF/oozmnIlQYAu9opvQ
	(envelope-from <stable+bounces-232934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:29:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B3A386053
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92DE4301AF49
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 08:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F272A3630A0;
	Thu,  2 Apr 2026 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="PZoC2sAc"
X-Original-To: stable@vger.kernel.org
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E1A35958
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775118360; cv=none; b=REqe4ofh/JK1DfOQ0SwHDYypuJI7nlUvCMh/TH/5ypXEn8gbkNEtKbb9fenv0mlLXUIoB5wwk71LDPjJq13eyPrJZ6yfUbsbF4B4BPPTVsOHqXUtdRme4rS812Kgskv4bueT9HNxSD+Wrkz5SGyGNSTpb67/4z8Ov2FF8khnlHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775118360; c=relaxed/simple;
	bh=kw74a7MVwzQ7G4joZG7CvrVIxxfwrN3W4C9eUeO6LLk=;
	h=From:To:Subject:Date:Message-Id; b=mF16BODrt7va/alxagIYB12blConPrw3av6kvHokshLPQ7Mz7zLKYcpGiqM56Qw20Bir7tSfHIMuJluD2m3n7xupi05pRAmbTGmzHhnpTdVtz5U34D1zV5p42vqxeLSKtpHbLfQayO/uD+B38ADvRRhr4Gs7TkjzjOrqOzDM6jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=PZoC2sAc; arc=none smtp.client-ip=120.232.169.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=PZoC2sAcBRlcfS1R6Ky8AcFC7iQtNkfg7btIu6GjfWaZsQAwaYOaPa3liH4W92fzxUGzvcUZMbs95
	 P4cVks7agAe4rolHlsJQHSgs1wa1wbK1JvsthEmoJgPtOMmUUKCETEOTajKBhWpKScOJy0NBuX/S+c
	 85sXVzFnM+otkpQI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[183.241.248.246])
	by rmsmtp-lg-appmail-22-12025 (RichMail) with SMTP id 2ef969ce273b095-7c830;
	Thu, 02 Apr 2026 16:22:21 +0800 (CST)
X-RM-TRANSID:2ef969ce273b095-7c830
From: Rajani Kantha <681739313@139.com>
To: zilin@seu.edu.cn,
	pmenzel@molgen.mpg.de,
	aleksandr.loktionov@intel.com,
	sx.rinitha@intel.com,
	anthony.l.nguyen@intel.com,
	stable@vger.kernel.org
Subject: [PATCH 6.12.y] ice: Fix memory leak in ice_set_ringparam()
Date: Thu,  2 Apr 2026 16:22:14 +0800
Message-Id: <20260402082214.17191-1-681739313@139.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232934-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[139.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[681739313@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mpg.de:email,139.com:email,139.com:mid,seu.edu.cn:email]
X-Rspamd-Queue-Id: 20B3A386053
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
index b2183d5670b8..337396d8beba 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3323,7 +3323,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 	rx_rings = kcalloc(vsi->num_rxq, sizeof(*rx_rings), GFP_KERNEL);
 	if (!rx_rings) {
 		err = -ENOMEM;
-		goto done;
+		goto free_xdp;
 	}
 
 	ice_for_each_rxq(vsi, i) {
@@ -3353,7 +3353,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 			}
 			kfree(rx_rings);
 			err = -ENOMEM;
-			goto free_tx;
+			goto free_xdp;
 		}
 	}
 
@@ -3404,6 +3404,13 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
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



