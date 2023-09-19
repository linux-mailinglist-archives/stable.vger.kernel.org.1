Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84937A6724
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 16:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjISOpP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 10:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjISOpB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 10:45:01 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CD9F4
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 07:43:59 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690c6f4f6a5so558012b3a.2
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 07:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695134639; x=1695739439; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=74V+LpxE8pADy6YzEGDn2aTOdRoEllhFUEgA7vLwZRc=;
        b=hq3mEy6VPF1FRlLpp3DMyfc3itY7NGw+W1pbTab2kQtQ0/MMsJTsn6L3YUMjiCa4fO
         it4hUM6lmniRUoJApHoXE4x7R80FIcrcVbPXj6yVYzSr3qd2G9cbNDkP7aw10KlTt2Q8
         78lfHzfcrCwv1aB0McPtFKQi7c+IFee/27KhwJ+h4OpCTw/WekyVk3WCOd27WUkecdAR
         KUJ63nOut4x+8GdeRSWMEGxwwolhGtrFYsuTo7eElRrtZ2JRPox3rZOtWL7eNExt5Rok
         fW4o+whh+0TIoD9XH8yopG+7tzqhzlJLKGXl4iSZf/s+lvWRWOnvzahYZefHVAbK0D6p
         tICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695134639; x=1695739439;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74V+LpxE8pADy6YzEGDn2aTOdRoEllhFUEgA7vLwZRc=;
        b=r9kynk6352Tvt8glr4W/UG/60wGPryaGXEPgiYUXq8Anr6hYAERvO9KpMaGHW0E8rY
         UJZtfyzo/I1Lu19VOz/Npy5ikIkTYF+x96ExPETE3cGgN7N+q/4fqAQ9pLnHfne6crcY
         jikhJlfMGqdhT8g0v1I1vtmIByQ6TkWlf7i2RbNcCDiNXPVicfupqjLO28SWHoQpyFcA
         5ghiEqhUHh1lY9ZNlcwGmw2lecQL3vbW54f9qTSVcTD04N3wRmZKdmRsGUED3Fg5Ofgb
         B0LFXZuQVb51G/OtKRUk4fJrxKAGKlX0QCFeXJmmfZWEJ8bUSBCgrG7E0ZekUI0f/US+
         KnUA==
X-Gm-Message-State: AOJu0YxMsfDTJUAq5pqgEUTrBxxXYLkQORCJwWrW4mr+TkIXwhxPN3zi
        FhNVxtOkpZjPqxcSmY356yyxfTh6mpsc0VTeep+AxA==
X-Google-Smtp-Source: AGHT+IGmcCn++ey9XXLacnJxgE36iv8lRy18Lee36LRla7tIowM0ayjgG0aSR56ZriHEk+TEHrmWqQ==
X-Received: by 2002:a05:6a00:331a:b0:690:ca4e:662f with SMTP id cq26-20020a056a00331a00b00690ca4e662fmr1366861pfb.5.1695134638273;
        Tue, 19 Sep 2023 07:43:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id de11-20020a056a00468b00b00686236718d8sm1598529pfb.41.2023.09.19.07.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 07:43:57 -0700 (PDT)
Message-ID: <6509b3ad.050a0220.872b.611e@mx.google.com>
Date:   Tue, 19 Sep 2023 07:43:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v5.15.132
X-Kernelci-Report-Type: test
Subject: stable/linux-5.15.y baseline: 176 runs, 32 regressions (v5.15.132)
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

stable/linux-5.15.y baseline: 176 runs, 32 regressions (v5.15.132)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.132/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.132
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      35ecaa3632bff102decb9f2277cf99150b2bf690 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65097fef1835d607388a0a68

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65097fef1835d607388a0a71
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-19T11:04:23.621633  <8>[   10.462671] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11570139_1.4.2.3.1>

    2023-09-19T11:04:23.625074  + set +x

    2023-09-19T11:04:23.726551  /#

    2023-09-19T11:04:23.827478   # #export SHELL=3D/bin/sh

    2023-09-19T11:04:23.827683  =


    2023-09-19T11:04:23.928219  / # export SHELL=3D/bin/sh. /lava-11570139/=
environment

    2023-09-19T11:04:23.928395  =


    2023-09-19T11:04:24.028935  / # . /lava-11570139/environment/lava-11570=
139/bin/lava-test-runner /lava-11570139/1

    2023-09-19T11:04:24.029258  =


    2023-09-19T11:04:24.035509  / # /lava-11570139/bin/lava-test-runner /la=
