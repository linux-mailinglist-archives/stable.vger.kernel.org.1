Return-Path: <stable+bounces-163239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC87B08903
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 11:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B16B56692B
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 09:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071D7288C36;
	Thu, 17 Jul 2025 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UqJA9841"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030324503B
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752743465; cv=none; b=GPiCZ2SjmLbfpQorFP8LlCCPD1jh3GAFK9gWBIrAwD1eO6mq6+XM26h5xirk7gEEaKgM997RG6pNMqEg+wgfTCvv90iYTON2qjq7c5yus8+GrIe2R+1BzwAffq2m42SVPvwXl4vdsIvuPanqk1E7ua5W6I8iz1/+6g0pnptriKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752743465; c=relaxed/simple;
	bh=/8oQPYYz6cHSNYNwym9xwEu6RpZClPerPGm665iJk6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=igFmXrFd5m3dfyLV0yAeRBpYRsTGS0O6Ki/7PD87dG1g0jWD/GQ/fZA93Zta6080q+uBI7Gh4JxnG2fvtXBF5nCqnpFtCuftGYlz/BikUxYA/aR9a0LG7gYEMu/XaFKeVJRdQLNAbxXNOtvTgUXL4CMG8APKqFtlpApBQ90YjV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UqJA9841; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4e749d7b2so118628f8f.0
        for <stable@vger.kernel.org>; Thu, 17 Jul 2025 02:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752743462; x=1753348262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HyhBoxrCNtsTMaq/ZkCXVp9e8dnMJwhtRa7CTroNyu4=;
        b=UqJA9841YGmp3b1DmzBZMKxbCOn7lw/Alv6kqdBDhCNgl8crteibLLII7hHyFAi8A5
         DdUUzBHTweeCYOA4JuFYJQnPeryjc6IGSxnUpg3Z7QlwDyGrCxatDcsE2CCV7XJevMGD
         k7iAgIIpPwS+JvAd/0FuNvCz3RWY2UO3Lfs+9hVxyiARutTwtLFTVO/nSgmQcniv1QbA
         HYhzZZkrxwbKWYSu5aw86NZ/pgIkmwXE9yUa0ceMsqlw5DqVKJaxMe3fQMkVwttO1Llz
         lyN4ZrVvztoFH2DkZHYEZOr8Q7BJuR9hQK9te/geSMbUKR3DY3XkVjSj4ji7movJ/Cl3
         +mjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752743462; x=1753348262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HyhBoxrCNtsTMaq/ZkCXVp9e8dnMJwhtRa7CTroNyu4=;
        b=k1lu8HLm8bBK/cSsxuE7hn+/j2HFm+OBwmbfRIkdqF3jykkunau9uLdOi6I0VJbT83
         3UdQLJ7eREoNPPQwaP7Bb48zpt/wDeQGcQxZ6BaxtYpdh3iTsABrXGeUKYODhMUkRry/
         4wwXYkDbJLamwTm+I7ajeLStwK1/6eipmfRAnwBE2kdqeqAwcJ9YOQvhSyZZ7hWRTbj4
         Xvq27vZEtOOJ/GvXxlbEg4w/+g1u1tMiirFCVolaBRkgR6O7+alStiYMnvioSwVsNv38
         nEiXRhNxnh4k3F0Z/qkTd7FdE8nno8920aWQh3Dbsvw/2TXGgQ04HNGKBSNBNqihJQ7j
         bPiA==
X-Forwarded-Encrypted: i=1; AJvYcCVcOybzbWSOXgrX6lTS0APEGgI4t7yHxZf1ggN8bWJfYxJpr0vvXauyp3FV/fow81auuJzGu0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd/pIM2I9Xp7JcrGAGfBHcuSFNpIaW2hIeynK+SHATMi4FlWbP
	D+RPU/j5SKV6Uw6FGb2jxUpJevOjwE1khiy7vpmdXhCblHH1OM52HMxk/Nr71HK/e0k=
X-Gm-Gg: ASbGnctA07BODjfNo0j0ad4MLqA95jpjodObtiahivgRkTEv5mn2YsFcCu4Juk46wrO
	LtgwMTpLTF9qRpBfbJXLVr20lDbSySivqJQ1IHB8+PBNxgJjn/RmXmnxguDgeEVH+Rg7tlbUAcn
	GoURajg+XCnH/vdSN0RpELOUr/EpNT2sLKotElogbXry4qOm2ZBJbNfpnbKHs74g7Dg0kqhzGCR
	YnqUenNmNdaPoQJdNuwCEQCbjYXu7IjcIWvOkUvtIYIkZ9AjwqaGyCBaCi3GNsVv4zD2HI1hWrp
	JMwoBip2xgt106CerOAegVzYamdkGxRW+oPN34FRUVoR+s8kVxW5cCi/gO8RPZyxGh90ir2Lxo0
	039RxqbrCPDI8lwuBrM8FbRi6RFGBwA0O
