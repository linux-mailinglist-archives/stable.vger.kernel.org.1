Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD847D19D6
	for <lists+stable@lfdr.de>; Sat, 21 Oct 2023 02:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjJUAMf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 20:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjJUAMe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 20:12:34 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C773419E
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 17:12:29 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1ea45b07c59so1018640fac.0
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 17:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697847147; x=1698451947; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rs2/dU9lpeS7EUdOtYodDlf0S8X2wRO8iirBhm0re7Y=;
        b=MRDCQOY7bLGoL+plQLkUOc9Zc16pm45lisnjBt0h/npM0FD+GE0IbxYZ9jK1zIwh6w
         ktamfPE/ly1MparS290s3+W0D6+2XQQnvpR4GqYl3e7GH5qjachG+qJHLhY7NM86Ls0F
         evieixB++ZBdDTyEfWpfiU1WK32ooQDT1l/SBvLKodBqix0Rirm2m3Dg3lpuBaZHXvQ2
         Ix8UQATyiAc8WqTwBccpL7OrpAWcjcQoeHRVy4Xf48DBM6GZcHN+f0Iomjx0Ls1jZwKM
         uggt7L0R8Q+sZhLSHrMc3CxmPi8DU4ffEznWBN1RxMEOqkW/l3/xpS9YIZdxaYY48iu7
         WbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697847147; x=1698451947;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rs2/dU9lpeS7EUdOtYodDlf0S8X2wRO8iirBhm0re7Y=;
        b=Ccfww8f8SDWK6KdnjQowBBVyfPC8UmxrevnjO/x71v2Y8W1G9JWna0AnfID6gBpYnk
         JM79c+KKRKuJS6bNwUuzrOjHIIE+IeKk3TsgtYuvODvhmtO6swbX8xxkIaSfpeikkUHo
         cHTx2DcjdGGMG26YrbTq7hj0DuVBQOmv7w01ua5DCrtwTcSydjg2oWdLUIiqxI8eb7pT
         +gQOXoQYNVsnMAsJvf9pTpucvF+nnZQjnc22qry3t7CZoE/LooQl4MzhUI3focJIqkVG
         3r9/WR7Rre6TNgRIqrHPQyhSwe5ehjYrNO4EqXrqjFloL4jD37u0b6CBHh73KuzDi4sb
         XaXg==
X-Gm-Message-State: AOJu0Yzw0mnBLh+xXW+3btppc0YGznlK/VFdBAqLv8GnMA4pnZ8GwGys
        nfL/cdhmLrne21H1Arsfat76BwqWkmLmey0sPyke/A==
X-Google-Smtp-Source: AGHT+IFcW1vGgtTaTg6jZnqdPQPJQGGsFLYaU7OMKkZRuo37mTyZKhOFw6A024nbr3jH69i8n5gQMw==
X-Received: by 2002:a05:6871:4391:b0:1bb:a227:7008 with SMTP id lv17-20020a056871439100b001bba2277008mr4068585oab.3.1697847147431;
        Fri, 20 Oct 2023 17:12:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t8-20020aa79468000000b006884549adc8sm2114159pfq.29.2023.10.20.17.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 17:12:26 -0700 (PDT)
Message-ID: <6533176a.a70a0220.c7489.87b1@mx.google.com>
Date:   Fri, 20 Oct 2023 17:12:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.59
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
Subject: stable/linux-6.1.y baseline: 171 runs, 12 regressions (v6.1.59)
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

stable/linux-6.1.y baseline: 171 runs, 12 regressions (v6.1.59)

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

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.59/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.59
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      7d24402875c75ca6e43aa27ae3ce2042bde259a4 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532e460b12bead345efcf26

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532e460b12bead345efcf2f
        failing since 204 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-20T20:34:26.190120  <8>[   10.642375] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11832867_1.4.2.3.1>

    2023-10-20T20:34:26.192979  + set +x

    2023-10-20T20:34:26.297512  / # #

    2023-10-20T20:34:26.398362  export SHELL=3D/bin/sh

    2023-10-20T20:34:26.398551  #

    2023-10-20T20:34:26.499098  / # export SHELL=3D/bin/sh. /lava-11832867/=
environment

    2023-10-20T20:34:26.499380  =


    2023-10-20T20:34:26.600084  / # . /lava-11832867/environment/lava-11832=
867/bin/lava-test-runner /lava-11832867/1

    2023-10-20T20:34:26.600407  =


    2023-10-20T20:34:26.605881  / # /lava-11832867/bin/lava-test-runner /la=
