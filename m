Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9D17D7334
	for <lists+stable@lfdr.de>; Wed, 25 Oct 2023 20:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjJYS0Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 14:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjJYS0Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 14:26:24 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAAB182
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 11:26:21 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27d0251d305so4260937a91.2
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 11:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698258380; x=1698863180; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WA+eZStQmHfzUF81rodanPEwTfuGqk4BCXcDvZqTXME=;
        b=BdrCC2LQkcxc9A/JAEaq6zFng1j22rPbTLsva80u8e7qFcmptHdkQSv/r5J/8h3Zfi
         OufV+odGdmj1uUCsnWWAZYY82fOmSNQxoUc25YpqYNkDutFlj6oKQ7k32H1OfyO+uswb
         +CON9Eci6usmP3mv/bgpmLvCLU2ZsDWVfF6uZbUzVxUJjx/DADeNI+WT9zx/tDDrtrWe
         sgB6+2K5qMZiyfz4HfJTuAcxVTB0FETYnfxT2tXYS3vM2IAbMqxcWzI7jf6cPQ20U6Cd
         Qqwt3jmMP2aHQaNjB0crTz1YtCTEZrywSY0l0ZvQZp/E5H+IOXIRD5vw3qHS16inrwbm
         TtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698258380; x=1698863180;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WA+eZStQmHfzUF81rodanPEwTfuGqk4BCXcDvZqTXME=;
        b=brL8Lq+h/pMDmK35oj7QWN4V0tCSolrDGGLR4Uco8ARwGoC0nydxC2nqm8StvkdRUY
         8+i22ijlJ/z9gTgXk/gNPX3Jb4iewk+baCrl5sV9NWj+3ZoQP8PBohbjUwUZLWReBMWQ
         B8tVRvh+04g7ZQccqgty7trtQ6V1oAPvUQguxF76aD8QkwdgfGjNKtMRchIYTNDWc2xy
         h3xEo7gIxZJUvjZdV9c0u2JnB+pTJytstRkzqCZsp1a5szZ6a7tDaWPiG8ewRM4MPsje
         MD3pwOAwQslEYQyyOzkMQLwnKk0cAuyGIxDb1yOt21RMKKf96FktyOMaTn9LwssTIcP0
         i7JA==
X-Gm-Message-State: AOJu0Yz+bLf2vd0aEos14Jas9IpOY/sCGyx3HKO7VN/1yk1NogtgvDGl
        ZMwYCyL+hwf8Spi3Nh8MyQpTx8Egv52CBxCPUnI=
X-Google-Smtp-Source: AGHT+IGS/hEq6T6K6hs5/Zj2XQL382f2uOZQkYyny6+xfZncjYKmq3vgvEQif91pwhU+fSAd6IdNmg==
X-Received: by 2002:a17:90a:1a10:b0:27d:5ef6:2862 with SMTP id 16-20020a17090a1a1000b0027d5ef62862mr12892628pjk.13.1698258380453;
        Wed, 25 Oct 2023 11:26:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id rj14-20020a17090b3e8e00b00263dfe9b972sm225714pjb.0.2023.10.25.11.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 11:26:19 -0700 (PDT)
Message-ID: <65395dcb.170a0220.d52cd.14f5@mx.google.com>
Date:   Wed, 25 Oct 2023 11:26:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.297
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable
Subject: stable/linux-4.19.y baseline: 107 runs, 4 regressions (v4.19.297)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-4.19.y baseline: 107 runs, 4 regressions (v4.19.297)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
at91sam9g20ek         | arm   | lab-broonie  | gcc-10   | multi_v5_defconfi=
g | 1          =

meson-gxbb-p200       | arm64 | lab-baylibre | gcc-10   | defconfig        =
  | 1          =

meson-gxl-s905d-p230  | arm64 | lab-baylibre | gcc-10   | defconfig        =
  | 1          =

meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig        =
  | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-4.19.y/kernel=
/v4.19.297/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-4.19.y
  Describe: v4.19.297
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      4a82dfcb8b4d07331d1db05a36f7d87013787e9e =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
at91sam9g20ek         | arm   | lab-broonie  | gcc-10   | multi_v5_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/65392b6092ed3ade4aefcf0e

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.297/=
arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.297/=
arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65392b6092ed3ade4aefcf44
        new failure (last pass: v4.19.296)

    2023-10-25T14:50:34.361506  + set +x
    2023-10-25T14:50:34.362068  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 194139_1.5.2=
.4.1>
    2023-10-25T14:50:34.474562  / # #
    2023-10-25T14:50:34.577585  export SHELL=3D/bin/sh
    2023-10-25T14:50:34.578476  #
    2023-10-25T14:50:34.680456  / # export SHELL=3D/bin/sh. /lava-194139/en=
vironment
    2023-10-25T14:50:34.681263  =

    2023-10-25T14:50:34.783281  / # . /lava-194139/environment/lava-194139/=
bin/lava-test-runner /lava-194139/1
    2023-10-25T14:50:34.784624  =

    2023-10-25T14:50:34.788251  / # /lava-194139/bin/lava-test-runner /lava=
-194139/1 =

    ... (12 line(s) more)  =

 =



platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
meson-gxbb-p200       | arm64 | lab-baylibre | gcc-10   | defconfig        =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/65392abdf3dc9bc74eefcf71

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.297/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.297/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/65392abdf3dc9bc=
74eefcf74
        new failure (last pass: v4.19.288)
        1 lines

    2023-10-25T14:48:15.013885  kern  :emerg : Disabling IRQ #19
    2023-10-25T14:48:15.014370  <8>[   49.168281] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
    2023-10-25T14:48:15.014572  + set +<8>[   49.171984] <LAVA_SIGNAL_ENDRU=
N 0_dmesg 3813706_1.5.2.4.1>
    2023-10-25T14:48:15.014758  x
    2023-10-25T14:48:15.015109  / # <4>[   49.195436] ------------[ cut her=
e ]------------
    2023-10-25T14:48:15.015282  <4>[   49.195505] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1040 meson_mmc_irq+0x1c8/0x1dc   =

 =



platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
meson-gxl-s905d-p230  | arm64 | lab-baylibre | gcc-10   | defconfig        =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/65392b02db8ca7add7efcf0b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.297/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.297/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/65392b02db8ca7a=
dd7efcf0e
        new failure (last pass: v4.19.292)
        3 lines

    2023-10-25T14:49:19.146912  kern  :emerg : Disabling IRQ #19
    2023-10-25T14:49:19.152728  kern  :emerg : Disabling IRQ #20
    2023-10-25T14:49:19.166863  kern  :emerg : Disabling IRQ <8>[   49.4049=
13] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines =
MEASUREMENT=3D3>
    2023-10-25T14:49:19.167591  #18   =

 =



platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig        =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/65392aa8f3dc9bc74eefcf02

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.297/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.297/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/65392aa8f3dc9bc=
74eefcf05
        new failure (last pass: v4.19.284)
        2 lines

    2023-10-25T14:47:55.117144  kern  :emerg : Disabling IRQ #24
    2023-10-25T14:47:55.117341  kern  :emerg : Disabling IRQ #22
    2023-10-25T14:47:55.117728  <8>[   48.322195] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>
    2023-10-25T14:47:55.117917  + set +x
    2023-10-25T14:47:55.118096  <8>[   48.326390] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3813708_1.5.2.4.1>   =

 =20
