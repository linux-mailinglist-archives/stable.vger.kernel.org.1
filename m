Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA2371EE5B
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 18:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjFAQMM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 12:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjFAQMK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 12:12:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D08E186
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 09:12:07 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d30ab1ef2so719416b3a.2
        for <stable@vger.kernel.org>; Thu, 01 Jun 2023 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685635926; x=1688227926;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EVoLr/yFKI/rK7v/ncMozk29GDm1qho8nNRlikxsM4w=;
        b=UW1uu87QrxS+Vcw8R8lN1r4wgTUoQ8XwXXctIph83n2WSFqK2QNyJN+xwU6WRLUdFo
         84f/3WmPE1tl3nORDWhvThiAimGCgaaTanahXpVSRBT3YjLzNeSVfTTA6DZe0MOCfyQt
         3nPZ4PWKR2lJd4lc8gb7p7UI17APqLL+NKdAc1vRkoUk1cPFCEJ6QKwUPCdln79RQz5M
         TNoPysOylOvce8MqSrG+C/PH1NgcisSejS+Fy4N9zCFjuXfYZpQ+WWc3MP/aoLvHbRXD
         xintPJkicjBbiSN8zZeGu728xm/3UdMhmkxQfawOrGROjE08mtMXy0wAlUfJ3ZcL/Ed/
         yssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685635926; x=1688227926;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVoLr/yFKI/rK7v/ncMozk29GDm1qho8nNRlikxsM4w=;
        b=clCqb64B3hiVTdZL7QceSARsajq/2xLKz+Oa1tAX+rqB3z4R1kyogHk5cPLplIm8JA
         9Mx/qWP22FGfa0YdHA2EW5HYcQj39aM+pX4JPAD+/1k4+5ezTbIKqAtHVJMz8ryO47mm
         UO83r/UuxCuhn9Ph/K2nmvdnXgLFQ4QaQlorLcocsmf//z7TOZObRjMcSdk3FWEe+CbH
         5+kxG10BBOK58evKzczogxzvdLKKN6xMheM5IcNHGbH7MJvcc6Mrx6Wt5jNlJIGZwE80
         qryGVGb7m6XiKSDXiep0pM9J31sAxnL+LccMAL9lvmpXwJJdFphLIJd4uolTULd6HaV9
         aULQ==
X-Gm-Message-State: AC+VfDwWD3Jq1PiQ6jul4OqTFxNMlM2l5xY8xOYrJ4viBHlPmTElcb0C
        /oUoBaVgHr0hw5Z3mWbE0jwBtC7I9JB6jHFAsfcXTg==
X-Google-Smtp-Source: ACHHUZ5YoSvFNP4gqnmMzxBIqRU9SczZ7D7zCugvWkY5YrxSnEmVsZak4o5G82pchFOkivssh11wcQ==
X-Received: by 2002:a05:6a20:4283:b0:10c:90ac:442d with SMTP id o3-20020a056a20428300b0010c90ac442dmr8218347pzj.13.1685635925993;
        Thu, 01 Jun 2023 09:12:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e25-20020aa78259000000b0065017055cb4sm2497568pfn.203.2023.06.01.09.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:12:05 -0700 (PDT)
Message-ID: <6478c355.a70a0220.a728e.535f@mx.google.com>
Date:   Thu, 01 Jun 2023 09:12:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.31-43-g087e96594ba7
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 125 runs,
 9 regressions (v6.1.31-43-g087e96594ba7)
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

stable-rc/linux-6.1.y baseline: 125 runs, 9 regressions (v6.1.31-43-g087e96=
594ba7)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.31-43-g087e96594ba7/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.31-43-g087e96594ba7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      087e96594ba7ac34f7162e9224ca67868fbcd126 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64788c9945535ddc122e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
43-g087e96594ba7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
43-g087e96594ba7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64788c9945535ddc122e85ec
        failing since 62 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-01T12:18:21.493343  <8>[   10.594643] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10552046_1.4.2.3.1>

    2023-06-01T12:18:21.496763  + set +x

    2023-06-01T12:18:21.601733  / # #

    2023-06-01T12:18:21.702581  export SHELL=3D/bin/sh

    2023-06-01T12:18:21.702809  #

    2023-06-01T12:18:21.803347  / # export SHELL=3D/bin/sh. /lava-10552046/=
