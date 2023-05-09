Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D9C6FC25F
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 11:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjEIJIM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 05:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjEIJIM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 05:08:12 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94E3D2
        for <stable@vger.kernel.org>; Tue,  9 May 2023 02:08:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aad5245571so38401515ad.1
        for <stable@vger.kernel.org>; Tue, 09 May 2023 02:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683623289; x=1686215289;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fHRmjslBXRNydTlNG8QmXx5y4RDzDUs/AazOkuK18+k=;
        b=Fa+ihoDFNqKGsa5WLZPSi/9Rym61OuGebtso9+tP+74VYzkE0zIP4Afg+nY0S4e9Ge
         CeFrEbh8ymwHQhD4U2aEWmOR+pgLY1Ik1XJ84avDuopWAwqRx13m9V6ONnK81YwsevSz
         VeFG53mIa+GzyvJZ8A4l6hCQO2Bup6pJsM2ZVYP0pKo9hC7bt1ETKZAtzfm0ouagKEez
         eTQPHCNJrQ+K7eJ5e/5o4TxhdF9n6SbNFXaG5ndiF1hT6NVywmaTrXN8EwZu+av83y+U
         9RAKpxMzWYGf2DZawRO9rIra0EoTi5l4TT3vrDGX8qJO0H3ZliU+1fd67utb1lemxYoV
         s4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683623289; x=1686215289;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHRmjslBXRNydTlNG8QmXx5y4RDzDUs/AazOkuK18+k=;
        b=dCWbmFGcIZZ+lqDB3LG5XZ4Neb65KUFCCc7KTW3V8U5218ws4v3htoS/9/xgWfOmon
         AkAGFnm5eZ5bCZIfGxX1TL/p0tJy9PiOTrJtttYcjNpK2UbdxorqsJV7YHcAEJI10Abm
         NWHUMVfDpRfN162hEgMCVqNC+hFBF5xPqRbfiH/spR4agATeExQB2UT+rqiex8KkVxnN
         gHzhO1bOhR2Bl6ShmAcXpv8uTGt0dToJ+oj4SW3MnDyeiL6UJ7QSvrzJ8UmyI+mKp2TF
         j+LTyQlGgIqSvm1DR8vsoT/vq0V0dgDXhSLlja+87bY5Kn6dpD/QA4/+31/PG+ui9kcE
         3Owg==
X-Gm-Message-State: AC+VfDxM4JjiXjKF1Df8y+y8lYqaRBIgwjwp6UWLfAQmY5vHug9mxp74
        xAbazd3bbpOdRXmwdAgaGZ94sEsYfongzJffDhrpNg==
X-Google-Smtp-Source: ACHHUZ57lMFNyajcy1yXVkREFaN56jRup2Q6rlng0CaaI9QTAhLxq2kK3MHCBQoiHQJherInRVaSjQ==
X-Received: by 2002:a17:902:d2c9:b0:1ac:61ad:d6bd with SMTP id n9-20020a170902d2c900b001ac61add6bdmr10861760plc.65.1683623288611;
        Tue, 09 May 2023 02:08:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902704400b001aaf370b1c7sm988991plt.278.2023.05.09.02.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 02:08:08 -0700 (PDT)
Message-ID: <645a0d78.170a0220.b52f.1b54@mx.google.com>
Date:   Tue, 09 May 2023 02:08:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-1202-g2b7e1f92aa55
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 161 runs,
 9 regressions (v6.1.22-1202-g2b7e1f92aa55)
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

stable-rc/linux-6.1.y baseline: 161 runs, 9 regressions (v6.1.22-1202-g2b7e=
1f92aa55)

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
el/v6.1.22-1202-g2b7e1f92aa55/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.22-1202-g2b7e1f92aa55
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      2b7e1f92aa55cac65688b3de87716bbd0cbfb88d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459d9bc6084cf15562e8606

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1202-g2b7e1f92aa55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1202-g2b7e1f92aa55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459d9bc6084cf15562e860b
        failing since 39 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-09T05:27:02.251460  <8>[   11.322903] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10250657_1.4.2.3.1>

    2023-05-09T05:27:02.255038  + set +x

    2023-05-09T05:27:02.359397  / # #

    2023-05-09T05:27:02.460748  export SHELL=3D/bin/sh

    2023-05-09T05:27:02.460917  #

    2023-05-09T05:27:02.561422  / # export SHELL=3D/bin/sh. /lava-10250657/=
