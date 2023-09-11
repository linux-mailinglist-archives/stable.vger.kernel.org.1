Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028DA79B851
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241508AbjIKWfH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbjIKML1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 08:11:27 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081D8193
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 05:11:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bc8a2f71eeso34782155ad.0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 05:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694434281; x=1695039081; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W43RZMH84xAIv87GRa6CFpSNnblh10Lpuq99rTOE2Rg=;
        b=RgE4NdyRp6FILVbNWOmxyL2rvXT+7hwhfflVbO1vIOr89PdGVluyPNqrHdYZU/JcnW
         KliBuNy1bAD98IK5cmli0GjDxs3AeBo8W7WlCxXWJRPdzVlgFIBVEwf+nC5MxnSBjze1
         WF9j4hHEkZ6Vxg6p9UvO/UV06P68OUmjt7zzzp3Atl5ahGaXc8vO9X6eXx9llE5tF5aT
         p7/Wf+x1z/p+jQLsPEEWs65mDsDdM+RVo+Iq8p1efy+oobG2gtFiwAiyze2A1OVcOu0A
         FtIcb3cnQzueySKgRB1264Jy2HWYeCPA5EG9HfzDxEpao9XYlEvQdgQy9J1SRPBNcINZ
         DEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694434281; x=1695039081;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W43RZMH84xAIv87GRa6CFpSNnblh10Lpuq99rTOE2Rg=;
        b=Shg09iKcBHu5oMm8uJlL8WF1beL7Lf+lHoDSnLSp/OnjhGwAtbRRZTeIKGMyQ4z5xS
         E6uw+hrKERSl5nFim2wEoPCvSOE5iIKUBa1TNcSwThBkJZ00NNBgow9Y8t5kG24rhKcy
         i9e+XMLZY4oMzHFNq/30kHP/nX9LdwvZqb86LYzulEi5Pop3E91XdQrCzj7A++PACp3T
         i9E06DDNU7XGOxHpaGrwuLyjQeEQYfydkTZv9WqlZn0tcJbcTt8dYulSBrQ1PrE3IsHL
         5Dwl0laaXXPJEOcTGZhd1ki+MG94rlqJtsg7aeveTXOvj7yPc3efXLLQe5nPIKfR5NU+
         SqPA==
X-Gm-Message-State: AOJu0YzCoNvnLlv/FKwTjN/VHZgojOmw1WShiP5PQ8BIXUSMVynfREEB
        1OHFX84YlIqgk5FizjtUgL46qXFL0sQNUyI/tqQ=
X-Google-Smtp-Source: AGHT+IG93j/c2jXbeWOZUS9ygq79bMflylxSWADAHcL1eQ3VBohV0N0e017fx1ymRSc000IkG+z1cA==
X-Received: by 2002:a17:902:e547:b0:1bf:2eab:dd4e with SMTP id n7-20020a170902e54700b001bf2eabdd4emr9005604plf.1.1694434280645;
        Mon, 11 Sep 2023 05:11:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jf6-20020a170903268600b001c1f4edfb87sm2114877plb.92.2023.09.11.05.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 05:11:19 -0700 (PDT)
Message-ID: <64ff03e7.170a0220.e2c81.4c76@mx.google.com>
Date:   Mon, 11 Sep 2023 05:11:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.194-314-gda03e749b770
Subject: stable-rc/linux-5.10.y baseline: 109 runs,
 9 regressions (v5.10.194-314-gda03e749b770)
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

stable-rc/linux-5.10.y baseline: 109 runs, 9 regressions (v5.10.194-314-gda=
03e749b770)

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

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.194-314-gda03e749b770/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.194-314-gda03e749b770
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      da03e749b77075d4c85bc92169ca9fb0713dcccf =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fee14a05853fa310286d73

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-gda03e749b770/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-gda03e749b770/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fee14a05853fa310286d7c
        failing since 166 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-11T09:43:27.628273  + set +x

    2023-09-11T09:43:27.634710  <8>[   10.459073] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11492820_1.4.2.3.1>

    2023-09-11T09:43:27.743253  / # #

    2023-09-11T09:43:27.845535  export SHELL=3D/bin/sh

    2023-09-11T09:43:27.846307  #

    2023-09-11T09:43:27.947659  / # export SHELL=3D/bin/sh. /lava-11492820/=
