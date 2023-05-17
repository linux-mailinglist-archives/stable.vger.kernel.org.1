Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDFE706D70
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 17:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjEQPze (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 11:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjEQPza (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 11:55:30 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2BE9EF3
        for <stable@vger.kernel.org>; Wed, 17 May 2023 08:55:16 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6439f186366so678626b3a.2
        for <stable@vger.kernel.org>; Wed, 17 May 2023 08:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684338915; x=1686930915;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E70hRCkqPI0SDe2AGV6ysGhhyjl2l+NjsUa13Oq3hZU=;
        b=ICJ60I4EZBttECDJBQs95FOoXwS/iaBYJNqzzTd+6SADk8toVIwUxx2dJZ3lrNwfap
         RzD83SzDXR2xibXqycRyF7+nlFZ2X0p9npAT3SQR6aPGGE8rj9wtSORWzLHjh6p+iFmh
         lcej6h1nJ/zD8aDyAGQcXRPqDje28ALRDbE8Xx3txPlFWiyzD+bXXIsxCdJhirwVL1ge
         +7q107enooAOOBL1HHA1A10Yre0RKX/P+3VvTnNQBZ7ovTaGuEtUa+S43eF8Br6Zn/Zm
         gzqmQRG7HsuOr2jZLmOYVYBxu6EU1pK9LT+WaVwCPdaEj29J9B+dyOiWIWPTMycvJ2l7
         PdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684338915; x=1686930915;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E70hRCkqPI0SDe2AGV6ysGhhyjl2l+NjsUa13Oq3hZU=;
        b=cF0QfO+B8bOGxqmxcYXsQ5lfAKH4eMwEre9MYPgtxWzf3FJNg7Lv5Ms084OA14Oduk
         6CsL7rn9cKm9jdzMAQFmydTdMi1T5JP4fbOxGueP7y3Kbh/PGnDGO+SeXNdICrHgTynZ
         j6HaBD9s40lsIQ4n1xMPudFOdxychKIvcnv4/6uqznD4S2iGPupw1IG1ciaqMnDlh5ER
         vPAUOYFuHnA/wQG9ojkOgdqQBphSN0xbwCByrOsR4KZyOKJlRYJ2zzHS1tPA8cU//V4U
         fBXftsehSbe1adJHSrwFhrmy3d+pIBuHC6d9EploZkK21eOKgOa90jO93NYMfrfCtye0
         vZgQ==
X-Gm-Message-State: AC+VfDzDL1+ihKCOwX+2AHZPyfwbbT6iV3UeS9+9YjJohqVGj0Qd1oU/
        GSfxzWPSmZJmq4Wv2vuChObCtgGVHVACw6mwoXdfSA==
X-Google-Smtp-Source: ACHHUZ6biUwkeq1o1wQvl8M/JAUV6M52Ji1QD3mMpivLK+nHE6Uyj+MhsTTk7iDUTN07acZE8AZdRA==
X-Received: by 2002:a05:6a00:21ca:b0:64c:ecf7:f49a with SMTP id t10-20020a056a0021ca00b0064cecf7f49amr107924pfj.21.1684338915227;
        Wed, 17 May 2023 08:55:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b0062a7462d398sm15847584pfm.170.2023.05.17.08.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:55:14 -0700 (PDT)
Message-ID: <6464f8e2.a70a0220.94f25.f928@mx.google.com>
Date:   Wed, 17 May 2023 08:55:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.111-133-g7ffe4e3b2d69
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 158 runs,
 6 regressions (v5.15.111-133-g7ffe4e3b2d69)
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

stable-rc/queue/5.15 baseline: 158 runs, 6 regressions (v5.15.111-133-g7ffe=
4e3b2d69)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.111-133-g7ffe4e3b2d69/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.111-133-g7ffe4e3b2d69
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      7ffe4e3b2d695018234dc6ba8fd39cf5a1e28332 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c6739e8661b2662e8611

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-g7ffe4e3b2d69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-g7ffe4e3b2d69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c6739e8661b2662e8616
        failing since 50 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-17T12:19:56.143097  + <8>[   11.787438] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10352079_1.4.2.3.1>

    2023-05-17T12:19:56.143206  set +x

    2023-05-17T12:19:56.247112  / # #

    2023-05-17T12:19:56.347759  export SHELL=3D/bin/sh

    2023-05-17T12:19:56.348003  #

    2023-05-17T12:19:56.448575  / # export SHELL=3D/bin/sh. /lava-10352079/=
environment

    2023-05-17T12:19:56.448804  =


    2023-05-17T12:19:56.549355  / # . /lava-10352079/environment/lava-10352=
079/bin/lava-test-runner /lava-10352079/1

    2023-05-17T12:19:56.549635  =


    2023-05-17T12:19:56.554042  / # /lava-10352079/bin/lava-test-runner /la=
va-10352079/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c54a13a21066262e85e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-g7ffe4e3b2d69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-g7ffe4e3b2d69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c54a13a21066262e85ee
        failing since 50 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-17T12:14:46.169175  <8>[   10.591773] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10352059_1.4.2.3.1>

    2023-05-17T12:14:46.172288  + set +x

    2023-05-17T12:14:46.274071  =


    2023-05-17T12:14:46.374743  / # #export SHELL=3D/bin/sh

    2023-05-17T12:14:46.374977  =


    2023-05-17T12:14:46.475517  / # export SHELL=3D/bin/sh. /lava-10352059/=
environment

    2023-05-17T12:14:46.475726  =


    2023-05-17T12:14:46.576274  / # . /lava-10352059/environment/lava-10352=
059/bin/lava-test-runner /lava-10352059/1

    2023-05-17T12:14:46.576551  =


    2023-05-17T12:14:46.581940  / # /lava-10352059/bin/lava-test-runner /la=
va-10352059/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c55913a21066262e861e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-g7ffe4e3b2d69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-g7ffe4e3b2d69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c55913a21066262e8623
        failing since 50 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-17T12:15:06.213271  + <8>[   10.045044] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10352061_1.4.2.3.1>

    2023-05-17T12:15:06.213412  set +x

    2023-05-17T12:15:06.314692  #

    2023-05-17T12:15:06.415600  / # #export SHELL=3D/bin/sh

    2023-05-17T12:15:06.415830  =


    2023-05-17T12:15:06.516402  / # export SHELL=3D/bin/sh. /lava-10352061/=
environment

    2023-05-17T12:15:06.516660  =


    2023-05-17T12:15:06.617290  / # . /lava-10352061/environment/lava-10352=
061/bin/lava-test-runner /lava-10352061/1

    2023-05-17T12:15:06.617599  =


    2023-05-17T12:15:06.622405  / # /lava-10352061/bin/lava-test-runner /la=
va-10352061/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c52a9a20a1aed62e85ee

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-g7ffe4e3b2d69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-g7ffe4e3b2d69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c52a9a20a1aed62e85f3
        failing since 50 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-17T12:14:18.883080  + set +x<8>[   10.024532] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10352053_1.4.2.3.1>

    2023-05-17T12:14:18.883178  =


    2023-05-17T12:14:18.984930  #

    2023-05-17T12:14:19.085822  / # #export SHELL=3D/bin/sh

    2023-05-17T12:14:19.086043  =


    2023-05-17T12:14:19.186596  / # export SHELL=3D/bin/sh. /lava-10352053/=
environment

    2023-05-17T12:14:19.186791  =


    2023-05-17T12:14:19.287310  / # . /lava-10352053/environment/lava-10352=
053/bin/lava-test-runner /lava-10352053/1

    2023-05-17T12:14:19.287712  =


    2023-05-17T12:14:19.292420  / # /lava-10352053/bin/lava-test-runner /la=
va-10352053/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c540f6634155982e8636

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-g7ffe4e3b2d69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-g7ffe4e3b2d69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c540f6634155982e863b
        failing since 50 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-17T12:14:33.527223  + set<8>[   10.585014] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10352016_1.4.2.3.1>

    2023-05-17T12:14:33.527768   +x

    2023-05-17T12:14:33.634981  / # #

    2023-05-17T12:14:33.735656  export SHELL=3D/bin/sh

    2023-05-17T12:14:33.735843  #

    2023-05-17T12:14:33.836386  / # export SHELL=3D/bin/sh. /lava-10352016/=
environment

    2023-05-17T12:14:33.836596  =


    2023-05-17T12:14:33.937101  / # . /lava-10352016/environment/lava-10352=
016/bin/lava-test-runner /lava-10352016/1

    2023-05-17T12:14:33.937392  =


    2023-05-17T12:14:33.941622  / # /lava-10352016/bin/lava-test-runner /la=
va-10352016/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c52831a7b3ec932e85f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-g7ffe4e3b2d69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-133-g7ffe4e3b2d69/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c52831a7b3ec932e85fb
        failing since 50 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-17T12:14:19.195709  + set<8>[    9.592556] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10352032_1.4.2.3.1>

    2023-05-17T12:14:19.195826   +x

    2023-05-17T12:14:19.300132  / # #

    2023-05-17T12:14:19.400850  export SHELL=3D/bin/sh

    2023-05-17T12:14:19.401087  #

    2023-05-17T12:14:19.501652  / # export SHELL=3D/bin/sh. /lava-10352032/=
environment

    2023-05-17T12:14:19.501901  =


    2023-05-17T12:14:19.602377  / # . /lava-10352032/environment/lava-10352=
032/bin/lava-test-runner /lava-10352032/1

    2023-05-17T12:14:19.602730  =


    2023-05-17T12:14:19.606859  / # /lava-10352032/bin/lava-test-runner /la=
va-10352032/1
 =

    ... (12 line(s) more)  =

 =20