va-11570139/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6509823d6f2ec825978a0a6d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509823d6f2ec825978a0a76
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-19T11:12:42.380287  + set +x

    2023-09-19T11:12:42.386573  <8>[   11.786864] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11570296_1.4.2.3.1>

    2023-09-19T11:12:42.494349  / # #

    2023-09-19T11:12:42.596828  export SHELL=3D/bin/sh

    2023-09-19T11:12:42.597562  #

    2023-09-19T11:12:42.699227  / # export SHELL=3D/bin/sh. /lava-11570296/=
environment

    2023-09-19T11:12:42.699980  =


    2023-09-19T11:12:42.801661  / # . /lava-11570296/environment/lava-11570=
296/bin/lava-test-runner /lava-11570296/1

    2023-09-19T11:12:42.802918  =


    2023-09-19T11:12:42.808718  / # /lava-11570296/bin/lava-test-runner /la=
va-11570296/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65097fca0df9148e328a0a53

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65097fca0df9148e328a0a5c
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-19T11:02:52.160859  + set<8>[   11.717704] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11570147_1.4.2.3.1>

    2023-09-19T11:02:52.160983   +x

    2023-09-19T11:02:52.265019  / # #

    2023-09-19T11:02:52.365622  export SHELL=3D/bin/sh

    2023-09-19T11:02:52.365797  #

    2023-09-19T11:02:52.466323  / # export SHELL=3D/bin/sh. /lava-11570147/=
environment

    2023-09-19T11:02:52.466503  =


    2023-09-19T11:02:52.567026  / # . /lava-11570147/environment/lava-11570=
147/bin/lava-test-runner /lava-11570147/1

    2023-09-19T11:02:52.567325  =


    2023-09-19T11:02:52.571535  / # /lava-11570147/bin/lava-test-runner /la=
va-11570147/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6509822b6f2ec825978a0a5b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509822b6f2ec825978a0a64
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-19T11:12:35.306294  + <8>[    9.675522] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11570291_1.4.2.3.1>

    2023-09-19T11:12:35.306716  set +x

    2023-09-19T11:12:35.414392  / # #

    2023-09-19T11:12:35.516713  export SHELL=3D/bin/sh

    2023-09-19T11:12:35.517445  #

    2023-09-19T11:12:35.619066  / # export SHELL=3D/bin/sh. /lava-11570291/=
environment

    2023-09-19T11:12:35.619819  =


    2023-09-19T11:12:35.721442  / # . /lava-11570291/environment/lava-11570=
291/bin/lava-test-runner /lava-11570291/1

    2023-09-19T11:12:35.722654  =


    2023-09-19T11:12:35.728115  / # /lava-11570291/bin/lava-test-runner /la=
va-11570291/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65097ff18796bd18a98a0a6a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65097ff18796bd18a98a0a73
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-19T11:04:18.469916  <8>[    8.404180] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11570140_1.4.2.3.1>

    2023-09-19T11:04:18.473466  + set +x

    2023-09-19T11:04:18.575391  =


    2023-09-19T11:04:18.676109  / # #export SHELL=3D/bin/sh

    2023-09-19T11:04:18.676356  =


    2023-09-19T11:04:18.776848  / # export SHELL=3D/bin/sh. /lava-11570140/=
environment

    2023-09-19T11:04:18.777057  =


    2023-09-19T11:04:18.877580  / # . /lava-11570140/environment/lava-11570=
140/bin/lava-test-runner /lava-11570140/1

    2023-09-19T11:04:18.877912  =


    2023-09-19T11:04:18.883088  / # /lava-11570140/bin/lava-test-runner /la=
va-11570140/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6509821987ddabf64d8a0ac0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509821987ddabf64d8a0ac9
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-19T11:12:02.423973  + set +x

    2023-09-19T11:12:02.430427  <8>[   11.902430] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11570280_1.4.2.3.1>

    2023-09-19T11:12:02.535045  / # #

    2023-09-19T11:12:02.635930  export SHELL=3D/bin/sh

    2023-09-19T11:12:02.636221  #

    2023-09-19T11:12:02.736832  / # export SHELL=3D/bin/sh. /lava-11570280/=
environment

    2023-09-19T11:12:02.737093  =


    2023-09-19T11:12:02.837713  / # . /lava-11570280/environment/lava-11570=
280/bin/lava-test-runner /lava-11570280/1

    2023-09-19T11:12:02.838065  =


    2023-09-19T11:12:02.843202  / # /lava-11570280/bin/lava-test-runner /la=
