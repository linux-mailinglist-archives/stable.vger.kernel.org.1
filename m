Return-Path: <stable+bounces-98139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0329E2931
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E405A2842FE
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7057A1FC109;
	Tue,  3 Dec 2024 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qygmHYjK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDA61FAC45
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246812; cv=none; b=ZEk7IHKMpu0QRC7lK99Eh0YxHD1dJ1DNq5q9SHLl7lSDas+2tBpEHrmmRmyii9WcxkaQvU2Euu8+8OHosKzFjs30bqUgxzRDPnRaOzvTzk1DPVt6AOEr4A6gjdreQiEfyeyH1nTKk8h5NlXCxLflJMpS7Dbx6Cty0Tbhby/1efk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246812; c=relaxed/simple;
	bh=3m/LMLlH/7jMESx6X9fIIIIib4hfJn5luoPUIkkkDds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NGeDuRYbj0u2KUyzyeGPmTjt7w8qcaJnFWy+OoBmPHUeXitj8C9ei09RTQ4NA4lPue3SkW3IbmSjyEK8V8phIcObu3H/zED3AlaeptABgcGS5mlkFDhSguedNNulqMOso5acdDOAUF8owRrmwQtSGXdvIpenXTJKg3o2QGco9Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qygmHYjK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a9f9a225so56075e9.1
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 09:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733246809; x=1733851609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uM3+RQXTMnOQ47ZFii0e33qP4d5w9EjJgy5PSo8ovks=;
        b=qygmHYjKQarvwNSRKLUHpG64+r89RJ9syZWWveMgWVAAr3lExgEHLY8Zdbj5etLAMI
         NjRZK/MfCjZFZvRVxm4ruMI0VMGFsgp6REnI/lQSrzIZKxH3fYlJdX4wQlY5pD9eDvzY
         /bX4sO2JofKUVjmO2z0Z/doBzyGn+0flHjImQbq/tueHYe8qqu0FkfSdMs84/ogb+hC8
         /JMFFdD593bzZVSb7k852U4ikdcjLDQdEjRF99MNHVBRKmnIg9mQ5mfvcBfN0Bit0Itn
         vZBEGmOB2H7E1ZuIs4Tvv78gjrYabb0b2OSSn5xFKQ4/c4qzDLtZ5/dyIrhMj11wtFUh
         fY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733246809; x=1733851609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uM3+RQXTMnOQ47ZFii0e33qP4d5w9EjJgy5PSo8ovks=;
        b=oISlODmy9fg5HHgXDOvf7qXfhbcA3d6bB+BKeSQEqierBmG+SbDjpSGsozY5pYrBVd
         pR7VrazVM75utdP3bS9NtTp7XK5ww1AWIBmwhDL4VH2QlVzLjdsR/ho1pyLd021WqKGy
         Y71y2EWPSHUDoOQhnV7SkqVrEqUXWzDWY9E8huOcZg3yyHfRKxZoLqGKek8nQBaKJP7f
         V1Yg1AaFfTyxi/MxeE/QSI//Vill1oPSxGQEpHwdAnpMQ8CuTTrUbchVNax0V4kpopSI
         rWtekyL++OBpCar3tNiEZ6BJ9pV013YmZhp+LN9nQU/aZhVDiPXMXKIvtfb/XOrJukbi
         85MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQU7Jnv4MlTmSWLNQbjzxT1pLoV7Tc9AKwvTGYZPnxnzSPD5vQuIamqbKrP/zzQhYZ8bAeegw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2v3mY707sKFBcsg9ZfTlA38tmqt30+gIGfIAy5ELwhbY+LTtS
	fRN8Fks38lMMkFsEP0EPJJJOCZdn7SK5Ii9nv1eREXuytRq3Br4K3a+TkWdMYiKAFNo3G7z8umm
	h3/x3
X-Gm-Gg: ASbGnctNS5SJO1iQWhP6ciyNBnrfTcRyr1jQdd2JG583AyiFnVa9mXmBRoUVLZ2+Qg+
	ttfQXhKgBCVUfnnJhfxPOVk3T1C9qLwExkh+HGtGNU5quZzYnHeL21f//8CThoqGrZ1sYuqNB9m
	seHxaT5nNkApjUtNRVPTIOcrct93+AALHh5pPn4hhc8kgrVxhONwj9T/Wa1nWEO+Gc2TkVDAUsC
	4VAsAZ8NkzUCmG55EG61QWijUy11K0ziq65wA==
X-Google-Smtp-Source: AGHT+IHah3tfnWDLN3UKIDFtEX6OxzBKzVPQiPV9mkH1uPluyyoiP9zAGpDGGtbXeYMGH6VNL1bEUg==
X-Received: by 2002:a7b:cc83:0:b0:434:9d76:5031 with SMTP id 5b1f17b1804b1-434d12b8d88mr1204455e9.1.1733246808530;
        Tue, 03 Dec 2024 09:26:48 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:92ba:3294:39ee:2d61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a522sm15986910f8f.52.2024.12.03.09.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 09:26:48 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Tue, 03 Dec 2024 18:25:36 +0100
Subject: [PATCH 2/3] udmabuf: also check for F_SEAL_FUTURE_WRITE
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-udmabuf-fixes-v1-2-f99281c345aa@google.com>
References: <20241203-udmabuf-fixes-v1-0-f99281c345aa@google.com>
In-Reply-To: <20241203-udmabuf-fixes-v1-0-f99281c345aa@google.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 John Stultz <john.stultz@linaro.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733246802; l=976;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=3m/LMLlH/7jMESx6X9fIIIIib4hfJn5luoPUIkkkDds=;
 b=C68RSNAz5tSn7/At1pT+/cqpyr2/1yVHxrn2ThIXppaycwhw+jpyJIrVQd0vwYT6uWunp7bMu
 gPYbSI141ikD1YI6YQFzt61WVCUN7ejJNigEshkNyhdAZUVB/Jcx0OG
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

When F_SEAL_FUTURE_WRITE was introduced, it was overlooked that udmabuf
must reject memfds with this flag, just like ones with F_SEAL_WRITE.
Fix it by adding F_SEAL_FUTURE_WRITE to SEALS_DENIED.

Fixes: ab3948f58ff8 ("mm/memfd: add an F_SEAL_FUTURE_WRITE seal to memfd")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/dma-buf/udmabuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 662b9a26e06668bf59ab36d07c0648c7b02ee5ae..8ce77f5837d71a73be677cad014e05f29706057d 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -297,7 +297,7 @@ static const struct dma_buf_ops udmabuf_ops = {
 };
 
 #define SEALS_WANTED (F_SEAL_SHRINK)
-#define SEALS_DENIED (F_SEAL_WRITE)
+#define SEALS_DENIED (F_SEAL_WRITE|F_SEAL_FUTURE_WRITE)
 
 static int check_memfd_seals(struct file *memfd)
 {

-- 
2.47.0.338.g60cca15819-goog


