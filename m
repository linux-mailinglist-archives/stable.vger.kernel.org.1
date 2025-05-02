Return-Path: <stable+bounces-139454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23164AA6B5E
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 09:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99AF1BC045B
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 07:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E31267AE7;
	Fri,  2 May 2025 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CF7296w8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C45267393;
	Fri,  2 May 2025 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746169796; cv=none; b=Q0khg4NyITJBmE85FC44y1Tg3Oqx1MAiFOl/z5Fw5L1Ys5G8gjQLJcfpUdUExkfA0sbqZZIXjK2WFQtP8CwAp2tGwf7ysbh4pfFFCQHfb3mk/4VGk9uXqrWbC6P1y83qGkltpA790ZCjExycgsPDyLnPvkcLT6ddqGHoswFEWgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746169796; c=relaxed/simple;
	bh=uzVjkm7xuS851VrFWNmL0auSaJTNbIuq8hK/utJoN/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/+6D5qNg7BrHYrQoANEoc3Y6aAB6ZMbsWetXcnHI34FeIr1t0wReR6cUrB9WL2o41XpkuTIEXxy9BHSrGRIXvkmJoGts5xeQM2YM+TO0R0OiHvhDlaJNyoYZn9mApI/XL/blKlHRkPXiNLleb+w/Xsv2xVCyzAGlQvq5AivSPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CF7296w8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f62d3ed994so3078927a12.2;
        Fri, 02 May 2025 00:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746169793; x=1746774593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzt4aSgxAuWrJytcX/gjPBd3APIFdgE8OTpFBrBgGjo=;
        b=CF7296w8z9Exr8tgCdAjV2ZdHMsIygPZspGP337fcS+YR0FZKfQy3QP+RWpedx0d/t
         XFIW95Yj368L+hFvqTRpQGVPOwxqleV36BTvb71e4EujFma3/DUU+DGxvAfFyEJRh1EQ
         H34un/1K4NIwRpv0qvdhS7PYQXfWoXeD+IYbAv9O/RtX/tQe7f0UlV5MLAreu/iOlWLH
         5FDcDxTSTtbA5kEx+RDRrzRO1RffWOgqjTHCeKKNlkKDORbXyW46q60f3ltyUPk/7R2J
         X9Zp6WmMVzRNkVEPbCgC15RrgA5X21lbXbpr3Nzbw1KnK6n7+Do+oShFoEMDAsDD4/py
         eCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746169793; x=1746774593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzt4aSgxAuWrJytcX/gjPBd3APIFdgE8OTpFBrBgGjo=;
        b=lr8Mct2GmmZf5ta2p9Z1ZjZR9mVLzEVjqqjFoMjR6inlbqJMy8S3rX5SXmzM0rUgkx
         QQB2dp9DGoL7xJ0+1jGUfcx1cxzVxpoNFY7jJbYGSWSVXTVM2w81tCPlU5fZhSQEqMym
         Hu7yZ9fvrxN5q9T6sHhwEplAjBENESCSdiUNhiWo2fXPZESEHDQ3OJZz+dlM/30eIVth
         xwy3Kyp3/901tcgRPxT27S/CBa12On3sp9pqRaaoH6Ewp9T4syASo+1A6jKyITI9lQYt
         9tF/VinEIiuwGEobzcCl58c5VatNDM4iwiUhASAd2jLQLkhcOA1954IvuT6DIqXDHwwV
         r8QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb+w95LpjNad85kPoBAtZqXRVYYCD7In46FHFvnpU1vjXgtRaXUIxWMSQwGFQG8nUi/sBgusPG@vger.kernel.org, AJvYcCWS8E7tt9ESbhlvETCP/4KohCk/OB/FP0i15wgCd5zT92b6EfpSgxaWNWYOqfHB4/OHylvhum0c2w8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+V9pjLxW9LXytJXK+tuhHxuM4GOqgJVcS7solpWsMT7jzIBcC
	fj/Pds5tnZTHTppggmhieeSn7QbAopgc8+XYeLvqHyrECVAsJ+nKao+2N8LFA0M=