environment

    2023-06-01T12:18:21.803559  =


    2023-06-01T12:18:21.904101  / # . /lava-10552046/environment/lava-10552=
046/bin/lava-test-runner /lava-10552046/1

    2023-06-01T12:18:21.904399  =


    2023-06-01T12:18:21.909867  / # /lava-10552046/bin/lava-test-runner /la=
va-10552046/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64788d21dbfc3827242e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
43-g087e96594ba7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
43-g087e96594ba7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64788d21dbfc3827242e860c
        failing since 62 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-01T12:20:25.418987  + set<8>[   11.950070] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10552060_1.4.2.3.1>

    2023-06-01T12:20:25.419074   +x

    2023-06-01T12:20:25.523251  / # #

    2023-06-01T12:20:25.625747  export SHELL=3D/bin/sh

    2023-06-01T12:20:25.626483  #

    2023-06-01T12:20:25.727994  / # export SHELL=3D/bin/sh. /lava-10552060/=
environment

    2023-06-01T12:20:25.728960  =


    2023-06-01T12:20:25.830735  / # . /lava-10552060/environment/lava-10552=
060/bin/lava-test-runner /lava-10552060/1

    2023-06-01T12:20:25.832096  =


    2023-06-01T12:20:25.836825  / # /lava-10552060/bin/lava-test-runner /la=
va-10552060/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64788ca32824bbac772e8626

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
43-g087e96594ba7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
43-g087e96594ba7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64788ca32824bbac772e862b
        failing since 62 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-01T12:18:26.933688  <8>[   11.012977] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10552008_1.4.2.3.1>

    2023-06-01T12:18:26.937356  + set +x

    2023-06-01T12:18:27.038717  #

    2023-06-01T12:18:27.039174  =


    2023-06-01T12:18:27.139991  / # #export SHELL=3D/bin/sh

    2023-06-01T12:18:27.140206  =


    2023-06-01T12:18:27.240816  / # export SHELL=3D/bin/sh. /lava-10552008/=
environment

    2023-06-01T12:18:27.241045  =


    2023-06-01T12:18:27.341576  / # . /lava-10552008/environment/lava-10552=
008/bin/lava-test-runner /lava-10552008/1

    2023-06-01T12:18:27.341866  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64788dd977b7cd28622e85ea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
43-g087e96594ba7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
43-g087e96594ba7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64788dd977b7cd28622e85ef
        failing since 62 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-01T12:23:39.135109  + set +x

    2023-06-01T12:23:39.141994  <8>[   11.537529] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10552007_1.4.2.3.1>

    2023-06-01T12:23:39.246634  / # #

    2023-06-01T12:23:39.348143  export SHELL=3D/bin/sh

    2023-06-01T12:23:39.348369  #

    2023-06-01T12:23:39.448942  / # export SHELL=3D/bin/sh. /lava-10552007/=
environment

    2023-06-01T12:23:39.449127  =


    2023-06-01T12:23:39.549641  / # . /lava-10552007/environment/lava-10552=
007/bin/lava-test-runner /lava-10552007/1

    2023-06-01T12:23:39.549931  =


    2023-06-01T12:23:39.554306  / # /lava-10552007/bin/lava-test-runner /la=
