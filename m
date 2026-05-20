Return-Path: <stable+bounces-250251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPCMFOnkDWpz4gUAu9opvQ
	(envelope-from <stable+bounces-250251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:44:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DC75925C6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD92E308EDB5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F083A3DD528;
	Wed, 20 May 2026 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AqUkc/4j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DE733B97A;
	Wed, 20 May 2026 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294922; cv=none; b=udciXkcB/GvVdiYcPs/pNKj6cJ7UxIYvsvbwG1fCxUagzSbcCn+zMX/NLy/4x9I0BNUKOp7/dhSxlw7eIQ808HPsmkyOfwa5aJuOgmS41qQS+wLtQJYl0gitU3inTyVOz9j4ZDAcTrMwdrcEAU0a+ck8l+a8XP/WUZGlKtAEyjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294922; c=relaxed/simple;
	bh=9c6Seqnqj56K+F7LP7rvO+y4ncSza9ITXY/bm4ELNMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPbjAIvmBpLK7RO6l+lZM44r+JLKO5OJ1U9lC5g9PDzRAazAskMhlxfPFItKohx+/tIAIYz10o1xKTVvIH1dVMHj8ct9LUEOcJ7n8rk11AT8htOmuyS2O8rX6ZnQB/F9u95SeugvZ30EXnyZZ++6s7g66Acp0jKcFGaLOA+Q6UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AqUkc/4j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DF41F000E9;
	Wed, 20 May 2026 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294921;
	bh=HZmPUUvA/v4y50bSlCvgTgbaZTER7YwwtEhpHahxkqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AqUkc/4jKP406bqU7okOlYqKY1LlD69x4Ogq86YptzYaWR4cr9DRBsNNC90D8mW3e
	 kdGfDQ5URx9ezQZAFHZixTUkTRgnSKemLWOGsvvXzbQTL5hh0lVXHHLFm3tNzz3HCX
	 kZ+mT4ojIeNmklq764RGYhrC0QVSk951fPQOfZbg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0224/1146] net: airoha: Add missing PPE configurations in airoha_ppe_hw_init()
Date: Wed, 20 May 2026 18:07:54 +0200
Message-ID: <20260520162153.324432960@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250251-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 06DC75925C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit b9d8b856689d2b968495d79fe653d87fcb8ad98c ]

Add the following PPE configuration in airoha_ppe_hw_init routine:
- 6RD hw offloading is currently not supported by Netfilter flowtable.
  Disable explicitly PPE 6RD offloading in order to prevent PPE to learn
  6RD flows and eventually interrupt the traffic.
- Add missing PPE bind rate configuration for L3 and L2 traffic.
  PPE bind rate configuration specifies the pps threshold to move a PPE
  entry state from UNBIND to BIND. Without this configuration this value
  is random.
- Set ageing thresholds to the values used in the vendor SDK in order to
  improve connection stability under load and avoid packet loss caused by
  fast aging.

Fixes: 00a7678310fe3 ("net: airoha: Introduce flowtable offload support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260412-airoha_ppe_hw_init-missing-bits-v1-1-06ac670819e3@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index c2c32b6833df9..62cfffb4f0e55 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -111,13 +111,13 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 		airoha_fe_rmw(eth, REG_PPE_BND_AGE0(i),
 			      PPE_BIND_AGE0_DELTA_NON_L4 |
 			      PPE_BIND_AGE0_DELTA_UDP,
-			      FIELD_PREP(PPE_BIND_AGE0_DELTA_NON_L4, 1) |
-			      FIELD_PREP(PPE_BIND_AGE0_DELTA_UDP, 12));
+			      FIELD_PREP(PPE_BIND_AGE0_DELTA_NON_L4, 60) |
+			      FIELD_PREP(PPE_BIND_AGE0_DELTA_UDP, 60));
 		airoha_fe_rmw(eth, REG_PPE_BND_AGE1(i),
 			      PPE_BIND_AGE1_DELTA_TCP_FIN |
 			      PPE_BIND_AGE1_DELTA_TCP,
 			      FIELD_PREP(PPE_BIND_AGE1_DELTA_TCP_FIN, 1) |
-			      FIELD_PREP(PPE_BIND_AGE1_DELTA_TCP, 7));
+			      FIELD_PREP(PPE_BIND_AGE1_DELTA_TCP, 60));
 
 		airoha_fe_rmw(eth, REG_PPE_TB_HASH_CFG(i),
 			      PPE_SRAM_TABLE_EN_MASK |
@@ -145,7 +145,15 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 			      FIELD_PREP(PPE_DRAM_TB_NUM_ENTRY_MASK,
 					 dram_num_entries));
 
+		airoha_fe_rmw(eth, REG_PPE_BIND_RATE(i),
+			      PPE_BIND_RATE_L2B_BIND_MASK |
+			      PPE_BIND_RATE_BIND_MASK,
+			      FIELD_PREP(PPE_BIND_RATE_L2B_BIND_MASK, 0x1e) |
+			      FIELD_PREP(PPE_BIND_RATE_BIND_MASK, 0x1e));
+
 		airoha_fe_wr(eth, REG_PPE_HASH_SEED(i), PPE_HASH_SEED);
+		airoha_fe_clear(eth, REG_PPE_PPE_FLOW_CFG(i),
+				PPE_FLOW_CFG_IP6_6RD_MASK);
 
 		for (p = 0; p < ARRAY_SIZE(eth->ports); p++)
 			airoha_fe_rmw(eth, REG_PPE_MTU(i, p),
-- 
2.53.0




