Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7746FFA21
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 21:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbjEKTa6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 15:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjEKTa5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 15:30:57 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F51C6A76
        for <stable@vger.kernel.org>; Thu, 11 May 2023 12:30:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aad5245632so65276915ad.3
        for <stable@vger.kernel.org>; Thu, 11 May 2023 12:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683833446; x=1686425446;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z8v5Q1EKGPK4Y82FN2Jq5K0E+EAQRjOcKVJJyWPueJY=;
        b=AovgSeVr1AkEqw2RfFQjbvnvc/S9vOQ4sGjEwq0rPSba0zsnhfsRtdN4rGlyjNPHsN
         VX2tPNSCyshPN2QER7qqL7wju9fjEbiw52FuFh7eCTmsXAef0wlm5aD26p/s6m5vwbvB
         NOpFY3ymcnjz9zKz7y8B2hsIyKEVb2LNdmJr6OxQv+2Fxe3w9RJFjSINvGwcZbJIq+Kr
         Z3YV8Qyxat5JUpVTilWkF5Pz8QN19O0hEnHJDRqY31Cuk1bn20p/AjCawWSfr1hvILG2
         mpRFWcuBtPyXmsKB2EjQsIZ0OVYqp/0a/ZcSJnNlOKjEg+v1WNSFbHzFN3X59jtppYxi
         cZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683833446; x=1686425446;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8v5Q1EKGPK4Y82FN2Jq5K0E+EAQRjOcKVJJyWPueJY=;
        b=dRtOdjC/VfS/IcokhkLDlVEbjequS0m1HuAJ5PSJTd2bSlfpzQ7vVsHAh1AMmJa5jX
         quo31JjPjMfphKlgEZyi5CKnqDf0moNR4Gid+5DzhkYhX+PMyKGhnKQR2Wa2/QxZawvo
         v+WlueXd57bOMETL0mkKfD0K//xdRYtcAv+lRm0EgUU0EJr8d57EkTztnNw99s3CjQ7Q
         cecV6BK3tgk/wnJXHbIiJkLIyRL5f61e0eASKfEMl2mfT/UmBM9KkWEOdYq4w12vzLil
         rLAToCAYipk3LBLmqt675PIKA9lBmGhlcjFHUw9Eh0KzP/MTegT/j0Z7DEsBfOOyKiG0
         Nifg==
X-Gm-Message-State: AC+VfDylOZtmPI9R4uZ5GtNRuE+9FlAwF1tP5sV8OB+cC0zhFNiPnNpU
        16MDTytczIthGZoxZNWJi/iLJHYMwkZjSEb7NbNeYg==
X-Google-Smtp-Source: ACHHUZ4Dfi8sl4COjnWbOSJ8etJsNZzI3UdIiS/M4TLujAaqupXgOKr3dAbN37npNWsWmT9yWFo7Yw==
X-Received: by 2002:a17:902:d483:b0:1ac:896f:f655 with SMTP id c3-20020a170902d48300b001ac896ff655mr16426702plg.50.1683833445487;
        Thu, 11 May 2023 12:30:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c9-20020a170903234900b001a6e3e3dbc3sm6327574plh.22.2023.05.11.12.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 12:30:44 -0700 (PDT)
Message-ID: <645d4264.170a0220.c7762.cb74@mx.google.com>
Date:   Thu, 11 May 2023 12:30:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.111
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 159 runs, 10 regressions (v5.15.111)
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

stable-rc/linux-5.15.y baseline: 159 runs, 10 regressions (v5.15.111)

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

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.111/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.111
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b0ece631f84a3e70341496b000b094b7dfdf4e5f =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d0f7bfe7e1c89ae2e85fd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d0f7bfe7e1c89ae2e8602
        failing since 43 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-11T15:53:10.901291  + set +x

    2023-05-11T15:53:10.908014  <8>[   11.853048] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10284765_1.4.2.3.1>

    2023-05-11T15:53:11.010400  =


    2023-05-11T15:53:11.110986  / # #export SHELL=3D/bin/sh

    2023-05-11T15:53:11.111205  =


    2023-05-11T15:53:11.211792  / # export SHELL=3D/bin/sh. /lava-10284765/=
environment

    2023-05-11T15:53:11.211984  =


    2023-05-11T15:53:11.312526  / # . /lava-10284765/environment/lava-10284=
