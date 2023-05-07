Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4076F987C
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 14:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjEGMoa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 08:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEGMo2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 08:44:28 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9252A189
        for <stable@vger.kernel.org>; Sun,  7 May 2023 05:44:26 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-51b661097bfso2419905a12.0
        for <stable@vger.kernel.org>; Sun, 07 May 2023 05:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683463465; x=1686055465;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X1w8DAbhxXSCdw25M/oE+OnRo55VKz0hBb2vh77RJ4c=;
        b=qCjuC10GBqnih0Db/epL9BhE8wCXTjlGu3GOkCpcA+f8q8nBMz12RSUOmXI26Vf5xY
         eADy+frXBv2ej/qwHWnOThHrOQYY3jvNFK8OgljSBDFFlyfYoWdwim5xGwIibmRrLe6x
         qXOheL7IvEhL8M7IAMyRogCIxp1DlM93WDAs8em0Iq9XPtBbyzDk4XZMCsdTva9qhJGP
         6H2244quKeNcDZ3sVDz4dsXi+U9Bsqo6Fteu8vbzf9fF8JyQRWhbhrasBWm4vW4J1vfW
         F5Fk0LPWyJaXU2h18AFlfGUILnmWcOvcHz24eYKKECBsnqBCtsZIUWxBxVQB/mu7PRak
         cAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683463465; x=1686055465;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1w8DAbhxXSCdw25M/oE+OnRo55VKz0hBb2vh77RJ4c=;
        b=kKZnpwHgTfhaJkO2I2CA0Z/eUaU60paUW1eJy7DS8B5kdQqPmqNGoBSAvw7GKmATaT
         RbX/6JUfWXSf6L3+CvdmcA7UXsVwnDOG7BxNuVHPxj5yjRV0gQwFZ2ftDLl5aQCK2gy9
         8S1R6ZWEDR6Tk4u8Gm0YaiA6cw6scO76W0xXGKhsXSQSXzoG3upZW4BPcHt45L1bvMUy
         hOJZ4vALioeuAYgviSimjZLxb+/OtfFHWQ5Upj2M+DRahak18FnM6hzuoF0X+a9qcAVj
         8Me30nQtJhfnRAk3shI6kGrFwvv/tUpX4TRLjdNjb1eHNEnQwtsdvC1HHUWYaH91BnrZ
         WmLQ==
X-Gm-Message-State: AC+VfDxmGE1mZx2UjvhtxqqNoLfogfkL94hz/DnxTERjMgarkLyN4P1g
        pk3H1Nx40DmOXPJ+hFnBhMmuQNCPdIUhVXHacHMqBw==
X-Google-Smtp-Source: ACHHUZ4eCxv6iQxB8AK8DciEFXu3dwtwga6zsPFoxKqsklf+m+G1dprofPnAu1ZXhnFNDyAxDAa87g==
X-Received: by 2002:a17:902:eccc:b0:1a6:6b85:7b4a with SMTP id a12-20020a170902eccc00b001a66b857b4amr8800273plh.18.1683463465445;
        Sun, 07 May 2023 05:44:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b10-20020a1709027e0a00b001a19196af48sm5151701plm.64.2023.05.07.05.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 05:44:24 -0700 (PDT)
Message-ID: <64579d28.170a0220.3e0a5.8e3b@mx.google.com>
Date:   Sun, 07 May 2023 05:44:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-715-gb6b6662beaab
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 161 runs,
 12 regressions (v5.15.105-715-gb6b6662beaab)
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

stable-rc/queue/5.15 baseline: 161 runs, 12 regressions (v5.15.105-715-gb6b=
6662beaab)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

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

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.105-715-gb6b6662beaab/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.105-715-gb6b6662beaab
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b6b6662beaabdec99e8364cf148916a447a52afa =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64576903120a7cad972e8698

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-715-gb6b6662beaab/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-715-gb6b6662beaab/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64576903120a7cad972e869d
        failing since 39 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T09:01:39.781050  + set<8>[   11.031507] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10225190_1.4.2.3.1>

    2023-05-07T09:01:39.781642   +x

    2023-05-07T09:01:39.889650  / # #

    2023-05-07T09:01:39.992488  export SHELL=3D/bin/sh

    2023-05-07T09:01:39.993356  #

    2023-05-07T09:01:40.095057  / # export SHELL=3D/bin/sh. /lava-10225190/=
environment

    2023-05-07T09:01:40.095921  =


    2023-05-07T09:01:40.197732  / # . /lava-10225190/environment/lava-10225=
190/bin/lava-test-runner /lava-10225190/1

    2023-05-07T09:01:40.198990  =


    2023-05-07T09:01:40.204035  / # /lava-10225190/bin/lava-test-runner /la=
