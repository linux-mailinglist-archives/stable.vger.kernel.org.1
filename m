Return-Path: <stable+bounces-255937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJfvAYCnGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:37:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 275EF5F9204
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70BA6306242B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB883368B5;
	Thu, 28 May 2026 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FHdtQc1t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAC032AAD6;
	Thu, 28 May 2026 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000297; cv=none; b=KUCTUjjYWF8Oznsw5oz5r3m7UjjBMbxBhFSSq0KV5nHU8ycRQi56IaGywanumHfUbe7I8klNAq9tv98bnbv0aoFJr3hGnZqOUeKyUFvulf+pWU/7n14eDzX5VcaBXzdHgohOSF5ADT4LNipf5CEd5S/0ZqHEobcO8ClPG3Dgwnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000297; c=relaxed/simple;
	bh=M2ML9S74JgNzlb39RaaAnjvrHqhq0SSz4e22BAPfdO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVaTqS+iJrcXVUpo9kEVA8Z6qTdQxW0hedH8VtQS4fx9wAJ6+I4NkSrG7RStIFLKNetwOh1ipfG1OmlpEKA51O7+DYDW2kSSziISr6AUqpLgNUMmc3SfeL1AppUsDZs1uSj0w0a1+2gCMj0QGQIirk+j5ZXk3SyhJaj0hV5WYb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FHdtQc1t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA0F1F000E9;
	Thu, 28 May 2026 20:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000296;
	bh=s9zo3cgK5Incumbiw0h9BMBLtXjbuojWyQr7zDfVWl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FHdtQc1tHUG1aAEH3x6AghDbaVkrzFGhY+AittZSwSqzmYz4qoHmKHaWZH+Y7n1nB
	 kKRdC22aNXbAYh4ISbousy1+af1zCraMHtBKW1MJyuVXYXdeA2VpSzpSfUuY6Ptcc8
	 J6Z0UljCv223/ZvczWuOLa2NAS0DuIUhWrrpJTfw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Madhur Agrawal <madhur.agrawal@airoha.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 372/377] net: airoha: Disable GDM2 forwarding before configuring GDM2 loopback
Date: Thu, 28 May 2026 21:50:10 +0200
Message-ID: <20260528194649.200057964@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255937-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 275EF5F9204
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 985d4a55e64e43bd86eeb896b81ceba453301989 ]

Hw design requires to disable GDM2 forwarding before configuring GDM2
loopback in airoha_set_gdm2_loopback routine.

Fixes: 9cd451d414f6e ("net: airoha: Add loopback support for GDM2")
Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20260520-airoha-disable-gdm2-fwd-v1-1-1eeea5dffc2f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 27d62acfcc39c..9781a6fc9bf9a 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1800,11 +1800,8 @@ static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 	u32 val, pse_port, chan;
 	int src_port;
 
-	/* Forward the traffic to the proper GDM port */
-	pse_port = port->id == AIROHA_GDM3_IDX ? FE_PSE_PORT_GDM3
-					       : FE_PSE_PORT_GDM4;
 	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
-				    pse_port);
+				    FE_PSE_PORT_DROP);
 	airoha_fe_clear(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
 			GDM_STRIP_CRC_MASK);
 
@@ -1822,6 +1819,11 @@ static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 		      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
 		      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
 		      FIELD_PREP(GDM_LONG_LEN_MASK, AIROHA_MAX_MTU));
+	/* Forward the traffic to the proper GDM port */
+	pse_port = port->id == AIROHA_GDM3_IDX ? FE_PSE_PORT_GDM3
+					       : FE_PSE_PORT_GDM4;
+	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
+				    pse_port);
 
 	/* Disable VIP and IFC for GDM2 */
 	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
-- 
2.53.0




