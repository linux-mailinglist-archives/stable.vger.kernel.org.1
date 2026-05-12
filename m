Return-Path: <stable+bounces-245465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJmOFcQeA2r10gEAu9opvQ
	(envelope-from <stable+bounces-245465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:36:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B363352043F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F09AA302C911
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE074C77AA;
	Tue, 12 May 2026 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dW7PLLon"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A5D3ACA6A
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589072; cv=none; b=gbL++H56Z7iXgWtHRnkT/6lL94tcSn30+1jP2tdLCmD39yAu8Bym2scjmL10ILQru4LaamFh2B94m6CdCh70eA+lLB9kHJH19Ldghz0TOxuLMalShUljAs93qq6eiWRUkZJ5LYaNcWn+EnVxFVe/qlRCebMKzGwH0LqBPMS5I1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589072; c=relaxed/simple;
	bh=IFsFHog5bWcK2c+UvvtP8pVeEWEu244YwzvaoyzplVs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BXgeU2UIz28WpRVDGnUVp1fCBFAvLy26UlFF4EcWoeCTOBWk65Usp/nRQdMopIjVm+3mLnuDyag2k/r5hUIZ55nRuPeGo3R1aT1USZZloOIBsuGzXsGnJjHO5p/ao92uJAE4QZze6NxMPMhrwrfbtUX70mX5cdnpGWH0YeCu0R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dW7PLLon; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a8891f0c51so5190355e87.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 05:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778589062; x=1779193862; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/IuY8V+yTw5VQSBZmRP6A8go4t9q9EJMmfoMaCV58p0=;
        b=dW7PLLong5LBWf6S/KKh0DDIgM0tlIPAA6ShEhhtQEY74m6XOpOVIWKxrwMYypvEV+
         4LjjTh8ToDAg1TqFzBLs0BRZvJUVO3QKQOvWOLJiipO43YdF9ESGNki5UJvllnulCyqH
         g4qS/7L7r0D9TRRlMtNnqZsGGGrgv1HbkJp6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778589062; x=1779193862;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IuY8V+yTw5VQSBZmRP6A8go4t9q9EJMmfoMaCV58p0=;
        b=PoVlK0bu+HaLEHY4xmfcKTd6NYTGJcpfycBZ22V8+n2hTRTLE9DO2xsNSRJen5bbOb
         onjGlj3MlDyKpdCxtwjUyYDN6ozHng75c5Ftfuq4H9bIA5dEgwC0zYvH0VbxuAkve+/c
         QQjmBK28mZqHgkOAVV4/KZDW1dPRhDlrUKqxtaEL9pvjLeYFm5htMaj2oky9e9CCniFP
         6wCZUKvKtNXCvIYJqrLOc35JoSVsT/nMYu2NFavuaFEQXnhZqY2YJU14aBwe0GZEHw5q
         Zi+BHCodSlBayV3BbmI8o/l/Gg47lbpDhROXWqHQOpykIRVCKqjvC4lTaTjKzo/Ea/aD
         mqvw==
X-Forwarded-Encrypted: i=1; AFNElJ/hMVkqiuz7+uSHe7w5lKxo9+aXc0CwL0XdAhQ3A4+Gns7Duc8HE2rqMgJrHySk/mNw9y6cc4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn4Qw3DDmMrX79m956IzDKtrFxWDhA2Y+uyL4LCb2S79Braatd
	aJU85myYw1PVfiyUJPybksOoHLwE5KtspuATIYBa1R2Fc2fb3b/dUwnGfJL0uj8U3IO/hKlZcIa
	Tk4BT1M7mlaU=
X-Gm-Gg: Acq92OGDyk1l5zbjuNDoF+xV4BADvDqGjs73xUaJfSVUWQ+uE5AL6n+aUnWcjZEOGXD
	luKwmL7VQ20gi/pBG167fMmW2n1kvOniw0YFmHWo2YvYz2+XBLbOYMjh2Ebq/MDDvVQGNi6+mLU
	D0h1iyJuPSdcO0iIopUwNKJ2KBV1pZcDUUqBgeWaGdH0z+rjv3uBEYJZWAlBqO7qOckVVPmEMCV
	c52ehb8YoSfcjIseWB13/ubW/kGjEdoAoReZxqHopx8G42s+9Fsf79xnfx6uulHIOiAIDI0CFJe
	NRSdtyM77Y+liFJu2oXdGtebNM4YnMlWLye++Yg27jv84E6yJU1zBPjm4OOTdO97Sb0ejYWJdT/
	JpLeCQmpJu0i9XO+zpdvAB4lcbPMl/px9dEOQZiC6J6ASwwAy0X6zofCA3/6Y0w+aro1R/sxZ0h
	ncLaaKZ3Ad1yUUb8z3FSN9PGODWGe7UsoUU3GJpfEPPUDOQKQKdT0GhvPfQo7gzkfyvS2aUePFH
	6T6kigR7o06
X-Received: by 2002:a05:6512:3046:b0:5a4:1914:bae3 with SMTP id 2adb3069b0e04-5a887ce5f32mr10157386e87.27.1778589061708;
        Tue, 12 May 2026 05:31:01 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8c66facc2sm1861344e87.22.2026.05.12.05.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:30:59 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/5] media: uvcvideo: Fixes for hw timestamping
Date: Tue, 12 May 2026 12:30:54 +0000
Message-Id: <20260512-uvc-hwtimestamp-v2-0-3c2905c733bb@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH4dA2oC/2WNyw6CMBBFf4XM2pp2eKkr/8OwaMpAZ1FKWqgaw
 r9biTuX5yT33A0iBaYIt2KDQIkj+ykDngowVk8jCe4zA0psZCmvYk1G2OfCjuKi3SwGrHuD7VC
 3SkFezYEGfh3FR5fZclx8eB8HSX3tr4XlXyspIYXWFVJ5aWqU1d3Y4B2v7uzDCN2+7x9oettEs
 QAAAA==
X-Change-ID: 20260309-uvc-hwtimestamp-f25dc27f5711
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Tomasz Figa <tfiga@chromium.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yunke Cao <yunkec@google.com>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org, Hans de Goede <johannes.goede@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: B363352043F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245465-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,chromium.org:mid,chromium.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This series introduces fixes for the hardware timestamp calculations.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Fix comments
- Add UCV_ prefix
- Improve commit messages
- Add "Do not run expensive code if not needed" patchset
- Link to v1: https://lore.kernel.org/r/20260323-uvc-hwtimestamp-v1-0-aa42e3865204@chromium.org

---
Ricardo Ribalda (5):
      media: uvcvideo: Fix dev_sof filtering in hw timestamp
      media: uvcvideo: Use hw timestaming if the clock buffer is full
      media: uvcvideo: Relax the constrains for interpolating the hw clock
      media: uvcvideo: Do not add clock samples with small sof delta
      media: uvcvideo: clock: Do not run expensive code if not needed

 drivers/media/usb/uvc/uvc_video.c | 77 +++++++++++++++++++++++++++++----------
 drivers/media/usb/uvc/uvcvideo.h  |  3 +-
 2 files changed, 59 insertions(+), 21 deletions(-)
---
base-commit: bc1ba628e37c93cf2abeb2c79716f49087f8a024
change-id: 20260309-uvc-hwtimestamp-f25dc27f5711

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


