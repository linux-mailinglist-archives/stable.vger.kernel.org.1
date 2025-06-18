Return-Path: <stable+bounces-154641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A229EADE4C7
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 09:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3A31898438
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 07:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54266254846;
	Wed, 18 Jun 2025 07:46:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CD0944F;
	Wed, 18 Jun 2025 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750232819; cv=none; b=KcqUeTppNFf4kK7PbEf/xBmhNW1HlqTMsx7PV9IHMTvQolTj3PWlggOZR0v/c67vh9X6e6gh8CKWonR6ro0gZ+Igo66LTfOG0F4egmVlMS4naMa8zApMMJ6Xnepw/Hn56BSiAPDQUALc5Ur5FuY4/R9CYrBjY3Y9NBouFHYbCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750232819; c=relaxed/simple;
	bh=fK+icWTWTS8ChRYmgJe4JInNeZdQsKKcXMzfxvFeWCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SfnWzKhXfA8JLjMvQ2AWON8NAnsFXZJ3S6SlKksEKQAtGFA6XoUYs2k3usG7LFmMU+uTmMhpOZkAD6DEvvxYeiuF1q5apABqkEQqNrSsrIcso9K19IRik2YA4CRJ/UNWv/sMJj/2+a6wujV2/+n12vlX2nv1B5ZX1v3/HzLXtN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234fcadde3eso85267985ad.0;
        Wed, 18 Jun 2025 00:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750232816; x=1750837616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGlUiBAoJkmRj68VLYJK0hx1In2EpfAj4z1QBRDEbfQ=;
        b=Mf407RDfufBAVntYYuZXYzr3Mhx+rfzJPajVmFl4PlOWe7BSXy32WLajK9PydL+Sv/
         bVenuazI6LHBxpCxwPxb78w5NvddhXDlT0gD1InJqIJ1PcR90Fipme17pPaSFNRjjt5j
         omTz6Dodw4WajInTqpj2V5daw4gaHnrDiTjukP4Rrd9yEbvWn/uQo18VrObBF//UBvEE
         6NIkMfrNL1/Ya7GG0ZpCLSJvP50x7bcjuLH7weMu8LOtLWrSg2EMidZQ54crAIcTsNT8
         eYAxWosQaaVPrBUdiuWCOE6gFqi8HQ9i8cmiybHDrF45CnYeJQ+9C15hhnXx0BtIwqYH
         iTwA==
X-Forwarded-Encrypted: i=1; AJvYcCUPBpUlj+zN4m3PsBwvdVroNHWghUFv8VeZaa2M0MZLR3BQJdhPbUJW+4CFRiCsQ4X5wk+6U0+Q@vger.kernel.org, AJvYcCVTuf172aujw8aAuTjuHv3mrMPuUg1nyos5GZwCSkdMY+5y/gEPhSwdVDnGSDEaKhrHWk4SwQwmPhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL8yGxrpAXMSeIkI39w9yYhauVBZ10gonSzw7DK/T4IEihuWgX
	ieKp46lkMJMNj/A8YJxNSAOk8Zn1f0W8obcI41/+2pOUpVkPyOXAXpbyThV27yNhJ4E=
X-Gm-Gg: ASbGncvxqOZE071W4zlPojzGaL40K1PbyI+grFpQR83WuzyL2lFjzbiLN2He7TJ/X7i
	GuJZIjv4mJRKt/FkLv2Z5D51en7fHCGdlSgSew8+3YlzAdsLxIEcqgHaXqgBJOMHaHaQe5yAApc
	y8TYnCgye/gdY0JmYd23yIvzOjMX3ovcVuU0rRUoK1UR66ryjo2F5BYuwsnfqS4zvv5WTPyMt9R
	PxStb1SqCUisOmLi1bq02IJO1p9i5Tdf8sxWeMwcKoNvgdH8hp93z62Jp7U0m7I7FsD2wUn/LfG
	hYLcDH6mMJrHB06T45EgwwaYMzLHKbuuDEUxtY0RmGT+sYFomqDcjj3VQKT85sHZW+31KyFW36G
	Tov4=
X-Google-Smtp-Source: AGHT+IF9pE0v7751yHhx+AdusbJXsvyHWq3cdiW4yEx/ti/WuhWZ0f2d9Kbvw7qqmHNdONWSrTy0+g==
X-Received: by 2002:a17:902:f790:b0:234:a033:b6f6 with SMTP id d9443c01a7336-2366b3a959dmr232406725ad.31.1750232816011;
        Wed, 18 Jun 2025 00:46:56 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deca2b5sm94085355ad.195.2025.06.18.00.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 00:46:55 -0700 (PDT)
From: xiehongyu1@kylinos.cn
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mathias.nyman@intel.com,
	oneukum@suse.de,
	Hongyu Xie <xiehongyu1@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] xhci: Disable stream for xHC controller with XHCI_BROKEN_STREAMS
Date: Wed, 18 Jun 2025 15:46:48 +0800
Message-Id: <20250618074648.109879-1-xiehongyu1@kylinos.cn>
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