va-11570280/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65097fa9961a04598c8a0b32

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65097fa9961a04598c8a0b3b
        failing since 54 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-09-19T11:05:57.688300  / # #

    2023-09-19T11:05:57.790417  export SHELL=3D/bin/sh

    2023-09-19T11:05:57.791127  #

    2023-09-19T11:05:57.892638  / # export SHELL=3D/bin/sh. /lava-11570106/=
environment

    2023-09-19T11:05:57.893356  =


    2023-09-19T11:05:57.994794  / # . /lava-11570106/environment/lava-11570=
106/bin/lava-test-runner /lava-11570106/1

    2023-09-19T11:05:57.995940  =


    2023-09-19T11:05:57.997209  / # /lava-11570106/bin/lava-test-runner /la=
va-11570106/1

    2023-09-19T11:05:58.077206  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T11:05:58.121332  + cd /lava-11570106/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650980ea91568821da8a0a61

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650980ea91568821da8a0=
a62
        failing since 166 days (last pass: v5.15.105, first fail: v5.15.106=
) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650981e956e3ed941b8a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-nxp/baseline-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650981e956e3ed941b8a0=
a43
        failing since 17 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65097fde2d9e842a8a8a0a61

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65097fde2d9e842a8a8a0a6a
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-19T11:02:38.321714  + set +x

    2023-09-19T11:02:38.327657  <8>[   10.467733] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11570130_1.4.2.3.1>

    2023-09-19T11:02:38.436161  / # #

    2023-09-19T11:02:38.538778  export SHELL=3D/bin/sh

    2023-09-19T11:02:38.539573  #

    2023-09-19T11:02:38.641148  / # export SHELL=3D/bin/sh. /lava-11570130/=
environment

    2023-09-19T11:02:38.642053  =


    2023-09-19T11:02:38.743626  / # . /lava-11570130/environment/lava-11570=
130/bin/lava-test-runner /lava-11570130/1

    2023-09-19T11:02:38.745127  =


    2023-09-19T11:02:38.749874  / # /lava-11570130/bin/lava-test-runner /la=
va-11570130/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/650983651f7a77ff608a0af4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650983651f7a77ff608a0afd
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-19T11:18:06.599621  + set +x<8>[   12.577726] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11570289_1.4.2.3.1>

    2023-09-19T11:18:06.600254  =


    2023-09-19T11:18:06.709695  / # #

    2023-09-19T11:18:06.812629  export SHELL=3D/bin/sh

    2023-09-19T11:18:06.813500  #

    2023-09-19T11:18:06.915495  / # export SHELL=3D/bin/sh. /lava-11570289/=
environment

    2023-09-19T11:18:06.916424  =


    2023-09-19T11:18:07.018260  / # . /lava-11570289/environment/lava-11570=
289/bin/lava-test-runner /lava-11570289/1

    2023-09-19T11:18:07.019783  =


    2023-09-19T11:18:07.025009  / # /lava-11570289/bin/lava-test-runner /la=
va-11570289/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65097fea8796bd18a98a0a5d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65097fea8796bd18a98a0a66
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-19T11:02:51.473800  <8>[   10.396105] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11570116_1.4.2.3.1>

    2023-09-19T11:02:51.477009  + set +x

    2023-09-19T11:02:51.578766  =


    2023-09-19T11:02:51.679395  / # #export SHELL=3D/bin/sh

    2023-09-19T11:02:51.679608  =


    2023-09-19T11:02:51.780145  / # export SHELL=3D/bin/sh. /lava-11570116/=
environment

    2023-09-19T11:02:51.780356  =


    2023-09-19T11:02:51.880908  / # . /lava-11570116/environment/lava-11570=
116/bin/lava-test-runner /lava-11570116/1

    2023-09-19T11:02:51.881248  =


    2023-09-19T11:02:51.885909  / # /lava-11570116/bin/lava-test-runner /la=
va-11570116/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/650982a369eff820408a0a44

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650982a369eff820408a0a4d
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-19T11:14:29.668045  + set<8>[   11.276753] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11570309_1.4.2.3.1>

    2023-09-19T11:14:29.668469   +x

    2023-09-19T11:14:29.775218  #

    2023-09-19T11:14:29.775631  =


    2023-09-19T11:14:29.876629  / # #export SHELL=3D/bin/sh

    2023-09-19T11:14:29.877337  =


    2023-09-19T11:14:29.978584  / # export SHELL=3D/bin/sh. /lava-11570309/=
