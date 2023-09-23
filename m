Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009D57AC343
	for <lists+stable@lfdr.de>; Sat, 23 Sep 2023 17:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjIWPfn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 23 Sep 2023 11:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjIWPfm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 23 Sep 2023 11:35:42 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6E4197
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 08:35:36 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2774552a12.1
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695483335; x=1696088135; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+JyvV0GmBAM+EWj7xesKCIp9K4e1F5QsA+aafIGcyqw=;
        b=kDG9OlBFtG8d35nwuhtqvQvZsg28hC1YescNCOwaz8HqTR66N0JUhsOqvZasK/yUcM
         H9/qSrt5xjmQ6hwO5fYPhxtNs1Nk45bIzxyOMOnCpZ8F8ON7t+KzEEU7GecCC25avEne
         bOz6KGjRuplhRj/f4xgcpZCyT+CQlvNPfYU073DNDeN+NnoO3fLXqZFPUt8ShbtEcuWB
         gAzYXdKPKlzV1xyLk4MnoO9P4otqRLumiww++h2VJYvXChpjGw1R7Izs2r/aEUstQ++D
         KoX6HazbWjuR2z4XjGthaD8ZcTarce2nqiaInxpbbjHnZT4+xf6b7aiZ1zFzk4G/yW2W
         9Gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695483335; x=1696088135;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JyvV0GmBAM+EWj7xesKCIp9K4e1F5QsA+aafIGcyqw=;
        b=dvSDrhZi+1mgvQrEin9mATrSoOIMMbRaw96MppD/YoT3uyEjMqBZliQefYFEJQkcAW
         sB+P9SXC8RsMwrpL/+L0jxCv7psS3iwFuiYdgVguRPOfQGmA7JpJOwtH8XRzWquzD9WE
         8eGAION4Hp5YIEhVa3daCeN9li3+XbwzI4XSD5fOvtsvpHyEPC/klA9sb4Nki2z2TpZi
         6uYwjco4o8D12Y++pAFVPwMv48PsjAsQRB1MWYNAfD6y3JffEZGcQHXKfa85jq0x4fAe
         akuPoooFQhubpI/hQLe7TzJBNLxv6kDndhNwW2Ntal2GfxyyqPEOfQ+/CMTGldcboDtj
         TTaw==
X-Gm-Message-State: AOJu0Yyf4nWdWYb96OxXOiUd3feYr8lpRFGM4XgVWC3pIwU7b6leu6BI
        gDt8XgmMIuXl/Ie9C7yOSx5HUGsokMp1qRwzTlDMEw==
X-Google-Smtp-Source: AGHT+IH47g4Le+Lf1q4ziu35FL0XvzpXdFY6RIXBAKvsqYuyum8w9sX6tQTrCEc9ryJoV2I3l4sxyA==
X-Received: by 2002:a05:6a20:7290:b0:131:c760:2a0b with SMTP id o16-20020a056a20729000b00131c7602a0bmr3111400pzk.52.1695483335205;
        Sat, 23 Sep 2023 08:35:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ff11-20020a056a002f4b00b00686bef8e55csm5046500pfb.39.2023.09.23.08.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 08:35:34 -0700 (PDT)
Message-ID: <650f05c6.050a0220.bf81e.874d@mx.google.com>
Date:   Sat, 23 Sep 2023 08:35:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.133
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 76 runs, 5 regressions (v5.15.133)
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

stable-rc/linux-5.15.y baseline: 76 runs, 5 regressions (v5.15.133)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.133/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.133
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b911329317b4218e63baf78f3f422efbaa7198ed =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650ed0094114831f478a0a74

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ed0094114831f478a0a7d
        failing since 178 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-23T11:47:27.297075  <8>[   11.147963] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11601824_1.4.2.3.1>

    2023-09-23T11:47:27.300535  + set +x

    2023-09-23T11:47:27.401813  / #

    2023-09-23T11:47:27.502646  # #export SHELL=3D/bin/sh

    2023-09-23T11:47:27.502824  =


    2023-09-23T11:47:27.603327  / # export SHELL=3D/bin/sh. /lava-11601824/=
environment

    2023-09-23T11:47:27.603502  =


    2023-09-23T11:47:27.704047  / # . /lava-11601824/environment/lava-11601=
