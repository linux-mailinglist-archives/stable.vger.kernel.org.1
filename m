Return-Path: <stable+bounces-244155-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dSTCGTr1+Wk/FgMAu9opvQ
	(envelope-from <stable+bounces-244155-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:48:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5863A4CEC7C
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62D7C303937E
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 13:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55E747CC63;
	Tue,  5 May 2026 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAh4ZExN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05EC47D923
	for <stable@vger.kernel.org>; Tue,  5 May 2026 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988275; cv=none; b=UnOBvBv1p1MfeW9FQWxLQUjVAHz5KBO3XWmjcZuAeLHBTFzTXLcPOP2wWoDgHxst+eszRpj8pwEawD+jAKw6vLQ/c6SHptaUz2a1NSxPtygz2b9FKoq4l8vd3exlQ9yqsYT8cWMPcTpKkTvUUi5EC9NdjPHk/ekssJmjzAz7w2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988275; c=relaxed/simple;
	bh=nI482rHAbt5nXbKBqEJDa7o2nSrbcSlgM1ZPd6rpVsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvC4pHjkIZULf8e7NyVpFCjm/wWqb6aUJyae12Ea1TizTEmtY/UX5cZF5UVKX6uW0p55JHr6pml0KAH867H3AWz/HQwWiIgmT7GNko9LZuQFqFgGLqeaCebSzRaySw3qdU/o7yUwWEmP949YHmX2NRQN3XYUbGPMMbw+RSqbG4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAh4ZExN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso38450125e9.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 06:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777988272; x=1778593072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8zqGy9FCxsyto+kn1sLwjo8QRhEdeQTEmwhLR5OXod0=;
        b=nAh4ZExNWY5zSJTf1wuqWZzlvDsn3P98+RtvyT+v2D64+8/f5KhYTaTT1Uxt/Ur+4d
         ZTvfBzCpHUkNlREgCkfs7EjiFHzY0lqaX+ZZmC7YyyYSGRzDqE/0mGf8QpO4Z1V4Q65o
         qPtsLlX76ZNUIN5Ww1jwotx3bh0BtkVh3zl2B8N/dLJF+iHL2gyE24O2us7CJ53rXOkk
         U+GdOwIH8/yyScGd2fz862t0iJTbNqT0SRSqX/MskMpAIFaJTgxp2j0EFOz8QMb9bna4
         GktlV6l/l2kzKiVCJppPij2QsdEOHoLNNO7TD5rSu8Gyu00NOX8KQKVbyBkYjJt/2J8F
         xfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777988272; x=1778593072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zqGy9FCxsyto+kn1sLwjo8QRhEdeQTEmwhLR5OXod0=;
        b=ohYfV2WI6VGgx/12i4Nfrb8s2d5ErQfYo2tH6Y02NoLUp7ma8O0ej2QBNgaQ38B1Ka
         k8cRQpo6QtWF3EnXFYPv+jlx8pX5WjbVQS1gcGnOtFIzhcPL/8BdMg31OdwbkWUIC5eJ
         c7JGfso8//nnGPPHI4wTJduBulD1ETlSLJvwbkmt2Ed7QoorVgXu2cJxIyPFo26EW11D
         kiG3QMKLsfCSJO5+I8PwKcZ2g+J59HR2s7M7UqwZa4GLhPGpcAvToA5+MYUHSZhe+hwY
         i1YtPjmFdKWi9CPzHemNY8IDtqdEqnjwW76gsK2dtYgGbPEqccijm4mMduI0EBcSGZmg
         RtsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9IW19FfD1OHOAD8yHUdxB4KRHNFPe+B25AIbYK+lKtHvqBZy5Yndl+3bWG0boUB07EcWcpGXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YylHKB4v3PeU/Q6wdEqICttFGTEjbY7+kdck5zjgP2hzVRTV6uF
	fJqQgaKZYyKWgh0jvt8vzBvwhznffsL95t6fzecP+rYRjmhqacOLaO0N
X-Gm-Gg: AeBDiesYa1Y9FVkDqyyGrC/QctgTjH6OmuiuxSs/MFuutg7l4KOBAoKP+mtLqoBl4vI
	K0MjYNjxO/pg5qZVezxlq/Et9cbiVtm35rx6riPQtad4avGIR5U1kvyzEeemUjlylNGdJeUx0cb
	jfUWIAdwGK1yXtwFKnZXpGjh5KkW5euc3heGopT9/HUDAj1sVhiuHuT5nGtUgDxeWtsWD/dEGvC
	DgERjj2B4x8M3QIt30LwFieDIbYPXkS3g0jvv0TeKRprDHKPMURPb8bXWt6sopsvo9xK0PwiiXR
	v0Nd+IXftwyb0zqiSGjhpmJcAQ8RvKqTx/Bn022u99y5OYfewugs7UF4KZGJMme3uzAGKYKA2+b
	CWCqY342fcHiR7OIhoMV8oprlFa/qbgS7BWA0NyD45QMYsflnBCtE7FOXn80eGkueaMSsHB1Ukq
	UBIPTgh+MX1no3GJXhS0wZ8Fgy4N3f//chdx8Widj5o8iHT+bd0qrY65PoysMI750NpeFSklRYe
	SSGOnQq96be7oA8PxzTAq1FmD6eCb9B
X-Received: by 2002:a05:600c:3596:b0:488:fd7e:1063 with SMTP id 5b1f17b1804b1-48a988cee29mr269575315e9.29.1777988271858;
        Tue, 05 May 2026 06:37:51 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81b99127sm391200295e9.0.2026.05.05.06.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:37:51 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] iio: gyro: itg3200: fix i2c read into the wrong stack location
Date: Tue,  5 May 2026 14:37:48 +0100
Message-ID: <20260505133748.51355-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5863A4CEC7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,analog.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-244155-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

itg3200_read_all_channels() takes `__be16 *buf' as a parameter and
fills the i2c_msg destination as `(char *)&buf'. Since `buf' is the
parameter (a pointer), `&buf' is the address of the local pointer
slot on the stack of itg3200_read_all_channels(), not the address
of the caller's scan buffer. The (char *) cast hides the type
mismatch.

i2c_transfer() therefore writes ITG3200_SCAN_ELEMENTS * sizeof(s16)
= 8 bytes into the parameter's stack slot, which is discarded when
the function returns. The caller's scan buffer in
itg3200_trigger_handler() is never written to, so
iio_push_to_buffers_with_timestamp() pushes uninitialised stack
contents to userspace via /dev/iio:deviceX every scan -- both a
functional bug (no actual gyroscope or temperature data is
delivered through the triggered buffer) and an information leak.

The non-buffered read_raw() path is unaffected: it goes through
itg3200_read_reg_s16() which uses `&out' on a local s16 value,
where that is correct.

Drop the spurious `&' so the i2c read writes into the caller's
buffer.

Fixes: 9dbf091da080 ("iio: gyro: Add itg3200")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/iio/gyro/itg3200_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
index a624400a239c..0d3a50031d76 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -34,7 +34,7 @@ static int itg3200_read_all_channels(struct i2c_client *i2c, __be16 *buf)
 			.addr = i2c->addr,
 			.flags = i2c->flags | I2C_M_RD,
 			.len = ITG3200_SCAN_ELEMENTS * sizeof(s16),
-			.buf = (char *)&buf,
+			.buf = (char *)buf,
 		},
 	};
 
-- 
2.53.0