environment

    2023-05-09T05:27:02.561635  =


    2023-05-09T05:27:02.662173  / # . /lava-10250657/environment/lava-10250=
657/bin/lava-test-runner /lava-10250657/1

    2023-05-09T05:27:02.662488  =


    2023-05-09T05:27:02.668337  / # /lava-10250657/bin/lava-test-runner /la=
va-10250657/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459d9665570fb23d12e85eb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1202-g2b7e1f92aa55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1202-g2b7e1f92aa55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459d9665570fb23d12e85f0
        failing since 39 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-09T05:25:39.208500  + set +x<8>[   11.930749] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10250613_1.4.2.3.1>

    2023-05-09T05:25:39.208619  =


    2023-05-09T05:25:39.313325  / # #

    2023-05-09T05:25:39.413893  export SHELL=3D/bin/sh

    2023-05-09T05:25:39.414083  #

    2023-05-09T05:25:39.514547  / # export SHELL=3D/bin/sh. /lava-10250613/=
environment

    2023-05-09T05:25:39.514722  =


    2023-05-09T05:25:39.615262  / # . /lava-10250613/environment/lava-10250=
613/bin/lava-test-runner /lava-10250613/1

    2023-05-09T05:25:39.615531  =


    2023-05-09T05:25:39.620001  / # /lava-10250613/bin/lava-test-runner /la=
va-10250613/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459d959a536add7e12e8636

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1202-g2b7e1f92aa55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1202-g2b7e1f92aa55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459d959a536add7e12e863b
        failing since 39 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-09T05:25:35.005674  <8>[   10.524452] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10250604_1.4.2.3.1>

    2023-05-09T05:25:35.009204  + set +x

    2023-05-09T05:25:35.110796  =


    2023-05-09T05:25:35.211501  / # #export SHELL=3D/bin/sh

    2023-05-09T05:25:35.212128  =


    2023-05-09T05:25:35.313637  / # export SHELL=3D/bin/sh. /lava-10250604/=
environment

    2023-05-09T05:25:35.314442  =


    2023-05-09T05:25:35.415873  / # . /lava-10250604/environment/lava-10250=
604/bin/lava-test-runner /lava-10250604/1

    2023-05-09T05:25:35.417141  =


    2023-05-09T05:25:35.422423  / # /lava-10250604/bin/lava-test-runner /la=
va-10250604/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459d9cc8e3d6aea532e85ed

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1202-g2b7e1f92aa55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1202-g2b7e1f92aa55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459d9cc8e3d6aea532e85f2
        failing since 39 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-09T05:27:24.927197  + set +x

    2023-05-09T05:27:24.934196  <8>[   11.169051] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10250673_1.4.2.3.1>

    2023-05-09T05:27:25.038590  / # #

    2023-05-09T05:27:25.139201  export SHELL=3D/bin/sh

    2023-05-09T05:27:25.139377  #

    2023-05-09T05:27:25.240241  / # export SHELL=3D/bin/sh. /lava-10250673/=
environment

    2023-05-09T05:27:25.240708  =


    2023-05-09T05:27:25.341867  / # . /lava-10250673/environment/lava-10250=
673/bin/lava-test-runner /lava-10250673/1

    2023-05-09T05:27:25.343223  =


    2023-05-09T05:27:25.348198  / # /lava-10250673/bin/lava-test-runner /la=
va-10250673/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459d9780dca7bcd702e861e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1202-g2b7e1f92aa55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1202-g2b7e1f92aa55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459d9780dca7bcd702e8623
        failing since 39 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-09T05:25:45.489062  + set +x

    2023-05-09T05:25:45.495907  <8>[    7.863996] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10250649_1.4.2.3.1>

    2023-05-09T05:25:45.600218  / # #

    2023-05-09T05:25:45.701011  export SHELL=3D/bin/sh

    2023-05-09T05:25:45.701318  #

    2023-05-09T05:25:45.801951  / # export SHELL=3D/bin/sh. /lava-10250649/=
