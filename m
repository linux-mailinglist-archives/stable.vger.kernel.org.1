Return-Path: <stable+bounces-171325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AD7B2A945
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1CF5A5C9A
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4188322741;
	Mon, 18 Aug 2025 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="YI4NU2YS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9AC234984
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525548; cv=none; b=ZMwxP/kC5KFFRJeRuUIhah+QuqFPpg5c+NbdsSx8QPk1mYbBtBE1stu8MpMHZ16Uah8iu89wRRUbloCiPK096hOSYKEeSdoL1Ladl7GsVYzGhQXhhJJEDQJfyHbUTp5ND8VGAlwuWmsMApe/1ORFlsMrDYYxpDVESVzbR7u+XsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525548; c=relaxed/simple;
	bh=xAgDy4w9sytHsyrtlILdVViVpigOZTX4LaJA2VtdpkE=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=TtLdyM9ykyuWbt9AOD4Hakwyx3dPXpF5EGHw50ZZ+6abBm4xAwhwireGjcM07K33ia8FxtDL4zcCyp5I0X5tmez9ZSwOyYktwInp1PvTDs/sLKU2aCM4gXOo7WVeoDbchtCk16WHBTgrrn9pZSr5S4AUTFbJqt7wpdWapDFUhwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=YI4NU2YS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2eb3726cso2501751b3a.3
        for <stable@vger.kernel.org>; Mon, 18 Aug 2025 06:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1755525546; x=1756130346; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEhe+AKwp9lnCOs0kJ/vCk40Y033WJ32Thetd0TH8P8=;
        b=YI4NU2YSiFvL3htiwsi4DtqN2Lx89f/oDY7kj/7QEanv6K2PEzcgLVNVy8EE6I1Nx9
         2kLyk0ixfgO7jx+kKfOx1CgWQMKcN0Ro4o09jNfy9CpAWO4hjfBa2nVTx3JMZ//F/9yc
         3IYAA8XrRwDEtbsSfx2erCZsz4SzVGEsTFvPlSJvXNWBA9gR+Tzes6ruW4yIhsKgHNn8
         jtHpB7RuVhydBM8jPquX/wr64KSfz2lBkaJCWA++ROXMZQnt6bvd50EK5n1l/SPiHobg
         BpUWVK4y2jEFHOPz//0LhR0KSZ40vbXF4av/QJz9owhQLEFInhq0GicFy1Qld2VeoHNA
         DIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755525546; x=1756130346;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sEhe+AKwp9lnCOs0kJ/vCk40Y033WJ32Thetd0TH8P8=;
        b=vF6teuuvfHXAgpg1/kuanjhUnT3xRQiPdOQGc6HssQkXJJjP2JdNPM/ydP6+KXCENq
         8FYp62/4fG6a5EVj7qvTJhbmqpNhqFROeC5XO9Ci2GV72pcT0WVIC01qxsAev5J95FuY
         AfvwnY2E3CjSNuh+tfFNDx1iU1nwh/D04e0Oqdb/FyO1zeEe38oygDARZZgQTp1/Xo1s
         /Ub5CA19Ln7UCHRubem3TSVBDlEvn4rGkNmF8+kGcKeeWVwnuqj6Qht3t/c9JntzQyEh
         a8DatmstYVGFMibgnuszBDfN+paNjDRSH48a6lDN6dvEzWKxKkW34fn6s38Nw4cxOufO
         fJzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTaWnMB0rWnf1RfRTOLZd47RSywBMzsDJnvyFUMcdtQPKy+k2POfB94gZn/WDbmDDApR+0TpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVG/AQIOi2ayqWj1Xd5PBI3o183NE4GAQwepymvtrv/zD3G/zJ
	kFNSzJNTzpSkZfUkoqem6ZePuKRo7CW8NnyQJHZzSzBVuXBF5ioSJpTrw4r0jzR7QSxvOWpAjv9
	mnJGq
X-Gm-Gg: ASbGncuJJL6gWw4A3jqN7pBJXbZgTRPInRizD885nsciMTtf54+h3ZGCz9MK+AARl9S
	Wj42OIqPurHMZXvX4xeDoJ/JpKDLJBXA7Ri/VDqDHReqYlCr9JmxQwsrzVntVKtGZG0jM/ZlY6O
	pyQBQR47+ygtRWMHYg41Fhp4F5UMyzl8vfrWaLDjUUEdVIFxgvmHmU7akmxuzg/4wAg2hvPp3jG
	BYlsq9zzuxZZbDXC7UHRwQN5J/da8yz4OLkog5uLQWH7hvDLJq91i2CQU9hdO/pmldFnq2oSpbk
	oe7psZl8FkCCGE4J8CyRl8PteirerVfSV8NN2FZHxrQyJPDtw/BwVfQMCe13xocGZrAFxS2nmgD
	wLcsYcfwb1Z/ZiO7mxJa34Q1iffLsOYuhzyZv4A==
X-Google-Smtp-Source: AGHT+IFhIAoB3CW/uISilmsdOBuGkHGGk4LuCmYAcmrctaBwPClAsK0DPzkk2cKg0rQwpnDtTjM/bg==
X-Received: by 2002:a05:6a21:6d99:b0:243:78a:826a with SMTP id adf61e73a8af0-243078af87dmr437769637.48.1755525546171;
        Mon, 18 Aug 2025 06:59:06 -0700 (PDT)
Received: from 16ad3c994827 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d73a736sm8172004a12.29.2025.08.18.06.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 06:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.4.y: (build) use of undeclared
 identifier
 'CPUFREQ_NEED_UPDATE_LIMITS' in drive...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 18 Aug 2025 13:59:05 -0000
Message-ID: <175552554489.51.12007704339434697451@16ad3c994827>





Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 use of undeclared identifier 'CPUFREQ_NEED_UPDATE_LIMITS' in drivers/cpufreq/cppc_cpufreq.o (drivers/cpufreq/cppc_cpufreq.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:b9c80192e71f04dd69fa1038881cb02b2c46b045
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  a6319f2fe27b8fefe40757d3797cfca30d43ce3c



Log excerpt:
=====================================================
drivers/cpufreq/cppc_cpufreq.c:410:33: error: use of undeclared identifier 'CPUFREQ_NEED_UPDATE_LIMITS'
  410 |         .flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
      |                                        ^
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:68a324ee233e484a3f9e9e07


#kernelci issue maestro:b9c80192e71f04dd69fa1038881cb02b2c46b045

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

