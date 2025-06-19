Return-Path: <stable+bounces-154715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD27ADFA6D
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 03:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF9E189B077
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 01:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E063915A856;
	Thu, 19 Jun 2025 01:01:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5324B134BD;
	Thu, 19 Jun 2025 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750294918; cv=none; b=EVTOlxmQlQbksBU7L/9KdGs3D6WcfFYd3i5MvTJOT6gHzPPld0LaPn17cC2reLMVIL71pPQUx1qe5UsvMfQo8MqGEj+m2AsUlQAGOwonKZs12TJD916GXuQW+KNs87Nwc/VcMaP04bHlUe0dE0q5hCKvlwRnppFY6AW7aGGyjNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750294918; c=relaxed/simple;
	bh=8dzAtZXRJbPHeK5rZiAvbauuD089RYH7HRSAJfHTw9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oOs18rAnilFz0uyeOt6KLc9Dg/LsqE7xpHYfSg6ZUuoNVpofdUL/+VWcebudTEyJmn4D9nUMgXEXz4cNvZT9VBj1F6M6iOQhlUfUWajHWjBFtSZOZG8QV7H+RCm7i+iG23cbJcQV7RIifFL/QdRGWWkRRPtYZDzBGih1U5yh69k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-313eeb77b1fso113127a91.1;
        Wed, 18 Jun 2025 18:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750294914; x=1750899714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GUQZrKiK5AnMP6uSUHsa8JoTYLF/N8UG3rC/9JKp7g=;
        b=a3oIcD/p0/J3iZCHQcOkJmwikZp8Cr0Fd/daktD2SVSmE7/n7s7p1p3VOPJhKlzKtx
         fX583gfalN1lHwhUYSmYmxg3WEPEzScY5qI4N2KxWZDRBtcQOdmgOPu+yWwUN78dcylI
         dJW55p/h+pp9RXU/MJO039DjKRa7rZ2qfdJnZ1GbOOdDiIFOmZ7WwvmqDJyE4pSxTl1Y
         JVFgu5uzz8cWDB5GkJMOdHaByQufq1pm2V9WJ/7nFflT37s8xdyqQqsmAfOw5ntTJCAK
         87asluDITmjFqBcycJUYJ/oPR5mFodUOBxbo4cehwJVo16EPuJiy7EjWbDSN6yt3jQuI
         df/A==
X-Forwarded-Encrypted: i=1; AJvYcCVva2PHGLgjxJLjp5J/gLkot2PDqAoPj45L4T7qXIBhE7BJogxpnyOB+xxLaQ/bx0qL0FROeBD91C4=@vger.kernel.org, AJvYcCWdxi6evBWqaAzDNTREMVlJg5sxp+FmMGMcVp7p2dYzjCXlLiV+n5HeBQRk3vIOLG9jn7q8LPPE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9fyNJD5arT36qrS5oJ7aGZbIkb7uP8CZWniz1SqpuKiqpVlUk
	f1pHwn1IK6I00ZMTuL820o4pDUjCJq5KYIRczUGNktwZSTwbjqEehx95xAH8ENXZDRtP9w==
X-Gm-Gg: ASbGncsDndoVUrI0/yX2ZavPxgE9gZuWSGkj1rVFLTNcYtmrbenaI0e7zxU/qtgDIcY
	iVpDqActPUF+Qp4JID1tDIep01KbfrXuxAA/FXdpO2NC0h8CBqUMii8kRvQL3DXiK6OzS9Amvbl
	jzfffSXjpF3lLc7Qgy3l/YXcxl98mhoBk4CS/rMwOfvQT/rt6jJbQUKq0PJeLhutSzULeuSUiLa
	4Spkddv8tP4SVTLH1gWzQZtOlu7icjadH0pLfihzrAgwmjypJM0NtsBwerwtMggeR3MZoBdEW4v
	hYALvhVnF+6tHdBTsGvJdOyOlDLyga03JAFUlJ80jBRP4UsEN55GQL3ugFyqZzxQo7YgNxHXCZ2
	5gWC8OIH3ItuT9w==
X-Google-Smtp-Source: AGHT+IFzCx5dv9nWBdXRDKiEG9z032p/ulG+lsXqayFYddezdizq+agAHSc6o8ODlDEAM7unBaWk5Q==
X-Received: by 2002:a17:90b:4cce:b0:312:639:a058 with SMTP id 98e67ed59e1d1-313f1d96ee5mr29701077a91.27.1750294914354;
        Wed, 18 Jun 2025 18:01:54 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a224620sm845475a91.7.2025.06.18.18.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 18:01:54 -0700 (PDT)
From: xiehongyu1@kylinos.cn
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mathias.nyman@intel.com,
	oneukum@suse.de,
	Hongyu Xie <xiehongyu1@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] xhci: Disable stream for xHC controller with XHCI_BROKEN_STREAMS
Date: Thu, 19 Jun 2025 09:01:46 +0800
Message-Id: <20250619010146.394294-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Xie <xiehongyu1@kylinos.cn>

Disable stream for platform xHC controller with broken stream.

Fixes: 14aec589327a6 ("storage: accept some UAS devices if streams are unavailable")
Cc: stable@vger.kernel.org # 5.4
Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---
v3: add changelog information

v2: add Fixes information and cc 5.4 lts

 drivers/usb/host/xhci-plat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 6dab142e72789..c79d5ed48a08b 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -328,7 +328,8 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 	}
 
 	usb3_hcd = xhci_get_usb3_hcd(xhci);
-	if (usb3_hcd && HCC_MAX_PSA(xhci->hcc_params) >= 4)
+	if (usb3_hcd && HCC_MAX_PSA(xhci->hcc_params) >= 4 &&
+	    !(xhci->quirks & XHCI_BROKEN_STREAMS))
 		usb3_hcd->can_do_streams = 1;
 
 	if (xhci->shared_hcd) {
-- 
2.25.1


