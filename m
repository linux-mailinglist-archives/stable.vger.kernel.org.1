Return-Path: <stable+bounces-253966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M7eHOvbEWq+rQYAu9opvQ
	(envelope-from <stable+bounces-253966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 18:55:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E48DA5BFEA8
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 18:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 010A4302DF52
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 16:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B3C322B8C;
	Sat, 23 May 2026 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBzvroCc"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DAB1FE471
	for <stable@vger.kernel.org>; Sat, 23 May 2026 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555244; cv=none; b=bMV9KN6DFwNviV/l4JkuKu9xKHB2baZjUSrVlWufAtMCk2DaYxKx0h6EjEXD8EYsgFMNksfz9KdWSfuh88lozgHtfdA96CdZDvOc0xnVngdxhsoiJxRlTQ7rWPBA3iyq+0QSME6PHm8MCHSS5P+TEEfBLywXyIn0RMXJNSSeJCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555244; c=relaxed/simple;
	bh=0MwoAX/J5bzYEqSgxGhyDDvWiurQkDJFryudRPqqyec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FU38Q4PXGVjAcC30IHkPYBg3+4eGjqOLguKH144Y/Sh6cXaaybF+dqFRqJQhrk2ydh0Ry/Rflm0gqFFgM0DQgzrGNE3CtFJIea9TtYBahnMG7ADXPbTLFTpaSzpiHkJOsCWdiaUE0gdyAIylfiAHpnTnE8QsMHbLwRyhXjIHGXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBzvroCc; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-393a44854d2so74104281fa.3
        for <stable@vger.kernel.org>; Sat, 23 May 2026 09:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779555241; x=1780160041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUFxLs9xayiDL27YZLOgJaat3erm/tdOdPXhQ8ySemg=;
        b=eBzvroCcbMaioE1zTmmGAAnKkWj4XziwtoppjBPSUBHNYHhg3qi9Gr7E4g8wZFVOI4
         ALMeVu73nA43EsF/pRe4mkwoV994r0VTNuts1NXsKIn954nW7koCN3vxRMpvbfxKu80w
         xycee3g/DQ1wJdk4Gvggg52Tl9GCgp8uVcKV9GpDx75STxoWMmYaDC2wZcyDaF3lWv1u
         HKsOR6yusvCSw1CCgHUg7opcGZmaKT68NehG9qh7dRmTS/4FcDL1vSHCbeM2H3zuF2Z4
         BncHO7uvwvCjdO2C56tEpR/7QGuJKE9ES6B+NsFSwfxMnyVJ+EWtvOPLHiilwP4Rjg3b
         cBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779555241; x=1780160041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dUFxLs9xayiDL27YZLOgJaat3erm/tdOdPXhQ8ySemg=;
        b=E4Tyfwd6fmdhiZdNgN+ScW+VZ8ZvIxcjKZgzjv6pvf+y2hUwH1z8Ow45IsRT4Svma2
         F7M8Z+kNcXmbLhHHtN4Bkl1JpCijt5zOMWYKErX6eXPKigulLTXn2PvoJmu62nX6pcEO
         OUT7RS1/V/Q6DXNl3nLlK/SJ+MiOYSBAEBVYLS+kYaiaavT0lGAMvOJutEdvB+3risGg
         9wMf6MUhqM7CIoodL7XIEc+qwL5MVp+TBZB6Spy+oxIBD2fjHG7Av8o5sjozCZfWTdNo
         uUwJTMyaHrv6iFw99xw0xfTO+uO4miFd+B0revOwyfcPln70fWYqQ6I19k1A3O9MoCYb
         ULTg==
X-Forwarded-Encrypted: i=1; AFNElJ9YLt7V6VMzjkPCDxK3ktfMlWyCgoqMQmNr72lW9RfS3ZHSMnyS/I2zV4qHzrwzziN5HPqvsdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmsLUGMZwi93iGZ+3Rr7iLcYbzUvm+sjKlj2IxMZn8rpgfrBMV
	2b1fHqIjazrxMePJ1UgFaZv98dx49xkAe9pOkC5RUe9NioxnEP9blgpV
X-Gm-Gg: Acq92OHWDCGgAFDk8+g3FHU60juU+jSZnw7yPWs3kG6yVZdADwinwMeaSphyHALxMxI
	DlOKSYQavGoXbazQPPrw4OemGon9QmoN+IvolJ/i8Iv9pQ/v8p5W0NHMdlQLBsglhUQFFQEP1em
	/yzUUXcML7rEMnzaN71AQGXnh/Ww0gIhmNDvOMfyl3s+/TLOu+1mgO8HX+n6RpqYILI9fZmx3hC
	fhCdTYdfrT+seMEDiU3K6jIW0ERjl9jTa2+gYkSpooo40kek2xnPWwL9zi2PAN1PhLY+oH0vBGA
	xRJVaSQJ+MWZxYvgWC1Z2Hd+LTDSEg1TGSJceoZ6RUO39HUUPYfzXmQK9zYov7D7Q+BKHsWgLxl
	3M3EO2C7MqBuI3dyKxOHdtMwjDMZE4DrSgUIZo6w0z+o4ezHQ4YjYVAj5B0TG7S1eOaSpPUc/iW
	baQnYPEiJvTRsw1u5RsLrcIkI2je3ngFbsB0/iZDr48p88ddpd4TNG49Uh+e9jqNrMogNe0g==
X-Received: by 2002:a05:651c:222c:b0:393:a4f5:3e0f with SMTP id 38308e7fff4ca-395d8c35f3fmr27895731fa.2.1779555241189;
        Sat, 23 May 2026 09:54:01 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dcc2c6efsm12092981fa.29.2026.05.23.09.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 09:54:00 -0700 (PDT)
From: Valery Borovsky <vebohr@gmail.com>
To: mchehab@kernel.org,
	crope@iki.fi
Cc: hverkuil+cisco@kernel.org,
	linux-media@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: rtl2832_sdr: release URBs and stream buffers on start_streaming() failure
Date: Sat, 23 May 2026 19:53:58 +0300
Message-ID: <20260523165358.286293-1-vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513055733.146905-1-vebohr@gmail.com>
References: <20260513055733.146905-1-vebohr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253966-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E48DA5BFEA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Changes since v1
(https://lore.kernel.org/linux-media/20260513055733.146905-1-vebohr@gmail.com/):
- Rebased on media-committers/next. The err: label in
  rtl2832_sdr_start_streaming() now also calls
  rtl2832_sdr_cleanup_queued_bufs(dev, VB2_BUF_STATE_QUEUED) from
  commit 33ca0aab6f4b ("media: rtl2832_sdr: Return queued buffers on
  start_streaming() failure"); free_urbs()/free_stream_bufs() are placed
  before that cleanup, matching the order in stop_streaming(). No
  semantic change to v1.

 drivers/media/dvb-frontends/rtl2832_sdr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/dvb-frontends/rtl2832_sdr.c b/drivers/media/dvb-frontends/rtl2832_sdr.c
index c564485e3bbb..036b67a17b7a 100644
--- a/drivers/media/dvb-frontends/rtl2832_sdr.c
+++ b/drivers/media/dvb-frontends/rtl2832_sdr.c
@@ -906,9 +906,12 @@ static int rtl2832_sdr_start_streaming(struct vb2_queue *vq, unsigned int count)
 		goto err;
 
 	mutex_unlock(&dev->v4l2_lock);
+
 	return 0;
 
 err:
+	rtl2832_sdr_free_urbs(dev);
+	rtl2832_sdr_free_stream_bufs(dev);
 	rtl2832_sdr_cleanup_queued_bufs(dev, VB2_BUF_STATE_QUEUED);
 	mutex_unlock(&dev->v4l2_lock);
 
-- 
2.51.0


