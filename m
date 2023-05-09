Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088BF6FCA6B
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 17:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjEIPnU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 11:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbjEIPnR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 11:43:17 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5628C30E3
        for <stable@vger.kernel.org>; Tue,  9 May 2023 08:43:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64115eef620so43430057b3a.1
        for <stable@vger.kernel.org>; Tue, 09 May 2023 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683646994; x=1686238994;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S0LZbknUL/NzP98KQV+xHCZ8r7D4hWOzriWlnq9Ns88=;
        b=SCntoEvsUroJSR+iRrMZG05EBMhKL5zxvU5w9hnWBw2qF7GwfLMJJ88jrIJUY74b/7
         hs4jZkA6ylX7S0UwUlllXl3UllyeBCdoOteTWGNWRMqDzSgtSSyrbGz9+O3wXs9E3bgA
         8TlMQ5zH940bEyYxahpcF6sDGSVksthZeXl4FdN3KGrwrzIbJHh5PSoygmaRuI8Y/NE6
         aM1dCvhyD9LHAq1n5dvT3B24SKbICTbr8b7NJgmlSDPD6o3QYrvK/1peGtL8KacE6b3q
         mz3EncBDMaTBXS7A9NSI3zawTRlaABRf6VYQS6GdbYCcuF6l5wp7W8a8kotRov08s1jA
         Gh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683646994; x=1686238994;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0LZbknUL/NzP98KQV+xHCZ8r7D4hWOzriWlnq9Ns88=;
        b=JZrnPz+d9QgdugGdADTEI63RWr2+JZNG/vvO8VbL0bT5EV3CbohuhYTeVAoTJ86rpv
         3FATY0QGdlZuI73+OrmQYAeC+p5u+JhWQ0wbvXXCdPeEfLAFyx2P4TRLIwfol/bY5iux
         g79k0oCp7kk//0itqPGgAOcqxdEv4Zs7Ag9qwvqqELF+b16v4pyj11zKLAV0387xXjDa
         BAtFd+HZRodcPfCd+fDg52H0JEG3iOc33Dky+Wk3968KmccKypUR+OYJAV6hSzI+CgmA
         +N9GH6iVHQ+hCc1fYb/N1tA+c0D/7yhhBTd9vFmYC8v6OztYErjRPASaGVTA5OeUJFnX
         N7lw==
X-Gm-Message-State: AC+VfDw+Lh2MjlOet+B+GGaDnCmeTqQH5u03kkSSnjjh9XK6xQ4ANRS6
        ZrEzhTJfvpIW596aZzWR0PfqgQdMqPbBAHenW+d5qQ==
X-Google-Smtp-Source: ACHHUZ638NE7f75S+RyLeuUl2qkoCsleHIXCfvtR1AA1pWK8bnAToHKQJe7Pz692dnM+1I6kgfucGQ==
X-Received: by 2002:a17:902:d4c7:b0:1ac:626b:18fe with SMTP id o7-20020a170902d4c700b001ac626b18femr10889909plg.30.1683646994150;
        Tue, 09 May 2023 08:43:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y19-20020a170902b49300b001a1ccb37847sm1741643plr.146.2023.05.09.08.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:43:13 -0700 (PDT)
Message-ID: <645a6a11.170a0220.4b5a1.3102@mx.google.com>
Date:   Tue, 09 May 2023 08:43:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-732-g51751fee1428
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 159 runs,
 10 regressions (v5.15.105-732-g51751fee1428)
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

stable-rc/queue/5.15 baseline: 159 runs, 10 regressions (v5.15.105-732-g517=
51fee1428)

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

kontron-pitx-imx8m           | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 2          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.105-732-g51751fee1428/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.105-732-g51751fee1428
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      51751fee14288c10aae496ffa476052cfcbee161 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645a363371d684b9ef2e8694

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g51751fee1428/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g51751fee1428/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a363371d684b9ef2e8699
        failing since 42 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-09T12:01:46.322331  + set +x<8>[   11.735748] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10256983_1.4.2.3.1>

    2023-05-09T12:01:46.322460  =


    2023-05-09T12:01:46.426041  / # #

    2023-05-09T12:01:46.526822  export SHELL=3D/bin/sh

    2023-05-09T12:01:46.527045  #

    2023-05-09T12:01:46.627604  / # export SHELL=3D/bin/sh. /lava-10256983/=
