Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108BE72CC15
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 19:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbjFLRIq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 13:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbjFLRIm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 13:08:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3D8171A
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:08:28 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-65311774e52so3509626b3a.3
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686589708; x=1689181708;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gF0xnrnMikcAk9zKnoh7neTH2i5FN5+ZRy5MEUMkgjQ=;
        b=OrBG3YJE7sqWyI84OIVRdIgvredhxIc01P4dZ25aKNjP0djwUwFnyBQRrE8kCaoH72
         aKMEVGlsKhB1fnGGNy/fA5340Yzbd6PAIyeFDPKuhZ47zppDR5RE15PqiYyYxKlaXDst
         EpRg3iYGyYEt+lDUaNs6fU5G7oUotAlBRi5QdTr5dToVKg7A7o3+0h0mFugDQlYsLTIC
         PR5xwGwuGuDGJoMltvanTILGk7zmUuntC2rZmRFafoBBni04enCmcFDVmSNmgSh/Z75+
         J6rri/qzouKNLdL1u+K23mBQSl7HaR+JGNHwMFrC7a8LOz5oKUZz09GRMANMXEz/5vL1
         ld7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686589708; x=1689181708;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gF0xnrnMikcAk9zKnoh7neTH2i5FN5+ZRy5MEUMkgjQ=;
        b=jqE5smHFBEVcCJug8v5tC2tm81YtBSirhIZ6LlSAV8ieJNUz7XlclxmdzRlMnk8Fh4
         6b7j37A/MCDYtXtYV0ea92bbehOp8bee91mTFhbvK55pOwIcggMf+jEvpjh1lDEpWSbm
         xZYV9KvLoTec3L4lSEGrgJ6SYLqHC6OMtbE/k85d0z8C+KQNDHuaBiMAyCVSY0mzPT2q
         lp0aEkhAxjoZgaursshkdPQLg0qCgKPxbLTiMkMjXljZPVfx8MOUTWt8h88Ozfr+iVhi
         6z5jxp0AC8ZQGNSIzcxnKmmn5dreTqNDeFYPqJxRpoRq0w5+6w9iDy+i3L91x49sqHxB
         +fZg==
X-Gm-Message-State: AC+VfDyiKxbj4YTsr0Lk1QJkytGCBAmZMtp7NgyvUgQ9PJy5/6WSAE4D
        8IBDguvyd1IPjcu0g6LuUYQO1fDu0SsUbpWV4WlbgA==
X-Google-Smtp-Source: ACHHUZ7+VjYWhe4KJ5Ev1FZGTgFomNFZyHXxNHGDPKMhG9kpw7vfy3T6PejwGLIVa6dLd3FA8pmcFQ==
X-Received: by 2002:a05:6a00:2309:b0:648:8c0d:6e4e with SMTP id h9-20020a056a00230900b006488c0d6e4emr12337932pfh.19.1686589707336;
        Mon, 12 Jun 2023 10:08:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x7-20020aa793a7000000b0065da94fe917sm5309018pff.36.2023.06.12.10.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:08:26 -0700 (PDT)
Message-ID: <6487510a.a70a0220.e1555.9f40@mx.google.com>
Date:   Mon, 12 Jun 2023 10:08:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.33-133-g08f336c8c68d
Subject: stable-rc/linux-6.1.y baseline: 119 runs,
 10 regressions (v6.1.33-133-g08f336c8c68d)
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

stable-rc/linux-6.1.y baseline: 119 runs, 10 regressions (v6.1.33-133-g08f3=
36c8c68d)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.33-133-g08f336c8c68d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.33-133-g08f336c8c68d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      08f336c8c68dd7cec1d536063754c10805a7d5b4 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64871b906e8a249699306150

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871b906e8a249699306155
        failing since 73 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-12T13:19:55.829303  <6>[   11.048833] sh (236) used greatest st=
