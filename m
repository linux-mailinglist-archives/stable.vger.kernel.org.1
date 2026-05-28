Return-Path: <stable+bounces-254962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAIiGFsvGGpwfggAu9opvQ
	(envelope-from <stable+bounces-254962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:04:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FDD5F1D2D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E336531532E4
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F1A3E63AF;
	Thu, 28 May 2026 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QAteKlCV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151B53E3156
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969501; cv=none; b=M7TgSPdt406o4uSUVSXOdlfc6iMXM4ruAH7BPu6wIziyp8zZZ2X396HXzRLyFVOAcDMe/J0jtwoQzPd7KlS0i27PdRA1FW7koR6GMaxu1bTU/quPpizxajaUxWz80VA9I7dq8zC7p2+Rh/X3fYXSlF+IOfyKPdqk269zIGBV6PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969501; c=relaxed/simple;
	bh=BrHoWyC5tCbmyoCj4dKfF6KMvvZmyJsHmbMuDQjiKos=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V9rg3RfJtjLCXU00tK+sCgRXX7LHx24rk//Hek708kCKY7NBFTEtWF5DIdUfTFhH+/D03G3A6KEMn0GsVJEvEl33tHVAwa5EblxcDU5gz6jPNkBrRb4tLE690RgP0Z0FuiuVgCTVgC10L60h+ZGaSvrrCsNQoDTAX1gOkLWTT1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QAteKlCV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3281F00A3D;
	Thu, 28 May 2026 11:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779969499;
	bh=ugIcO6H1D0NB9GJESOyNAYN4iLUjIH+/kv2eMm/eXi8=;
	h=Subject:To:Cc:From:Date;
	b=QAteKlCVp8lnld9cYL0FPH4uYphT27oz54CIO8tOexGrVh/8CEPN2gpnpWbV/o9q8
	 P/2y1tEyzItSpX9pmdvFctK8XC+J85UjStWVM5H24xkJ+mF2nWHM8kDq2dbDaLsS59
	 CZoiDoVxgpevx3J5ww72omRkY3mvsE6ovaETYX3g=
Subject: FAILED: patch "[PATCH] batman-adv: tt: prevent TVLV entry number overflow" failed to apply to 6.6-stable tree
To: sven@narfation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:57:18 +0200
Message-ID: <2026052818-chaperone-nuclear-c2aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254962-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,narfation.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F1FDD5F1D2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 99d9958fa10fb684b2a8e2c48a8d704122721420
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052818-chaperone-nuclear-c2aa@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 99d9958fa10fb684b2a8e2c48a8d704122721420 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 2 May 2026 21:25:19 +0200
Subject: [PATCH] batman-adv: tt: prevent TVLV entry number overflow

The helpers to prepare the buffers for the local and global TT based
replies are trying to sum up all TT entries which can be found for each
VLAN. In theory, this sum can be too big for an u16 and therefore overflow.
A too small buffer would then be allocated for the TVLV.

The too small buffer will be handled gracefully by
batadv_tt_tvlv_generate() and is not causing a buffer overflow - just a
truncated reply. But this overflow shouldn't have happened in the first and
the too small buffer should never have been allocated when an overflow was
detected.

Cc: stable@kernel.org
Fixes: 7ea7b4a14275 ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Sven Eckelmann <sven@narfation.org>

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2259b241e0b5..9f6e67771ffa 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -804,11 +804,18 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	u16 total_entries = 0;
 	u8 *tt_change_ptr;
 	int vlan_entries;
+	u16 sum_entries;
 
 	spin_lock_bh(&orig_node->vlan_list_lock);
 	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
-		total_entries += vlan_entries;
+
+		if (check_add_overflow(vlan_entries, total_entries, &sum_entries)) {
+			*tt_len = 0;
+			goto out;
+		}
+
+		total_entries = sum_entries;
 		num_vlan++;
 	}
 
@@ -893,15 +900,22 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	struct batadv_meshif_vlan *vlan;
 	size_t change_offset;
 	u16 num_vlan = 0;
-	u16 vlan_entries = 0;
 	u16 total_entries = 0;
 	u16 tvlv_len;
 	u8 *tt_change_ptr;
+	int vlan_entries;
+	u16 sum_entries;
 
 	spin_lock_bh(&bat_priv->meshif_vlan_list_lock);
 	hlist_for_each_entry(vlan, &bat_priv->meshif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
-		total_entries += vlan_entries;
+
+		if (check_add_overflow(vlan_entries, total_entries, &sum_entries)) {
+			tvlv_len = 0;
+			goto out;
+		}
+
+		total_entries = sum_entries;
 		num_vlan++;
 	}
 


