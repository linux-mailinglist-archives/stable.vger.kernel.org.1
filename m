Return-Path: <stable+bounces-252217-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCWYID37DWrO5AUAu9opvQ
	(envelope-from <stable+bounces-252217-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:19:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 661D0595D13
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E10E53110A87
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F153F54D1;
	Wed, 20 May 2026 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zs9Kn/Vs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B703370D54;
	Wed, 20 May 2026 18:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300099; cv=none; b=f0UuSVrYKSol9FhtHwkDeYDEN/j7W5q4Bu8CWZku0WcMRrdDN7gk4KzBkBlzrg6VPOX7aRn9cBJRs/1whXDpXupCauTG65ioW60gJMycaEu97v9H3WhKMJf8II9xc7RWdL2YB+HlgL2Jfvb4BWnU0OOKEAK8f7XeKSwp3zEAd90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300099; c=relaxed/simple;
	bh=rbzqTV2OUoyweVcqSPcAVweRjBx6JfIO+lAgg8Hwbkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCusZwcEdC0nBYTsWZYlXmOiTKgPl5M/oB8+KcIZeF/Cn/xZuz0TU8jiIo6KB4kfG5LQ8bgWdvOYcnG+3B2yHXgwayIYFsihc0dR8EFnzdJnANFiuI1wfa5DhN5gMv/JkBcn85vC0LrMa0Lr5mVAS5L/sj1hLdxp6KpWwgBORh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zs9Kn/Vs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14CF1F000E9;
	Wed, 20 May 2026 18:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300098;
	bh=cTpMtFOpl+X2jHjqCVZ6e0o7vvz/Fy1G2Xasz+eSI30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zs9Kn/VsB6Gv6ohc7StYJwVVGRjkh0cXRgYob/786DQqQfixT0Q9MBEP9tYHc+vrI
	 w2YUrboJ8ld/RL7I6zzOXDmYLP6/93vQ7TRi0Zq0LBBgEFKFk6wgue/1NBSs/rybqA
	 Fmbje4On9OQDsZJNjQzIGSD5u9q82qd/RhY4NgSo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 047/666] wifi: mt76: mt7925: prevent NULL vif dereference in mt7925_mac_write_txwi
Date: Wed, 20 May 2026 18:14:18 +0200
Message-ID: <20260520162112.259821368@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252217-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nbd.name:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mediatek.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 661D0595D13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

[ Upstream commit 962eb04e67552be406c906c83099c1d736aae3b6 ]

Check for a NULL `vif` before accessing `ieee80211_vif_is_mld(vif)` to
avoid a potential kernel panic in scenarios where `vif` might not be
initialized.

Fixes: ebb1406813c6 ("wifi: mt76: mt7925: add link handling to txwi")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Link: https://patch.msgid.link/20250904030649.655436-3-mingyen.hsieh@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index e308c97b574b8..e5de05a91aee7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -807,8 +807,8 @@ mt7925_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 	txwi[5] = cpu_to_le32(val);
 
 	val = MT_TXD6_DAS | FIELD_PREP(MT_TXD6_MSDU_CNT, 1);
-	if (!ieee80211_vif_is_mld(vif) ||
-	    (q_idx >= MT_LMAC_ALTX0 && q_idx <= MT_LMAC_BCN0))
+	if (vif && (!ieee80211_vif_is_mld(vif) ||
+	    (q_idx >= MT_LMAC_ALTX0 && q_idx <= MT_LMAC_BCN0)))
 		val |= MT_TXD6_DIS_MAT;
 	txwi[6] = cpu_to_le32(val);
 	txwi[7] = 0;
-- 
2.53.0