ack depth: 13248 bytes left

    2023-06-12T13:19:55.829389  + set +x

    2023-06-12T13:19:55.836201  <8>[   11.055890] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10690504_1.4.2.3.1>

    2023-06-12T13:19:55.940270  / # #

    2023-06-12T13:19:56.040958  export SHELL=3D/bin/sh

    2023-06-12T13:19:56.041172  #

    2023-06-12T13:19:56.141727  / # export SHELL=3D/bin/sh. /lava-10690504/=
environment

    2023-06-12T13:19:56.141977  =


    2023-06-12T13:19:56.242496  / # . /lava-10690504/environment/lava-10690=
504/bin/lava-test-runner /lava-10690504/1

    2023-06-12T13:19:56.242777  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64871b93c3c9154424306188

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871b93c3c915442430618d
        failing since 73 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-12T13:19:58.877684  + set +x<8>[   11.563014] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10690535_1.4.2.3.1>

    2023-06-12T13:19:58.877778  =


    2023-06-12T13:19:58.982369  / # #

    2023-06-12T13:19:59.085353  export SHELL=3D/bin/sh

    2023-06-12T13:19:59.086105  #

    2023-06-12T13:19:59.187714  / # export SHELL=3D/bin/sh. /lava-10690535/=
environment

    2023-06-12T13:19:59.188565  =


    2023-06-12T13:19:59.290167  / # . /lava-10690535/environment/lava-10690=
535/bin/lava-test-runner /lava-10690535/1

    2023-06-12T13:19:59.291461  =


    2023-06-12T13:19:59.296663  / # /lava-10690535/bin/lava-test-runner /la=
va-10690535/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64871b2e14a315ac36306149

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871b2e14a315ac3630614e
        failing since 73 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-12T13:18:27.087203  <8>[   10.631902] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10690515_1.4.2.3.1>

    2023-06-12T13:18:27.091223  + set +x

    2023-06-12T13:18:27.197133  #

    2023-06-12T13:18:27.198257  =


    2023-06-12T13:18:27.300230  / # #export SHELL=3D/bin/sh

    2023-06-12T13:18:27.301036  =


    2023-06-12T13:18:27.403072  / # export SHELL=3D/bin/sh. /lava-10690515/=
environment

    2023-06-12T13:18:27.403884  =


    2023-06-12T13:18:27.505632  / # . /lava-10690515/environment/lava-10690=
515/bin/lava-test-runner /lava-10690515/1

    2023-06-12T13:18:27.507019  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64871da858aa8ba9d430614a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64871da858aa8ba9d4306=
