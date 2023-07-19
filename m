Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC5575A1DD
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 00:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjGSW1M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 19 Jul 2023 18:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjGSW1M (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 19 Jul 2023 18:27:12 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C322713
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 15:26:46 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-66869feb7d1so73849b3a.3
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689805604; x=1692397604;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QCnGJ/8crmW5S2griRciSCky4p6DDzYYQeRSwhJXPUQ=;
        b=OQG9zixDRO7hk0KvwlBYLVqT4WbhuSndWYCf2JgexRurRz5x0+zom03/uTZAhOlh02
         5WNkmenfTQvN21UmZqmLI1Tq7yZMvUCSR/K3ZpN60DoT1GGMrFOh5185SMYaTL9WON2l
         Y9rDRCP0zG+SRVv+GPHCcomy0QvKYgvnHim5nTaxzW7pAbxIlv1dimFBm1iOy/tykRlz
         wt3Bsh+R1XbbDygcAbbI8clWt7p1P5siXOX+fPU507p1I/db5p1Ya9E4eI5zteHiEdsj
         OueLfu5UTtevcbSdnrRShWDECX5m0Y3KTAdgSry0/60U0RLQQoOug8gnnYxMEH+0x4AP
         7WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689805604; x=1692397604;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCnGJ/8crmW5S2griRciSCky4p6DDzYYQeRSwhJXPUQ=;
        b=XjT3DzOykzButLHd7x+qRVIXo1wBZ9hUSCBLfPD9HjH5pdDL5sp2BfWCPRCRUKc01e
         4YhepiC0yfE7YvpbA6txUGnn4EpUWFF/KA0TAt6N0lhMT7VCFX0RXk/Cj0UkjGMThov3
         ZF8RSrZGiGBI12+fzFFEi9JvNJT8ftZEaWsNa93oy2mJ+aYWkUqNQ351iGmxVcMApb6v
         zpkoXG4RfIjuLbqK79+YzZkxS5kma+hcqG2G1s2bIEE8nh+UF01p4kFHW+WWdwhvFM25
         MdwJ8Pdpkno6CIxTYCEZg9x8l2uUZdIkWlKU/Kx+D7blT2zPJIanHbC/tKaynjYq17pn
         Y6ug==
X-Gm-Message-State: ABy/qLZbpJGlNoDp9ky54jZLzmY/akNQycXG927bRBpUboBm8SpiP0sg
        RImWMrIJe2/D5/TXs44gQDMRtMfCUGLVPrMzfnercg==
X-Google-Smtp-Source: APBJJlErVcX+Ik4XO5/KlFWmDEGZoTLojGYbsKtS8UiCJ27OUBAsWJyfkC+/J+sSmgRJ7V5OHUYvmA==
X-Received: by 2002:a05:6a00:2316:b0:67a:8fc7:1b57 with SMTP id h22-20020a056a00231600b0067a8fc71b57mr526737pfh.2.1689805604251;
        Wed, 19 Jul 2023 15:26:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x16-20020a62fb10000000b00682d79199e7sm3737563pfm.200.2023.07.19.15.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 15:26:43 -0700 (PDT)
Message-ID: <64b86323.620a0220.1294c.870f@mx.google.com>
Date:   Wed, 19 Jul 2023 15:26:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Kernel: v6.3.13
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.3.y baseline: 86 runs, 3 regressions (v6.3.13)
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

stable-rc/linux-6.3.y baseline: 86 runs, 3 regressions (v6.3.13)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

beagle-xm                | arm    | lab-baylibre  | gcc-10   | omap2plus_de=
fconfig          | 1          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.3.y/kern=
el/v6.3.13/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.13
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d1047d75f77afefd19b19ae33cde7ad67f3628c9 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b82d70c5ada6dfbc8ace4a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.13/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-c=
hromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.13/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-c=
hromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b82d70c5ada6dfbc8ac=
e4b
        failing since 8 days (last pass: v6.3.11-441-gb95b57082420, first f=
ail: v6.3.11-439-g4882b85b0b1d) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
beagle-xm                | arm    | lab-baylibre  | gcc-10   | omap2plus_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64b82f3942b582b0888ace1e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.13/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.13/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b82f3942b582b0888ac=
e1f
        new failure (last pass: v6.3.11-439-g4882b85b0b1d) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64b831e5f6babe528b8ace28

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.13/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.13/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b831e5f6babe528b8ac=
e29
        new failure (last pass: v6.3.11-439-g4882b85b0b1d) =

 =20
