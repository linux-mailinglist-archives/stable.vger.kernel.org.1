Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF4871424D
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 05:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjE2DYu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 23:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjE2DYr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 23:24:47 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70565C4
        for <stable@vger.kernel.org>; Sun, 28 May 2023 20:24:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2565b864f9aso705994a91.1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 20:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685330682; x=1687922682;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F+h7qL/0N8BtaC1jBCuwAGZIHhHD9qdmgeVs+KYCZaw=;
        b=wHzpnC1WBNBp+Jvb2LXBaR0yHH7QPScj0ds8E/5oKmAP6quCJNja7VB2dKXrfj7uf5
         ZLB7JfJ82O5Vly/YpgZhvG/DUlDJuhMXxnhxOieqL5RpHbZ8Yw1DhGI8nVSDvZrMZxz3
         9jgQpvUKwgiuoH8YvenCbvcr3Y/c0N7DBXKraOKGja8I+yUS0bJ0+QSB94ZBIjZFh7tI
         gkp9m7/+uSSNkhw6LFR4dj3CTboElWXjURnE/vELr7e1ZnEK8LeiS62kluGhiJZF9sGu
         R7y+10qJBJnswuqnguPBtg4WBD+S0DxGi7mxab0rBfSXBnoFrMbHXouji/8+yyUgvd4e
         jRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685330682; x=1687922682;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+h7qL/0N8BtaC1jBCuwAGZIHhHD9qdmgeVs+KYCZaw=;
        b=YTtF9TGRJd1XDU+RWrRyGCb6zLJqVy9yAJvefa7A1UGW9cmNu2zEBEd9/Vgz8jMd10
         322df7H8RoC39EIuhdSGFHNcOmk5Glln1uEGUC6I2r2oBO+/kcWzdfPvaUEiTJ3uO+1f
         chCrWJvx+YRCLVWBfj9AzaFvUbosQY8Q6IGQIjagftqhOcr9NOcF2TtiME8FAEaqCQE9
         hQ3n+5UT2384SJgXfBSRhR+N2MGBnJtVvRn7tXhPV1rGlaFyXNcytewjR5gsaetPajoX
         qkFIVk4A5PGdpn8hi0JoTRiJ12sUYHozmwTPgEI5T6+5oEDMdu8ZfDR6veVz187jYzLg
         er4A==
X-Gm-Message-State: AC+VfDyowJlm3i0j+Bj4dPzCYAYCs5OZGYVfdsHzSkWHSDybjROKzuBB
        PA9RpmA5pITHtkhcgDrPSf/UlTIIhUM/bGjix2GTMQ==
X-Google-Smtp-Source: ACHHUZ5aQWy85FsJaPfEKlqS+J2SH+/i6N50bDR4kfOuLCnWMfagmNmC3E6b3SSJaqTg/u1Cy3AxFQ==
X-Received: by 2002:a17:90b:3115:b0:255:83b6:2d0b with SMTP id gc21-20020a17090b311500b0025583b62d0bmr10480983pjb.17.1685330681999;
        Sun, 28 May 2023 20:24:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w123-20020a636281000000b00528b78ddbcesm6091227pgb.70.2023.05.28.20.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 20:24:41 -0700 (PDT)
Message-ID: <64741af9.630a0220.738c6.b86d@mx.google.com>
Date:   Sun, 28 May 2023 20:24:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29-413-g8482df0ff7e7
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 147 runs,
 7 regressions (v6.1.29-413-g8482df0ff7e7)
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

stable-rc/linux-6.1.y baseline: 147 runs, 7 regressions (v6.1.29-413-g8482d=
f0ff7e7)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.29-413-g8482df0ff7e7/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.29-413-g8482df0ff7e7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      8482df0ff7e727d4244b8bf8537cce39a474eefc =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e6473cbba7ed5f2e8633

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g8482df0ff7e7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g8482df0ff7e7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e6473cbba7ed5f2e8638
        failing since 59 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-28T23:39:28.571533  <8>[   10.877194] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10500506_1.4.2.3.1>

    2023-05-28T23:39:28.575043  + set +x

    2023-05-28T23:39:28.676527  / #

    2023-05-28T23:39:28.777426  # #export SHELL=3D/bin/sh

    2023-05-28T23:39:28.777680  =


    2023-05-28T23:39:28.878228  / # export SHELL=3D/bin/sh. /lava-10500506/=
environment

    2023-05-28T23:39:28.878457  =


    2023-05-28T23:39:28.978994  / # . /lava-10500506/environment/lava-10500=
506/bin/lava-test-runner /lava-10500506/1

    2023-05-28T23:39:28.979306  =


    2023-05-28T23:39:28.984962  / # /lava-10500506/bin/lava-test-runner /la=
va-10500506/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e5faf7892a05852e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g8482df0ff7e7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g8482df0ff7e7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e5faf7892a05852e85ed
        failing since 59 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-28T23:38:18.521808  + set<8>[   11.218401] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10500454_1.4.2.3.1>

    2023-05-28T23:38:18.521952   +x

    2023-05-28T23:38:18.626316  / # #

    2023-05-28T23:38:18.726978  export SHELL=3D/bin/sh

    2023-05-28T23:38:18.727192  #

    2023-05-28T23:38:18.827840  / # export SHELL=3D/bin/sh. /lava-10500454/=
