Return-Path: <stable+bounces-119426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B00A430FE
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 00:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7BC188A1DB
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 23:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40838201001;
	Mon, 24 Feb 2025 23:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMV7Jp8t"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5F52746C;
	Mon, 24 Feb 2025 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440263; cv=none; b=kLAIYjWKDS7+tDOaaxtc543k1I6yXyY7TEnK1B8g1ZOh0eD/lYr3yKht9GLfi+coD2TxsDNCL+mykZ2vwL6v8MRrZVsgZHICTiBdTbwUpFfMIWXjatFNJAFqMabqD0dUD3A6uECuljZPFBWMj1nMtdbRksfK2B+/6Ho79qAkp2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440263; c=relaxed/simple;
	bh=FoTrKA6LhvKCMblZLC7GWRiwAMwCpu3dS6guGAxYv8s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iDLYsO04vLgFTZ7Jlkjx8DKhuy3jSz0LJAdQz62WQ1V8B1JjjfzSJMvvgWkprGZEDO4mfy4BQKmiY6LH43Iab3v9oJInKBzp9xcIQZR6pIOe3xAgfn/nSVdLWUKJwq3QRsaA1BhWGNPflduJ6lZ8sHJZDhE5R43HZwTEFpaJAHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMV7Jp8t; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e679353108so7043846d6.3;
        Mon, 24 Feb 2025 15:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740440259; x=1741045059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5cZXDntvAKgGl0/KBa0c3pjh/XgejRpeKXWb1ZgOLkU=;
        b=SMV7Jp8tOUuxoLl5+SnR7Fe5pMgDri7lZwDkod/x128mFA31QLyYIpH6MKpgmbHx6d
         6CTugG12ojt9FaY8J+ZTfRnD00S5HKX2wGZ0JOfBUV3DVWmfYF4vdPZ+BDemaItyswMd
         JNiHLB97OTpeeYN0ORjmDsjhGNt84UMe/ZUqcXhx19eiVJSq0o36sOR3erMaMwC32xX3
         VSA2RZhNDvdZEgz/sphkmum4pCwW+KYsu/cnPPH141nopsfUUv9HKMAKxOcyrGwIRfVL
         ooaw08KOfoWwkCGcWidVy9dafU8Tjf5bMxXs7cdyJZnDDd0Oc4CP684EdVgrk4CqzwkX
         H1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740440259; x=1741045059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cZXDntvAKgGl0/KBa0c3pjh/XgejRpeKXWb1ZgOLkU=;
        b=dGDSDEhxGaAnrMUNoCohHk2cGQ/zy6PAYdxg0dQRHYLuwufWXBiATGSJpHcYUGKjsg
         Z1xTSN5nYR4UhXR/u/voelfbzs0biPzB7qd5/jNCJXRaZtmixt/7D5ATA/Fcxnc2L0M4
         fC2RfTBv2vWv1dYOsSIVfUyMcIJ59jWQk8PCFdDWoZ3X7MRBDMcoE9vjU9GFaEeWB84F
         mBYSZcIS8DpbqtH2HqASg0wTRrfWZJ1mBdw4E0L+AQ9yUmt+DVcna8TcSGe8pHjMmfAP
         6qFNQAXebyJjV58WZvhlXs3AiiPQJtLc2uEBziSdkhmFxhOzEuOHXkfxrOiDHJkwr6aF
         kq1g==
X-Forwarded-Encrypted: i=1; AJvYcCX/bVTWkls5d6Pyxdn2D3IzRI1Lmfi2V7kpOLXTWGSmm5RY2TK/IE+epQ8Q/VQpMsHPuOMtHPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkBzr7BqdbD/Na/oZS0v9keWSaKAlhfk/UZb0MdQZtgmvfbvY5
	bVP/uCXGDrbTbHf4pZtDLexNwpO4SqGt9x7+jxGM43Kuac2Q9m5NrQD3
X-Gm-Gg: ASbGncvCX87HT3VmSsMZUA7AXKjlG66H0BrJ2imVGj30AU+RMWJ13HWzvBdbGhodrwN
	hA0+DvUIZv+02lpbgJY7elCrPQZEIqPizVUQzySVdre01UMt/8tdjBVVVD4D9jv8i3qG4HpSh4c
	JIKd0lWmNoCEPcSsGY8hlHOi8nTq5oO9Zi38IGCe3ECN4kffH4NDTO5S/jT9NE0Xy+0y/THpK4V
	4dvqFAAc6XmjZVEDz4b1e5qjhMjrmqapG24vdO9IQQABPtCPLBDfPdHQJ3BunsosLmj4xSTukM1
	CTZyPdX8I7Vk5wtt/KTly/s=
X-Google-Smtp-Source: AGHT+IH6TWm3eudaZ4Jmk29rO3+3FpuMFYKoqtU91lji/lFr5sq3jpnJ42Bq7uWXQQgkXK2c0FVNGw==
X-Received: by 2002:ac8:7f16:0:b0:472:1fe2:22c4 with SMTP id d75a77b69052e-472228bd992mr73136091cf.4.1740440259115;
        Mon, 24 Feb 2025 15:37:39 -0800 (PST)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47378086081sm2421771cf.79.2025.02.24.15.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 15:37:38 -0800 (PST)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: lee@kernel.org,
	lkundrak@v3.sk
Cc: linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] mfd: ene-kb3930: Fix a potential NULL pointer dereference
Date: Mon, 24 Feb 2025 17:37:36 -0600
Message-Id: <20250224233736.1919739-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The off_gpios could be NULL. Add missing check in the kb3930_probe().
This is similar to the issue fixed in commit b1ba8bcb2d1f
("backlight: hx8357: Fix potential NULL pointer dereference").

This was detected by our static analysis tool.

Fixes: ede6b2d1dfc0 ("mfd: ene-kb3930: Add driver for ENE KB3930 Embedded Controller")
Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Suggested-by: Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/mfd/ene-kb3930.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ene-kb3930.c b/drivers/mfd/ene-kb3930.c
index fa0ad2f14a39..9460a67acb0b 100644
--- a/drivers/mfd/ene-kb3930.c
+++ b/drivers/mfd/ene-kb3930.c
@@ -162,7 +162,7 @@ static int kb3930_probe(struct i2c_client *client)
 			devm_gpiod_get_array_optional(dev, "off", GPIOD_IN);
 		if (IS_ERR(ddata->off_gpios))
 			return PTR_ERR(ddata->off_gpios);
-		if (ddata->off_gpios->ndescs < 2) {
+		if (ddata->off_gpios && ddata->off_gpios->ndescs < 2) {
 			dev_err(dev, "invalid off-gpios property\n");
 			return -EINVAL;
 		}
-- 
2.34.1


