Return-Path: <stable+bounces-183569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CFEBC2F60
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 01:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828D93A3B35
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 23:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E8525B687;
	Tue,  7 Oct 2025 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apz0RRnJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F78023D281
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 23:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880281; cv=none; b=j7kVngeXH+KfdIYhG419lZgEpajRz1PuEIB6ibnUcJFnrk/2ozWaviYjAKpNi26fA1BncGR/is7TuRKRzTAsRK7/rNA+NFA03onyvtUjvaNg+UxP0qhrLXe++5Cy4wVxvTBf4InPNh1m8hbqH4uQri8vqlHAwPt65/2H+mNMeoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880281; c=relaxed/simple;
	bh=h26x29s20hjBJODDc+mltJ1rrKTeU+LcB6figctfTWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xs88yRDM/qYwiSWmCUEUu2aCwMR7oRMfrOBsE1EpSqoY4TkfcU1BaYch9mT3zkv/hf2TGir09BV+s0bbv5YgSpoWVC/ky13zTxUabpdWNHlPHfsvGvoAlnGMkSD4x55AzXVbz5K6Bi4WmD6NHxqokJ3aF3jGYd8EA8QdQzrwRKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apz0RRnJ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-87db3aa478fso286944385a.2
        for <stable@vger.kernel.org>; Tue, 07 Oct 2025 16:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759880279; x=1760485079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PLxpd9kbi54qSwlv5nU44o57YQdg6U4+ha5MoJ07Q4g=;
        b=apz0RRnJSR8eH+105kHOth9iqPn054UtK/j/Kz0qb1C+A1IxNURZiWDiBQq9WPJU2c
         z2aoWLdMkfiavHyiFwyfK4raSKoKq/pS2D2xThFJ+lbBfQgGIaoBvw6gccYiaj2dqrS4
         caRFZKQ0tghyj+ksfiBJl5C4a7TBGhx14Ap+dBcb7aOnz98s03JTftf3oJhw/qceVp6s
         MuAOPe1yTpqSK2Ct7QEWZJdYJME33nqlGO8DLlC6txODjXlp5qJONCYLJXAAovReXBd9
         lhO7YraHnFwcZERsVzn4myBG8HIPDWzGPTu9OPA7kN8OQj6aIbk829dzIeUzCcIYfp6O
         xnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759880279; x=1760485079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLxpd9kbi54qSwlv5nU44o57YQdg6U4+ha5MoJ07Q4g=;
        b=GvRI8F2f48GXjRSr+1nQnLJOB+H3OdIYs/NG6Im2umOaz8LIMkqnSfHUyFHukPR3FN
         fjuljJaQAVX+FP+Z6f7gSBM+FPzeY1BEV4KqmGVp+eFz48/7UbGkdH7p5TfBqOWAbJ9f
         qnVMFIm5jPYMXvC30KqtPq9W56Uos7E8EWbGcHXaK6EWxMj7n3YmCB6GWN7H087K46Yj
         2o6PChSLRfbJNJ+VQXTEeql2onsPhKzF0XWy5TMSIAdNoTEaPE03L9trIz6qgEwBm4Bp
         STw/VLt10hQNSdy2BPOTDhOM670zxpgJUKXhNhefoVZKa7wTTEPtr49Jam1kzpnVCJ14
         r7lg==
X-Forwarded-Encrypted: i=1; AJvYcCXv2frxf/XO2piChUciT36OhbT/6WD4aYStTXIQ+7V5RyCXUHrxPfOwGs2azjYswKcvfPUaHfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUoxB5DRWHtOv8V1LiDhnBe4nrDNdBWP5l5u+EmSQzI57HDkJ+
	0EnjICj0q6YFXvNjkFVWzxuesr8kXyt0EqHuTQ4OgU1/uust22MG5yDC
X-Gm-Gg: ASbGncvCJll/ABHpIOn5ybK6x56rDlXf+1tTj+obAXQbqhGWvEOsEhuXeDRY/EWScLg
	f46PYEPu0RmvPBS4nYrunbZ31wX3+FSjou5ndXLZhBVCkTCP5vz5EmNya1yckZqnHyvQJuWQTp1
	dGWAwKBSz/kjkoy2o5RVCr9qJTbb6SkUxYwFP4EEQykJLHwcr9tIGlLyg3c4yAUr8OC3Q1KNRuW
	09/VNgxxakeW1VFXovO2IqPX38A2NEOjBJJSW0XQ4dRlHFvEp5SNoYSUu5X6zyWyqjd27/dyuTr
	CttIXxN/zOn6SNcNS4PxMQAHzGdjs8snZ+tt1qARnPzJ6cHfkaCcIAgZZ596TJifZFWxQn2/lJo
	C46Iduvfmo3HPt8ICy4zSVtojskDmWOnRO9RQ9b9lUw1D52x+1tcjYBLO2QeIuno5IaDG8UCNfr
	oGpDvSsRcP6IMk45Vmyh+DZ2Pr4jgnT8A=
X-Google-Smtp-Source: AGHT+IGWuoyjLBHTvXhdCeOdSV6cJByJ0Y01xALhTW3Q5DEdDg5DMyRj8M0bafbfIIx4igMJsj0h+Q==
X-Received: by 2002:a05:620a:29d0:b0:826:a2b5:d531 with SMTP id af79cd13be357-88350a7881bmr266619585a.32.1759880279064;
        Tue, 07 Oct 2025 16:37:59 -0700 (PDT)
Received: from mango-teamkim.. ([129.170.197.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87a0e9bd554sm14351366d6.32.2025.10.07.16.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 16:37:58 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: bfusb: Fix buffer over-read in rx processing loop
Date: Tue,  7 Oct 2025 19:29:42 -0400
Message-ID: <20251007232941.3742133-2-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

The bfusb_rx_complete() function parses incoming URB data in while loop.
The logic does not sufficiently validate the remaining buffer size(count)
accross loop iterations, which can lead to a buffer over-read.

For example, with 4-bytes remaining buffer, if the first iteration takes
the `hdr & 0x4000` branch, 2-bytes are consumed. On the next iteration,
only 2-bytes remain, but the else branch is trying to access the third
byte(buf[2]). This causes an out-of-bounds read and a potential kernel panic.

This patch fixes the vulnerability by adding checks to ensure enough
data remains in the buffer before it is accessed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 drivers/bluetooth/bfusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 8df310983bf6..f17eae6dbd7d 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -360,6 +360,10 @@ static void bfusb_rx_complete(struct urb *urb)
 			count -= 2;
 			buf   += 2;
 		} else {
+            if (count < 3) {
+                bf_dev_err(data->hdev, "block header is too short");
+                break;
+            }
 			len = (buf[2] == 0) ? 256 : buf[2];
 			count -= 3;
 			buf   += 3;
-- 
2.43.0