va-10225190/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645768f8ef1789ee142e861c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-715-gb6b6662beaab/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-715-gb6b6662beaab/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645768f8ef1789ee142e8621
        failing since 39 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T09:01:28.981993  <8>[   10.368014] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10225114_1.4.2.3.1>

    2023-05-07T09:01:28.985377  + set +x

    2023-05-07T09:01:29.090231  #

    2023-05-07T09:01:29.091535  =


    2023-05-07T09:01:29.193577  / # #export SHELL=3D/bin/sh

    2023-05-07T09:01:29.194245  =


    2023-05-07T09:01:29.295607  / # export SHELL=3D/bin/sh. /lava-10225114/=
environment

    2023-05-07T09:01:29.296329  =


    2023-05-07T09:01:29.397696  / # . /lava-10225114/environment/lava-10225=
114/bin/lava-test-runner /lava-10225114/1

    2023-05-07T09:01:29.398946  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645768f52be1fccbaf2e8614

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-715-gb6b6662beaab/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-715-gb6b6662beaab/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645768f52be1fccbaf2e8619
        failing since 39 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T09:01:30.283274  + set +x

    2023-05-07T09:01:30.289972  <8>[   10.661968] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10225185_1.4.2.3.1>

    2023-05-07T09:01:30.394407  / # #

    2023-05-07T09:01:30.495109  export SHELL=3D/bin/sh

    2023-05-07T09:01:30.495339  #

    2023-05-07T09:01:30.595885  / # export SHELL=3D/bin/sh. /lava-10225185/=
environment

    2023-05-07T09:01:30.596175  =


    2023-05-07T09:01:30.696764  / # . /lava-10225185/environment/lava-10225=
185/bin/lava-test-runner /lava-10225185/1

    2023-05-07T09:01:30.697109  =


    2023-05-07T09:01:30.701352  / # /lava-10225185/bin/lava-test-runner /la=
va-10225185/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645768efef1789ee142e85f8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-715-gb6b6662beaab/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-715-gb6b6662beaab/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645768efef1789ee142e85fd
        failing since 39 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T09:01:19.930756  <8>[   10.226621] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10225153_1.4.2.3.1>

    2023-05-07T09:01:19.933979  + set +x

    2023-05-07T09:01:20.038869  #

    2023-05-07T09:01:20.040080  =


    2023-05-07T09:01:20.141755  / # #export SHELL=3D/bin/sh

    2023-05-07T09:01:20.142531  =


    2023-05-07T09:01:20.244059  / # export SHELL=3D/bin/sh. /lava-10225153/=
environment

    2023-05-07T09:01:20.244910  =


    2023-05-07T09:01:20.346291  / # . /lava-10225153/environment/lava-10225=
153/bin/lava-test-runner /lava-10225153/1

    2023-05-07T09:01:20.347457  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6457690994e162224c2e85f0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-715-gb6b6662beaab/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-715-gb6b6662beaab/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6457690994e162224c2e85f5
        failing since 39 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T09:01:38.880049  + set<8>[   11.000509] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10225124_1.4.2.3.1>

    2023-05-07T09:01:38.880162   +x

    2023-05-07T09:01:38.984379  / # #

    2023-05-07T09:01:39.085088  export SHELL=3D/bin/sh

    2023-05-07T09:01:39.085320  #

    2023-05-07T09:01:39.185872  / # export SHELL=3D/bin/sh. /lava-10225124/=
environment

    2023-05-07T09:01:39.186096  =


    2023-05-07T09:01:39.286670  / # . /lava-10225124/environment/lava-10225=
124/bin/lava-test-runner /lava-10225124/1

    2023-05-07T09:01:39.286959  =


    2023-05-07T09:01:39.291857  / # /lava-10225124/bin/lava-test-runner /la=
va-10225124/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64576a56aa1244e3542e869c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-715-gb6b6662beaab/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-715-gb6b6662beaab/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64576a56aa1244e3542e86a1
        failing since 99 days (last pass: v5.15.81-121-gcb14018a85f6, first=
 fail: v5.15.90-146-gbf7101723cc0)

    2023-05-07T09:07:25.714834  + set +x
    2023-05-07T09:07:25.715014  [    9.412267] <LAVA_SIGNAL_ENDRUN 0_dmesg =
942584_1.5.2.3.1>
    2023-05-07T09:07:25.822789  / # #
    2023-05-07T09:07:25.924261  export SHELL=3D/bin/sh
    2023-05-07T09:07:25.924643  #
    2023-05-07T09:07:26.025907  / # export SHELL=3D/bin/sh. /lava-942584/en=
