Return-Path: <stable+bounces-245306-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNnNECURAmqIngEAu9opvQ
	(envelope-from <stable+bounces-245306-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:25:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C9951363D
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A65B314CE28
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E901450906;
	Mon, 11 May 2026 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDNGAD3k"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D6C44DB73
	for <stable@vger.kernel.org>; Mon, 11 May 2026 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519542; cv=none; b=job7Opg0wscPy3PX4dmLl1PGpSLfKandbFVWbDKdnAoZWfEEVdoM9IFbnLfQ+EpjylSdJw2VBg7JiPTC+FAdDPg1s+/hNh+VfnZEIhAB+fyJu7BZ77k5m7LdzRLoxjQKmFfKGfwDhQRXXFZ22+nrseMMXA1R3mDZeG8wJJ/UFdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519542; c=relaxed/simple;
	bh=Pm0arqbEMJSuzVfu2XbHYEXxhnKaEaOHkvubnY5Jb24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1TTU4yXbm0ElQNAAtjL50CxMEM0iNts1PDQVNl37fefjVF9iCYSWd/TZHZfvA7Cr7QwgCvJj/rpqqZlejThtcfQjHFIFhG23hxOv1h/1JLcHCcV78KsQNlHqyu0jm+isxzyHMFEZ4BAQr9OqADwOi3mGoUrXH6lSAyRmk1ocs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDNGAD3k; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59dea72099eso4610391e87.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519540; x=1779124340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JH+u+xhzUiMSlilufXXl7nt5EV8IiDoOquYIB5049q8=;
        b=dDNGAD3k/0sAoDafWNHvzhoLdyZxDp3xurV7r/KgtXbByyqKpswBrGR1MqzPZgosv0
         0qmLllYxGTQHzpTDgxy9m+IMNIgIFOXdFEWFIR7bQB6x+DGUhs9KJG0ONxYR3pdNrAi2
         ygm1zRTUz09oMvwjGVZ6JkAEqeR3aUMiMAKKTDp1VBFY4ATP8wlJatzXtc1GeFttNIAU
         nVsmas13PW2GjeYG5an96ZtBFbpDRKqamBKaNfCNEqfY4XdMYbEn45TnUi1TsE0cYQy/
         /nPtpGFE6wK8+u4tjUnxbAhYSyHdndXQ6Msv4I0kIXhEjeW1RqqwNvpCKerdAVMh2tQ7
         DS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519540; x=1779124340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JH+u+xhzUiMSlilufXXl7nt5EV8IiDoOquYIB5049q8=;
        b=Kuag/Wn27ueEdJL66gAyyIrTlwQuHwx9ILoYWMmcPWkj3Rc/Wh2ETnNamuqEHyY/UK
         /2dPpBKfqZ27SyoIdibjEXaybyBClNJfASi2KfR3KbVTM3ekivo4m7BVUaP1M+jDn8lU
         VFV9x+uyo/JQQ+fuGuWxLDhhQIQS0RFl2fDZG/musC6qrjZ/tpTmuHAVT8sfV8RuFXa4
         Hug5xoUyPeWadfibZSAkfHime0V4lIP6uEapWRl+X0evInUOmLSrTGAtD2mtFwnggkEv
         mHDTm9/BmIgMN8MKp4POggvesCu3rPIuUydQc1nOTtdgrwgXED70DeF4MidI3vTYbrEz
         Pdow==
X-Forwarded-Encrypted: i=1; AFNElJ98r/JVwOdpLkpGVNTeDNyRa/42zuslr77p+KlDX0504jXqTLLOeR8FWVNOYfDX+6CmDaQz+9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2nWtE3j0n2DiblFXQlQhZd9EVZWv9CRPbX2P+Am6NKYqY/u+L
	cjpF+NXFfDh/5U1MSCoe2+VcIsd4/ofVeWUYuSQEaYmAR836lD/z78Gq
X-Gm-Gg: Acq92OHDRa+3CQvpKdGybIYGkJRkHTK+gxsvJRoxt4yqb4lVQK9XTbaUCucmrfUwtc+
	evkpTcuKU/mo5sUPklC58o9kTrbbAa3YDFd4oXPJ7ewD2U5ghVCcebxtP6bUSzZghHIbkaUaa04
	Bjyw4m6h8X7UaP4rVwb9qyURF1vv24YJWA6fKseTuD5RmBwJrPDf/skA0oLsDP+D451JCy0X36Z
	0bTkcStBJHMSq28xQXJV24B2VrUFUcrwNj4hHYLg6ftrBOGDA9JfnmWc7TwyERHXvdsBe8ta5gj
	sHMpnyCe4PXoVtNoZGt2TrgzRJS8lQFNQRickmV/LQtVB6qId6QrHQs0GRcNkJq78HpbiKDp5Fg
	rCW1PgFbsfuTFUR7IhWxuwfZur4/jTxsYvxBa3LN0jqGPX0XeCcgSGJcj4nlcT3ao2DmoCdA28F
	pbksPkKAJokq5nbcBxCAQ1ZyQKXut4SScccB0hST4ffzO5Of5sfDSXTPzWY2BmSdkq/DOVpDM=
X-Received: by 2002:a05:6512:3e16:b0:5a3:ff5a:d83 with SMTP id 2adb3069b0e04-5a887ae3618mr10520299e87.16.1778519539315;
        Mon, 11 May 2026 10:12:19 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a95660b6sm2765488e87.62.2026.05.11.10.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:12:18 -0700 (PDT)
From: Valery Borovsky <vebohr@gmail.com>
To: linux-media@vger.kernel.org
Cc: mchehab@kernel.org,
	hverkuil@kernel.org,
	hansg@kernel.org,
	hugues.fruchet@foss.st.com,
	alain.volmat@foss.st.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	sakari.ailus@linux.intel.com,
	mripard@kernel.org,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Valery Borovsky <vebohr@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/6] media: pwc: Return queued buffers on start_streaming() failure
