Return-Path: <stable+bounces-250132-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNs4KfLtDWpb4wUAu9opvQ
	(envelope-from <stable+bounces-250132-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:22:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 396485937DD
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4EAF33825B6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F99B3546D0;
	Wed, 20 May 2026 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IF1arS5Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E68369211;
	Wed, 20 May 2026 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294628; cv=none; b=Ms7u666Ye5dukEoMQ4GEIKOHJzA3PDbA/VP/8UQe2MBowIQMleT55uR2p3GJVNybwRXquRuQsRWZ1kZ7FgnDUHZBBr2uv0rU++rOp5yK1ygG81MvDxIrjvzdmzvs8ENfRZMeJWilMo4PUk1I5fJ6zmPGW7gKMq9keaf4qfby2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294628; c=relaxed/simple;
	bh=jEgAba/8mqzLYMcsIDEhAJrytIn7F/DKaqNtZ9KRhjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhTG4Hszg83B6zvtUox7n+akMrJCH13t9D8WUI5/mYd/5l+O1N1ybsF8ABQxiqo3shtGcmT+9oX2uvQHERSDCPJM3o4L5VUUqNwnIfWKoImZ2hA9BHItKHU6zHxP0TBU7E7HE883xxpdA5Tx1pM2Fao5f3vu/17CDTmgcaSlsr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IF1arS5Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6021F000E9;
	Wed, 20 May 2026 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294626;
	bh=AaBZe2u83A+GuO1kq7ccTIntSWfeBniiY154Ph/WYyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IF1arS5ZJ8ug5YKnbrt10JA2cH0dhjqv07Y2+rmOiY0A73wacWbBMGK08M0VAp7gZ
	 5grINk0Am6/Ym9a41wFmpJz7/Dip/mGtJx0yhT7vCUgLD6+5KY0+Ar9qfCeIL3LfD7
	 jtziCTO2yoqNrnfhfm9GwKfeJtnM5yTiggjnx6NI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kang Yang <kang.yang@airoha.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0110/1146] wifi: mt76: npu: Add missing rx_token_size initialization
Date: Wed, 20 May 2026 18:06:00 +0200
Message-ID: <20260520162150.828476608@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250132-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,nbd.name:email,msgid.link:url,airoha.com:email]
X-Rspamd-Queue-Id: 396485937DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 25e3203a2192f2b0d697b2410126bad87e62d4f0 ]

Add missing rx_token_size initialization for NPU offloading.

Fixes: 7fb554b1b623 ("wifi: mt76: Introduce the NPU generic layer")
Tested-by: Kang Yang <kang.yang@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20260122-mt76-npu-eagle-offload-v2-2-2374614c0de6@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/npu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/npu.c b/drivers/net/wireless/mediatek/mt76/npu.c
index ec36975f6dc94..9679237f73984 100644
--- a/drivers/net/wireless/mediatek/mt76/npu.c
+++ b/drivers/net/wireless/mediatek/mt76/npu.c
@@ -457,6 +457,7 @@ int mt76_npu_init(struct mt76_dev *dev, phys_addr_t phy_addr, int type)
 	dev->mmio.npu_type = type;
 	/* NPU offloading requires HW-RRO for RX packet reordering. */
 	dev->hwrro_mode = MT76_HWRRO_V3_1;
+	dev->rx_token_size = 32768;
 
 	rcu_assign_pointer(dev->mmio.npu, npu);
 	rcu_assign_pointer(dev->mmio.ppe_dev, ppe_dev);
-- 
2.53.0




