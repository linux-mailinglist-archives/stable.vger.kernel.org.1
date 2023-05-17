Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AC9706CF1
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 17:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjEQPhC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 11:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEQPhB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 11:37:01 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D931F1713
        for <stable@vger.kernel.org>; Wed, 17 May 2023 08:36:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae408f4d1aso8255095ad.0
        for <stable@vger.kernel.org>; Wed, 17 May 2023 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684337817; x=1686929817;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3RWYnJyIAqkKOHNjnHC+OgRmBNqfuENlCmOjhE+MXfE=;
        b=d4k2POMmjE7w2Sj0WSAuWekkoccV7iABnUf0T+4zs4kSu5C/Q70rVQ+5jW+VlsAxQt
         05LXXKMV/7Ivd9D5vHU4yNBaQq+y5q7Nna8+YLAREphuepUAdv1sdPGI15zW851bW13W
         tTj9sVWw937+a+9fDrzS0ZNK8r5MRN46Iy60pI9tEY5uG01va2luT+uG48QNKFbiq12/
         2q7y9ELu4fj66rFtKWvdDny2c4Tuv47HVehcYuFmTtPi/hn/N+Njw6hcIz01Su/c4mIh
         q/kV3ShJzKY7hP9hWoL/NK/k4UXAjAZ2VQIpXXx3hmq8cfKLbovkmvH6oeU3wG2rmGR+
         //jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684337817; x=1686929817;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3RWYnJyIAqkKOHNjnHC+OgRmBNqfuENlCmOjhE+MXfE=;
        b=OJ/JV2ko4R0UE4ITwXzwiXf6SFZYwkfIBY4W0fC1bmHojE4arNy0+Yfx3UKcuBxyTn
         ehix+TLSb2t8bw/g4BqmCUKB81ZlE1wqZyrwuHtQI/UzDxJ1yHlbOgACPjrwWaH25VZc
         yd1cqRLy3MLoS+wJ3/U9X7LfcDdLhT8yH80Pqo3RIwWMBcy1wXsHz+lM7V5hJFDjYpo2
         N0TsL/WBnYFcLmi3w2hcSqzdGcUWuJV0FaFWaZBeIW6qnAOYSj0tZtkh2b8RnWzpEbQ7
         L4/zlfu0exfSy0mAcgkouMswvgurtkAOUKaRPs9sMcaNQEmBGUEOowAngcaQLn1Nkc5o
         obFg==
X-Gm-Message-State: AC+VfDzNtkPrDjW/YovmWybkYbG2OAeMJlyYrGlrzzuSTY0ZKQf3O4KD
        zzbUaj49zOkJsQ0X57C2y6dPfoGyN7UxNynHnijKvA==
X-Google-Smtp-Source: ACHHUZ5Z6fxLGCMBEQA7g2HpC2qyCDh1zrae5mthGWY3X+QfFYEUnD7I5H2epXDtGo57UlF7uqRDow==
X-Received: by 2002:a17:902:e882:b0:1aa:e30e:29d3 with SMTP id w2-20020a170902e88200b001aae30e29d3mr53270363plg.29.1684337816050;
        Wed, 17 May 2023 08:36:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090a890d00b0024dee5cbe29sm1737058pjn.27.2023.05.17.08.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:36:55 -0700 (PDT)
Message-ID: <6464f497.170a0220.258be.33f9@mx.google.com>
Date:   Wed, 17 May 2023 08:36:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v5.15.112
X-Kernelci-Report-Type: test
Subject: stable/linux-5.15.y baseline: 210 runs, 25 regressions (v5.15.112)
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

stable/linux-5.15.y baseline: 210 runs, 25 regressions (v5.15.112)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
am57xx-beagle-x15            | arm    | lab-linaro-lkft | gcc-10   | multi_=
v7_defconfig+kselftest | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm...ok+kselftest | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm...ok+kselftest | 4          =

