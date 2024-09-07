Return-Path: <stable+bounces-73827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831A897027F
	for <lists+stable@lfdr.de>; Sat,  7 Sep 2024 15:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABA1282F61
	for <lists+stable@lfdr.de>; Sat,  7 Sep 2024 13:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B1015B98F;
	Sat,  7 Sep 2024 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8rHX6Y2"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127EDA93D
	for <stable@vger.kernel.org>; Sat,  7 Sep 2024 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725716917; cv=none; b=ScXWTiXBJPvq7nBy5LljScDIwdP91jhiCNWqjDF7Pw1NVfXxGRBl4B4x6JSjY0D7K8mx4KoUMdqNM+Z3Xc4VvFICXMJ+dQyBKSIyvGo8lW91WprbMsyzA6iuFVrgwNB52ZJipFQ24CMe6H8BiYomLMbcXZ03kXX9nsNluYhOu4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725716917; c=relaxed/simple;
	bh=aFp9KLbrETCUa3lkD2i+hUni3MVQRH66/4924UNX8fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsOLKyidVvw8/nuHRoxftWqdbmWrEceeD5ceTJnv0OJY3jr3ZJJLybty1YR51cauJMtihGR9H56QE1jm1K09L1hn4ORXwjPRBh45thLpHRi9jN2i8w5dXj6iqkq0UZrH4OsB8yeg5ws2FtuTbHWWE0a9Cf/QABjttnlOZWrIpwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8rHX6Y2; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-45815723c87so10764821cf.0
        for <stable@vger.kernel.org>; Sat, 07 Sep 2024 06:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725716914; x=1726321714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fS/OA3BsrI6pzbMDPFKPV5GdDCe3zSgljORI2lN/SEo=;
        b=T8rHX6Y2J/Mvyh/qFuMCh2lmB4JxdXAitvCwHS8NYz1Ah7lOQh8ht9oB42zKTxt2jr
         uTCEyyY5a+UcpSAIRXzd+yrDsRJ6tw0cy2xz3jZc9aSKzhpUUhQZkkAyp02qvflUgMWJ
         Wj3PHTcLMIMC2MIG/mTszGNG+3Zx/+8lFZLsbAfIsnJHLm5Rh/O+tKosCgusGZOb3wOX
         gFkMxIAqHCCWEbOITYaLWhytX0cmyHUNGAWHz7LhYjhbhYSx+qt7d38ZOs1DJPbAWj9N
         ZL93qpr1uQVQAE2Q4Hq/LzcOE7pX2xYj7epc8mbBZNGpTg58+rqw/v0FCJ2jejyP/u73
         io3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725716914; x=1726321714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fS/OA3BsrI6pzbMDPFKPV5GdDCe3zSgljORI2lN/SEo=;
        b=ggtQdhrhK375aeVMSnUsIZN33cETj3IgkvwAPGqTp60gigTqJr4r7SuYDa0BpP8rX2
         lSM9GwE861/FGjibOBNUDdXx6g4Cp9TtIoTI39pD602o2WhBFixtO0zr1KoMuHAV5YS9
         CJK/6HWXX2HPsOd1zf4nsYC8N/MicvvP4hYg9DguIZ5k1NUhdSnQT5llZK3cC5xSbyGb
         VRRRviiuhzK/eH3i0zMwz7qzTojoep9M6A259Oa3zPFihXjpqlPL/MaEUXqle1YVQi/f
         8FO2eP8UloXVdGqY5AWKHF72qfEaWERvBgBBjfqH2lqG15ry4YqcgiDbHiPpLyWK86sN
         QC4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7jZbpLcCVIc+o+czodPZWcBKkjEmPJ5V+HJkUAuW0z77d3rJnwWMmUU571l09okSQI0olsz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg4ZkDkibjZteQ6Q0zb4VDmf9UZAuDRAkdqz2y52enpPY+NCAk
	sDw06Ho9r0Zg+cGgXJrsdj6VHP5jQaAWvUZFFj3KwgNBsjjm1jFC
X-Google-Smtp-Source: AGHT+IFYAVjViso5yashKI1cy82Ue9rUvQKnhsWtdD2mCfjcDosLzieTwdV0ePLT0+92kcf05IErmg==
X-Received: by 2002:a05:622a:54a:b0:447:e003:ed8f with SMTP id d75a77b69052e-457f8c639b4mr197237141cf.19.1725716913773;
        Sat, 07 Sep 2024 06:48:33 -0700 (PDT)
Received: from shine.lan (216-15-0-36.s8994.c3-0.slvr-cbr1.lnh-slvr.md.cable.rcncustomer.com. [216.15.0.36])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e655e1sm4447541cf.16.2024.09.07.06.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 06:48:32 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: arthurborsboom@gmail.com
Cc: oleksandr_andrushchenko@epam.com,
	xen-devel@lists.xenproject.org,
	Jason Andryuk <jason.andryuk@amd.com>,
	stable@vger.kernel.org
Subject: [xen_fbfront] - Xen PVH VM: kernel upgrade 6.9.10 > 6.10.7 results in crash
Date: Sat,  7 Sep 2024 09:47:56 -0400
Message-ID: <20240907134756.46949-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CALUcmUncX=LkXWeiSiTKsDY-cOe8QksWhFvcCneOKfrKd0ZajA@mail.gmail.com>
References: <CALUcmUncX=LkXWeiSiTKsDY-cOe8QksWhFvcCneOKfrKd0ZajA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Andryuk <jason.andryuk@amd.com>

Hi Arthur,

Can you give the patch below a try?  If it works, please respond with a
Tested-by.  I'll then submit it with your Reported-by and Tested-by.

Thanks,
Jason

[PATCH] fbdev/xen-fbfront: Assign fb_info->device

Probing xen-fbfront faults in video_is_primary_device().  The passed-in
struct device is NULL since xen-fbfront doesn't assign it and the
memory is kzalloc()-ed.  Assign fb_info->device to avoid this.

This was exposed by the conversion of fb_is_primary_device() to
video_is_primary_device() which dropped a NULL check for struct device.

Fixes: f178e96de7f0 ("arch: Remove struct fb_info from video helpers")
CC: stable@vger.kernel.org
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
The other option would be to re-instate the NULL check in
video_is_primary_device()
---
 drivers/video/fbdev/xen-fbfront.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
index 66d4628a96ae..c90f48ebb15e 100644
--- a/drivers/video/fbdev/xen-fbfront.c
+++ b/drivers/video/fbdev/xen-fbfront.c
@@ -407,6 +407,7 @@ static int xenfb_probe(struct xenbus_device *dev,
 	/* complete the abuse: */
 	fb_info->pseudo_palette = fb_info->par;
 	fb_info->par = info;
+	fb_info->device = &dev->dev;
 
 	fb_info->screen_buffer = info->fb;
 
-- 
2.43.0