14b
        failing since 4 days (last pass: v6.1.31-40-g7d0a9678d276, first fa=
il: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64871b75bce04722ce30615b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871b75bce04722ce306160
        failing since 73 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-12T13:19:46.192842  + set +x

    2023-06-12T13:19:46.199427  <8>[   13.036823] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10690462_1.4.2.3.1>

    2023-06-12T13:19:46.303666  / # #

    2023-06-12T13:19:46.404427  export SHELL=3D/bin/sh

    2023-06-12T13:19:46.404671  #

    2023-06-12T13:19:46.505269  / # export SHELL=3D/bin/sh. /lava-10690462/=
environment

    2023-06-12T13:19:46.505521  =


    2023-06-12T13:19:46.606109  / # . /lava-10690462/environment/lava-10690=
462/bin/lava-test-runner /lava-10690462/1

    2023-06-12T13:19:46.606422  =


    2023-06-12T13:19:46.610944  / # /lava-10690462/bin/lava-test-runner /la=
va-10690462/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64871b3ade02eb4fac306137

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871b3ade02eb4fac30613c
        failing since 73 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-12T13:18:32.558780  <8>[   10.666035] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10690525_1.4.2.3.1>

    2023-06-12T13:18:32.561832  + set +x

    2023-06-12T13:18:32.666318  / # #

    2023-06-12T13:18:32.766981  export SHELL=3D/bin/sh

    2023-06-12T13:18:32.767257  #

    2023-06-12T13:18:32.867771  / # export SHELL=3D/bin/sh. /lava-10690525/=
environment

    2023-06-12T13:18:32.867952  =


    2023-06-12T13:18:32.968436  / # . /lava-10690525/environment/lava-10690=
525/bin/lava-test-runner /lava-10690525/1

    2023-06-12T13:18:32.968757  =


    2023-06-12T13:18:32.973488  / # /lava-10690525/bin/lava-test-runner /la=
va-10690525/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64871b53fb04736283306140

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871b53fb04736283306145
        failing since 73 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-12T13:18:53.579125  + set<8>[   11.016199] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10690495_1.4.2.3.1>

    2023-06-12T13:18:53.579552   +x

    2023-06-12T13:18:53.686744  / # #

    2023-06-12T13:18:53.788619  export SHELL=3D/bin/sh

    2023-06-12T13:18:53.788814  #

    2023-06-12T13:18:53.889314  / # export SHELL=3D/bin/sh. /lava-10690495/=
environment

    2023-06-12T13:18:53.889565  =


    2023-06-12T13:18:53.990240  / # . /lava-10690495/environment/lava-10690=
495/bin/lava-test-runner /lava-10690495/1

    2023-06-12T13:18:53.991645  =


    2023-06-12T13:18:53.996107  / # /lava-10690495/bin/lava-test-runner /la=
va-10690495/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6487198056bd541f5b306177

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-im=
x6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-im=
x6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6487198056bd541f5b30617c
        new failure (last pass: v6.1.33)

    2023-06-12T13:11:04.195746  + set[   14.973774] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 974497_1.5.2.3.1>
    2023-06-12T13:11:04.195895   +x
    2023-06-12T13:11:04.301827  / # #
    2023-06-12T13:11:04.403518  export SHELL=3D/bin/sh
    2023-06-12T13:11:04.404014  #
    2023-06-12T13:11:04.505322  / # export SHELL=3D/bin/sh. /lava-974497/en=
vironment
    2023-06-12T13:11:04.505809  =

    2023-06-12T13:11:04.607232  / # . /lava-974497/environment/lava-974497/=
bin/lava-test-runner /lava-974497/1
    2023-06-12T13:11:04.608111  =

    2023-06-12T13:11:04.611023  / # /lava-974497/bin/lava-test-runner /lava=
-974497/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64871b2f1adb1c6ff130612f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64871b2f1adb1c6ff1306134
        failing since 73 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-12T13:18:26.375112  <8>[    8.929965] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10690530_1.4.2.3.1>

    2023-06-12T13:18:26.483515  / # #

    2023-06-12T13:18:26.586071  export SHELL=3D/bin/sh

    2023-06-12T13:18:26.586901  #

    2023-06-12T13:18:26.688328  / # export SHELL=3D/bin/sh. /lava-10690530/=
environment

    2023-06-12T13:18:26.688682  =


    2023-06-12T13:18:26.789490  / # . /lava-10690530/environment/lava-10690=
530/bin/lava-test-runner /lava-10690530/1

    2023-06-12T13:18:26.790743  =


    2023-06-12T13:18:26.795902  / # /lava-10690530/bin/lava-test-runner /la=
va-10690530/1

    2023-06-12T13:18:26.802559  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64871912d75101dc58306139

  Results:     4 PASS, 1 FAIL, 2 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.33-=
133-g08f336c8c68d/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/mipsel/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/64871912d75101d=
c58306141
        failing since 2 days (last pass: v6.1.31-265-g621717027bee, first f=
ail: v6.1.33)
        1 lines

    2023-06-12T13:09:17.398311  kern  :alert : CPU 0 Unable to handle kerne=
l paging request at virtual address 6aa7bad4, epc =3D=3D 80203c54, ra =3D=
=3D 80203c48
    2023-06-12T13:09:17.398540  =


    2023-06-12T13:09:17.443821  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
    2023-06-12T13:09:17.444035  =

   =

 =20