environment

    2023-09-19T11:14:29.979389  =


    2023-09-19T11:14:30.080868  / # . /lava-11570309/environment/lava-11570=
309/bin/lava-test-runner /lava-11570309/1

    2023-09-19T11:14:30.082013  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65097fccf7dc5413c98a0a48

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65097fccf7dc5413c98a0a51
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-19T11:02:19.585282  + set<8>[   10.551173] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11570112_1.4.2.3.1>

    2023-09-19T11:02:19.585368   +x

    2023-09-19T11:02:19.690076  / # #

    2023-09-19T11:02:19.790699  export SHELL=3D/bin/sh

    2023-09-19T11:02:19.790901  #

    2023-09-19T11:02:19.891461  / # export SHELL=3D/bin/sh. /lava-11570112/=
environment

    2023-09-19T11:02:19.891672  =


    2023-09-19T11:02:19.992231  / # . /lava-11570112/environment/lava-11570=
112/bin/lava-test-runner /lava-11570112/1

    2023-09-19T11:02:19.992544  =


    2023-09-19T11:02:19.996711  / # /lava-11570112/bin/lava-test-runner /la=
va-11570112/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6509822087ddabf64d8a0ad8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509822087ddabf64d8a0ae1
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-19T11:12:17.062259  + <8>[   12.379522] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11570301_1.4.2.3.1>

    2023-09-19T11:12:17.062337  set +x

    2023-09-19T11:12:17.166554  / # #

    2023-09-19T11:12:17.267129  export SHELL=3D/bin/sh

    2023-09-19T11:12:17.267333  #

    2023-09-19T11:12:17.367920  / # export SHELL=3D/bin/sh. /lava-11570301/=
environment

    2023-09-19T11:12:17.368627  =


    2023-09-19T11:12:17.470256  / # . /lava-11570301/environment/lava-11570=
301/bin/lava-test-runner /lava-11570301/1

    2023-09-19T11:12:17.471715  =


    2023-09-19T11:12:17.476644  / # /lava-11570301/bin/lava-test-runner /la=
va-11570301/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509819193d9aa62e88a0a49

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls=
.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6509819193d9aa62e88a0=
a4a
        failing since 17 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509817ddb6300db738a0aa6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads=
2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads=
2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6509817ddb6300db738a0=
aa7
        failing since 12 days (last pass: v5.15.128, first fail: v5.15.131) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65097feb1835d607388a0a5d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65097feb1835d607388a0a66
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-19T11:02:45.749274  <8>[   12.320190] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11570151_1.4.2.3.1>

    2023-09-19T11:02:45.857179  / # #

    2023-09-19T11:02:45.959642  export SHELL=3D/bin/sh

    2023-09-19T11:02:45.960343  #

    2023-09-19T11:02:46.061726  / # export SHELL=3D/bin/sh. /lava-11570151/=
environment

    2023-09-19T11:02:46.062467  =


    2023-09-19T11:02:46.164159  / # . /lava-11570151/environment/lava-11570=
151/bin/lava-test-runner /lava-11570151/1

    2023-09-19T11:02:46.165264  =


    2023-09-19T11:02:46.170785  / # /lava-11570151/bin/lava-test-runner /la=
va-11570151/1

    2023-09-19T11:02:46.176383  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6509820787ddabf64d8a0a4e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509820787ddabf64d8a0a57
        failing since 172 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-09-19T11:11:53.011046  + <8>[   12.495946] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11570306_1.4.2.3.1>

    2023-09-19T11:11:53.011500  set +x

    2023-09-19T11:11:53.118669  / # #

    2023-09-19T11:11:53.220948  export SHELL=3D/bin/sh

    2023-09-19T11:11:53.221707  #

    2023-09-19T11:11:53.323164  / # export SHELL=3D/bin/sh. /lava-11570306/=
environment

    2023-09-19T11:11:53.323897  =


    2023-09-19T11:11:53.425468  / # . /lava-11570306/environment/lava-11570=
306/bin/lava-test-runner /lava-11570306/1

    2023-09-19T11:11:53.426637  =


    2023-09-19T11:11:53.431994  / # /lava-11570306/bin/lava-test-runner /la=
va-11570306/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650983f6d35935ddd08a0a46

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-baylibre/baseline-meson-gxl-s905x-libr=
etech-cc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-baylibre/baseline-meson-gxl-s905x-libr=
etech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650983f6d35935ddd08a0=
a47
        failing since 17 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre  | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6509855e7cd0ee33de8a0a4b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-baylibre/baseline-mes=
