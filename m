Return-Path: <stable+bounces-253964-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MD6KJvbEWq0rQYAu9opvQ
	(envelope-from <stable+bounces-253964-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 18:53:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7905BFE5D
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 18:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A30E23007BA2
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 16:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C14631F989;
	Sat, 23 May 2026 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZOJIAyf"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7646316189
	for <stable@vger.kernel.org>; Sat, 23 May 2026 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555223; cv=none; b=OYWfLHKOQ2/4yHDn8Z++dLZu9FYScRVL1J8b/Ql2GHTtlpkqEYVF0NIwcsVf48KbrVnc6z4X6xnU7Sjf7jwSIP4nOFxorHgRfnW68s0iK0H2m2x7s8tJ+cbfdlhdd4NZPnIavIcGwk+WkMbvFwVpn7ZUzK8Kyqw2HNzxjLPrsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555223; c=relaxed/simple;
	bh=som4gKyO96dhfc0ih3Y9ugIff6/5J1vxdGe58HMxGPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIZELQq+79YSCVisO87hXHsObM+1B4JVTrtFXr2ZhN1XG/ymX76iG8zJyfAR8McA6MpYpVsMNhaKjDbv5mFKSTRwbyLyYNj5LYhliagdc/GCLIrJcBN992HiQCYptGwpyc6FPY8m3Wp6ivOiixZYsjOlsbei+99UvukiFX8043o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZOJIAyf; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a8dc2606a0so8814307e87.2
        for <stable@vger.kernel.org>; Sat, 23 May 2026 09:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779555220; x=1780160020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utnaPVtluIiTyEzwOhIMr0EOUnXAQ6TiN8kOxttnpoQ=;
        b=LZOJIAyf4mfLtwE2dXfVaB3lTmmoSi4T//KX4/gyBmnmdD15NHNgbIkaZa16M314jZ
         gRylO7Ku79zYnlkPnEWWsGacu5TfuaYMoHS08iU22EaS3leNquXEHkDFlQnD6/xYwVHk
         ocq99hcZdYDpOn/i3rrtpUCkKbDOYrm2UxI7bq8X9WB8bjTKi1I3YbKC2Qy6DOBUP7N+
         lHRSNvONDZJiJwErmzZB5ySlpUIg0zE4WD+mynZOJM6r1DgsTkTxZUmUr/DFsc8Wz9iE
         xTInViUA2BFQIK6fP0SxqEoyMlZjnWmbX+Rwfyh7ku2hz5CJRI0S1KHkgPXGUKBdwjnX
         ZtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779555220; x=1780160020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=utnaPVtluIiTyEzwOhIMr0EOUnXAQ6TiN8kOxttnpoQ=;
        b=k6IsBZQpy8ZV76Br0DuDOB0ArvaQr3YKTthLngpHLpYSDsHfWAgE3M95rxUrkh6ov+
         GOesD7u5WPS3ay9Kubo9UCmgynJgoPZ0jK6X+c4SeopbB3ebJoASlsTFzosmy/z6HBkY
         B1+HqUYqKzL2Xyb9mNE3oEqsbHAvfvXFJqlM4V3efT7cgZBdK5jeFKCtTJ58h1Bp8PO/
         Cl3hy52NXEgLsR4+YvGIfcxLbE4ajR9PwectAUu56SmW9Imumn04SBLi0MAdhwXSPmKI
         TfO5BFwLMns0BMrR7HDurzaoONeVJnSzDwLjDIU1bwCIk/KonqGXymweA3F4C97tfCnQ
         FeMg==
X-Forwarded-Encrypted: i=1; AFNElJ9MuWbUqU3v54VOCOd/8TlJwxU1yVlmXgsHygoPx9SbY3+akQV5uVta8UIG7pSNUq6mUif0Mqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx00ERdvU5qvTHUcFNJHUSzqrcVC32QnJZgoEQ6y/xxeiIzsrWG
	pVND6ghrh/YmLVQAhr6aTqzABVsovCDej93BZYJldr5AOhGg5h6PWQLn
X-Gm-Gg: Acq92OElG9nz+Nk75wc9ppV3BO4oWJwGdduu3UfArFuKl3kJox1WGFZKUFBAQJhTvSK
	7PxG7+UyuF6Y/58RO6+nL2ey8o/Mj7NxwabpsQlsZnoQYzVR8wSMFgFupwu2SFsLRq5kOKDV/Bn
	DUFMxKpI3LfzRBgMiAcWSIT96RHZQapBtiD8T/0mV1OOuucyWlyqO8+hQT6abJZymKDhMtqLv8+
	NYWqFP88rE8OtkLQCeM60dfrU6/XKK7gVGU5OGrWW9uTHnS5HrvmPE30sWu3HDJqgyp31kGrU6K
	Y6SGTxB7iYAARHyWg3yuXYt4IswETp8M8JlMUKEY86Im3ZPToLDmPU8acNAo8DyxH79ixQyI7dM
	zL85PRC+8wgVc+PN0KX4wIn9eXCJaVYaAxn3lYORa+hSynB6lgJMsR/GIVdNWcxkq9nLlAXRIpu
	Tpw7B5LYfg5QEJ9U3Gv7tjBFd6xJNSLluLxCxn7h6NXfgRGqZfFF3+ZH1wy/Q=
X-Received: by 2002:a05:6512:2147:b0:5aa:b6b:93c3 with SMTP id 2adb3069b0e04-5aa323aaec3mr1730104e87.45.1779555219626;
        Sat, 23 May 2026 09:53:39 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32ceb558sm1293839e87.41.2026.05.23.09.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 09:53:39 -0700 (PDT)
From: Valery Borovsky <vebohr@gmail.com>
To: mchehab@kernel.org,
	crope@iki.fi
Cc: hverkuil+cisco@kernel.org,
	linux-media@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: rtl2832_sdr: use vb2_video_unregister_device() on remove to fix DMA leak
Date: Sat, 23 May 2026 19:53:37 +0300
Message-ID: <20260523165337.286141-1-vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <3c427dde-54c5-4a63-bcab-dd0079593ba1@kernel.org>
References: <3c427dde-54c5-4a63-bcab-dd0079593ba1@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253964-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 3C7905BFE5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rtl2832_sdr_remove() runs on USB disconnect and clears dev->udev to
NULL before any pending streaming teardown has run. When user space
later closes its file descriptor, vb2 calls rtl2832_sdr_stop_streaming()
which in turn calls rtl2832_sdr_free_stream_bufs(). That helper releases
each coherent buffer with:

    usb_free_coherent(dev->udev, dev->buf_size,
                      dev->buf_list[dev->buf_num],
                      dev->dma_addr[dev->buf_num]);

usb_free_coherent() returns immediately when its dev argument is NULL,
so every DMA stream buffer that was live at disconnect is silently
leaked. The URBs allocated in rtl2832_sdr_alloc_urbs() outlive the
device for the same reason.

The rtl2832_sdr driver uses vb2_fop_release() in its file_operations,
so replace video_unregister_device(&dev->vdev) with
vb2_video_unregister_device(&dev->vdev) and move it before clearing
dev->udev. vb2_video_unregister_device() releases the vb2 queue, which
synchronously runs rtl2832_sdr_stop_streaming() if streaming is active,
so URBs and coherent DMA stream buffers are freed while dev->udev is
still valid.

vb2_video_unregister_device() locks vdev->queue->lock (vb_queue_lock)
internally, and stop_streaming() locks v4l2_lock, so the previous outer
mutex_lock(&dev->vb_queue_lock) / mutex_lock(&dev->v4l2_lock) pair
around the unregister sequence would self-deadlock and has been removed.
A short v4l2_lock critical section around dev->udev = NULL remains so
any ioctl path that still holds the file descriptor sees coherent state.

Issue identified by automated review of the INV-003 series at
https://sashiko.dev/

Fixes: 771138920eaf ("[media] rtl2832_sdr: Realtek RTL2832 SDR driver module")
Cc: stable@vger.kernel.org
Suggested-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Valery Borovsky <vebohr@gmail.com>
---
Changes since v1
(https://lore.kernel.org/linux-media/20260513055745.146998-1-vebohr@gmail.com/):
- Rewritten per Hans Verkuil's review
  (https://lore.kernel.org/linux-media/3c427dde-54c5-4a63-bcab-dd0079593ba1@kernel.org/):
  replace video_unregister_device() with vb2_video_unregister_device()
  and move it before clearing dev->udev, instead of open-coding the
  URB/DMA teardown. vb2_video_unregister_device() releases the queue,
  which synchronously calls stop_streaming() while dev->udev is still
  valid, so the explicit rtl2832_sdr_kill_urbs() /
  rtl2832_sdr_free_urbs() / rtl2832_sdr_free_stream_bufs() block from
  v1 is no longer needed.
- Dropped the outer mutex_lock(&dev->vb_queue_lock) /
  mutex_lock(&dev->v4l2_lock) around the unregister sequence:
  vb2_video_unregister_device() acquires vb_queue_lock internally and
  stop_streaming() acquires v4l2_lock, so holding either of those
  while calling the unregister helper self-deadlocks.
- Rebased on media-committers/next.

 drivers/media/dvb-frontends/rtl2832_sdr.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/media/dvb-frontends/rtl2832_sdr.c b/drivers/media/dvb-frontends/rtl2832_sdr.c
index c564485e3bbb..c1f5f07c42a8 100644
--- a/drivers/media/dvb-frontends/rtl2832_sdr.c
+++ b/drivers/media/dvb-frontends/rtl2832_sdr.c
@@ -1477,14 +1477,22 @@ static void rtl2832_sdr_remove(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "\n");
 
-	mutex_lock(&dev->vb_queue_lock);
+	/*
+	 * vb2_video_unregister_device() releases the vb2 queue, which
+	 * triggers rtl2832_sdr_stop_streaming() if streaming is active.
+	 * stop_streaming() uses dev->udev to free URBs and coherent DMA
+	 * stream buffers via usb_free_coherent(), so it must run before
+	 * dev->udev is cleared. vb2_video_unregister_device() locks
+	 * vb_queue_lock internally and stop_streaming() locks v4l2_lock,
+	 * so neither may be held by the caller.
+	 */
+	v4l2_device_disconnect(&dev->v4l2_dev);
+	vb2_video_unregister_device(&dev->vdev);
+
 	mutex_lock(&dev->v4l2_lock);
-	/* No need to keep the urbs around after disconnection */
 	dev->udev = NULL;
-	v4l2_device_disconnect(&dev->v4l2_dev);
-	video_unregister_device(&dev->vdev);
 	mutex_unlock(&dev->v4l2_lock);
-	mutex_unlock(&dev->vb_queue_lock);
+
 	v4l2_device_put(&dev->v4l2_dev);
 	module_put(pdev->dev.parent->driver->owner);
 }
-- 
2.51.0


