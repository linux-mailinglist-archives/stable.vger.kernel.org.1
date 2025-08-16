Return-Path: <stable+bounces-169840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7F9B28A12
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 04:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BC9569304
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 02:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F0E1E49F;
	Sat, 16 Aug 2025 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="0trSqtHH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346086FC5
	for <stable@vger.kernel.org>; Sat, 16 Aug 2025 02:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755311449; cv=none; b=qS7Ew2iu4oBk8OEj48TQKhBaXr8Vk/0nN8aTUEJYE9Wddsp2tkcHi4NDAc5XiOvq6W2F4dRElmYxf6+WhlA1EjXL8UwbAlm8ldJXoJ+iKc5xShTU8j1M91w1bnrMQLHdBmk6GUWyIMPd6u08MEamCShcKSrlRfQqqCnxWa+dfJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755311449; c=relaxed/simple;
	bh=ObprRbvfTDXdKxhaD/e6ybAc9N2ZsvxGsCqrt3OPi9Q=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=WZk+mob6B885RV8nUM8F93ygKvG6EIxQ5hrq3J/TCR8G8U2vConIw3GqfMGFKNVcz/s6C9wa5RWBycwR+eX2bOCLbEZh8jCj3QY8okOliVzrdmn2JUrlu1wCSSGuHc7ukkj+QqlLW8ejUTxJnrPrJS50GZ4agqy4Rl7GH2uZsiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=0trSqtHH; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b471740e488so2429904a12.1
        for <stable@vger.kernel.org>; Fri, 15 Aug 2025 19:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1755311447; x=1755916247; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pxx+9IgLdAmlD8zRCbZkKyU/mF3DcTXIOka+al/EKU0=;
        b=0trSqtHHpkN8hZB4/wy+l2eutqOrfWdO4FrLkzyYr7Mb6UBM44Cj+NjcFvhvIeXQo6
         4raPJ9RycuZl0WIpW4y1zme9yxaIQZqd0kqdFSq5/gYX75yAU5T5YBeWhIFQLCc5Y2SI
         rlmpBr3rwFXx6M0suL9u1X9GgHOLfeNnsEBiXZxdwTanv+dxFjMXGd5h77khAfQjCuQA
         s2YA4/TVAqqYY8iy2bcEfIunFXLEarGSaKh5RO14X0hGOK+ixU1xMvijsZDx2MyNE6oQ
         VgKZ37KsrLA+q7nf9GWRjZ4XpbrY/AwJ35GC+d6q2GWDQxWQwmhedcfvJuAlX2pM3Zuh
         KaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755311447; x=1755916247;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pxx+9IgLdAmlD8zRCbZkKyU/mF3DcTXIOka+al/EKU0=;
        b=qn12NZN76WRjqYIA5m8PNBV5rCV2j5ejOLwQe7U7CiUas1dA/4wtVp2S6PK2CR8xb/
         uREKTP+nucJZ4EnQli+IE3XtQJ+0hJSfhK93oGL3nW0YLH27JSEl9XddBHHTv3NqiOY1
         N/HI/HlOzC/T00X4P0psxIa03OcSooMQOfvcYRd/lR046O8BPsgdGq/Z++8lWzqNsyGb
         Sp/SPzhmZenpKQudtVw2OtSuxllSGUw0JJdrfdQkMdwF9nH9Qt2eOIhce53q62t33lIv
         rP1nGMQ+CFwEVWTQK7VY50y5Ddjw20FhP+L2H9FPrYgjQubjNPOp7OS90zToroUHHpX8
         Sgdw==
X-Forwarded-Encrypted: i=1; AJvYcCVToRla81b75M694wcNdFqrdyd2hmR52GBFMMX8zRKiJQ/EAygVwJsZjbeuELiPLlRRMq/WZ40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE/m32JquFDQQXV1eVs8fPJP/3Xo3+MhkO2GsNoFociumWY6i/
	dTI7uXE0UDdI6N8duBB5EOfrRwYV5H02el8UlHK7PYBh+GKLiIZil9HBrKxBCUPhD6k=
X-Gm-Gg: ASbGncuuRs8BFfodCybcyq4pC6LwDqCk72EAd4mXYJmVzXY2WyccodaXtTWvSVYb92c
	hMH15WG7qtYDvamfeFFXHgeDO/H2asF27WqLhz2c2C/b3InpiPvNGqHlayZnnjwafqDLKk8wQpd
	AG6SIefO92MK8DWYLY8lgzDoU/H2POS65+PzZli4iS9kaiXUZL2/ogL3XOps4xU3IfjQJTKA6JT
	lbsZg8Wcola9aeVoNFrGMifaF1ZyODM6MpbwMYrOc/7YQGa7Nt/oJhVgciAA61AwtGeJQEY+o3X
	HLBjNYWVvogXWArBe475s5mQEDr+c1EpaZhFZaZ1L4QNJhjY/fV4meg6jKEZvtgl+Bv09GCkf8R
	wf/95hBWJpKMnEXtExg96dPRLN4FSLpFi65QyHQ==
X-Google-Smtp-Source: AGHT+IFW+jqRCYeQWIVsBk/IZcHTyKfzSLVY9Qp4Bqq/r2mamXFp7Deekqj8AKpotllbPCvZ5ZgKBQ==
X-Received: by 2002:a17:903:2291:b0:240:6d9b:59ff with SMTP id d9443c01a7336-2446d8f45e2mr66823105ad.33.1755311447512;
        Fri, 15 Aug 2025 19:30:47 -0700 (PDT)
Received: from 16ad3c994827 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9ef54sm25027685ad.26.2025.08.15.19.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 19:30:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.6.y -
 bb9c90ab9c5a1a933a0dfd302a3fde73642b2b06
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 16 Aug 2025 02:30:46 -0000
Message-ID: <175531144631.276.17876917358612286646@16ad3c994827>





Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/bb9c90ab9c5a1a933a0dfd302a3fde73642b2b06/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: bb9c90ab9c5a1a933a0dfd302a3fde73642b2b06
origin: maestro
test start time: 2025-08-15 10:52:19.705000+00:00

Builds:	   45 ✅    0 ❌    0 ⚠️
Boots: 	   60 ✅    0 ❌   42 ⚠️
Tests: 	 3948 ✅  607 ❌ 1617 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: bcm2711-rpi-4-b
- boot (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:689f184b233e484a3f986be3
  history:  > ✅  > ✅  > ⚠️  
            
Hardware: dell-latitude-3445-7520c-skyrim
- boot (cros://chromeos-6.6/x86_64/chromeos-amd-stoneyridge.flavour.config+lab-setup+x86-board+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y)
  last run: https://d.kernelci.org/test/maestro:689f24dd233e484a3f98e2c2
  history:  > ⚠️  > ⚠️  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

