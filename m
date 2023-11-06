Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B037E298F
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 17:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjKFQRe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 11:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjKFQRd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 11:17:33 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A00D69
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 08:17:30 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so3464171b3a.3
        for <stable@vger.kernel.org>; Mon, 06 Nov 2023 08:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699287449; x=1699892249; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qzt0OhYPyZEqYyh3QN7LnZgF8IH2HQLhGgR8wGuIic0=;
        b=w9LnU0W2LVOxtrBN4vPWM1ihK87BYTPLmh+94r/eBUqSv0a1k7x1ei2tjFuZ53WU3r
         bo6AcVgmmWaM1oaxJJgw8f2fnvtNqUABrRaZkgy100tKduAaJ55yllMUq/D2wb5idvC7
         7CX2F/OXcQ9kYq2KFz3MdxO07peQ6KwIKZ/DBAv70RuAUHfavhhbOVhJhYmSKYMfBvVQ
         yjosgPoynQSxOgRjkGKfo4lnEJEjG9gWKuWxJxiMMDGvYYZpCDnOJl1xlpurlkP4NNka
         hv3oA6ruuQs/CGVReYnatR79jqJcz/3DvRZdUU+yixix5Avp3WgmwX17eYFIzqBr/Thd
         X+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699287449; x=1699892249;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qzt0OhYPyZEqYyh3QN7LnZgF8IH2HQLhGgR8wGuIic0=;
        b=Rj0y0/mWrLTUwKr8Ngx4H+INWJ/gXn8jTFGzgtlvytwssaRHSJ1czcwfsb4t3joJEJ
         K6AhqZPpmkA79A4DRImwYZFyJhmPlpdEOWJqj3/C1dY8cW/bXJmPiy43MbTQx+MFONy8
         JAQ4t0wkxixwtqwekUn0k65SJTaImpUkpate/83dumQXQLphyG+Pm5rVPdLWEZ2GV5pn
         p673nFWqa0onOaXuhmtwBp1b6sOW3fsuD9ggFOroIPoGY3/DKWUxP7lkfxLWyYgzQCDx
         RxvhrJ/j8FxWX/AvimijdepBAfn2FViV1m3fMbULBZtw76l0ToBIChsHNqAhmE9wuh7N
         ozyA==
X-Gm-Message-State: AOJu0YzptzKjNlIYoDATsJSQuxf0YQFqosPwVXn59bFkfpeEbnyW0+vS
        ikfMCiLjBrX0Nygnt5QbQXcq6RRgBdcskHmZ6ryE+Q==
X-Google-Smtp-Source: AGHT+IE8vR1f1sotEbd6lsBzP+sWxm99F+PTz/1goejYmf5rUM8ccL/D3ZZf2LGWUbTf2MobtjVsvQ==
X-Received: by 2002:a05:6a21:3607:b0:161:76a4:4f79 with SMTP id yg7-20020a056a21360700b0016176a44f79mr17917981pzb.23.1699287449324;
        Mon, 06 Nov 2023 08:17:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u8-20020a627908000000b006baa1cf561dsm6087126pfc.0.2023.11.06.08.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 08:17:28 -0800 (PST)
Message-ID: <65491198.620a0220.87f62.daea@mx.google.com>
Date:   Mon, 06 Nov 2023 08:17:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.297-56-gaed5d9c51d2ca
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-4.19.y baseline: 135 runs,
 1 regressions (v4.19.297-56-gaed5d9c51d2ca)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.19.y baseline: 135 runs, 1 regressions (v4.19.297-56-gaed=
5d9c51d2ca)

Regressions Summary
-------------------

platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.297-56-gaed5d9c51d2ca/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.297-56-gaed5d9c51d2ca
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      aed5d9c51d2ca39b889e7a6be9191a6c9f45792f =



Test Regressions
---------------- =



platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6548e01a21b2b3963eefcf1b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
97-56-gaed5d9c51d2ca/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm=
-q200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
97-56-gaed5d9c51d2ca/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm=
-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6548e01a21b2b39=
63eefcf1e
        failing since 21 days (last pass: v4.19.288, first fail: v4.19.296-=
42-gb3c2ae79aa73)
        1 lines

    2023-11-06T12:46:04.793461  <4>[   46.201261] ------------[ cut here ]-=
-----------
    2023-11-06T12:46:04.793954  <4>[   46.201351] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1040 meson_mmc_irq+0x1c8/0x1dc
    2023-11-06T12:46:04.796802  <4>[   46.209819] Modules linked in: ipv6 d=
wmac_generic realtek meson_gxl meson_dw_hdmi meson_drm dw_hdmi drm_kms_help=
er drm adc_keys crc32_ce meson_ir rc_core meson_rng rng_core dwmac_meson8b =
stmmac_platform crct10dif_ce stmmac pwm_meson meson_gxbb_wdt drm_panel_orie=
ntation_quirks input_polldev nvmem_meson_efuse
    2023-11-06T12:46:04.836711  <4>[   46.237079] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.298-rc1 #1
    2023-11-06T12:46:04.836922  <4>[   46.245094] Hardware name: Amlogic Me=
son GXM (S912) Q200 Development Board (DT)
    2023-11-06T12:46:04.837117  <4>[   46.252600] pstate: 60000085 (nZCv da=
If -PAN -UAO)
    2023-11-06T12:46:04.837304  <4>[   46.257606] pc : meson_mmc_irq+0x1c8/=
0x1dc
    2023-11-06T12:46:04.837490  <8>[   46.258562] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
    2023-11-06T12:46:04.837676  <4>[   46.261913] lr : meson_mmc_irq+0x1c8/=
0x1dc   =

 =20
