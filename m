Return-Path: <stable+bounces-245304-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHJsOxUOAmoSngEAu9opvQ
	(envelope-from <stable+bounces-245304-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:12:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A02513276
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2693300E004
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345CE44CF44;
	Mon, 11 May 2026 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcrY5pQu"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8205942E013
	for <stable@vger.kernel.org>; Mon, 11 May 2026 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519540; cv=none; b=fa9AtRw5oShILI7ptNn1iQJLlweZWb6qU/eMa1+diyZwQVwcxjbptKfGHfDDUZ0KrRL81WuQXJO16/x92xqsNW4N3UymDyNgAt7UeYSkIXkWqzR3cOnndt/lXSmfbtMyvE1sFe8O9ig7HtrRhjXAa8vX/iCqqzd5nVoB+H8P8Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519540; c=relaxed/simple;
	bh=qSesX2ZDGhaCZrzr8oezoBtstChG//vMkmqR9KwS7d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B859YCDbBQQcqYcLOcxqep+TkEuqKwA0tIEte3JlQ2KdADB18+UiSeqh1yIUad7lQL4XfvuTAYY8SbYOPaShXGt4SoETfmiNUNPXG9DKQb4fh6FxlZE97rrdwu+uB0BU2NSV6OzwXNC7JqtJCurplBuZaNG+gGtjItQBm/oKgX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcrY5pQu; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a746f9c092so7192004e87.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 10:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519536; x=1779124336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s42sCXaEIYI2iT8o/2WjdzJavucMWxgVZFV2JYX3rF8=;
        b=KcrY5pQueoCa4MoLMldHSXm4iJ3/EjEqLttwIT098h1TCW6DCISHfy/6r+bVPtjZUx
         PXi9OeeW1CItkGfm2MWvoFrFhJk0H9QqqUMAueQeyRld7+9UTuOOYD+1coRjUw9UX3DU
         9x/k4JKOtJGa5sXYnMiQSr4BeUEoHYuDchPWGlKMiIW7+zSPdBN1x27qIGLmDSxNncgz
         IbEHIJCOj7xlCuHB0Lqar+7TJmC/O67BmkZ510AYqaOzqoKqHf1R2LPZC+gPfEG++zkj
         QDhJuWdx6moAHmvyIvwEEnp+LalJIPiTqwp82itG6QHvpJRcRxvsHG87VOi8pEiQg03I
         YYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519536; x=1779124336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s42sCXaEIYI2iT8o/2WjdzJavucMWxgVZFV2JYX3rF8=;
        b=GVYRy5/O7lXd2AUdbmkesl/O+Zf7MtduuZN+hyqHbZ9RXYjNM2rLSCMslYDoK9sufm
         qZ0Mw9UaKCv3AmMpdXYc4MeOshMWb62yeQCA+g3OIzq632Yz6Bbl6BU9uRv+3ciMwoj+
         nxs2ZbexJ4d6tQqisfiOFs4KuFdojGhSpaTImOqZ56vqEOaTKjfOBKX8m5ZqSBpCg3n+
         3ERkP7k0X1DI+RDDKekg+K0Jj6tfRUMj0r0WgkTn+qrdFz+Ns/hwkAraSSFqRM7A0aHl
         GqnQ1emf8NgEJvHbfxLs7cEymzp4DroLIJoGieR1JlHyrTDnbD5VMjA6EQINq/T+U6j4
         lkyw==
X-Forwarded-Encrypted: i=1; AFNElJ+kZBJQpS8vE++pMBIBwO633eo+/lqoOvFzsDtBL7ehIPIZdbUBAWFlyJ2ZiV4d25rumiqhGdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjTv0v38q9QlRizDiavgM070GcowMjtZ+lui3FsWMIBPfDM60c
	6WUxzX+nXv/Ncc5skT9gCum2ZeZLJVmIjth3srWUjBgeBblnfoMh0PwG
X-Gm-Gg: Acq92OFkWP1853Bozk4Xadck4kw0V7Di4zkuy4IrW/Ty2s7vwQFVyj/QGrgjeRs7YGS
	2r3/lQwMuNY7sYzOHqFoKoeRa0t1g0nhBiLXfk7PrevtvG749JoE7Za/27tYWW+LAvijyiH1Gf2
	UQdjBmpma7tROMe4olayiM40wJ4b8wE+eC16NCxXsIaSXONwU55Git/jcbzLu4ROIvy38i2eDNg
	McEia7rsmQ2nvVEjVb8O3MYw6fHW6feJM4ba5YCrp1l+ezTSz2XKAEPdE+x1QfJupwKcQLu3LQx
	vXy3j/0XzTSG1lNTVc04jk7BOs0MWVBBv7XvrhpDmxt1oWQq68eGT+C+bT0FzveAXrwb+Y4Wmxr
	WP+jYONPqEA7iYUfHmn2ou60Gh28VvPgHcb8bjbZKK1LyRncnYy5pvNJFO8BErZt2DvcvSFmOiD
	QEuLgBUCNVGJGqjARu6ORhaDHhReCp3LWltPvu5Sj2z9BuVP0sCHWd3PevYNmxOgYY5jTtBZI=
X-Received: by 2002:a05:6512:a8c:b0:5a8:99dd:1648 with SMTP id 2adb3069b0e04-5a8e0c8c320mr110927e87.0.1778519535453;
        Mon, 11 May 2026 10:12:15 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a95660b6sm2765488e87.62.2026.05.11.10.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:12:15 -0700 (PDT)
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
Subject: [PATCH 1/6] media: airspy: Return queued buffers on start_streaming() failure
Date: Mon, 11 May 2026 20:12:06 +0300
Message-ID: <649601988189f031670215cb35add5e80439559d.1778518085.git.vebohr@gmail.com>
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
X-Rspamd-Queue-Id: 91A02513276
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
	TAGGED_FROM(0.00)[bounces-245304-lists,stable=lfdr.de];
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

airspy_start_streaming() returned -ENODEV early when the USB device had
been disconnected (s->udev == NULL) without returning any buffers that
buf_queue() had already accepted.  Take v4l2_lock first and jump to the
existing err_clear_bit label, which already drains s->queued_bufs via
vb2_buffer_done(..., VB2_BUF_STATE_QUEUED) before unlocking.

This mirrors the uvcvideo fix in commit 4cf3b6fd54eb ("media: uvcvideo:
Return queued buffers on start_streaming() failure").

Fixes: 634fe5033951 ("[media] airspy: AirSpy SDR driver")
Cc: stable@vger.kernel.org
Signed-off-by: Valery Borovsky <vebohr@gmail.com>
---
 drivers/media/usb/airspy/airspy.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/airspy/airspy.c b/drivers/media/usb/airspy/airspy.c
index 8f6b721ba107..57edb42463e8 100644
--- a/drivers/media/usb/airspy/airspy.c
+++ b/drivers/media/usb/airspy/airspy.c
@@ -522,11 +522,13 @@ static int airspy_start_streaming(struct vb2_queue *vq, unsigned int count)
 
 	dev_dbg(s->dev, "\n");
 
-	if (!s->udev)
-		return -ENODEV;
-
 	mutex_lock(&s->v4l2_lock);
 
+	if (!s->udev) {
+		ret = -ENODEV;
+		goto err_clear_bit;
+	}
+
 	s->sequence = 0;
 
 	set_bit(POWER_ON, &s->flags);
-- 
2.51.0


