Return-Path: <stable+bounces-255755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAA1MbikGGoQlwgAu9opvQ
	(envelope-from <stable+bounces-255755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:25:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 561E05F8A50
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF5F73015D1F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8038B2F39B4;
	Thu, 28 May 2026 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cKeZEwBW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53233257854;
	Thu, 28 May 2026 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999793; cv=none; b=SCFBp6XmDRj2GscQdlvp1AeF/PkePDg6/2HoXxGVj8dyaRXG55Tg7ZYwk5K1D9l+CsqfqAm6Aw8ap1JmTdb3+q1KMJFvP2KQ8xWqi8A3IsSGz1ru0abgXM5r5EWrAfjfsvTKNBxqGuaYw0lEttzJJcBMZR3QhruAsQlhMPFQxKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999793; c=relaxed/simple;
	bh=8yd3A6RP7l9PEFC1ZbSazbSFHxpUDvDQvm2+kz68Hqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaPPVQtWkp19PKKYl2+fz+3rltjfbyCgstiOMxBuzj+be+7K4Ua3JQTUMSPfSnh8jZU72tjk2E81dOwfvUBBi9zMkQ6Ifl9MQx1jMUFazuI8zOPCnw8kkqjY+rSqZRdPSbqCtmWVSZUxhFjmQdQiNu8EVqaULBkrH/U8y3Wlog8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cKeZEwBW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28C61F000E9;
	Thu, 28 May 2026 20:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999792;
	bh=G27SZo7CmWButnKW/XwK3pjXImN5o2/YQFySFTQ7nU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cKeZEwBWdofxj18hD96zgReNR6eOsY8c3vzumKQjnrH6UEZbdYGyIYfH+m9a1ndg8
	 VxE8YsCbR+DiKYrI78QBQP7WftQfu0Tbzt10CBNLtpHDJAgrxdRHm/Hu4fB7iG+3tN
	 g23Ix/xRbzcUXtrp/1nmW/SE3MkgU7vEurULYNp4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.18 157/377] batman-adv: tt: avoid empty VLAN responses
Date: Thu, 28 May 2026 21:46:35 +0200
Message-ID: <20260528194642.943840348@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255755-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,narfation.org:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 561E05F8A50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit fa1bd704940b5bcbc32c0b28db9167405c8ee5e0 upstream.

The commit 16116dac2339 ("batman-adv: prevent TT request storms by not
sending inconsistent TT TLVLs") added checks to the local (direct) TT
response code. But the response can also be done indirectly by another node
using the global TT state. To avoid such inconsistency states reported in
the original fix, also avoid sending empty VLANs for replies from the
global TT state.

Cc: stable@kernel.org
Fixes: 7ea7b4a14275 ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/translation-table.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -797,24 +797,26 @@ batadv_tt_prepare_tvlv_global_data(struc
 				   s32 *tt_len)
 {
 	u16 num_vlan = 0;
-	u16 num_entries = 0;
 	u16 tvlv_len = 0;
 	unsigned int change_offset;
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_orig_node_vlan *vlan;
+	u16 total_entries = 0;
 	u8 *tt_change_ptr;
+	int vlan_entries;
 
 	spin_lock_bh(&orig_node->vlan_list_lock);
 	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
+		vlan_entries = atomic_read(&vlan->tt.num_entries);
+		total_entries += vlan_entries;
 		num_vlan++;
-		num_entries += atomic_read(&vlan->tt.num_entries);
 	}
 
 	change_offset = struct_size(*tt_data, vlan_data, num_vlan);
 
 	/* if tt_len is negative, allocate the space needed by the full table */
 	if (*tt_len < 0)
-		*tt_len = batadv_tt_len(num_entries);
+		*tt_len = batadv_tt_len(total_entries);
 
 	if (change_offset > U16_MAX || *tt_len > U16_MAX - change_offset) {
 		*tt_len = 0;
@@ -835,14 +837,26 @@ batadv_tt_prepare_tvlv_global_data(struc
 	(*tt_data)->num_vlan = htons(num_vlan);
 
 	tt_vlan = (*tt_data)->vlan_data;
+	num_vlan = 0;
 	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
+		vlan_entries = atomic_read(&vlan->tt.num_entries);
+		if (vlan_entries < 1)
+			continue;
+
 		tt_vlan->vid = htons(vlan->vid);
 		tt_vlan->crc = htonl(vlan->tt.crc);
 		tt_vlan->reserved = 0;
 
 		tt_vlan++;
+		num_vlan++;
 	}
 
+	/* recalculate in case number of VLANs reduced */
+	change_offset = struct_size(*tt_data, vlan_data, num_vlan);
+	tvlv_len = *tt_len + change_offset;
+
+	(*tt_data)->num_vlan = htons(num_vlan);
+
 	tt_change_ptr = (u8 *)*tt_data + change_offset;
 	*tt_change = (struct batadv_tvlv_tt_change *)tt_change_ptr;
 



