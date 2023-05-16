Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AF07059BA
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 23:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjEPVoC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 17:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjEPVoB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 17:44:01 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003C459C4
        for <stable@vger.kernel.org>; Tue, 16 May 2023 14:43:58 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ab1ce53ca6so1295835ad.0
        for <stable@vger.kernel.org>; Tue, 16 May 2023 14:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684273438; x=1686865438;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c/lIA43Qz4sut0Ty4SiPvGcHVe881SBflWGNf+bAPmk=;
        b=PxMQW3KczgkYsUalcWk79z5s3bdOwD7jKUqBoEvX+HTo6r5JO5yldsc0tt0daCDkDk
         ZdifG98BPWQyEBYFXYPtmEY0WxkFc1KhiTxd0ri8+q3cg9C6CTNBi8J3mZYZymzwHNUf
         3jO3ckCF+jVgc8aQGesI43vpfrTtlDbyX6A69GNkNo5yiOYbM2vnNYkKMM9mf2czdmd1
         gnmRzqFH34PKWjJIsMpro8UjoB4Pn3Ih5MMQHQ2j+JibromS8cBuopv6tp8mVXnv/zrv
         DGWw1M8FxT2A3K8Oe/kpvE6WWh0whG8e65Ul00szx5HEa7LnSanWzKOhE58umEUFBjMQ
         rwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684273438; x=1686865438;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/lIA43Qz4sut0Ty4SiPvGcHVe881SBflWGNf+bAPmk=;
        b=RRcrRyn8EoyHiOLSq4cuRlUpyfnENNELdk1WI8Gd4vby15uPFlRnX+ZyNc1IJVuM24
         GRuMcG3jXpMua6NbUbyo1Tq80xq2jB6TN3zEh0IxE1/u8c4rzc+DWiUQLP3leeD4cQLM
         Ppz/o3GCxK/HfWoQn2gYUM7Hb7TEe9x6Nt7oJLOVS83OP/M3R9hW2QeWoP2UkZaIjHjC
         NFyhnrvDhDTSy0wEIVjLLQ4z6/cjcMWAF14uYN600ZqgtzNaWfgoWoATAYXIwm2NSEiD
         X71IMsevqqrfHF2ekLUSn2sLlhDb8nKjKz4LLmFloVAlahzIEOkMKrK2KujbTok2Dw4b
         43Ew==
X-Gm-Message-State: AC+VfDx3miC0UHX5xxr+RMjMdnkJg7isychFM2VAZvFv0CsvcFLFV7l6
        wRtHWn2rSXLnYYUxdqSLN1O2ojPNRcnuMB3v7G58yA==
X-Google-Smtp-Source: ACHHUZ5OXK+266iozZbYl9BlPs+eoGymXgZL3YH9KtoImkdwvhBuaCS46Coyrpuj09w2gXyxrxAqYw==
X-Received: by 2002:a17:902:a414:b0:1ae:4fbd:f626 with SMTP id p20-20020a170902a41400b001ae4fbdf626mr297862plq.52.1684273437904;
        Tue, 16 May 2023 14:43:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090276c100b001ab18eaf90esm15930537plt.158.2023.05.16.14.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 14:43:57 -0700 (PDT)
Message-ID: <6463f91d.170a0220.29297.f783@mx.google.com>
Date:   Tue, 16 May 2023 14:43:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.28-240-gb82733c0ff99
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 175 runs,
 11 regressions (v6.1.28-240-gb82733c0ff99)
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

stable-rc/linux-6.1.y baseline: 175 runs, 11 regressions (v6.1.28-240-gb827=
33c0ff99)

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

