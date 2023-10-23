Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A577D3E14
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 19:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjJWRno (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 13:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjJWRnn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 13:43:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9E3B0
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 10:43:39 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso3400813b3a.2
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698083019; x=1698687819; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+S7yOne0uOJAjlNhcm54AmOkE7FlSwVfgJUlTRe58BI=;
        b=rgk9URNnW1BlwvY0S3A3hEHD6O4NNHTaKCjQSw0yadh3mPPxBpH5UTP+RQIVmRDfKB
         dFz6eRH3MXEvW7LxZsyX8Aplw8bNXJgEWcQqTubvH7i/Y7DGHBHiGSKVmUnEShU/dzQx
         qGsXew7wUajwdvFvCf7+8nRx7r4N1/N0+B3r/8FICuVlpEFe7bJkCPCPG8zmMFwEXjqM
         no9ypmNuM9YfykaRODAGHvqL+64F2o4nK3nlrthe4MzeSmV4bwQFR+JizbUU5mtlT5r8
         xIxRKRNotWd9fT7dv9Vyo7LA88O6XSMDOtCsj2yuvJZmIDGGURnEwLAfCTlu2uSEpm+S
         MmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698083019; x=1698687819;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+S7yOne0uOJAjlNhcm54AmOkE7FlSwVfgJUlTRe58BI=;
        b=rME3QhBY1rN8wO3vZdG3A2ns4EnORGfCqM3lGQCG/JrsHaZzHp9xctl4sB1e2Cf0tm
         hYLBLSLW/roobr5OSYlTGXLu0GiRJ0yXkpl8yJO+SeAZ2HVVIuM/GunXBWxCvh5kJX4m
         hk3eqamIVDPNT/IegshW8RVtVpCmPlrWH0p+QqmBc3JR1RJU5+ejCJVx4cNDWTq7zD5y
         11Y9TGI8ZXyhALz4tmV6FadtNiy2sdPLwZuCSPnn4Qieej1J8xc75wrsOJPjX70TvqnY
         GixzhD+I1/9sI9rGNvOu5emleTBVAu2dMUHbOle8kZQ3GI5REVRRLXN9XrycQBDXy5OJ
         7TGQ==
X-Gm-Message-State: AOJu0YxdCKP/S55JBw+lKaR8xeEzWx3xOHqCmSoD8eY2WH4fv8tKMCpM
        kpco7mjMUT6g+2FJE68DMP3sCA9c4Ta2ILXadzY8Nw==
X-Google-Smtp-Source: AGHT+IFArT3jPsyS3+DUmt6Ej4WITt3B8CvgnqOFSesDZi+2tvqENkHwVOq+NYHacoEzpOteX1adbw==
X-Received: by 2002:a62:f20d:0:b0:68a:49bc:e0af with SMTP id m13-20020a62f20d000000b0068a49bce0afmr8759688pfh.1.1698083018826;
        Mon, 23 Oct 2023 10:43:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p7-20020aa79e87000000b006b2e07a6235sm6290310pfq.136.2023.10.23.10.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:43:37 -0700 (PDT)
Message-ID: <6536b0c9.a70a0220.16d13.24cf@mx.google.com>
Date:   Mon, 23 Oct 2023 10:43:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.135-239-gc7721f02ed5c
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.15.y baseline: 111 runs,
 12 regressions (v5.15.135-239-gc7721f02ed5c)
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

stable-rc/linux-5.15.y baseline: 111 runs, 12 regressions (v5.15.135-239-gc=
7721f02ed5c)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

kontron-pitx-imx8m        | arm64  | lab-kontron   | gcc-10   | defconfig  =
                  | 2          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64        | arm64  | lab-clabbe    | gcc-10   | defconfig  =
                  | 1          =

sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.135-239-gc7721f02ed5c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.135-239-gc7721f02ed5c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c7721f02ed5cc1071a744d6f041469e0ac0d6d91 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65367e22b01b5e1a19efcf03

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65367e22b01b5e1a19efcf0c
        failing since 208 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-23T14:07:17.141616  + set +x

    2023-10-23T14:07:17.147986  <8>[   10.602111] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11856296_1.4.2.3.1>

    2023-10-23T14:07:17.249949  / #

    2023-10-23T14:07:17.350829  # #export SHELL=3D/bin/sh

    2023-10-23T14:07:17.351580  =


    2023-10-23T14:07:17.452998  / # export SHELL=3D/bin/sh. /lava-11856296/=
environment

    2023-10-23T14:07:17.453941  =


    2023-10-23T14:07:17.555896  / # . /lava-11856296/environment/lava-11856=
296/bin/lava-test-runner /lava-11856296/1

    2023-10-23T14:07:17.556963  =


    2023-10-23T14:07:17.562837  / # /lava-11856296/bin/lava-test-runner /la=
va-11856296/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65367e388d304b324fefcf61

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65367e388d304b324fefcf6a
        failing since 208 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-23T14:07:39.237151  <8>[   10.593340] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11856364_1.4.2.3.1>

    2023-10-23T14:07:39.240297  + set +x

    2023-10-23T14:07:39.341756  =


    2023-10-23T14:07:39.442339  / # #export SHELL=3D/bin/sh

    2023-10-23T14:07:39.442558  =


    2023-10-23T14:07:39.543114  / # export SHELL=3D/bin/sh. /lava-11856364/=
environment

    2023-10-23T14:07:39.543326  =


    2023-10-23T14:07:39.643900  / # . /lava-11856364/environment/lava-11856=
364/bin/lava-test-runner /lava-11856364/1

    2023-10-23T14:07:39.644296  =


    2023-10-23T14:07:39.649457  / # /lava-11856364/bin/lava-test-runner /la=
va-11856364/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beagle-xm                 | arm    | lab-baylibre  | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65367fc3fc635bc855efcfd5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65367fc3fc635bc855efc=
fd6
        failing since 7 days (last pass: v5.15.133, first fail: v5.15.135-1=
03-gf11fc66f963f) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65367eaa2e7f5cb4e0efcf07

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65367eaa2e7f5cb4e0efcf10
        failing since 208 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-23T14:09:25.676483  <8>[   10.150895] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11856343_1.4.2.3.1>

    2023-10-23T14:09:25.679611  + set +x

    2023-10-23T14:09:25.786931  / # #

    2023-10-23T14:09:25.889182  export SHELL=3D/bin/sh

    2023-10-23T14:09:25.889876  #

    2023-10-23T14:09:25.991243  / # export SHELL=3D/bin/sh. /lava-11856343/=
environment

    2023-10-23T14:09:25.992027  =


    2023-10-23T14:09:26.093426  / # . /lava-11856343/environment/lava-11856=
343/bin/lava-test-runner /lava-11856343/1

    2023-10-23T14:09:26.094460  =


    2023-10-23T14:09:26.100048  / # /lava-11856343/bin/lava-test-runner /la=
va-11856343/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65367e1eec3944cc9cefcf20

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65367e1eec3944cc9cefcf29
        failing since 208 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-23T14:07:18.134997  + <8>[   10.798628] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11856307_1.4.2.3.1>

    2023-10-23T14:07:18.135181  set +x

    2023-10-23T14:07:18.240301  / # #

    2023-10-23T14:07:18.343070  export SHELL=3D/bin/sh

    2023-10-23T14:07:18.343801  #

    2023-10-23T14:07:18.445020  / # export SHELL=3D/bin/sh. /lava-11856307/=
environment

    2023-10-23T14:07:18.445250  =


    2023-10-23T14:07:18.545869  / # . /lava-11856307/environment/lava-11856=
307/bin/lava-test-runner /lava-11856307/1

    2023-10-23T14:07:18.546189  =


    2023-10-23T14:07:18.551215  / # /lava-11856307/bin/lava-test-runner /la=
va-11856307/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
kontron-pitx-imx8m        | arm64  | lab-kontron   | gcc-10   | defconfig  =
                  | 2          =


  Details:     https://kernelci.org/test/plan/id/65367f263b9c2ae479efd05b

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pi=
tx-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pi=
tx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65367f263b9c2ae479efd062
        new failure (last pass: v5.15.135-238-g07ec13925385)

    2023-10-23T14:11:38.070026  / # #
    2023-10-23T14:11:38.172240  export SHELL=3D/bin/sh
    2023-10-23T14:11:38.172948  #
    2023-10-23T14:11:38.274399  / # export SHELL=3D/bin/sh. /lava-388162/en=
vironment
    2023-10-23T14:11:38.275220  =

    2023-10-23T14:11:38.376718  / # . /lava-388162/environment/lava-388162/=
bin/lava-test-runner /lava-388162/1
    2023-10-23T14:11:38.377954  =

    2023-10-23T14:11:38.381713  / # /lava-388162/bin/lava-test-runner /lava=
-388162/1
    2023-10-23T14:11:38.444844  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-23T14:11:38.445274  + cd /l<8>[   12.135551] <LAVA_SIGNAL_START=
RUN 1_bootrr 388162_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/653=
67f263b9c2ae479efd072
        new failure (last pass: v5.15.135-238-g07ec13925385)

    2023-10-23T14:11:40.773880  /lava-388162/1/../bin/lava-test-case
    2023-10-23T14:11:40.774383  <8>[   14.559861] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>   =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65367e17ec3944cc9cefcf15

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65367e17ec3944cc9cefcf1e
        failing since 208 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-10-23T14:07:02.136897  <8>[   15.431689] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11856313_1.4.2.3.1>

    2023-10-23T14:07:02.245555  / # #

    2023-10-23T14:07:02.348079  export SHELL=3D/bin/sh

    2023-10-23T14:07:02.348842  #

    2023-10-23T14:07:02.450309  / # export SHELL=3D/bin/sh. /lava-11856313/=
environment

    2023-10-23T14:07:02.451169  =


    2023-10-23T14:07:02.552620  / # . /lava-11856313/environment/lava-11856=
313/bin/lava-test-runner /lava-11856313/1

    2023-10-23T14:07:02.553751  =


    2023-10-23T14:07:02.558424  / # /lava-11856313/bin/lava-test-runner /la=
va-11856313/1

    2023-10-23T14:07:02.564167  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (13 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a77960-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65367f233b9c2ae479efd03a

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65367f233b9c2ae479efd043
        failing since 95 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-10-23T14:15:45.167037  / # #

    2023-10-23T14:15:45.267540  export SHELL=3D/bin/sh

    2023-10-23T14:15:45.267642  #

    2023-10-23T14:15:45.368194  / # export SHELL=3D/bin/sh. /lava-11856390/=
environment

    2023-10-23T14:15:45.368300  =


    2023-10-23T14:15:45.468834  / # . /lava-11856390/environment/lava-11856=
390/bin/lava-test-runner /lava-11856390/1

    2023-10-23T14:15:45.469060  =


    2023-10-23T14:15:45.480846  / # /lava-11856390/bin/lava-test-runner /la=
va-11856390/1

    2023-10-23T14:15:45.523884  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-23T14:15:45.539864  + cd /lav<8>[   15.962817] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11856390_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a779m1-ulcb             | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65367f36102ddcea44efcf87

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65367f36102ddcea44efcf90
        failing since 95 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-10-23T14:14:34.668075  / # #

    2023-10-23T14:14:35.748569  export SHELL=3D/bin/sh

    2023-10-23T14:14:35.750485  #

    2023-10-23T14:14:37.240982  / # export SHELL=3D/bin/sh. /lava-11856392/=
environment

    2023-10-23T14:14:37.242923  =


    2023-10-23T14:14:39.966947  / # . /lava-11856392/environment/lava-11856=
392/bin/lava-test-runner /lava-11856392/1

    2023-10-23T14:14:39.969307  =


    2023-10-23T14:14:39.976568  / # /lava-11856392/bin/lava-test-runner /la=
va-11856392/1

    2023-10-23T14:14:40.042003  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-23T14:14:40.042505  + cd /lava-118563<8>[   25.540068] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11856392_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-clabbe    | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65367f163b9c2ae479efd007

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65367f163b9c2ae479efd010
        failing since 12 days (last pass: v5.15.105-194-g415a9d81c640, firs=
t fail: v5.15.135)

    2023-10-23T14:11:26.502852  / # #
    2023-10-23T14:11:26.604616  export SHELL=3D/bin/sh
    2023-10-23T14:11:26.605285  #
    2023-10-23T14:11:26.706434  / # export SHELL=3D/bin/sh. /lava-440137/en=
vironment
    2023-10-23T14:11:26.707272  =

    2023-10-23T14:11:26.808539  / # . /lava-440137/environment/lava-440137/=
bin/lava-test-runner /lava-440137/1
    2023-10-23T14:11:26.809789  =

    2023-10-23T14:11:26.812683  / # /lava-440137/bin/lava-test-runner /lava=
-440137/1
    2023-10-23T14:11:26.844758  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-23T14:11:26.886047  + cd /lava-440137/<8>[   16.616386] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 440137_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
sun50i-h6-pine-h64        | arm64  | lab-collabora | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65367f243b9c2ae479efd050

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-239-gc7721f02ed5c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65367f243b9c2ae479efd059
        failing since 12 days (last pass: v5.15.105-194-g415a9d81c640, firs=
t fail: v5.15.135)

    2023-10-23T14:15:57.260400  / # #

    2023-10-23T14:15:57.362566  export SHELL=3D/bin/sh

    2023-10-23T14:15:57.363272  #

    2023-10-23T14:15:57.464727  / # export SHELL=3D/bin/sh. /lava-11856399/=
environment

    2023-10-23T14:15:57.465431  =


    2023-10-23T14:15:57.566927  / # . /lava-11856399/environment/lava-11856=
399/bin/lava-test-runner /lava-11856399/1

    2023-10-23T14:15:57.568086  =


    2023-10-23T14:15:57.584718  / # /lava-11856399/bin/lava-test-runner /la=
va-11856399/1

    2023-10-23T14:15:57.643796  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-23T14:15:57.644348  + cd /lava-1185639<8>[   16.863920] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11856399_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
