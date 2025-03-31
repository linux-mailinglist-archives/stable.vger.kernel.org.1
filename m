Return-Path: <stable+bounces-127037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BF1A762CD
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 10:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2B01889FD6
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 08:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E1A1D90AD;
	Mon, 31 Mar 2025 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DvKRl8VA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0E01D7E52
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743411352; cv=none; b=rkRwVUcf/F4+jKYnjZvsv8+IOSrnnFK4gWbfeVUWZqXZwVTnN0Mu5gtjiLJN/l6Ce0EqS88Zo22Vkuvdtma/0swb3KHg0uwMskHYsjKy8b2Q2gA7GSdj6a7LmvV64eVDapy/zdwqvI2nViKeQ3moJARPIiamZS5kja0YuhfbMjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743411352; c=relaxed/simple;
	bh=vg7Aty440Ed4mkGmGT5Xgyf4CTrtEUYU6m7ivcveDAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hzI8xxpgmrCVY/ccpOv/TPji/rz/LYPgnVUPJNVNA8Bfn2kPwHh4ml2/Vhnw+aku3Rrylvnrhy00dMzp++Rzs8aux2JrZqLmfBn9a6J+Lyj/NGH+W4IXv/BiqSa9wSdy7qqWBZCJY2BaNoKpdlHqHBApiEScMPiwLpJMh9RFzgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DvKRl8VA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22403cbb47fso87857345ad.0
        for <stable@vger.kernel.org>; Mon, 31 Mar 2025 01:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743411349; x=1744016149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rl6/yfrgHMry1T02uA2XjsjoAKq1zL1iGk1DzXNmiJQ=;
        b=DvKRl8VA6XX98BfdLp/wQzf0vBD3xs8zkQCDisC73S5RXe3F0rIo7kcC4TM9pjmB8i
         yInaNUe6dnyBMQaAPSrXezhgu+yGBkVuJua8AY98SFoQNoXvXYeXZ8rQx+rIjIpESCoz
         D4GKEFmozXO+kTIiraQ+6Hh1PHeQ7mCnmECmKCo8nJC+DAYE8suoTHiGP55wkH3rirQr
         AiZ7vWeECSlfDX4B6fkjhN2jiz2ysKF0eGwk7fxQmn7WHeQdfFJT9JWV1uKibE+a56WV
         iAl1EaeeK3QjSR5MPj5+B7R69YHwHTGVO+rWcCl+u397FDx/ZmBNZ6vgGUzqQY4lh2rN
         SAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743411349; x=1744016149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rl6/yfrgHMry1T02uA2XjsjoAKq1zL1iGk1DzXNmiJQ=;
        b=PY/5dIV++j7VSTKMTC6grgXPrgZ6GaTpwV5EqqTkRcgyqItqK7UWdjUm60JpRJdQFu
         uoZ9pepZdPkLeGf2egCVf/wTIOEFeQnHcNBT8llBFXOIQsRNvhElkPq23P148JNNSjH0
         93bvCvCBAAtDaW710AiMPD1PKj5fOPuqy/n+KyiDJSnlCo48i9jOQhzHn3m8g9OL4jRA
         q1cDVRK4dBnP+hMqGczNQ8uVNQL52mio8jRDR1XQFy+yNSU166Fp8yjOumQem8hxofs7
         dx3VM+xECIPK/zggru+L0QRYkjAWnKcRXiID7TU7w0YCcaFPWPU9froOmbpdDPvcoySu
         LMow==
X-Forwarded-Encrypted: i=1; AJvYcCV6K4a6XFzAmR+otH5bKr+J+ziznw9jHwk9A3FDCB4pZaF/LpXu5auGaRjYC0lQ5v8ERS2p3wA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI98wp6EzjUKmgIAqKwszOhFuimJ4f9lgdrh/rwrKRHggVkvbj
	hpwq0mKQaDWGbrnKOL5xTOzMDLCRjrh7y4s5fwFs3+xhLGytAUepXRSCUR1QekE=
