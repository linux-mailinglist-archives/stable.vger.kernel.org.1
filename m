Return-Path: <stable+bounces-206152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A93CFFE1A
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 20:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7D7630A8EBC
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 19:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F21933F8B8;
	Wed,  7 Jan 2026 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNJWSe+E"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE27433D51D
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796564; cv=none; b=rE0EfaQRHRPq6pynF8BpDmobsqfW/a3UBl490gE8ZnpJZ7GzdaUpMCeVQaIidZJXl0EgNBTvz3gDXT9fJkt4eOyc348dIYe7wEwSwfFeIry50XXLM1N7JH8mVDmp+3gUPeqMv8IlhPB9EM4u9MhJIx/D6uiLdO0H0qaEcyeM8HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796564; c=relaxed/simple;
	bh=D3eswSWoOxyW/MtHHWi4dF9Glhsucht+yuOuez2GrG0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cb2C39fbIHm0UlKx/XDIW4a69LX4KBtvnOBX44jYPYLAo7dJjYuWF4Zm8OHi523HHVs1WbjIUSTvoB8e2i78eGHkVmvczdX3TuwSPQovBswdhYoPs0oquF4kUh4R5uCw0AFr+PM10UP2GGLS1/PRHiFdOahxebxVVCrc3LkZSQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNJWSe+E; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so15487945ad.3
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 06:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767796562; x=1768401362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vhej7Rf7RQpGEQbQQS7DPInZNw0X028RqQb1HBJM1hQ=;
        b=jNJWSe+EW6TUw67AtqHHX2vxIF+4cGrD2izAVDOuf0IQUHcxas+kPrDhI5UHH5jV2B
         L3533IdyFBqY8tFApROHTIjqqutbduPiQ2pSqHZGdjbn1Mh1vCqA4B1geNXtxblKzYBO
         YHGfQwjBGfP4ryU7mDhKUkC56EMqcfIyGwaAC9XRTU9KiAMYieWqOCdCBGShCBa3Xbbs
         Hb1wiTrWgoRd600z4oWo0Zz1tvE3zznx6swXQjgM/ADyC9VtO+QEPeAxA3NQUjAxI/ag
         3YW5bSyqln7qtCyWOQpNzAd6JaaU0Ye8kLMiEEsUOdLD7x2OdEtsi6XMuWXa3lXGyi5H
         FsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796562; x=1768401362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhej7Rf7RQpGEQbQQS7DPInZNw0X028RqQb1HBJM1hQ=;
        b=SBIj7FVRyOcP7i/h83qskORvAOlRXqIl5M/9pIvER+2NU1KAXrJ7mQuzJ9bv8T/KM6
         9Ok0R3obsH6eWBmAgNETZwB5T3pJNQPXRptlBKg0ZfCVFJw373libXvazeO2Jx3TqpHI
         DMwmI1w0XuvPCKNFbpSqvArG5wrAL1gDkbprnz/FaHcKPECSBUeX3skQrcx5cgx8zL/w
         HMFfhqilq3jORAhsDRRXiYypeoCoFByq1ViFqIx5BTKcAl3zztu5yzaKraBkdAGdGswI
         2XMsody8dtc48vStN4ZqqETJlPoytEceah5TyvdVbLEuca2yoS0uuyoz2Guw3UkDcxAg
         MGAg==
X-Forwarded-Encrypted: i=1; AJvYcCWIC0uefy0bLhc8uLS7AgOhv6tL7cv/JDVvTQy8aFeD3EyOfp5h7bv+184OU8QjNEGQpMso41Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLxv6PIZ9kRehI1rm+RBsoXE85S3aRE0q3W/VZTnOaBTyBgh52
	fwNQn8KbRI4Pz7/huTd1zYShLGZs/1B35M7kssZSSjdI4itYQzFEFu+S
X-Gm-Gg: AY/fxX7ZsaSz8wbMaa0wnog7G5UPgoi+I94SKZRsafI4yBZO6GH/gMBCXjjzGBuLq5j
	erzyLL+uWtNwdVHKSne8lSaEaKPNmVOs/F/YkI71o7ss9oSowk92AyJ89k0AJNNb4QQGlBO5Gbp
	hy5A1RQf9U8g301TXZlvEtwzVhiW+M8FlNiFGXESBQjh/AvsDDj6izdg+7TuB+9MJcn67pX67Pw
	2HUVJ7I/ipc8IvAXEoEdGTKMfLzXhvIq07fVoy9tOypXf4krZQMi7EU43EIuTrJpDRF+KkJc6W6
	Iet46ozGQfHbTj30PXuvpc03pZhhq2KfSY3EK8bm+FDdosZMnqUOu/nVmTjmtVlnZiH4y+tTR2Z
	s7yUiL3j9Cbv/fekMfcplVnlthMYbD5A1di0a7aZiPXYEix/w4T5Z6j+l0UxL25qtI6Y8mXeCc0
	YHbQ/D9PLkYGD+HIyaLk3fH2E=
X-Google-Smtp-Source: AGHT+IEaSwwcYPYAXXYX2+w2EfGHMP4tkbOgZMmoW9pA20X6ClwZzMF/KCy891gVYWM2tLnEvyClKg==
X-Received: by 2002:a17:903:354b:b0:2a0:af76:f8cf with SMTP id d9443c01a7336-2a3ee425182mr27341895ad.2.1767796562140;
        Wed, 07 Jan 2026 06:36:02 -0800 (PST)
Received: from localhost.localdomain ([202.120.237.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc7912sm54058345ad.67.2026.01.07.06.35.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 06:36:01 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Angelo Dureghello <adureghello@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: dac: ad3552r-hs: fix out-of-bound write in ad3552r_hs_write_data_source
Date: Wed,  7 Jan 2026 22:35:50 +0800
Message-Id: <20260107143550.34324-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When simple_write_to_buffer() succeeds, it returns the number of bytes
actually copied to the buffer. The code incorrectly uses 'count'
as the index for null termination instead of the actual bytes copied.
If count exceeds the buffer size, this leads to out-of-bounds write.
Add a check for the count and use the return value as the index.

The bug was validated using a demo module that mirrors the original
code and was tested under QEMU.

Pattern of the bug:
- A fixed 64-byte stack buffer is filled using count.
- If count > 64, the code still does buf[count] = '\0', causing an
- out-of-bounds write on the stack.

Steps for reproduce:
- Opens the device node.
- Writes 128 bytes of A to it.
- This overflows the 64-byte stack buffer and KASAN reports the OOB.

Found via static analysis. This is similar to the
commit da9374819eb3 ("iio: backend: fix out-of-bound write")

Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- update commit message
- v1 link: https://lore.kernel.org/all/20251027150713.59067-1-linmq006@gmail.com/
---
 drivers/iio/dac/ad3552r-hs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 41b96b48ba98..a9578afa7015 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -549,12 +549,15 @@ static ssize_t ad3552r_hs_write_data_source(struct file *f,
 
 	guard(mutex)(&st->lock);
 
+	if (count >= sizeof(buf))
+		return -ENOSPC;
+
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
 				     count);
 	if (ret < 0)
 		return ret;
 
-	buf[count] = '\0';
+	buf[ret] = '\0';
 
 	ret = match_string(dbgfs_attr_source, ARRAY_SIZE(dbgfs_attr_source),
 			   buf);
-- 
2.39.5 (Apple Git-154)


