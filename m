Return-Path: <stable+bounces-164889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 054C3B1364C
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 10:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00623A1BF0
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 08:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3755323536A;
	Mon, 28 Jul 2025 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dn1p5S1+"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F27F1D61BB
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691048; cv=none; b=cn+ihbe1Lwsy2DF8yiCwFC+jAaBa8UeoKjC6k+T3+k74+cF57/XbxfJj7S2cZTsuSdvWgJRRxrEcKISSPCX5ivdj4u8g5OIM3GY+ji263DUve+Cu0p0vUPE6by2BX6rYMg2IuBB0/zZN0P6N5Zd+bW0hrEkXyZtLmFpvLycz2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691048; c=relaxed/simple;
	bh=nV4/PTmUEYP9KwMf532+qDjUVUN0GHVZDZLIsvcU80w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZXCR22CVa6nV94pIV7XiKYm6nla7n4RjyVNOn15h05eEwBxyVxeGbj74pxTdQc8vVNT0F8BO2p5iuLN3cOmmmmWXnoFrJjVMLwkO807FMC424vGxQrYj8ZdN8Exwx1krf7ST9iFKO2t+hGGUvcdawmM5PYvdABOqFDSwhAnh+/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dn1p5S1+; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4aeb2e06b82so5947821cf.2
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 01:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753691045; x=1754295845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aS8c0DmZhV/h10pO2Kk++8G/v4lwXvV7Mu1YBRRf+B8=;
        b=dn1p5S1+ho/aTvhjiloNb5cICGlRS/ln8LntU9/7fZPfyBFxSa/URrSxj5Ezni40gK
         8l8SVy6UmG+9bfUX81Aa3egxqesA6d9OXO9iB6y7W/uoOK8WwT5D2yGatGFTg48pX27s
         4OcaybDgJpt68fJqZ19SqIW86DwmU7wpF5Nzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753691045; x=1754295845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aS8c0DmZhV/h10pO2Kk++8G/v4lwXvV7Mu1YBRRf+B8=;
        b=gwxdJgW5B7YBpkgxOxO8BWsq09z6rVu6tNQ/3ob2vkMAckoyR9nzN54FGC1ESlZobW
         Srz1T2CQ+0hDYyvLIjiitvmhfJzVOPI20Xlqbb421DKVWQ+QnUqSg+zxFJM9oT1PNlZy
         GhSqEgap+6CzPSSTtQvdgNtJYsFxlpoZk0oSz2TYeuRdjf+PnPpmj9Jn2XAtIzxH8Kd+
         4FRHYcckJW4xb+rcYt/eFMgUE2PunWaeAd3O3eWUXxFmo6C7gTeDoke8PSEUyCdGZeQS
         83uUcMX5jr0V7q2drh+govnHihcaOgh8n1wI9iSMj9f7gsnT1Zy2t1XB/Ao07ejOEXX3
         Nmag==
X-Gm-Message-State: AOJu0YyjbKQcoZdNFsm8oMPIHc2l3U/NuHoGo+zqFJPdP43MyX8iv0cC
	e6nzlIqhYO6+dL8f1U+HknPIok2Oq01QKCSZJsRpXAob3qqMmNjdzsdqutTyaP6CDeXLnNo3DLs
	C8L2ZBoEGRzet49clZO8/jtu+5fg+hJzTpyoXUfPcVx3mu8CdNGie/l7sk3VKaA7R3ZLryklHYn
	LnW0xcDr2Kfqmvefktmhkagg6HqUd1LT0Z6pVvFRZTYnsDCsVlr3+oFA==
