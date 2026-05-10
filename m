Return-Path: <stable+bounces-245056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFryL3a+AGoCMQEAu9opvQ
	(envelope-from <stable+bounces-245056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 19:20:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7795055EB
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 19:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BF2A3009171
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32AC39C645;
	Sun, 10 May 2026 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIqTwHmC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D2C318EDF
	for <stable@vger.kernel.org>; Sun, 10 May 2026 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778433651; cv=none; b=kyWvETb1YffUWq6vab1Psqzo+G2TOnRF4Jl1ER51TGbWFOMjlHkpAN2MU58h8DK+3bAxzC5Lq04zML532bHUOpTbAP61DnZ19SGxorQ4oMUAmHNW31exP3ayfe+JCgJSJqjZaibrK47CNU/67sak8fHXDQXRjGuPpSe2h7AhFZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778433651; c=relaxed/simple;
	bh=FJevMoCgzbcT3Xw+0gG1U2ozUYJswNgmbBEqoU3PC/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAfNLjbClKNZ3xrJOhPZO5u9Sy1N5wKt9FAavb6Bokuq4Nrf9+kypFfIopjARNkzy/eKCInZRj4ie8k5bnxm//Y8q84ELM6TDi+MSBi9TqoCOUapEFziJtMqaB8dYDLLVI6+xuTGd8vBa4biKrSHtQpEUbvPiS1hKCqskkySURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIqTwHmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29DFC2BCB8;
	Sun, 10 May 2026 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778433651;
	bh=FJevMoCgzbcT3Xw+0gG1U2ozUYJswNgmbBEqoU3PC/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jIqTwHmC0HaFKk3HbBIAlT2uYXVwXfLCx5xvr/tADOjsMbDJR7EIobuayJ+vMUlFY
	 ULJBD7D+VmNYuzq5WKIQBu0i04GNJcvuamGKpG6UQYwva3q1bOXWvlsdmHoUvhce6l
	 0kDDIO8dbhKyWTXvss+U+x8gDoBjzli6SBbyZ2nnU2AHJMzL58VzWyrqRXCcJi4hi0
	 ttDjB29yQT9JOZ+hv66xtMnWmMLTNSNQBhyq0uXn9qtLeOG9fLBDvsqF6BCVQ17wbm
	 yM/QlW9fOLYh5da5L/KQk76KSua+F/j7of4AxVhxr4JcUZERk9lidfE1ph0yPJHA6J
	 BZbsWwr4rpzYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Quan Zhou <quan.zhou@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] wifi: mt76: mt7925: fix incorrect TLV length in CLC command
Date: Sun, 10 May 2026 13:20:48 -0400
Message-ID: <20260510172048.533185-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050712-unicorn-patrol-23a0@gregkh>
References: <2026050712-unicorn-patrol-23a0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1E7795055EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245056-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

From: Quan Zhou <quan.zhou@mediatek.com>

[ Upstream commit 62e037aa8cf5a69b7ea63336705a35c897b9db2b ]

The previous implementation of __mt7925_mcu_set_clc() set the TLV length
field (.len) incorrectly during CLC command construction. The length was
initialized as sizeof(req) - 4, regardless of the actual segment length.
This could cause the WiFi firmware to misinterpret the command payload,
resulting in command execution errors.

This patch moves the TLV length assignment to after the segment is
selected, and sets .len to sizeof(req) + seg->len - 4, matching the
actual command content. This ensures the firmware receives the
correct TLV length and parses the command properly.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Cc: stable@vger.kernel.org
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Acked-by: Sean Wang <sean.wang@mediatek.com>
Link: https://patch.msgid.link/f56ae0e705774dfa8aab3b99e5bbdc92cd93523e.1772011204.git.quan.zhou@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 847a1069f41eb..95111a4333f40 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -3261,7 +3261,6 @@ __mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		u8 rsvd[64];
 	} __packed req = {
 		.tag = cpu_to_le16(0x3),
-		.len = cpu_to_le16(sizeof(req) - 4),
 
 		.idx = idx,
 		.env = env_cap,
@@ -3289,6 +3288,7 @@ __mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		memcpy(req.type, rule->type, 2);
 
 		req.size = cpu_to_le16(seg->len);
+		req.len = cpu_to_le16(sizeof(req) + seg->len - 4);
 		skb = __mt76_mcu_msg_alloc(&dev->mt76, &req,
 					   le16_to_cpu(req.size) + sizeof(req),
 					   sizeof(req), GFP_KERNEL);
-- 
2.53.0