X-Gm-Gg: ASbGnctnGpvuBpquMRSpI3JrTkDWU6XMsZB6db29jkEaKlkabWf5q3PW2B6lWb5x0SV
	ZCPta+o945863cyk+wA0HVFFvm+Xhw8OA1dVbRtDR0FazOR4jhHOHkg6kzWj2KPfiG6NjAc/5mg
	Flza/n5ZksMqPHGXZAMQFe3yGpS9QoXpGyJfpb7+o2fD4btqc+kyNWimE0Cbmq82mv09nre+3Dw
	eEnh5/E8bwEh7YmBnnrZJZHDjMuyx5SCjBWZxCKzvl6jCz9FNOT5jOpnQyPEf0soiAUQbq+Rhz7
	zQd3zExrCzYA8wfiwxlnML37D+v7ZZXn8GfZMCtISQrxWekTLRCXKwGMgNurxbL8hg==
X-Google-Smtp-Source: AGHT+IFcN0Fvff5Ssn/6D2TkCyKTHYUWC7wGULJMyVCMHWHel5iTtJqXbZR67NkIJsx16rG3HOAYFA==
X-Received: by 2002:aa7:88c1:0:b0:736:3d7c:2368 with SMTP id d2e1a72fcca58-7398036fc34mr10372507b3a.7.1743411349079;
        Mon, 31 Mar 2025 01:55:49 -0700 (PDT)
Received: from frode-fedora-MJ0FLJ04.thefacebook.com ([2620:10d:c090:400::5:ac76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e2a0e2sm6695564b3a.67.2025.03.31.01.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 01:55:48 -0700 (PDT)
From: Frode Isaksen <fisaksen@baylibre.com>
To: linux-usb@vger.kernel.org,
	Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	Frode Isaksen <frode@meta.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: gadget: f_fs: Invalidate io_data when USB request is dequeued or interrupted
Date: Mon, 31 Mar 2025 10:53:50 +0200
Message-ID: <20250331085540.32543-1-fisaksen@baylibre.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frode Isaksen <frode@meta.com>

Invalidate io_data by setting context to NULL when USB request is
dequeued or interrupted, and check for NULL io_data in epfile_io_complete().
The invalidation of io_data in req->context is done when exiting
epfile_io(), since then io_data will become invalid as it is allocated
on the stack.
The epfile_io_complete() may be called after ffs_epfile_io() returns
in case the wait_for_completion_interruptible() is interrupted.
This fixes a use-after-free error with the following call stack:

Unable to handle kernel paging request at virtual address ffffffc02f7bbcc0
pc : ffs_epfile_io_complete+0x30/0x48
lr : usb_gadget_giveback_request+0x30/0xf8
Call trace:
ffs_epfile_io_complete+0x30/0x48
usb_gadget_giveback_request+0x30/0xf8
dwc3_remove_requests+0x264/0x2e8
dwc3_gadget_pullup+0x1d0/0x250
kretprobe_trampoline+0x0/0xc4
usb_gadget_remove_driver+0x40/0xf4
usb_gadget_unregister_driver+0xdc/0x178
unregister_gadget_item+0x40/0x6c
ffs_closed+0xd4/0x10c
ffs_data_clear+0x2c/0xf0
ffs_data_closed+0x178/0x1ec
ffs_ep0_release+0x24/0x38
__fput+0xe8/0x27c

Signed-off-by: Frode Isaksen <frode@meta.com>
Cc: stable@vger.kernel.org
---
v1 -> v2:
Removed WARN_ON() in ffs_epfile_io_complete().
Clarified commit message.
Added stable Cc tag.

 drivers/usb/gadget/function/f_fs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 2dea9e42a0f8..e35d32e7be58 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -738,6 +738,9 @@ static void ffs_epfile_io_complete(struct usb_ep *_ep, struct usb_request *req)
 {
 	struct ffs_io_data *io_data = req->context;
 
+	if (io_data == NULL)
+		return;
+
 	if (req->status)
 		io_data->status = req->status;
 	else
@@ -1126,6 +1129,7 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
 			spin_lock_irq(&epfile->ffs->eps_lock);
 			if (epfile->ep != ep) {
 				ret = -ESHUTDOWN;
+				req->context = NULL;
 				goto error_lock;
 			}
 			/*
@@ -1140,6 +1144,7 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
 			interrupted = io_data->status < 0;
 		}
 
+		req->context = NULL;
 		if (interrupted)
 			ret = -EINTR;
 		else if (io_data->read && io_data->status > 0)
-- 
2.49.0