qemu_x86_64                  | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.112/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.112
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      9d6bde853685609a631871d7c12be94fdf8d912e =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
am57xx-beagle-x15            | arm    | lab-linaro-lkft | gcc-10   | multi_=
v7_defconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6464bdbd62052fe43b2e85e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-linaro-lkft/baseline-am57xx-bea=
gle-x15.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-linaro-lkft/baseline-am57xx-bea=
gle-x15.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6464bdbd62052fe43b2e8=
5e8
        new failure (last pass: v5.15.111) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464be586febe36e772e85fe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464be586febe36e772e8603
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-17T11:45:11.624224  <8>[   11.025435] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10351214_1.4.2.3.1>

    2023-05-17T11:45:11.627562  + set +x

    2023-05-17T11:45:11.731746  / # #

    2023-05-17T11:45:11.832336  export SHELL=3D/bin/sh

    2023-05-17T11:45:11.832558  #

    2023-05-17T11:45:11.933122  / # export SHELL=3D/bin/sh. /lava-10351214/=
environment

    2023-05-17T11:45:11.933384  =


    2023-05-17T11:45:12.033984  / # . /lava-10351214/environment/lava-10351=
214/bin/lava-test-runner /lava-10351214/1

    2023-05-17T11:45:12.034262  =


    2023-05-17T11:45:12.039574  / # /lava-10351214/bin/lava-test-runner /la=
va-10351214/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c09df6df2106ab2e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c09df6df2106ab2e85f8
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-17T11:54:52.114981  + set +x

    2023-05-17T11:54:52.121853  <8>[   12.943375] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10351634_1.4.2.3.1>

    2023-05-17T11:54:52.226179  / # #

    2023-05-17T11:54:52.328887  export SHELL=3D/bin/sh

    2023-05-17T11:54:52.329759  #

    2023-05-17T11:54:52.431453  / # export SHELL=3D/bin/sh. /lava-10351634/=
environment

    2023-05-17T11:54:52.432229  =


    2023-05-17T11:54:52.533717  / # . /lava-10351634/environment/lava-10351=
634/bin/lava-test-runner /lava-10351634/1

    2023-05-17T11:54:52.535144  =


    2023-05-17T11:54:52.541042  / # /lava-10351634/bin/lava-test-runner /la=
va-10351634/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c57a8b6b9d11942e85fa

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c57a8b6b9d11942e85ff
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-17T12:15:48.451969  + set<8>[   11.465129] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10351288_1.4.2.3.1>

    2023-05-17T12:15:48.452412   +x

    2023-05-17T12:15:48.559677  / # #

    2023-05-17T12:15:48.661749  export SHELL=3D/bin/sh

    2023-05-17T12:15:48.662461  #

    2023-05-17T12:15:48.763836  / # export SHELL=3D/bin/sh. /lava-10351288/=
environment

    2023-05-17T12:15:48.764505  =


    2023-05-17T12:15:48.865814  / # . /lava-10351288/environment/lava-10351=
288/bin/lava-test-runner /lava-10351288/1

    2023-05-17T12:15:48.866608  =


    2023-05-17T12:15:48.871270  / # /lava-10351288/bin/lava-test-runner /la=
va-10351288/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c64263765941112e8601

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c64263765941112e8606
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-17T12:19:00.493142  + <8>[   11.946708] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10351608_1.4.2.3.1>

    2023-05-17T12:19:00.493270  set +x

    2023-05-17T12:19:00.597323  / # #

    2023-05-17T12:19:00.697961  export SHELL=3D/bin/sh

    2023-05-17T12:19:00.698200  #

    2023-05-17T12:19:00.798704  / # export SHELL=3D/bin/sh. /lava-10351608/=
environment

    2023-05-17T12:19:00.798971  =


    2023-05-17T12:19:00.899560  / # . /lava-10351608/environment/lava-10351=
608/bin/lava-test-runner /lava-10351608/1

    2023-05-17T12:19:00.899973  =


    2023-05-17T12:19:00.904465  / # /lava-10351608/bin/lava-test-runner /la=
