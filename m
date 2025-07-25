Return-Path: <stable+bounces-164739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91516B11FE4
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 16:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA45D564EC8
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 14:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAE6224225;
	Fri, 25 Jul 2025 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pBebP9rA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EE27494
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452981; cv=none; b=qcDRt3/LBwYVgf/ZmlQ58w22GD3INAtJeHo2GdzrUQRxiLIriEYZC2fQ5ykRMnk06aVSLOjJao/K2hBrykYQcbCITBp0H0R4C4q1z7WSSGGicfxf4s4rgnKmoFlUzAW5m3T+8NZidk8BdHuF8iZtF6EQDKTSvqBOlncmZt7z1Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452981; c=relaxed/simple;
	bh=8AW0wZtIdMTOecI8zEy7or/xRHq/+HDNB4Msky+fi4A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F7YGUZjJkw3Nvt91P/gJikNBkpd6eT13dQmnSiftXErgkSmMk6zy1axbxzE86/88tj8LGMBupoDluQqN0XDF0CwM9FLB8bAEkJkiUM8s6oBD8TynzvVJqcHX2JIo0h6AR4+nR61vQyRNTnsLoyWlHWkGP5nIHZPvdQmp32YOKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pBebP9rA; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so4646741a12.3
        for <stable@vger.kernel.org>; Fri, 25 Jul 2025 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753452978; x=1754057778; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0GYrZkLXVXcOZgbWnPr9ONxYHIczwht5gJlvJdmNzQk=;
        b=pBebP9rALtTAJKnpPJpllQiQY9VyHBqULO3QVOWmJ5tHTNwIFaXLluiQHWXyiL6Xy0
         PhL6Ido0qCPelByNCaLUEzqA3kJel/6i8NBKeOVLVA6tfG6fWetUM75BBKojyvH3CemT
         2aD6LpUKdXpATcx9W+fWh9va6Rdfrk+2QKO7HDcLplrwT+N4Eh6Ncv3b6qJyPOeKCoa+
         3aXEpODFl5Y5Vt/SowT0DixTR1wlN/snGgxQ5cIYPuGCXYMlUqdnjTMObT//AVbIJjNa
         ngCDvW/QKYOCyittTgnCCR7/Od/oT4wO9oTXE/PejAjzg7k/7gtTB8rV4kPMUUnkgjoj
         /zEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753452978; x=1754057778;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GYrZkLXVXcOZgbWnPr9ONxYHIczwht5gJlvJdmNzQk=;
        b=JiR04sYM4YJ8y8AruEiadny4ZMvoe+O0fQYA4VUcuoOibpXGGxV667THQAwO/1NL1t
         HW+cFZXa+H42GbcrtJOTfYtrFEyaq8iHmEeCoFi1ngai4ptfB4MtvLSImf04KQzkxVzp
         RDfPdKyN102Yfjn482LvPeMqPJMYmVJgfQVQD+pfZxSk1d3Wxd5A9TP4viAjLPYCIhG9
         E2GbFNpBYWZUWtljjy29Dvdofe8t7OJpVSzTnljymPjInhsf+LRgG1vB4OtASNLKVWlP
         vlKY2/OeFhFnmJIzjFiWop+WzL9Pk6F92fBFygfpWy/2q0SFW5nS+yg/127oHeJhGY0G
         gGDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtQkTcqTUDaRgd1Blj2yHd56kMELwQU8ETE1FxE/uBwwqH9k1rU69XzO/MBlL8JJvxJ3bZPok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5WIBjGHWH0XyaMyZ9gUpdJEPqDGhi10rM7TxyeOUOpBrVCAtJ
	4il2eHmFO5hBNl3SrleNufxhKDZzR3nkOB0bwHrr7UwVjVHKETuVb000oEZZCwq6E2c=
X-Gm-Gg: ASbGncvhtN6650FEMU0WOWI/XuyVhGiAFBJq+UPHr+v8UZ3c1Bst3wyLyssJkyc1mGA
	3rD3ovY1Zt9vlDUovvWuxB7z7Rzh6o9uvdQd/J6gefA6QzwVYmAWJdDMDPyDzQq7lFQcEoiZ29u
	UD5lSzG8cs5TcMJV7muABl6ERaVgOcuijQCJX8bE2/aqVv+wbzgl/dyECC6yMZ9lHV3nZOAbg09
	kvfM2DHLXbfAR3w8v4k75bMQBrGirQ3UOMsPu7IqVlPs9c5Od4CPbnBazB8i3wGkSkAYS5P8wPs
	NpBgz+u1dIe33tDY9LCHWqgoNpXxvxZwHsZy4kklKTzm1z2SePHfeskLxl6UJpKJquzLpN04qNU
	gYLc5m+3VHNEytWBguzV5PRYkOXMUG7EWYZUJzn6J8tMvVUeRKFvh4rKG0J3kzsdInjgaR/Wcze
	hOGXAQ8A==
X-Google-Smtp-Source: AGHT+IESxxtSVuTR7JcpPvCin5sJRXnxskX5QKzVI4SQNZf89ZEV5qKL5Ev6pflyXfFUSgm5m/ZQVA==
X-Received: by 2002:a17:907:7205:b0:ae3:bb4a:91fb with SMTP id a640c23a62f3a-af61ef2e6demr228089066b.59.1753452977655;
        Fri, 25 Jul 2025 07:16:17 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47f85e60bsm278398966b.96.2025.07.25.07.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 07:16:17 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 0/2] scsi: ufs: core: interrupt handling optimisations
Date: Fri, 25 Jul 2025 15:16:14 +0100
Message-Id: <20250725-ufshcd-hardirq-v2-0-884c11e0b0df@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAK6Rg2gC/13MQQrCMBCF4auUWRtpJ01aXXkP6SI0STMgjZ1oU
 Ervbiy4cfk/eN8KyTG5BOdqBXaZEsW5BB4qGIOZJyfIlgasUdUdSvH0KYxWBMOWeBFjJ1F73aJ
 TGsrpzs7TawevQ+lA6RH5vfu5+a4/qv2nciMaoeWpNwp972u83Gg2HI+RJxi2bfsAJzI6Da0AA
 AA=
X-Change-ID: 20250723-ufshcd-hardirq-c7326f642e56
To: Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, kernel-team@android.com, 
 linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

UFS performance for < v4 controllers has reduced quite a bit in 6.16.
This series addresses this regression and brings numbers more or less
back to the previous level.

See patch 2 for some benchmark (fio) results.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- patch 1: new patch as suggested by Bart during v1 review
- patch 2: update commit message and some inline & kerneldoc comments
- patch 2: add missing jiffies.h include
- Link to v1: https://lore.kernel.org/r/20250724-ufshcd-hardirq-v1-1-6398a52f8f02@linaro.org

---
André Draszik (2):
      scsi: ufs: core: complete polled requests also from interrupt context
      scsi: ufs: core: move some irq handling back to hardirq (with time limit)

 drivers/ufs/core/ufshcd.c | 211 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 152 insertions(+), 59 deletions(-)
---
base-commit: 58ba80c4740212c29a1cf9b48f588e60a7612209
change-id: 20250723-ufshcd-hardirq-c7326f642e56

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


