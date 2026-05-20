Return-Path: <stable+bounces-250782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH4oGAD4DWry4wUAu9opvQ
	(envelope-from <stable+bounces-250782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:05:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF658595463
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 954FB35A44D3
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAA227E045;
	Wed, 20 May 2026 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Losj72A6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B02E3D8103
	for <stable@vger.kernel.org>; Wed, 20 May 2026 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296300; cv=none; b=ax2fzZLZJxgz5apCM8PUNRa4rppWmlE5BBT73NeIEi/U0RqyYy/P3IhFQYZUm7o8tGLCHO/DVLFqdFgxtSJVyh3ya2p9/NC7wQZPYI/wp3DnwoduW1Sq0Wh56HBv0DOg4NZeNaI1L13obemamPZ97PgCZW/F0MU/P0ejL+SLdEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296300; c=relaxed/simple;
	bh=NtUQs9Up2HMFfGydX9tvBK/zuuwwxTHT0fxGOTS0YXM=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=h5iUqiscxgR3pY+5TO8Dkh+WkVZsiyn03nvGdwgX47DKAviDWpVT44xRGm7BL6dRwTQeAz3Exczpsuuw+3rjCuVgqo6QtA7rXdFeAATb5CvKzYA4K3FAF1SVxpaewVCSvhev60O4YgjwfZwjtaksaXfpj5dK4SoYRUPyoH+Fy50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Losj72A6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so2055018f8f.2
        for <stable@vger.kernel.org>; Wed, 20 May 2026 09:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779296297; x=1779901097; darn=vger.kernel.org;
        h=importance:content-transfer-encoding:mime-version:subject
         :message-id:cc:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBPCSCd3C9rmzX+oCsvNxdulonp23ztClQ3jmkmbmIw=;
        b=Losj72A63KVEONCv3bVEZ6x6BfnPihIGOZzncR1s9eTzmJLMr9dQ1g0/4ylqOZszgT
         Rit7a8ZA+5Wq8ISR81mrx9YhcWjHHpT9kUYbbQ0gf7/TJFNUnUwPKUqjVy1jW0EO3EEI
         F6LDa7BAMaI9Msv02So50rHmps675TOPzYTaEmnpFEboXBJgx0XVYN827L/ZozOuZ/Wm
         4HiuEKQB+rZqd+ZD6Eh9ntuDQHXpVnYWzsATMOmuPYpUa5FBhFg5Ynck4TEn1TTbaSUs
         veUDjBiPPO9CIL64E95cPaHsRIKalXCgttqC1e+n4pEfthHvLMR87KJRKkXVvpEXFB6N
         a79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779296297; x=1779901097;
        h=importance:content-transfer-encoding:mime-version:subject
         :message-id:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBPCSCd3C9rmzX+oCsvNxdulonp23ztClQ3jmkmbmIw=;
        b=Wbo3ZML09/eiSAdeD2iNgZru7ICk37/MH7i1ouIG9tGhfW2P9KPiKLJlZSLf6Ln5r6
         aPuNk5ZP8tMgAQiaqW7k/QjlNpUPlIUSJ3xNWri5q4cE+VOHdejg/Z+1COd0X03k2tpQ
         ub4DIna0N8Ri2fmVXUN5SAjvS+xx8bgD8qe0yeAA2WU2LwZgvZr0Ay9CNmQoiGzYGhAz
         E+bQp0xNYtRc25OVMWBC0LNqnwR2x8gZSUThessTJ4vYdPRwbtAq1EDTBEvD2WbY05lm
         0VV2ZyS/BgKvyGiEiMMw2mLPg3nitxCkb6d2v4w1nFpnLb6vKcKVD2BqKA3S67Hn4a3+
         7qdw==
X-Forwarded-Encrypted: i=1; AFNElJ+wznxHmfOzO7A7D9BktbsY6cYvijxH/PZlxA9M3+ISuh1Rq5gj4uxZZghA7PHmUzg0wRL1HtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpSCfjE3VIr/P6cVDAAmzpK2Que/oevZQocxHUxgndR8OBrUnY
	cVHdRG61Mmp/rYAGkC5u688UiLZ69q1wIZ93SlCZvNiTjJgIDAc03a/o5HCkgg==
X-Gm-Gg: Acq92OEZXyNGQDp5RAKQagwSsKAYdSdIH9/pJSUnu+r/OYJb1LA69hKC0TZZ5d39uHq
	y/S0VDoOQSy9MMKc+FIpHYSmfovVAR32tD6Mnw0kK428+1pj12ZP/zxqI042c+26J7vJMu5oEzN
	A4OKvYTstT0A2Ya/D0dvYmC4xnfONFBAo9KLlbzqELP0NSuw62UniFIEEelSKKLhQJFhxCb5f9c
	BQJ7GQ2BWfcoH9I0wdKV6xnJ0n2zJWigsnYeEp9S9x/hBo5j5E94JwjqP91vEVmoMjQvOe5ajV7
	VTSuFCgbobR2W42JInwoOmfRZYWZJ8/UKVkBb2EYtRyT9AbV8CsvF2dntmaFu6fwmN5FoUQmuDH
	w51qXeCRWtYcupoGV44lcvsqNuBZuQT6tHg5UEf6nr68vm28Y5upTbNKirlgezUFfDe+lSM3RMj
	meH93O+49uGgBpYVSGRYzAzEpd+ZzVJoiauqZnxVDV3jZeaEd6dC10oxwLOeX5cA0GCGzNVN4bO
	vd0xjtkbXLIvB9esmc4MQtDrwU=
X-Received: by 2002:a05:6000:2f83:b0:43b:5097:6f62 with SMTP id ffacd0b85a97d-45e5c5952d5mr39092195f8f.36.1779296297117;
        Wed, 20 May 2026 09:58:17 -0700 (PDT)
Received: from appsuite-core-mw-groupware-85f8f85758-hs66v (gate-4.heinlein-hosting.de. [80.241.60.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm55157565f8f.5.2026.05.20.09.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:58:16 -0700 (PDT)
Date: Wed, 20 May 2026 18:58:14 +0200 (CEST)
From: Goetz Goerisch <ggoerisch@gmail.com>
To: paul.louvel@bootlin.com
Cc: herve.codina@bootlin.com, miquel.raynal@bootlin.com,
	stable@vger.kernel.org, thomas.petazzoni@bootlin.com
Message-ID: <142603430.61540.1779296295550@app.mailbox.org>
Subject: [PATCH] crypto: talitos - fix rename first/last to
 first_desc/last_desc
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.48.98
X-Originating-Client: open-xchange-appsuite
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_X_PRIO_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250782-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ggoerisch@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,app.mailbox.org:mid]
X-Rspamd-Queue-Id: EF658595463
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Commit a1b80018b8cec27fc06a8b04a7f8b5f6cfe86eae
was backported to 6.6.y with a866e2b1c65edaee2e1bb1024ee2c761ced335f8
It renames last to last_desc but misses one occurrence which leads to compile errors on mpc85xx

drivers/crypto/talitos.c: In function 'ahash_digest':
drivers/crypto/talitos.c:2204:16: error: 'struct talitos_ahash_req_ctx' has no member named 'last'
 2204 | req_ctx->last = 1;
      |        ^~4

Fixes: a866e2b1c65e ("crypto: talitos - rename first/last to first_desc/last_desc")
Signed-off-by: Goetz Goerisch <ggoerisch@gmail.com>
---
 drivers/crypto/talitos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 347483f6fc5d..ed160c591346 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -2201,7 +2201,7 @@ static int ahash_digest(struct ahash_request *areq)
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(areq);
 
 	ahash->init(areq);
-	req_ctx->last = 1;
+	req_ctx->last_desc = 1;
 
 	return ahash_process_req(areq, areq->nbytes);
 }
-- 
2.54.0

