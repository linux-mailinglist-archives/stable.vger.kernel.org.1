Return-Path: <stable+bounces-251292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHR8FhwZDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:27:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B32F5599986
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 912A331A0E3F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9B43D5642;
	Wed, 20 May 2026 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yNJLmSem"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF74B372EDE;
	Wed, 20 May 2026 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297604; cv=none; b=M0lOPIzCAORnkQlO09G0zp5tKbs6CXV6e28bBFDN+garqm9ixA36YAukGhVX5+4/UOt8MYygwMHJvLzYwtkIwMyE5XhPhOCiAJ3Rhg9PC1P8OFMBKhVCvdAAK5GX9XqchmJstVFZ18xSASn8JMnZCViAtjbVyHPnBdDamvn6zFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297604; c=relaxed/simple;
	bh=WZD6vZI+AF/7h0XiwkyQc3n2UVRWYvbXq3UpE8nz+6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8rPyYQc7tUb0zEgBEHrfJuGMnC4GzA7YM3bMtV3nFZ1SOdW36XtwIcYXR6uct0wrREJQhOOsGdnSCdgw4PeeL2qB1QGX52KRorPqHU5CDMDRq+Itnp5cUJamm5i5haniX2xSZUz74mXPtrBz6qBP75hnxL3dShico3GwMG5uU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yNJLmSem; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F691F00894;
	Wed, 20 May 2026 17:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297603;
	bh=dzygsRMiJPLLo2CJtPGYLzOiD3qqQZONYR92t0U05sE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yNJLmSemrCTeufOoTXiVv4VzzF9TYEExgHRZxpPdzA4/hfcnSXirMgGBR1u8407v2
	 cW8ASnckwsq46tVGGo2jZBWmQ+yMHOzDzLgXmswM2LPUrnbWoztUNAuvKO6Vthl7r6
	 mSj1ppYwFQJkkFNdMcTvVOOzpYqmLUSqUK4eWA90=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 095/957] wifi: mt76: mt7996: fix wrong DMAD length when using MAC TXP
Date: Wed, 20 May 2026 18:09:38 +0200
Message-ID: <20260520162136.619452702@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251292-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nbd.name:email,mediatek.com:email]
X-Rspamd-Queue-Id: B32F5599986
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shayne Chen <shayne.chen@mediatek.com>

[ Upstream commit 97b9f9831bf297f3ffa62018721601ed2736f2c3 ]

The struct mt76_connac_fw_txp is used for HIF TXP. Change to use the
struct mt76_connac_hw_txp to fix the wrong DMAD length for MAC TXP.

Fixes: cb6ebbdffef2 ("wifi: mt76: mt7996: support writing MAC TXD for AddBA Request")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Link: https://patch.msgid.link/20260203155532.1098290-1-shayne.chen@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 2aa8bb779b228..0b5194e708b3a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1109,10 +1109,10 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	 * req
 	 */
 	if (le32_to_cpu(ptr[7]) & MT_TXD7_MAC_TXD) {
-		u32 val;
+		u32 val, mac_txp_size = sizeof(struct mt76_connac_hw_txp);
 
 		ptr = (__le32 *)(txwi + MT_TXD_SIZE);
-		memset((void *)ptr, 0, sizeof(struct mt76_connac_fw_txp));
+		memset((void *)ptr, 0, mac_txp_size);
 
 		val = FIELD_PREP(MT_TXP0_TOKEN_ID0, id) |
 		      MT_TXP0_TOKEN_ID0_VALID_MASK;
@@ -1131,6 +1131,8 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 				  tx_info->buf[1].addr >> 32);
 #endif
 		ptr[3] = cpu_to_le32(val);
+
+		tx_info->buf[0].len = MT_TXD_SIZE + mac_txp_size;
 	} else {
 		struct mt76_connac_txp_common *txp;
 
-- 
2.53.0




