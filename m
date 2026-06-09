Return-Path: <stable+bounces-262284-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JCzWGGsPKGom9QIAu9opvQ
	(envelope-from <stable+bounces-262284-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 15:04:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C46046605BB
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 15:04:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=O9vUur46;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262284-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262284-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A78BB31D41B5
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7EB425CF5;
	Tue,  9 Jun 2026 12:50:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m8131.xmail.ntesmail.com (mail-m8131.xmail.ntesmail.com [156.224.81.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88EA3A9616;
	Tue,  9 Jun 2026 12:50:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009437; cv=none; b=un0Wh0Y9t1iyvZkGBMimbnGsOuIYINmgdGd47TTKRZPS8cCwyTWGGSo1/1FHVKLKgPHTqZpcoFbhOa46FQxa7lwvQYRmmDwxJ+WBe7h2UfN3EZjMYf7w8L7WqBybsNt5TSEnW9xbjAyAUyNkc+cjQEWL2Vp3IUBbKd2mjYGMw9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009437; c=relaxed/simple;
	bh=M7MuFBvFvOPVdHC4KkWz5wwYNVEMbppPjZZ3N2uEGM8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MBDmQSwoSgghlk5m5dAHK8Mklp88Zy0Zv0HPuQQHuKcseHzdwFOSiSqZ6qNuCatbL0lsujTaVgyLcBMyioJwDLayW9JoDJcfjoUUKW7YTEOobagmtJj34DZVYb4+5L9CAv6x2IpIFF/DdREYh2HtI9/AdtbHv2oDyUrnK3rK7ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=O9vUur46; arc=none smtp.client-ip=156.224.81.31
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 41af408e8;
	Tue, 9 Jun 2026 20:50:22 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net] ice: fix memory leak in ice_lbtest_prepare_rings()
Date: Tue,  9 Jun 2026 20:50:21 +0800
Message-Id: <20260609125021.3873270-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eac6f180803a2kunm9425b504132c7c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZT0saVk4fShpDTBpKGkMdQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=O9vUur46oTC1cMJOEpOFA+tVhmsQ4ivwwCKVAfk04gRbshq+Udvg6oH7HOK6sdDddR+SAmFWnVMA1ahkwmOctQXsewU/xkdKvQBjDEVO3Hg3aWa0qhuYUC0T6hbTPgbzkrcRdT9ygJs0R6NjIK7S5kbqE5QTWF5Pio8C16Adt64=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=gDFkhjOKI1BsP8BXzapJ6Ptm02LVwzRDI7vFZnvGtaI=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:dawei.feng@seu.edu.cn,m:stable@vger.kernel.org,m:zilin@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262284-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C46046605BB

While ice_lbtest_prepare_rings() correctly frees Rx rings if
ice_vsi_start_all_rx_rings() fails, the earlier error paths for
ice_vsi_setup_rx_rings() and ice_vsi_cfg_lan() jump past this cleanup.
If Rx ring setup or LAN configuration fails, the function leaks the
initialized Rx resources.

Fix this by routing these earlier failures to the existing
err_start_rx_ring label. This ensures the Rx rings are properly freed
before tearing down the Tx state.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc5.

An x86_64 allyesconfig build showed no new warnings. As we do not have an
Intel E800 Series adapter available to run the ethtool offline loopback
selftest, no runtime testing was able to be performed.

Fixes: 0e674aeb0b77 ("ice: Add handler for ethtool selftest")
Cc: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index f28416a707d7..7c81ca313645 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1065,11 +1065,11 @@ static int ice_lbtest_prepare_rings(struct ice_vsi *vsi)
 
 	status = ice_vsi_setup_rx_rings(vsi);
 	if (status)
-		goto err_setup_rx_ring;
+		goto err_start_rx_ring;
 
 	status = ice_vsi_cfg_lan(vsi);
 	if (status)
-		goto err_setup_rx_ring;
+		goto err_start_rx_ring;
 
 	status = ice_vsi_start_all_rx_rings(vsi);
 	if (status)
@@ -1079,7 +1079,6 @@ static int ice_lbtest_prepare_rings(struct ice_vsi *vsi)
 
 err_start_rx_ring:
 	ice_vsi_free_rx_rings(vsi);
-err_setup_rx_ring:
 	ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, 0);
 err_setup_tx_ring:
 	ice_vsi_free_tx_rings(vsi);
-- 
2.34.1