765/bin/lava-test-runner /lava-10284765/1

    2023-05-11T15:53:11.312832  =


    2023-05-11T15:53:11.319203  / # /lava-10284765/bin/lava-test-runner /la=
va-10284765/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d0f79ce5c6cd3412e878a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d0f79ce5c6cd3412e878f
        failing since 43 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-11T15:53:09.166509  + set<8>[   11.291797] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10284766_1.4.2.3.1>

    2023-05-11T15:53:09.166596   +x

    2023-05-11T15:53:09.270649  / # #

    2023-05-11T15:53:09.371216  export SHELL=3D/bin/sh

    2023-05-11T15:53:09.371444  #

    2023-05-11T15:53:09.472056  / # export SHELL=3D/bin/sh. /lava-10284766/=
environment

    2023-05-11T15:53:09.472261  =


    2023-05-11T15:53:09.572730  / # . /lava-10284766/environment/lava-10284=
766/bin/lava-test-runner /lava-10284766/1

    2023-05-11T15:53:09.573051  =


    2023-05-11T15:53:09.577961  / # /lava-10284766/bin/lava-test-runner /la=
va-10284766/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d0f7efe7e1c89ae2e861c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d0f7efe7e1c89ae2e8621
        failing since 43 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-11T15:53:08.989301  <8>[   10.270987] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10284761_1.4.2.3.1>

    2023-05-11T15:53:08.992620  + set +x

    2023-05-11T15:53:09.097577  #

    2023-05-11T15:53:09.200085  / # #export SHELL=3D/bin/sh

    2023-05-11T15:53:09.200803  =


    2023-05-11T15:53:09.302249  / # export SHELL=3D/bin/sh. /lava-10284761/=
environment

    2023-05-11T15:53:09.302959  =


    2023-05-11T15:53:09.404737  / # . /lava-10284761/environment/lava-10284=
761/bin/lava-test-runner /lava-10284761/1

    2023-05-11T15:53:09.405957  =


    2023-05-11T15:53:09.411194  / # /lava-10284761/bin/lava-test-runner /la=
va-10284761/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d0fde786da99fb42e8688

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d0fde786da99fb42e868d
        failing since 43 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-11T15:54:53.825750  + <8>[   10.858267] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10284803_1.4.2.3.1>

    2023-05-11T15:54:53.825848  set +x

    2023-05-11T15:54:53.927001  #

    2023-05-11T15:54:54.027865  / # #export SHELL=3D/bin/sh

    2023-05-11T15:54:54.028090  =


    2023-05-11T15:54:54.128641  / # export SHELL=3D/bin/sh. /lava-10284803/=
environment

    2023-05-11T15:54:54.128865  =


    2023-05-11T15:54:54.229426  / # . /lava-10284803/environment/lava-10284=
803/bin/lava-test-runner /lava-10284803/1

    2023-05-11T15:54:54.229793  =


    2023-05-11T15:54:54.234253  / # /lava-10284803/bin/lava-test-runner /la=
va-10284803/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d0f74ce5c6cd3412e86fe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d0f74ce5c6cd3412e8703
        failing since 43 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-11T15:52:57.068387  <8>[   10.475231] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10284827_1.4.2.3.1>

    2023-05-11T15:52:57.071428  + set +x

    2023-05-11T15:52:57.176196  / # #

    2023-05-11T15:52:57.276849  export SHELL=3D/bin/sh

    2023-05-11T15:52:57.277051  #

    2023-05-11T15:52:57.377554  / # export SHELL=3D/bin/sh. /lava-10284827/=
environment

    2023-05-11T15:52:57.377730  =


    2023-05-11T15:52:57.478231  / # . /lava-10284827/environment/lava-10284=
827/bin/lava-test-runner /lava-10284827/1

    2023-05-11T15:52:57.478481  =


    2023-05-11T15:52:57.484048  / # /lava-10284827/bin/lava-test-runner /la=
va-10284827/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d0f81fe7e1c89ae2e8635

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d0f81fe7e1c89ae2e863a
        failing since 43 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-11T15:53:11.572234  + set<8>[   11.687873] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10284785_1.4.2.3.1>

    2023-05-11T15:53:11.572338   +x

    2023-05-11T15:53:11.677344  / # #

    2023-05-11T15:53:11.778000  export SHELL=3D/bin/sh

    2023-05-11T15:53:11.778194  #

    2023-05-11T15:53:11.878717  / # export SHELL=3D/bin/sh. /lava-10284785/=
