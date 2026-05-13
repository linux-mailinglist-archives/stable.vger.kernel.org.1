Return-Path: <stable+bounces-246753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLU+Hd4SBGoMDAIAu9opvQ
	(envelope-from <stable+bounces-246753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 07:57:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFA252DDDC
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 07:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FDD8304C955
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 05:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF4A3B895F;
	Wed, 13 May 2026 05:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOOCPeRI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D283B8406
	for <stable@vger.kernel.org>; Wed, 13 May 2026 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651863; cv=none; b=XTXvRMCAj/62NwOhtSrlGV9zW8XabvO8SKGFO0YtbGoUa3jaB45D+GsowciKiUfLepj5vcF5msDSqY5G8rVzoO8sIjmjPE4ShLmNKybv3Hg4P2dJrEka0Ei8Zzn3CJ3shmQlxhMCkvVdbqs/pOUPAnF4th1AvK2Niy7Y7aAAIhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651863; c=relaxed/simple;
	bh=s6BfnkAql2MTDlPesu3S+RGrhsYSXwRQZEBa/vKhnW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EreZzpdnoIi3LGEwDlLJLzmUXxzvMFN32f3W4lDqmvC6n/CnNQCNWZefiL9vjgNKl4FEUBwEQQz5rt9YnjndCyMB9xKhGFFtmz8R4+mztouWizHOmqpcv3HyRNFWWqK0zY21tu5rpsk80xmND8MVQzebf0QZNobdX8csC//eEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOOCPeRI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-459bf19e87bso1641243f8f.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 22:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778651858; x=1779256658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MUFuofREYZSwb8K19QV9xCXORpxZYXHR7ZkCUNHTKDk=;
        b=YOOCPeRIlPCyljhgquYup6R2864qZ4Z4CKhL6i/DIZspLXlGE/Eaww7bHzsb31Kb9k
         ECV4DQPn2HZqtSuJEaof2FA2Fjafg6xgPgEb2iNyQqwKG0DnxWn2CcZ5IdPL8HiriYir
         EQPf2LQCPp3kHi9AiTNUTdX4n1AXOVCXepTZs92xHCR0ruS5X1Z0wXYADR9o/ax2PNNl
         xBA+Ilx6eQWLroi1PN2yJPVoOVd8QC9x+4b2ZGeoTplfrVnPDm3aT+Zrgvz/j3Mc9M6X
         C9omFhc5DpUWFLAEFFSzQZhNDuEayYlz3XMcXsCIZ6QTbAvaqZpwaT5DfS3NYy/OazS/
         4otA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778651858; x=1779256658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUFuofREYZSwb8K19QV9xCXORpxZYXHR7ZkCUNHTKDk=;
        b=F/QbTv0zX3q8hshLwrM3RKd3/xE00EK3y0tDGKi7zkFihQutDKiUfi4wuU/9/NNQ1d
         yDxW0GUmicV9/61KzNOGAw7gapKgeXH0L5+mxgKS+B34HMxKTdj6pHNmD3Nd7oYwfOgV
         z1HfBpM/RteavCPEVAkTTpAragcfH/PFzbQNnHsOljDGHC7HoGNsB/GHDtkC/7R9dnNM
         ICVojD3M0fXUaiMDgwsazzCVn/8wy0zkvwN7loXMWF9GIVOKJ3dPvf3lihoLtXV8uMa6
         6ls4KgMEUbfxI0YvA1oUe/7RykVm6lzgfBgaW0uVdmqAtsPb+zEOAWwOOPcEp27NoIdu
         AArg==
X-Gm-Message-State: AOJu0YyOzX2VEcExUN3Y1TotWd+uqUhrO6y25eqCjXAeSVM1aFRYGw3n
	+hbV29myDihMlxDei2I33HJhiN9eaxwWdU07TJ4PhfdHkPqdOc2TNSqW
X-Gm-Gg: Acq92OH5/fdSavRgtc8OECASOjVIeuyzndbGBBxtAsXcfCrWf44E8dGKD7wYKzis4o+
	oVVV587Z/iclSJpmyyOM73NTIS9AiYJpaZK4BaoZZJhIyMFUDgW/rg51DzLvn60Seat5aRkFGeA
	dpK+zjfBLpM60mUagPCZiBGFZ08ah2Jw0jilGLpTr5LvXP5qIfOcXFW//lMuF+U35X9uyFpweOE
	/ZYCLpNvwjk0gpiwiQ/nkKKRBjLaXFTUpldrKpK028fVPEGAoXe87IYqvx1WeTvVDWaE87kQb61
	W8jz85D4lwTBTj5sH8IYiw6gcJjv6cOENp1yVcHyY6MCxrcFOokh/HH6FYgDxuknhO2bVfw/WA2
	RU5i8xGzY3thqbV7owCxBqN9LonmzZ75OG5hdSFdYdVFOQpVMAr3zdIfnM+0YePykgd7ybozVwH
	QvieZU544vVBFS2NlBUkqooUdTtb6YQThU5nnX6RFkmQAUoVCraXCrRZ1gGno8xC3C+XM=
X-Received: by 2002:a05:600c:6096:b0:48a:592c:e63d with SMTP id 5b1f17b1804b1-48fc9a30d10mr22234605e9.14.1778651858485;
        Tue, 12 May 2026 22:57:38 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([31.7.57.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120f1f9sm38447271f8f.24.2026.05.12.22.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 22:57:38 -0700 (PDT)
From: Valery Borovsky <vebohr@gmail.com>
To: mchehab@kernel.org,
	crope@iki.fi,
	linux-media@vger.kernel.org
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Valery Borovsky <vebohr@gmail.com>
Subject: [PATCH] media: rtl2832_sdr: release URBs and stream buffers on start_streaming() failure
Date: Wed, 13 May 2026 08:57:33 +0300
Message-ID: <20260513055733.146905-1-vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CAFA252DDDC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-246753-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

rtl2832_sdr_start_streaming() calls rtl2832_sdr_alloc_stream_bufs(),
rtl2832_sdr_alloc_urbs() and rtl2832_sdr_submit_urbs() in sequence and
shares a single err: label that only unlocks the mutex and returns.
When alloc_urbs() succeeds but submit_urbs() fails, or when alloc_urbs()
itself returns -ENOMEM after alloc_stream_bufs() has already succeeded,
the URBs and/or the coherent DMA stream buffers stay allocated while
streaming reports failure to vb2. Two latent defects follow on the next
VIDIOC_STREAMON:

1) rtl2832_sdr_alloc_stream_bufs() unconditionally resets dev->buf_num
   to 0 and overwrites dev->buf_list[]/dev->dma_addr[], permanently
   leaking the coherent DMA memory allocated by the previous attempt.

2) rtl2832_sdr_alloc_urbs() never resets dev->urbs_initialized and only
   increments it. After a second successful pass urbs_initialized can
   exceed MAX_BULK_BUFS, so the subsequent rtl2832_sdr_free_urbs() walks
   from urbs_initialized - 1 down to 0 and reads past the end of
   dev->urb_list[], passing garbage pointers to usb_free_urb().

Mirror the teardown that stop_streaming() already performs: on the error
path call rtl2832_sdr_free_urbs() and rtl2832_sdr_free_stream_bufs()
before unlocking. Both helpers are idempotent (free_urbs kills and zeros
urbs_initialized; free_stream_bufs is gated on URB_BUF and clears the
buf_num counter), so partial-failure paths and the no-allocation paths
remain safe.

Issue identified by automated review of the INV-003 series at
https://sashiko.dev/

Fixes: 771138920eaf ("[media] rtl2832_sdr: Realtek RTL2832 SDR driver module")
Cc: stable@vger.kernel.org
Signed-off-by: Valery Borovsky <vebohr@gmail.com>
---
 drivers/media/dvb-frontends/rtl2832_sdr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/dvb-frontends/rtl2832_sdr.c b/drivers/media/dvb-frontends/rtl2832_sdr.c
index 422d1a7b5456..efcef1317cf9 100644
--- a/drivers/media/dvb-frontends/rtl2832_sdr.c
+++ b/drivers/media/dvb-frontends/rtl2832_sdr.c
@@ -900,7 +900,13 @@ static int rtl2832_sdr_start_streaming(struct vb2_queue *vq, unsigned int count)
 	if (ret)
 		goto err;
 
+	mutex_unlock(&dev->v4l2_lock);
+
+	return 0;
+
 err:
+	rtl2832_sdr_free_urbs(dev);
+	rtl2832_sdr_free_stream_bufs(dev);
 	mutex_unlock(&dev->v4l2_lock);
 
 	return ret;
-- 
2.51.0