at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.28-240-gb82733c0ff99/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.28-240-gb82733c0ff99
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b82733c0ff99435bb7eb5ed4ea2e1c1fd69e7ebb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c52ddb9fa5aaf42e8639

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463c52ddb9fa5aaf42e863e
        failing since 47 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-16T18:01:54.214403  <8>[   10.831296] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10339018_1.4.2.3.1>

    2023-05-16T18:01:54.218041  + set +x

    2023-05-16T18:01:54.322503  / # #

    2023-05-16T18:01:54.423130  export SHELL=3D/bin/sh

    2023-05-16T18:01:54.423355  #

    2023-05-16T18:01:54.523994  / # export SHELL=3D/bin/sh. /lava-10339018/=
environment

    2023-05-16T18:01:54.524195  =


    2023-05-16T18:01:54.624684  / # . /lava-10339018/environment/lava-10339=
018/bin/lava-test-runner /lava-10339018/1

    2023-05-16T18:01:54.624989  =


    2023-05-16T18:01:54.630359  / # /lava-10339018/bin/lava-test-runner /la=
va-10339018/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c50d313224cc742e860d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463c50d313224cc742e8612
        failing since 47 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-16T18:01:31.841723  + set<8>[   11.572060] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10338983_1.4.2.3.1>

    2023-05-16T18:01:31.842206   +x

    2023-05-16T18:01:31.950320  / # #

    2023-05-16T18:01:32.052737  export SHELL=3D/bin/sh

    2023-05-16T18:01:32.053564  #

    2023-05-16T18:01:32.155209  / # export SHELL=3D/bin/sh. /lava-10338983/=
environment

    2023-05-16T18:01:32.156028  =


    2023-05-16T18:01:32.257729  / # . /lava-10338983/environment/lava-10338=
983/bin/lava-test-runner /lava-10338983/1

    2023-05-16T18:01:32.259054  =


    2023-05-16T18:01:32.263861  / # /lava-10338983/bin/lava-test-runner /la=
va-10338983/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c50b6f096e1a6b2e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463c50b6f096e1a6b2e860c
        failing since 47 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-16T18:01:43.188237  <8>[   11.177306] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10339023_1.4.2.3.1>

    2023-05-16T18:01:43.191441  + set +x

    2023-05-16T18:01:43.297558  =


    2023-05-16T18:01:43.399737  / # #export SHELL=3D/bin/sh

    2023-05-16T18:01:43.400385  =


    2023-05-16T18:01:43.501668  / # export SHELL=3D/bin/sh. /lava-10339023/=
environment

    2023-05-16T18:01:43.502361  =


    2023-05-16T18:01:43.603803  / # . /lava-10339023/environment/lava-10339=
023/bin/lava-test-runner /lava-10339023/1

    2023-05-16T18:01:43.605162  =


    2023-05-16T18:01:43.610435  / # /lava-10339023/bin/lava-test-runner /la=
va-10339023/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91-sama5d4_xplained        | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c8b3dd03d22a4a2e85ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-=
sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-=
sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6463c8b3dd03d22a4a2e8=
5ed
        new failure (last pass: v6.1.28-239-g553581e88bac) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c519660c9570a02e860f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463c519660c9570a02e8614
        failing since 47 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-16T18:01:45.014495  + set +x

    2023-05-16T18:01:45.021153  <8>[   11.041551] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10339011_1.4.2.3.1>

    2023-05-16T18:01:45.125802  / # #

    2023-05-16T18:01:45.226413  export SHELL=3D/bin/sh

    2023-05-16T18:01:45.226632  #

    2023-05-16T18:01:45.327224  / # export SHELL=3D/bin/sh. /lava-10339011/=
environment

    2023-05-16T18:01:45.327428  =


    2023-05-16T18:01:45.427985  / # . /lava-10339011/environment/lava-10339=
011/bin/lava-test-runner /lava-10339011/1

    2023-05-16T18:01:45.428344  =


    2023-05-16T18:01:45.432935  / # /lava-10339011/bin/lava-test-runner /la=
