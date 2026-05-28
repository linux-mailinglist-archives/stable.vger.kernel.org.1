Return-Path: <stable+bounces-256372-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DVDBnqsGGphmAgAu9opvQ
	(envelope-from <stable+bounces-256372-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:58:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFFF5F9F44
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B251304E255
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96728330307;
	Thu, 28 May 2026 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mXiM+Kqy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57994304BB3;
	Thu, 28 May 2026 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001516; cv=none; b=pQmsr0psPHqNF9l3j+boHirNx+IuZHGfcieJSBrrkGsDFpYzUM/pHRCzDsTdThtsdHQ4T+O1FttxbcqZp0lT1OG3o3gkne+u8+67gUsmUHhwB7qtCIMzps1D2Xbn6RHGJt1ghOcR8kENfKKrB0N/Gne5NvQGzxJGXiQa0yF5kKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001516; c=relaxed/simple;
	bh=BPut+zJe0IRlxOBZl6O8tAekQX6hQxst1zPDCaoWRqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxEEGGoayTRlxc7QhSm7ycIJatytv9pFqkPYlt5uBxiFYbNts/9fN7JQwqjmja7vKSn2656LJrwkhY0EtznlRv0tKcQbLnXufDLxG0xzEiYR0GXSC3dQm+/wDSKnADTHZ73V1J6S6Ux3Jb6pEksTh1RwSVMy/EQkTJjLP5fkxMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mXiM+Kqy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B661F1F000E9;
	Thu, 28 May 2026 20:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001515;
	bh=baWXi7sKQk7kTydhrRkUoQPXn9lK6PZ0bPsFp/7aKYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXiM+Kqy40tg2Cv+FhE/Pkmu2S+zDJTkXleEltFD6fWYwgBDNTfGTVIpINBhxUd5u
	 XdUjhZt74JrNTB0wZxKZbwwihCUPzdc7GhWWQGwUwvPPVkN/mR10LicM7xvQEsiM6L
	 +EokyvodFP1vEb5w4daZQHlyDJVVOXJ5fIV67Jkw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Golle <daniel@makrotopia.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 156/186] net: dsa: mt7530: preserve VLAN tags on trapped link-local frames
Date: Thu, 28 May 2026 21:50:36 +0200
Message-ID: <20260528194933.168604072@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256372-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,makrotopia.org:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8BFFF5F9F44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit 3ac85bcfd404b588298c95c6fba8aad4ad334f57 ]

The BPC, RGAC1 and RGAC2 registers control the handling of link-local
frames with reserved MAC DAs (01:80:C2:00:00:0x). These frames are
correctly trapped to the CPU port, but the egress VLAN tag attribute was
set to MT7530_VLAN_EG_UNTAGGED which causes the switch to strip any
VLAN tags from trapped frames before they reach the CPU.

This causes VLAN-tagged link-local frames (STP BPDUs, LLDP, PTP Peer
Delay Requests) to arrive at the CPU without their VLAN tag, so they
are delivered to the base network interface instead of the VLAN
sub-interface. The DSA local_termination selftest confirms this: all
link-local protocol tests on VLAN upper interfaces fail.

Set the EG_TAG attribute to MT7530_VLAN_EG_DISABLED (system default)
so that the switch does not modify VLAN tags in trapped frames. This
way VLAN-tagged frames retain their original tag and are delivered to
the correct VLAN sub-interface, matching the behavior of non-trapped
frames which pass through without VLAN tag modification.

Fixes: 69ddba9d170b ("net: dsa: mt7530: fix handling of all link-local frames")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Acked-by: Chester A. Unal <chester.a.unal@arinc9.com>
Link: https://patch.msgid.link/891e0cd34db2a5fe20ceb73283a81fb5f71427ca.1778766629.git.daniel@makrotopia.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mt7530.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index ed783943c73c7..8d889bc5f3d1b 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1174,37 +1174,40 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 static void
 mt753x_trap_frames(struct mt7530_priv *priv)
 {
-	/* Trap 802.1X PAE frames and BPDUs to the CPU port(s) and egress them
-	 * VLAN-untagged.
+	/* Trap 802.1X PAE frames and BPDUs to the CPU port(s) and egress
+	 * them with the EG_TAG attribute set to disabled (system default)
+	 * so that any VLAN tags in the frame are not modified by the
+	 * switch egress VLAN tag processing. This preserves VLAN tags
+	 * for reception on VLAN sub-interfaces.
 	 */
 	mt7530_rmw(priv, MT753X_BPC,
 		   PAE_BPDU_FR | PAE_EG_TAG_MASK | PAE_PORT_FW_MASK |
 			   BPDU_EG_TAG_MASK | BPDU_PORT_FW_MASK,
-		   PAE_BPDU_FR | PAE_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+		   PAE_BPDU_FR | PAE_EG_TAG(MT7530_VLAN_EG_DISABLED) |
 			   PAE_PORT_FW(TO_CPU_FW_CPU_ONLY) |
-			   BPDU_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   BPDU_EG_TAG(MT7530_VLAN_EG_DISABLED) |
 			   TO_CPU_FW_CPU_ONLY);
 
-	/* Trap frames with :01 and :02 MAC DAs to the CPU port(s) and egress
-	 * them VLAN-untagged.
+	/* Trap frames with :01 and :02 MAC DAs to the CPU port(s) and
+	 * egress them with EG_TAG disabled.
 	 */
 	mt7530_rmw(priv, MT753X_RGAC1,
 		   R02_BPDU_FR | R02_EG_TAG_MASK | R02_PORT_FW_MASK |
 			   R01_BPDU_FR | R01_EG_TAG_MASK | R01_PORT_FW_MASK,
-		   R02_BPDU_FR | R02_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+		   R02_BPDU_FR | R02_EG_TAG(MT7530_VLAN_EG_DISABLED) |
 			   R02_PORT_FW(TO_CPU_FW_CPU_ONLY) | R01_BPDU_FR |
-			   R01_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   R01_EG_TAG(MT7530_VLAN_EG_DISABLED) |
 			   TO_CPU_FW_CPU_ONLY);
 
-	/* Trap frames with :03 and :0E MAC DAs to the CPU port(s) and egress
-	 * them VLAN-untagged.
+	/* Trap frames with :03 and :0E MAC DAs to the CPU port(s) and
+	 * egress them with EG_TAG disabled.
 	 */
 	mt7530_rmw(priv, MT753X_RGAC2,
 		   R0E_BPDU_FR | R0E_EG_TAG_MASK | R0E_PORT_FW_MASK |
 			   R03_BPDU_FR | R03_EG_TAG_MASK | R03_PORT_FW_MASK,
-		   R0E_BPDU_FR | R0E_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+		   R0E_BPDU_FR | R0E_EG_TAG(MT7530_VLAN_EG_DISABLED) |
 			   R0E_PORT_FW(TO_CPU_FW_CPU_ONLY) | R03_BPDU_FR |
-			   R03_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   R03_EG_TAG(MT7530_VLAN_EG_DISABLED) |
 			   TO_CPU_FW_CPU_ONLY);
 }
 
-- 
2.53.0




