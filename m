Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2974F6FFB1F
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 22:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbjEKUQm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 16:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbjEKUQl (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 16:16:41 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CBC1BD0
        for <stable@vger.kernel.org>; Thu, 11 May 2023 13:16:39 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1adc913094aso10700975ad.0
        for <stable@vger.kernel.org>; Thu, 11 May 2023 13:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683836198; x=1686428198;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zP/riLoLTHV62Bc9hXh80bBtwCTHaGmOQY8C3mfu+m8=;
        b=jgL0gfBQUiqPWNn1i/pzPlhv/bDZVTdngeJXVTZoa7J1j4hyIXoADKLeeQrbJHJ+pH
         4LwRUGV59rsWEqTBzSXPEn44V53BRv6tufQWpDg0nxmGk0rml6r55WUYUdiH/rLdBI+t
         /KmNat3vGqaRHyjYbf/7rgNGmXopjlSoMu9gNcIqxgjjWbQbzJbBBEWC6lxrNF5cW/+k
         sKfwBDnrdrVfRmFO38tB39xz5cdPLZVB9QYeLHa8pbFYEpE1R5IyMoTnnkRiJRhGyb/g
         p2rtE7Cv3Q8DFz1qpWlKoHdaK7Trx96yaOBlvCmMKJ9fS0h87ztPlFRr6+X+LcGf//af
         9WaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683836198; x=1686428198;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zP/riLoLTHV62Bc9hXh80bBtwCTHaGmOQY8C3mfu+m8=;
        b=lsHfLzc/MrdXYW7ghGgGnK8AblwfDhf3bKcYeuRS3YbOX5t7+dxP5YaSDQEO3+adpz
         XApKQhX+dEa3r9Gp9tpZgS7VGv9vskb3lAQxfWLYoYSMtBQfcGPXeb3hBDANIflPw4im
         tTsH0rWy/IV+IaK1p08v4E24vIZuh0uyMvMB+lwy59maKIOfao2omG1QUZWQt0UU73Bj
         iT3/YIAZjfE6AnX3F9jQ8Q+74Mjf2MbtfCVEnJz5vhi1CHwtrmXA5iM8TZy+zYxMaMYZ
         EXTYbiAEkamHc5Vt+xMNVKIPSNV0jAQozEhRzAGmRfr2XCjhZoUYkARoWoVuLbIRRZ47
         ofdw==
X-Gm-Message-State: AC+VfDwcaQIAXcXm8hFSQR47e2Ra5tu/tPAXGRuN38HBjuIh9T+Lrkm8
        ONki5BYJmlzaulnucY3b1onsRUDXbXv6nvsYT/hhGg==
X-Google-Smtp-Source: ACHHUZ5JI9NCPjevURScP6si9zAGZGYtA8b8W23ukbxJGLFAxnmLYXDeYojuJl1NWzQWedJgm5dATw==
X-Received: by 2002:a17:902:f548:b0:1ad:cb4b:1d50 with SMTP id h8-20020a170902f54800b001adcb4b1d50mr3294185plf.43.1683836197997;
        Thu, 11 May 2023 13:16:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a195300b0023a84911df2sm24470490pjh.7.2023.05.11.13.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 13:16:37 -0700 (PDT)
Message-ID: <645d4d25.170a0220.65f64.0e2c@mx.google.com>
Date:   Thu, 11 May 2023 13:16:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.28
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 177 runs, 10 regressions (v6.1.28)
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

stable-rc/linux-6.1.y baseline: 177 runs, 10 regressions (v6.1.28)

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

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.28/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.28
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      bf4ad6fa4e5332e53913b073d0219319a4091619 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d1a629f8a8b5c372e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d1a629f8a8b5c372e85ec
        failing since 42 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T16:39:39.933893  <8>[    9.908998] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10285642_1.4.2.3.1>

    2023-05-11T16:39:39.937446  + set +x

    2023-05-11T16:39:40.041183  / # #

    2023-05-11T16:39:40.141842  export SHELL=3D/bin/sh

    2023-05-11T16:39:40.142056  #

    2023-05-11T16:39:40.242530  / # export SHELL=3D/bin/sh. /lava-10285642/=
environment

    2023-05-11T16:39:40.242737  =


    2023-05-11T16:39:40.343272  / # . /lava-10285642/environment/lava-10285=
642/bin/lava-test-runner /lava-10285642/1

    2023-05-11T16:39:40.343560  =


    2023-05-11T16:39:40.349045  / # /lava-10285642/bin/lava-test-runner /la=
va-10285642/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d1a4d7dd8232b902e8626

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d1a4d7dd8232b902e862b
        failing since 42 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T16:39:34.941824  + <8>[   11.385985] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10285588_1.4.2.3.1>

    2023-05-11T16:39:34.942457  set +x

    2023-05-11T16:39:35.050402  / # #

    2023-05-11T16:39:35.152948  export SHELL=3D/bin/sh

    2023-05-11T16:39:35.153750  #

    2023-05-11T16:39:35.255489  / # export SHELL=3D/bin/sh. /lava-10285588/=
environment

    2023-05-11T16:39:35.256274  =


    2023-05-11T16:39:35.358077  / # . /lava-10285588/environment/lava-10285=
588/bin/lava-test-runner /lava-10285588/1

    2023-05-11T16:39:35.359321  =


    2023-05-11T16:39:35.364222  / # /lava-10285588/bin/lava-test-runner /la=
va-10285588/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d1a71e6695301ca2e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d1a71e6695301ca2e8605
        failing since 42 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T16:39:55.116832  <8>[   10.859856] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10285623_1.4.2.3.1>

    2023-05-11T16:39:55.119658  + set +x

    2023-05-11T16:39:55.221102  =


    2023-05-11T16:39:55.321703  / # #export SHELL=3D/bin/sh

    2023-05-11T16:39:55.321923  =


    2023-05-11T16:39:55.422445  / # export SHELL=3D/bin/sh. /lava-10285623/=
environment

    2023-05-11T16:39:55.422675  =


    2023-05-11T16:39:55.523203  / # . /lava-10285623/environment/lava-10285=
623/bin/lava-test-runner /lava-10285623/1

    2023-05-11T16:39:55.523477  =


    2023-05-11T16:39:55.529245  / # /lava-10285623/bin/lava-test-runner /la=
va-10285623/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d1a79bffc0cdfe92e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d1a79bffc0cdfe92e85f8
        failing since 42 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T16:40:03.748889  + set +x

    2023-05-11T16:40:03.755627  <8>[   11.209269] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10285622_1.4.2.3.1>

    2023-05-11T16:40:03.860343  / # #

    2023-05-11T16:40:03.961030  export SHELL=3D/bin/sh

    2023-05-11T16:40:03.961256  #

    2023-05-11T16:40:04.061790  / # export SHELL=3D/bin/sh. /lava-10285622/=
environment

    2023-05-11T16:40:04.062000  =


    2023-05-11T16:40:04.162564  / # . /lava-10285622/environment/lava-10285=
622/bin/lava-test-runner /lava-10285622/1

    2023-05-11T16:40:04.162892  =


    2023-05-11T16:40:04.167269  / # /lava-10285622/bin/lava-test-runner /la=
va-10285622/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d1a5a794f0e45cb2e85e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d1a5a794f0e45cb2e85ee
        failing since 42 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T16:39:38.500411  <8>[   10.116365] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10285641_1.4.2.3.1>

    2023-05-11T16:39:38.503510  + set +x

    2023-05-11T16:39:38.604963  #

    2023-05-11T16:39:38.605421  =


    2023-05-11T16:39:38.706116  / # #export SHELL=3D/bin/sh

    2023-05-11T16:39:38.706425  =


    2023-05-11T16:39:38.807015  / # export SHELL=3D/bin/sh. /lava-10285641/=
environment

    2023-05-11T16:39:38.807298  =


    2023-05-11T16:39:38.907894  / # . /lava-10285641/environment/lava-10285=
641/bin/lava-test-runner /lava-10285641/1

    2023-05-11T16:39:38.908291  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d1a60794f0e45cb2e861d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d1a60794f0e45cb2e8622
        failing since 42 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T16:39:42.433306  + <8>[   11.343530] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10285624_1.4.2.3.1>

    2023-05-11T16:39:42.433404  set +x

    2023-05-11T16:39:42.537950  / # #

    2023-05-11T16:39:42.638511  export SHELL=3D/bin/sh

    2023-05-11T16:39:42.638704  #

    2023-05-11T16:39:42.739174  / # export SHELL=3D/bin/sh. /lava-10285624/=
environment

    2023-05-11T16:39:42.739365  =


    2023-05-11T16:39:42.839879  / # . /lava-10285624/environment/lava-10285=
624/bin/lava-test-runner /lava-10285624/1

    2023-05-11T16:39:42.840145  =


    2023-05-11T16:39:42.844854  / # /lava-10285624/bin/lava-test-runner /la=
va-10285624/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d1a3a79985a92d42e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d1a3a79985a92d42e85eb
        failing since 42 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-11T16:39:13.336178  + set<8>[   13.076942] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10285580_1.4.2.3.1>

    2023-05-11T16:39:13.336365   +x

    2023-05-11T16:39:13.441271  / # #

    2023-05-11T16:39:13.543395  export SHELL=3D/bin/sh

    2023-05-11T16:39:13.544196  #

    2023-05-11T16:39:13.646036  / # export SHELL=3D/bin/sh. /lava-10285580/=
environment

    2023-05-11T16:39:13.646717  =


    2023-05-11T16:39:13.748168  / # . /lava-10285580/environment/lava-10285=
580/bin/lava-test-runner /lava-10285580/1

    2023-05-11T16:39:13.749944  =


    2023-05-11T16:39:13.754097  / # /lava-10285580/bin/lava-test-runner /la=
va-10285580/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/645d1c3d81273b8d9f2e85e8

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/645d1c3d81273b8d9f2e8604
        new failure (last pass: v6.1.27)

    2023-05-11T16:47:35.472900  /lava-10285799/1/../bin/lava-test-case

    2023-05-11T16:47:35.473112  <8>[   22.823860] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>

    2023-05-11T16:47:35.473244  /lava-10285799/1/../bin/lava-test-case

    2023-05-11T16:47:35.473380  <8>[   22.844474] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-driver-present RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d1c3d81273b8d9f2e8690
        new failure (last pass: v6.1.27)

    2023-05-11T16:47:29.404569  + set +x

    2023-05-11T16:47:29.410784  <8>[   17.377823] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10285799_1.5.2.3.1>

    2023-05-11T16:47:29.516061  / # #

    2023-05-11T16:47:29.616665  export SHELL=3D/bin/sh

    2023-05-11T16:47:29.616903  #

    2023-05-11T16:47:29.717477  / # export SHELL=3D/bin/sh. /lava-10285799/=
environment

    2023-05-11T16:47:29.717706  =


    2023-05-11T16:47:29.818263  / # . /lava-10285799/environment/lava-10285=
799/bin/lava-test-runner /lava-10285799/1

    2023-05-11T16:47:29.818599  =


    2023-05-11T16:47:29.824119  / # /lava-10285799/bin/lava-test-runner /la=
va-10285799/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/645d1c1008cf33a7ba2e860a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28/=
mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.28/=
mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645d1c1008cf33a7ba2e8=
60b
        new failure (last pass: v6.1.27) =

 =20
