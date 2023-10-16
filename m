Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEBC7CA9DA
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 15:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjJPNj7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 09:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjJPNjj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 09:39:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E58D40
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 06:39:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9d922c039so36410185ad.3
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 06:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697463575; x=1698068375; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wJg/bjoG0SWoapkAklzn6FTCDCn2VM6HsXukG2TAKBE=;
        b=pPasUk+idmtia0/0tdNzLG+waRU0HMleZdVJN44wVmYF/YTb2buaPBMY8mb/Tnbb+9
         nA6aMUpVri4Zof3JqkoCzyzSw27M0CIHJn2jWh0d/qqOEdBmpoLZWBthcWmAKkZNS4Ib
         IfSKg0tBohx1s808sR3vEBIZs+0LjpdJjkeQ/PLhPqkiklw5Qz51La0RhVpFuraf059t
         T9oAWSwz0PGDCLgzh17GGVaK6albAOOPv628YzuVicL5FUeEG7wSgxKTlWSEAj+GkKr3
         DXQr/TuQPtO1Ujkj3YD2YPVzst8VgYjlliiBv6dfLxsHxCTo+Li6Z+A0K4W+o3iCt5QQ
         WOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697463575; x=1698068375;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJg/bjoG0SWoapkAklzn6FTCDCn2VM6HsXukG2TAKBE=;
        b=R7QA0kvnNE2hIEmRLhD0U80tCZheuoG4+b9ihC4Z57nvEHpyvI0RyVn1TWhTM71b+D
         rgAE6XoHcyQV6puxehHbd9iDLXj9UFaB8b6ZS2cD/zevCkNYlOyOf7dw60Qqt/AAIdVn
         A3TTg5tOjTDaLYdgqxYzuhRROOMKlsZWSCGCFp3/us4l4QUfvxN5DgfTrr4wkR0qEsf0
         g4vRWR7m9598F4/da4VUeFjZ5j3dqjJsxWbzG3TO/E8M/5fKWIFRVhbCAPJhUhviQp5X
         a36ARPq6TCSW3pnl0aKrIiHwiJliLi9XGRDcTWqVAxs/N2x2kXL8bmfmF7L74m9Xiox/
         cZ/Q==
X-Gm-Message-State: AOJu0YylWldQs0ing1Hp84J5xr047J/82fagWnlWgK8GzH3/8hzbDhsY
        vGIVc/03PZozhZdXK/SxsRLif+/K6Gud3kS6R84evQ==
X-Google-Smtp-Source: AGHT+IExRB8qZ6IYua7WFAFcyUrvz2F7KI5jEjM+ypDVjj51GdPEv27W55XBiYOiPedqN7+5O1yDTA==
X-Received: by 2002:a17:902:720a:b0:1c5:a7b7:291c with SMTP id ba10-20020a170902720a00b001c5a7b7291cmr35792125plb.12.1697463574558;
        Mon, 16 Oct 2023 06:39:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i16-20020a170902c95000b001c73f51e61csm8463106pla.106.2023.10.16.06.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 06:39:33 -0700 (PDT)
Message-ID: <652d3d15.170a0220.1ed86.866d@mx.google.com>
Date:   Mon, 16 Oct 2023 06:39:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.58-132-g9b707223d2e98
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y baseline: 166 runs,
 10 regressions (v6.1.58-132-g9b707223d2e98)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y baseline: 166 runs, 10 regressions (v6.1.58-132-g9b70=
7223d2e98)

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

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

sun50i-h6-pine-h64           | arm64  | lab-clabbe      | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.58-132-g9b707223d2e98/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.58-132-g9b707223d2e98
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      9b707223d2e986b8728181d9fb2547d1bbf8c23a =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652d09dd6be937eff3efcf64

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d09dd6be937eff3efcf6d
        failing since 199 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-16T10:00:53.021623  <8>[   10.916758] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11788685_1.4.2.3.1>

    2023-10-16T10:00:53.021734  + set +x

    2023-10-16T10:00:53.126128  / # #

    2023-10-16T10:00:53.226695  export SHELL=3D/bin/sh

    2023-10-16T10:00:53.226889  #

    2023-10-16T10:00:53.327412  / # export SHELL=3D/bin/sh. /lava-11788685/=
