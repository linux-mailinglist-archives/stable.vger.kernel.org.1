Return-Path: <stable+bounces-136778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABC9A9E070
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 09:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB945A4699
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 07:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086DA2459EC;
	Sun, 27 Apr 2025 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVC32fYJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E82BE6C;
	Sun, 27 Apr 2025 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745739051; cv=none; b=YvrQUhhbXgSpAxTlCuZ1vvg4OY41b0GFHtn+WxWzHA3lvUVUvbhEFTkREtzQULzxDcZ5NSUICIBeM2ySumU9lL0UOe554cAPlVxj5fsp972DMbpWMIGqVbq1pGHHwq54m5BYZyJ0/+2JlyXhYRp3ksoj6+5Zho1r+lnF4r3UUy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745739051; c=relaxed/simple;
	bh=FNP3f8vTF+eq4+o2gW9MFt1Ri5yXjJT6HdncG9sVSy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQPBc95XB46xv22Zep9/Mr7nBezcf+MNzfTOLUPafshwd07PsSlzip6HcPLrWKfyjCjgqVAOMWCDh/3/BNoRuxxzAV+IKY9KEma8NPTRYaDDL7byOA+xl/5ddqEthc+d4uLoh5Smq31ja/g9K5vwX623/7fMoEMgerXjG77OPyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVC32fYJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so35621725e9.1;
        Sun, 27 Apr 2025 00:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745739048; x=1746343848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d10r9kauN9gqIusKigQu41oSQY9xgEgrDUOGrp8WcZM=;
        b=mVC32fYJZCf3gtWlqVXoMs0+w6t1nzn/64cLGxgidOynWSZDMyrh0qKCRDvMaMYt6q
         TiUpbeS+qNaSh3g4WxNwK9SSLVWMpyIYHhZaKaKPoht1W8zJbpndx8S53D1VnSpX6bhA
         5rMTSZecWxE7awdmsHSjpIi8oKcH3j+ubprqdgkytYTMw/giSZZ1ZXyihgA+5e5i9fqK
         DoZkt+NSqAQ8htsuQHEcJZmXaXNwLodmcZIuKDHzmQn9Hx8nn7j7KUCXZTYtQdMXnQaf
         D/bVIrPwj9StirX9AcF+OLipFOpKazqCOmCAD00joO8SJSp66mEJTCh94fgrqVtRal+r
         Y+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745739048; x=1746343848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d10r9kauN9gqIusKigQu41oSQY9xgEgrDUOGrp8WcZM=;
        b=paBOwzsC2RX2CkUMKx/r9RopBL7fJkvmxVfJBOe4lqxdMoxmggXAunFKKBEgGowRUm
         dt0ZRfcRKbTYoy+OC/bBsjXtQUPZXkq2pWjTev7sn7vAnAgT/TTVTKONFI8OFyv/JpK1
         1sy6zHahax1RYC10Dm7Jf1+ZlssQBEgHmVdHIzff8hf5sVWfgN1XNfhGvHmppTmFkyme
         IRk/kV+NSkcmcQHpA6Wuv9jsnnAdWkGKVYV8j9RxpyHD4YJm0ZbmdJ3552Kv96WN01YN
         jj+Y342yktzHOiuStu6mGu8OCTnPQGYEOIj1K3TLBfbrTrK6C6n+NEzaX6TbSn9Hah/Y
         imnA==
X-Forwarded-Encrypted: i=1; AJvYcCViIWV7plB3K6zlzf9JKuX4Yq92D03GZB4SZmNkyNvw0cYdD3WUiMPgR8w5QevK66aEKGwS7T7a@vger.kernel.org, AJvYcCWC2cQujN0ZuXX67BCo4D6NpW/Mja4gO6sUyiMEc6SqUygY+K5yT/7CBTG++UGz1ze+4+K4mB/IX/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHkbVOsheP5QJHxfvhZx5IkYt4eOcmU223mGuPA6ft+CJZfLQd
	W+yH14mL1x0hr3c8pyzYODQlV2FQ3PgS+T49wElCmc7Vx7VnwULdUCofzkB9