va-11832867/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532e46ba4d0cac7a6efcf2b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532e46ba4d0cac7a6efcf34
        failing since 204 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-20T20:34:29.332562  + set<8>[   10.980361] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11832855_1.4.2.3.1>

    2023-10-20T20:34:29.333027   +x

    2023-10-20T20:34:29.441204  / # #

    2023-10-20T20:34:29.543682  export SHELL=3D/bin/sh

    2023-10-20T20:34:29.544532  #

    2023-10-20T20:34:29.646031  / # export SHELL=3D/bin/sh. /lava-11832855/=
environment

    2023-10-20T20:34:29.646810  =


    2023-10-20T20:34:29.748278  / # . /lava-11832855/environment/lava-11832=
855/bin/lava-test-runner /lava-11832855/1

    2023-10-20T20:34:29.749508  =


    2023-10-20T20:34:29.754162  / # /lava-11832855/bin/lava-test-runner /la=
va-11832855/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532e469b12bead345efcf41

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532e469b12bead345efcf4a
        failing since 204 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-20T20:34:29.859274  <8>[   11.132799] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11832854_1.4.2.3.1>

    2023-10-20T20:34:29.862558  + set +x

    2023-10-20T20:34:29.968783  =


    2023-10-20T20:34:30.070863  / # #export SHELL=3D/bin/sh

    2023-10-20T20:34:30.071668  =


    2023-10-20T20:34:30.173440  / # export SHELL=3D/bin/sh. /lava-11832854/=
environment

    2023-10-20T20:34:30.174286  =


    2023-10-20T20:34:30.276130  / # . /lava-11832854/environment/lava-11832=
854/bin/lava-test-runner /lava-11832854/1

    2023-10-20T20:34:30.277389  =


    2023-10-20T20:34:30.282626  / # /lava-11832854/bin/lava-test-runner /la=
va-11832854/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6532e79d8416bf7aa8efcf71

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/arm=
/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/arm=
/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6532e79d8416bf7aa8efc=
f72
        failing since 58 days (last pass: v6.1.46, first fail: v6.1.47) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532e43e8f79f45be6efcf12

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532e43e8f79f45be6efcf1b
        failing since 204 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-20T20:35:32.132219  + set +x

    2023-10-20T20:35:32.139145  <8>[   10.185207] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11832819_1.4.2.3.1>

    2023-10-20T20:35:32.243439  / # #

    2023-10-20T20:35:32.345104  export SHELL=3D/bin/sh

    2023-10-20T20:35:32.345344  #

    2023-10-20T20:35:32.446015  / # export SHELL=3D/bin/sh. /lava-11832819/=
environment

    2023-10-20T20:35:32.446257  =


    2023-10-20T20:35:32.547036  / # . /lava-11832819/environment/lava-11832=
819/bin/lava-test-runner /lava-11832819/1

    2023-10-20T20:35:32.548236  =


    2023-10-20T20:35:32.552849  / # /lava-11832819/bin/lava-test-runner /la=
va-11832819/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532e456e7e79cc81befcf1d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532e456e7e79cc81befcf26
        failing since 204 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-20T20:34:24.598824  <8>[    7.887054] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11832848_1.4.2.3.1>

    2023-10-20T20:34:24.602093  + set +x

    2023-10-20T20:34:24.706775  #

    2023-10-20T20:34:24.708083  =


    2023-10-20T20:34:24.810076  / # #export SHELL=3D/bin/sh

    2023-10-20T20:34:24.810912  =


    2023-10-20T20:34:24.912419  / # export SHELL=3D/bin/sh. /lava-11832848/=
environment

    2023-10-20T20:34:24.913207  =


    2023-10-20T20:34:25.014948  / # . /lava-11832848/environment/lava-11832=
848/bin/lava-test-runner /lava-11832848/1

    2023-10-20T20:34:25.016214  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532e460a4d0cac7a6efcf03

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532e460a4d0cac7a6efcf0c
        failing since 204 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-20T20:34:40.778294  + set<8>[    8.643478] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11832887_1.4.2.3.1>

    2023-10-20T20:34:40.778419   +x

    2023-10-20T20:34:40.882756  / # #

    2023-10-20T20:34:40.983530  export SHELL=3D/bin/sh

    2023-10-20T20:34:40.983774  #

    2023-10-20T20:34:41.084341  / # export SHELL=3D/bin/sh. /lava-11832887/=
environment

    2023-10-20T20:34:41.084581  =


    2023-10-20T20:34:41.185162  / # . /lava-11832887/environment/lava-11832=
887/bin/lava-test-runner /lava-11832887/1

    2023-10-20T20:34:41.185509  =


    2023-10-20T20:34:41.190550  / # /lava-11832887/bin/lava-test-runner /la=