Date: Mon, 11 May 2026 20:12:08 +0300
Message-ID: <d0fdfb94b56871e757812bfb7aa58e83f7215903.1778518085.git.vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1778518085.git.vebohr@gmail.com>
References: <cover.1778518085.git.vebohr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D4C9951363D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,foss.st.com,gmail.com,linux.intel.com,sholland.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-245306-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The vb2 framework hands buffers to the driver via buf_queue() before
calling start_streaming().  If start_streaming() returns an error
without first returning those buffers via vb2_buffer_done(),
vb2_start_streaming() fires WARN_ON(owned_by_drv_count) and the queued
buffers leak.

pwc's start_streaming() had two early returns that hit this trap:
-ENODEV when the USB device was already disconnected, and -ERESTARTSYS
when mutex_lock_interruptible() was interrupted by a signal.  Call the
existing pwc_cleanup_queued_bufs() helper with VB2_BUF_STATE_QUEUED
before returning (matching the state already used by the
pwc_isoc_init() error path in the same function).

This mirrors the uvcvideo fix in commit 4cf3b6fd54eb ("media: uvcvideo:
Return queued buffers on start_streaming() failure").

Fixes: ceede9fa8939 ("[media] pwc: Fix locking")
Cc: stable@vger.kernel.org
Signed-off-by: Valery Borovsky <vebohr@gmail.com>
---
 drivers/media/usb/pwc/pwc-if.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
index c416e2fc5754..59b99ac8fcb6 100644
--- a/drivers/media/usb/pwc/pwc-if.c
+++ b/drivers/media/usb/pwc/pwc-if.c
@@ -710,11 +710,15 @@ static int start_streaming(struct vb2_queue *vq, unsigned int count)
 	struct pwc_device *pdev = vb2_get_drv_priv(vq);
 	int r;
 
-	if (!pdev->udev)
+	if (!pdev->udev) {
+		pwc_cleanup_queued_bufs(pdev, VB2_BUF_STATE_QUEUED);
 		return -ENODEV;
+	}
 
-	if (mutex_lock_interruptible(&pdev->v4l2_lock))
+	if (mutex_lock_interruptible(&pdev->v4l2_lock)) {
+		pwc_cleanup_queued_bufs(pdev, VB2_BUF_STATE_QUEUED);
 		return -ERESTARTSYS;
+	}
 	/* Turn on camera and set LEDS on */
 	pwc_camera_power(pdev, 1);
 	pwc_set_leds(pdev, leds[0], leds[1]);
-- 
2.51.0