X-Gm-Gg: ASbGnctCleFCiv07j+imUHOk6fDWiu4hjMoiPt5GI0FUboMRJz0JxMJyYEWeboBcsnJ
	AzuC8C/fPFc9UyueL9t/JbMRz+iE64zBiXhCBoYvHlWMrf2MTXS4akidWVrlGYX1Dc0EiebZ26f
	cHTwZHvHXCo3ambZb//E56ASiBdmsbEYnp4vbgZQXDkE2N3d+glGxZzhrwbOE9UNaXmvwmnBuLX
	Hl5EVFyPHRXiVMYT/SKAKrreQboRtsJdCB7T8T6NjhutzvneEOr8ADF6NZ4Ax57Z2oc4x5xMimo
	Na25nPcMEmCpQQe4/5WewIy2dRJS7IUbCqAMWBBok/8tBRlg6lDs0X5bUhf1YkJS2UXvqL4f+4Q
	+NBHjI331Qhs=
X-Google-Smtp-Source: AGHT+IGPRib0hFxQ5N6HgmmfeGrUQay1ziEpnEnOqDTIi5IYxaUi74I+Csgutby2km11l+klrrahPQ==
X-Received: by 2002:a05:600c:4e91:b0:43c:ec0a:ddfd with SMTP id 5b1f17b1804b1-440a64c1416mr51118605e9.6.1745739048263;
        Sun, 27 Apr 2025 00:30:48 -0700 (PDT)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a531072csm83924145e9.18.2025.04.27.00.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 00:30:47 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: guido.kiener@rohde-schwarz.com,
	stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 2/3 V2] usb: usbtmc: Fix erroneous wait_srq ioctl return
Date: Sun, 27 Apr 2025 09:30:14 +0200
Message-ID: <20250427073015.25950-3-dpenkler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250427073015.25950-1-dpenkler@gmail.com>
References: <20250427073015.25950-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wait_event_interruptible_timeout returns a long
The return was being assigned to an int causing an integer overflow when
the remaining jiffies > INT_MAX resulting in random error returns.

Use a long return value,  converting to the int ioctl return only on
error.

Fixes: 739240a9f6ac ("usb: usbtmc: Add ioctl USBTMC488_IOCTL_WAIT_SRQ")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
Change V1 -> V2
  Add cc to stable line

 drivers/usb/class/usbtmc.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index e24277fef54a..b3ca89b0dab7 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -606,9 +606,9 @@ static int usbtmc488_ioctl_wait_srq(struct usbtmc_file_data *file_data,
 {
 	struct usbtmc_device_data *data = file_data->data;
 	struct device *dev = &data->intf->dev;
-	int rv;
 	u32 timeout;
 	unsigned long expire;
+	long wait_rv;
 
 	if (!data->iin_ep_present) {
 		dev_dbg(dev, "no interrupt endpoint present\n");
@@ -622,25 +622,24 @@ static int usbtmc488_ioctl_wait_srq(struct usbtmc_file_data *file_data,
 
 	mutex_unlock(&data->io_mutex);
 
-	rv = wait_event_interruptible_timeout(
-			data->waitq,
-			atomic_read(&file_data->srq_asserted) != 0 ||
-			atomic_read(&file_data->closing),
-			expire);
+	wait_rv = wait_event_interruptible_timeout(
+		data->waitq,
+		atomic_read(&file_data->srq_asserted) != 0 ||
+		atomic_read(&file_data->closing),
+		expire);
 
 	mutex_lock(&data->io_mutex);
 
 	/* Note! disconnect or close could be called in the meantime */
 	if (atomic_read(&file_data->closing) || data->zombie)
-		rv = -ENODEV;
+		return -ENODEV;
 
-	if (rv < 0) {
-		/* dev can be invalid now! */
-		pr_debug("%s - wait interrupted %d\n", __func__, rv);
-		return rv;
+	if (wait_rv < 0) {
+		dev_dbg(dev, "%s - wait interrupted %ld\n", __func__, wait_rv);
+		return wait_rv;
 	}
 
-	if (rv == 0) {
+	if (wait_rv == 0) {
 		dev_dbg(dev, "%s - wait timed out\n", __func__);
 		return -ETIMEDOUT;
 	}
-- 
2.49.0


