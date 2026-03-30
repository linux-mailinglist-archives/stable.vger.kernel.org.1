Return-Path: <stable+bounces-231249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIweM5GXymla+QUAu9opvQ
	(envelope-from <stable+bounces-231249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 17:32:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE9935DE7D
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 17:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CC3C3086CF0
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3521734028F;
	Mon, 30 Mar 2026 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdfF/Qnq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B271833FE27
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884031; cv=none; b=BjX2mDy1jduhxM/Yj6poiooa+4Xf/wf8g2i9bmyynt+8bKRIi1E4u3cLDVZ3ywIy6gYMrB7l3hpWDu4XCmMYuUbhc9/jGJzNwML8wSXxTcGbmi8rWgbH3LsMAjgTtze0jM9tGYBRTLv8sOHyehxlibm4uIxuDNcudPBWS80Nmy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884031; c=relaxed/simple;
	bh=zaYZzXfNb5Yh8uDxRqRlNV+NT11MzWt0MOXKtvGWU2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rWjth/II1106T13R5UMQQjzanc0vdCXlLfZkafBJ2tO4DaC7eZYeetlOW7vQpcZwJCsnMATbvvpLC5/oz08SpmFlOamAJbU0X2VYJj+m5vBGdA+iSje+UvMOBZs48FoYAAaKJ6u6uuVTanTB0dN4rjBFw/jfSAIMccTfg6La0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdfF/Qnq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4853a5ffc05so9846385e9.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 08:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774884028; x=1775488828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sDvERDZoAlGyHoO/AmLOjRnD9UlryXe2PNrEtyg6T8E=;
        b=kdfF/QnqU1ROaamS1piMLKusCEuszMSB0Gji+sPdcN9y9r5ZSEz2/RAS750gKsmUte
         hwDakI0sD3MNcfR9c3VHQ5o5kjjCyGILxBGhfLNu+jyriu/bK+amjO6HbLQFfVek7/Ew
         VBRMUYFmR0zLWGxYcrxQDHPI1CPi1tH5a1757jBfFiieMYVkYCN3V5R5YWKbFPAmWvLv
         OpjFDn/zGWmZBfVFP7Eb0pGCbuLxS6+GZUbrUVKbdtV064fc5CPP28ZYze/TaA+ga832
         iouKK1SlA0p9GxIXRFWI+fZRyGB68nMxGoj99JJ2MIhzbU5SWZR33TOwVxjfkmd4Z3BU
         GHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774884028; x=1775488828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDvERDZoAlGyHoO/AmLOjRnD9UlryXe2PNrEtyg6T8E=;
        b=FPSCu0GrSsw+zHKjhy7uPiSYrSaeBTfqu8E8m/OFu5BXQ6uAQOs7O80O8u6ORhR+vF
         TQH+JOH/hYOI+WXNOyHVMmz4ewOMlBNW6I43lfs4lg8UuECaLvwYr+NEiWA2mvB9eD7z
         kY2UnBbB0GVcdLsxThTKpi8EJvJxvUFfCVuCSHi1zPw71ds4KRqhXyRreyAWcQavounH
         OVhUuer+5jvnqQ8cby5LJMix93bonmm0D5iOU2OhNRv9/ooBE2EhhZ5Kis9fZYRwZpbN
         yfZ8ickVnkZEiW84u1r+t24hsh2kUmlDe4vQ0LQA2U7G0rVSxdy4aEjcNLXSSTRfdg06
         Xk+A==
X-Forwarded-Encrypted: i=1; AJvYcCVmL8YeMjPD5dFF9sJbsf63/uPlpzOR/7AVo+AuVnU35s3mNFi0gW8DnzOeVb/q4yh5Ox2PeMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3cvMQ2aWsgzVbquP/Vky+o+imjq8h33e2rOBg+KpbX20Bt19
	Nq3J9xg/F3IjpDu1CMhr9AQSOShn0xxM5ZoaYTUw6P7rDZTVrMin9Yip
X-Gm-Gg: ATEYQzwGH6zCQXfj0LLlxazriT+qGGHQ14vSST2dsgZtehVLcAlEeeDJkaxyt2CGxt2
	wRTNZ6KCXOXvviNXg3gyKBa/AJ7ubA5fJrIYmx2sOLBlCs07EXXvHESfSXCQwibLk5yPkEMg781
	iid1WANYty9DzFp7dwdbpP4AqP7BLG3AgdR1rQ6euaIAtobE35p4JCEuH/9Bg2t63NZl38Tdm47
	8UoG78gelbQPDobzHgDjOnaJ4Xy99YoJA+rPpBPq3KtuCQASEVemEAsmiUyVdKtSfQNifTAurpq
	ThQsKf0NaZ1SFmCGp9Sd38Uxdax1aHs3jBHdFqU2/Oh91RD2glcqo0r26yhdABgIOaa8rDDFyAs
	lgsV57XABKjE3VWaumvYEZjqgFzQiNQ7D0JseqUr7lz1/Jcseie0kfaXZlnwrn0Ks2LybaN4YMJ
	CKIySLgXPk12+uL21mYsI9YJgE9utJFPppw0fPydr4g9TR8S2kfHKSkWXCyZOunZShQQ4v3vUSy
	vaxgoWqStOSXzc0JnFp
X-Received: by 2002:a05:600c:c493:b0:486:ff8e:1911 with SMTP id 5b1f17b1804b1-48727ef0319mr107582435e9.5.1774884027689;
        Mon, 30 Mar 2026 08:20:27 -0700 (PDT)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-82-131.paris.inria.fr. [128.93.82.131])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48722be608bsm430820075e9.0.2026.03.30.08.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 08:20:27 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Kees Cook <kees@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: hisilicon - Fix dma_unmap_single() direction
Date: Mon, 30 Mar 2026 17:19:32 +0200
Message-ID: <20260330151937.83837-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-231249-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,gondor.apana.org.au,davemloft.net,kernel.org,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fourierthomas@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CE9935DE7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The direction used to map the buffer skreq->iv is DMA_TO_DEVICE but it is
unmapped with direction DMA_BIDIRECTIONAL in the error path.

Change the unmap to match the mapping.

Fixes: 915e4e8413da ("crypto: hisilicon - SEC security accelerator driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/crypto/hisilicon/sec/sec_algs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/sec/sec_algs.c b/drivers/crypto/hisilicon/sec/sec_algs.c
index 54e24fd7b9be..85eecbb40e7e 100644
--- a/drivers/crypto/hisilicon/sec/sec_algs.c
+++ b/drivers/crypto/hisilicon/sec/sec_algs.c
@@ -844,7 +844,7 @@ static int sec_alg_skcipher_crypto(struct skcipher_request *skreq,
 	if (crypto_skcipher_ivsize(atfm))
 		dma_unmap_single(info->dev, sec_req->dma_iv,
 				 crypto_skcipher_ivsize(atfm),
-				 DMA_BIDIRECTIONAL);
+				 DMA_TO_DEVICE);
 err_unmap_out_sg:
 	if (split)
 		sec_unmap_sg_on_err(skreq->dst, steps, splits_out,
-- 
2.43.0


