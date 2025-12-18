Return-Path: <stable+bounces-202911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93214CC9F99
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 02:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 257D9301028F
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 01:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6672459ED;
	Thu, 18 Dec 2025 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVHqy55U"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8251C4A20
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 01:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766021048; cv=none; b=hN5274ck9srOTnfgnROgQ/6vYUhIsKbjFp7TV1/LNM2x2vifObz6AYVj2eo33rts+7onMn00h2kYlPAyPXF7CDa0O421re5ea9vtVsisWYoKUNKiqqTylf2JzXTQn/7Bis68aOfDRiaCV6gFL5lHs+L3jtJbSfXz/hZP+d/nQcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766021048; c=relaxed/simple;
	bh=e2uP0ZZrORin36qfUFZ4oiCOOcWKcoTH8uLPIBj5IWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5c4KncILIxpdRuIJ8TgVS1Ei3cX+do4SWSvuNGrqI68uYr2soAyTO1Jb3PV+bWRllY4158tH1pEO+C4SypSDnsikSOAJxQyVtEZ9fvnWUpTFnbWjTxDTe5yt9jO5Obc1xAUVDAcwBw4dE9NpNKXiZvbCUSLbvvFL8jCz/KAbCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVHqy55U; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so167019b3a.0
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 17:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766021045; x=1766625845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=emBNhNNlWqPOEEl6QlP0wn4wftIpig8p3Ziv36qR1o0=;
        b=TVHqy55U2/kSInDIDlmdhsVS35rK3YKQYBlOoNvOXVo52PMjq7fumiaUd6oWuluHxm
         zgX6sQxfxTWy7cvivpFvel2X42lLLVLxyYgsYdLd7xdAuOoOiq91ussaRqgD9WMKPjoo
         LLc6gIO1DgT1rKJ3jySJlCWAyxIUSiGWpPb40C2qE9kB/FOk9moMGWgUa5P8CHLdahK8
         v/B0QPXX7Rk/WlNYSPfQ/mbc/91pEx+iudU6rd+ck9oMw/eDVqyI0TurfJX/L9WNoYSs
         H2mb8k3li/ew7/wfzNStBNBgK7JU2NX1R9nrn1HTyE5w1C/e2x7Sy9mQoIew63SHSjmy
         Bwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766021045; x=1766625845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emBNhNNlWqPOEEl6QlP0wn4wftIpig8p3Ziv36qR1o0=;
        b=S8PmowZBRskVLGTJlq4AAaykFXWwNBSiKBfFPq0uz/DtQIneDBsSvjdzXEbaZt8WW9
         b5YeImBOS6WC6ERkBWSPOgMU3raseGjYK5aEeOzDjSz0sUR2S8VPZ0DU6l5fb7ty4NNa
         C588KAuSir3q8S0djhs6zNJGkDb7DrrtxVkPZvAo5O+zOyFjo5pAYl5i24ENY0GMVQ3I
         UjBqeGuYFfrbSmAz/APnpBrIoPQ3TKlPf6lFkISihNGwZCiVwvOEc2kCHFBIXieV/Hgw
         IO1lxQhBcNzKiwKaNMqdY3ucoGtLIblXEMM0tceiiFbTelKaqde4UWqs5NeAiSgJ8VNZ
         8quQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCPrVPj3e9aw5KmIDb3imzymS/0QvDc3PbKIz2aCnmfvWOZn91jo8jfc7jEN5B1aSexQanrWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeiKW3oFxAgB6MruUMbmnTiQXHMGCVtZsgh1DTpXuHjNeUSKQQ
	e3z+5NY7XTU4ltkr+WB2BqUI0JTw9E9frl1NHIbY1cOYPILMg6qYpP9n
X-Gm-Gg: AY/fxX53mzrTKbFtOxNFAnQw7Ft5UzhJHWOZX00VwF8GfyN/Z007iyQ2Tx3nzvsxb7r
	1yTSYuvO61OrbEQSkifYq++FQg6vF9SqfAOBuh8XRMjnVDh2BqE++ZsslRAeav7u+V1rCGwXzvI
	QNLxGk3f3Y/HoGkkP7Y90znKIR1/Xxb2Nl3dQFgUBVFRacFsoutBr6EW7lt1GqdoS5uD3m3UEvh
	U1w87vRVZXz/D87MjEvFGrL2+fVlEvgLquhaV32GQSY6LkEi5qJ/aHZ+a08Ii9kUR/tJI+Kocdx
	9xhkoiRneJmDU7P2m+rRuvvoni+bfHx6kg9HJe1JbhJwdwY4epVlFUE8XeBo1klczn7HoOESqIM
	qHSj6sNsryzpjq2Pe6JdM4oGze2ldloroM6J8EAErmvDF5kV3wxeEA6E0dXrCP+UBl4shlsWHH2
	/OpBHG+QzDiK9GxCaEkwUO38+0LrvIpxHs+UU2h9WTGqT7exSasutkeYcgh1OzrrTLc4A=