environment

    2023-05-09T12:01:46.627858  =


    2023-05-09T12:01:46.728451  / # . /lava-10256983/environment/lava-10256=
983/bin/lava-test-runner /lava-10256983/1

    2023-05-09T12:01:46.728819  =


    2023-05-09T12:01:46.733044  / # /lava-10256983/bin/lava-test-runner /la=
va-10256983/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645a3631f48340b4992e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g51751fee1428/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g51751fee1428/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a3631f48340b4992e860c
        failing since 42 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-09T12:01:32.182549  <8>[   10.601427] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10256949_1.4.2.3.1>

    2023-05-09T12:01:32.186074  + set +x

    2023-05-09T12:01:32.291478  =


    2023-05-09T12:01:32.393092  / # #export SHELL=3D/bin/sh

    2023-05-09T12:01:32.393839  =


    2023-05-09T12:01:32.495219  / # export SHELL=3D/bin/sh. /lava-10256949/=
environment

    2023-05-09T12:01:32.495962  =


    2023-05-09T12:01:32.597521  / # . /lava-10256949/environment/lava-10256=
949/bin/lava-test-runner /lava-10256949/1

    2023-05-09T12:01:32.598916  =


    2023-05-09T12:01:32.604277  / # /lava-10256949/bin/lava-test-runner /la=
va-10256949/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645a3676681f986ccb2e85ed

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g51751fee1428/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g51751fee1428/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a3676681f986ccb2e85f2
        failing since 42 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-09T12:02:46.619328  + <8>[   10.202793] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10256938_1.4.2.3.1>

    2023-05-09T12:02:46.619414  set +x

    2023-05-09T12:02:46.721025  =


    2023-05-09T12:02:46.821635  / # #export SHELL=3D/bin/sh

    2023-05-09T12:02:46.821829  =


    2023-05-09T12:02:46.922357  / # export SHELL=3D/bin/sh. /lava-10256938/=
environment

    2023-05-09T12:02:46.922560  =


    2023-05-09T12:02:47.023114  / # . /lava-10256938/environment/lava-10256=
938/bin/lava-test-runner /lava-10256938/1

    2023-05-09T12:02:47.023375  =


    2023-05-09T12:02:47.028037  / # /lava-10256938/bin/lava-test-runner /la=
va-10256938/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645a363ad84b69d3652e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g51751fee1428/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g51751fee1428/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a363ad84b69d3652e85ec
        failing since 42 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-09T12:01:41.575296  <8>[   11.085363] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10256956_1.4.2.3.1>

    2023-05-09T12:01:41.578823  + set +x

    2023-05-09T12:01:41.683225  / # #

    2023-05-09T12:01:41.783912  export SHELL=3D/bin/sh

    2023-05-09T12:01:41.784133  #

    2023-05-09T12:01:41.884668  / # export SHELL=3D/bin/sh. /lava-10256956/=
environment

    2023-05-09T12:01:41.884845  =


    2023-05-09T12:01:41.985329  / # . /lava-10256956/environment/lava-10256=
956/bin/lava-test-runner /lava-10256956/1

    2023-05-09T12:01:41.985654  =


    2023-05-09T12:01:41.990119  / # /lava-10256956/bin/lava-test-runner /la=
va-10256956/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645a3645f58f8d13652e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g51751fee1428/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g51751fee1428/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a3645f58f8d13652e85eb
        failing since 42 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-09T12:01:48.741731  + set<8>[   11.555343] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10256971_1.4.2.3.1>

    2023-05-09T12:01:48.742171   +x

    2023-05-09T12:01:48.850085  / # #

    2023-05-09T12:01:48.952560  export SHELL=3D/bin/sh

    2023-05-09T12:01:48.953366  #

    2023-05-09T12:01:49.054855  / # export SHELL=3D/bin/sh. /lava-10256971/=
environment

    2023-05-09T12:01:49.055626  =


    2023-05-09T12:01:49.157035  / # . /lava-10256971/environment/lava-10256=
971/bin/lava-test-runner /lava-10256971/1

    2023-05-09T12:01:49.158128  =


    2023-05-09T12:01:49.162797  / # /lava-10256971/bin/lava-test-runner /la=
va-10256971/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645a34ae34dd98704a2e8611

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g51751fee1428/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g51751fee1428/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-i=
mx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a34ae34dd98704a2e8616
        failing since 102 days (last pass: v5.15.81-121-gcb14018a85f6, firs=
t fail: v5.15.90-146-gbf7101723cc0)

    2023-05-09T11:55:05.180079  + set +x
    2023-05-09T11:55:05.180520  [    9.428639] <LAVA_SIGNAL_ENDRUN 0_dmesg =
