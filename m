Return-Path: <stable+bounces-263885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZXeFKwRqMWoYiwUAu9opvQ
	(envelope-from <stable+bounces-263885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:21:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40325690F59
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:21:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=sDS5goOJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263885-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263885-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54C7E30780E6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB5743E48B;
	Tue, 16 Jun 2026 15:16:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7E543C05C;
	Tue, 16 Jun 2026 15:16:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622984; cv=none; b=tpKFU7kIZU9XzE6c4YVisr+iL8DVT9wUGAii67CYXMI1JcFGfGtC1DaALSwilMbrFa75VrYBh1jH1ApuNU0/xw45tmoM1Juw9biu6iw90otT361rdIc8RDzD2rN+b+amv+3vxXDi44D/wupiS5WfSEyDy4BD1jy2lQ1Wf4sNHcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622984; c=relaxed/simple;
	bh=qKC8cIO2kLpoY934Q83ztY47FmNoj201Q7v73aXj6EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNSVKmh41cSNE3MURHm0KnsCxM+IC4/5TXxm4+ZngybA+MLNvMZKJ5BeMZcarEoNMS2uUEIt3rsQ/k2un4vxVyCMiSJK9tL9PLvy1m1+8YyT+VnkNGsDyIa/vusLZtyMz7yIG9xkhHRsJcAu1d7MSvvP9Tq386uNNPdBiYL7vjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sDS5goOJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7D41F000E9;
	Tue, 16 Jun 2026 15:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781622983;
	bh=thJr+uokrH1vdBDdq4kGM7lhoeiUzc+c2H8Np2tWDq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sDS5goOJUJjJ1krlEVyheRwrUZuJ2dPdaHyQkpVx4w8M2hSbQ0iqH+JBAiIxzZ5AL
	 n8X5ucNPKwbngfUjd2rHOsWWnAf5k9v5XvINQCZFBLPpDaSdJ65PFh/6hGGtuWtqJ3
	 qTf7eqi+Rpodvr5yczeklVKlntnT8R+Ktwb/1zp8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 065/378] octeontx2-af: npc: Fix CPT channel mask in npc_install_flow
Date: Tue, 16 Jun 2026 20:24:56 +0530
Message-ID: <20260616145113.446621065@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263885-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:naveenm@marvell.com,m:ndabilpuram@marvell.com,m:rkannoth@marvell.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40325690F59

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

[ Upstream commit 1d31eb27e570daa04f5373345f9ac98c95863be9 ]

Use the CPT-aware NIX channel mask in the npc_install_flow path so that
when the host PF installs steering rules in kernel for a VF used from
userspace (e.g. DPDK), MCAM entries see the same channel mask semantics as
other RX paths.

Fixes: 56bcef528bd8 ("octeontx2-af: Use npc_install_flow API for promisc and broadcast entries")
Cc: Naveen Mamindlapalli <naveenm@marvell.com>
Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
Link: https://patch.msgid.link/20260602045853.1558530-1-rkannoth@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  1 +
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 32 +++++++++----------
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  2 +-
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 3f76ec6c5cf3b9..e31d7bc4a0e9c2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -1138,6 +1138,7 @@ int rvu_cpt_lf_teardown(struct rvu *rvu, u16 pcifunc, int blkaddr, int lf,
 			int slot);
 int rvu_cpt_ctx_flush(struct rvu *rvu, u16 pcifunc);
 int rvu_cpt_init(struct rvu *rvu);
+u32 rvu_get_cpt_chan_mask(struct rvu *rvu);
 
 #define NDC_AF_BANK_MASK       GENMASK_ULL(7, 0)
 #define NDC_AF_BANK_LINE_MASK  GENMASK_ULL(31, 16)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index a0d2ed56186d8d..65aa6aeab8e782 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -599,6 +599,19 @@ void npc_set_mcam_action(struct rvu *rvu, struct npc_mcam *mcam,
 			   NPC_AF_MCAMEX_BANKX_ACTION(index, bank), cfg);
 }
 
+u32 rvu_get_cpt_chan_mask(struct rvu *rvu)
+{
+	/* For cn10k the upper two bits of the channel number are
+	 * cpt channel number. with masking out these bits in the
+	 * mcam entry, same entry used for NIX will allow packets
+	 * received from cpt for parsing.
+	 */
+	if (!is_rvu_otx2(rvu))
+		return NIX_CHAN_CPT_X2P_MASK;
+	else
+		return 0xFFFu;
+}
+
 void rvu_npc_install_ucast_entry(struct rvu *rvu, u16 pcifunc,
 				 int nixlf, u64 chan, u8 *mac_addr)
 {
@@ -642,7 +655,7 @@ void rvu_npc_install_ucast_entry(struct rvu *rvu, u16 pcifunc,
 	eth_broadcast_addr((u8 *)&req.mask.dmac);
 	req.features = BIT_ULL(NPC_DMAC);
 	req.channel = chan;
-	req.chan_mask = 0xFFFU;
+	req.chan_mask = rvu_get_cpt_chan_mask(rvu);
 	req.intf = pfvf->nix_rx_intf;
 	req.op = action.op;
 	req.hdr.pcifunc = 0; /* AF is requester */
@@ -712,11 +725,7 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
 	 * mcam entry, same entry used for NIX will allow packets
 	 * received from cpt for parsing.
 	 */
-	if (!is_rvu_otx2(rvu)) {
-		req.chan_mask = NIX_CHAN_CPT_X2P_MASK;
-	} else {
-		req.chan_mask = 0xFFFU;
-	}
+	req.chan_mask = rvu_get_cpt_chan_mask(rvu);
 
 	if (chan_cnt > 1) {
 		if (!is_power_of_2(chan_cnt)) {
@@ -887,16 +896,7 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 	ether_addr_copy(req.mask.dmac, mac_addr);
 	req.features = BIT_ULL(NPC_DMAC);
 
-	/* For cn10k the upper two bits of the channel number are
-	 * cpt channel number. with masking out these bits in the
-	 * mcam entry, same entry used for NIX will allow packets
-	 * received from cpt for parsing.
-	 */
-	if (!is_rvu_otx2(rvu))
-		req.chan_mask = NIX_CHAN_CPT_X2P_MASK;
-	else
-		req.chan_mask = 0xFFFU;
-
+	req.chan_mask = rvu_get_cpt_chan_mask(rvu);
 	req.channel = chan;
 	req.intf = pfvf->nix_rx_intf;
 	req.entry = index;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 1930b54e72f219..02663530368965 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1470,7 +1470,7 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 
 	/* ignore chan_mask in case pf func is not AF, revisit later */
 	if (!is_pffunc_af(req->hdr.pcifunc))
-		req->chan_mask = 0xFFF;
+		req->chan_mask = rvu_get_cpt_chan_mask(rvu);
 
 	err = npc_check_unsupported_flows(rvu, req->features, req->intf);
 	if (err)
-- 
2.53.0




