Return-Path: <stable+bounces-229086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHPhCRZswWlMTAQAu9opvQ
	(envelope-from <stable+bounces-229086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:36:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD382F86CA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C79EE30F74B4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD35246BD5;
	Mon, 23 Mar 2026 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uo2tjt6b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF4242D70;
	Mon, 23 Mar 2026 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278016; cv=none; b=XQju7O34Pgn3ibIUlAENkDMsTmCLQZthldBre7AWk7o997xpA70FN4g7zElgGrSoZTTiB49vyf1LABvP6UISPDuuE0CfcT5Zc69GC1QT2zNYEAaXtQVk5Z0e0Oir6C5FKZ2cMpH0YU0EPQZij/dWi/A/hPcCmTtFNTw1TLmY3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278016; c=relaxed/simple;
	bh=V/7lWuIAdHNJejPMsicTHajl78RgYfGyLU1NZvKE9z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2+cqj9BABm9ukLnvEnJtmQeLlmiWy0ZP4z8AUQn8KX9T9ONIjGw50dO3gCY+H9hBkbCeOc55H4RrSZvChLdycXKLPzwMLEEV6PPYCM9m92V2DPGJJQYyNKFzqjA8FM6H2N0IJCurwSgGolFRM5tNiRgcQFGsfEnNng/TmOyeUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uo2tjt6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6E1C4CEF7;
	Mon, 23 Mar 2026 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278016;
	bh=V/7lWuIAdHNJejPMsicTHajl78RgYfGyLU1NZvKE9z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uo2tjt6bWdm1fuOcIaetiaCioQTH5P7XRVzawMenFOj106q66MJXTMGHKYcQ4b4Rt
	 FxdQ/JlI93FN0d+59fDmH7gmdeLm5Swd9JIwmyUA9gjIbtEwZQtMaTtBBFkGYE0arx
	 tiSCXsI+/y45xoE/nFRWkQTwyCuuZ82jtUDEVeqU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Valerio <pvalerio@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 173/567] net: ethernet: mtk_eth_soc: Reset prog ptr to old_prog in case of error in mtk_xdp_setup()
Date: Mon, 23 Mar 2026 14:41:33 +0100
Message-ID: <20260323134538.114660723@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229086-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6AD382F86CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 0abc73c8a40fd64ac1739c90bb4f42c418d27a5e ]

Reset eBPF program pointer to old_prog and do not decrease its ref-count
if mtk_open routine in mtk_xdp_setup() fails.

Fixes: 7c26c20da5d42 ("net: ethernet: mtk_eth_soc: add basic XDP support")
Suggested-by: Paolo Valerio <pvalerio@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20260303-mtk-xdp-prog-ptr-fix-v2-1-97b6dbbe240f@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index c843e6531449b..e2d3bda1dc923 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3529,12 +3529,21 @@ static int mtk_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
 		mtk_stop(dev);
 
 	old_prog = rcu_replace_pointer(eth->prog, prog, lockdep_rtnl_is_held());
+
+	if (netif_running(dev) && need_update) {
+		int err;
+
+		err = mtk_open(dev);
+		if (err) {
+			rcu_assign_pointer(eth->prog, old_prog);
+
+			return err;
+		}
+	}
+
 	if (old_prog)
 		bpf_prog_put(old_prog);
 
-	if (netif_running(dev) && need_update)
-		return mtk_open(dev);
-
 	return 0;
 }
 
-- 
2.51.0