va-10339011/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c518660c9570a02e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463c518660c9570a02e8605
        failing since 47 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-16T18:01:41.127755  <8>[   10.621953] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10339017_1.4.2.3.1>

    2023-05-16T18:01:41.130969  + set +x

    2023-05-16T18:01:41.235137  / # #

    2023-05-16T18:01:41.335822  export SHELL=3D/bin/sh

    2023-05-16T18:01:41.336060  #

    2023-05-16T18:01:41.436530  / # export SHELL=3D/bin/sh. /lava-10339017/=
environment

    2023-05-16T18:01:41.436729  =


    2023-05-16T18:01:41.537244  / # . /lava-10339017/environment/lava-10339=
017/bin/lava-test-runner /lava-10339017/1

    2023-05-16T18:01:41.537549  =


    2023-05-16T18:01:41.542829  / # /lava-10339017/bin/lava-test-runner /la=
va-10339017/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c51a660c9570a02e861a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463c51a660c9570a02e861f
        failing since 47 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-16T18:01:41.476275  + set<8>[   11.211646] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10338968_1.4.2.3.1>

    2023-05-16T18:01:41.476361   +x

    2023-05-16T18:01:41.580565  / # #

    2023-05-16T18:01:41.681127  export SHELL=3D/bin/sh

    2023-05-16T18:01:41.681301  #

    2023-05-16T18:01:41.781826  / # export SHELL=3D/bin/sh. /lava-10338968/=
environment

    2023-05-16T18:01:41.781994  =


    2023-05-16T18:01:41.882518  / # . /lava-10338968/environment/lava-10338=
968/bin/lava-test-runner /lava-10338968/1

    2023-05-16T18:01:41.882749  =


    2023-05-16T18:01:41.887503  / # /lava-10338968/bin/lava-test-runner /la=
va-10338968/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c4f9d4eb012caf2e8644

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463c4f9d4eb012caf2e8649
        failing since 47 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-16T18:01:16.607202  <8>[   12.732069] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10338980_1.4.2.3.1>

    2023-05-16T18:01:16.715243  / # #

    2023-05-16T18:01:16.817334  export SHELL=3D/bin/sh

    2023-05-16T18:01:16.817964  #

    2023-05-16T18:01:16.919303  / # export SHELL=3D/bin/sh. /lava-10338980/=
environment

    2023-05-16T18:01:16.920008  =


    2023-05-16T18:01:17.021469  / # . /lava-10338980/environment/lava-10338=
980/bin/lava-test-runner /lava-10338980/1

    2023-05-16T18:01:17.022694  =


    2023-05-16T18:01:17.027427  / # /lava-10338980/bin/lava-test-runner /la=
va-10338980/1

    2023-05-16T18:01:17.033579  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6463c8bf85d56e3a1b2e8855

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6463c8bf85d56e3a1b2e8871
        failing since 5 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-05-16T18:17:23.796827  /lava-10339241/1/../bin/lava-test-case
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6463c8bf85d56e3a1b2e88fd
        failing since 5 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-05-16T18:17:18.360250  + set +x

    2023-05-16T18:17:18.366666  <8>[   17.512115] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10339241_1.5.2.3.1>

    2023-05-16T18:17:18.471749  / # #

    2023-05-16T18:17:18.572292  export SHELL=3D/bin/sh

    2023-05-16T18:17:18.572459  #

    2023-05-16T18:17:18.672986  / # export SHELL=3D/bin/sh. /lava-10339241/=
environment

    2023-05-16T18:17:18.673150  =


    2023-05-16T18:17:18.773670  / # . /lava-10339241/environment/lava-10339=
241/bin/lava-test-runner /lava-10339241/1

    2023-05-16T18:17:18.773985  =


    2023-05-16T18:17:18.779344  / # /lava-10339241/bin/lava-test-runner /la=
va-10339241/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6463c3bb085f89dde12e863e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28-=
240-gb82733c0ff99/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6463c3bb085f89dde12e8=
63f
        failing since 5 days (last pass: v6.1.27, first fail: v6.1.28) =

 =20
