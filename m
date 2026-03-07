Return-Path: <stable+bounces-223430-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TdH9Ke9ErGlLoQEAu9opvQ
	(envelope-from <stable+bounces-223430-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 16:31:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0408322C6A9
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 16:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00D2A3013D43
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 15:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F640287253;
	Sat,  7 Mar 2026 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uVARBis+"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654E2274641
	for <stable@vger.kernel.org>; Sat,  7 Mar 2026 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772897514; cv=none; b=VNQtfvH3+ncWLJ6iQzVScbNX2/kg9HEL0cHBM112+hIss65pSeDcRCbM9O3UtTlNNB4xe/QqkMq7E+rW0kVJps9uLsGE4Ikvy+/bm9GqFc8enB0AX0VaW5CYgpsTZ2BzHqckA2EOzL6esl8Uyq28sgC9DsdPBxLqvVzjp1uNQYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772897514; c=relaxed/simple;
	bh=12uNODLktx6BEfkMaGGtrq9ZKRAKF85Ng0piF3rogU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PcukHkmFwIu2L0Fdhh6PPrkNtxEG2MdPo1xGccHoqqf7EpjwjR66T5y7qDsNK0yAzVnX282NqWWh0Ld+yOnm1MFPeIF8jSAnUbT/exjPdANjWfhFvJw7BhRZ8YX8CWiORXRp8VJbJlEiz65AmhFGrdRdIwNKYBe4jOsZ64Qz6yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uVARBis+; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772897510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WCkjlMOHTdO7UOxucKf2A+R16ZfIHUwM/0MaXiSsIN4=;
	b=uVARBis+gT927/YxV8BaJDN81E2SICI9F76QBhCWq94eRk8hxiuEuD1McgUcyCOczUm5TE
	IHSNJyLVMkvSf++yawmVaBO5XYZyv+DarnbjyVhWWOWzc4J4CGF0kj8mYyybQ81UMsn9OL
	C6ILaD6SCar5i72ubQHBkIJ/x1ELH20=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	=?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>,
	Nicolas Royer <nicolas@eukrea.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: atmel-tdes - fix DMA sync direction
Date: Sat,  7 Mar 2026 16:31:10 +0100
Message-ID: <20260307153109.321147-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1847; i=thorsten.blum@linux.dev; h=from:subject; bh=12uNODLktx6BEfkMaGGtrq9ZKRAKF85Ng0piF3rogU0=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJlrXPZ+vaQmmt7/c0Na2mPHlOvzvgWs+rpIIjLpd3FW3 ysLlSKzjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZhISyIjQ7O8+/O89zbth+e1 Hpp0cKvQ8+LaGUsjfuo83rbUa+75Z9cY/spOYlrM439627n1igGyTz98On/91hqRKcHFUje77pz mC2cAAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 0408322C6A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223430-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.977];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

Before DMA output is consumed by the CPU, ->dma_addr_out must be synced
with dma_sync_single_for_cpu() instead of dma_sync_single_for_device().
Using the wrong direction can return stale cache data on non-coherent
platforms.

Fixes: 13802005d8f2 ("crypto: atmel - add Atmel DES/TDES driver")
Fixes: 1f858040c2f7 ("crypto: atmel-tdes - add support for latest release of the IP (0x700)")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/atmel-tdes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index 278c0df3c92f..643e507f9c02 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -294,8 +294,8 @@ static int atmel_tdes_crypt_pdc_stop(struct atmel_tdes_dev *dd)
 		dma_unmap_sg(dd->dev, dd->out_sg, 1, DMA_FROM_DEVICE);
 		dma_unmap_sg(dd->dev, dd->in_sg, 1, DMA_TO_DEVICE);
 	} else {
-		dma_sync_single_for_device(dd->dev, dd->dma_addr_out,
-					   dd->dma_size, DMA_FROM_DEVICE);
+		dma_sync_single_for_cpu(dd->dev, dd->dma_addr_out,
+					dd->dma_size, DMA_FROM_DEVICE);
 
 		/* copy data */
 		count = atmel_tdes_sg_copy(&dd->out_sg, &dd->out_offset,
@@ -619,8 +619,8 @@ static int atmel_tdes_crypt_dma_stop(struct atmel_tdes_dev *dd)
 			dma_unmap_sg(dd->dev, dd->out_sg, 1, DMA_FROM_DEVICE);
 			dma_unmap_sg(dd->dev, dd->in_sg, 1, DMA_TO_DEVICE);
 		} else {
-			dma_sync_single_for_device(dd->dev, dd->dma_addr_out,
-				dd->dma_size, DMA_FROM_DEVICE);
+			dma_sync_single_for_cpu(dd->dev, dd->dma_addr_out,
+						dd->dma_size, DMA_FROM_DEVICE);
 
 			/* copy data */
 			count = atmel_tdes_sg_copy(&dd->out_sg, &dd->out_offset,
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