vironment
    2023-05-07T09:07:26.026480  =

    2023-05-07T09:07:26.127868  / # . /lava-942584/environment/lava-942584/=
bin/lava-test-runner /lava-942584/1
    2023-05-07T09:07:26.128489  =

    2023-05-07T09:07:26.130944  / # /lava-942584/bin/lava-test-runner /lava=
-942584/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645768faca880bb23e2e8609

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-715-gb6b6662beaab/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-715-gb6b6662beaab/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645768faca880bb23e2e860e
        failing since 39 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-07T09:01:31.332135  + set +x<8>[   11.859954] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10225108_1.4.2.3.1>

    2023-05-07T09:01:31.332215  =


    2023-05-07T09:01:31.436513  / # #

    2023-05-07T09:01:31.537095  export SHELL=3D/bin/sh

    2023-05-07T09:01:31.537324  #

    2023-05-07T09:01:31.637787  / # export SHELL=3D/bin/sh. /lava-10225108/=
environment

    2023-05-07T09:01:31.638019  =


    2023-05-07T09:01:31.738508  / # . /lava-10225108/environment/lava-10225=
108/bin/lava-test-runner /lava-10225108/1

    2023-05-07T09:01:31.738785  =


    2023-05-07T09:01:31.743445  / # /lava-10225108/bin/lava-test-runner /la=
va-10225108/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/645769f402801a9e512e85f3

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-715-gb6b6662beaab/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-715-gb6b6662beaab/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/645769f402801a9e512e8600
        failing since 0 day (last pass: v5.15.105-406-g93046c7116de, first =
fail: v5.15.105-716-g0ba96946e8d1)

    2023-05-07T09:05:37.372891  /lava-10225236/1/../bin/lava-test-case

    2023-05-07T09:05:37.379163  <8>[   60.577614] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/645769f402801a9e512e861e
        failing since 0 day (last pass: v5.15.105-406-g93046c7116de, first =
fail: v5.15.105-716-g0ba96946e8d1)

    2023-05-07T09:05:38.413803  /lava-10225236/1/../bin/lava-test-case

    2023-05-07T09:05:38.420269  <8>[   61.619154] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/645769f402801a9e512e861e
        failing since 0 day (last pass: v5.15.105-406-g93046c7116de, first =
fail: v5.15.105-716-g0ba96946e8d1)

    2023-05-07T09:05:38.413803  /lava-10225236/1/../bin/lava-test-case

    2023-05-07T09:05:38.420269  <8>[   61.619154] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645769f402801a9e512e8697
        failing since 0 day (last pass: v5.15.105-406-g93046c7116de, first =
fail: v5.15.105-716-g0ba96946e8d1)

    2023-05-07T09:05:23.204949  <8>[   46.406991] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10225236_1.5.2.3.1>

    2023-05-07T09:05:23.208367  + set +x

    2023-05-07T09:05:23.315983  / # #

    2023-05-07T09:05:23.418231  export SHELL=3D/bin/sh

    2023-05-07T09:05:23.418985  #

    2023-05-07T09:05:23.520581  / # export SHELL=3D/bin/sh. /lava-10225236/=
environment

    2023-05-07T09:05:23.521276  =


    2023-05-07T09:05:23.622574  / # . /lava-10225236/environment/lava-10225=
236/bin/lava-test-runner /lava-10225236/1

    2023-05-07T09:05:23.623804  =


    2023-05-07T09:05:23.628707  / # /lava-10225236/bin/lava-test-runner /la=
va-10225236/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64576a7a021d8a1cd92e85f5

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-715-gb6b6662beaab/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-715-gb6b6662beaab/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64576a7a021d8a1cd92e8622
        failing since 109 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-07T09:07:45.717573  + set +x
    2023-05-07T09:07:45.721661  <8>[   16.025717] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3559596_1.5.2.4.1>
    2023-05-07T09:07:45.841663  / # #
    2023-05-07T09:07:45.947195  export SHELL=3D/bin/sh
    2023-05-07T09:07:45.948704  #
    2023-05-07T09:07:46.052100  / # export SHELL=3D/bin/sh. /lava-3559596/e=
nvironment
    2023-05-07T09:07:46.053632  =

    2023-05-07T09:07:46.157062  / # . /lava-3559596/environment/lava-355959=
6/bin/lava-test-runner /lava-3559596/1
    2023-05-07T09:07:46.159860  =

    2023-05-07T09:07:46.163035  / # /lava-3559596/bin/lava-test-runner /lav=
a-3559596/1 =

    ... (12 line(s) more)  =

 =20
