Return-Path: <stable+bounces-240809-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMfZKGFy62nCMwAAu9opvQ
	(envelope-from <stable+bounces-240809-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:38:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 137AB45F4C4
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62066300794D
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7763D6CC1;
	Fri, 24 Apr 2026 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cup2WaiL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A31D3D5643;
	Fri, 24 Apr 2026 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037896; cv=none; b=Ft01HdLSLz8Epv4sNQF+s1Hd5VDz2upe8byayUXM1ZYC6vvx/0lpxwKhm8udZODpDf1qdWkoeuInjiMHlZPGBZ27kKHPMfe6HJ7dxQXqkYUz/ZnwGOp/u6H8ftEAsfGMDofleatp1jV1L+bz0XYYEcqJaU86fjTIfmRWXcM8UkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037896; c=relaxed/simple;
	bh=myJgHMK+7iXJ+sojBp6GmkQ8JUX9BzPF58xDvlP65ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfTfv6rBFA1By/cEBIpjqktaKSq93PE3FsjplYoX3O6T/5lJXvngogvlcYLW5u/m3iz1NS1C44OldGNGQOV55vOCjosMAdh1qrBDvimAEtushOJJHJCvnfjM1sSWeiOFRlXKwpy4amQpylhkJoYlQ/uVki4houD/Gx7lxCHugy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cup2WaiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D731C19425;
	Fri, 24 Apr 2026 13:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037896;
	bh=myJgHMK+7iXJ+sojBp6GmkQ8JUX9BzPF58xDvlP65ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cup2WaiLMmukOwfwziFc2lgeaUDcJiBb+hSxluaJOG225kTKnoMLL7q5c3z09CK8W
	 LfCGsOASlhYwAVF7Fbb4P7JW9NbDHJpAgbXJ1jR0XB+Y0PWRu+dfbrtHuSO9K1CuI8
	 xIIhip1ikFiRyg6H7mBEr7ksImIkKTxm0G3nWO50=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zilin Guan <zilin@seu.edu.cn>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Rajani Kantha <681739313@139.com>,
	Sasha Levin <sashal@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH 6.6 111/166] ice: Fix memory leak in ice_set_ringparam()
Date: Fri, 24 Apr 2026 15:30:25 +0200
Message-ID: <20260424132556.013809668@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 137AB45F4C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,seu.edu.cn,molgen.mpg.de,intel.com,139.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-240809-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,139.com:email,seu.edu.cn:email,mpg.de:email]

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 448ca855df901..c254484e9b6b2 100644
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
2.53.0




