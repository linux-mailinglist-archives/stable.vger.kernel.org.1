Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3237DFCB7
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 23:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbjKBW5f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 18:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjKBW5e (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 18:57:34 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B21B133
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 15:57:29 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so1364230b3a.3
        for <stable@vger.kernel.org>; Thu, 02 Nov 2023 15:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698965848; x=1699570648; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+rDf3A8MMKpvqEuhwMsQc6jKsjoaUJfPbxcyboObxV8=;
        b=OctY27LU3zMg6xGg4StcsUhEnNCtu3noSBZ1a4hQ3HqPpl1uZwYOVCzpO5KnjmWwIu
         TTLURZa3hZ4ZqUIW82ckkowggJhw8DtVdMOvq15gazl72Iw6M7vmpKBzRVmsZrMGzLCe
         GCQvp9DYmq7wl6kmrQOKRZt4jtFr8sVwoqWIfRNH5QkhAsUOZK3jfXh/q7CepxGQ3Iwg
         lTDzUuiEzps95vbj2Nend3rBKMGCxVuqT/zETKYP0KZGdcegM+uy8bsFf9KdPQtFComS
         wcBKhD4lrO7xgbZtmdIizjHoAWeqWhsvbTeDXBdchZkLVV3khgd72L4heqUSYcwCUSvl
         T2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698965848; x=1699570648;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rDf3A8MMKpvqEuhwMsQc6jKsjoaUJfPbxcyboObxV8=;
        b=lDDouf0s4uW/Sa7Pizg8HsZh5yT0+oJ0qn+YO8DRdrazQfbcA42MygHeL04Sy55nDO
         MHHnohGWYqn6NnXy0a+Gw6zT3YDXpdq+a/E+LIMR4k4sgrNck13nfSDRTIR+TlNdke7g
         Prxxo0rPi1XBBA+RgTZGlRsqLn5uS0uWJTbmIBnNVwU7UFiz1BLIbABGtWY0EeX4qTZ7
         ju6JtwX50Y9vjzz+URVKO+Eue0/ixNl0rhP/JHKQvRwzSPJp5C1xAjV1XrB33gG+ufjq
         1bX8h67tUBPSLgQWYFvtZS46DXROksGxQUps0pZ/tTpH3aCCfBfBk3qH/kpXdf7lXiu2
         soyw==
X-Gm-Message-State: AOJu0Yyw6uT7jve5UyOjC0onXNg0V0Ns/PV2LSoPJpmMb6fBCRh32BMU
        tDZOC59Pi3yxyRquuqj5Dy5dWGEUEQsVXsBxZ6iJRQ==
X-Google-Smtp-Source: AGHT+IFJOORc2bEQzDm9DY34AXS2lGiP6vjACNhJYuCwatDHXIIn7L75i4holUT2sSp+9Nccgk6YDA==
X-Received: by 2002:a05:6a00:138f:b0:6be:287d:46d6 with SMTP id t15-20020a056a00138f00b006be287d46d6mr21330628pfg.33.1698965847862;
        Thu, 02 Nov 2023 15:57:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id du4-20020a056a002b4400b00694ebe2b0d4sm232679pfb.191.2023.11.02.15.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 15:57:27 -0700 (PDT)
Message-ID: <65442957.050a0220.7b7d.1337@mx.google.com>
Date:   Thu, 02 Nov 2023 15:57:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.297-41-g46e03d3c6192
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-4.19.y baseline: 127 runs,
 1 regressions (v4.19.297-41-g46e03d3c6192)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.19.y baseline: 127 runs, 1 regressions (v4.19.297-41-g46e=
03d3c6192)

Regressions Summary
-------------------

platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.297-41-g46e03d3c6192/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.297-41-g46e03d3c6192
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      46e03d3c6192741f041d7d46136bc90245ed7220 =



Test Regressions
---------------- =



platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6543f7a6faa229eedcefcf00

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
97-41-g46e03d3c6192/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-=
q200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
97-41-g46e03d3c6192/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-=
q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6543f7a6faa229e=
edcefcf03
        failing since 17 days (last pass: v4.19.288, first fail: v4.19.296-=
42-gb3c2ae79aa73)
        1 lines

    2023-11-02T19:25:05.543668  <4>[   50.695079] ------------[ cut here ]-=
-----------
    2023-11-02T19:25:05.544156  <4>[   50.695165] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1040 meson_mmc_irq+0x1c8/0x1dc
    2023-11-02T19:25:05.546893  <4>[   50.703639] Modules linked in: ipv6 r=
ealtek meson_gxl dwmac_generic meson_dw_hdmi meson_drm crc32_ce dw_hdmi crc=
t10dif_ce drm_kms_helper meson_ir meson_rng drm rng_core rc_core dwmac_meso=
n8b meson_gxbb_wdt stmmac_platform pwm_meson stmmac drm_panel_orientation_q=
uirks adc_keys nvmem_meson_efuse input_polldev
    2023-11-02T19:25:05.586821  <4>[   50.730899] CPU: 0 PID: 0 Comm: swapp=
er/0 Tainted: G        W         4.19.298-rc1 #1
    2023-11-02T19:25:05.587063  <4>[   50.738915] Hardware name: Amlogic Me=
son GXM (S912) Q200 Development Board (DT)
    2023-11-02T19:25:05.587271  <4>[   50.746420] pstate: 60000085 (nZCv da=
If -PAN -UAO)
    2023-11-02T19:25:05.587467  <4>[   50.751422] pc : meson_mmc_irq+0x1c8/=
0x1dc
    2023-11-02T19:25:05.587656  <4>[   50.755734] lr : meson_mmc_irq+0x1c8/=
0x1dc
    2023-11-02T19:25:05.587908  <4>[   50.760045] sp : ffff000008003cc0
    2023-11-02T19:25:05.588214  <4>[   50.763582] x29: ffff000008003cc0 x28=
: 00000000000000a0  =

    ... (37 line(s) more)  =

 =20
