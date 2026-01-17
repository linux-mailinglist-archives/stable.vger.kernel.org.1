Return-Path: <stable+bounces-210141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AFED38D78
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 10:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AC13301F8E5
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 09:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B019C32FA37;
	Sat, 17 Jan 2026 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWkvCtQ5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C82C145348
	for <stable@vger.kernel.org>; Sat, 17 Jan 2026 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768643199; cv=none; b=pzlCZS6eANAsbnae7cg3mDHsRBTPZQBYyqtkHUeycmImdvqhSe5fnGXan4pp4YgC6II8kt3HNJfAlRkkhCmjuS1oCJGvhp5+irvSFfsuha46Lloqkmly54ZeoApsZvvexXUdgEwtB7a+D7njugWOuQM8MqferogwOU47x9YCu8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768643199; c=relaxed/simple;
	bh=dzuCEr++dzV7RGNmwdbO18PEnRRvlr6DRE7R+PtL5fE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kNjpizI2F9Eff9TDCMXE3Hbw7KulbVkZ8bGhwfdA5f0ARxXV+u9UivMLG6kfJlaLaaAdugKwYwbCfYPccWIZV3GKkzCipHwdCWcFozfE6fJ16S5/bEPEBwln7CVQXRYMk1RyAGZTvF0WuQ867lsG7lEj+NEiAgQzRN7vgnt3zeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWkvCtQ5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f4c0e2b42so1515983b3a.1
        for <stable@vger.kernel.org>; Sat, 17 Jan 2026 01:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768643197; x=1769247997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XdRImgnlzumkwpGPWq3zB030HsmNVz+cDIu4+32/ft0=;
        b=bWkvCtQ5CCXza9jRk/LsSnKU0CUkDASpkMA4/s7W5pmuWUZQOyIc7G51lzsRFGWGFR
         eV+lkQUFA+96z8W012i/jp1woeHmebKSPLXCR147Mm1Ky6V7P0VqlZfh0iKDlM9drfC3
         LAT6htDHHCKP5ZnLbzbsCi0RQT4B6jcizgR6ABHz0HjvmtL0BYBJFqxZKJo80nNTxZdD
         XUg9/pBRP252AcAewqlzAUtByEY0I+4ewRg1a/39C3f7hKe001tgu5MqVtkl32PR56pI
         XNPW9L1mpHism8H2y5tYxLXwapa6ikrsI5XCQxB+Um77Y+GkMuXceRz7l4jyURL9LihP
         VhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768643197; x=1769247997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdRImgnlzumkwpGPWq3zB030HsmNVz+cDIu4+32/ft0=;
        b=pUoFrPkUS/2esi60i5OIPTVZLDT6l2+6l4gp/mjVB74Bsyq1sgA2fbX/Rc2HFvPonV
         gFpjb1bAVal4OdzUE3m+fFIzebcyyJEH96lKOjXFeo/rAlT3g/wr4d88VnryQL5bwMwP
         C6Bxb28/WdUOLzd3S3haC3pBmB9IqekSRzQ7kJH/YYLzsmrNp8duGzjyB6VkwaW5AwrY
         zqraRq4s1eqWqz75bCu811I+AGc/JNohiFbr2TklpeJTQwebvCXM/NqX8cZErVDqXWH7
         gJjcPjCjtAJ+CZIti21V/7mOnpIUqx9DJZzvp+Pvac6aKoR23DJB1FiKLr9IHMJVwNua
         wOmw==
X-Forwarded-Encrypted: i=1; AJvYcCWOhBZxNYtNQnaVjo4CVyo9Yzgb0/ikzuAwe8uc5qePk0YsnAqXXO0jxz37b3pU8FewaWWMA+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEj2vjdrgmI+/yVKm+5kx4qEY51rUD4Iwk5hwMgdrHRzZgxO0T
	i7rY9mcW2QrtTGrF9Djm+AdTMsRGfHm71T+Gn3jnigwcQ6GkY0+q+qU3
X-Gm-Gg: AY/fxX4i1tSTmsS6Othrbxyta67o2Afcw/mdublPfm3qqZPR9Mtt1Xj1F1jCLDnXaUI
	1jUt+TdvhiDga9P4/ZsU8FvBgkMElZZBMlKIfqOreVJF6BpjaxRaWmdXvrQkSiWt/iOZyTmFt/P
	h/Cs5Rvl14d08ai4xmxug53UrrazZ+lFyPGMT1hcMFB54z9p6E6qoOKg8PuAl/dqrlTbZ3G90Io
	naYQZvV+pByAzlZnJekCZzUBgBkzgaI3F5FoJXEtuB7J2CiJz02/CYjAdvW+pj5O1n5ZfxU2idr
	vbnUR3x02dDF7rfuV41+MjauRIZcf+2e4lefVGYPF08MlXy5CSBmj2ckRNTYodFSXiEE54zCOQI
	Bhpjpl37tF6EsNwUZNiDd3uIttraUx+LjipZ2DuXFqqv4pT7K7PGoxoQ3RpZODN4py+2kzSoL9m
	DpF9O23uLnhVTJ2DkWwhZA1SgD3rrZXUMoBtwxVaXFkk9Q+E6QupZtFpeTU7IrWUhLiQ9Qy7Aqg
	ole+bJDImxmQxuIS2YGkSQDIk6AAzTBifFRror5UW+DyD4=
X-Received: by 2002:a05:6a00:14c5:b0:81f:3d32:fe58 with SMTP id d2e1a72fcca58-81fa01ec336mr5335959b3a.35.1768643197568;
        Sat, 17 Jan 2026 01:46:37 -0800 (PST)
Received: from c8971f1abf06.ap-southeast-2.compute.internal (ec2-54-252-206-51.ap-southeast-2.compute.amazonaws.com. [54.252.206.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa12b3165sm4063839b3a.60.2026.01.17.01.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 01:46:37 -0800 (PST)
From: Weigang He <geoffreyhe2@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Weigang He <geoffreyhe2@gmail.com>
Subject: [PATCH] usb: xhci: fix missing null termination after copy_from_user()
Date: Sat, 17 Jan 2026 09:46:31 +0000
Message-Id: <20260117094631.504232-1-geoffreyhe2@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The buffer 'buf' is filled by copy_from_user() but is not properly
null-terminated before being used with strncmp(). If userspace provides
fewer than 10 bytes, strncmp() may read beyond the copied data into
uninitialized stack memory.

Add explicit null termination after copy_from_user() to ensure the
buffer is always a valid C string before string operations.

Fixes: 87a03802184c ("xhci: debugfs: add debugfs interface to enable compliance mode for a port")
Cc: stable@vger.kernel.org
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
---
 drivers/usb/host/xhci-debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index c1eb1036ede95..1e2350de77775 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -347,11 +347,13 @@ static ssize_t xhci_port_write(struct file *file,  const char __user *ubuf,
 	struct xhci_port	*port = s->private;
 	struct xhci_hcd		*xhci = hcd_to_xhci(port->rhub->hcd);
 	char                    buf[32];
+	size_t			len = min_t(size_t, sizeof(buf) - 1, count);
 	u32			portsc;
 	unsigned long		flags;
 
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+	if (copy_from_user(&buf, ubuf, len))
 		return -EFAULT;
+	buf[len] = '\0';
 
 	if (!strncmp(buf, "compliance", 10)) {
 		/* If CTC is clear, compliance is enabled by default */
-- 
2.34.1


