Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A757E6E44
	for <lists+stable@lfdr.de>; Thu,  9 Nov 2023 17:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjKIQIP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 9 Nov 2023 11:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbjKIQIP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 9 Nov 2023 11:08:15 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014BD30F9
        for <stable@vger.kernel.org>; Thu,  9 Nov 2023 08:08:12 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5bd33a450fdso862035a12.0
        for <stable@vger.kernel.org>; Thu, 09 Nov 2023 08:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699546092; x=1700150892; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QqOH0LQBa8odW/UpxZMidLCuYHjnIKbfek39GyZSXbI=;
        b=K79pmuMo7GwZEkno+VFs6sP9wgsKOPPLdnV5jaQJLf/G7vEICDXHI7OfTM7JmyhfqU
         uea8Lun6mDuC73CVy0YfanUbm1SZ+hqBSQWWRUv4L8q31BtwLWF7/gk9PDyYhiELENYz
         iOcQ3RiHn3gYocY4P28zGXsquzYMIXzpkzkWsiERiTebQLVR4Czs6HCj7XJ7vaWu30vg
         WQ4KptHAj/OuUjLgaAdUAiM2EIj0LiYvmiW4rlTXUQzEGjtlGP5qq2Ppn+NBL5vXeVHs
         y7UTKvdUT6gVwQwauV5OyQgy1r5z0TvxwPup2XEKST4+1PnsICMxL1jlADPHHM5+NOtA
         BRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699546092; x=1700150892;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqOH0LQBa8odW/UpxZMidLCuYHjnIKbfek39GyZSXbI=;
        b=KznDhrLexYQZQkFqmgyrm4Atk+NOE7cJb0crD4CJPnRuybFNGwWoGeOd3ZiMMMrGYe
         qlX2lWTEwOVWN9i8vrEKWHpuQwd2MMQ1Q7B4JW+2aj76tOrrz/7FzjaaE3ZLmEACmQ42
         Syjij/t/vsxWBYIfH+JLFOvBMVYLZYuCrLI55pjeozIeOcGLL2x9FqONEUL6vrpOKov2
         /NEi4ARNZGQx7zbh54wQ4+rLGjOtcm2jUO0mDcRR3oL+QDPmNkpdF8UN+SJnPC9XNAub
         CE70cfvw3FMIGdkhpmyjLqFsQQK78B+OAjCQits8I799hZ7RgC0HlYjLPJNmo/QASQXq
         LCrA==
X-Gm-Message-State: AOJu0YxuOX6SGv4LCGomBJJlff6h2kkVRI0kYETliBAYStzzENl+GtUN
        KlmsE8M/bL+hqx2GsWCxilKcXoOEU+AH1rfe9m1W0A==
X-Google-Smtp-Source: AGHT+IEvk0PzQkBdQ6c7ggmYiZmLVNAljxcBZEpcxPQbc+ku1YfxGuH6QFHbt2EU7sY01tQGXlcpaA==
X-Received: by 2002:a17:90a:3181:b0:280:18bd:ffe7 with SMTP id j1-20020a17090a318100b0028018bdffe7mr1804153pjb.48.1699546092013;
        Thu, 09 Nov 2023 08:08:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t21-20020a17090a449500b002808c9e3095sm1502395pjg.26.2023.11.09.08.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 08:08:11 -0800 (PST)
Message-ID: <654d03eb.170a0220.b58d.4011@mx.google.com>
Date:   Thu, 09 Nov 2023 08:08:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.298
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-4.19.y baseline: 92 runs, 1 regressions (v4.19.298)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.19.y baseline: 92 runs, 1 regressions (v4.19.298)

Regressions Summary
-------------------

platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.298/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.298
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      aa8663e85da65e4b92ac82208059c173cb42c3bd =



Test Regressions
---------------- =



platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/654cd2641e8f8a2d94efcf3e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
98/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
98/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/654cd2641e8f8a2=
d94efcf41
        failing since 24 days (last pass: v4.19.288, first fail: v4.19.296-=
42-gb3c2ae79aa73)
        1 lines

    2023-11-09T12:36:39.025246  <4>[   46.417587] ------------[ cut here ]-=
-----------
    2023-11-09T12:36:39.025769  <4>[   46.417679] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1040 meson_mmc_irq+0x1c8/0x1dc
    2023-11-09T12:36:39.029249  <4>[   46.426151] Modules linked in: ipv6 d=
wmac_generic realtek meson_gxl meson_dw_hdmi meson_drm dw_hdmi dwmac_meson8=
b drm_kms_helper stmmac_platform meson_ir crc32_ce drm rc_core meson_gxbb_w=
dt meson_rng adc_keys crct10dif_ce stmmac pwm_meson rng_core drm_panel_orie=
ntation_quirks nvmem_meson_efuse input_polldev
    2023-11-09T12:36:39.068554  <4>[   46.453410] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.298 #1
    2023-11-09T12:36:39.068775  <4>[   46.461080] Hardware name: Amlogic Me=
son GXM (S912) Q200 Development Board (DT)
    2023-11-09T12:36:39.068978  <4>[   46.468586] pstate: 60000085 (nZCv da=
If -PAN -UAO)
    2023-11-09T12:36:39.069175  <4>[   46.473590] pc : meson_mmc_irq+0x1c8/=
0x1dc
    2023-11-09T12:36:39.069368  <4>[   46.477901] lr : meson_mmc_irq+0x1c8/=
0x1dc
    2023-11-09T12:36:39.069781  <8>[   46.479472] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>   =

 =20
