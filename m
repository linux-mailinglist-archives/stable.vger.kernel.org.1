Return-Path: <stable+bounces-211487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DlHIQEvdmk8NAEAu9opvQ
	(envelope-from <stable+bounces-211487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 15:56:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 329398116C
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 15:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 306833005759
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 14:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6DB27467F;
	Sun, 25 Jan 2026 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrTAebeT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D0614BF92
	for <stable@vger.kernel.org>; Sun, 25 Jan 2026 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769352955; cv=none; b=LqtMNteYpNOHYpoRFGlwdiSWUxgAzlaT4enVmaWh47Wgs4D5dEv1fIpePT7PqSHL6u0rmeTrKvqJn9Iocu/3YKGt3ZhC0FzIufaBlW3L7Pm92a/grc9uC3ZMZgNBmgoisv7b1qLfzA4P5vjuoFZwDz2c+GRa/3KvdVUXUEzjO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769352955; c=relaxed/simple;
	bh=SoaC+bTBADZsZ6lBW8YnpUI8AOZA6Bnbyobzs3M9ObI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+yL9tezMZvmVPTZ3u4h1Amhj55g7PAynzBvYqXwDdOJjjz+BOwfqWypSdkS5+Yknk96wNEdC0VBJAUcWqjZqhJ6vzzKzsh0bx7Ir4+Lo1UtmfIqGQHmZgsx7jROMp+TZACabzoV4FK4OnH8heLWhQbVZwIL1r72eSnFLkY9cms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrTAebeT; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c227206e6dcso2624031a12.2
        for <stable@vger.kernel.org>; Sun, 25 Jan 2026 06:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769352954; x=1769957754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9H4UePuprwIqygwTYXIxu8X5uuYTZS1QdaUvyOfOkw=;
        b=CrTAebeTnLyNUfpD31ceXHiwlIvnyoPbubOcBznK8EQvOMajjNNFSw8FrC6wkNUnMg
         +8i8Jg/0p3Cec9To37TkKbWdRxTbK4UBmbWvGB71lPUnCFHQqe37FhGSAAWx2DVC5qJw
         Sirw1Slj/18hjOgYgH7ZRqCgocDbcKOhBhYG5vJM/oDYe1nxFKJdh/1JKpSWOImDpb3B
         fL3xHWvdbqXIoXgHRM74f+ToKgVzCEDfhVdup8FiS7viFQwqQlfdBlTZB7NpKzNPBzdI
         Llnygbyh1k5LrtjsYnWbmzIkNAfz+H43VRb5KC4pbslH4xIh4vfwrOLWK7oK/1xJvV+5
         1cXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769352954; x=1769957754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l9H4UePuprwIqygwTYXIxu8X5uuYTZS1QdaUvyOfOkw=;
        b=OLQs4P/2wyD6WIcr7Wm/HdOQXkquZ2XJf5Ah7mZ+WWuoZMVOunXnKteK/3y4OG420k
         HvfnjpKAIRmaJDYMTfrU2ibVRJbCpKAkzhKMw8aehSSj1wjXwxrOHKWqCq/fwIINaJWt
         Z+sqBRPD2PzYXAWUsWysZElDi9Ij+Kjgfv3BusdndRC+j1va3i827+HDCND8S8rrbFlc
         f/2LTWMtjq+jSNjGwtGs2pviKarhJE++SeEBXzXyDhI7e34mT8UPIZWs1X4i4Sfu5uLJ
         o9RZFqTgSKJLVvEWgxmy+4td8HzQBroBDKU4xmijIQcAVByfFVZR2QN4Rdg6Qx0L5rNZ
         Zs1g==
X-Gm-Message-State: AOJu0YyvKQ3x3mgJqhurDlkLXNkc7U5g9dITUNqRsQyyaTMv47w3F0ek
	BbynLP3QFLc3cvB/NMBsrrxUPZvyfs4Q0X9lvp12y/23tMiKebRdzt55d81tmamc
X-Gm-Gg: AZuq6aKoMvD5GByNUWVgvf4dvu+cYcvAMNC9QkZvSQbXbdmCmlaHo6BMdnyjD2KocNw
	+1khXexKkkl6Aq48zDwu0QPIY3cYfUlbHUDl4YQIhwtbTPZw5MygBUkYFgPMAMaQYsRh+IVtNy2
	J9X7aXRHBdBlKeaF0q0ztTd1OZ9ln2xC4Slxdh1A/GL7p4nBg0M/s6x+WhQWPj74k3icWkqiCJP
	41eGQEpxBBbKhBmiM8YdBrhuCYTllStNqrR4gvGQlAcOGCC/mK+z9PioCllmdpC1j840op8gecE
	AUBytcFRzN+JuzSUO+d7XtGXWQr+HvehwfADnerOIR/lZNyyZKalRnL8vZ3foGDoZmEKIHrRgDg
	a28fk8lvzjgICW0iur9aZTPXx/fB0Zo+b72NAxo6LYVmha0nqzSC4VeCg/YQaLYm/ACuugTr4EH
	QHlABycHWO7F9y93yfVq19ycx45N5xr6BUqMyGlbjKrsXReFc=
X-Received: by 2002:a05:6a21:398e:b0:38d:f2db:ea3e with SMTP id adf61e73a8af0-38e9f16a116mr1434122637.36.1769352953859;
        Sun, 25 Jan 2026 06:55:53 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:9eef:365d:4ce8:fead])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a42e8ecsm6452382a12.32.2026.01.25.06.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 06:55:53 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: bjsaikiran@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 2/2] media: i2c: ov02c10: Check for errors in disable_streams
Date: Sun, 25 Jan 2026 20:25:44 +0530
Message-ID: <20260125145544.50785-3-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125145544.50785-1-bjsaikiran@gmail.com>
References: <20260125145544.50785-1-bjsaikiran@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211487-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 329398116C
X-Rspamd-Action: no action

The ov02c10_disable_streams() function ignores the return value from
cci_write() when stopping the sensor. If the I2C write fails (e.g.,
due to CCI timeout, power management race, or device removal), the
error is silently lost.

While we still need to return 0 and call pm_runtime_put() regardless
of hardware state (to prevent PM reference leaks and pipeline lock
issues), we should at least log when the hardware stop fails.

This change:
1. Captures the cci_write() return value
2. Logs an error if the write fails
3. Still returns 0 to ensure proper cleanup

Returning an error from disable_streams would cause the camss driver's
video_stop_streaming() to exit early without releasing the pipeline
lock, permanently locking the camera.

Fixes: 0e98938b0157 ("media: i2c: add OmniVision OV02C10 sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Saikiran <bjsaikiran@gmail.com>
---
 drivers/media/i2c/ov02c10.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov02c10.c b/drivers/media/i2c/ov02c10.c
index b86cae3d2b74..743d8544ac53 100644
--- a/drivers/media/i2c/ov02c10.c
+++ b/drivers/media/i2c/ov02c10.c
@@ -629,8 +629,12 @@ static int ov02c10_disable_streams(struct v4l2_subdev *sd,
 				   u32 pad, u64 streams_mask)
 {
 	struct ov02c10 *ov02c10 = to_ov02c10(sd);
+	int ret;
+
+	ret = cci_write(ov02c10->regmap, OV02C10_REG_STREAM_CONTROL, 0, NULL);
+	if (ret)
+		dev_err(ov02c10->dev, "failed to stop streaming: %d\n", ret);
 
-	cci_write(ov02c10->regmap, OV02C10_REG_STREAM_CONTROL, 0, NULL);
 	pm_runtime_put(ov02c10->dev);
 
 	return 0;
-- 
2.51.0


