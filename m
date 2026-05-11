Return-Path: <stable+bounces-245305-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBsoECAOAmoSngEAu9opvQ
	(envelope-from <stable+bounces-245305-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:13:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E3B5132A3
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE015301B359
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F48A43E9C8;
	Mon, 11 May 2026 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+V5Khs5"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FD644BCAF
	for <stable@vger.kernel.org>; Mon, 11 May 2026 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519540; cv=none; b=dEfpHbWnTCnZpIAndkii0NVFDAOghGtiSH3/sUSd0OqDznWrgZutej5v0ys0Brz/CkEfh5CFq8HAOqE7sNosb/grgRumL0dSURaiYe1qXcCKDNT2rixv4DkqRH3fwvQg0yNZ8Kt/uG1aJ0f1gvTby1YLHNlJaGjLCGciV+cTEw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519540; c=relaxed/simple;
	bh=4DlyG+iXICv8PFIjVe2HgIrTduPnzOhVbzvai6W3884=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9YLzFXqYzddnb3U5+nWPXCQn7Mqu61/20YGHbC24+QxecA7sZguqa+2FPb5l0Sv6NQasYXzyx4VRl7MplX/bFIq5CHudQr1jtOE/7NoTvxxsAwbeoxYdtQEeuHj2PFKTB8+lHwRK3kKw/TnT2qtqdp4sGvV1yhN+M3PamdILO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+V5Khs5; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38e7b0903cdso43832431fa.3
        for <stable@vger.kernel.org>; Mon, 11 May 2026 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519537; x=1779124337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSIxIJUh3eL2dSuA1xrUNZiqoyBIDeeVRxEk9r/yyRo=;
        b=M+V5Khs5sW5CnKNYTvSJ9U6Fhg9+w6YeNPtI+moPEmZTma0x4ZuGzYW+pwebfPyiYA
         8eollKjLl9KhXsmzQ/Rjf3ime4ya9qQGo9uDjf5dphnRc7UvKwyHWEDgcIrLd4Am9oku
         Ui4QPMIQtqYEepdYjipQDtBFQ+Ib78PD9EdFzC1AnaD83ZglGb30EF5YxvwUyReZtYQO
         bWJoeAPA/j2ZPTBdaHM40JY6VOqqrHokz9VHi89qMpi/YWzJvzVB3+qaY9X+MYC71ZvP
         muRD8uYuXzgt4YntFqhfVVrdQYippWpVhME6oC22IFY9KskzGfA46CXzFuZQCIjfxR8w
         7qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519537; x=1779124337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XSIxIJUh3eL2dSuA1xrUNZiqoyBIDeeVRxEk9r/yyRo=;
        b=rE9eMSPGKHaTPmwz697H6bk3Bi6jRL/+TkNLga4i/asKZAW2u4ogyvF3zNwCug10zH
         pZ56KRA73RPnNBuF+UKbgmolY/vqgoYHGG9oz57DnMZrM1alOT4JcFyMpPqkKF+0aFj6
         fBu5IL3oTnb1QZCEQc7fFXZ2UCygMLIGPJmYAppRZp3p2Ldl1K8Ulp+QYl+jfW7IdJpI
         RyPnb/6l3kYLOly9ZjjtcokckqcwxIQgM5Esz0kSamGY6faf/ohF0g0ONuMMzCFUERL/
         tkwe+Iw4EYDOgj6b36LUCWUt7bZOccDSYyayfVvbIHf3MwUn8oPpTT41i/IdAUocZ0MR
         e9/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/4ibC+Toie6ljb1T+bLqGMy9Czb+3nqC+E+ZywcMCKWdsuz2IDqVs6/lsbAxa43o/sHuF+gqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLhj02IjBZyHo2vNBiBnbOaWLB7Rs05C5K222Am0oTOnIcj5VX
	M0svE8J3/MqLrfV8Fm2IpkPN37ZZafPah90EQbr914ztHgahMJVcJelR
X-Gm-Gg: Acq92OFv+TUKidGuSxs8qAmyJz/UcJ7ISKoiN8GMKWu0bThrbtf/0BO+B7Xe+taKEmd
	16dHSDcD/vhVeHjmkFEF6By+uKJT+0GOKRyCYNxa7J+oX8wCszzZsiMQSWQb0ojVI0JvnSum1TM
	cMPNbwDeVfGxFVt6/KcYdx9EeTe4iYvBZ9/M9/DDvyIXvw3RzvUn90PHucznwbXfTPMfBgRky/Q
	m88SLSoJ10VBCmhHc6FSQrT4aaY/hcIpixAJw5bKgmrzTLZ69nO37SRqlnLSUoIOjWLJXAy4/qs
	JU5itpMZOyZOGjd+LNrgUPQ2P8RzfuDB8JsXbr2h34S60xwHi7aRbd6bLSFcOmKyxdxRG0Y7Gdz
	uyQJj5z6dg6s+itAQ2FVnNkpnga+9IFL2ll8oTGVuo9v3JlomOzef64bKrrnySPqNM4kiYzfK0O
	pbhXgDbjR/K7+d5HNDYNPTPv1xX4eHYCIfE2BuMqDQvTH1IeRXFYTi63ZeZpvZ
X-Received: by 2002:a05:6512:3ca1:b0:5a8:7be1:24c8 with SMTP id 2adb3069b0e04-5a887ceaa65mr9581194e87.37.1778519537055;
        Mon, 11 May 2026 10:12:17 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a95660b6sm2765488e87.62.2026.05.11.10.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:12:16 -0700 (PDT)
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
Subject: [PATCH 2/6] media: msi2500: Return queued buffers on start_streaming() failure
Date: Mon, 11 May 2026 20:12:07 +0300
Message-ID: <e3052e648c898900582b7bebb6890ff4042100c0.1778518085.git.vebohr@gmail.com>
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
X-Rspamd-Queue-Id: E2E3B5132A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,foss.st.com,gmail.com,linux.intel.com,sholland.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-245305-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The vb2 framework hands buffers to the driver via buf_queue() before
calling start_streaming().  If start_streaming() returns an error
without first returning those buffers via vb2_buffer_done(),
vb2_start_streaming() fires WARN_ON(owned_by_drv_count) and the queued
buffers leak.

msi2500_start_streaming() had five error paths that all hit this trap
and were further tangled by ret-overwriting between calls:

  - -ENODEV when the USB device was already disconnected
  - -ERESTARTSYS when mutex_lock_interruptible() was interrupted
  - msi2500_set_usb_adc() failure: ret was silently overwritten by
    the next call (msi2500_isoc_init), so the error was lost entirely
  - msi2500_isoc_init() failure: cleanup_queued_bufs was called, but
    the function then fell through to msi2500_ctrl_msg() and again
    masked the original error by overwriting ret
  - msi2500_ctrl_msg(CMD_START_STREAMING) failure: no cleanup at all,
    leaving isoc URBs submitted with no way for the driver to consume
    them

Consolidate the error paths into a small goto chain.  Every failure
now stops the function, drains the queued-buffer list, and returns
the real error code.  The ctrl_msg failure path also rolls back the
preceding msi2500_isoc_init() via msi2500_isoc_cleanup() before
unlocking and draining.

The cleanup helper takes a vb2_buffer_state argument so that the
start_streaming error paths can pass VB2_BUF_STATE_QUEUED (as
expected by userspace on start_streaming failure) while stop_streaming
keeps its existing VB2_BUF_STATE_ERROR semantics.

This mirrors the uvcvideo fix in commit 4cf3b6fd54eb ("media: uvcvideo:
Return queued buffers on start_streaming() failure").

Fixes: 977e444f59ad ("[media] Mirics MSi3101 SDR Dongle driver")
Cc: stable@vger.kernel.org
Signed-off-by: Valery Borovsky <vebohr@gmail.com>
---
 drivers/media/usb/msi2500/msi2500.c | 32 +++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/msi2500/msi2500.c b/drivers/media/usb/msi2500/msi2500.c
index 1ff98956b680..0614087c3c3c 100644
--- a/drivers/media/usb/msi2500/msi2500.c
+++ b/drivers/media/usb/msi2500/msi2500.c
@@ -541,7 +541,8 @@ static int msi2500_isoc_init(struct msi2500_dev *dev)
 }
 
 /* Must be called with vb_queue_lock hold */
-static void msi2500_cleanup_queued_bufs(struct msi2500_dev *dev)
+static void msi2500_cleanup_queued_bufs(struct msi2500_dev *dev,
+					enum vb2_buffer_state state)
 {
 	unsigned long flags;
 
@@ -554,7 +555,7 @@ static void msi2500_cleanup_queued_bufs(struct msi2500_dev *dev)
 		buf = list_entry(dev->queued_bufs.next,
 				 struct msi2500_frame_buf, list);
 		list_del(&buf->list);
-		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+		vb2_buffer_done(&buf->vb.vb2_buf, state);
 	}
 	spin_unlock_irqrestore(&dev->queued_bufs_lock, flags);
 }