X-Gm-Gg: ASbGncsCUFkp1Qy9SCLWYhIC2C9O8juwjw+7zA5bnvt+1dk2G/eB+chnN47l0gELtZw
	lIbBkiLFJWOVGQcAwJQiPO88bABXhYu7ZQALc7irBS+yOFAVEmGduVwwVEv6Xyajlmq3+oDYHsM
	JD2C/NzP8V6vVGJcl2Dfe1PtOPmSD22Ts5bD6xBXyP9Kv+OFIWJEVp3hFRp0jhC8kqTrmoAk+0k
	jqB4Mlr7g6ErMLzlf64kzrxan1oPcvT6Of/X2X8ZSU/WtkRDgeEJlOR3bH5tFbHCpNYXoUJX2Cd
	7HIGlGa+rjCWk4go+Eg7wthD0zWv0vekhDb4+yCPNvioZl8UVedUkiJ6BEPD3A==
X-Google-Smtp-Source: AGHT+IFyXuzhV6UZrEksw3NwHNzRWAy3BH2tt0jPz8Wbd7C48KiPovJ6jkGs8b9hRPnBmEkrQybSMg==
X-Received: by 2002:a05:6402:3554:b0:5f6:c5e3:faab with SMTP id 4fb4d7f45d1cf-5fa77fd765bmr1101612a12.1.1746169793206;
        Fri, 02 May 2025 00:09:53 -0700 (PDT)
Received: from localhost.localdomain ([178.25.124.12])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77bf3ec0sm753513a12.79.2025.05.02.00.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 00:09:52 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: guido.kiener@rohde-schwarz.com,
	stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 3/3 V3] usb: usbtmc: Fix erroneous generic_read ioctl return
Date: Fri,  2 May 2025 09:09:41 +0200
Message-ID: <20250502070941.31819-4-dpenkler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502070941.31819-1-dpenkler@gmail.com>
References: <20250502070941.31819-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wait_event_interruptible_timeout returns a long
The return value was being assigned to an int causing an integer overflow
when the remaining jiffies > INT_MAX which resulted in random error
returns.

Use a long return value, converting to the int ioctl return only on error.

Fixes: bb99794a4792 ("usb: usbtmc: Add ioctl for vendor specific read")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
Change V1 -> V2
  Acc cc to stable line

 drivers/usb/class/usbtmc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index b3ca89b0dab7..025a7aa795e3 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -833,6 +833,7 @@ static ssize_t usbtmc_generic_read(struct usbtmc_file_data *file_data,
 	unsigned long expire;
 	int bufcount = 1;
 	int again = 0;
+	long wait_rv;
 
 	/* mutex already locked */
 
@@ -945,19 +946,24 @@ static ssize_t usbtmc_generic_read(struct usbtmc_file_data *file_data,
 		if (!(flags & USBTMC_FLAG_ASYNC)) {
 			dev_dbg(dev, "%s: before wait time %lu\n",
 				__func__, expire);
-			retval = wait_event_interruptible_timeout(
+			wait_rv = wait_event_interruptible_timeout(
 				file_data->wait_bulk_in,
 				usbtmc_do_transfer(file_data),
 				expire);
 
-			dev_dbg(dev, "%s: wait returned %d\n",
-				__func__, retval);
+			dev_dbg(dev, "%s: wait returned %ld\n",
+				__func__, wait_rv);
+
+			if (wait_rv < 0) {
+				retval = wait_rv;
+				goto error;
+			}
 
-			if (retval <= 0) {
-				if (retval == 0)
-					retval = -ETIMEDOUT;
+			if (wait_rv == 0) {
+				retval = -ETIMEDOUT;
 				goto error;
 			}
+
 		}
 
 		urb = usb_get_from_anchor(&file_data->in_anchor);
-- 
2.49.0


