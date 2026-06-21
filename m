Return-Path: <stable+bounces-267577-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fl13Cf86OGqBaAcAu9opvQ
	(envelope-from <stable+bounces-267577-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 21:26:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A304F6AB826
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 21:26:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="A+/X6/gz";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267577-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267577-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08D2B300A10B
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 19:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18410370D4D;
	Sun, 21 Jun 2026 19:26:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A87A17A2F6
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 19:26:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782070005; cv=none; b=GkpH2P+cMgDTQ4RjdInQdO5Xmuq3JSUAdIL0Q4NV+R7LpgxpTdXHUX2ULu08cbxJZ55lhnLlk/EO0MYPbq4xaNy0L9J59q4Jt4qoTiv/CzfnIdrPoOsALHkj/Wy/ZKsrQVSFFvu813g/WZXCwIU8DnP6pJqKidPjS/s9Zm6axnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782070005; c=relaxed/simple;
	bh=QLkT6UpBtXFAmC/EbtJYRlAe8jiyZbpGniPqrtKoJ60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XaJLO6lQsTxcS9F4db3cogsXthC5eNiFb6HII6v2fyF565G6ePdXBDBsGVHCkrMKDubLVnVRCWIbGK0indfsru1QlaUQtbh+GZDcuLaHX9wOv0BOzOWExBbblRteTXMjqDFkB5gJMsVVa0VqoZemimWJ4e6G76yPz36bvXPAQaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A+/X6/gz; arc=none smtp.client-ip=95.215.58.173
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782069992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SyW5BDjbbmigNhBIEQlI5kPn/+PoFEIgeknateLdwe4=;
	b=A+/X6/gzL5DsFhYcVjNECqD+KhJW/fBatsdvl4pn75ovYj8zQv+UGoGeBcc6rC+dYKZt7q
	US1KlZRu0kr4Xh0w68gjTtp8o10XQ8RFA5lLOmZ+hrYzI9OPOfMlLvxbu4RwV2Rx/e++zV
	U5pyo4k3gooQ0UAzUc1PomZ+hBjomNM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Marek Vasut <marex@denx.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: mxs-dcp - fix source scatterlist length access
Date: Sun, 21 Jun 2026 21:26:16 +0200
Message-ID: <20260621192615.277957-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044; i=thorsten.blum@linux.dev; h=from:subject; bh=QLkT6UpBtXFAmC/EbtJYRlAe8jiyZbpGniPqrtKoJ60=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkWVtf/Cu5UfHHr5psQA8WX6k/jS97s97SteKueYCvQw Vf6q/9JRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEyk0Zjhr9TxwPL6Od9fHNC/ JRK9ceuRs/JzOpTnTmC0NsladWLWQzVGhubVJxLtTZfx7L59V6Ah7OsRx4mp7Fu9TkjfKL07d+2 EEG4A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267577-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:marex@denx.de,m:thorsten.blum@linux.dev,m:stable@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gondor.apana.org.au,davemloft.net,nxp.com,pengutronix.de,gmail.com,denx.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A304F6AB826

mxs_dcp_aes_block_crypt() uses sg_dma_len() without mapping the source
scatterlist with dma_map_sg() first. Therefore, sg_dma_len() is invalid
and could return zero or a stale DMA length, causing encryption and
decryption to process the wrong number of bytes when
CONFIG_NEED_SG_DMA_LENGTH=y.

Use the original scatterlist length instead.

Fixes: 15b59e7c3733 ("crypto: mxs - Add Freescale MXS DCP driver")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/mxs-dcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index 133ebc998236..595b2fd84667 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -353,7 +353,7 @@ static int mxs_dcp_aes_block_crypt(struct crypto_async_request *arq)
 
 	for_each_sg(req->src, src, sg_nents(req->src), i) {
 		src_buf = sg_virt(src);
-		len = sg_dma_len(src);
+		len = src->length;
 		tlen += len;
 		limit_hit = tlen > req->cryptlen;
 

