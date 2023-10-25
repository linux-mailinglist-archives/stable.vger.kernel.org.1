Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB247D6776
	for <lists+stable@lfdr.de>; Wed, 25 Oct 2023 11:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjJYJtv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 05:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjJYJtu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 05:49:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2372EDD
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 02:49:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so5448730b3a.2
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 02:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698227387; x=1698832187; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2+VI1/nna5S11Z2MnXZ6BjEmqHW8DnblfTeVQ8ssaI0=;
        b=CU1UZ3XiZ8lPg4AiAuSzGHZDRjPll+nNFTAKxsP4NWjxG8iVvZkf1QuFPJNxRa23So
         vAB7E65qz21VK8DtKfBzn/CT+s8SlG8wLm0Ah5fw0m361j6L0AcI0SP7Jtx6rkCYiNxN
         GG6PTLCCgPAKNQKMDqKBUOs4GJ4Irumlf9SVHzgBMj1LbakLw3F0+bPQ4QgQ+HYgASyt
         kUJQpeRlNujHJsAUJ+zBo4RL/Nhl5CR/RWVmSGxspLu5KpXgnjr3Ps/Kuk4PgERN7oGt
         oHxEEDMwVHTIn8Da5Hn9HF/cCu36cxVkky9Cim7y0w6WtA5ULdxPf2aEyLLZu9plijX1
         jf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698227387; x=1698832187;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+VI1/nna5S11Z2MnXZ6BjEmqHW8DnblfTeVQ8ssaI0=;
        b=k9myelmtFyTlHZEoh/mO7DH3wCaFVQznpQWXQgvyNdoPMuWGV2dXtCdjV2CP2IulSf
         eEKT0PLptXjfJtc85Y/idVmbRGCqoMNA9ZNpM4l+9ocIxlym5UNgINRn7qktQSOGzh+g
         v82SgYuYXLisu2UoZnUshoiiR5GCafExeluNRxR/BRAFHI7ZzMZ6Rx1LO0sOTIYdFi2t
         FvhksHz7Gr+XHBZhv6NLVdyqOCm+RKRFOHBfrNRn2gv6+xH5kPowsbh48Odq9X9nIqR2
         kC+LaGFYTMweVOj1J+S9uJJe7xGLiOETea9+JxaB2K6Lq3IcSxI/Mm1fdCzadUvRLXjG
         3UJQ==
X-Gm-Message-State: AOJu0YwMtpDuvDzNY0CYaP7SN4OwFROjiMjs57Nn/l9j5RYTOjrtMnT9
        opFkHN7jNjTT/8EnmL3eojcrI4TipYOa5d/+M8Ujsw==
X-Google-Smtp-Source: AGHT+IH1zpQL1+8RkXoI1MIvG/IYPs+2nWsPwoMbr0OQXYsV9sx7EtLLesTWYlFRk+PwVGwMlihzSQ==
X-Received: by 2002:a05:6a00:1789:b0:6ba:4f2e:33ca with SMTP id s9-20020a056a00178900b006ba4f2e33camr18924028pfg.2.1698227387134;
        Wed, 25 Oct 2023 02:49:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e1-20020a630f01000000b005b856fab5e9sm8403444pgl.18.2023.10.25.02.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 02:49:46 -0700 (PDT)
Message-ID: <6538e4ba.630a0220.44953.c3ba@mx.google.com>
Date:   Wed, 25 Oct 2023 02:49:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.198-200-ge31b6513c43d
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.10.y baseline: 162 runs,
 2 regressions (v5.10.198-200-ge31b6513c43d)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 162 runs, 2 regressions (v5.10.198-200-ge3=
1b6513c43d)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig          | re=
gressions
----------------+-------+--------------+----------+--------------------+---=
---------
meson-gxbb-p200 | arm64 | lab-baylibre | gcc-10   | defconfig          | 1 =
         =

panda           | arm   | lab-baylibre | gcc-10   | multi_v7_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.198-200-ge31b6513c43d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.198-200-ge31b6513c43d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e31b6513c43d7f4efa2c5913dd7d4fbef162e736 =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig          | re=
gressions
----------------+-------+--------------+----------+--------------------+---=
---------
meson-gxbb-p200 | arm64 | lab-baylibre | gcc-10   | defconfig          | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/6538b0a3d6feff8a2cefcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-200-ge31b6513c43d/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxb=
b-p200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-200-ge31b6513c43d/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxb=
b-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6538b0a3d6feff8a2cefc=
efa
        new failure (last pass: v5.10.198-203-g38f629e2a1b6) =

 =



platform        | arch  | lab          | compiler | defconfig          | re=
gressions
----------------+-------+--------------+----------+--------------------+---=
---------
panda           | arm   | lab-baylibre | gcc-10   | multi_v7_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/6538b40258d09ad121efcf37

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-200-ge31b6513c43d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pa=
nda.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-200-ge31b6513c43d/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pa=
nda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6538b40258d09ad121efcf3f
        new failure (last pass: v5.10.148-5-gac0fb49345ee)

    2023-10-25T06:21:25.840605  <8>[   24.813537] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3812506_1.5.2.4.1>
    2023-10-25T06:21:25.947233  / # #
    2023-10-25T06:21:26.048527  export SHELL=3D/bin/sh
    2023-10-25T06:21:26.049010  #
    2023-10-25T06:21:26.149844  / # export SHELL=3D/bin/sh. /lava-3812506/e=
nvironment
    2023-10-25T06:21:26.150323  =

    2023-10-25T06:21:26.251137  / # . /lava-3812506/environment/lava-381250=
6/bin/lava-test-runner /lava-3812506/1
    2023-10-25T06:21:26.251750  =

    2023-10-25T06:21:26.257004  / # /lava-3812506/bin/lava-test-runner /lav=
a-3812506/1
    2023-10-25T06:21:26.315121  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
