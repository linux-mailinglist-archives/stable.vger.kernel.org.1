Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F11F72024D
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 14:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbjFBMmf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 08:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjFBMme (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 08:42:34 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5910113D
        for <stable@vger.kernel.org>; Fri,  2 Jun 2023 05:42:31 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-53f8da65701so1102689a12.1
        for <stable@vger.kernel.org>; Fri, 02 Jun 2023 05:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685709750; x=1688301750;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+E1jcl8fT6HcNUJIQAmFGFMTMsbk2u1LNrppSE1Fomk=;
        b=xTZ6+Ei47Q0xkYRr7Cwsu/v35cq0GBC2w/ECl8i/rtWDiKxZb2uGAwYshpIDqV+M33
         boT5Q/D4mxlnQjU3p99f3anzfT0zFZXul63LllW8+jWXu7nXmVpq5zoNkAHT7I/f3ZrX
         v/02MBjcZQX+3Jr9er19BC1ktSA6HtXrNsDGl7m6IF7Fy1hip7QBn2WdwcCaC+Bu/k+V
         x9o4/VLW6pioEh6RaXEJ0elo3WYCHwmz1luh8cEGerAOxXuEossato9JCoXXJQ1ueFf6
         ztZQzNKuT+W2ufDeu+ll9h8PnwNXgWd9gTeD7xZVw5qchTTvCGXuxwQ/7li0s/5lzCE+
         ZSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685709750; x=1688301750;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+E1jcl8fT6HcNUJIQAmFGFMTMsbk2u1LNrppSE1Fomk=;
        b=lNGmyH82Tk2hrVxFwz1Cx75NVch684BPcmniTZa+LcHQOOvhJr9EeyqfDUF/VBPL8a
         xVXNSd5g3BqNNcUJ1kxF1sXLz0f2CxqNXxbc6/ozEyS7mEPjH/fWG29bG5fZOOR4dSNQ
         JfKX1K+3hw1OBTbg+afJU/HyEYYneeusS8X6x8FA1lXSfRPHH1BVqvSVQEY+t93dLB8Z
         ixwey4iN70FPhcTOmaA6HmX4CZ2RwshsVY8EbZdhfEWt0JQkfgz08Mqp5sUqzbMuDjpR
         oMR4TZiKN7kc/xc/pe0LeDU+KYy6VYcTdl7LJi0/98/0nFJUFJBn2c40V0V3Zseil5Cl
         xeNw==
X-Gm-Message-State: AC+VfDxVGsydvrj667cQMw3L/856Tzm1UyofHEBMygLKwDucu2OLPjyx
        FVZh3Q2vaepV8qH+E+TnpsBOrgE9oLvqKpaZ8szVkg==
X-Google-Smtp-Source: ACHHUZ7E4XzeZ6BZcaIKSx8e4Y1zwkcMzdRPQpcCZ71PWRMNx7BqDfpLpFaBkzasYjZKg803D/JXXQ==
X-Received: by 2002:a17:90b:4b09:b0:258:de21:f237 with SMTP id lx9-20020a17090b4b0900b00258de21f237mr644237pjb.9.1685709750052;
        Fri, 02 Jun 2023 05:42:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090adb8e00b00250aa8ef89csm1184805pjv.18.2023.06.02.05.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 05:42:29 -0700 (PDT)
Message-ID: <6479e3b5.170a0220.d7084.1cd3@mx.google.com>
Date:   Fri, 02 Jun 2023 05:42:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.114-38-g31e35d9f1b8d0
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.15.y baseline: 166 runs,
 14 regressions (v5.15.114-38-g31e35d9f1b8d0)
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

stable-rc/linux-5.15.y baseline: 166 runs, 14 regressions (v5.15.114-38-g31=
e35d9f1b8d0)

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

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.114-38-g31e35d9f1b8d0/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.114-38-g31e35d9f1b8d0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      31e35d9f1b8d02e82f497ba31231b0c9dc00380d =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6479af2a77b795355df5dea2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479af2a77b795355df5deab
        failing since 65 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-02T08:57:54.767976  <8>[   19.821570] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10561453_1.4.2.3.1>

    2023-06-02T08:57:54.771022  + set +x

    2023-06-02T08:57:54.878887  / # #

    2023-06-02T08:57:54.981322  export SHELL=3D/bin/sh

    2023-06-02T08:57:54.981532  #

    2023-06-02T08:57:55.082083  / # export SHELL=3D/bin/sh. /lava-10561453/=
environment

    2023-06-02T08:57:55.082256  =


    2023-06-02T08:57:55.182818  / # . /lava-10561453/environment/lava-10561=
453/bin/lava-test-runner /lava-10561453/1

    2023-06-02T08:57:55.183851  =


    2023-06-02T08:57:55.190068  / # /lava-10561453/bin/lava-test-runner /la=
va-10561453/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6479afc9971eae1a31f5de44

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479afc9971eae1a31f5de4d
        failing since 65 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-02T09:00:52.221329  + set<8>[   10.961753] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10561521_1.4.2.3.1>

    2023-06-02T09:00:52.221918   +x

    2023-06-02T09:00:52.329770  / # #

    2023-06-02T09:00:52.432359  export SHELL=3D/bin/sh

    2023-06-02T09:00:52.433153  #

    2023-06-02T09:00:52.534802  / # export SHELL=3D/bin/sh. /lava-10561521/=
environment

    2023-06-02T09:00:52.535596  =


    2023-06-02T09:00:52.637229  / # . /lava-10561521/environment/lava-10561=
521/bin/lava-test-runner /lava-10561521/1

    2023-06-02T09:00:52.638594  =


    2023-06-02T09:00:52.643904  / # /lava-10561521/bin/lava-test-runner /la=
va-10561521/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6479aecf9d56cf327df5dea9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479aecf9d56cf327df5deb2
        failing since 65 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-02T08:56:28.367204  <8>[   11.373052] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10561447_1.4.2.3.1>

    2023-06-02T08:56:28.370666  + set +x

    2023-06-02T08:56:28.472128  =


    2023-06-02T08:56:28.572724  / # #export SHELL=3D/bin/sh

    2023-06-02T08:56:28.572933  =


    2023-06-02T08:56:28.673505  / # export SHELL=3D/bin/sh. /lava-10561447/=
environment

    2023-06-02T08:56:28.673705  =


    2023-06-02T08:56:28.774219  / # . /lava-10561447/environment/lava-10561=
447/bin/lava-test-runner /lava-10561447/1

    2023-06-02T08:56:28.774497  =


    2023-06-02T08:56:28.779343  / # /lava-10561447/bin/lava-test-runner /la=
va-10561447/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6479afe6f2fff0728df5de34

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6479afe6f2fff0728df5d=
e35
        failing since 385 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6479b206dce859c0b2f5de2a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479b206dce859c0b2f5de33
        failing since 136 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-02T09:10:15.513431  <8>[    9.950138] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3636675_1.5.2.4.1>
    2023-06-02T09:10:15.626216  / # #
    2023-06-02T09:10:15.730126  export SHELL=3D/bin/sh
    2023-06-02T09:10:15.731435  #
    2023-06-02T09:10:15.731998  / # <3>[   10.113171] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-06-02T09:10:15.834530  export SHELL=3D/bin/sh. /lava-3636675/envir=
onment
    2023-06-02T09:10:15.835738  =

    2023-06-02T09:10:15.938299  / # . /lava-3636675/environment/lava-363667=
5/bin/lava-test-runner /lava-3636675/1
    2023-06-02T09:10:15.940404  =

    2023-06-02T09:10:15.944880  / # /lava-3636675/bin/lava-test-runner /lav=
a-3636675/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6479b01aff971c52fbf5de26

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479b01aff971c52fbf5de2f
        failing since 65 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-02T09:02:02.546857  + <8>[   10.697368] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10561499_1.4.2.3.1>

    2023-06-02T09:02:02.546965  set +x

    2023-06-02T09:02:02.648135  #

    2023-06-02T09:02:02.749043  / # #export SHELL=3D/bin/sh

    2023-06-02T09:02:02.749267  =


    2023-06-02T09:02:02.849806  / # export SHELL=3D/bin/sh. /lava-10561499/=
environment

    2023-06-02T09:02:02.850022  =


    2023-06-02T09:02:02.950620  / # . /lava-10561499/environment/lava-10561=
499/bin/lava-test-runner /lava-10561499/1

    2023-06-02T09:02:02.950936  =


    2023-06-02T09:02:02.956115  / # /lava-10561499/bin/lava-test-runner /la=
va-10561499/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6479af770b60e29a0ff5de2b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479af770b60e29a0ff5de34
        failing since 65 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-02T08:59:14.549701  <8>[   10.883170] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10561454_1.4.2.3.1>

    2023-06-02T08:59:14.553372  + set +x

    2023-06-02T08:59:14.657435  / # #

    2023-06-02T08:59:14.758238  export SHELL=3D/bin/sh

    2023-06-02T08:59:14.758509  #

    2023-06-02T08:59:14.859016  / # export SHELL=3D/bin/sh. /lava-10561454/=
environment

    2023-06-02T08:59:14.859288  =


    2023-06-02T08:59:14.959841  / # . /lava-10561454/environment/lava-10561=
454/bin/lava-test-runner /lava-10561454/1

    2023-06-02T08:59:14.960128  =


    2023-06-02T08:59:14.964962  / # /lava-10561454/bin/lava-test-runner /la=
va-10561454/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6479aed11422668ec6f5de2d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479aed11422668ec6f5de36
        failing since 65 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-02T08:56:38.571010  + set<8>[   11.354580] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10561493_1.4.2.3.1>

    2023-06-02T08:56:38.571111   +x

    2023-06-02T08:56:38.675399  / # #

    2023-06-02T08:56:38.776221  export SHELL=3D/bin/sh

    2023-06-02T08:56:38.776460  #

    2023-06-02T08:56:38.877001  / # export SHELL=3D/bin/sh. /lava-10561493/=
environment

    2023-06-02T08:56:38.877237  =


    2023-06-02T08:56:38.977788  / # . /lava-10561493/environment/lava-10561=
493/bin/lava-test-runner /lava-10561493/1

    2023-06-02T08:56:38.978116  =


    2023-06-02T08:56:38.982750  / # /lava-10561493/bin/lava-test-runner /la=
va-10561493/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6479b1d81c84e2083df5deb6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline=
-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479b1d81c84e2083df5debf
        failing since 122 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-06-02T09:09:25.180498  + set +x
    2023-06-02T09:09:25.180800  [    9.391115] <LAVA_SIGNAL_ENDRUN 0_dmesg =
965235_1.5.2.3.1>
    2023-06-02T09:09:25.287732  / # #
    2023-06-02T09:09:25.389237  export SHELL=3D/bin/sh
    2023-06-02T09:09:25.389659  #
    2023-06-02T09:09:25.490921  / # export SHELL=3D/bin/sh. /lava-965235/en=
vironment
    2023-06-02T09:09:25.491309  =

    2023-06-02T09:09:25.592504  / # . /lava-965235/environment/lava-965235/=
bin/lava-test-runner /lava-965235/1
    2023-06-02T09:09:25.593150  =

    2023-06-02T09:09:25.595212  / # /lava-965235/bin/lava-test-runner /lava=
-965235/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6479aeec5b681456c0f5de2a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479aeec5b681456c0f5de33
        failing since 65 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-02T08:56:53.295541  <8>[   11.481501] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10561525_1.4.2.3.1>

    2023-06-02T08:56:53.400154  / # #

    2023-06-02T08:56:53.500918  export SHELL=3D/bin/sh

    2023-06-02T08:56:53.501140  #

    2023-06-02T08:56:53.601693  / # export SHELL=3D/bin/sh. /lava-10561525/=
environment

    2023-06-02T08:56:53.601996  =


    2023-06-02T08:56:53.702559  / # . /lava-10561525/environment/lava-10561=
525/bin/lava-test-runner /lava-10561525/1

    2023-06-02T08:56:53.702906  =


    2023-06-02T08:56:53.708037  / # /lava-10561525/bin/lava-test-runner /la=
va-10561525/1

    2023-06-02T08:56:53.713186  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/6479b01cbdb8d47ab0f5de79

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
14-38-g31e35d9f1b8d0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/=
baseline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6479b01cbdb8d47ab0f5de97
        failing since 18 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-02T09:02:01.995601  /lava-10561566/1/../bin/lava-test-case

    2023-06-02T09:02:02.001668  <8>[   61.503217] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/6479b01cbdb8d47ab0f5de97
        failing since 18 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-02T09:02:01.995601  /lava-10561566/1/../bin/lava-test-case

    2023-06-02T09:02:02.001668  <8>[   61.503217] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6479b01cbdb8d47ab0f5decb
        failing since 18 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-02T09:02:00.955787  /lava-10561566/1/../bin/lava-test-case

    2023-06-02T09:02:00.962330  <8>[   60.463585] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6479b01cbdb8d47ab0f5df21
        failing since 18 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-02T09:01:46.803854  + set +x

    2023-06-02T09:01:46.810657  <8>[   46.312060] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10561566_1.5.2.3.1>

    2023-06-02T09:01:46.915362  / # #

    2023-06-02T09:01:47.016076  export SHELL=3D/bin/sh

    2023-06-02T09:01:47.016264  #

    2023-06-02T09:01:47.116771  / # export SHELL=3D/bin/sh. /lava-10561566/=
environment

    2023-06-02T09:01:47.117010  =


    2023-06-02T09:01:47.217537  / # . /lava-10561566/environment/lava-10561=
566/bin/lava-test-runner /lava-10561566/1

    2023-06-02T09:01:47.217819  =


    2023-06-02T09:01:47.222947  / # /lava-10561566/bin/lava-test-runner /la=
va-10561566/1
 =

    ... (13 line(s) more)  =

 =20