X-Google-Smtp-Source: AGHT+IHrFGe3+kv5nwJd+XNeEujKS3DRWXLY9Byhf8ifVc9w27qoxH+x6Sv5cjsnKuMJ4OhTyD8jIg==
X-Received: by 2002:a05:6000:2103:b0:3a3:584b:f5d7 with SMTP id ffacd0b85a97d-3b60dd52d9cmr1905603f8f.5.1752743462195;
        Thu, 17 Jul 2025 02:11:02 -0700 (PDT)
Received: from kuoka.. ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e8cfsm19737019f8f.80.2025.07.17.02.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 02:11:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	stable@vger.kernel.org
Subject: [PATCH] vfio: cdx: Fix missing GENERIC_MSI_IRQ on compile test
Date: Thu, 17 Jul 2025 11:10:54 +0200
Message-ID: <20250717091053.129175-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1461; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=/8oQPYYz6cHSNYNwym9xwEu6RpZClPerPGm665iJk6s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoeL4d8/4TGosHV8mie+xfGtqZiciWrgzgpC30w
 na+ERnoJQaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHi+HQAKCRDBN2bmhouD
 1/zjD/0cJyPefGWza0F69QVCLfsnnCijvT/geB45kgr+TLK3lnT9lyLubK2hUCjwlKCFtiH8tz8
 wNeof8YKDcnPrBqyG4EGIOmfMhI+ijZ61jNFiTu4+gj7tVZ0dHqYx8MFtRjyDnjrTpdx0mBx0lg
 rSyaosVWs629AWEV9j2AapeB9gtgNQJnfhCyyoigze5uc1x6qAz2FPuShy5yfnJYTaglvbToCsM
 ncptmAomgrda477zTKNEmlvgdNnxNi86vmEZR0Vf6LWJHwj6gi/3vJKtj15M1OB4KCcT93QDlF9
 SmXfiLUozswlyVsrUicJV3l8OI2LKFviq1Lj2h/PdbTTLmFVUVtmYAYBhYqUDtnL+5h7XFGXFar
 0J0x0ZyYrViyo8XnNUc9vG3bN1xTGKNXMmPcZdw0RIfTNnclNmxbtoIOWUl9FfhCTmjatxxQAjk
 0aLfWgBslzg0FDl8tux9KXwJ5Vn+gjN3NwFa/U4lQ8BzYP+pkOTmKJJCs1naLhXCsfvPXPjz4bm
 lNvQEACOEtxjPDhc/2F1kdjetaBbmRtWhCf0iBR2K1pIFYSmrj20/jkSq5cuBpd4PDwRawqjNfA
 AWHelP78g1MBkw48ndHMh93lNulCY8IB8SHMxoQ7meVMeykTZmhNixthKHVcJEnjnYkdP5/AhRg wo8dIEv8fqBUaqQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

VFIO_CDX driver uses msi_domain_alloc_irqs() which is provided by
non-user-visible GENERIC_MSI_IRQ, thus it should select that option
directly.

VFIO_CDX depends on CDX_BUS, which also will select GENERIC_MSI_IRQ
(separate fix), nevertheless driver should poll what is being used there
instead of relying on bus Kconfig.

Without the fix on CDX_BUS compile test fails:

  drivers/vfio/cdx/intr.c: In function ‘vfio_cdx_msi_enable’:
  drivers/vfio/cdx/intr.c:41:15: error: implicit declaration of function ‘msi_domain_alloc_irqs’;
    did you mean ‘irq_domain_alloc_irqs’? [-Wimplicit-function-declaration]

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/r/4a6fd102-f8e0-42f3-b789-6e3340897032@infradead.org/
Fixes: 848e447e000c ("vfio/cdx: add interrupt support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/vfio/cdx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vfio/cdx/Kconfig b/drivers/vfio/cdx/Kconfig
index e6de0a0caa32..90cf3dee5dba 100644
--- a/drivers/vfio/cdx/Kconfig
+++ b/drivers/vfio/cdx/Kconfig
@@ -9,6 +9,7 @@ config VFIO_CDX
 	tristate "VFIO support for CDX bus devices"
 	depends on CDX_BUS
 	select EVENTFD
+	select GENERIC_MSI_IRQ
 	help
 	  Driver to enable VFIO support for the devices on CDX bus.
 	  This is required to make use of CDX devices present in
-- 
2.48.1