environment

    2023-10-16T10:00:53.327619  =


    2023-10-16T10:00:53.428104  / # . /lava-11788685/environment/lava-11788=
685/bin/lava-test-runner /lava-11788685/1

    2023-10-16T10:00:53.428429  =


    2023-10-16T10:00:53.433945  / # /lava-11788685/bin/lava-test-runner /la=
va-11788685/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652d09d16518a4ecc3efcf1c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d09d16518a4ecc3efcf25
        failing since 199 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-16T10:00:31.252040  + set<8>[   11.085360] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11788658_1.4.2.3.1>

    2023-10-16T10:00:31.252131   +x

    2023-10-16T10:00:31.356459  / # #

    2023-10-16T10:00:31.457077  export SHELL=3D/bin/sh

    2023-10-16T10:00:31.457260  #

    2023-10-16T10:00:31.557764  / # export SHELL=3D/bin/sh. /lava-11788658/=
environment

    2023-10-16T10:00:31.557953  =


    2023-10-16T10:00:31.658531  / # . /lava-11788658/environment/lava-11788=
658/bin/lava-test-runner /lava-11788658/1

    2023-10-16T10:00:31.658783  =


    2023-10-16T10:00:31.663757  / # /lava-11788658/bin/lava-test-runner /la=
va-11788658/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652d09dff9082fe35eefcf76

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d09dff9082fe35eefcf7f
        failing since 199 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-16T10:01:05.404183  <8>[   10.160940] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11788682_1.4.2.3.1>

    2023-10-16T10:01:05.407668  + set +x

    2023-10-16T10:01:05.508845  /#

    2023-10-16T10:01:05.609604   # #export SHELL=3D/bin/sh

    2023-10-16T10:01:05.609781  =


    2023-10-16T10:01:05.710314  / # export SHELL=3D/bin/sh. /lava-11788682/=
environment

    2023-10-16T10:01:05.710537  =


    2023-10-16T10:01:05.811083  / # . /lava-11788682/environment/lava-11788=
682/bin/lava-test-runner /lava-11788682/1

    2023-10-16T10:01:05.811433  =


    2023-10-16T10:01:05.816345  / # /lava-11788682/bin/lava-test-runner /la=
