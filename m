Return-Path: <stable+bounces-244249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDZBGAwv+mnIKgMAu9opvQ
	(envelope-from <stable+bounces-244249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:55:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1E24D261D
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D1533019A3B
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CC24A341A;
	Tue,  5 May 2026 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0JcXFFLp"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7D94BC011;
	Tue,  5 May 2026 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003650; cv=none; b=oEnFQJhIa8Ys52WMascAWW7xb7W/ztF2Mj0dBeT2BBvWWg8ZvoyBEOQnvs9UVxyAuV50Pfdj+irUifG8acdQ+JDym25IrzvChmHYY58xFncJ707GU7NzMOkm09RtowvkfpUhOo62ImUGXi4ICT9X/q+AhEBCJ/9Ja/PBT+x1NSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003650; c=relaxed/simple;
	bh=cGFtgo0CIneYft26pq9frkKi1YpE+xAQE6MAWw9sMmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jgiSWXvRX7/smQoOaBhHAv7JfImxMPW2SDVi01D3yrqikwC5bwxXCdFhstC2+4tRRMdReK1kmPkeYHqa05l05xEkwM6+xzbx6gU5DjuCF0JBCH2oZNiMjBDXF+sqGQmGW+soPZc3t1Gcm+JOPB3OfnIEvd3njmm9FMZ+qco4zgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0JcXFFLp; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 20C8FC5CD66;
	Tue,  5 May 2026 17:54:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 35DC26053C;
	Tue,  5 May 2026 17:54:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F6DD11AD0419;
	Tue,  5 May 2026 19:54:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778003646; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZpnQUXWUq73ELudmYQPs1N2edbD7ZmXBu8vaxfEusmQ=;
	b=0JcXFFLpc2mcFKNtctLHftsQV8GLZMXeW3BH5nbpBsYwrT9LJEvj6w93TbbOuKG4PrTXOq
	YWT4HLYujC/lWpbIbX2jIwv6j4vhAOopjyjtjzTnjMlD2EfGI2nf6JhUrv1+6GA2zCGTu0
	jxpQ2x1jd4QPIomYeftStrr+aQTgui2H/IoRqi3BKG4FYClVUVUytYpFQIn452TpP7nsnU
	4LtPhVtmm9DQWyfOjRJHYOjecjbh8CFy/8Pa72a+CiwC54tO6rpz2PhBFGQYqJu8K0EWGg
	0MmYPhSxNRJ1JHB2xIkvaYeGLYvtjUERqcyRRNl/pZklun5zYN3N+qojGdNvig==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Tue, 05 May 2026 19:53:13 +0200
Subject: [PATCH v2 12/12] crypto: talitos - fix invalid submit_count
 initial value
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-bootlin_test-7-1-rc1_sec_bugfix-v2-12-5818064bd190@bootlin.com>
References: <20260505-bootlin_test-7-1-rc1_sec_bugfix-v2-0-5818064bd190@bootlin.com>
In-Reply-To: <20260505-bootlin_test-7-1-rc1_sec_bugfix-v2-0-5818064bd190@bootlin.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
 David Howells <dhowells@redhat.com>, 
 Kim Phillips <kim.phillips@freescale.com>, 
 Christophe Leroy <chleroy@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778003630; l=1086;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=cGFtgo0CIneYft26pq9frkKi1YpE+xAQE6MAWw9sMmU=;
 b=USC1Hgq/0B0WglVQceOviDvRDBQ/+0qy4t1foyQAu/Ywogb7wiQrvMzWlxjteAGBW3lhngkwK
 +D1QQ8mYjFfCtN0fjj2akX/ZO2H396hTKXAClDHLbsBzHASUmXF+pL1
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 7A1E24D261D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244249-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul.louvel@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]

The submit_count atomic counter is initialized to -(chfifo_len - 1), but
since atomic_inc_not_zero() rejects increments when the value is zero,
one FIFO slot is always wasted. With chfifo_len = 24, only 23
descriptors can be submitted before getting -EAGAIN in talitos_submit().

Fix by initializing submit_count to -chfifo_len so that the counter
reaches zero only after all chfifo_len slots are occupied.

Cc: stable@vger.kernel.org
Fixes: 4b99262881213 ("crypto: talitos - align locks on cache lines")
Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/crypto/talitos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index cdb6823d7038..6a5b0b053479 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -3566,7 +3566,7 @@ static int talitos_probe(struct platform_device *ofdev)
 		}
 
 		atomic_set(&priv->chan[i].submit_count,
-			   -(priv->chfifo_len - 1));
+			   -priv->chfifo_len);
 	}
 
 	dma_set_mask(dev, DMA_BIT_MASK(36));

-- 
2.53.0