environment

    2023-09-11T09:43:27.947940  =


    2023-09-11T09:43:28.048583  / # . /lava-11492820/environment/lava-11492=
820/bin/lava-test-runner /lava-11492820/1

    2023-09-11T09:43:28.049706  =


    2023-09-11T09:43:28.054776  / # /lava-11492820/bin/lava-test-runner /la=
va-11492820/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fee72806e744094128718d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-gda03e749b770/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-gda03e749b770/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fee72806e7440941287196
        failing since 166 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-11T10:08:32.269535  <8>[   12.994705] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11492805_1.4.2.3.1>

    2023-09-11T10:08:32.272806  + set +x

    2023-09-11T10:08:32.376911  / # #

    2023-09-11T10:08:32.477706  export SHELL=3D/bin/sh

    2023-09-11T10:08:32.478675  #

    2023-09-11T10:08:32.580502  / # export SHELL=3D/bin/sh. /lava-11492805/=
environment

    2023-09-11T10:08:32.581261  =


    2023-09-11T10:08:32.682502  / # . /lava-11492805/environment/lava-11492=
805/bin/lava-test-runner /lava-11492805/1

    2023-09-11T10:08:32.683772  =


    2023-09-11T10:08:32.688992  / # /lava-11492805/bin/lava-test-runner /la=
va-11492805/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64fed3706840b4dcb4286d86

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-gda03e749b770/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-gda03e749b770/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fed3706840b4dcb4286dc2
        new failure (last pass: v5.10.194-287-ga910bb4a67e8)

    2023-09-11T08:43:59.755288  / # #
    2023-09-11T08:43:59.858265  export SHELL=3D/bin/sh
    2023-09-11T08:43:59.859029  #
    2023-09-11T08:43:59.960934  / # export SHELL=3D/bin/sh. /lava-98655/env=
ironment
    2023-09-11T08:43:59.961722  =

    2023-09-11T08:44:00.063706  / # . /lava-98655/environment/lava-98655/bi=
n/lava-test-runner /lava-98655/1
    2023-09-11T08:44:00.065029  =

    2023-09-11T08:44:00.077913  / # /lava-98655/bin/lava-test-runner /lava-=
98655/1
    2023-09-11T08:44:00.138784  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-11T08:44:00.139303  + cd /lava-98655/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64fed31b28298b923a286df4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-gda03e749b770/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-gda03e749b770/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fed31b28298b923a286df7
        failing since 55 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-11T08:42:52.060826  + set +x
    2023-09-11T08:42:52.064037  <8>[   83.968807] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1007668_1.5.2.4.1>
    2023-09-11T08:42:52.171612  / # #
    2023-09-11T08:42:53.635941  export SHELL=3D/bin/sh
    2023-09-11T08:42:53.656856  #
    2023-09-11T08:42:53.657317  / # export SHELL=3D/bin/sh
    2023-09-11T08:42:55.615088  / # . /lava-1007668/environment
    2023-09-11T08:42:59.217240  /lava-1007668/bin/lava-test-runner /lava-10=
07668/1
    2023-09-11T08:42:59.238720  . /lava-1007668/environment
    2023-09-11T08:42:59.239134  / # /lava-1007668/bin/lava-test-runner /lav=
a-1007668/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64fed391aa641e30bd286d79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-gda03e749b770/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-gda03e749b770/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseli=
ne-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fed391aa641e30bd286d7c
        failing since 55 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-11T08:44:33.075585  / # #
    2023-09-11T08:44:34.537099  export SHELL=3D/bin/sh
    2023-09-11T08:44:34.557634  #
    2023-09-11T08:44:34.557841  / # export SHELL=3D/bin/sh
    2023-09-11T08:44:36.512938  / # . /lava-1007663/environment
    2023-09-11T08:44:40.109625  /lava-1007663/bin/lava-test-runner /lava-10=
