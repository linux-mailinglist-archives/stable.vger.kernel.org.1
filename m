Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE69F7D3D1C
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 19:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjJWRMH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 13:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJWRMH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 13:12:07 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CEC94
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 10:12:04 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-27d8e2ac2b1so2186091a91.2
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 10:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698081123; x=1698685923; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J2a8UgchkfeSFr3pMYjLgtYh3xOJeTia6MqGGZA+Z/c=;
        b=GMMJp/VV23STQk14e4fGJRyj3WwzweLuB23Y/F8+//RHl1PmAbSXuYIGhnQZzcCT/1
         1ayGjxntt+FFBylDZxrPvaiJRuaMZl+6Z4Ihs9nE2OzA7vFhPyZ57Kar9tM/MQ7Ar8Rq
         y43VIX3fxCKWp24J2lao16DRZ/HBnPMpD2ULKTWqb9VNUDXSxnOQoD9GjQS2lfbpFVCF
         gaOAByo9S4Ox/njxOqRV0wq9M9MWWcgnz3q1hGiLT15fXx8N/qEwNBThSfdjxlT9UFWM
         ekF50UZTn/jaOB8ik5gDIJM3l2W6DCuUG8tnI6mYbuncIHqWML3IajbOB/ur0PtulQdR
         UrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698081123; x=1698685923;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2a8UgchkfeSFr3pMYjLgtYh3xOJeTia6MqGGZA+Z/c=;
        b=udU3r6xfXWVaw2qbV4zWgaqRAqHw3CGbWa2p56Y4AWuEXc9Kb11VPAO1+Y1R07IuCk
         1Xt4cicW1vlECa4IoIviF+n+efWEkzw+GHVyWB98+t7wOf9Y17OuJ6zlRqMKKslQMxos
         oOwKYJf64H0LBx1PQBF4ZL+tBzhGy/FMIQNqCVdzJiIlIiwiN9fHdn7yHXpnsAOEgqn6
         aOJHFdS+5Loc/mtSI5di6jPp1q1DHKRCEu1YwBHSUux2i1FqwugyRcDvl8KXxY0ZTyQf
         d7KmoQO1xW18TBp5Z+CgEqgegNm5Hj876eN/rUNZGvBzN2tbjQcfTLAPTsFB6IWPMYRk
         L08Q==
X-Gm-Message-State: AOJu0YzbIciBGyF8LOJDuvqtJvogp5wyhhMmmcvSzaYNCNOmYrSd09i8
        grHc1otPL3RUrNr/57eYuVh45Y+d694Nb/nmcJoyaQ==
X-Google-Smtp-Source: AGHT+IEJAtBgCZ3CjwT0AoSNQzqvJetu8epEyQVXO/w1l8DgFuLvzNWNHsng5Cz2UveDExqUZ7Aaog==
X-Received: by 2002:a17:90a:d2c4:b0:27d:a14c:eba6 with SMTP id dj4-20020a17090ad2c400b0027da14ceba6mr7493007pjb.21.1698081122990;
        Mon, 23 Oct 2023 10:12:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c91-20020a17090a496400b0027dc483be23sm8437297pjh.26.2023.10.23.10.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:12:01 -0700 (PDT)
Message-ID: <6536a961.170a0220.d0d2e.a676@mx.google.com>
Date:   Mon, 23 Oct 2023 10:12:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.198-203-g38f629e2a1b6
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.10.y baseline: 114 runs,
 7 regressions (v5.10.198-203-g38f629e2a1b6)
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

stable-rc/linux-5.10.y baseline: 114 runs, 7 regressions (v5.10.198-203-g38=
f629e2a1b6)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.198-203-g38f629e2a1b6/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.198-203-g38f629e2a1b6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      38f629e2a1b66d0f082821ff1a5eb5af0a8e4862 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6536741f2e801687acefcf00

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-203-g38f629e2a1b6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-203-g38f629e2a1b6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6536741f2e801687acefcf09
        failing since 208 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-10-23T13:25:04.289690  + set +x

    2023-10-23T13:25:04.296561  <8>[   13.221469] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11855622_1.4.2.3.1>

    2023-10-23T13:25:04.400609  / # #

    2023-10-23T13:25:04.501185  export SHELL=3D/bin/sh

    2023-10-23T13:25:04.501386  #

    2023-10-23T13:25:04.601910  / # export SHELL=3D/bin/sh. /lava-11855622/=
environment

    2023-10-23T13:25:04.602171  =


    2023-10-23T13:25:04.702707  / # . /lava-11855622/environment/lava-11855=
622/bin/lava-test-runner /lava-11855622/1

    2023-10-23T13:25:04.703041  =


    2023-10-23T13:25:04.707691  / # /lava-11855622/bin/lava-test-runner /la=
va-11855622/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/653674302e801687acefcf39

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-203-g38f629e2a1b6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-203-g38f629e2a1b6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653674302e801687acefcf42
        failing since 208 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-10-23T13:24:55.012943  <8>[   11.880756] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11855628_1.4.2.3.1>

    2023-10-23T13:24:55.015826  + set +x

    2023-10-23T13:24:55.117115  =


    2023-10-23T13:24:55.217627  / # #export SHELL=3D/bin/sh

    2023-10-23T13:24:55.217845  =


    2023-10-23T13:24:55.318474  / # export SHELL=3D/bin/sh. /lava-11855628/=
