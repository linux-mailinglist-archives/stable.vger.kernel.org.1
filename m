Return-Path: <stable+bounces-171936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B3BB2EB39
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 04:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B645E7193
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 02:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702DA2472B5;
	Thu, 21 Aug 2025 02:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Iyu0X0h5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5843E245033
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755743462; cv=none; b=nLf3OsRMvVI9v+zAE3De87BcFJgGBv2d3XVC4ffC3S3UqUlfFkUhXWU5cisgQhOPAPTngUMaKA41S13/EZaM5g74zB1CXXnAty5pH39GY61ORoCj5KBziKcrrZeb2GMH8Tj2YpTuq7vccam+P/mXEVW+aZFrb6nw7MMaW2bahvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755743462; c=relaxed/simple;
	bh=gP6su7F6OnrLKg9T7o03jljD5G7FSJMvrRo92KZ1T8w=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=OZKYlum1C75kl/2L8HC9f/DHRwRUclJXRTcaE/vOY4+ncs9+T55Du457T8tizN4ioSo4qf5bqub0URgDUqPnJC7goMEceK6uI9b/lZEDUyniae9ZX0lIHPaoNet7TGXds857yf9a0xbYA2XGtc3Ie9wDnEDVzwElzuS5btxJc4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Iyu0X0h5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24458242b33so5212695ad.3
        for <stable@vger.kernel.org>; Wed, 20 Aug 2025 19:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1755743459; x=1756348259; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yr9jUPJMjfuoWvM3cGpMaDOZLHSu040cmOTzCbTIpx8=;
        b=Iyu0X0h5zFLgIJ0ikyBcANlNmAXiGaRP/6Insz6rwlVd0gp0hnuw5tl+tQl67z27Bx
         ZO6nLDPcnqqJnES8aEgX50UajGJf3G6Jy/ABp4XjDAct6Txpkrynl9Nw+u/TsNXXdnBl
         tjxQm3ae4hbxPP1ksg7ACm8LrJHklVEoo5ZVdigJzjALgWLzv8G1iPyF0oBWjLFy2slb
         ZPuVC5RxWFB0WPtJajlavtPyJX3/4qxJWYYyaovd1COtW8k28J2umUNZkLVrqTrb8bnL
         hwAnZT46swXgymB62iXt3rVZBa7/MpW1Ci67xKRIDicUoAgfgD93VZ0H4FL96MrtKZtg
         Xd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755743459; x=1756348259;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yr9jUPJMjfuoWvM3cGpMaDOZLHSu040cmOTzCbTIpx8=;
        b=OsxWjeu5V1Uj6oA3+6daNlWjBqNcoOFhVA2KhTZu4yb0FwURo98xCe1jkEEdJHCA/i
         SiqWZnX/p3FU5XhFqZDjlDxHXGuiNqiAFB2fuqncajgUU/8ifQqzmnz3ImO7PAGzadhu
         YWG6nh+VbzT5w1mdmcP04U/ABcKPBi7EZkaauwfPA4J0Hwebr1strQ509aip7XnRAFMu
         sEpYYUSyKjzTP+LXXDDSmeffdZFPqJiu9B94PUKechNSCadTS9PT1hgvkozh9aTo/+Wi
         AOiD1t/t5tdF3aEux4/8+X+mGrvQdOF5OuQNOzCfSfLZt8DBmdQPcijvNmRWa2LF6xnU
         sNqA==
X-Forwarded-Encrypted: i=1; AJvYcCVZKxAV4tTXs4oJUGKI5g4XfixFoZMLpKVBAUANs0zXzud3XM/iGdB1ht8boJy/kMLTCeG4cQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPHafO0AQ77OdFJhb96hk0/gsCgn1GTZ4+GpeM57ueATDYfeUd
	okiAA4gJEmDXH25MQ7ue+l14WFhTdJNuExKuZ19ysQTE+jRB+hclUCws0xiOjh6IivI=
X-Gm-Gg: ASbGncvEKI6Saz3gcfot6APLkXzFOXjX+2J+qZvFvTSkRGmF3xchggpi7McXQCZ9kME
	f5wgZumrTPN88+lmCwGi/azAM1z10gpmZe+2Ei2kmNMjtJe5BZ3+fJ+nwY1xK6UaDP/DyL40ukQ
	m3LOknTBIh9E/qOdPMSlmYb8gvnzKXir4RrImWKcprHHZzE1vtSjqEsRDS5s8ri9XXDD6OYMlAS
	xG/1a5FXVOAwzwjsp4Ygo/1bzAPKPfDRQIuxodYKoI3kBWJJWNcGsYE8h8EO+6Df86PRwr3mt6L
	DZv8pfK70w2dQFP8vKK71kSsCRsZF4Zh4SUjIhMEst4tfWyo8ryTIEKG4x3GXDtg+s4aqrZAi4L
	gDKCjsHXJ5D+j5DlJ