va-10351608/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c25c4c8a29d7f22e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c25c4c8a29d7f22e85ec
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-17T12:02:21.818677  <8>[   10.694646] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10351272_1.4.2.3.1>

    2023-05-17T12:02:21.821671  + set +x

    2023-05-17T12:02:21.924588  =


    2023-05-17T12:02:22.026374  / # #export SHELL=3D/bin/sh

    2023-05-17T12:02:22.027147  =


    2023-05-17T12:02:22.128641  / # export SHELL=3D/bin/sh. /lava-10351272/=
environment

    2023-05-17T12:02:22.129425  =


    2023-05-17T12:02:22.230901  / # . /lava-10351272/environment/lava-10351=
272/bin/lava-test-runner /lava-10351272/1

    2023-05-17T12:02:22.232317  =


    2023-05-17T12:02:22.237254  / # /lava-10351272/bin/lava-test-runner /la=
va-10351272/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c2da903f0d89e92e85fc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c2da903f0d89e92e8601
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-17T12:04:25.500271  + set +x

    2023-05-17T12:04:25.506686  <8>[   11.010715] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10351600_1.4.2.3.1>

    2023-05-17T12:04:25.610946  / # #

    2023-05-17T12:04:25.711729  export SHELL=3D/bin/sh

    2023-05-17T12:04:25.711927  #

    2023-05-17T12:04:25.812440  / # export SHELL=3D/bin/sh. /lava-10351600/=
environment

    2023-05-17T12:04:25.812631  =


    2023-05-17T12:04:25.913141  / # . /lava-10351600/environment/lava-10351=
600/bin/lava-test-runner /lava-10351600/1

    2023-05-17T12:04:25.913403  =


    2023-05-17T12:04:25.918640  / # /lava-10351600/bin/lava-test-runner /la=
va-10351600/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c31698d9c2c05d2e8639

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c31698d9c2c05d2e863e
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-17T12:05:26.151859  + set +x

    2023-05-17T12:05:26.158838  <8>[   10.626189] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10351257_1.4.2.3.1>

    2023-05-17T12:05:26.263051  / # #

    2023-05-17T12:05:26.363866  export SHELL=3D/bin/sh

    2023-05-17T12:05:26.364092  #

    2023-05-17T12:05:26.464596  / # export SHELL=3D/bin/sh. /lava-10351257/=
environment

    2023-05-17T12:05:26.464836  =


    2023-05-17T12:05:26.565439  / # . /lava-10351257/environment/lava-10351=
257/bin/lava-test-runner /lava-10351257/1

    2023-05-17T12:05:26.565802  =


    2023-05-17T12:05:26.571036  / # /lava-10351257/bin/lava-test-runner /la=
va-10351257/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c356707f387ed52e864a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c356707f387ed52e864f
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-17T12:06:34.385669  + set +x

    2023-05-17T12:06:34.392360  <8>[   12.126691] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10351625_1.4.2.3.1>

    2023-05-17T12:06:34.496997  / # #

    2023-05-17T12:06:34.597589  export SHELL=3D/bin/sh

    2023-05-17T12:06:34.597786  #

    2023-05-17T12:06:34.698338  / # export SHELL=3D/bin/sh. /lava-10351625/=
environment

    2023-05-17T12:06:34.698531  =


    2023-05-17T12:06:34.799078  / # . /lava-10351625/environment/lava-10351=
625/bin/lava-test-runner /lava-10351625/1

    2023-05-17T12:06:34.799355  =


    2023-05-17T12:06:34.804118  / # /lava-10351625/bin/lava-test-runner /la=
va-10351625/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c2aba9a359990d2e8612

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c2aba9a359990d2e8617
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-17T12:03:36.072130  + set +x<8>[   10.831663] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10351287_1.4.2.3.1>

    2023-05-17T12:03:36.072238  =


    2023-05-17T12:03:36.174323  #

    2023-05-17T12:03:36.174702  =


    2023-05-17T12:03:36.275245  / # #export SHELL=3D/bin/sh

    2023-05-17T12:03:36.275434  =


    2023-05-17T12:03:36.376062  / # export SHELL=3D/bin/sh. /lava-10351287/=
environment

    2023-05-17T12:03:36.376323  =


    2023-05-17T12:03:36.476910  / # . /lava-10351287/environment/lava-10351=
