Return-Path: <stable+bounces-118704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E74A415CE
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 08:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E902D3B6354
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 07:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC83241663;
	Mon, 24 Feb 2025 07:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MrlsSQcZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6A20AF80
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380642; cv=none; b=bH2kZzDCENbcE5Tljgms59c2MPnfyqWgGoe6CKBpQGtLc5AY4KVhbIjPcCftFYvUYKGsjefS/JLwjeVMJPAnmnPdAuGNERyeYKiMMY7M/R5vyEphBiIxckPweD6eNJHXrVvfR8+jOCYsab9K6cbmbuda3d9Y4r8kEAXfAU7BQ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380642; c=relaxed/simple;
	bh=gxhapjJ2V7VmgaU4ygU27WoYv9liMFZHBLfXA9uaLac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m5AxCRZd4EtvbUYkAlPSSERuXl1mwu0Za1Ct5rbQxUupzRaDwn/6qapHs4Gg0+yMjYYn/w2ftKvPwLvX3OJj0nFLRx5pdCj8szQQ2Q+hTV/skbQBJyHgaqm+5pFFH1bR2IDPbRYVTH306dN5L8E9PYCQsqNnRAYO59Bi9Kfdxx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MrlsSQcZ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c2303a56d6so58044585a.3
        for <stable@vger.kernel.org>; Sun, 23 Feb 2025 23:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740380639; x=1740985439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zNBSiNN48vAuN3f6QiTHcLYM/YjS/mOVk8GlAcAGX0=;
        b=MrlsSQcZYiQPKGDyNH4bQfoY5eUpyg0fJk+ViixTJ8pRRnwQ6hQFWzK1U8yrVIMJ+H
         GUOsysBQGsWM2huhXAikce7Ne33qE9HoH0/7lh6EfNhMdhlp/8VdSpm13T+HevnEOEuB
         T+e5BrS7ntkCVfOY2qhPgK4IjT+TZitoNQV94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740380639; x=1740985439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zNBSiNN48vAuN3f6QiTHcLYM/YjS/mOVk8GlAcAGX0=;
        b=EzADUexMolLHPPO2DAxBBbTA0aT1t+w+d9ym2oKKlSgqcV9rRvsDCHxlHKdXNho0mf
         NL3MpzpEUpfMg/26RhQPkjebxoBxRxpxTJTE8Rg3s+Rcb43lVkdor44M+61UPObx395z
         /OrBdyGPhQvHmbqXSM2fwCDtDVJ/2XwBv1TCNHd6r2qp3g2JHoQGfmJYWRHQdZajK0c4
         cZSsuOV8xMgBOy8KwQBWUaPfc0nDclEzG8XWJmMma0xHNdmIrJ0V3qdE3UIxuuUUeKj3
         R685SVwVELwZpj3uFNsNnTihFNgBWgInHzren2VK59j5odbcLAUPjBV7V/uJwnzX/IJx
         f7Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWCKSbpovpNslp3WaMcooMq8Vlnu8CS8zR7eghJ9+/M5YpjEvZiT2qiKZ0JpghImAX4F+1tLms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoxEKy5a9YyUnQLuX4r8UROMuepmcoiFpeKwiJXzjRugOzhTj4
	REQzdNHctf98qfLjCnBoTT0jh8zjTnM7OgKKi6mnxSwDNTlW5PcaEoigiaQ/tw==
X-Gm-Gg: ASbGncsAlv2JdO9SQz35+Fz2yFhUmISogrDkjIUsKGM3a//d9Hg2XDMmhPFYbdfygsN
	K5CVmtJnrPd6df28XzQZk55nCRCvAQJFWM+X+B5dk9/7L+KMnIxvIkhq0wJwcF7ehzjPBAvdjA/
	0OP5V3QQsqDYvAPeQWEfESWTNygQtONwlbLI3DIPbuM8vY1Oo3lILTG/TqBC31aVJqIGU7LZuj1
	emXvFUGOA7z660VMfaIVsK3cam6ixBROdOj1hFsM82aOqgxaDeKoCiFuTpnY66ia6iEnF3Yd8Ud
	Sf9ess9cQEinXSwIu0UMKKXptq4SExwmDePcjB4Wo73nPkN190njytJOWJtGj7SXDGNiGfhP7QJ
	ynMc=
X-Google-Smtp-Source: AGHT+IHcm5l4vj+qLy5nO1kcV2ISxYp1Ig6V5tDSH+3S1QoU9rYnKzcGaZk0NeL01r9155s+2saw4Q==
X-Received: by 2002:a05:620a:488f:b0:7c0:b018:5928 with SMTP id af79cd13be357-7c0cf96eeacmr1637963085a.47.1740380639403;
        Sun, 23 Feb 2025 23:03:59 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bf81253sm977920485a.47.2025.02.23.23.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 23:03:58 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 24 Feb 2025 07:03:54 +0000
Subject: [PATCH v2 1/2] media: nuvoton: Fix reference handling of ece_node
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-nuvoton-v2-1-8faaa606be01@chromium.org>
References: <20250224-nuvoton-v2-0-8faaa606be01@chromium.org>
In-Reply-To: <20250224-nuvoton-v2-0-8faaa606be01@chromium.org>
To: Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marvin Lin <milkfafa@gmail.com>, linux-media@vger.kernel.org, 
 openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1

Make sure all the code paths call of_node_put().

Instead of manually calling of_node_put, use the __free macros/helpers.

Cc: stable@vger.kernel.org
Fixes: 46c15a4ff1f4 ("media: nuvoton: Add driver for NPCM video capture and encoding engine")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/nuvoton/npcm-video.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/nuvoton/npcm-video.c b/drivers/media/platform/nuvoton/npcm-video.c
index 024cd8ee1709..0547f119c38f 100644
--- a/drivers/media/platform/nuvoton/npcm-video.c
+++ b/drivers/media/platform/nuvoton/npcm-video.c
@@ -1648,8 +1648,8 @@ static int npcm_video_setup_video(struct npcm_video *video)
 
 static int npcm_video_ece_init(struct npcm_video *video)
 {
+	struct device_node *ece_node __free(device_node) = NULL;
 	struct device *dev = video->dev;
-	struct device_node *ece_node;
 	struct platform_device *ece_pdev;
 	void __iomem *regs;
 
@@ -1669,7 +1669,6 @@ static int npcm_video_ece_init(struct npcm_video *video)
 			dev_err(dev, "Failed to find ECE device\n");
 			return -ENODEV;
 		}
-		of_node_put(ece_node);
 
 		regs = devm_platform_ioremap_resource(ece_pdev, 0);
 		if (IS_ERR(regs)) {

-- 
2.48.1.601.g30ceb7b040-goog


