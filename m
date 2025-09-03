Return-Path: <stable+bounces-177630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FE2B42353
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 16:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DA4165A91
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 14:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A793074A1;
	Wed,  3 Sep 2025 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwUm+Nyj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498361DE4FB;
	Wed,  3 Sep 2025 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908982; cv=none; b=fbmeyl2kplua2/iaWHAJeAfQMIqZNQmLwxt71THTRdAhtxsCQApfcTC0sVJtm/tJmCUArIpl2Dy9xEicKbYQY2Q2Shr/8DcwMza0lPDv5eizYAmvDh4KJQtQ0OxoUDoZQPYpiBWEDW5xAcTNbXotzrcoRu4YJMLNcONeTMgwSMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908982; c=relaxed/simple;
	bh=St9fHw10rwgxS1Egz/yc+TzfgHHjx7abaCL7UqiQWBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pd8Lz16HEs8yPN8ojAkuYxZI2yzYL0Gvp2snhspfeVRiypknkvHFPgYbL/DMPkLQqcouHkI19pFl+8WlfkcsM46o/WpSWnUo8CCtww9n2yjdYnwl96otpMF0uTL1YUbJFK4qAFnQLPnw/yZMyEhyrxigiDoXzz7J4i7eg5PPZCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwUm+Nyj; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-772627dd50aso1173491b3a.1;
        Wed, 03 Sep 2025 07:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756908980; x=1757513780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vSIVzxsZnDEDQYyytjPWJDnoB+qkvrOnEt7Ac3yB9qY=;
        b=BwUm+Nyj9tss7zeLoHMlDeHhl/pa8Uyr0Ytt8DhRnXLLCgccDayVU4aZ1bIiICBq9M
         1MWx64BRKoNeQrwyCtsESdGVjBbaiJJRl+QT9364BicNa8bbRoYqAcaLAC7RHieImIIu
         5dTsujBNE+68WWjSJrHlfgujT7CwqQrsTBcqqYU4ifSo3eF5C+FvUv9saVn8decFWV9s
         mIQh23VkJ6KZF5Y60/k0wxs1EaoEsIHUdLeGL95IjV83a/b3aRNjwBvmjHjN8b3OTNa2
         K8fHyCBNin1liWj1LVzttYYoxuenUsGKEP9JleF9qD1IJoABupIxfrtRiz+Lm0lINfMs
         zCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908980; x=1757513780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSIVzxsZnDEDQYyytjPWJDnoB+qkvrOnEt7Ac3yB9qY=;
        b=cMPUNUIKDSi2Iqv1K3qk/2HA1bNdafCuP+LwASY0cE3VDhV2G1cPA0/JWnAhhzQKY+
         qWJqqwTVKqDt97u3d8ewuUvCkML+eWau3kaQrPaNbCHzFkSH+IioDRayCN1M/2EY+R5I
         LEnPrUKx/8VSwnr0DqMOA2U6SJascHvJJ6iPwSjF9soFONPscPRkhUvj10We3t70Rr+0
         JD9XQkjGFxJ1ClJbwccG0GtB1f7/dZmzG3E0eHhY2c8K6Mfcsj/QaHHaemwnvdJvpbH+
         bZ86AhSNtDBzYm8h9N9ha1CLmGMeAQCOwZsz8QZ708Kqn+AoJwrQiQXJNbzUcKaqsVeN
         /o2A==
X-Forwarded-Encrypted: i=1; AJvYcCVjBEHOJabs/oq6e3xHqH1X2nVBb820Qa9Z4lzexcd4YxeKgh3mSExhGpOOolqnoxuKKD30118LOfthmgM=@vger.kernel.org, AJvYcCVumD8tuJHLi/RsY+eV5V7ImxP263mmJwFIrjmfKrRqfYj367JHuYp5tLJ4ck8K1QdcO8+oTRUu@vger.kernel.org, AJvYcCVyPEE7QjDbU6og5xdDC90A1WHojLpwgPykxhwAWayaqJq53UA0HlBsXIwgKNq+sK7uniTQCm4FDoek@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9lg8O3clskjhzR458L2SXmJ1SadQwAgDvZODTKBZCbFLq9QkW
	1Uc/HYERstzcSjAzHBpERW5stsaSppNpZavnwODjQkS/x9bX/5FJG4kP
X-Gm-Gg: ASbGncueGVUzj/asHyHnfLgFZoVdNJwWKl7STuVj7mEyv7tXwUoniQgdUJOO+MztLpg
	yS16M0pdp9ulCJeNNdCtcrCo23mTSqHt70QnNBoYOXx6g4JbWQzRGaHcF4N6BZnd3g38qnGY0z2
	PrZolN9WN2CXmLtNxql0sjo8QR2RzJiW4oDEcbCqwp0Vhee+7noxIuL0WkxfVZBircT+/Agbz37
	fuVmFLfEcB8BLzvIBrLY2AOlUuFizT+hFnohxq3NYdaKjjveALYX091ZqvotNy5hAFdO3L+qvwh
	Mfk8DIbowW6RJyoYzQfwbh3fXO6E/EJ0A++YmFuP40PITAUoBpCJYHTHUE55bjlMlhNnGjHuVp0
	JfMyvBMYVnE+pZ8Ye4QD7RvFkLBOjaX0UurSev3DyVskfcxuCqP7UXEfZ0UFdYUYuJWFF11WxTM
	tnZXyfrhSgDBM1GLmIcCTESOlTMGFC+J25XbmLhKCkVGmFDz+Ab0NRkUgeL1ByKR7RUQ==
X-Google-Smtp-Source: AGHT+IGwsvYyVoIJgvncmGFJxFvcJbXT10B9DfRdoej8UYDq/Vr/6qTmuq10RnOU+77LfVi51PhuNg==
X-Received: by 2002:a17:903:244d:b0:248:f844:678f with SMTP id d9443c01a7336-2493f04071emr219748565ad.30.1756908980318;
        Wed, 03 Sep 2025 07:16:20 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.22.11.161])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b4cd38610edsm14508264a12.54.2025.09.03.07.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:16:19 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Pawel Laszczak <pawell@cadence.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Chen <peter.chen@nxp.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] usb: cdns3: cdnsp-pci: remove redundant pci_disable_device() call
Date: Wed,  3 Sep 2025 22:16:13 +0800
Message-Id: <20250903141613.2535472-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cdnsp-pci driver uses pcim_enable_device() to enable a PCI device,
which means the device will be automatically disabled on driver detach
through the managed device framework. The manual pci_disable_device()
call in the error path is therefore redundant.

Found via static anlaysis and this is similar to commit 99ca0b57e49f
("thermal: intel: int340x: processor: Fix warning during module unload").

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/usb/cdns3/cdnsp-pci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
index 8c361b8394e9..5e7b88ca8b96 100644
--- a/drivers/usb/cdns3/cdnsp-pci.c
+++ b/drivers/usb/cdns3/cdnsp-pci.c
@@ -85,7 +85,7 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
 		cdnsp = kzalloc(sizeof(*cdnsp), GFP_KERNEL);
 		if (!cdnsp) {
 			ret = -ENOMEM;
-			goto disable_pci;
+			goto put_pci;
 		}
 	}
 
@@ -168,9 +168,6 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
 	if (!pci_is_enabled(func))
 		kfree(cdnsp);
 
-disable_pci:
-	pci_disable_device(pdev);
-
 put_pci:
 	pci_dev_put(func);
 
-- 
2.35.1