07663/1
    2023-09-11T08:44:40.130529  . /lava-1007663/environment
    2023-09-11T08:44:40.130671  / # /lava-1007663/bin/lava-test-runner /lav=
a-1007663/1
    2023-09-11T08:44:40.211521  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-11T08:44:40.211745  + cd /lava-1007663/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64fed4c7401cecfc13286df2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-gda03e749b770/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-gda03e749b770/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fed4c7401cecfc13286df5
        failing since 55 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-11T08:49:45.314875  / # #
    2023-09-11T08:49:46.774485  export SHELL=3D/bin/sh
    2023-09-11T08:49:46.794905  #
    2023-09-11T08:49:46.795046  / # export SHELL=3D/bin/sh
    2023-09-11T08:49:48.747854  / # . /lava-1007677/environment
    2023-09-11T08:49:52.343930  /lava-1007677/bin/lava-test-runner /lava-10=
07677/1
    2023-09-11T08:49:52.364689  . /lava-1007677/environment
    2023-09-11T08:49:52.364797  / # /lava-1007677/bin/lava-test-runner /lav=
a-1007677/1
    2023-09-11T08:49:52.442983  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-11T08:49:52.443197  + cd /lava-1007677/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64fed2b287aedb69ae286d6c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-gda03e749b770/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-gda03e749b770/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960=
-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fed2b287aedb69ae286d75
        failing since 55 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-11T08:45:33.679904  / # #

    2023-09-11T08:45:33.780876  export SHELL=3D/bin/sh

    2023-09-11T08:45:33.781527  #

    2023-09-11T08:45:33.882824  / # export SHELL=3D/bin/sh. /lava-11492893/=
environment

    2023-09-11T08:45:33.883483  =


    2023-09-11T08:45:33.984764  / # . /lava-11492893/environment/lava-11492=
893/bin/lava-test-runner /lava-11492893/1

    2023-09-11T08:45:33.985744  =


    2023-09-11T08:45:33.987978  / # /lava-11492893/bin/lava-test-runner /la=
va-11492893/1

    2023-09-11T08:45:34.051325  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-11T08:45:34.051808  + cd /lav<8>[   16.408702] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11492893_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64fed2f4d54e61cc8a286da0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-gda03e749b770/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-gda03e749b770/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-r=
ock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fed2f4d54e61cc8a286da9
        failing since 17 days (last pass: v5.10.191, first fail: v5.10.190-=
136-gda59b7b5c515e)

    2023-09-11T08:43:53.689640  / # #

    2023-09-11T08:43:54.947548  export SHELL=3D/bin/sh

    2023-09-11T08:43:54.958321  #

    2023-09-11T08:43:56.700883  / # export SHELL=3D/bin/sh. /lava-11492887/=
environment

    2023-09-11T08:43:56.711842  =


    2023-09-11T08:43:56.712307  / # . /lava-11492887/environment

    2023-09-11T08:43:59.900994  / # /lava-11492887/bin/lava-test-runner /la=
va-11492887/1

    2023-09-11T08:43:59.916529  /lava-11492887/bin/lava-test-runner /lava-1=
1492887/1

    2023-09-11T08:43:59.966404  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-11T08:43:59.966489  + cd /lava-11492887/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64fed2c264dcfd9ba1286d72

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-gda03e749b770/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94-314-gda03e749b770/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fed2c264dcfd9ba1286d7b
        failing since 55 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-11T08:45:47.594859  / # #

    2023-09-11T08:45:47.696930  export SHELL=3D/bin/sh

    2023-09-11T08:45:47.697755  #

    2023-09-11T08:45:47.799265  / # export SHELL=3D/bin/sh. /lava-11492894/=
environment

    2023-09-11T08:45:47.800006  =


    2023-09-11T08:45:47.901458  / # . /lava-11492894/environment/lava-11492=
894/bin/lava-test-runner /lava-11492894/1

    2023-09-11T08:45:47.902619  =


    2023-09-11T08:45:47.944106  / # /lava-11492894/bin/lava-test-runner /la=
va-11492894/1

    2023-09-11T08:45:47.975998  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-11T08:45:47.976466  + cd /lava-1149289<8>[   18.324130] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11492894_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
