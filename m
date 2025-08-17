Return-Path: <stable+bounces-169898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7880B2947B
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 19:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C454E37C9
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AC51F4177;
	Sun, 17 Aug 2025 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3wHI1jt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570C228750D;
	Sun, 17 Aug 2025 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755450863; cv=none; b=Lb2lydfaDTmweV1lDYcGewH3Nae4zAHlg2GNNftn8MRylKuEnM+GqvHplpVhQ7OgCnL4arBc5wpw11dw9h2l1I3mwWLq2IwEMR/V9uGwyZNmmgGfBYMzj/Oq3Y0ch+Fm8oQLONGRttLKYhqm1JzFFroWRLgJykgM9ydSJH2M1/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755450863; c=relaxed/simple;
	bh=EdsXrgswoXc/LcRSdAyb1O3Hx5UkEBDBkHDaZ4mDY/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dB7/UvTs5DELiW1OAu8q/oGIZ5NIWyv+cDXAKtERGlvO0AtKm2oWhwuUzM2s9E5/dPzjhW6vmrfRzWld5YF1rFfp9aZ2uhLCLvUDkZuGnAdHexnOPMCuRnrml0kOz+bFlNhNA/NyMTmZKdQZJjJidxJk3Vl0AKCN2DmndFYDZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3wHI1jt; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61a1663be10so1730785a12.1;
        Sun, 17 Aug 2025 10:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755450860; x=1756055660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LY0YIEoUecUVF5HfBlI2OFzc+QtaIhgG2Wu8Bta8CWI=;
        b=d3wHI1jtLFAKSO7ubV/8OimppKNUYwng7IUTCWiqfwAfvXI9OPCDsY/bB4KyF/fO9L
         qb7WiX9d5sxZqRM2PB2Qh1cATBU7e8X+mui1/+8AeUa2qyy8yzcALLpDkRQwnBcJADF6
         TcKd+5MfGADaqQYd6wu+BE7k1PnkpXXGGAv0KD/h3KfXBCp5Ofx92Tb3YxasgHg0Oubm
         lulArpoNPSbb6ou6lpttI38E4YpxLBwY23DZdN2pXsrNW8A4w46vL5ffTVoOKQpK8doU
         KbwnV+Za+DfLxg/rMCvGTiAJKdd4/29sgApKE2U2x1z5HQNG0wMN2rIHzvg3uUz71mK7
         AfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755450860; x=1756055660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LY0YIEoUecUVF5HfBlI2OFzc+QtaIhgG2Wu8Bta8CWI=;
        b=JkvXHKsj5mAG3y5nRY0Y5y2R90VMfJPaKxXUkZltlAXvA7zXShlNvnBfgm4d+k214Q
         jbkksxNeWcoUeL+adPO6s79ThtLKyLOJw0I/ipHbyyzthkKEhDdfI31QanOJocNe/FWP
         WhLV71WvhKKH4EcfWACBS8EhmUD36Naz/+2zW2HrJXz+w1aOf5ZDremBoovKDmwXBxT3
         2zTEJ4unjnkMi5LsHBpEHUrRdvUtUZxFnC6fyoUlI0IKIznWSpXfBo44/VXwTWKP1H+p
         EKPMcYfyWZipRV6ad2/DVnZE4Br7Ihl8fs+zW5aYWNMachfnVHSpQylvCcpVBdt7apaW
         1RAg==
X-Forwarded-Encrypted: i=1; AJvYcCUb8jSohf93Kc+rxxPf0U8inht59w0///U0ZpVFdoVyM3RXSQgvbHF8D3Zi5RopQ61XxBLMcDWW@vger.kernel.org, AJvYcCW7RfmNfSQGPHzqR6iHu8xP5ft2iI+S8zaZ7B5KzL9irhqTBP/RTtITrVhq0sV4k3dfvMGrXNmpKFNc5Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqm3GEHfVKjCTUsqfZHp0C/aGKPdSwpgyUgOvgDGGFtwIvUfiy
	alas/6OAJ9F1GQ9zMnXYw6qOg281/f+NEACQG4QJEgwtz0daiH8xrsBysj7pRQ==