287/bin/lava-test-runner /lava-10351287/1

    2023-05-17T12:03:36.477203  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c2c905899650c22e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c2c905899650c22e85ed
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-17T12:04:09.471635  + set +x

    2023-05-17T12:04:09.478520  <8>[   11.522571] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10351615_1.4.2.3.1>

    2023-05-17T12:04:09.582975  / # #

    2023-05-17T12:04:09.683649  export SHELL=3D/bin/sh

    2023-05-17T12:04:09.683871  #

    2023-05-17T12:04:09.784377  / # export SHELL=3D/bin/sh. /lava-10351615/=
environment

    2023-05-17T12:04:09.784595  =


    2023-05-17T12:04:09.885133  / # . /lava-10351615/environment/lava-10351=
615/bin/lava-test-runner /lava-10351615/1

    2023-05-17T12:04:09.885455  =


    2023-05-17T12:04:09.890913  / # /lava-10351615/bin/lava-test-runner /la=
va-10351615/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464be660866c2684a2e85ed

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464be660866c2684a2e85f2
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-17T11:45:20.870305  + <8>[   11.075970] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10351254_1.4.2.3.1>

    2023-05-17T11:45:20.870416  set +x

    2023-05-17T11:45:20.975024  / # #

    2023-05-17T11:45:21.075752  export SHELL=3D/bin/sh

    2023-05-17T11:45:21.076018  #

    2023-05-17T11:45:21.176481  / # export SHELL=3D/bin/sh. /lava-10351254/=
environment

    2023-05-17T11:45:21.176697  =


    2023-05-17T11:45:21.277245  / # . /lava-10351254/environment/lava-10351=
254/bin/lava-test-runner /lava-10351254/1

    2023-05-17T11:45:21.277620  =


    2023-05-17T11:45:21.282427  / # /lava-10351254/bin/lava-test-runner /la=
va-10351254/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c0a34b605463f22e85fa

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c0a34b605463f22e85ff
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-17T11:54:53.981260  + <8>[   12.255735] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10351654_1.4.2.3.1>

    2023-05-17T11:54:53.981390  set +x

    2023-05-17T11:54:54.086144  / # #

    2023-05-17T11:54:54.186804  export SHELL=3D/bin/sh

    2023-05-17T11:54:54.187011  #

    2023-05-17T11:54:54.287572  / # export SHELL=3D/bin/sh. /lava-10351654/=
environment

    2023-05-17T11:54:54.287780  =


    2023-05-17T11:54:54.388363  / # . /lava-10351654/environment/lava-10351=
654/bin/lava-test-runner /lava-10351654/1

    2023-05-17T11:54:54.388755  =


    2023-05-17T11:54:54.393785  / # /lava-10351654/bin/lava-test-runner /la=
va-10351654/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c32a98d9c2c05d2e8659

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c32a98d9c2c05d2e865e
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-17T12:05:44.309227  <8>[   12.004038] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10351226_1.4.2.3.1>

    2023-05-17T12:05:44.418061  / # #

    2023-05-17T12:05:44.521660  export SHELL=3D/bin/sh

    2023-05-17T12:05:44.521888  #

    2023-05-17T12:05:44.622721  / # export SHELL=3D/bin/sh. /lava-10351226/=
environment

    2023-05-17T12:05:44.623451  =


    2023-05-17T12:05:44.725001  / # . /lava-10351226/environment/lava-10351=
226/bin/lava-test-runner /lava-10351226/1

    2023-05-17T12:05:44.726183  =


    2023-05-17T12:05:44.731725  / # /lava-10351226/bin/lava-test-runner /la=
va-10351226/1

    2023-05-17T12:05:44.736914  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c379ad103c16f12e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c379ad103c16f12e85eb
        failing since 47 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-17T12:07:10.190083  + <8>[   12.165336] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10351613_1.4.2.3.1>

    2023-05-17T12:07:10.190203  set +x

    2023-05-17T12:07:10.294496  / # #

    2023-05-17T12:07:10.395149  export SHELL=3D/bin/sh

    2023-05-17T12:07:10.395353  #

    2023-05-17T12:07:10.495836  / # export SHELL=3D/bin/sh. /lava-10351613/=