environment

    2023-05-28T23:38:18.828067  =


    2023-05-28T23:38:18.928635  / # . /lava-10500454/environment/lava-10500=
454/bin/lava-test-runner /lava-10500454/1

    2023-05-28T23:38:18.928916  =


    2023-05-28T23:38:18.933678  / # /lava-10500454/bin/lava-test-runner /la=
va-10500454/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e5f7db760efdb32e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g8482df0ff7e7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g8482df0ff7e7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e5f7db760efdb32e85eb
        failing since 59 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-28T23:38:11.577961  <8>[   10.149266] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10500518_1.4.2.3.1>

    2023-05-28T23:38:11.581551  + set +x

    2023-05-28T23:38:11.682876  =


    2023-05-28T23:38:11.783408  / # #export SHELL=3D/bin/sh

    2023-05-28T23:38:11.783575  =


    2023-05-28T23:38:11.884050  / # export SHELL=3D/bin/sh. /lava-10500518/=
environment

    2023-05-28T23:38:11.884216  =


    2023-05-28T23:38:11.984688  / # . /lava-10500518/environment/lava-10500=
518/bin/lava-test-runner /lava-10500518/1

    2023-05-28T23:38:11.984953  =


    2023-05-28T23:38:11.990165  / # /lava-10500518/bin/lava-test-runner /la=
va-10500518/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e68725a05bce292e861d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g8482df0ff7e7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g8482df0ff7e7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e68725a05bce292e8622
        failing since 59 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-28T23:37:47.252150  + set +x

    2023-05-28T23:37:47.258609  <8>[   11.090362] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10500492_1.4.2.3.1>

    2023-05-28T23:37:47.363141  / # #

    2023-05-28T23:37:47.463697  export SHELL=3D/bin/sh

    2023-05-28T23:37:47.463938  #

    2023-05-28T23:37:47.564515  / # export SHELL=3D/bin/sh. /lava-10500492/=
environment

    2023-05-28T23:37:47.564752  =


    2023-05-28T23:37:47.665334  / # . /lava-10500492/environment/lava-10500=
492/bin/lava-test-runner /lava-10500492/1

    2023-05-28T23:37:47.665722  =


    2023-05-28T23:37:47.670602  / # /lava-10500492/bin/lava-test-runner /la=
va-10500492/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e5d0e0a21625912e8612

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g8482df0ff7e7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g8482df0ff7e7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e5d0e0a21625912e8617
        failing since 59 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-28T23:37:40.158573  <8>[   10.525475] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10500487_1.4.2.3.1>

    2023-05-28T23:37:40.161724  + set +x

    2023-05-28T23:37:40.262871  /#

    2023-05-28T23:37:40.363824   # #export SHELL=3D/bin/sh

    2023-05-28T23:37:40.364012  =


    2023-05-28T23:37:40.464493  / # export SHELL=3D/bin/sh. /lava-10500487/=
environment

    2023-05-28T23:37:40.464764  =


    2023-05-28T23:37:40.565378  / # . /lava-10500487/environment/lava-10500=
487/bin/lava-test-runner /lava-10500487/1

    2023-05-28T23:37:40.565822  =


    2023-05-28T23:37:40.571164  / # /lava-10500487/bin/lava-test-runner /la=
va-10500487/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e5e8f720d94df22e8625

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g8482df0ff7e7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g8482df0ff7e7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e5e8f720d94df22e862a
        failing since 59 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-28T23:37:55.798673  + set<8>[   10.920885] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10500484_1.4.2.3.1>

    2023-05-28T23:37:55.798762   +x

    2023-05-28T23:37:55.903792  / # #

    2023-05-28T23:37:56.004402  export SHELL=3D/bin/sh

    2023-05-28T23:37:56.004589  #

    2023-05-28T23:37:56.105244  / # export SHELL=3D/bin/sh. /lava-10500484/=
environment

    2023-05-28T23:37:56.105443  =


    2023-05-28T23:37:56.206076  / # . /lava-10500484/environment/lava-10500=
484/bin/lava-test-runner /lava-10500484/1

    2023-05-28T23:37:56.206363  =


    2023-05-28T23:37:56.210954  / # /lava-10500484/bin/lava-test-runner /la=
va-10500484/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473e68925a05bce292e8636

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g8482df0ff7e7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g8482df0ff7e7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473e68925a05bce292e863b
        failing since 59 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-28T23:37:46.919900  + set<8>[   12.260528] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10500471_1.4.2.3.1>

    2023-05-28T23:37:46.919983   +x

    2023-05-28T23:37:47.024043  / # #

    2023-05-28T23:37:47.124619  export SHELL=3D/bin/sh

    2023-05-28T23:37:47.124768  #

    2023-05-28T23:37:47.225254  / # export SHELL=3D/bin/sh. /lava-10500471/=
environment

    2023-05-28T23:37:47.225421  =


    2023-05-28T23:37:47.325938  / # . /lava-10500471/environment/lava-10500=
471/bin/lava-test-runner /lava-10500471/1

    2023-05-28T23:37:47.326238  =


    2023-05-28T23:37:47.330970  / # /lava-10500471/bin/lava-test-runner /la=
va-10500471/1
 =

    ... (12 line(s) more)  =

 =20