environment

    2023-05-11T15:53:11.878919  =


    2023-05-11T15:53:11.979591  / # . /lava-10284785/environment/lava-10284=
785/bin/lava-test-runner /lava-10284785/1

    2023-05-11T15:53:11.980746  =


    2023-05-11T15:53:11.985319  / # /lava-10284785/bin/lava-test-runner /la=
va-10284785/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645d0df38ca15b1d6a2e863e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d0df38ca15b1d6a2e8643
        failing since 101 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-05-11T15:46:50.841518  + set +x
    2023-05-11T15:46:50.841801  [    9.423724] <LAVA_SIGNAL_ENDRUN 0_dmesg =
947910_1.5.2.3.1>
    2023-05-11T15:46:50.949613  / # #
    2023-05-11T15:46:51.051362  export SHELL=3D/bin/sh
    2023-05-11T15:46:51.051895  #
    2023-05-11T15:46:51.153214  / # export SHELL=3D/bin/sh. /lava-947910/en=
vironment
    2023-05-11T15:46:51.153631  =

    2023-05-11T15:46:51.254762  / # . /lava-947910/environment/lava-947910/=
bin/lava-test-runner /lava-947910/1
    2023-05-11T15:46:51.255358  =

    2023-05-11T15:46:51.258085  / # /lava-947910/bin/lava-test-runner /lava=
-947910/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645d0f8d40b44c0af62e85f8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d0f8d40b44c0af62e85fd
        failing since 43 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-05-11T15:53:31.473004  + set<8>[   12.429022] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10284783_1.4.2.3.1>

    2023-05-11T15:53:31.473127   +x

    2023-05-11T15:53:31.577517  / # #

    2023-05-11T15:53:31.678202  export SHELL=3D/bin/sh

    2023-05-11T15:53:31.678429  #

    2023-05-11T15:53:31.778984  / # export SHELL=3D/bin/sh. /lava-10284783/=
environment

    2023-05-11T15:53:31.779175  =


    2023-05-11T15:53:31.879738  / # . /lava-10284783/environment/lava-10284=
783/bin/lava-test-runner /lava-10284783/1

    2023-05-11T15:53:31.880116  =


    2023-05-11T15:53:31.884388  / # /lava-10284783/bin/lava-test-runner /la=
va-10284783/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645d0ea04e12cc2e142e85ee

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d0ea04e12cc2e142e861b
        failing since 114 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-05-11T15:49:27.115112  + set +x
    2023-05-11T15:49:27.118446  <8>[   16.124504] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3575770_1.5.2.4.1>
    2023-05-11T15:49:27.239673  / # #
    2023-05-11T15:49:27.345935  export SHELL=3D/bin/sh
    2023-05-11T15:49:27.347676  #
    2023-05-11T15:49:27.451382  / # export SHELL=3D/bin/sh. /lava-3575770/e=
nvironment
    2023-05-11T15:49:27.454563  =

    2023-05-11T15:49:27.561978  / # . /lava-3575770/environment/lava-357577=
0/bin/lava-test-runner /lava-3575770/1
    2023-05-11T15:49:27.567881  =

    2023-05-11T15:49:27.570478  / # /lava-3575770/bin/lava-test-runner /lav=
a-3575770/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre    | gcc-10   | sunxi_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/645d0afb430131be422e85f4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-=
r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
11/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-orangepi-=
r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645d0afb430131be422e85f9
        failing since 28 days (last pass: v5.15.82-124-g2b8b2c150867, first=
 fail: v5.15.105-194-g415a9d81c640)

    2023-05-11T15:33:58.073933  <8>[    5.742086] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3575744_1.5.2.4.1>
    2023-05-11T15:33:58.194294  / # #
    2023-05-11T15:33:58.299985  export SHELL=3D/bin/sh
    2023-05-11T15:33:58.301571  #
    2023-05-11T15:33:58.405050  / # export SHELL=3D/bin/sh. /lava-3575744/e=
nvironment
    2023-05-11T15:33:58.406890  =

    2023-05-11T15:33:58.510433  / # . /lava-3575744/environment/lava-357574=
4/bin/lava-test-runner /lava-3575744/1
    2023-05-11T15:33:58.513583  =

    2023-05-11T15:33:58.517791  / # /lava-3575744/bin/lava-test-runner /lav=
a-3575744/1
    2023-05-11T15:33:58.630404  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
