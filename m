Return-Path: <stable+bounces-179340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A4AB54950
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 12:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 911D17BACC8
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 10:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208042E9ECC;
	Fri, 12 Sep 2025 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws/VFMWy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370AF2E4279
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672058; cv=none; b=AN9nLrAnDWYUe9cB8jbwHli6Joe1FoUrsoMVBwZwcJ1ZHc9I+NMbZRMTCXcTH5iSEuZdO9OZqPtEeU9MvFuI2XIrrQL7FkXFnhPQkcosGhzDzNut3joqKaDI992QzTFmyTDLk6+Y2DgGgEQreEu5weSHv5eZlKFgfMUTp0/YccM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672058; c=relaxed/simple;
	bh=WzgTnbK9tuNFXaklXyWAZeptvHxNrHodKB3ayQnobdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKX3Ef1KXK+a/t37DAZ1eQ2cCFoIjxb7WWilGHEW7F82H/gqLmO0/TiOhwBO+cmBMV58hrw9639PgwniepcH3bjF0/39Mq5DOf58d89bo2lJYZGOnC8QtuD5y1nMhR80d78qAvHe0ZKGMsXSz37vbfLgmnuMrEh9ViP9uHo9BeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws/VFMWy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso11321895e9.3
        for <stable@vger.kernel.org>; Fri, 12 Sep 2025 03:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757672054; x=1758276854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PQcDKC/bECgYhflDmBq/roZDN26g7PlEyIKs1aCH60=;
        b=Ws/VFMWyKXeKQ7SgMMLcgYcrpuKZzHD1Fw4Kl9rgqiE2evOHbNKfgytvA87cFo0B5H
         Qoh7NYTFiWZpeZVS8EX65bYU8QOSX0NVRhIaW4RcUUwCIKuviT2plVrzwk5Mf/VQdnb1
         qO/ZqBI8/USRCfNik7RHK80/76te3JgFHbMqHbuK1mP9tbwf1IBiBq9oAs/B8TTP78UV
         Z2GlQd9djlH7Fk7iCJO5eI+CgFoHxJyDQR21cpvnlTHalw9JElEt1wn/QGDx11RJWOO1
         uvaTx7JacXHQ+lkBZ3kGqf71lvihet+9guu/zBCfYF7kd0mM2eQ20qPsT51Z+fvp4xjU
         d+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672054; x=1758276854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PQcDKC/bECgYhflDmBq/roZDN26g7PlEyIKs1aCH60=;
        b=mfw5y+XTIeSJEKzmqYD6qoGbcvka1V0bCJdhczXYqbNw3nI+/oAxq+3PxyT6Yi4+Do
         8Ya1ct0nKQrNQe2q7dMvZ6gACIuuRT6I+JtdJyxq8tRx+EcIAR1luRpRRSAjZlPP+bGw
         u7whLs0QkwRQAlRDzfAZMN+bUAukZptkQ/U0+gLd5xe1X7YyscCgeP6mYDxZwCdX48ib
         3a6i+LLHjMBG2bD3hfQSFpho3YwbKpuBM83Sh+j1M0lKOUcMOka04sA+SyFyqVKlZatK
         6EZZOj0TMt6N08xr+cE9jiXgmSG9VM+g3UmTh1SLqs991Z/60Dpn5lUgHeXi3rGMTVG2
         6OcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU30ugPy4mZiTzLa4DPyDyFNw452IwzTMe4sV67mfy6/UVWzAP7DlyV+vL3sORLM8kpwxf7hsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YykPlmLlmoXfbhJAq7LUzaVVqCGNSWgmh3ckved+Ez3dd+sETWI
	Kk9YkO90fASxx3Zd1iPxvQyQI0CI+HXTGsJwZbluEFTDtvqxYvmJWmul
