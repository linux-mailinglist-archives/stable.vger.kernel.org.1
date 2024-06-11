Return-Path: <stable+bounces-50166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD61903F4C
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 16:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DF7DB23400
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933D911720;
	Tue, 11 Jun 2024 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NmNFzDOF"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72D11C6AE
	for <stable@vger.kernel.org>; Tue, 11 Jun 2024 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117734; cv=none; b=WqxGDFVaOmsXTlYorWi8Wx1jlKox8DBoxe831Q1CyJ1QqyTYbQ9sVWiItsyHmpaM0auMJXqrNmnUOzk6HIsUOAZMd/7HqtQKIyRfLhBazGJZ7i/XP9KMmfXeK0CMersCnFh9HFgTKFjnpsyPhjPsGUhzOFh2xGOMSpmWddbRu6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117734; c=relaxed/simple;
	bh=f6Q3qEkJz+8prAqwo+YT+sHWBk2z/q9w7kLssxRRdqc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=k506vSU/V0UbkDC6Qh8m2+7wKplH0AW8RKCw4F5sc81uHF097LT2Xt47jQiWeBHo9pflAPBnPy2QGnneyMfuzQu0k5l5oj76rql9qv6QYfNJlSdQgFSzbECtinwtPOiUgU9Ol+U0RqLFsFRtIUHgNqGpb7oq7dGqui4oYMcs2/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NmNFzDOF; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df78acd5bbbso10070374276.1
        for <stable@vger.kernel.org>; Tue, 11 Jun 2024 07:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718117732; x=1718722532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MTug23NVW5smTBIbInLHVPug/iFJLDfAzzZ2mui8rNM=;
        b=NmNFzDOF59Mxf/KxH596ng7n/MjhJGfVV+hsIOmeZ03noz459cOeS7uHb3FLiMY8a2
         RGXkhxnoPns6K/cQ9W9rvjhQRcqrzxwvfhAUWDHLrADaVL+utcVCKCFQJfv5c0slTuX6
         SooQtrwpEiwWx7pwHqtlHZtwUgEt9PviwLr/QRLRuiFv1y+VCgqF03lDjfhxMOW4wFN3
         D02yuH1bGzXyL5w78zSTvs+D5MELpGAMqoQ8oJR7GWla0k7dl6TM6Qc49u8alQgWUD/I
         l+CMjp5cinPwztoLFWFiR9zz9XHhn4hebhbX83IsyPPtRQhlEw+bJf0xjREbNeDrkvHr
         cFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718117732; x=1718722532;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MTug23NVW5smTBIbInLHVPug/iFJLDfAzzZ2mui8rNM=;
        b=nSXJ5daVySirK7zYHDl9CitqNSIiWGNJRdDvT61e6YHCZsf3WbTi2n7TYNTgOw8FaK
         PFrAd7EKobhwRcMGm+7ccxUp6wcr/WTiKI8JrHBxeqcpwARwYSvF/haVOJQEWl7sNQmo
         0a6qk65XHW+gCya8XZUagGvXQpy6i8WSnBsfYp8udDPy51Jz27t8ZsgFZDVQ5mp4lNvo
         CQqk9Ycx/e4toYIGwaxPp5jplsLVv8DrkInX1nKzSHufG1mf+2bXMfW9KxT9i+ZbxLiB
         vcYwMWCOF0j/rSYchT4OVEnzRw054e7GcZZhA4hvPr/+ZrCnSft37RTeGWLqqFGH8/xe
         2gww==
X-Forwarded-Encrypted: i=1; AJvYcCWcreoGu2rBuvbh2wSUZ9mhkmx6VBmGuOssyF+rVZLAC1toL/pBzKJgdn1rJjnXxd8Dyg0CNQSQaUqSntn9mmuZLxUa6YJR
X-Gm-Message-State: AOJu0Yw0/sKGYlrXZKk5/N8krqOtKFH51xZuqVOwTYDLhpR1QWktKHEH
	qUFEDfP5K5LOw9WVYDArdpwTuT4VqI6Z0iwjBz60oB6p1SV5oSFRiSpkFe8Xtwl+tzAAxWKyVXQ
	IYKjeIY94uQ==
X-Google-Smtp-Source: AGHT+IHiOkeOvIjfZ6wUrcER+iWZsILYAZCJ9J9uHIeGqPk6NP5zJj3D5rPgY6hwnMYRfIhfkqi1mMAvYXYIig==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:1207:b0:dfb:168d:c02e with SMTP
 id 3f1490d57ef6-dfb168dc4e9mr780657276.3.1718117731956; Tue, 11 Jun 2024
 07:55:31 -0700 (PDT)
Date: Tue, 11 Jun 2024 14:55:24 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240611145524.1022656-1-joychakr@google.com>
Subject: [PATCH] nvmem: meson-efuse: Fix return value of nvmem callbacks
From: Joy Chakraborty <joychakr@google.com>
To: Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Joy Chakraborty <joychakr@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Read/write callbacks registered with nvmem core expect 0 to be returned
on success and a negative value to be returned on failure.

meson_efuse_read() and meson_efuse_write() call into
meson_sm_call_read() and meson_sm_call_write() respectively which return
the number of bytes read or written on success as per their api
description.

Fix to return error if meson_sm_call_read()/meson_sm_call_write()
returns an error else return 0.

Fixes: a29a63bdaf6f ("nvmem: meson-efuse: simplify read callback")
Cc: stable@vger.kernel.org
Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/nvmem/meson-efuse.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 52ed9a62ca5b..d7f9ac99a212 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -18,18 +18,24 @@ static int meson_efuse_read(void *context, unsigned int offset,
 			    void *val, size_t bytes)
 {
 	struct meson_sm_firmware *fw = context;
+	int ret;
 
-	return meson_sm_call_read(fw, (u8 *)val, bytes, SM_EFUSE_READ, offset,
-				  bytes, 0, 0, 0);
+	ret = meson_sm_call_read(fw, (u8 *)val, bytes, SM_EFUSE_READ, offset,
+				 bytes, 0, 0, 0);
+
+	return ret < 0 ? ret : 0;
 }
 
 static int meson_efuse_write(void *context, unsigned int offset,
 			     void *val, size_t bytes)
 {
 	struct meson_sm_firmware *fw = context;
+	int ret;
+
+	ret = meson_sm_call_write(fw, (u8 *)val, bytes, SM_EFUSE_WRITE, offset,
+				  bytes, 0, 0, 0);
 
-	return meson_sm_call_write(fw, (u8 *)val, bytes, SM_EFUSE_WRITE, offset,
-				   bytes, 0, 0, 0);
+	return ret < 0 ? ret : 0;
 }
 
 static const struct of_device_id meson_efuse_match[] = {
-- 
2.45.2.505.gda0bf45e8d-goog


