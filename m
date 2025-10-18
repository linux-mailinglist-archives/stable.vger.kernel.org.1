Return-Path: <stable+bounces-187836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5D4BECDF9
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 12:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88249625D64
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 10:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851B82F9DA0;
	Sat, 18 Oct 2025 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="gi25T5Ty"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5598A2F5A23
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760785151; cv=none; b=RmbPZXcA+DRfDhgF6mr+PWLTWMqIn08kD57C2Fxl+a9Lwa81pAPC0I8cyQVldJ4K1ukAat5WYxc39aukZIHfkRVlZflXKHDGTdAkZ5zq/EA+jhHq7odonnj/hiG+rb7cQI9BWzrtb/g5OmSUqeVEbNty2M1uc8CGNwGo2IWxdAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760785151; c=relaxed/simple;
	bh=uYv1MXpij67tJQP1VjSjFwxSy6VjW08UICMQ4puekFc=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=G1Xzv1SFVY+T/pVBcMoY8OnsH8WPXDzINvKMlg5Bwi8i507LOW3TLCf+kx1wmC27xo8I+5yHjkxnbapQruCCI7Ul8Q9CZXDGnFnaB+9mtHnNlCxdWRs4AZlb8N/o28yFunT2FI2VNGk/reCrd06SxIAPEtQUy7LxyUXkx+Z37RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=gi25T5Ty; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-330b4739538so2582083a91.3
        for <stable@vger.kernel.org>; Sat, 18 Oct 2025 03:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1760785148; x=1761389948; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zptiu5GcKehuncsdsqxllSgDDStXlq84DtHiVlh9Kk=;
        b=gi25T5Tyln8JbPNgGw5c9bukvf/E8G0n1rA9lNe16QAfCOXX7qbxFO0fNezILvwxwJ
         1gbqB0hJSchJhfT3sQ4dJCqg1d1WkjyZN/tFWhBiL9IX/NfIHslfeljp+7zi+ivfx5fu
         NWSPSHjYxHQnmvIFACLLbhr8aSTINADo34O7mYKjRrCHCYSKZNBWwYIyTNf98VKqyHC/
         gHYmYmkKXyEjV3WNQK7Gg7QspFN5+EztUVz1qkGlCAp9xvx1TqOrfLW6bJKT3CuOC9dC
         1OjPB0Czs9g8xqosOLpLxZxSyD7oI+z8+qK43OIT+qeVVNkmpAKxoYsF6JtQLHBzK5D3
         MVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760785148; x=1761389948;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5zptiu5GcKehuncsdsqxllSgDDStXlq84DtHiVlh9Kk=;
        b=du98MnlAKzdHUkWc2D5cfuribQOGFasfHsc6YurPLcmrsth2/WwGpnEJILZCBCBtHj
         i2Q+oaSX81A9+1oi48V9gpXITssAXvZ29m09vC1H6sskLhWshPenQqHBj/sLhLt/rT2U
         8VO9zSaa0gRqMVCrP64Mx0d2DL92owcNwKqPPcUxXpIqzR9UPRFauFqRq0w/BlvpoA9M
         spONOZgfeYQI4/kujmkpNCgdmQL+5wYnNQNcH6gHOfrd2ux09m+eCErYrp6IloVEfrbU
         TzlPvMWvuOk8orgZ+BoRR0iquJoGrups0OKqc4o/FpYlsBRiXGgXEoTetb9lfJPSQFE4
         S0TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEfBbEzfSylUl0eaq8Y6n7JlK62NMIhDp7SosS6ZQFFe0RPrkfE3j/9QzHyy73PtNnQoNlRMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEvkp7bWQB1VvpdcNXttZKE8VDe5iUQGVrXJ4Pqa0RJMM6wQG7
	r55mlVpuXJQ8cVgkQvtjbrPCx3LJ29OCFds3Z3EK/IYa6gbMh66PC/emK/zgdmCI81I=
X-Gm-Gg: ASbGncsVJUSk7dh+tIrg8PxXkIRROU3+DYGSWh0wStGhZuZZ1uHehUDEKPV0BRbIp7G
	0MaIAQL8X0t25yNzIMyBvXU12xNVz/i0eX+JqvHtRaS4shfmhjh2iwQubtIrSFKD7yOYnsjFEs0
	LUHAY7CUtXevmlq545HCUykQKsVwsmOptJGnAJE74UcGw8DQG5smzpsBe1hH+IowZOsVuXrj7zJ
	FTvmFH2sc5GcQ9eYLgKsg5omIyYzuAIwvhcueduut0fOdtJEAFy0GowzpacNQ0BUtbn4ih1xM/c
	xXwragI52wk+ghJGgz3FZq4JI5XypVNlia46VLE1ZOC+PCRsrKl1lhkf3APyind640szOXfjxxu
	xpoQs0nPuQx2g6th0gLiGv5aQv4sUrT0SZJNNV0mdgFBC2c3Z9Uvr2EYxHK6jjfhxFznWP6xVD7
	UsUAWpP4sX4mJnDwk=
