Return-Path: <stable+bounces-179276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1EAB53636
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 16:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB86188C668
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 14:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148F131E11F;
	Thu, 11 Sep 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ea6KHcxp"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E591E1DE9
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602119; cv=none; b=hI70zU9SYHVk6gW5fecVcoklynjgqe7Rzv7At8H4ui4QGwAZgUtN3NxRZetCFk5nXXry0ZKcZSnJcGcVmbSmg+uCklqvrk03IpyWnrMQGLfv6dVVMYiNuyXiBe0ibgiORbNoLeWIXYjfkay6XeNgZuLj0j1Uo94PaN9Mz5Tipms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602119; c=relaxed/simple;
	bh=4AxZOzPYQRg37ToRKQvaG5KcDRZSTy0OrAfqI6weJKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SeLXDJmf/cP3X635+h2IhKK2WpZtHYBZpJppV7Ba/vLz1coWTp5HtOOA2JY4ZKbhGKgJkn7pzA555ubgj4MWKMTgnKZDhRwe89fqXVRNUumWM9kdjWSrr7C3XiQFBoUdt5gfREagJtRkONVgSPzPkKul9RJ3F/fTapNFi0QtXDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ea6KHcxp; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5608bfae95eso900189e87.1
        for <stable@vger.kernel.org>; Thu, 11 Sep 2025 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757602116; x=1758206916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MIfjxfI8fjF/JltWwvv161P4lPdGyzyNYzNbvTF3UwM=;
        b=Ea6KHcxpHrFAgCFgvzV/nJ9CgyDXmNGmfHiXTFzOkY2kcMiilL//Ako7ePhccAeJgH
         wbWaLuOofPWduuAjtXzZmEOxpvdwsQYPR29W+8DT1SW8r5G9LIBT81/9V/E28uymeYsc
         2N3K5ScGULucve3VSTc3Oc+9kRh3FniVjWUS4sC+gDjXzzNTlOG6kICFOG7BJes1GY3/
         gzW616iI2qvsykPIUVghYFtuet33vM0xkHzD4xfex8Z78JZUf7gD1jwtPH/lVgtlCaPg
         3mFTVCHppuF/Dhxbks62PPUQme1NefGDlpGmolldwPE6dq3HD2vjA2JVJ7xbrrAYKYrQ
         3Aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757602116; x=1758206916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIfjxfI8fjF/JltWwvv161P4lPdGyzyNYzNbvTF3UwM=;
        b=B+o9u2SrPuOxgLFx/4TIBzjRyYgboDoQDR3MarTJsGDJvQeUXGOR/Fd0ygAYf/Q/SM
         WirZ26Or+ZKxNptsiHjXOQZ9mrDB7BflfZT4UXfH5J3dbuPis4B3Ik53xQeinyuIsHsn
         HpTf8Mm0mGmJNPgV2Lpye0GnugBOwu9zOz6LN9KUiz6CpYv5fMvV/hbA6FvJ1R4eqycg
         Xre3wVSOG+9AFzkmFP2P1mCkRzVH5osb6R4fHTbLxSATQf7bNAZqteOpQJn/f5Gdh+JX
         Qt090HMp+XzGFoXZ+wqyR+Xt8cFybePyjDsFQhakyZpXjzEJKKUtEi6MF+rATnEjUsX8
         wmXg==
X-Forwarded-Encrypted: i=1; AJvYcCWAwpTuFWSm7hHVNK9MNvaP5+4Pp4MBZlOZ/KdxTbTELhTzZCOVP9LOcO3Al8Oa3wWaMCmNtvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrDzK1EP29Dni8SPakFyfglao2j07gft6+Pc80R4e025RrHdHx
	dW0qQpdY3v3Qkcm2W19uWdG36ASBr4Jgs5McpIcTXgHWy+icM/a1Z/OD9/toxp7Gh0Xf6qSdU7O
	e2aAq0BgSvg==
X-Gm-Gg: ASbGnctlP0iF2/HpB4gytQ8kTRPtqGR3X9nOj1cs817LRfIh+A9t+dhuK75G0+ymtFK
	GZZ0wuBe0CsC2g7fg92/xL3fYcE4F7PoEGPND3IaR1WbvY07YNJ+X83B1icnRZKdDCq9+fXzKc9
	vGbfbg8b3bc0RDK/TEXu4bl2fkTA5ECTibXoWLvlERyk3LYqsahw42ndrViuvqZkSF3vL4bwNVW
	iw/61kGhPO/d2WfAWevuG9tM6y86jaA3PjOccdOVLe4WTxpe3S1AknaKc6gI2uyUYfyuoyGGxbV
	GfHGBEqLt1Cs43joSH/QuJSHzwMZ1XWwGy8SOszn3WwzXUXWdwPAw7CTtSK3l97yVk3N9zsfn0w
	SzfXizDS8r4tLlGW+CpIjwpsDxfxPPNCPbFND4zAWGjdLXfVrLGUmfyaAkdmv1mCrsg==
X-Google-Smtp-Source: AGHT+IHy6/1NqtnV9by+dmtQKMm6p40le7KhEDevJduhHCh2PDA/H9OMZ7vx2vMMLyLbvjYYlENfWg==
X-Received: by 2002:a05:6512:63c5:20b0:563:3ac3:1ec1 with SMTP id 2adb3069b0e04-5633ac31f71mr5579784e87.54.1757602116035;
        Thu, 11 Sep 2025 07:48:36 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b6116sm473294e87.24.2025.09.11.07.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 07:48:35 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: krzysztof.kozlowski@linaro.org,
	arnd@arndb.de,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	stable@vger.kernel.org,
	Jon Mason <jon.mason@arm.com>,
	Ross Burton <ross.burton@arm.com>,
	bruce.ashfield@gmail.com
Subject: [PATCH] arm64 defconfig: remove CONFIG_SCHED_DEBUG reference
Date: Thu, 11 Sep 2025 17:47:14 +0300
Message-ID: <20250911144714.2774539-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It has been completely removed since v6.14-rc6 by

commit dd5bdaf2b72da81d57f4f99e518af80002b6562e
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Mon Mar 17 11:42:54 2025 +0100
Commit:     Ingo Molnar <mingo@kernel.org>
CommitDate: Wed Mar 19 22:20:53 2025 +0100

    sched/debug: Make CONFIG_SCHED_DEBUG functionality unconditional

Fixes yocto meta-arm sbsa-ref kernel config warning which
uses kernel.org arm64 defconfig:

DEBUG: Executing python function do_kernel_configcheck
WARNING: [kernel config]: This BSP contains fragments with warnings:

[INFO]: the following symbols were not found in the active
configuration:
     - CONFIG_SCHED_DEBUG

DEBUG: Python function do_kernel_configcheck finished

Fixes: dd5bdaf2b72d ("sched/debug: Make CONFIG_SCHED_DEBUG functionality unconditional")
Cc: <stable@vger.kernel.org>
Cc: Jon Mason <jon.mason@arm.com>
Cc: Ross Burton <ross.burton@arm.com>
Cc: bruce.ashfield@gmail.com
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 58f87d09366cd..4126281665bf2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1798,7 +1798,6 @@ CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_INFO_REDUCED=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
-# CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
 CONFIG_CORESIGHT=m
-- 
2.34.1


