Return-Path: <stable+bounces-133329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC61A92525
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877B21B61927
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6DC2586FB;
	Thu, 17 Apr 2025 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Kvn0xRFz"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41C32586CF
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912749; cv=none; b=ITP5et7T5bpZ9y1GD8bgzbCDRZ9VnfZrP4nkYgFbYHgo92A7+/yIizEYkM94vkQdl7SRMxElHN4fiG5Mi587kh6QU+eVdiEWaXvwppW83/5Lqk+MvrRSdjU/aqOIk2s9YJ63bKcQMuIKNl3mNu7aXqRSayA2OeNeHTUEBvDODGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912749; c=relaxed/simple;
	bh=EOwjIb2GQ2gE1QfbAJHYbDP9km7kOtk90HgWXmx6RmA=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=aoOvbhOtoJMIq1H3oRbTxuaFsrY9w452/u6ErNOdy2QtQqTCstHxAGkdOt1yG4dhrqjXzR6NfVfLpGSFKlq3dSbtm1XvrmYnx4IulPGdR76VcWXj7rfZ7K8Qx3tqTPO/4BmRiTGD3N1JjhBOrfx3XhwGyPQ4sl1qhzBtUGnFXlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Kvn0xRFz; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70575d66612so9494577b3.1
        for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1744912747; x=1745517547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqpoNFetZ+gL1ifJ/VwgTVqN/ertx42XkVpoZ7flkLA=;
        b=Kvn0xRFzTZ/Da0LvZwXCoFNTwYaaRA7RB0QwrLDZr4NCDrc91me/Y08ZF2RVncTZ3+
         ioSGDXy38AgGtmifrO+B+NOmnDs26dp+XjZNck4xbgKUjgTxsP1NYxeKH0eGCr6cjqo+
         Vc2YG6eIttT6D7v18/st38gb4KGc9anRAGCeWmMml43J6o1AfeyXsWWx066n6T3RzlVQ
         0U9Uy4KE+PK68uKH1SCWZtRnlpWnSs5Um2pIY8Mi5a9AXUVGi25r842kmqRheDzaMRfJ
         vsafWKp+Vfvr/GXu7Mb2fBoNxo+u5Nm44sob0XSDE1t9cBPzI8rC32BlFOIh0u6UonzY
         EteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744912747; x=1745517547;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqpoNFetZ+gL1ifJ/VwgTVqN/ertx42XkVpoZ7flkLA=;
        b=fTAbSRpHtCV43X8R4dAteY0KtiK+49GBR0f7rpLlBo3T1L+smy7sjLZS1ICTm/VkGb
         koT42J+nvohvMaX1BsuEsmSY8z4qTWa9dU5IHs4u1mvwqCKRS4sEIxeY5iYBygk2oycw
         shYxUFOxNw7wLMoBsOGYAbstV/KExYCRHIG3hwq2VawjvzhhI3tvx9R03Km1DrX12xXh
         5uHYjZGQSqGUQYoF6haTijdCPfd5OPOUuHLglZ8tuD1FLt+ZpjrCWPX9KmM+vrGJiyNU
         0c38VTumTeEJ5hLOqNpvqGBAQsT5aUAqgDKKVgRQrCL4b3gnMGwsCeprGLLKyOMyPcef
         8t8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXD5o3iD+jTQdybqCfKVI1Nxcq3d1ZpWZRz/tNfeyHZ2E3K0oRj+9PvY+nb43bXL9Nq5Clrae0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJmZHNVhlK+Bi4XlwRUpLBcvc204DRCfbOUgs9skX/vDQAipr2
	p89Jsa8QCWPr57K3wcSrhddLZf63iXQfAnq5f2h0HL9o4nYWUe+LxR2BgUCQDb7nSAA6wVsklP7
	Rl7IrV9yHrV9HQTkgsA7f8T7dCaDwnPT1vnqdY3goaaee/o2IeYU=
X-Gm-Gg: ASbGnctkxmluDnpu4QGGU9fWspERSCix71ne4n5WLNVDD1i6umqDWKdBaDeUaz/IVjb
	wUoZTHImpTkHqfLn99Pjo+vlBZ8nmVXL7kN7fR8nAl5AxoKdkLnjwgiEhQ/nk2DLcz5+WVrZcw5
	sSxzG1ZIlifgyFCwYWWTIRtBsIlA7pNl0=
X-Google-Smtp-Source: AGHT+IFQsqhbTpv2KgPaBd5pw1N/MuA32FfDVhJX/8OAEE/hYDMThOxM2lku4ggNjII6Da7D2Z3l9WvrTjM83baE7mU=
X-Received: by 2002:a05:690c:610f:b0:702:2b4c:ade4 with SMTP id
 00721157ae682-706b32764f1mr102493077b3.12.1744912746714; Thu, 17 Apr 2025
 10:59:06 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Apr 2025 10:59:04 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Apr 2025 10:59:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Thu, 17 Apr 2025 10:59:04 -0700
X-Gm-Features: ATxdqUG2vx-UvPjTl7S_GlPIfDW7jgdC1qL85rSX5qlM_kDijMbP4RRGRNYuEwg
Message-ID: <CACo-S-2X6V8xNL4B8jqjiQc0X03c_1CO-a5eRTYRc8jJumjrfA@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build) call to undeclared
 function 'devm_of_qcom_ice_get'; ISO C99 and la...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.6.y:

---
 call to undeclared function 'devm_of_qcom_ice_get'; ISO C99 and later
do not support implicit function declarations
[-Wimplicit-function-declaration] in drivers/ufs/host/ufs-qcom.o
(drivers/ufs/host/ufs-qcom.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:6e8cbc216a099c6d659b1d487f03ec4f27a2b8b6
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  902938c3eee30b17690f206091c78c5f7608218c


Log excerpt:
=====================================================
drivers/ufs/host/ufs-qcom.c:124:8: error: call to undeclared function
'devm_of_qcom_ice_get'; ISO C99 and later do not support implicit
function declarations [-Wimplicit-function-declaration]
  124 |         ice = devm_of_qcom_ice_get(dev);
      |               ^
drivers/ufs/host/ufs-qcom.c:124:8: note: did you mean 'of_qcom_ice_get'?
./include/soc/qcom/ice.h:36:18: note: 'of_qcom_ice_get' declared here
   36 | struct qcom_ice *of_qcom_ice_get(struct device *dev);
      |                  ^
drivers/ufs/host/ufs-qcom.c:124:6: error: incompatible integer to
pointer conversion assigning to 'struct qcom_ice *' from 'int'
[-Wint-conversion]
  124 |         ice = devm_of_qcom_ice_get(dev);
      |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
2 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:68011d7869241b2ece0f8252


#kernelci issue maestro:6e8cbc216a099c6d659b1d487f03ec4f27a2b8b6

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