@@ -830,25 +831,40 @@ static int msi2500_start_streaming(struct vb2_queue *vq, unsigned int count)
 
 	dev_dbg(dev->dev, "\n");
 
-	if (!dev->udev)
-		return -ENODEV;
+	if (!dev->udev) {
+		ret = -ENODEV;
+		goto err_cleanup;
+	}
 
-	if (mutex_lock_interruptible(&dev->v4l2_lock))
-		return -ERESTARTSYS;
+	if (mutex_lock_interruptible(&dev->v4l2_lock)) {
+		ret = -ERESTARTSYS;
+		goto err_cleanup;
+	}
 
 	/* wake-up tuner */
 	v4l2_subdev_call(dev->v4l2_subdev, core, s_power, 1);
 
 	ret = msi2500_set_usb_adc(dev);
+	if (ret)
+		goto err_unlock_cleanup;
 
 	ret = msi2500_isoc_init(dev);
 	if (ret)
-		msi2500_cleanup_queued_bufs(dev);
+		goto err_unlock_cleanup;
 
 	ret = msi2500_ctrl_msg(dev, CMD_START_STREAMING, 0);
+	if (ret)
+		goto err_isoc_cleanup;
 
 	mutex_unlock(&dev->v4l2_lock);
+	return 0;
 
+err_isoc_cleanup:
+	msi2500_isoc_cleanup(dev);
+err_unlock_cleanup:
+	mutex_unlock(&dev->v4l2_lock);
+err_cleanup:
+	msi2500_cleanup_queued_bufs(dev, VB2_BUF_STATE_QUEUED);
 	return ret;
 }
 
@@ -863,7 +879,7 @@ static void msi2500_stop_streaming(struct vb2_queue *vq)
 	if (dev->udev)
 		msi2500_isoc_cleanup(dev);
 
-	msi2500_cleanup_queued_bufs(dev);
+	msi2500_cleanup_queued_bufs(dev, VB2_BUF_STATE_ERROR);
 
 	/* according to tests, at least 700us delay is required  */
 	msleep(20);
-- 
2.51.0