va-10552007/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64788d4dc1145a89332e863a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
43-g087e96594ba7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
43-g087e96594ba7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64788d4dc1145a89332e863f
        failing since 62 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-01T12:21:13.611288  + set<8>[    9.926875] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10552055_1.4.2.3.1>

    2023-06-01T12:21:13.611453   +x

    2023-06-01T12:21:13.714396  #

    2023-06-01T12:21:13.815202  / # #export SHELL=3D/bin/sh

    2023-06-01T12:21:13.815393  =


    2023-06-01T12:21:13.915943  / # export SHELL=3D/bin/sh. /lava-10552055/=
environment

    2023-06-01T12:21:13.916163  =


    2023-06-01T12:21:14.016774  / # . /lava-10552055/environment/lava-10552=
055/bin/lava-test-runner /lava-10552055/1

    2023-06-01T12:21:14.017141  =


    2023-06-01T12:21:14.022547  / # /lava-10552055/bin/lava-test-runner /la=
va-10552055/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64788ca7fd93ee06812e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
43-g087e96594ba7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
43-g087e96594ba7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64788ca7fd93ee06812e85eb
        failing since 62 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-01T12:18:33.573990  + <8>[   10.942029] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10552029_1.4.2.3.1>

    2023-06-01T12:18:33.574077  set +x

    2023-06-01T12:18:33.678478  / # #

    2023-06-01T12:18:33.779142  export SHELL=3D/bin/sh

    2023-06-01T12:18:33.779382  #

    2023-06-01T12:18:33.879900  / # export SHELL=3D/bin/sh. /lava-10552029/=
environment

    2023-06-01T12:18:33.880107  =


    2023-06-01T12:18:33.980608  / # . /lava-10552029/environment/lava-10552=
029/bin/lava-test-runner /lava-10552029/1

    2023-06-01T12:18:33.981044  =


    2023-06-01T12:18:33.985827  / # /lava-10552029/bin/lava-test-runner /la=
va-10552029/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64788caafd93ee06812e85f7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
43-g087e96594ba7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
43-g087e96594ba7/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64788caafd93ee06812e85fc
        failing since 62 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-01T12:18:24.993781  <8>[   11.933181] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10552041_1.4.2.3.1>

    2023-06-01T12:18:25.098334  / # #

    2023-06-01T12:18:25.198893  export SHELL=3D/bin/sh

    2023-06-01T12:18:25.199079  #

    2023-06-01T12:18:25.299599  / # export SHELL=3D/bin/sh. /lava-10552041/=
environment

    2023-06-01T12:18:25.299776  =


    2023-06-01T12:18:25.400290  / # . /lava-10552041/environment/lava-10552=
041/bin/lava-test-runner /lava-10552041/1

    2023-06-01T12:18:25.400536  =


    2023-06-01T12:18:25.405085  / # /lava-10552041/bin/lava-test-runner /la=
va-10552041/1

    2023-06-01T12:18:25.411784  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647891943062e722292e85fe

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
43-g087e96594ba7/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31-=
43-g087e96594ba7/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/647891943062e722292e861a
        failing since 20 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-01T12:39:36.404813  /lava-10552104/1/../bin/lava-test-case

    2023-06-01T12:39:36.411469  <8>[   22.967455] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647891953062e722292e86a6
        failing since 20 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-01T12:39:30.959435  + set +x

    2023-06-01T12:39:30.966322  <8>[   17.520421] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10552104_1.5.2.3.1>

    2023-06-01T12:39:31.071504  / # #

    2023-06-01T12:39:31.172090  export SHELL=3D/bin/sh

    2023-06-01T12:39:31.172268  #

    2023-06-01T12:39:31.272727  / # export SHELL=3D/bin/sh. /lava-10552104/=
environment

    2023-06-01T12:39:31.272935  =


    2023-06-01T12:39:31.373436  / # . /lava-10552104/environment/lava-10552=
104/bin/lava-test-runner /lava-10552104/1

    2023-06-01T12:39:31.373711  =


    2023-06-01T12:39:31.378648  / # /lava-10552104/bin/lava-test-runner /la=
va-10552104/1
 =

    ... (13 line(s) more)  =

 =20