824/bin/lava-test-runner /lava-11601824/1

    2023-09-23T11:47:27.704324  =


    2023-09-23T11:47:27.709182  / # /lava-11601824/bin/lava-test-runner /la=
va-11601824/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650ed000986ef2c5278a0a42

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ed000986ef2c5278a0a4b
        failing since 178 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-23T11:45:53.100865  <8>[   10.523274] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11601811_1.4.2.3.1>

    2023-09-23T11:45:53.104310  + set +x

    2023-09-23T11:45:53.205679  #

    2023-09-23T11:45:53.307182  / # #export SHELL=3D/bin/sh

    2023-09-23T11:45:53.307899  =


    2023-09-23T11:45:53.409205  / # export SHELL=3D/bin/sh. /lava-11601811/=
environment

    2023-09-23T11:45:53.409544  =


    2023-09-23T11:45:53.510514  / # . /lava-11601811/environment/lava-11601=
811/bin/lava-test-runner /lava-11601811/1

    2023-09-23T11:45:53.511849  =


    2023-09-23T11:45:53.517383  / # /lava-11601811/bin/lava-test-runner /la=
va-11601811/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650ecff6ef6ccee1858a0a82

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ecff6ef6ccee1858a0a8b
        failing since 178 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-23T11:45:42.394744  <8>[   10.493929] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11601837_1.4.2.3.1>

    2023-09-23T11:45:42.398078  + set +x

    2023-09-23T11:45:42.499707  =


    2023-09-23T11:45:42.600366  / # #export SHELL=3D/bin/sh

    2023-09-23T11:45:42.600559  =


    2023-09-23T11:45:42.701064  / # export SHELL=3D/bin/sh. /lava-11601837/=
environment

    2023-09-23T11:45:42.701287  =


    2023-09-23T11:45:42.801820  / # . /lava-11601837/environment/lava-11601=
837/bin/lava-test-runner /lava-11601837/1

    2023-09-23T11:45:42.802224  =


    2023-09-23T11:45:42.807453  / # /lava-11601837/bin/lava-test-runner /la=
va-11601837/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14a-cb0001xx-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650ecffe291c3d5ca68a0a42

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ecffe291c3d5ca68a0a4b
        failing since 178 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-23T11:45:46.431691  + set<8>[   10.696197] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11601804_1.4.2.3.1>

    2023-09-23T11:45:46.431813   +x

    2023-09-23T11:45:46.535753  / # #

    2023-09-23T11:45:46.636339  export SHELL=3D/bin/sh

    2023-09-23T11:45:46.636511  #

    2023-09-23T11:45:46.736998  / # export SHELL=3D/bin/sh. /lava-11601804/=
environment

    2023-09-23T11:45:46.737163  =


    2023-09-23T11:45:46.837645  / # . /lava-11601804/environment/lava-11601=
804/bin/lava-test-runner /lava-11601804/1

    2023-09-23T11:45:46.837964  =


    2023-09-23T11:45:46.842762  / # /lava-11601804/bin/lava-test-runner /la=
va-11601804/1
 =

    ... (12 line(s) more)  =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650ecff29a57cf617d8a0a66

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
33/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ecff29a57cf617d8a0a6f
        failing since 178 days (last pass: v5.15.104, first fail: v5.15.104=
-147-gea115396267e)

    2023-09-23T11:45:39.852087  <8>[   11.608782] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11601795_1.4.2.3.1>

    2023-09-23T11:45:39.960067  / # #

    2023-09-23T11:45:40.061997  export SHELL=3D/bin/sh

    2023-09-23T11:45:40.062623  #

    2023-09-23T11:45:40.163997  / # export SHELL=3D/bin/sh. /lava-11601795/=
environment

    2023-09-23T11:45:40.164620  =


    2023-09-23T11:45:40.265988  / # . /lava-11601795/environment/lava-11601=
795/bin/lava-test-runner /lava-11601795/1

    2023-09-23T11:45:40.267061  =


    2023-09-23T11:45:40.271999  / # /lava-11601795/bin/lava-test-runner /la=
va-11601795/1

    2023-09-23T11:45:40.277442  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =20
