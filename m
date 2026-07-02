Return-Path: <stable+bounces-270845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RmeQB2+XRmrRZQsAu9opvQ
	(envelope-from <stable+bounces-270845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:53:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0C36FAB19
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:53:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=yCIaXEWF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270845-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270845-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C803A314C36A
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBAA3AE1B8;
	Thu,  2 Jul 2026 16:33:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7CB342509;
	Thu,  2 Jul 2026 16:33:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009999; cv=none; b=dx6BQTUONR7TwBP6//kMMuK0Rd+eum7yXv/eokIntDVHbGLSgONyIegN3o9JfcKSNeQB/pGYWCAop3q6Bfmol9k/azUnhOxmNxPcSKF+r0I2ncrdq2xkq4LgEW/hjQ8CoR63vn5rvo9YkRbA4uRxsDDblR8ZjyR6C1G6iz/TMlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009999; c=relaxed/simple;
	bh=SUvYI1SI1ISsCxmcZgaU2/5VbdT/6+KqPvpxssj0OSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUGF59SSGRNTvmPe9B3g0Dz28C78R57WkR57oMbsAo+WEvyagreN+STMotn/Zb2DTP9U1eTH8z2MVgVrxBk8ILyJASPZ1gvZOTq38HQTnoJp14KItEpCyLQYSDF30SNBCn8f+smtsysJFtRt7x+sipunQJtY43rDzxn4CKzBrFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yCIaXEWF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102591F000E9;
	Thu,  2 Jul 2026 16:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009998;
	bh=ntmr+yrrA6KazHAjkabkvcS1mKxTvQxU/kEdX00+cA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yCIaXEWFhQieNOJBH6OJ//oBr70qmUyeonHQMVrdIoJQbo+XuXMNLALy9OvKNCDvy
	 8g7T2PxS3UtR3eBl8fV+Nr1iuXpZClgQJiLkOoxOJoMqvSkKHpN0DnUA8vlPYoiyU7
	 CkdR//5BVNkmiSmQHzN8KpSIVqxbvAqLhtL2Q84M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Sven Eckelmann <sven@narfation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 073/129] batman-adv: tvlv: enforce 2-byte alignment
Date: Thu,  2 Jul 2026 18:19:52 +0200
Message-ID: <20260702155113.654542289@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.163984240@linuxfoundation.org>
References: <20260702155112.163984240@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:sven@narfation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270845-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,narfation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C0C36FAB19

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit 32a6799255525d6ea4da0f7e9e0e521ad9560a46 upstream.

The fields of an aggregated OGM(v2) are accessed assuming (at least) 2-byte
alignment, so a following OGM must start at an even offset. As the header
length is even, an odd tvlv_len would misalign it and trigger unaligned
accesses on strict-alignment architectures.

Such a misaligned TVLV/OGM/OGMv2 is not created by a normal participant in
the mesh. Therefore, reject such malformed packets.

Cc: stable@kernel.org
Fixes: ef26157747d4 ("batman-adv: tvlv - basic infrastructure")
[ Drop change for non-existing mcast handling ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/bat_iv_ogm.c | 11 ++++++++++-
 net/batman-adv/bat_v_ogm.c  | 11 ++++++++++-
 net/batman-adv/tvlv.c       |  6 ++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index c52e3b82889868..7fd692b642e392 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -311,14 +311,23 @@ batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
 			  const struct batadv_ogm_packet *ogm_packet)
 {
 	int next_buff_pos = 0;
+	u16 tvlv_len;
 
 	/* check if there is enough space for the header */
 	next_buff_pos += buff_pos + sizeof(*ogm_packet);
 	if (next_buff_pos > packet_len)
 		return false;
 
+	tvlv_len = ntohs(ogm_packet->tvlv_len);
+
+	/* the fields of an aggregated OGM are accessed assuming (at least)
+	 * 2-byte alignment, so a following OGM must start at an even offset.
+	 */
+	if (tvlv_len & 1)
+		return false;
+
 	/* check if there is enough space for the optional TVLV */
-	next_buff_pos += ntohs(ogm_packet->tvlv_len);
+	next_buff_pos += tvlv_len;
 
 	return next_buff_pos <= packet_len;
 }
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index f87c2b80e4291e..e8ad4817d20018 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -854,14 +854,23 @@ batadv_v_ogm_aggr_packet(int buff_pos, int packet_len,
 			 const struct batadv_ogm2_packet *ogm2_packet)
 {
 	int next_buff_pos = 0;
+	u16 tvlv_len;
 
 	/* check if there is enough space for the header */
 	next_buff_pos += buff_pos + sizeof(*ogm2_packet);
 	if (next_buff_pos > packet_len)
 		return false;
 
+	tvlv_len = ntohs(ogm2_packet->tvlv_len);
+
+	/* the fields of an aggregated OGMv2 are accessed assuming (at least)
+	 * 2-byte alignment, so a following OGMv2 must start at an even offset.
+	 */
+	if (tvlv_len & 1)
+		return false;
+
 	/* check if there is enough space for the optional TVLV */
-	next_buff_pos += ntohs(ogm2_packet->tvlv_len);
+	next_buff_pos += tvlv_len;
 
 	return next_buff_pos <= packet_len;
 }
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 99e5e8518dcc9a..e25430da5afb1b 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -448,6 +448,12 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 		if (tvlv_value_cont_len > tvlv_value_len)
 			break;
 
+		/* the next tvlv header is accessed assuming (at least) 2-byte
+		 * alignment, so it must start at an even offset.
+		 */
+		if (tvlv_value_cont_len & 1)
+			break;
+
 		tvlv_handler = batadv_tvlv_handler_get(bat_priv,
 						       tvlv_hdr->type,
 						       tvlv_hdr->version);
-- 
2.53.0