X-Google-Smtp-Source: AGHT+IH199F81zf2g520B8s1BgHwtVJTJCMsXOmTFD7HNMolNg82DRm08N1cONgt5eN5DOnHn1zhiw==
X-Received: by 2002:a17:903:1103:b0:242:b315:ddaf with SMTP id d9443c01a7336-245febef2ffmr13027845ad.7.1755743459381;
        Wed, 20 Aug 2025 19:30:59 -0700 (PDT)
Received: from 16ad3c994827 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed35dd12sm39904985ad.51.2025.08.20.19.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 19:30:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 9becd7c25c61ae7e5b6fbfc3c226b1f23af7638c
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 21 Aug 2025 02:30:58 -0000
Message-ID: <175574345812.117.5147328299444701156@16ad3c994827>





Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/9becd7c25c61ae7e5b6fbfc3c226b1f23af7638c/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 9becd7c25c61ae7e5b6fbfc3c226b1f23af7638c
origin: maestro
test start time: 2025-08-20 17:11:31.947000+00:00

Builds:	   44 ✅    1 ❌    0 ⚠️
Boots: 	  155 ✅    0 ❌   47 ⚠️
Tests: 	 9449 ✅ 4714 ❌ 2785 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: imx6q-udoo
- kselftest.alsa.alsa_mixer-test_name_fslimx6qudooac9_22 (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a62a9b233e484a3fa3644a
  history:  > ✅  > ❌  
            
- kselftest.alsa.alsa_mixer-test_name_fslimx6qudooac9_9 (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a62a9b233e484a3fa363ef
  history:  > ✅  > ❌  
            
Hardware: sun50i-a64-pine64-plus
- kselftest.kvm.kvm_memslot_perf_test (defconfig+arm64-chromebook+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a6103e233e484a3fa3221d
  history:  > ✅  > ❌  
            
Hardware: sun50i-h5-libretech-all-h3-cc
- kselftest.uevent (defconfig+arm64-chromebook+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60df0233e484a3fa31411
  history:  > ✅  > ❌  
            
- kselftest.uevent.uevent_uevent_filtering (defconfig+arm64-chromebook+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60f02233e484a3fa31730
  history:  > ✅  > ❌  
            
- kselftest.uevent.uevent_uevent_filtering_global_uevent_filtering (defconfig+arm64-chromebook+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60f02233e484a3fa31731
  history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: imx6q-udoo
- kselftest.alsa.alsa_mixer-test_name_fslimx6qudooac9_10 (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a62a9b233e484a3fa363f6
  history:  > ❌  > ✅  
            
Hardware: imx8mp-evk
- kselftest.kvm.kvm_memslot_perf_test (defconfig+arm64-chromebook+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a649db233e484a3fa3d412
  history:  > ❌  > ✅  
            
Hardware: k3-am625-verdin-wifi-mallow
- kselftest.kvm.kvm_memslot_perf_test (defconfig+arm64-chromebook+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60fbb233e484a3fa319f0
  history:  > ❌  > ✅  
            


### UNSTABLE TESTS
    
Hardware: acer-cb317-1h-c3z6-dedede
- kernelci_wifi_basic (x86_64_defconfig+lab-setup+x86-board+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60ea1233e484a3fa3168c
  history:  > ⚠️  > ❌  > ⚠️  
            
- kselftest.iommu (x86_64_defconfig+lab-setup+x86-board+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60e92233e484a3fa3160d
  history:  > ❌  > ⚠️  
            
Hardware: acer-chromebox-cxi4-puff
- tast (cros://chromeos-6.6/x86_64/chromeos-intel-pineview.flavour.config+lab-setup+x86-board+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y)
  last run: https://d.kernelci.org/test/maestro:68a60d3b233e484a3fa31218
  history:  > ⚠️  > ⚠️  > ⚠️  > ⚠️  > ⚠️  
            
Hardware: acer-chromebox-cxi5-brask
- boot (x86_64_defconfig+lab-setup+x86-board+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60e6a233e484a3fa314bd
  history:  > ✅  > ⚠️  
            
Hardware: acer-cp514-2h-1160g7-volteer
- boot (defconfig+kcidebug+x86-board)
  last run: https://d.kernelci.org/test/maestro:68a61133233e484a3fa32a5a
  history:  > ⚠️  > ⚠️  
            
Hardware: acer-R721T-grunt
- kselftest.cpufreq.suspend (x86_64_defconfig+lab-setup+x86-board+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60e80233e484a3fa3156e
  history:  > ✅  > ✅  > ⚠️  
            
Hardware: at91sam9g20ek
- ltp (multi_v5_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a60958233e484a3fa306a5
  history:  > ⚠️  > ⚠️  
            
Hardware: bcm2711-rpi-4-b
- boot (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a61238233e484a3fa33008
  history:  > ✅  > ⚠️  > ✅  > ⚠️  > ⚠️  
            
- kselftest.acct (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a61239233e484a3fa33010
  history:  > ❌  > ⚠️  
            
- kselftest.alsa (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a61239233e484a3fa33013
  history:  > ❌  > ⚠️  
            
- kselftest.arm64 (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a6123d233e484a3fa33031
  history:  > ✅  > ⚠️  
            
- kselftest.breakpoints (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a61244233e484a3fa3305f
  history:  > ⚠️  > ⚠️  
            
- kselftest.device_error_logs (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a61248233e484a3fa33077
  history:  > ✅  > ⚠️  
            
- kselftest.dt (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a6125c233e484a3fa330ed
  history:  > ❌  > ❌  > ⚠️  > ❌  
            
- kselftest.timers (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a61262233e484a3fa3310e
  history:  > ❌  > ⚠️  
            
- kselftest.ftrace (defconfig+arm64-chromebook+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60de2233e484a3fa313b6
  history:  > ✅  > ⚠️  
            
- kselftest.kvm (defconfig+arm64-chromebook+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60de3233e484a3fa313c2
  history:  > ❌  > ⚠️  
            
- kselftest.landlock (defconfig+arm64-chromebook+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60de8233e484a3fa313e0
  history:  > ❌  > ⚠️  
            
- kselftest.lsm (defconfig+arm64-chromebook+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60de8233e484a3fa313e3
  history:  > ✅  > ⚠️  
            
- kselftest.perf_events (defconfig+arm64-chromebook+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60dea233e484a3fa313f0
  history:  > ⚠️  > ⚠️  
            
- kselftest.zram (defconfig+arm64-chromebook+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60df1233e484a3fa31417
  history:  > ✅  > ⚠️  
            
Hardware: beaglebone-black
- boot (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a60735233e484a3fa2ffff
  history:  > ✅  > ⚠️  
            
- kselftest.acct (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a6073f233e484a3fa30016
  history:  > ❌  > ⚠️  
            
- kselftest.alsa (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a60740233e484a3fa30019
  history:  > ❌  > ⚠️  
            
- kselftest.breakpoints (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a60745233e484a3fa30026
  history:  > ❌  > ⚠️  
            
- kselftest.capabilities (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a60746233e484a3fa30029
  history:  > ✅  > ⚠️  
            
- kselftest.clone3 (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a60747233e484a3fa3002c
  history:  > ❌  > ⚠️  
            
- kselftest.coredump (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a60748233e484a3fa3002f
  history:  > ❌  > ⚠️  
            
- kselftest.device_error_logs (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a60749233e484a3fa30032
  history:  > ❌  > ⚠️  
            
- kselftest.dt (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a60753233e484a3fa30051
  history:  > ❌  > ❌  > ⚠️  > ⚠️  
            
- kselftest.fchmodat2 (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a60758233e484a3fa30061
  history:  > ❌  > ⚠️  
            
- kselftest.futex (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a60759233e484a3fa30064
  history:  > ❌  > ⚠️  
            
- kselftest.kcmp (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a6075a233e484a3fa30067
  history:  > ✅  > ⚠️  
            
- kselftest.mqueue (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a6075b233e484a3fa3006a
  history:  > ❌  > ⚠️  
            
- kselftest.proc (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a6075e233e484a3fa30070
  history:  > ❌  > ⚠️  
            
- kselftest.ptrace (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a6075c233e484a3fa3006d
  history:  > ❌  > ⚠️  
            
- kselftest.signal (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a60762233e484a3fa30079
  history:  > ❌  > ⚠️  
            
- kselftest.timers (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a6075f233e484a3fa30073
  history:  > ❌  > ⚠️  
            
- kselftest.tmpfs (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a60760233e484a3fa30076
  history:  > ✅  > ⚠️  
            
- kselftest.vdso (multi_v7_defconfig)
  last run: https://d.kernelci.org/test/maestro:68a60763233e484a3fa3007c
  history:  > ✅  > ⚠️  
            
- kselftest.gpio (multi_v7_defconfig+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60ca0233e484a3fa30ccd
  history:  > ❌  > ⚠️  
            
- kselftest.ipc (multi_v7_defconfig+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60ca2233e484a3fa30cd0
  history:  > ❌  > ⚠️  
            
- kselftest.landlock (multi_v7_defconfig+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60ca3233e484a3fa30cd3
  history:  > ❌  > ⚠️  
            
- kselftest.lsm (multi_v7_defconfig+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60ca5233e484a3fa30cd6
  history:  > ❌  > ⚠️  
            
- kselftest.memfd (multi_v7_defconfig+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60ca7233e484a3fa30cd9
  history:  > ❌  > ⚠️  
            
- kselftest.perf_events (multi_v7_defconfig+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60cab233e484a3fa30cdf
  history:  > ❌  > ⚠️  
            
- kselftest.ring-buffer (multi_v7_defconfig+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60cad233e484a3fa30ce9
  history:  > ❌  > ⚠️  
            
- kselftest.rlimits (multi_v7_defconfig+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60caf233e484a3fa30cfb
  history:  > ❌  > ⚠️  
            
- kselftest.seccomp (multi_v7_defconfig+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60cb7233e484a3fa30d13
  history:  > ❌  > ⚠️  
            
- kselftest.splce (multi_v7_defconfig+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60cb1233e484a3fa30cfe
  history:  > ❌  > ⚠️  
            
- kselftest.sync (multi_v7_defconfig+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60cb3233e484a3fa30d09
  history:  > ✅  > ⚠️  
            
- kselftest.timens (multi_v7_defconfig+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60cb5233e484a3fa30d10
  history:  > ✅  > ⚠️  
            
- kselftest.ublk (multi_v7_defconfig+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60cba233e484a3fa30d16
  history:  > ❌  > ⚠️  
            
- kselftest.uevent (multi_v7_defconfig+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60cbb233e484a3fa30d1f
  history:  > ❌  > ⚠️  
            
- kselftest.user_events (multi_v7_defconfig+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60cbd233e484a3fa30d22
  history:  > ✅  > ⚠️  
            
Hardware: cd8180-orion-o6
- boot (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a61231233e484a3fa32fdd
  history:  > ✅  > ⚠️  
            
- kselftest.arm64 (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a6123f233e484a3fa3303b
  history:  > ⚠️  > ⚠️  
            
- kselftest.breakpoints (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a61245233e484a3fa33065
  history:  > ⚠️  > ⚠️  
            
- kselftest.device_error_logs (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a6124a233e484a3fa33087
  history:  > ⚠️  > ⚠️  
            
- kselftest.dt (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a61255233e484a3fa330c2
  history:  > ⚠️  > ⚠️  
            
- kselftest.futex (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a6125f233e484a3fa330ff
  history:  > ⚠️  > ⚠️  
            
- kselftest.signal (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a61265233e484a3fa33120
  history:  > ⚠️  > ⚠️  
            
- kselftest.timers (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a61263233e484a3fa33115
  history:  > ⚠️  > ⚠️  
            
- kselftest.efivars (defconfig+arm64-chromebook+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60de1233e484a3fa313b3
  history:  > ⚠️  > ⚠️  
            
- kselftest.ftrace (defconfig+arm64-chromebook+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60de2233e484a3fa313b9
  history:  > ⚠️  > ⚠️  
            
- kselftest.mm (defconfig+arm64-chromebook+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60de9233e484a3fa313e9
  history:  > ⚠️  > ⚠️  
            
- kselftest.perf_events (defconfig+arm64-chromebook+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60deb233e484a3fa313f3
  history:  > ⚠️  > ⚠️  
            
Hardware: dell-latitude-3445-7520c-skyrim
- boot (cros://chromeos-6.6/x86_64/chromeos-amd-stoneyridge.flavour.config+lab-setup+x86-board+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y)
  last run: https://d.kernelci.org/test/maestro:68a606eb233e484a3fa2ff10
  history:  > ⚠️  > ⚠️  > ⚠️  > ⚠️  
            
Hardware: dell-latitude-5400-8665U-sarien
- tast (cros://chromeos-6.6/x86_64/chromeos-intel-pineview.flavour.config+lab-setup+x86-board+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y)
  last run: https://d.kernelci.org/test/maestro:68a60d3e233e484a3fa31230
  history:  > ⚠️  > ⚠️  > ⚠️  > ⚠️  > ❌  
            
- boot (defconfig+kcidebug+x86-board)
  last run: https://d.kernelci.org/test/maestro:68a61135233e484a3fa32a6c
  history:  > ❌  > ⚠️  
            
Hardware: hp-14b-na0052xx-zork
- kselftest.cpufreq.suspend (x86_64_defconfig+lab-setup+x86-board+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60e82233e484a3fa31580
  history:  > ✅  > ⚠️  
            
Hardware: hp-14-db0003na-grunt
- kselftest.cpufreq.suspend (x86_64_defconfig+lab-setup+x86-board+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60e81233e484a3fa3157a
  history:  > ⚠️  > ✅  
            
Hardware: imx8mp-evk
- kselftest.alsa (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a6123a233e484a3fa33019
  history:  > ⚠️  > ❌  
            
Hardware: imx8mp-verdin-nonwifi-dahlia
- boot (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a61232233e484a3fa32fe3
  history:  > ✅  > ⚠️  
            
- kselftest.alsa (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a6123a233e484a3fa3301c
  history:  > ❌  > ⚠️  
            
- kselftest.arm64 (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a61240233e484a3fa33041
  history:  > ✅  > ⚠️  
            
- kselftest.device_error_logs (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a6124b233e484a3fa3308d
  history:  > ❌  > ⚠️  
            
- kselftest.dt (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a61256233e484a3fa330cf
  history:  > ❌  > ⚠️  
            
- kselftest.kvm (defconfig+arm64-chromebook+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60de4233e484a3fa313cb
  history:  > ❌  > ⚠️  
            
- kselftest.pkvm (defconfig+arm64-chromebook+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a60de7233e484a3fa313da
  history:  > ❌  > ⚠️  
            
Hardware: lenovo-TPad-C13-Yoga-zork
- tast (cros://chromeos-6.6/x86_64/chromeos-amd-stoneyridge.flavour.config+lab-setup+x86-board+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y)
  last run: https://d.kernelci.org/test/maestro:68a60703233e484a3fa2ffec
  history:  > ⚠️  > ⚠️  > ⚠️  > ⚠️  > ⚠️  
            
Hardware: meson-g12b-a311d-libretech-cc
- boot (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a61233233e484a3fa32fed
  history:  > ✅  > ⚠️  
            
Hardware: meson-sm1-s905d3-libretech-cc
- boot (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a61234233e484a3fa32ff5
  history:  > ✅  > ⚠️  
            
- kselftest.device_error_logs (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a6124f233e484a3fa3309f
  history:  > ❌  > ⚠️  
            
- kselftest.dt (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a61259233e484a3fa330e1
  history:  > ⚠️  > ❌  
            
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
- boot.nfs (defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y)
  last run: https://d.kernelci.org/test/maestro:68a60b88233e484a3fa3089d
  history:  > ✅  > ⚠️  
            
- kernelci_watchdog_reset (defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y)
  last run: https://d.kernelci.org/test/maestro:68a60c18233e484a3fa30965
  history:  > ⚠️  > ✅  
            
- kselftest.cpufreq.hibernate (defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y)
  last run: https://d.kernelci.org/test/maestro:68a60bc9233e484a3fa30905
  history:  > ⚠️  > ✅  
            
- kselftest.devices-probe (defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y)
  last run: https://d.kernelci.org/test/maestro:68a60bab233e484a3fa308d8
  history:  > ⚠️  > ✅  
            
- kselftest.exec (defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y)
  last run: https://d.kernelci.org/test/maestro:68a60bfa233e484a3fa3093b
  history:  > ⚠️  > ✅  
            
Hardware: mt8395-genio-1200-evk
- kselftest.dt (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a6125d233e484a3fa330f4
  history:  > ❌  > ⚠️  
            
Hardware: rk3399-roc-pc
- boot (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a61234233e484a3fa32ff8
  history:  > ⚠️  > ✅  
            
- kselftest.arm64 (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a61243233e484a3fa33056
  history:  > ⚠️  > ⚠️  
            
- kselftest.dt (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a6125a233e484a3fa330e4
  history:  > ⚠️  > ⚠️  
            
Hardware: sc7180-trogdor-kingoftown
- kselftest.cpufreq.suspend (defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y)
  last run: https://d.kernelci.org/test/maestro:68a60bd3233e484a3fa30911
  history:  > ✅  > ⚠️  
            
Hardware: sun50i-h5-libretech-all-h3-cc
- kselftest.alsa (defconfig+lab-setup+kselftest)
  last run: https://d.kernelci.org/test/maestro:68a6123d233e484a3fa3302c
  history:  > ❌  > ⚠️  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

