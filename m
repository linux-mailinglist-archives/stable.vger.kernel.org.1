Return-Path: <stable+bounces-257238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGk+LXQZG2pV/AgAu9opvQ
	(envelope-from <stable+bounces-257238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:08:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 119FD60EEF3
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5198430C5566
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E6B33F5A3;
	Sat, 30 May 2026 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DxoWMZfc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969BF2E92B3;
	Sat, 30 May 2026 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160297; cv=none; b=uFDPbToeGAIuzMoS8pfG9K7zVaBtZY97yyVyiCCEjsiYoeZU8BFLtuN0exiUxUabRxY60tv6vKBghcYKwExehQ7xrLiL5xduu9mibCr0mTWlEaOAyNkNKwCMXjQQzaqJk6nVC/d618/4QZG04GVD1U+Ev7+azwAjMNdudoyCt/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160297; c=relaxed/simple;
	bh=mnSeUUDroYhjOCRNP5neHL4zAQ7x2yOjCONEO979UEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/j0vFYwL4wYXp/G35B2Gl2gemTaQo5FEciTZvSdhUk5XpDhuvYDe+2z8BoaF0kLXT+ajBVjoeie2NKgX+A9mGRoMXvDJgq74lbLuTOV+MemvcsU8veUrk3gm9lDB4ZTa4kBMP9u1CsGf4jmhUbdtJtK+qAsWAWPD6dpKGJpE9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DxoWMZfc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA06B1F00893;
	Sat, 30 May 2026 16:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160296;
	bh=b+ipQM2fc+p9CHiPW2Tmit4I0+7Cd5YTylV1yBDTNAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DxoWMZfc0MtCDky9tlb2qm3AfHKMCwYf8JuDUQCyaEgFNsHsr9Kav+x3hCA5SaGu9
	 aMDUvydOp7bHoOm6z6aAE55XbfpT5D+VOzVZqX4sgtB5oSB42yq0mflQVzEFhIT7ZB
	 DtyR16UuHWq0viuEBFvawBdzJ1bTD86RAOhGCIXo=
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
Subject: [PATCH 6.1 298/969] ice: Fix memory leak in ice_set_ringparam()
Date: Sat, 30 May 2026 17:57:02 +0200
Message-ID: <20260530160308.670180238@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-257238-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,seu.edu.cn,molgen.mpg.de,intel.com,139.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 119FD60EEF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 49c524304a412..7774292a5bdbe 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2891,7 +2891,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 	rx_rings = kcalloc(vsi->num_rxq, sizeof(*rx_rings), GFP_KERNEL);
 	if (!rx_rings) {
 		err = -ENOMEM;
-		goto done;
+		goto free_xdp;
 	}
 
 	ice_for_each_rxq(vsi, i) {
@@ -2921,7 +2921,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 			}
 			kfree(rx_rings);
 			err = -ENOMEM;
-			goto free_tx;
+			goto free_xdp;
 		}
 	}
 
@@ -2972,6 +2972,13 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
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