X-Gm-Gg: ASbGnctkbLtCwO4VDisWcRhDRKA0BSFI+dr0qzWLVu0deecgIaiCIbGDTZFUel5tQ7R
	zValR1+Y97Xb5pa9LPAzr6M74MeSA1hWPrtPkz119IjaR7KNRLRfB2CuTs03R7z8Y6Vh8FwNpHN
	5jPFbsAiYtBEmeyZI9OE2R+/Inp2k7sFtlD/2OrnV1y86fTrbA/IiNt3KAZn7/pKi7RXq+S6BIT
	+BFmJhn2XaV946qrOfcdE8dF5yfNUra09AXHEZw2jV92WyGmCTLbk7EMcwQeBbcPpvMI2m40Hl0
	XjFmPHUgFrX+aXC9eVOqDb3ZmaJqOIc8BAmfEjtzEPk+FGQxaWSacsy8yWsUDC+UTDxQ817Q3qP
	UQWUba9N64fmB3+SVXAqy21YR0HIupXMv0w==
X-Google-Smtp-Source: AGHT+IGTN3iEvbwgt1xnZ9FgE2o8v+iy5yboUBLF5nA0P8h3zvmiBjNvUzKjvIuN7BJmKtdf0bSh6w==
X-Received: by 2002:a05:6402:234b:b0:617:fe86:6bff with SMTP id 4fb4d7f45d1cf-618b0513fe6mr8219743a12.8.1755450859385;
        Sun, 17 Aug 2025 10:14:19 -0700 (PDT)
Received: from ws-linux01 ([2a02:2f0e:c207:b600:978:f6fa:583e:b091])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618b02b2e97sm5414399a12.56.2025.08.17.10.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 10:14:19 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: gshahrouzi@gmail.com,
	Ovidiu Panait <ovidiu.panait.oss@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] staging: axis-fifo: fix maximum TX packet length check
Date: Sun, 17 Aug 2025 20:13:50 +0300
Message-ID: <20250817171350.872105-1-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since commit 2ca34b508774 ("staging: axis-fifo: Correct handling of
tx_fifo_depth for size validation"), write() operations with packets
larger than 'tx_fifo_depth - 4' words are no longer rejected with -EINVAL.

Fortunately, the packets are not actually getting transmitted to hardware,
otherwise they would be raising a 'Transmit Packet Overrun Error'
interrupt, which requires a reset of the TX circuit to recover from.

Instead, the request times out inside wait_event_interruptible_timeout()
and always returns -EAGAIN, since the wake up condition can never be true
for these packets. But still, they unnecessarily block other tasks from
writing to the FIFO and the EAGAIN return code signals userspace to retry
the write() call, even though it will always fail and time out.

According to the AXI4-Stream FIFO reference manual (PG080), the maximum
valid packet length is 'tx_fifo_depth - 4' words, so attempting to send
larger packets is invalid and should not be happening in the first place:

> The maximum packet that can be transmitted is limited by the size of
> the FIFO, which is (C_TX_FIFO_DEPTH–4)*(data interface width/8) bytes.

Therefore, bring back the old behavior and outright reject packets larger
than 'tx_fifo_depth - 4' with -EINVAL. Add a comment to explain why the
check is necessary. The dev_err() message was removed to avoid cluttering
the dmesg log if an invalid packet is received from userspace.

Fixes: 2ca34b508774 ("staging: axis-fifo: Correct handling of tx_fifo_depth for size validation")
Cc: stable@vger.kernel.org
Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
Changes in v2:
- added "cc: stable" tag

 drivers/staging/axis-fifo/axis-fifo.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index e8aa632e0a31..271236ad023f 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -325,11 +325,17 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		return -EINVAL;
 	}
 
-	if (words_to_write > fifo->tx_fifo_depth) {
-		dev_err(fifo->dt_device, "tried to write more words [%u] than slots in the fifo buffer [%u]\n",
-			words_to_write, fifo->tx_fifo_depth);
+	/*
+	 * In 'Store-and-Forward' mode, the maximum packet that can be
+	 * transmitted is limited by the size of the FIFO, which is
+	 * (C_TX_FIFO_DEPTH–4)*(data interface width/8) bytes.
+	 *
+	 * Do not attempt to send a packet larger than 'tx_fifo_depth - 4',
+	 * otherwise a 'Transmit Packet Overrun Error' interrupt will be
+	 * raised, which requires a reset of the TX circuit to recover.
+	 */
+	if (words_to_write > (fifo->tx_fifo_depth - 4))
 		return -EINVAL;
-	}
 
 	if (fifo->write_flags & O_NONBLOCK) {
 		/*
-- 
2.50.0


