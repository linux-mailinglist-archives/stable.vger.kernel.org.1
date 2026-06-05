Return-Path: <stable+bounces-260689-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i0ESLO7JImrcdgEAu9opvQ
	(envelope-from <stable+bounces-260689-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 15:06:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A635A648653
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 15:06:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="hzw/zUAZ";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260689-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260689-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C24E1301E41F
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 13:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A773659FB;
	Fri,  5 Jun 2026 12:59:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC1C29C325
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 12:59:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664397; cv=none; b=da3Z6GKYJmvTlBe2Ph39pXuY2ZUOCG12QmR6q5d5ml420pNC/HA7JKmKGfrRIQAPDkfb3gB1w9b2sAhXFq5tjE2DdoSpATsBjoNxw/I1Mv+PSeln/1HahNOxEP3aEIbZRWrvh2p5SuyGdZSU2pDlzB29Mv57x+y5vmEccnvJXRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664397; c=relaxed/simple;
	bh=MDYEVmmQv5JXRpTzTDDGmbfOYh3w0drWXj5n7XRlGbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4zuTbzZSUk6kA0GMTRRNC3VZMbYd3DW62hhUZQZY1TF4vS3Nhrqa2yjPhOTkvCBYDnnvrxcsxCXkGIvRUferQYi8kKHIGTInf4oyNSGvwHCnZsufyzMTHoFypSm1dxgIb9EUmRa4c04mwat1c84OZCg8os0Y4bT+ly6TxRzvdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzw/zUAZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF88D1F00893;
	Fri,  5 Jun 2026 12:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780664396;
	bh=ll0OmWyirpXNmHHp89ggJN1WGowPOc2ATDZGSJhgKUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hzw/zUAZPvkxRkpNqB2KWfb+j5ceFsYtKT3wPiNJjxxG0SRtbzuCyFH3HkAWIM6Ra
	 4S5HYS92VRIwdQCx2ArL2fJx1G6533sFRXZ6mntFTZhWW4uySckydbuC7rUrKuLCsJ
	 NAZ0ujtpF8njLr8qlZp3IVvpXFPFRdgck2CipUZM1z+ziw7ZulufTwAw2zztarKF+G
	 dmwoT0ziBSdSY1MsVi9ywMAIoOegKbD+qMbG2nWjRzq3B55JH2ePD4uPonQuh5ja/q
	 eLMS0ep+5ikDZiaicj39121+oR2RPSYAOjvOZCh5gd+HquPFD9x1zwGxT93EW1PSva
	 Z90HEBtkmNVhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shaomin Chen <eeesssooo020@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] xfrm: iptfs: reset runtime state when cloning SAs
Date: Fri,  5 Jun 2026 08:59:53 -0400
Message-ID: <20260605125953.366286-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060404-supply-unglazed-218f@gregkh>
References: <2026060404-supply-unglazed-218f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,secunet.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260689-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:eeesssooo020@gmail.com,m:steffen.klassert@secunet.com,m:sashal@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,secunet.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A635A648653

From: Shaomin Chen <eeesssooo020@gmail.com>

[ Upstream commit 7f83d174073234839aea176f265e517e0d50a1d2 ]

iptfs_clone_state() clones the IPTFS mode data with kmemdup(). This
copies runtime objects which must not be shared with the original SA,
including the embedded sk_buff_head, hrtimers, spinlock, and in-flight
reassembly/reorder state.

If xfrm_state_migrate() fails after clone_state() but before the later
init_state() call has reinitialized those fields, the cloned state can be
destroyed by xfrm_state_gc_task() with list and timer state copied from the
original SA. With queued packets this lets the clone splice and free skbs
owned by the original IPTFS queue, leading to use-after-free and
double-free reports in iptfs_destroy_state() and skb release paths.

Reinitialize the clone's runtime state before publishing it through
x->mode_data. Because clone_state() now publishes a destroyable mode_data
object before init_state(), take the mode callback module reference there.
Avoid taking it again from __iptfs_init_state() for the same object.

Fixes: 0e4fbf013fa5 ("xfrm: iptfs: add user packet (tunnel ingress) handling")
Cc: stable@vger.kernel.org
Signed-off-by: Shaomin Chen <eeesssooo020@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_iptfs.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 7cd97c1dcd1178..e11e4f7411fd25 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2650,7 +2650,8 @@ static void __iptfs_init_state(struct xfrm_state *x,
 	x->props.enc_hdr_len = sizeof(struct ip_iptfs_hdr);
 
 	/* Always keep a module reference when x->mode_data is set */
-	__module_get(x->mode_cbs->owner);
+	if (x->mode_data != xtfs)
+		__module_get(x->mode_cbs->owner);
 
 	x->mode_data = xtfs;
 	xtfs->x = x;
@@ -2658,22 +2659,40 @@ static void __iptfs_init_state(struct xfrm_state *x,
 
 static int iptfs_clone_state(struct xfrm_state *x, struct xfrm_state *orig)
 {
+	struct skb_wseq *w_saved = NULL;
 	struct xfrm_iptfs_data *xtfs;
 
 	xtfs = kmemdup(orig->mode_data, sizeof(*xtfs), GFP_KERNEL);
 	if (!xtfs)
 		return -ENOMEM;
 
-	xtfs->ra_newskb = NULL;
 	if (xtfs->cfg.reorder_win_size) {
-		xtfs->w_saved = kcalloc(xtfs->cfg.reorder_win_size,
-					sizeof(*xtfs->w_saved), GFP_KERNEL);
-		if (!xtfs->w_saved) {
+		w_saved = kcalloc(xtfs->cfg.reorder_win_size,
+				  sizeof(*w_saved), GFP_KERNEL);
+		if (!w_saved) {
 			kfree_sensitive(xtfs);
 			return -ENOMEM;
 		}
 	}
+	xtfs->w_saved = w_saved;
+
+	__skb_queue_head_init(&xtfs->queue);
+	xtfs->queue_size = 0;
+	hrtimer_setup(&xtfs->iptfs_timer, iptfs_delay_timer, CLOCK_MONOTONIC,
+		      IPTFS_HRTIMER_MODE);
+
+	spin_lock_init(&xtfs->drop_lock);
+	hrtimer_setup(&xtfs->drop_timer, iptfs_drop_timer, CLOCK_MONOTONIC,
+		      IPTFS_HRTIMER_MODE);
 
+	xtfs->w_seq_set = false;
+	xtfs->w_wantseq = 0;
+	xtfs->w_savedlen = 0;
+	xtfs->ra_newskb = NULL;
+	xtfs->ra_wantseq = 0;
+	xtfs->ra_runtlen = 0;
+
+	__module_get(x->mode_cbs->owner);
 	x->mode_data = xtfs;
 	xtfs->x = x;
 
-- 
2.53.0


