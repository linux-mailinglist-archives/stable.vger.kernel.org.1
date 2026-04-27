Return-Path: <stable+bounces-241347-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOD2Mlt872lKBwEAu9opvQ
	(envelope-from <stable+bounces-241347-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:10:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C57474F03
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BD7B305A5D5
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F275325706;
	Mon, 27 Apr 2026 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N71769j6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1593242B5
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302262; cv=none; b=A+N4cn/FH0JiCRBPzsmm1a51NZQ981YnzZSSKqoc89ici9smq8UG96gdMnDYAYFd4NN3AuQPYlL35mcFI9RgXpCMjlHRswb5SUzuSIUSOYt38z6gTGGs/khiIZHdklIMMIm29C8ateKAEmea+L/NHGOBJMCoUImZMEbUacYh0Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302262; c=relaxed/simple;
	bh=Ew+fLThVC+dSbzbNb1AU8XHhAhSM9m8r433IWvT/JQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKLUogo7QMpiM/WZ9AYjzSiN5Zh7jeo9tw2d4e5WaDtHDh0iTZ2sKepWtHiZVbkrHLaxcLRa3yYG6BW3Z2DPzWsyG7Vb6rWOg+577B3wTggei+6prXcMU5gSSXWR/nQlJ7jrdKIOeXtNzghO+RjU/T0bDRmxNllb+dM7xpUTn5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N71769j6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48374014a77so135179385e9.3
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777302256; x=1777907056; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZ7wHKT/b/1jeOqUNO1Le/y2Yble71O6C83Q1O+ta3U=;
        b=N71769j6wVHnXHihmoUacjSEEbz4P5NLhr/wxFHnXXW7cjGdsbcF9/sqdqbTEyY0u0
         MadbvMdVbo6adSOF5RqUcN/N0phbC6OUSC5GFfKtgc8UXwhUn3KTPUvsgT3fjDPz5CBR
         YJQF4Kb/NKximM/Q1SoiEnmlO5guLQZRPpYItE2BGNuMwPxP5JeWc93teJs1UitttB6B
         5ePhFMdPuNVskJrGNHbumXDGBhHjhCW7TGozlkStMXgTVOh5PgFoaEg8g+TDyURrrHuY
         VPBBVubp3jF1az+1sBT0TlLjVD8qn301SJr6m+22i8uDttBm0GzxTZJ5C+Z763Fd22wO
         nxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777302256; x=1777907056;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RZ7wHKT/b/1jeOqUNO1Le/y2Yble71O6C83Q1O+ta3U=;
        b=pRT5mHjwsQDDg9bOXJkuNK4EkuEP/Q6dvFAQeeB15wW4hk8SiqtKW5FYnAO4qJF8ld
         NBQykp0iOkWom36SOY9fx0wsndEQvzpBG1EKxm5UaSvh+JZlDp1JvBylzChGYLVyEtn0
         RTO2gSOCEGkRFVUfFxdg3Ml12hJwg0Jk3LrM87YyIhxf71SN+NRNBT2SR0odrMzuQd7v
         zbEW6SVETKhAnNBL55jl1eE12wJadQv2hm/v164Jr6rOMxsUZNajioCbTsv+moSJVi1V
         R0kK2wibaTDd0zgV1kGBlAHVmAxxLAo4XbezPH2Q0FionZpTXwPZBnm9YpvBRwWMvDie
         IkAw==
X-Forwarded-Encrypted: i=1; AFNElJ+a1ZNKKnLGbxrItKnq9KvsmSlt9VoZva7RPJZs1Z70KSf9v4ZlC2mbly93Jprnq2An+leQz0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyPjfU22tbG3i7I8+EhGd95wMAdrMDyP8Aadue+DPU0qdg8Gth
	wxP4fzp78Agii0kO5lm2s4D8FUlZQWfvImrf1eGHFzvbkJFn6co+iN1qWkTaSnFU93ucDSmQG90
	7wI1mDQs=
X-Gm-Gg: AeBDietTyA6rraCIUicuRgTkOKvH1QfeZhnSgwMAF7t2AXZ6AKSmpu0OYMqAAWU6OkW
	L+e+SaJRqih0XLX6c2VVHDs12+thYGKI7c3WqM3j55AhY0c8ysYrWg8WQgAYRYqj1tINtV3FBi/
	FMRzFQmoUs2/tpg2WWsXt0jC9qgnvofsyiDVeTVJt4woY0B3nuTXJ5H66APj56T5OVSppjkKu6d
	YoiULWVzdrAlIqqxZSpCYYK2idx6Cu7g/aHraVdDrBxa1OoN0DPs8Br22eQSCe+66w/zqfdXQbD
	vgecGpal8mcv35Kah9J4TaJHYdkxghP4m3NXkLpFjxxZb7r9XOmLAXFMPFKsZ1xQ8KLM4sL1sF2
	Y76IJnP46mRrdr2YL4d9atD8CVqdddmyQDkyKmNn5mg339+ygMZ8MHM5FD9LZyR3UN0qEgEDCMd
	6YYZp6mj4hWntfCDaKEYuPrXpWHXZ4WQE2ePd/KT50uUlkj5D2DOQ98twsPre9UDBY0bKkYn4Vz
	I4hM3uDjqtPkWFu/Q==
X-Received: by 2002:a05:600c:6297:b0:486:d76c:fa57 with SMTP id 5b1f17b1804b1-488fb77155dmr577914705e9.17.1777302256438;
        Mon, 27 Apr 2026 08:04:16 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48919f54572sm235370215e9.26.2026.04.27.08.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 08:04:15 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 27 Apr 2026 15:04:10 +0000
Subject: [PATCH v2 5/6] firmware: samsung: acpm: Fix out-of-bounds read and
 infinite loop in RX path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-acpm-fixes-sashiko-reports-v2-5-1ff8de94a997@linaro.org>
References: <20260427-acpm-fixes-sashiko-reports-v2-0-1ff8de94a997@linaro.org>
In-Reply-To: <20260427-acpm-fixes-sashiko-reports-v2-0-1ff8de94a997@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777302249; l=2000;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=Ew+fLThVC+dSbzbNb1AU8XHhAhSM9m8r433IWvT/JQk=;
 b=bNdL0A0E7+FoNQEHWtJ8/0fKtqwb636UbTf2X5UWD2LrhRiobr/5jvf4G8NE0a+KNaWY4PLU+
 5i5T2klfbR9CpJBuSWbdOvWAIXalA2MXO7vpbdhquEJVWqHFNX7wee6
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: 78C57474F03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241347-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,linaro.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]

