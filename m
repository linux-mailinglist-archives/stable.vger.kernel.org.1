Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8698F7DF553
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 15:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjKBOxF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 10:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKBOxE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 10:53:04 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D9313A
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 07:52:58 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc5b6d6228so7768085ad.2
        for <stable@vger.kernel.org>; Thu, 02 Nov 2023 07:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698936777; x=1699541577; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DREX7Jqgbkm8JlWZ37AHf9/a7DeIb+f6CT0ji9d1gkA=;
        b=SJkHk/6azTsQ/7DiOq2onzWJgSil3I1StPJjEUOVgNPFlvvfmseDMAhLmJbr2K5MgJ
         XaOKLdIAoYN4iwSIBDAgTFGVAu7UEK+Eb6NqFo/gFRVynBcfFmpNMUcO5VdyQMg8cunn
         SR7of3wuuXLAPwwXQWW5iqo2zguwXW0LWz88IxtMwatZaWWV34P2V7bLFWvYnhTar4Ya
         b7oXB8NM1YwauL63hXRi8KepkNph49nYLTEusbd08kJNmMjdgnLbHgwOsbda3u60o1s+
         D17TVgvljsHiAkZInGoEQ7qgfqEIS4aXnJO2RY9+EVYNXAXu1wcEbFmOpOlJqWbWUa0e
         SV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698936777; x=1699541577;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DREX7Jqgbkm8JlWZ37AHf9/a7DeIb+f6CT0ji9d1gkA=;
        b=kNz3Ny/XfUf/yA6gNn1rEQDVNSRQndFrz/BB2BehB7kYbk7T4du/GYCKBvwXDVkuF3
         IO/+Rqm2DVFknUjkiPzCfF5aE9lRngNR8voyUvf1l6ohmmRo0z8YgFdDAJWvReHkz/BH
         RIdoXsIZYv3qUay97NHhVMvMOIbPWt/ZxFQYiRyhfMGlQzMOD8Ky7noQYxtP0OEhZxCT
         QEn0oYWOEm1D65VhifCNbxhOPMgQQDKLTVBaCVJOE6PtU/JFaXGxwzdwQ2K8SNlLNmZd
         RY+bFHDfrYklTFiWHFeNgYNkEGT7tu6Px3TpEmuuPgce2u5ETr6JvYWc6HKUl4Qk0SUt
         ZZSA==
X-Gm-Message-State: AOJu0YwL9IZnC/lI+jPedc+oWevAYO5olyYMHf42OYzhzVr4CPYZ3UmD
        O7NAqCPbw6AGRXP6u470SpB7dyzZUffMYf94Z5iq/A==
X-Google-Smtp-Source: AGHT+IEWRZujS/CqwDf0NR0t5np8lA63zrbhV8JmEgV+HwBjp4AllGD+7QSuSBbD8p/gqI3SYrwgkw==
X-Received: by 2002:a17:902:f213:b0:1c9:da1a:8b14 with SMTP id m19-20020a170902f21300b001c9da1a8b14mr15043126plc.1.1698936777116;
        Thu, 02 Nov 2023 07:52:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902edc700b001bc21222e34sm3200796plk.285.2023.11.02.07.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 07:52:56 -0700 (PDT)
Message-ID: <6543b7c8.170a0220.130d9.8f79@mx.google.com>
Date:   Thu, 02 Nov 2023 07:52:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.297
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-4.19.y baseline: 141 runs, 1 regressions (v4.19.297)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.19.y baseline: 141 runs, 1 regressions (v4.19.297)

Regressions Summary
-------------------

platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.297/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.297
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4a82dfcb8b4d07331d1db05a36f7d87013787e9e =



Test Regressions
---------------- =



platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/654386a3293d8399e4efcf02

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
97/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
97/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/654386a3293d839=
9e4efcf05
        failing since 17 days (last pass: v4.19.288, first fail: v4.19.296-=
42-gb3c2ae79aa73)
        1 lines

    2023-11-02T11:23:02.563487  <4>[   51.142135] ------------[ cut here ]-=
-----------
    2023-11-02T11:23:02.564878  <4>[   51.142224] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1040 meson_mmc_irq+0x1c8/0x1dc
    2023-11-02T11:23:02.568620  <4>[   51.150696] Modules linked in: ipv6 r=
ealtek meson_gxl dwmac_generic meson_dw_hdmi dwmac_meson8b stmmac_platform =
dw_hdmi stmmac meson_drm drm_kms_helper meson_ir crc32_ce drm rc_core meson=
_rng meson_gxbb_wdt adc_keys pwm_meson crct10dif_ce rng_core drm_panel_orie=
ntation_quirks nvmem_meson_efuse input_polldev
    2023-11-02T11:23:02.607216  <4>[   51.177957] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.297 #1
    2023-11-02T11:23:02.607836  <4>[   51.185628] Hardware name: Amlogic Me=
son GXM (S912) Q200 Development Board (DT)
    2023-11-02T11:23:02.608030  <4>[   51.193133] pstate: 60000085 (nZCv da=
If -PAN -UAO)
    2023-11-02T11:23:02.608436  <4>[   51.198135] pc : meson_mmc_irq+0x1c8/=
0x1dc
    2023-11-02T11:23:02.608626  <4>[   51.202447] lr : meson_mmc_irq+0x1c8/=
0x1dc
    2023-11-02T11:23:02.608806  <4>[   51.206758] sp : ffff000008003cc0
    2023-11-02T11:23:02.609196  <4>[   51.210294] x29: ffff000008003cc0 x28=
: 00000000000000a0  =

    ... (38 line(s) more)  =

 =20