945244_1.5.2.3.1>
    2023-05-09T11:55:05.288238  / # #
    2023-05-09T11:55:05.390250  export SHELL=3D/bin/sh
    2023-05-09T11:55:05.390854  #
    2023-05-09T11:55:05.492235  / # export SHELL=3D/bin/sh. /lava-945244/en=
vironment
    2023-05-09T11:55:05.492971  =

    2023-05-09T11:55:05.594480  / # . /lava-945244/environment/lava-945244/=
bin/lava-test-runner /lava-945244/1
    2023-05-09T11:55:05.595341  =

    2023-05-09T11:55:05.597777  / # /lava-945244/bin/lava-test-runner /lava=
-945244/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron     | gcc-10   | defcon=
fig                    | 2          =


  Details:     https://kernelci.org/test/plan/id/645a357f1355d7a3752e85ed

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g51751fee1428/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx=
-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g51751fee1428/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx=
-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a357f1355d7a3752e85f0
        new failure (last pass: v5.15.105-731-gf083435ecac9)

    2023-05-09T11:58:28.894325  / # #
    2023-05-09T11:58:28.997019  export SHELL=3D/bin/sh
    2023-05-09T11:58:28.997815  #
    2023-05-09T11:58:29.099711  / # export SHELL=3D/bin/sh. /lava-333105/en=
vironment
    2023-05-09T11:58:29.100455  =

    2023-05-09T11:58:29.202397  / # . /lava-333105/environment/lava-333105/=
bin/lava-test-runner /lava-333105/1
    2023-05-09T11:58:29.203631  =

    2023-05-09T11:58:29.221105  / # /lava-333105/bin/lava-test-runner /lava=
-333105/1
    2023-05-09T11:58:29.269091  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-09T11:58:29.269625  + cd /l<8>[   12.141694] <LAVA_SIGNAL_START=
RUN 1_bootrr 333105_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/645=
a357f1355d7a3752e8600
        new failure (last pass: v5.15.105-731-gf083435ecac9)

    2023-05-09T11:58:31.592059  /lava-333105/1/../bin/lava-test-case
    2023-05-09T11:58:31.592535  <8>[   14.563311] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-05-09T11:58:31.592879  /lava-333105/1/../bin/lava-test-case   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645a366da4b9d61eff2e8630

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g51751fee1428/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g51751fee1428/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a366da4b9d61eff2e8635
        failing since 42 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-09T12:02:34.796538  + set +x<8>[   11.758812] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10256939_1.4.2.3.1>

    2023-05-09T12:02:34.796624  =


    2023-05-09T12:02:34.900701  / # #

    2023-05-09T12:02:35.001301  export SHELL=3D/bin/sh

    2023-05-09T12:02:35.001470  #

    2023-05-09T12:02:35.101957  / # export SHELL=3D/bin/sh. /lava-10256939/=
environment

    2023-05-09T12:02:35.102118  =


    2023-05-09T12:02:35.202606  / # . /lava-10256939/environment/lava-10256=
939/bin/lava-test-runner /lava-10256939/1

    2023-05-09T12:02:35.202870  =


    2023-05-09T12:02:35.207816  / # /lava-10256939/bin/lava-test-runner /la=
va-10256939/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645a378283bee4cfe62e8606

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g51751fee1428/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-732-g51751fee1428/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645a378283bee4cfe62e8633
        failing since 111 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-09T12:07:01.201403  + set +x
    2023-05-09T12:07:01.205606  <8>[   16.102086] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3568484_1.5.2.4.1>
    2023-05-09T12:07:01.326674  / # #
    2023-05-09T12:07:01.432679  export SHELL=3D/bin/sh
    2023-05-09T12:07:01.434286  #
    2023-05-09T12:07:01.537897  / # export SHELL=3D/bin/sh. /lava-3568484/e=
nvironment
    2023-05-09T12:07:01.539581  =

    2023-05-09T12:07:01.643253  / # . /lava-3568484/environment/lava-356848=
4/bin/lava-test-runner /lava-3568484/1
    2023-05-09T12:07:01.646086  =

    2023-05-09T12:07:01.649473  / # /lava-3568484/bin/lava-test-runner /lav=
a-3568484/1 =

    ... (12 line(s) more)  =

 =20