va-11788682/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/652d0c93cf0c4c082defcf26

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/652d0c93cf0c4c082defc=
f27
        failing since 130 days (last pass: v6.1.31-40-g7d0a9678d276, first =
fail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652d09ce1a0b5c4a4cefcf0f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d09ce1a0b5c4a4cefcf18
        failing since 199 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-16T10:00:46.529283  + set +x

    2023-10-16T10:00:46.535702  <8>[   10.538768] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11788675_1.4.2.3.1>

    2023-10-16T10:00:46.640377  / # #

    2023-10-16T10:00:46.742671  export SHELL=3D/bin/sh

    2023-10-16T10:00:46.743378  #

    2023-10-16T10:00:46.844819  / # export SHELL=3D/bin/sh. /lava-11788675/=
environment

    2023-10-16T10:00:46.845501  =


    2023-10-16T10:00:46.947053  / # . /lava-11788675/environment/lava-11788=
675/bin/lava-test-runner /lava-11788675/1

    2023-10-16T10:00:46.948334  =


    2023-10-16T10:00:46.952642  / # /lava-11788675/bin/lava-test-runner /la=
va-11788675/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652d09cb6518a4ecc3efcf0d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d09cb6518a4ecc3efcf16
        failing since 199 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-16T10:00:30.687188  + set<8>[   10.741930] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11788646_1.4.2.3.1>

    2023-10-16T10:00:30.687275   +x

    2023-10-16T10:00:30.791866  / # #

    2023-10-16T10:00:30.892479  export SHELL=3D/bin/sh

    2023-10-16T10:00:30.892685  #

    2023-10-16T10:00:30.993267  / # export SHELL=3D/bin/sh. /lava-11788646/=
environment

    2023-10-16T10:00:30.993467  =


    2023-10-16T10:00:31.094051  / # . /lava-11788646/environment/lava-11788=
646/bin/lava-test-runner /lava-11788646/1

    2023-10-16T10:00:31.094383  =


    2023-10-16T10:00:31.098845  / # /lava-11788646/bin/lava-test-runner /la=
va-11788646/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/652d0c143d8282cefbefcf42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d0c143d8282cefbefcf4b
        new failure (last pass: v6.1.58)

    2023-10-16T10:10:04.805269  + set[   14.964854] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1003496_1.5.2.3.1>
    2023-10-16T10:10:04.805493   +x
    2023-10-16T10:10:04.911652  / # #
    2023-10-16T10:10:05.013387  export SHELL=3D/bin/sh
    2023-10-16T10:10:05.013962  #
    2023-10-16T10:10:05.115319  / # export SHELL=3D/bin/sh. /lava-1003496/e=
nvironment
    2023-10-16T10:10:05.115915  =

    2023-10-16T10:10:05.217347  / # . /lava-1003496/environment/lava-100349=
6/bin/lava-test-runner /lava-1003496/1
    2023-10-16T10:10:05.218183  =

    2023-10-16T10:10:05.221189  / # /lava-1003496/bin/lava-test-runner /lav=
a-1003496/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/652d09e0afe4882b41efcef5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d09e0afe4882b41efcefe
        failing since 199 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-10-16T10:00:50.290215  + set +x<8>[   11.039837] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11788729_1.4.2.3.1>

    2023-10-16T10:00:50.290302  =


    2023-10-16T10:00:50.395096  / # #

    2023-10-16T10:00:50.495681  export SHELL=3D/bin/sh

    2023-10-16T10:00:50.495869  #

    2023-10-16T10:00:50.596360  / # export SHELL=3D/bin/sh. /lava-11788729/=
environment

    2023-10-16T10:00:50.596543  =


    2023-10-16T10:00:50.697048  / # . /lava-11788729/environment/lava-11788=
729/bin/lava-test-runner /lava-11788729/1

    2023-10-16T10:00:50.697325  =


    2023-10-16T10:00:50.701861  / # /lava-11788729/bin/lava-test-runner /la=
va-11788729/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-clabbe      | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652d0a74059e667fd7efcf34

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d0a74059e667fd7efcf3d
        failing since 5 days (last pass: v6.1.22-178-gf8a7fa4a96bb, first f=
ail: v6.1.57)

    2023-10-16T10:03:19.500009  / # #
    2023-10-16T10:03:19.601789  export SHELL=3D/bin/sh
    2023-10-16T10:03:19.602388  #
    2023-10-16T10:03:19.703468  / # export SHELL=3D/bin/sh. /lava-438830/en=
vironment
    2023-10-16T10:03:19.704157  =

    2023-10-16T10:03:19.805228  / # . /lava-438830/environment/lava-438830/=
bin/lava-test-runner /lava-438830/1
    2023-10-16T10:03:19.806217  =

    2023-10-16T10:03:19.808521  / # /lava-438830/bin/lava-test-runner /lava=
-438830/1
    2023-10-16T10:03:19.887957  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-16T10:03:19.888363  + cd /lava-438830/<8>[   18.609141] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 438830_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/652d0a913f28daf617efcf09

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.58-=
132-g9b707223d2e98/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/652d0a913f28daf617efcf12
        failing since 5 days (last pass: v6.1.22-178-gf8a7fa4a96bb, first f=
ail: v6.1.57)

    2023-10-16T10:08:15.845496  / # #

    2023-10-16T10:08:15.947849  export SHELL=3D/bin/sh

    2023-10-16T10:08:15.948618  #

    2023-10-16T10:08:16.050102  / # export SHELL=3D/bin/sh. /lava-11788761/=
environment

    2023-10-16T10:08:16.050880  =


    2023-10-16T10:08:16.152422  / # . /lava-11788761/environment/lava-11788=
761/bin/lava-test-runner /lava-11788761/1

    2023-10-16T10:08:16.153645  =


    2023-10-16T10:08:16.156171  / # /lava-11788761/bin/lava-test-runner /la=
va-11788761/1

    2023-10-16T10:08:16.235954  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-16T10:08:16.236461  + cd /lava-1178876<8>[   18.759944] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11788761_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