environment

    2023-10-23T13:24:55.318650  =


    2023-10-23T13:24:55.419275  / # . /lava-11855628/environment/lava-11855=
628/bin/lava-test-runner /lava-11855628/1

    2023-10-23T13:24:55.419588  =


    2023-10-23T13:24:55.424588  / # /lava-11855628/bin/lava-test-runner /la=
va-11855628/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/653685399a5b1da92fefcf09

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-203-g38f629e2a1b6/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-203-g38f629e2a1b6/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653685399a5b1da92fefcf49
        failing since 33 days (last pass: v5.10.195, first fail: v5.10.195-=
84-gf147286de8e5)

    2023-10-23T14:37:23.899380  <8>[   14.988441] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 189021_1.5.2.4.1>
    2023-10-23T14:37:24.007555  / # #
    2023-10-23T14:37:24.110451  export SHELL=3D/bin/sh
    2023-10-23T14:37:24.111244  #
    2023-10-23T14:37:24.213179  / # export SHELL=3D/bin/sh. /lava-189021/en=
vironment
    2023-10-23T14:37:24.213621  =

    2023-10-23T14:37:24.315085  / # . /lava-189021/environment/lava-189021/=
bin/lava-test-runner /lava-189021/1
    2023-10-23T14:37:24.316357  =

    2023-10-23T14:37:24.331648  / # /lava-189021/bin/lava-test-runner /lava=
-189021/1
    2023-10-23T14:37:24.389512  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/653676123d9571d874efcf01

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-203-g38f629e2a1b6/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-203-g38f629e2a1b6/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653676123d9571d874efcf0a
        failing since 97 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-10-23T13:37:19.534060  / # #

    2023-10-23T13:37:19.636016  export SHELL=3D/bin/sh

    2023-10-23T13:37:19.636215  #

    2023-10-23T13:37:19.736677  / # export SHELL=3D/bin/sh. /lava-11855854/=
environment

    2023-10-23T13:37:19.736812  =


    2023-10-23T13:37:19.837297  / # . /lava-11855854/environment/lava-11855=
854/bin/lava-test-runner /lava-11855854/1

    2023-10-23T13:37:19.837505  =


    2023-10-23T13:37:19.848062  / # /lava-11855854/bin/lava-test-runner /la=
va-11855854/1

    2023-10-23T13:37:19.891893  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-23T13:37:19.906913  + cd /lav<8>[   16.403137] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11855854_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6536764540632db17fefcf5c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-203-g38f629e2a1b6/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-203-g38f629e2a1b6/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6536764540632db17fefcf65
        failing since 59 days (last pass: v5.10.191, first fail: v5.10.190-=
136-gda59b7b5c515e)

    2023-10-23T13:33:30.294940  / # #

    2023-10-23T13:33:31.555643  export SHELL=3D/bin/sh

    2023-10-23T13:33:31.566583  #

    2023-10-23T13:33:31.567059  / # export SHELL=3D/bin/sh

    2023-10-23T13:33:33.310624  / # . /lava-11855849/environment

    2023-10-23T13:33:36.516114  /lava-11855849/bin/lava-test-runner /lava-1=
1855849/1

    2023-10-23T13:33:36.527555  . /lava-11855849/environment

    2023-10-23T13:33:36.530046  / # /lava-11855849/bin/lava-test-runner /la=
va-11855849/1

    2023-10-23T13:33:36.582996  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-23T13:33:36.583485  + cd /lava-11855849/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65367605d927cf97baefcef5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-203-g38f629e2a1b6/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-203-g38f629e2a1b6/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65367605d927cf97baefcefe
        failing since 12 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-10-23T13:32:48.145981  / # #
    2023-10-23T13:32:48.248012  export SHELL=3D/bin/sh
    2023-10-23T13:32:48.248712  #
    2023-10-23T13:32:48.349917  / # export SHELL=3D/bin/sh. /lava-440104/en=
vironment
    2023-10-23T13:32:48.350574  =

    2023-10-23T13:32:48.451624  / # . /lava-440104/environment/lava-440104/=
bin/lava-test-runner /lava-440104/1
    2023-10-23T13:32:48.452523  =

    2023-10-23T13:32:48.454402  / # /lava-440104/bin/lava-test-runner /lava=
-440104/1
    2023-10-23T13:32:48.486397  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-23T13:32:48.527753  + cd /lava-440104/<8>[   17.484140] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 440104_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6536762640632db17fefcf0f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-203-g38f629e2a1b6/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
98-203-g38f629e2a1b6/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6536762640632db17fefcf18
        failing since 12 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-10-23T13:37:35.445645  / # #

    2023-10-23T13:37:35.546377  export SHELL=3D/bin/sh

    2023-10-23T13:37:35.547075  #

    2023-10-23T13:37:35.648339  / # export SHELL=3D/bin/sh. /lava-11855855/=
environment

    2023-10-23T13:37:35.648522  =


    2023-10-23T13:37:35.749093  / # . /lava-11855855/environment/lava-11855=
855/bin/lava-test-runner /lava-11855855/1

    2023-10-23T13:37:35.749365  =


    2023-10-23T13:37:35.759542  / # /lava-11855855/bin/lava-test-runner /la=
va-11855855/1

    2023-10-23T13:37:35.822157  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-23T13:37:35.822659  + cd /lava-1185585<8>[   18.073957] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11855855_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