environment

    2023-05-17T12:07:10.496065  =


    2023-05-17T12:07:10.596586  / # . /lava-10351613/environment/lava-10351=
613/bin/lava-test-runner /lava-10351613/1

    2023-05-17T12:07:10.596921  =


    2023-05-17T12:07:10.601524  / # /lava-10351613/bin/lava-test-runner /la=
va-10351613/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c48e8843a5c85d2e863e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6464c48e8843a5c85d2e8=
63f
        failing since 113 days (last pass: v5.15.89, first fail: v5.15.90) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/6464c1008a6b5309092e85fd

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6464c1008a6b5309092e860e
        failing since 5 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-05-17T11:56:25.185204  /lava-10351567/1/../bin/lava-test-case

    2023-05-17T11:56:25.191651  <8>[   61.541850] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6464c1008a6b5309092e860e
        failing since 5 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-05-17T11:56:25.185204  /lava-10351567/1/../bin/lava-test-case

    2023-05-17T11:56:25.191651  <8>[   61.541850] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6464c1008a6b5309092e8619
        failing since 5 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-05-17T11:56:24.144979  /lava-10351567/1/../bin/lava-test-case

    2023-05-17T11:56:24.151667  <8>[   60.501753] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c1018a6b5309092e86a1
        failing since 5 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-05-17T11:56:09.989225  + set +x

    2023-05-17T11:56:09.995864  <8>[   46.346423] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10351567_1.5.2.3.1>

    2023-05-17T11:56:10.099920  / # #

    2023-05-17T11:56:10.200724  export SHELL=3D/bin/sh

    2023-05-17T11:56:10.200926  #

    2023-05-17T11:56:10.301431  / # . /lava-10351567/environment

    2023-05-17T11:56:10.301637  export SHELL=3D/bin/sh

    2023-05-17T11:56:10.402157  / # . /lava-10351567/environment/lava-10351=
567/bin/lava-test-runner /lava-10351567/1

    2023-05-17T11:56:10.402481  =


    2023-05-17T11:56:10.407410  / # /lava-10351567/bin/lava-test-runner /la=
va-10351567/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm...ok+kselftest | 4          =


  Details:     https://kernelci.org/test/plan/id/6464c3c4db6e59b9ac2e85ea

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6464c3c4db6e59b9ac2e8604
        failing since 5 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-05-17T12:08:12.209528  /lava-10351832/1/../bin/lava-test-case

    2023-05-17T12:08:12.227891  <8>[   69.837607] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6464c3c4db6e59b9ac2e8604
        failing since 5 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-05-17T12:08:12.209528  /lava-10351832/1/../bin/lava-test-case

    2023-05-17T12:08:12.227891  <8>[   69.837607] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6464c3c4db6e59b9ac2e8606
        failing since 5 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-05-17T12:08:11.096845  /lava-10351832/1/../bin/lava-test-case

    2023-05-17T12:08:11.114758  <8>[   68.724785] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c3c4db6e59b9ac2e868e
        failing since 5 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-05-17T12:07:51.960244  + set +x<8>[   49.573965] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10351832_1.5.2.3.1>

    2023-05-17T12:07:51.963354  =


    2023-05-17T12:07:52.071353  / # #

    2023-05-17T12:07:52.172244  export SHELL=3D/bin/sh

    2023-05-17T12:07:52.172548  #

    2023-05-17T12:07:52.273162  / # export SHELL=3D/bin/sh. /lava-10351832/=
environment

    2023-05-17T12:07:52.273517  =


    2023-05-17T12:07:52.374234  / # . /lava-10351832/environment/lava-10351=
832/bin/lava-test-runner /lava-10351832/1

    2023-05-17T12:07:52.374805  =


    2023-05-17T12:07:52.379404  / # /lava-10351832/bin/lava-test-runner /la=
va-10351832/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_x86_64                  | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464bf574342132bdf2e8603

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-qemu_x=
86_64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.112/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-qemu_x=
86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6464bf574342132bdf2e8=
604
        new failure (last pass: v5.15.111) =

 =20