va-11832887/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532e43a7427ff9350efcf18

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532e43a7427ff9350efcf21
        failing since 204 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-20T20:33:49.325455  <8>[   12.247724] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11832814_1.4.2.3.1>

    2023-10-20T20:33:49.429775  / # #

    2023-10-20T20:33:49.530343  export SHELL=3D/bin/sh

    2023-10-20T20:33:49.530526  #

    2023-10-20T20:33:49.630984  / # export SHELL=3D/bin/sh. /lava-11832814/=
environment

    2023-10-20T20:33:49.631152  =


    2023-10-20T20:33:49.731644  / # . /lava-11832814/environment/lava-11832=
814/bin/lava-test-runner /lava-11832814/1

    2023-10-20T20:33:49.731897  =


    2023-10-20T20:33:49.736329  / # /lava-11832814/bin/lava-test-runner /la=
va-11832814/1

    2023-10-20T20:33:49.743728  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6532e5c3fcfa6d665befcf59

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532e5c3fcfa6d665befcf62
        failing since 93 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-10-20T20:44:43.012475  / # #

    2023-10-20T20:44:43.114515  export SHELL=3D/bin/sh

    2023-10-20T20:44:43.115193  #

    2023-10-20T20:44:43.216563  / # export SHELL=3D/bin/sh. /lava-11832934/=
environment

    2023-10-20T20:44:43.217294  =


    2023-10-20T20:44:43.318727  / # . /lava-11832934/environment/lava-11832=
934/bin/lava-test-runner /lava-11832934/1

    2023-10-20T20:44:43.319805  =


    2023-10-20T20:44:43.364251  / # /lava-11832934/bin/lava-test-runner /la=
va-11832934/1

    2023-10-20T20:44:43.385027  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-20T20:44:43.385588  + cd /lava-118329<8>[   19.139328] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11832934_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6532e5f2a6b032ccafefcfc1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532e5f2a6b032ccafefcfca
        failing since 93 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-10-20T20:41:21.861427  / # #

    2023-10-20T20:41:22.940882  export SHELL=3D/bin/sh

    2023-10-20T20:41:22.942721  #

    2023-10-20T20:41:24.432794  / # export SHELL=3D/bin/sh. /lava-11832936/=
environment

    2023-10-20T20:41:24.434663  =


    2023-10-20T20:41:27.158003  / # . /lava-11832936/environment/lava-11832=
936/bin/lava-test-runner /lava-11832936/1

    2023-10-20T20:41:27.160152  =


    2023-10-20T20:41:27.169073  / # /lava-11832936/bin/lava-test-runner /la=
va-11832936/1

    2023-10-20T20:41:27.229136  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-20T20:41:27.229593  + cd /lava-118329<8>[   29.544849] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11832936_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-clabbe    | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6532e5d21bb10cd81befcf2d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/arm=
64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/arm=
64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532e5d21bb10cd81befcf36
        failing since 9 days (last pass: v6.1.24, first fail: v6.1.57)

    2023-10-20T20:40:26.909883  / # #
    2023-10-20T20:40:27.011603  export SHELL=3D/bin/sh
    2023-10-20T20:40:27.012321  #
    2023-10-20T20:40:27.113523  / # export SHELL=3D/bin/sh. /lava-439462/en=
vironment
    2023-10-20T20:40:27.114179  =

    2023-10-20T20:40:27.215596  / # . /lava-439462/environment/lava-439462/=
bin/lava-test-runner /lava-439462/1
    2023-10-20T20:40:27.216737  =

    2023-10-20T20:40:27.219279  / # /lava-439462/bin/lava-test-runner /lava=
-439462/1
    2023-10-20T20:40:27.298341  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-20T20:40:27.299011  + cd /lava-439462/<8>[   18.564039] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 439462_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6532e5d9b30363becdefcf68

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.59/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532e5d9b30363becdefcf71
        failing since 9 days (last pass: v6.1.24, first fail: v6.1.57)

    2023-10-20T20:44:56.833699  / # #

    2023-10-20T20:44:56.935933  export SHELL=3D/bin/sh

    2023-10-20T20:44:56.936638  #

    2023-10-20T20:44:57.037998  / # export SHELL=3D/bin/sh. /lava-11832939/=
environment

    2023-10-20T20:44:57.038732  =


    2023-10-20T20:44:57.140149  / # . /lava-11832939/environment/lava-11832=
939/bin/lava-test-runner /lava-11832939/1

    2023-10-20T20:44:57.141169  =


    2023-10-20T20:44:57.157714  / # /lava-11832939/bin/lava-test-runner /la=
va-11832939/1

    2023-10-20T20:44:57.222828  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-20T20:44:57.223344  + cd /lava-1183293<8>[   18.753409] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11832939_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