Sashiko identified these bugs in [1].

The ACPM driver reads the rx_front and rx_rear pointers directly from
SRAM and uses them to calculate SRAM offsets and loop termination
conditions.

If a firmware bug writes a value greater than or equal to the queue
length (achan->qlen) at those addresses, two failures occur:

1. Out-of-bounds read: The rear pointer ('i') is used to calculate the
   MMIO address before the modulo operation is applied, leading to an
   immediate out-of-bounds memory access.
2. Infinite loop: The loop iterates using 'i = (i + 1) % achan->qlen'.
   Because 'i' is mathematically capped below qlen, if 'rx_front' is
   greater than or equal to qlen, 'i' will never equal 'rx_front'.
   The CPU will spin forever, holding the rx_lock and deadlocking the
   polling thread.

Protect the kernel by strictly validating the MMIO queue offsets
immediately after reading them.

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260420-acpm-tmu-v3-0-3dc8e93f0b26%40linaro.org [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index c9aa79c2faa4..43658cc1347a 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -230,6 +230,13 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 	rx_front = readl(achan->rx.front);
 	i = readl(achan->rx.rear);
 
+	if (rx_front >= achan->qlen || i >= achan->qlen) {
+		dev_err(achan->acpm->dev,
+			"Invalid RX queue pointers from firmware: front=%u rear=%u qlen=%u\n",
+			rx_front, i, achan->qlen);
+		return -EIO;
+	}
+
 	tx_seqnum = FIELD_GET(ACPM_PROTOCOL_SEQNUM, xfer->txd[0]);
 
 	if (i == rx_front) {

-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


