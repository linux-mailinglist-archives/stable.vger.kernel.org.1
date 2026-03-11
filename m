Return-Path: <stable+bounces-224630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMFRANfPsGmLnQIAu9opvQ
	(envelope-from <stable+bounces-224630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:13:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 489C025AC6F
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2174318FDEC
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF161EDA0F;
	Wed, 11 Mar 2026 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gUKioZh+"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3542E2DECBF
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194927; cv=none; b=dtxnTcR0FrOdPNPbNY7+DbJD80/lGi6A39zqlZlHlTbEwEk2OZMaA46/tAqYmNDgC5pyJ2/OwtBDdsGx1m1AInGh7mgMOUxlrtVipnRAvowg4/wZNNWpZSH0ZYBplG4e5nzxa0+TS1fQXtwVg5wzbwFADkH6NlIcCMNiRaC26+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194927; c=relaxed/simple;
	bh=Q5cFX2k6bHPxzmFwA1jZZP2sbUYKylqyAiNpZjCoMM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JGzPc6CTdEcVQLw+ZCSh33oJuZk5N/xdbQ7Ru2vMhnHL0Dd7aeg7GCk75qaL/WXfQ6dDUxQX9RQC1D08iYDfeBIje45WCEqKjnzN4T48tNVAlHTUAyC/qUkDPE5O0MIatfcAT0U8xEB3Brv3tf2C7HtOitNROnnjyrbSRVKU9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gUKioZh+; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773194922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T9f/NPNUnA8wcieHoMwt6iGWiyD3QsUUnDTus3MDL7Y=;
	b=gUKioZh+4Jvw0/Iw+sLJF9tyZm+zYGd9qYPoanXP8n7soOYeOBpIhWtADOc2ujewBJurMc
	2O0tOlqunO3vw6b7VDZpIiRs2v3N5px5LqkaMVpn/XuWJtMEz8olT3J7ykzYCpUv4pMFNE
	PN9y76lAAm8GUfn0QHKNKBN5JQ54eYs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: atmel-aes - Fix 3-page memory leak in atmel_aes_buff_cleanup
Date: Wed, 11 Mar 2026 03:07:35 +0100
Message-ID: <20260311020733.250288-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=thorsten.blum@linux.dev; h=from:subject; bh=Q5cFX2k6bHPxzmFwA1jZZP2sbUYKylqyAiNpZjCoMM4=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJkbzqUKhj15ssTH/p5yVPAMFmUvWem/ayZN9d3q6B3YZ uMoec20o5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACZiYcPwh08kfmn/Dd0kES32 PX/LDjYL7ihJ4qxcJyY2e8URS+m/3owM56+nOv77sNJ0/77WGUKnt/Yt+/Di5IGA5S7cHYs2P/7 dww8A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 489C025AC6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224630-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

atmel_aes_buff_init() allocates 4 pages using __get_free_pages() with
ATMEL_AES_BUFFER_ORDER, but atmel_aes_buff_cleanup() frees only the
first page using free_page(), leaking the remaining 3 pages. Use
free_pages() with ATMEL_AES_BUFFER_ORDER to fix the memory leak.

Fixes: bbe628ed897d ("crypto: atmel-aes - improve performances of data transfer")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/atmel-aes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index bc0c40f10944..9b0cb97055dc 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -2131,7 +2131,7 @@ static int atmel_aes_buff_init(struct atmel_aes_dev *dd)
 
 static void atmel_aes_buff_cleanup(struct atmel_aes_dev *dd)
 {
-	free_page((unsigned long)dd->buf);
+	free_pages((unsigned long)dd->buf, ATMEL_AES_BUFFER_ORDER);
 }
 
 static int atmel_aes_dma_init(struct atmel_aes_dev *dd)

