Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00117E2FDB
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 23:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjKFWcK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 17:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjKFWcK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 17:32:10 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20A41BC
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 14:32:06 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b2e73a17a0so3242581b6e.3
        for <stable@vger.kernel.org>; Mon, 06 Nov 2023 14:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699309925; x=1699914725; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xA5DmtkNK5PcVwkgEahEhmqOQ3w8aC0JjAZQYEHdrO4=;
        b=2MOaYkF4KfX0BBm0OLpA6DyAFnnjCFgfX18HOek5ztqbJtlfg07XEL79m+Q5TS+pFR
         X2CbQIIZPOGT/HSkj1adPAV0o8LPMZgmTwFW4atImbX5Pw6PKsCkVfHFGgp5KU59j+hl
         Jz3vTnW6QvwOG4tDgOGKmUeZ0ehJhN041riknu6Z6bIoP52NDRf6lGWQkzpwXi3stInl
         IJFsy0ujzQ2eVgstDm+fOjiu6INce4WWwmXkkuHncZiGl136ZPE1I4bjf9VZfglBV7A5
         FioDZtAgWzJRGSfscNt1f4wQold/q9wDqal3OAvAt/O1vtNlPeK/2UxZM0XbUgO2c/KU
         LMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699309925; x=1699914725;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xA5DmtkNK5PcVwkgEahEhmqOQ3w8aC0JjAZQYEHdrO4=;
        b=o3mu1Azr3VEKZLrPlqQJeiUL3kekSxkuhLBRG8wla5Xn/7oKPIHKli5FDx4XGoe93G
         ZYzftpsKzSLHAghKuksMMLqMO6ZF7j8rzgrdZLB8WsP3tZAifI23KWe/RrJM4ebDsKNg
         x5BDMxkcdVBHKePp+8fSZFoMJM7B/6I0i6SwXisDqZde7OpYsU1PiaSvUUofnhNR7xK0
         SJSLFp27p/gPctJEmhKESJP0K4OFiCxYDjjm0Rh218MQGV4LKDct578Oftkn+cbq/JcU
         1ajT5ay0ND0t7qameOvSkjcL6EjARhPfcGRxQ1l78lSWhqHvhdoWoOsa08EPUFmEdvsm
         yw5g==
X-Gm-Message-State: AOJu0Ywgbb2zxxoN49vHJ7QBkpDU8M/RPpkw2zvezimZvjeBdHiBBhWq
        bROJv79zYKUEKnKpIoCvU03Ay4nbGyWIPl/ueSThNw==
X-Google-Smtp-Source: AGHT+IGMGhjw46nuci03xnCPDZH+AQro2kPclcuVNW/AwuvVn6fvhsJs3X1z5JzV1Rgb/lVs9MLBdA==
X-Received: by 2002:a05:6808:2105:b0:3ae:2362:7137 with SMTP id r5-20020a056808210500b003ae23627137mr38225498oiw.59.1699309925656;
        Mon, 06 Nov 2023 14:32:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h15-20020a056a00218f00b00690ca4356f1sm6012625pfi.198.2023.11.06.14.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:32:04 -0800 (PST)
Message-ID: <65496964.050a0220.9bc6f.dd98@mx.google.com>
Date:   Mon, 06 Nov 2023 14:32:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.199-96-gfed6441dbe524
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.10.y baseline: 152 runs,
 2 regressions (v5.10.199-96-gfed6441dbe524)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 152 runs, 2 regressions (v5.10.199-96-gfed=
6441dbe524)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.199-96-gfed6441dbe524/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.199-96-gfed6441dbe524
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      fed6441dbe524de2cf3a6a40d5d65c369bf583a0 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6549367b5716947be1efcf89

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
99-96-gfed6441dbe524/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
99-96-gfed6441dbe524/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6549367b5716947be1efcf92
        failing since 26 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-06T18:54:24.985357  <8>[   16.934667] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 443029_1.5.2.4.1>
    2023-11-06T18:54:25.090403  / # #
    2023-11-06T18:54:25.192134  export SHELL=3D/bin/sh
    2023-11-06T18:54:25.192909  #
    2023-11-06T18:54:25.294063  / # export SHELL=3D/bin/sh. /lava-443029/en=
vironment
    2023-11-06T18:54:25.294757  =

    2023-11-06T18:54:25.395947  / # . /lava-443029/environment/lava-443029/=
bin/lava-test-runner /lava-443029/1
    2023-11-06T18:54:25.397064  =

    2023-11-06T18:54:25.400425  / # /lava-443029/bin/lava-test-runner /lava=
-443029/1
    2023-11-06T18:54:25.468861  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65493683ec1bd0ef86efcefe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
99-96-gfed6441dbe524/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
99-96-gfed6441dbe524/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65493683ec1bd0ef86efcf07
        failing since 26 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-06T19:01:16.663939  / # #

    2023-11-06T19:01:16.765985  export SHELL=3D/bin/sh

    2023-11-06T19:01:16.766664  #

    2023-11-06T19:01:16.867975  / # export SHELL=3D/bin/sh. /lava-11956273/=
environment

    2023-11-06T19:01:16.868679  =


    2023-11-06T19:01:16.970129  / # . /lava-11956273/environment/lava-11956=
273/bin/lava-test-runner /lava-11956273/1

    2023-11-06T19:01:16.971206  =


    2023-11-06T19:01:16.988129  / # /lava-11956273/bin/lava-test-runner /la=
va-11956273/1

    2023-11-06T19:01:17.029706  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-06T19:01:17.047268  + cd /lava-1195627<8>[   18.282577] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11956273_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