environment

    2023-05-09T05:25:45.802175  =


    2023-05-09T05:25:45.902756  / # . /lava-10250649/environment/lava-10250=
649/bin/lava-test-runner /lava-10250649/1

    2023-05-09T05:25:45.903194  =


    2023-05-09T05:25:45.908523  / # /lava-10250649/bin/lava-test-runner /la=
va-10250649/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459d96a0dca7bcd702e85f4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1202-g2b7e1f92aa55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1202-g2b7e1f92aa55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459d96a0dca7bcd702e85f9
        failing since 39 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-09T05:25:53.752999  + <8>[   11.423748] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10250670_1.4.2.3.1>

    2023-05-09T05:25:53.753101  set +x

    2023-05-09T05:25:53.857323  / # #

    2023-05-09T05:25:53.958010  export SHELL=3D/bin/sh

    2023-05-09T05:25:53.958218  #

    2023-05-09T05:25:54.058758  / # export SHELL=3D/bin/sh. /lava-10250670/=
environment

    2023-05-09T05:25:54.058972  =


    2023-05-09T05:25:54.159553  / # . /lava-10250670/environment/lava-10250=
670/bin/lava-test-runner /lava-10250670/1

    2023-05-09T05:25:54.159861  =


    2023-05-09T05:25:54.164661  / # /lava-10250670/bin/lava-test-runner /la=
va-10250670/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459d95233f71e9a672e8637

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1202-g2b7e1f92aa55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1202-g2b7e1f92aa55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459d95233f71e9a672e863c
        failing since 39 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-09T05:25:26.416915  + set<8>[   11.907806] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10250641_1.4.2.3.1>

    2023-05-09T05:25:26.417444   +x

    2023-05-09T05:25:26.524730  / # #

    2023-05-09T05:25:26.627039  export SHELL=3D/bin/sh

    2023-05-09T05:25:26.627788  #

    2023-05-09T05:25:26.729324  / # export SHELL=3D/bin/sh. /lava-10250641/=
environment

    2023-05-09T05:25:26.730084  =


    2023-05-09T05:25:26.831873  / # . /lava-10250641/environment/lava-10250=
641/bin/lava-test-runner /lava-10250641/1

    2023-05-09T05:25:26.833045  =


    2023-05-09T05:25:26.837825  / # /lava-10250641/bin/lava-test-runner /la=
va-10250641/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6459dc86eae76cd3432e86aa

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1202-g2b7e1f92aa55/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.22-=
1202-g2b7e1f92aa55/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6459dc86eae76cd3432e86c6
        failing since 1 day (last pass: v6.1.22-574-ge4ff6ff54dea, first fa=
il: v6.1.22-1197-g23b4e75cdd2e3)

    2023-05-09T05:39:06.119280  /lava-10250807/1/../bin/lava-test-case

    2023-05-09T05:39:06.125607  <8>[   22.975087] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459dc86eae76cd3432e8752
        failing since 1 day (last pass: v6.1.22-574-ge4ff6ff54dea, first fa=
il: v6.1.22-1197-g23b4e75cdd2e3)

    2023-05-09T05:39:00.645114  + set +x<8>[   17.496304] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10250807_1.5.2.3.1>

    2023-05-09T05:39:00.648443  =


    2023-05-09T05:39:00.756391  / # #

    2023-05-09T05:39:00.858616  export SHELL=3D/bin/sh

    2023-05-09T05:39:00.859426  #

    2023-05-09T05:39:00.960884  / # export SHELL=3D/bin/sh. /lava-10250807/=
environment

    2023-05-09T05:39:00.961679  =


    2023-05-09T05:39:01.063265  / # . /lava-10250807/environment/lava-10250=
807/bin/lava-test-runner /lava-10250807/1

    2023-05-09T05:39:01.064355  =


    2023-05-09T05:39:01.069402  / # /lava-10250807/bin/lava-test-runner /la=
va-10250807/1
 =

    ... (13 line(s) more)  =

 =20
