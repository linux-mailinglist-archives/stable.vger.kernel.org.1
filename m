Return-Path: <stable+bounces-108468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D6EA0BF7D
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 19:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A4F188779A
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 18:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0211BFE05;
	Mon, 13 Jan 2025 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IThZDohF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9578B1B87CD;
	Mon, 13 Jan 2025 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736791292; cv=none; b=D3n3jWc001TQZBpraAv+FofhUCnYYG5O2GGoJUcP6tf9Ut22XLnxfTJuuSxglTBmRfHlTWQ+UgAso/dsOOXlIM4R41wLxpjwsiez8dK4hpORCnElHEUbxXhTRnLZjrbmSZetPXmJdKBv0NAQca2EyKlfzioKGmPFQAlrWKJXmaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736791292; c=relaxed/simple;
	bh=2YgvIzODMSrHU+mF2a7jbDTh5CTNYJgP8eW4Bpt8Bh8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tPS+JBi9cTgEpueDAUuYnajCcB4irfulRMurRibpw05mSbw5cMNAO5vQ5d63P0BXhtGmRKbpX0RQMXII+VjwjyAqXvHwdIe+H+KE0xvVdATVKZ9UTrbp7I7aPRuTvflE5ethkhTB7AbhP3TFTBvX7voeDp1/5mDojGQO/9ISNAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IThZDohF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436341f575fso48336205e9.1;
        Mon, 13 Jan 2025 10:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736791289; x=1737396089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G4Ib3PpG18diW9lMYcaQ9q3WwOQ+VuEr/UGR4aGiwlA=;
        b=IThZDohFRsmx61ZgTyt1FqjReTP+0N0Vq0c8ftKF6g9dQURVSq6wn8DBe1pJqwTEoS
         Ptp9ge2dm4KKReRjzy5fw/51PEQ3CdPRbyqOXmTFI+NecWCoIfIR9jAzaaArKll1nzPH
         nc6t6HsXv2opWoW1xMJEZw7TmvOIpjNIGmUD813W4JyXd7NB+Itc7Gf5r2gVzGQxpTLm
         d4pMEizW83BYxV9kLk4kEPGTJKaUcP3s1gHRmAWvJhAPk0/Bg6Co/hPdC0HDJkG3RYTd
         rHQd6TDs/LiurPCfgiKbRPf4wKHdAn3sIOcbMDatHsrTMFR6C623fQ6+XmeG+BW3oRFt
         46IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736791289; x=1737396089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4Ib3PpG18diW9lMYcaQ9q3WwOQ+VuEr/UGR4aGiwlA=;
        b=lDdKT+ZhWiQq7Rpa/B44n8VpNWKtoN2VJC3i8qALOO8fu1svDRdB2PaPZWGD5SASYt
         IJ9GwROtXXQBzSyDCABevs1U9OqdhnMbNz5s1hoc2LEcEVW0ghR0eN1pavG3VSTg4LsJ
         IkN77VVTcS9dtFd4lhTKz5BvL7Ah2Q4avqGqi/EHS0pafcnavQJDE4699VtcsvHwlOIZ
         ycc1/c0Mv91+wYcLAl9LLTQHmUSbs73vej4UC0BCdbFuG91VxZydehYl9vyuMXQoiSL8
         NYhwBfcP2nke9g8KC/S0CNGCOAYfAXa5IP+sP+jnULnfRqhI039OMtBfA9oa+3EvrIjO
         Ga6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUO/+gLbwmlTq4ljQ7uwG8UTiUEVUVnYl2S6jgaZdHawGp5vabUoSmRCt/X1Xa5ySUk9UT59iry@vger.kernel.org, AJvYcCVFvr0Fh1sK+Pf72V3sqIig/w/EFZ+ALZF7J5RD5S44pYJVJvUOzxG7p1v2UPVY8EmOZ35hFEmZ9NRWzhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1mtjITkTi5nXPQrDuk8WjiQXAcdiGVSVrMZc+skHEdieG/eBf
	I6FwxB/Wp9+njIEMXZl5RF30r71Xkc/slZuH+qe16QaUsOqO6E4g
X-Gm-Gg: ASbGncsJ26AwViLsqgb6WSI4OsrULE0ee21xLsrvpN3CLtdnsiUwLyQlpIFKECDZ5Ux
	E5hB+MZwajForPb50Kcf7ZkOqltq3HdM1krJmg0j0lLwOEusA5CSXgZWPmuVdDWjyCQQaooVxWH
	jIko4PD/M1gcKOOB9Qe4mH/j7FER2yaxEv7NfssULj7nRkrg5jJOH7/WtBBgkB2UungwWZQ7l9v
	z9nY3rzfaxjGnC9FTAtvHVYG88+DHhxYbi6rIKlManJYOVEqpck5u9/zw==
X-Google-Smtp-Source: AGHT+IGjHIGIjo5PDpWTZYjQ/shv7GJKaNdCjwLLKqGB/qBjRP/aCpEGpUkYl773v6bh0cHNofNhvg==
X-Received: by 2002:a05:600c:1da8:b0:436:6460:e67a with SMTP id 5b1f17b1804b1-436e889dff0mr153039815e9.25.1736791288562;
        Mon, 13 Jan 2025 10:01:28 -0800 (PST)
Received: from qasdev.Home ([2a02:c7c:6696:8300:b223:13ea:b85b:4f5c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b81d7sm12776178f8f.73.2025.01.13.10.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 10:01:28 -0800 (PST)
From: Qasim Ijaz <qasdev00@gmail.com>
To: johan@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot <syzbot+506479ebf12fe435d01a@syzkaller.appspotmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] USB: serial: quatech2: Fix null-ptr-deref in qt2_process_read_urb()
Date: Mon, 13 Jan 2025 18:00:34 +0000
Message-Id: <20250113180034.17063-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses a null-ptr-deref in qt2_process_read_urb() due to
an incorrect bounds check in the following:

       if (newport > serial->num_ports) {
               dev_err(&port->dev,
                       "%s - port change to invalid port: %i\n",
                       __func__, newport);
               break;
       }

The condition doesn't account for the valid range of the serial->port
buffer, which is from 0 to serial->num_ports - 1. When newport is equal
to serial->num_ports, the assignment of "port" in the
following code is out-of-bounds and NULL:

       serial_priv->current_port = newport;
       port = serial->port[serial_priv->current_port];

The fix checks if newport is greater than or equal to serial->num_ports
indicating it is out-of-bounds.

Reported-by: syzbot <syzbot+506479ebf12fe435d01a@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=506479ebf12fe435d01a
Fixes: f7a33e608d9a ("USB: serial: add quatech2 usb to serial driver")
Cc: <stable@vger.kernel.org>      # 3.5
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/usb/serial/quatech2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index a317bdbd00ad..72fe83a6c978 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -503,7 +503,7 @@ static void qt2_process_read_urb(struct urb *urb)
 
 				newport = *(ch + 3);
 
-				if (newport > serial->num_ports) {
+				if (newport >= serial->num_ports) {
 					dev_err(&port->dev,
 						"%s - port change to invalid port: %i\n",
 						__func__, newport);
-- 
2.39.5