on-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-baylibre/baseline-mes=
on-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6509855e7cd0ee33de8a0=
a4c
        failing since 19 days (last pass: v5.15.128, first fail: v5.15.129) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65098192abcd47da788a0a62

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-meson-gxl-s905x-libre=
tech-cc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-meson-gxl-s905x-libre=
tech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65098192abcd47da788a0=
a63
        failing since 17 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65098420088d54d6328a0a6b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-broonie/baseline-meso=
n-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-broonie/baseline-meso=
n-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65098420088d54d6328a0=
a6c
        failing since 19 days (last pass: v5.15.128, first fail: v5.15.129) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/650983eed35935ddd08a0a43

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650983eed35935ddd08a0=
a44
        failing since 238 days (last pass: v5.15.89, first fail: v5.15.90) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65099dc2ccf74fe0428a0a7f

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65099dc2ccf74fe0428a0a88
        failing since 54 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-09-19T13:14:29.483418  / # #

    2023-09-19T13:14:29.585551  export SHELL=3D/bin/sh

    2023-09-19T13:14:29.586313  #

    2023-09-19T13:14:29.687641  / # export SHELL=3D/bin/sh. /lava-11570029/=
environment

    2023-09-19T13:14:29.688347  =


    2023-09-19T13:14:29.789699  / # . /lava-11570029/environment/lava-11570=
029/bin/lava-test-runner /lava-11570029/1

    2023-09-19T13:14:29.790772  =


    2023-09-19T13:14:29.807622  / # /lava-11570029/bin/lava-test-runner /la=
va-11570029/1

    2023-09-19T13:14:29.856405  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T13:14:29.856908  + cd /lav<8>[   15.992844] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11570029_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65099f145a9482d6f98a0a4f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65099f145a9482d6f98a0=
a50
        new failure (last pass: v5.15.131) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65097e2acf5ab9eeff8a0a62

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65097e2acf5ab9eeff8a0a6b
        failing since 54 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-09-19T10:55:37.264800  / # #

    2023-09-19T10:55:38.344378  export SHELL=3D/bin/sh

    2023-09-19T10:55:38.346300  #

    2023-09-19T10:55:39.836980  / # export SHELL=3D/bin/sh. /lava-11570016/=
environment

    2023-09-19T10:55:39.838904  =


    2023-09-19T10:55:42.562757  / # . /lava-11570016/environment/lava-11570=
016/bin/lava-test-runner /lava-11570016/1

    2023-09-19T10:55:42.565017  =


    2023-09-19T10:55:42.572802  / # /lava-11570016/bin/lava-test-runner /la=
va-11570016/1

    2023-09-19T10:55:42.636105  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T10:55:42.636589  + cd /lav<8>[   25.527341] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11570016_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650981457a1c6c3b908a0c12

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650981457a1c6c3b908a0=
c13
        failing since 17 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509814acfa77a248b8a0a56

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.t=
xt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6509814acfa77a248b8a0=
a57
        failing since 17 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509845c1762ef3b108a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plu=
s.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plu=
s.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6509845c1762ef3b108a0=
a43
        failing since 17 days (last pass: v5.15.128, first fail: v5.15.130) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650981c793d9aa62e88a0a5a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-a=
ll-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig+kselftest/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-a=
ll-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650981c793d9aa62e88a0=
a5b
        failing since 12 days (last pass: v5.15.128, first fail: v5.15.131) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65097e17f7922c08618a0a5c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.132/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65097e17f7922c08618a0a65
        failing since 54 days (last pass: v5.15.119, first fail: v5.15.123)

    2023-09-19T10:59:26.660174  / # #

    2023-09-19T10:59:26.762266  export SHELL=3D/bin/sh

    2023-09-19T10:59:26.762947  #

    2023-09-19T10:59:26.864337  / # export SHELL=3D/bin/sh. /lava-11570023/=
environment

    2023-09-19T10:59:26.865055  =


    2023-09-19T10:59:26.966528  / # . /lava-11570023/environment/lava-11570=
023/bin/lava-test-runner /lava-11570023/1

    2023-09-19T10:59:26.967618  =


    2023-09-19T10:59:26.984444  / # /lava-11570023/bin/lava-test-runner /la=
va-11570023/1

    2023-09-19T10:59:27.042390  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T10:59:27.042902  + cd /lava-1157002<8>[   16.924172] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11570023_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