X-Google-Smtp-Source: AGHT+IG8qEk4VvEgkvsi2+A4qbe7sf1FK993lwy81zhcYcsjR16OvYCzjdL3HruD2xxF4O/sLvNhJA==
X-Received: by 2002:a05:6a00:27a4:b0:7e8:4433:8fa3 with SMTP id d2e1a72fcca58-7f6694ac050mr18922276b3a.43.1766021044963;
        Wed, 17 Dec 2025 17:24:04 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:a45b:c390:af5a:2503])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe12315ea4sm694602b3a.28.2025.12.17.17.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:24:04 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: krzk@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linma@zju.edu.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	stable@vger.kernel.org,
	syzbot+4ef89409a235d804c6c2@syzkaller.appspotmail.com
Subject: [PATCH v2] net: nfc: fix deadlock between nfc_unregister_device and rfkill_fop_write
Date: Thu, 18 Dec 2025 06:53:54 +0530
Message-ID: <20251218012355.279940-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A deadlock can occur between nfc_unregister_device() and rfkill_fop_write()
due to lock ordering inversion between device_lock and rfkill_global_mutex.

The problematic lock order is:

Thread A (rfkill_fop_write):
  rfkill_fop_write()
    mutex_lock(&rfkill_global_mutex)
      rfkill_set_block()
        nfc_rfkill_set_block()
          nfc_dev_down()
            device_lock(&dev->dev)    <- waits for device_lock

Thread B (nfc_unregister_device):
  nfc_unregister_device()
    device_lock(&dev->dev)
      rfkill_unregister()
        mutex_lock(&rfkill_global_mutex)  <- waits for rfkill_global_mutex

This creates a classic ABBA deadlock scenario.

Fix this by moving rfkill_unregister() and rfkill_destroy() outside the
device_lock critical section. Store the rfkill pointer in a local variable
before releasing the lock, then call rfkill_unregister() after releasing
device_lock.

This change is safe because rfkill_fop_write() holds rfkill_global_mutex
while calling the rfkill callbacks, and rfkill_unregister() also acquires
rfkill_global_mutex before cleanup. Therefore, rfkill_unregister() will
wait for any ongoing callback to complete before proceeding, and
device_del() is only called after rfkill_unregister() returns, preventing
any use-after-free.

The similar lock ordering in nfc_register_device() (device_lock ->
rfkill_global_mutex via rfkill_register) is safe because during
registration the device is not yet in rfkill_list, so no concurrent
rfkill operations can occur on this device.

Fixes: 3e3b5dfcd16a ("NFC: reorder the logic in nfc_{un,}register_device")
Cc: stable@vger.kernel.org
Reported-by: syzbot+4ef89409a235d804c6c2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4ef89409a235d804c6c2
Link: https://lore.kernel.org/all/20251217054908.178907-1-kartikey406@gmail.com/T/ [v1]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v2:
  - Added explanation of why UAF is not possible
  - Added explanation of why nfc_register_device() is safe
  - Added Fixes and Cc: stable tags
  - Fixed blank line after variable declaration (kept it)
---
 net/nfc/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/nfc/core.c b/net/nfc/core.c
index ae1c842f9c64..82f023f37754 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -1154,6 +1154,7 @@ EXPORT_SYMBOL(nfc_register_device);
 void nfc_unregister_device(struct nfc_dev *dev)
 {
 	int rc;
+	struct rfkill *rfk = NULL;
 
 	pr_debug("dev_name=%s\n", dev_name(&dev->dev));
 
@@ -1164,13 +1165,17 @@ void nfc_unregister_device(struct nfc_dev *dev)
 
 	device_lock(&dev->dev);
 	if (dev->rfkill) {
-		rfkill_unregister(dev->rfkill);
-		rfkill_destroy(dev->rfkill);
+		rfk = dev->rfkill;
 		dev->rfkill = NULL;
 	}
 	dev->shutting_down = true;
 	device_unlock(&dev->dev);
 
+	if (rfk) {
+		rfkill_unregister(rfk);
+		rfkill_destroy(rfk);
+	}
+
 	if (dev->ops->check_presence) {
 		timer_delete_sync(&dev->check_pres_timer);
 		cancel_work_sync(&dev->check_pres_work);
-- 
2.43.0