X-Gm-Gg: ASbGncuRcjAYIMOZ+WxE+Mf1wYhpl0Lujdt3I07lmXQ30llJMpbNH7xMX3Y1/dg1sny
	L9i7JHobSyh2vFlSRUCqck4WWLhRZv7pR77R4BedFncjFgAQmiaW/urn0lzVrrHWr6EHVuuGiZv
	IuYu4qAG6BP3zqLpJWpzCbs0Taik4lBS51D98VMkOuNdswnuoZQkJdowSNk+NyRABFCHBhh2myI
	GovwI70+23mxeK/nM0+f0iltlOdiZRe027zScT5926vH3MJx9s1wqONnIdSKVskuRjP5ypIttTH
	qmmTmA4HBwzx71Cl7Wo6W4Mm6RlE/xwBybH1Hl5T0OxSh+HHXZoXvFJVBl+uoV9C42QmUlKsRl8
	iyACkNfIWyQqEYJvaqpnCoAZdwWj9Bcu/WIJYjdAlM0xl
X-Google-Smtp-Source: AGHT+IH/9UK+74KXPTnSJovBBUuqH7Dh59JphBjwKJfV2cuUIv0/SQm8MsDxBuEOK1XB9vm/BVZEhw==
X-Received: by 2002:a05:600c:2249:b0:45d:e54b:fa0c with SMTP id 5b1f17b1804b1-45f2121431amr20057115e9.17.1757672054181;
        Fri, 12 Sep 2025 03:14:14 -0700 (PDT)
Received: from ws-linux01 ([2a02:2f0e:c207:b600:978:f6fa:583e:b091])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372b983sm56542395e9.9.2025.09.12.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:14:13 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: gshahrouzi@gmail.com,
	Ovidiu Panait <ovidiu.panait.oss@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] staging: axis-fifo: flush RX FIFO on read errors
Date: Fri, 12 Sep 2025 13:13:22 +0300
Message-ID: <20250912101322.1282507-2-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250912101322.1282507-1-ovidiu.panait.oss@gmail.com>
References: <20250912101322.1282507-1-ovidiu.panait.oss@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flush stale data from the RX FIFO in case of errors, to avoid reading
old data when new packets arrive.

Commit c6e8d85fafa7 ("staging: axis-fifo: Remove hardware resets for
user errors") removed full FIFO resets from the read error paths, which
fixed potential TX data losses, but introduced this RX issue.

Fixes: c6e8d85fafa7 ("staging: axis-fifo: Remove hardware resets for user errors")
Cc: stable@vger.kernel.org
Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index c47c6a022402..2c8e25a8c657 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -230,6 +230,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 	}
 
 	bytes_available = ioread32(fifo->base_addr + XLLF_RLR_OFFSET);
+	words_available = bytes_available / sizeof(u32);
 	if (!bytes_available) {
 		dev_err(fifo->dt_device, "received a packet of length 0\n");
 		ret = -EIO;
@@ -240,7 +241,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		dev_err(fifo->dt_device, "user read buffer too small (available bytes=%zu user buffer bytes=%zu)\n",
 			bytes_available, len);
 		ret = -EINVAL;
-		goto end_unlock;
+		goto err_flush_rx;
 	}
 
 	if (bytes_available % sizeof(u32)) {
@@ -249,11 +250,9 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		 */
 		dev_err(fifo->dt_device, "received a packet that isn't word-aligned\n");
 		ret = -EIO;
-		goto end_unlock;
+		goto err_flush_rx;
 	}
 
-	words_available = bytes_available / sizeof(u32);
-
 	/* read data into an intermediate buffer, copying the contents
 	 * to userspace when the buffer is full
 	 */
@@ -265,18 +264,23 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 			tmp_buf[i] = ioread32(fifo->base_addr +
 					      XLLF_RDFD_OFFSET);
 		}
+		words_available -= copy;
 
 		if (copy_to_user(buf + copied * sizeof(u32), tmp_buf,
 				 copy * sizeof(u32))) {
 			ret = -EFAULT;
-			goto end_unlock;
+			goto err_flush_rx;
 		}
 
 		copied += copy;
-		words_available -= copy;
 	}
+	mutex_unlock(&fifo->read_lock);
+
+	return bytes_available;
 
-	ret = bytes_available;
+err_flush_rx:
+	while (words_available--)
+		ioread32(fifo->base_addr + XLLF_RDFD_OFFSET);
 
 end_unlock:
 	mutex_unlock(&fifo->read_lock);
-- 
2.50.0