X-Google-Smtp-Source: AGHT+IFGu4JbKmc2xBw7jYJTOEwEvmnwP5ls+MBve+n2wOT/EYZpWrfN2DU9b6bErhQ6yZ3yjEm8BQ==
X-Received: by 2002:a17:90b:3d87:b0:32b:96fa:5f46 with SMTP id 98e67ed59e1d1-33bcf86bcd7mr8242338a91.5.1760785148477;
        Sat, 18 Oct 2025 03:59:08 -0700 (PDT)
Received: from 15dd6324cc71 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bba630bf4sm3179176a91.4.2025.10.18.03.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 03:59:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) call to
 '__compiletime_assert_1041' declared with 'error' attribut...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 18 Oct 2025 10:59:07 -0000
Message-ID: <176078514710.3583.13524739232929082956@15dd6324cc71>





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 call to '__compiletime_assert_1041' declared with 'error' attribute: clamp() low limit -7 greater than high limit 15 in drivers/net/wireless/ralink/rt2x00/rt2800lib.o (drivers/net/wireless/ralink/rt2x00/rt2800lib.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:8602a79225a0e4285a39b81bbd04352b6ec80927
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  a32db271d59d9f35f3a937ac27fcc2db1e029cdc



Log excerpt:
=====================================================
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:10: error: call to '__compiletime_assert_1041' declared with 'error' attribute: clamp() low limit -7 greater than high limit 15
 3980 |                 return clamp_t(char, txpower, MIN_A_TXPOWER, MAX_A_TXPOWER);
      |                        ^
./include/linux/minmax.h:218:36: note: expanded from macro 'clamp_t'
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^
./include/linux/minmax.h:195:2: note: expanded from macro '__careful_clamp'
  195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |         ^
./include/linux/minmax.h:188:2: note: expanded from macro '__clamp_once'
  188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
      |         ^
note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
././include/linux/compiler_types.h:297:2: note: expanded from macro '_compiletime_assert'
  297 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ^
././include/linux/compiler_types.h:290:4: note: expanded from macro '__compiletime_assert'
  290 |                         prefix ## suffix();                             \
      |                         ^
<scratch space>:146:1: note: expanded from here
  146 | __compiletime_assert_1041
      | ^
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:10: error: call to '__compiletime_assert_1041' declared with 'error' attribute: clamp() low limit -7 greater than high limit 15
./include/linux/minmax.h:218:36: note: expanded from macro 'clamp_t'
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^
./include/linux/minmax.h:195:2: note: expanded from macro '__careful_clamp'
  195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |         ^
./include/linux/minmax.h:188:2: note: expanded from macro '__clamp_once'
  188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
      |         ^
note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
././include/linux/compiler_types.h:297:2: note: expanded from macro '_compiletime_assert'
  297 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ^
././include/linux/compiler_types.h:290:4: note: expanded from macro '__compiletime_assert'
  290 |                         prefix ## suffix();                             \
      |                         ^
<scratch space>:146:1: note: expanded from here
  146 | __compiletime_assert_1041
      | ^
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:3980:10: error: call to '__compiletime_assert_1041' declared with 'error' attribute: clamp() low limit -7 greater than high limit 15
./include/linux/minmax.h:218:36: note: expanded from macro 'clamp_t'
  218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
      |                                    ^
./include/linux/minmax.h:195:2: note: expanded from macro '__careful_clamp'
  195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
      |         ^
./include/linux/minmax.h:188:2: note: expanded from macro '__clamp_once'
  188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
      |         ^
note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
././include/linux/compiler_types.h:297:2: note: expanded from macro '_compiletime_assert'
  297 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ^
././include/linux/compiler_types.h:290:4: note: expanded from macro '__compiletime_assert'
  290 |                         prefix ## suffix();                             \
      |                         ^
<scratch space>:146:1: note: expanded from here
  146 | __compiletime_assert_1041
      | ^
  CC [M]  drivers/usb/gadget/function/f_mass_storage.o
  CC [M]  drivers/net/wireless/marvell/mwifiex/uap_event.o
  CC [M]  drivers/usb/musb/musb_virthub.o
  CC [M]  drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowacpi.o
  CC [M]  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.o
  CC [M]  drivers/usb/renesas_usbhs/mod.o
  CC [M]  drivers/usb/gadget/epautoconf.o
  CC [M]  drivers/usb/musb/musb_host.o
  CC [M]  drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.o
  CC [M]  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.o
  CC [M]  drivers/usb/renesas_usbhs/pipe.o
  CC [M]  drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowpci.o
  CC [M]  drivers/net/wireless/marvell/mwifiex/sta_tx.o
  CC [M]  drivers/usb/gadget/function/storage_common.o
  LD [M]  drivers/net/wireless/ralink/rt2x00/rt2x00lib.o
  CC [M]  drivers/media/i2c/adv7180.o
  CC [M]  drivers/usb/renesas_usbhs/fifo.o
  CC [M]  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.o
  CC [M]  drivers/usb/gadget/function/f_fs.o
  CC [M]  drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowramin.o
  CC [M]  drivers/usb/musb/musb_gadget_ep0.o
3 errors generated.

=====================================================


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-17
- config: https://files.kernelci.org/kbuild-clang-17-arm-68f2e7ae5621556c1f20560c/.config
- dashboard: https://d.kernelci.org/build/maestro:68f2e7ae5621556c1f20560c


#kernelci issue maestro:8602a79225a0e4285a39b81bbd04352b6ec80927

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