X-Gm-Gg: ASbGncv4mg5nJalZV1T09AAKNHNgrIdSq6NaENgfjcmZ4yW9GxHJsZCmt6FPrxyqwtO
	F4/gtSlalobuU6ubbWhbcOgNWzh+bmEvg11gPfNHdxoj73CsSPgNxYhzO8FIbR+50i+hiYrl2Br
	N/wYvMWf+KaUMtuNiUBcS11n9wqElBmiB1ZFDwUx1NsG+g0VzagaMo4iZU1dtl+NsLu/x3iWEr5
	M09AXmhy6K2iE/SlUxpapIQgP/nU7cEjn/WrGgIk0CwiXDjGBrZKjTRS41+3jh/7iZ79s4y+78B
	uGshaS49n3zehqTX0HHv0b8dObqU4vIdcUquObwxE80IQos6DyvWRYOV6bCoXRGT7zS9qBieiiZ
	RNKL9ndk0dD9maS6yhV5lc3nle8auTjrrLMuceXHaoRJ5mLAQOpKzA8yzQzDHMrARQLpQGyeANh
	I=
X-Google-Smtp-Source: AGHT+IEd9Qtbq/Axeuxm78yPvalIEBxFUnS73+vOHypPFZ6GDCTmnUWa4pzwHujXD4fPbZeOJA0urQ==
X-Received: by 2002:ad4:5de9:0:b0:704:f94e:b5d6 with SMTP id 6a1803df08f44-707205e99f1mr163132936d6.46.1753691044726;
        Mon, 28 Jul 2025 01:24:04 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-707299ff0f1sm27786876d6.9.2025.07.28.01.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 01:24:04 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vdronov@redhat.com,
	netdev@vger.kernel.org,
	Yang Yingliang <yangyingliang@huawei.com>,
	Hulk Robot <hulkci@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] ptp: Fix possible memory leak in ptp_clock_register()
Date: Mon, 28 Jul 2025 01:11:21 -0700
Message-Id: <20250728081121.95098-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 4225fea1cb28370086e17e82c0f69bec2779dca0 ]

I got memory leak as follows when doing fault injection test:

unreferenced object 0xffff88800906c618 (size 8):
  comm "i2c-idt82p33931", pid 4421, jiffies 4294948083 (age 13.188s)
  hex dump (first 8 bytes):
    70 74 70 30 00 00 00 00                          ptp0....
  backtrace:
    [<00000000312ed458>] __kmalloc_track_caller+0x19f/0x3a0
    [<0000000079f6e2ff>] kvasprintf+0xb5/0x150
    [<0000000026aae54f>] kvasprintf_const+0x60/0x190
    [<00000000f323a5f7>] kobject_set_name_vargs+0x56/0x150
    [<000000004e35abdd>] dev_set_name+0xc0/0x100
    [<00000000f20cfe25>] ptp_clock_register+0x9f4/0xd30 [ptp]
    [<000000008bb9f0de>] idt82p33_probe.cold+0x8b6/0x1561 [ptp_idt82p33]

When posix_clock_register() returns an error, the name allocated
in dev_set_name() will be leaked, the put_device() should be used
to give up the device reference, then the name will be freed in
kobject_cleanup() and other memory will be freed in ptp_clock_release().

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: a33121e5487b ("ptp: fix the race between the release of ptp_clock and cdev")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on 5.10.y, Removed 
kfree(ptp->vclock_index) in the ptach, since vclock_index is 
introduced in later versions]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/ptp/ptp_clock.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index c895e26b1f17..869023f0987e 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -283,15 +283,20 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	/* Create a posix clock and link it to the device. */
 	err = posix_clock_register(&ptp->clock, &ptp->dev);
 	if (err) {
+		if (ptp->pps_source)
+			pps_unregister_source(ptp->pps_source);
+
+		if (ptp->kworker)
+			kthread_destroy_worker(ptp->kworker);
+
+		put_device(&ptp->dev);
+
 		pr_err("failed to create posix clock\n");
-		goto no_clock;
+		return ERR_PTR(err);
 	}
 
 	return ptp;
 
-no_clock:
-	if (ptp->pps_source)
-		pps_unregister_source(ptp->pps_source);
 no_pps:
 	ptp_cleanup_pin_groups(ptp);
 no_pin_groups:
-- 
2.40.4


