Return-Path: <stable+bounces-259302-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEgcAhFMG2r1AgkAu9opvQ
	(envelope-from <stable+bounces-259302-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 22:44:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E44E613442
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 22:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9CF13022E04
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E135E34D389;
	Sat, 30 May 2026 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9VYEzBi"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B165D3403EA;
	Sat, 30 May 2026 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173833; cv=none; b=F7BaKA1byrSEaHEeTrIVV3cg0Wdh4KFCxL2lvoQhGQcN8wevqZeHCyucfg448z8MqtZzAbWuCyAjeHQ+NGcSJ4B+TCp+LOTv3JLB0pwIaVomYQiKt9IKFNg7ZOuj3ZsoWbtlPnusQlC0NtIPCmNcmBB8TD/4MAfRUcelZzaDZ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173833; c=relaxed/simple;
	bh=QI3ukdgzn9oHtvVOdq3G5jrrDf/hk6qMFVNn95PXs6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZJgQuvaoGnx6DZyo4ivLJoA3++it2szV16bqdel/ytRw8G6mnUepxmy74TNfPcLYy9TcJHiNxyBK7sBd3LYxV2QbhmiuYc/RWx3guPs7L1z0n0vZHkAgeQxQHL/4Lp1w41FKBqEd7RlCNAE0cYd6YFN9JEjIIOY2XLmc9cJuLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9VYEzBi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125211F00898;
	Sat, 30 May 2026 20:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780173832;
	bh=hpMYg9af1pGzvuZiChTfHI2TaVJJnId4BcvefQrMcws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g9VYEzBibwBclm0bULayQCINiCUNdD/V2GBTFZAMtB4F0vgk6W17a7lXQszAN7wf4
	 q2Eh7z01NdLsJC5vK83Z7Awi/eEAd4HyWdngA3Xj4DREIZHaTZzksA64rk0NamkkYp
	 rELFUS5Iht5wZFF0WjSQCOAyBYhdUpeIkOYu5hfgDQp/RkDN+vlVEbllo2i7d+/Ijc
	 trueC9/xCdsLwj7AGRwyC8cg7h/jxpjPPnTYV4//JNugPqv++TrUVjjTxpiBmXvAgS
	 5rVT/v9lvEmC5wGf4G3iGBgfY4Y68eAwG1gdS2lO0V8/S5wPKOWfCEK0DXrNeqosJZ
	 5ROuOOhh/Ijeg==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Andre Heider <a.heider@gmail.com>,
	Stable@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 1/2] nvmem: layouts: onie-tlv: fix hang on unknown types
Date: Sat, 30 May 2026 21:43:39 +0100
Message-ID: <20260530204340.116743-2-srini@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530204340.116743-1-srini@kernel.org>
References: <20260530204340.116743-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,bootlin.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-259302-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srini@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,cell.name:url,bootlin.com:email]
X-Rspamd-Queue-Id: 8E44E613442
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Andre Heider <a.heider@gmail.com>

The EEPROM on my board has a vendor specific entry of type 0x41. When
stumbling upon that, this driver hangs in an endless loop.

Fix it by keep incrementing the offset on unknown entries, so the loop
will eventually stop.

Fixes: d3c0d12f6474 ("nvmem: layouts: onie-tlv: Add new layout driver")
Cc: Stable@vger.kernel.org
Signed-off-by: Andre Heider <a.heider@gmail.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/nvmem/layouts/onie-tlv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index 0967a32319a2..8b0f3c1b8a0e 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -119,7 +119,7 @@ static int onie_tlv_add_cells(struct device *dev, struct nvmem_device *nvmem,
 
 		cell.name = onie_tlv_cell_name(tlv.type);
 		if (!cell.name)
-			continue;
+			goto next;
 
 		cell.offset = hdr_len + offset + sizeof(tlv.type) + sizeof(tlv.len);
 		cell.bytes = tlv.len;
@@ -132,6 +132,7 @@ static int onie_tlv_add_cells(struct device *dev, struct nvmem_device *nvmem,
 			return ret;
 		}
 
+next:
 		offset += sizeof(tlv) + tlv.len;
 	}
 
-- 
2.53.0


