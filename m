Return-Path: <stable+bounces-89129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F6C9B3DCA
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 23:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70F85B22130
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 22:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806B11EE021;
	Mon, 28 Oct 2024 22:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUyxPayQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2247D1D6DA9;
	Mon, 28 Oct 2024 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730154877; cv=none; b=b2JK3IOhtyqLr0kM+buVcjVMau7LilxOrZX2Y1OQh6EFVuSsxqdrchs5zgWCEgdblppsLmKeuHGcx0y8i6CVSg1Ij5g5mYPn0MxVr4643Gr1TW+BHLDE8wzm0dYktvgDeTaE7J6abtPe7++qXo0yha/5wXVgGX6ZtoymAX24iK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730154877; c=relaxed/simple;
	bh=NS6IGLdfQ4yhfa/h3qM/ZC4AMFpa5EbB0lv5pgr/TGE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sOnt/AaqEhz7Vey/sSUHceEvDZPmr+8gYqXeW5/b7oaeKb6sgt1F2iL/9/dCOTqW0mVF7bPg98VwdcaiTMQ97PdyGpu16/a9Y2Fm0L3VGg5YgFYxWeq77Bf46mmoRXa4HcLPVOa+isiyV2t9BffOOXrVY9M9zTnGrS5oDmGf/JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUyxPayQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso47059115e9.1;
        Mon, 28 Oct 2024 15:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730154873; x=1730759673; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pdlBwck4NxNHB4pJHNKMUo69aUJHsObvwbILTbB7MwQ=;
        b=HUyxPayQTpMNk0JyV6UdObc7IcquQMJXKkql6OUZ2Cm+DqKN0Vcfrjru30fWIBjUF8
         sgWUfklzq+qPozBGVycU0lreWUU13AJ/tgwyhKNU+uy6vebjdKeILD+qZzpqDe0Z8FhX
         ZCoNk5GkdOt75/ToCPk+ypPwFoohKpJC9jjbJ3qp81RjMW+6ZeW1Sz7tVgJiLdjcZC4/
         qQ0j/FmPY1pFbuTtPw0oRypgs6QA9tHYQbyQ7k7/Y5vWZf80Ri4R4WFdLzZT9HQhhTLP
         cO1kysTWI7YL5igLyunuqZh502cqqW56InY5TVio5JUq6+/AGhLuU+jj3vEWIyhv7afD
         z3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730154873; x=1730759673;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdlBwck4NxNHB4pJHNKMUo69aUJHsObvwbILTbB7MwQ=;
        b=McEDehau8NMulhl/KybAS+cpEPV5iB/f1wC1D/i76lWxgGU5ZIrX/0X+XUDHMX9aUO
         irAyc0rfYaGYdF9Ikoj3Pse+9jix7H1cXxAE/I/anjKCIT/OQyhqbhVtAalMob2SU3m0
         xxBzhNpQm6N2QY2Xiskpo8kPagvm7+N31gOUf6LA9/Jzn8p3pHmt4VVnDQTU94wqTSel
         QL3vJd/YkL+wRBEqPUj7vYW1UfC7S7SevC4NBHArUH1DorSCakSxbdklAyOOrLK1UNg4
         Ph6gPWCPc7P+S+FbXlyJq/I9aXyqHETBtZHUwlsKhG9ArBfIO6E8ApwcnzRAmi9nqifj
         uLLw==
X-Forwarded-Encrypted: i=1; AJvYcCUSN/ayrMGGcQA2FB6j6TUsRSVO9TU1WHbRgcrca1CKK6/+mZND0JAzEBtIOf2AghMCSy1hfafR@vger.kernel.org, AJvYcCXcREnSLtvuPSgC1js6KhRj3CH3sbQM/7hbfxXpi1LveT5LFkz8mICRFuEjvGTA/Xl+2D1FTJb3Qh/7itQ=@vger.kernel.org, AJvYcCXqu2o1Tz+Wl/P9u5hB7GzjVufFD8E3Te0K0Umy+fkNH2bW1e2vXFNGv1iA+h0fQQ5k2n1p+XK5gEk1KnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YybJZypmu8Hj/f3yOrp47T5PdYL4t1Tt39bkxxFAHEa5DpkSK5r
	Nm6AMQqlf/lvUNRWpb1+Ee5/TssdVGV4A/g0ufRcYu/daCnOPq2QGPm5gnjj
X-Google-Smtp-Source: AGHT+IFBiVXTrjD7ImDUCo/xWaGFnVYKS4h7WGj2F2MDCfqbPayAEVeJNVnFEvFnyih3B4YMtk5w7g==
X-Received: by 2002:a05:600c:5249:b0:431:6052:48c3 with SMTP id 5b1f17b1804b1-4319acacd6amr104870245e9.16.1730154872857;
        Mon, 28 Oct 2024 15:34:32 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b273-88b2-f83b-5936.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b273:88b2:f83b:5936])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f7213sm123899495e9.32.2024.10.28.15.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 15:34:32 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] phy: tegra: xusb: fix device(_node) release in
 tegra210_xusb_padctl_probe
Date: Mon, 28 Oct 2024 23:33:57 +0100
Message-Id: <20241028-phy-tegra-xusb-tegra210-put_device-v1-0-28f74368c9ba@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFURIGcC/yWNQQ5AMBAAvyJ7tklbDeIrIlJs2QtNixDp3zXcZ
 i4zDwTyTAGa7AFPJwfe1iQyz2BczDoT8pQclFBaClWjW27cafYGryMMPyop0B17P6XASGhtZag
 qtSgGDSnkPFm+vknbxfgCbCfWQnQAAAA=
To: JC Kuo <jckuo@nvidia.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-phy@lists.infradead.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730154870; l=1477;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=NS6IGLdfQ4yhfa/h3qM/ZC4AMFpa5EbB0lv5pgr/TGE=;
 b=BFOEYf0/XRn4Fi3Hhd0BIlIOkJuXsBUVt0jzg+51/ufPqypE/ActPCsKkORjVzpbblCVAMNv2
 i1eY0ZE4jD3BxAIBPbNzR1O1YTYlFOegmbh+JEke7fTeqDPwWtx879Y
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series fixes two similar issues in tegra_210_xusb_padctl_probe().

Two resources (device_node *np and the device within struct
platform_device *pdev) are acquired, but never released after they are
no longer needed. To avoid leaking such resources, calls to
of_node_put() and put_device() must be added.

In this case, the resources are not assigned anywhere in the probe
function, and they must be released in the error and success paths. If
I overlooked any assignment, please report it as an error.

I have tried to affect the existing code and execution paths as less as
possible by releasing the device and device_node as soon as possible,
but if goto jumps to labels for the cleanup are desired, I can go for
that approach instead.

This series has been compiled successfully, but not tested on real
hardware as I don't have access to it. Any validation with the affected
hardware is always welcome.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      phy: tegra: xusb: fix device release in tegra210_xusb_padctl_probe
      phy: tegra: xusb: fix device node release in tegra210_xusb_padctl_probe

 drivers/phy/tegra/xusb-tegra210.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
---
base-commit: dec9255a128e19c5fcc3bdb18175d78094cc624d
change-id: 20241028-phy-tegra-xusb-tegra210-put_device-ff7ae76403b4

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


