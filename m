Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F26789840
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 18:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjHZQod (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 12:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjHZQoE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 12:44:04 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5F91995
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 09:44:01 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68a520dba33so1549595b3a.0
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 09:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693068240; x=1693673040;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zVjh4mD0R41ufDPsXSmuzDKojK2904vXClnbHR7mKuc=;
        b=Wvt/GVO79BHTvwX/SrrnVoKpFnMVPFasOKph8dsLA//yv6c0b3b0Tjb0tSevl1by17
         2lqIRZUVWjYhcDaskPog7V4y4OwCrMOnPp17uCwyux7lEb9bq8WJRgAwKsVxqoYErfFj
         UbM3L5NNSFbGFNEWi/Cv5h7tjcLsiahCaHPfone7njsEcBQDFksrXYc8DJ5JyMoMx7NA
         JAQyizrLvCWZTw4er8g/B3/BzyyidD1L/f5y4BL/d8OmuGzOH3cJ09T+Kr8CENkdKEJH
         gq7cY2yUg7s7vQibX/cZQV40ZzR+VJeHf+D65h88BnKF9IfJ1+Pg+X4batmCRZAvtF+Y
         xM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693068240; x=1693673040;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zVjh4mD0R41ufDPsXSmuzDKojK2904vXClnbHR7mKuc=;
        b=O8My99izpx2rUw0yRuLPQANekfg3qLQxDQKVVRao/2ThJFvrE0PdMQUF5urFqekXUM
         HTF1ycXpwPn0CatAdI2bumLCENu6pMm+u16a36Rcf+9NCuSFIi4gMNJwJ4HXDjKPJXfl
         w68duKIUJ6l40OVkuFg5dMirx9PIEk2MYii2qb+vD1LtEAEruAVPO++zL5nbjG15eHUO
         3ZsJTKR3I7adTgfmoaAH1/jiJZpod/VRceIQA7meHq/PM7NYwwyMT7ciMlEz1gmMk9un
         SXsf+4ThwpVSCvW+D+m3fqMTaN9M3SqHmNxLcEC/YtR2aIdpPVisqgwgYwe3eALD10Hu
         R4Wg==
X-Gm-Message-State: AOJu0Yy6cjVhOSd6RLbbPTG4CkMwiXEKmJ4pPYXPiwvwRZqqTSqg97pQ
        ShLXdiec+oTZUp3rSVflaoY9hE1FWNRL5JDTWvY=
X-Google-Smtp-Source: AGHT+IEt0J28uM9RJMvW/HWC3sBLXyHVc5Bd9gg9eymCPbPpKNd20tKZQFriqcCfKShXN6cufMi7WQ==
X-Received: by 2002:a05:6a21:78aa:b0:132:ff57:7fab with SMTP id bf42-20020a056a2178aa00b00132ff577fabmr29114709pzc.2.1693068240088;
        Sat, 26 Aug 2023 09:44:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z3-20020a63ac43000000b0056c41227d4dsm3832220pgn.90.2023.08.26.09.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 09:43:59 -0700 (PDT)
Message-ID: <64ea2bcf.630a0220.459b1.56f9@mx.google.com>
Date:   Sat, 26 Aug 2023 09:43:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.48
Subject: stable/linux-6.1.y baseline: 123 runs, 12 regressions (v6.1.48)
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

stable/linux-6.1.y baseline: 123 runs, 12 regressions (v6.1.48)

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

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.48/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.48
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      cd363bb9548ec3208120bb3f55ff4ded2487d7fb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9f7670761249510286d7b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9f7670761249510286d80
        failing since 148 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-26T13:00:19.065891  <8>[   10.277490] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11361998_1.4.2.3.1>

    2023-08-26T13:00:19.069156  + set +x

    2023-08-26T13:00:19.173959  / # #

    2023-08-26T13:00:19.274527  export SHELL=3D/bin/sh

    2023-08-26T13:00:19.274718  #

    2023-08-26T13:00:19.375305  / # export SHELL=3D/bin/sh. /lava-11361998/=
environment

    2023-08-26T13:00:19.375492  =


    2023-08-26T13:00:19.475989  / # . /lava-11361998/environment/lava-11361=
998/bin/lava-test-runner /lava-11361998/1

    2023-08-26T13:00:19.476315  =


    2023-08-26T13:00:19.482914  / # /lava-11361998/bin/lava-test-runner /la=
va-11361998/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9f769e1ad1cdee0286da1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9f769e1ad1cdee0286da6
        failing since 148 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-26T13:00:20.162641  + <8>[   12.209849] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11362003_1.4.2.3.1>

    2023-08-26T13:00:20.163191  set +x

    2023-08-26T13:00:20.271255  / # #

    2023-08-26T13:00:20.373782  export SHELL=3D/bin/sh

    2023-08-26T13:00:20.374615  #

    2023-08-26T13:00:20.476214  / # export SHELL=3D/bin/sh. /lava-11362003/=
environment

    2023-08-26T13:00:20.477026  =


    2023-08-26T13:00:20.578836  / # . /lava-11362003/environment/lava-11362=
003/bin/lava-test-runner /lava-11362003/1

    2023-08-26T13:00:20.580080  =


    2023-08-26T13:00:20.584936  / # /lava-11362003/bin/lava-test-runner /la=
va-11362003/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9f774dd450903e0286dfe

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9f774dd450903e0286e03
        failing since 148 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-26T13:00:21.140002  <8>[   10.473947] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11362009_1.4.2.3.1>

    2023-08-26T13:00:21.143315  + set +x

    2023-08-26T13:00:21.249357  =


    2023-08-26T13:00:21.351343  / # #export SHELL=3D/bin/sh

    2023-08-26T13:00:21.352228  =


    2023-08-26T13:00:21.454033  / # export SHELL=3D/bin/sh. /lava-11362009/=
environment

    2023-08-26T13:00:21.454863  =


    2023-08-26T13:00:21.556941  / # . /lava-11362009/environment/lava-11362=
009/bin/lava-test-runner /lava-11362009/1

    2023-08-26T13:00:21.558335  =


    2023-08-26T13:00:21.563848  / # /lava-11362009/bin/lava-test-runner /la=
va-11362009/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9fbdc06dc62a1b2286d8b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/arm=
/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/arm=
/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e9fbdc06dc62a1b2286=
d8c
        failing since 2 days (last pass: v6.1.46, first fail: v6.1.47) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9f75f210deabfbf286eb5

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9f75f210deabfbf286eba
        failing since 148 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-26T13:00:06.180816  + set +x

    2023-08-26T13:00:06.187128  <8>[   10.349706] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11362030_1.4.2.3.1>

    2023-08-26T13:00:06.291902  / # #

    2023-08-26T13:00:06.392529  export SHELL=3D/bin/sh

    2023-08-26T13:00:06.392738  #

    2023-08-26T13:00:06.493281  / # export SHELL=3D/bin/sh. /lava-11362030/=
environment

    2023-08-26T13:00:06.493461  =


    2023-08-26T13:00:06.594007  / # . /lava-11362030/environment/lava-11362=
030/bin/lava-test-runner /lava-11362030/1

    2023-08-26T13:00:06.594265  =


    2023-08-26T13:00:06.598579  / # /lava-11362030/bin/lava-test-runner /la=
va-11362030/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9f74e43df21ac1e286d70

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9f74e43df21ac1e286d75
        failing since 148 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-26T12:59:45.142086  <8>[   10.965280] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11362021_1.4.2.3.1>

    2023-08-26T12:59:45.145663  + set +x

    2023-08-26T12:59:45.250796  #

    2023-08-26T12:59:45.251893  =


    2023-08-26T12:59:45.353662  / # #export SHELL=3D/bin/sh

    2023-08-26T12:59:45.354407  =


    2023-08-26T12:59:45.455856  / # export SHELL=3D/bin/sh. /lava-11362021/=
environment

    2023-08-26T12:59:45.456614  =


    2023-08-26T12:59:45.558037  / # . /lava-11362021/environment/lava-11362=
021/bin/lava-test-runner /lava-11362021/1

    2023-08-26T12:59:45.559219  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9f76eb3409b313a286dac

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9f76eb3409b313a286db1
        failing since 148 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-26T13:00:12.769000  + <8>[   11.898051] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11362027_1.4.2.3.1>

    2023-08-26T13:00:12.769453  set +x

    2023-08-26T13:00:12.877749  / # #

    2023-08-26T13:00:12.978932  export SHELL=3D/bin/sh

    2023-08-26T13:00:12.979787  #

    2023-08-26T13:00:13.081505  / # export SHELL=3D/bin/sh. /lava-11362027/=
environment

    2023-08-26T13:00:13.082560  =


    2023-08-26T13:00:13.184904  / # . /lava-11362027/environment/lava-11362=
027/bin/lava-test-runner /lava-11362027/1

    2023-08-26T13:00:13.186226  =


    2023-08-26T13:00:13.191087  / # /lava-11362027/bin/lava-test-runner /la=
va-11362027/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9f752c8acc694fe286d7e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9f752c8acc694fe286d83
        failing since 148 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-26T13:00:03.765462  <8>[   11.184251] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11362014_1.4.2.3.1>

    2023-08-26T13:00:03.869853  / # #

    2023-08-26T13:00:03.970502  export SHELL=3D/bin/sh

    2023-08-26T13:00:03.970689  #

    2023-08-26T13:00:04.071235  / # export SHELL=3D/bin/sh. /lava-11362014/=
environment

    2023-08-26T13:00:04.071409  =


    2023-08-26T13:00:04.172032  / # . /lava-11362014/environment/lava-11362=
014/bin/lava-test-runner /lava-11362014/1

    2023-08-26T13:00:04.172310  =


    2023-08-26T13:00:04.176970  / # /lava-11362014/bin/lava-test-runner /la=
va-11362014/1

    2023-08-26T13:00:04.183444  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9f9f65a10247d19286db3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/arm=
64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui-ja=
cuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/arm=
64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui-ja=
cuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e9f9f65a10247d19286=
db4
        new failure (last pass: v6.1.47) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9f83b42edcc2ce2286d92

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9f83b42edcc2ce2286d97
        failing since 37 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-08-26T13:05:14.233066  / # #

    2023-08-26T13:05:14.335083  export SHELL=3D/bin/sh

    2023-08-26T13:05:14.335809  #

    2023-08-26T13:05:14.437239  / # export SHELL=3D/bin/sh. /lava-11362057/=
environment

    2023-08-26T13:05:14.437973  =


    2023-08-26T13:05:14.539408  / # . /lava-11362057/environment/lava-11362=
057/bin/lava-test-runner /lava-11362057/1

    2023-08-26T13:05:14.540509  =


    2023-08-26T13:05:14.557403  / # /lava-11362057/bin/lava-test-runner /la=
va-11362057/1

    2023-08-26T13:05:14.605411  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T13:05:14.605899  + cd /lav<8>[   19.084139] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11362057_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9f85c97190f0f68286dfc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9f85c97190f0f68286e01
        failing since 37 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-08-26T13:04:16.469088  / # #

    2023-08-26T13:04:17.546464  export SHELL=3D/bin/sh

    2023-08-26T13:04:17.548168  #

    2023-08-26T13:04:19.037693  / # export SHELL=3D/bin/sh. /lava-11362055/=
environment

    2023-08-26T13:04:19.039504  =


    2023-08-26T13:04:21.755966  / # . /lava-11362055/environment/lava-11362=
055/bin/lava-test-runner /lava-11362055/1

    2023-08-26T13:04:21.757384  =


    2023-08-26T13:04:21.767602  / # /lava-11362055/bin/lava-test-runner /la=
va-11362055/1

    2023-08-26T13:04:21.826649  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T13:04:21.826727  + cd /lav<8>[   28.462033] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11362055_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64e9f83c5d2230879b286db7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.48/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e9f83c5d2230879b286dbc
        failing since 37 days (last pass: v6.1.38, first fail: v6.1.39)

    2023-08-26T13:05:25.756627  / # #

    2023-08-26T13:05:25.858786  export SHELL=3D/bin/sh

    2023-08-26T13:05:25.859492  #

    2023-08-26T13:05:25.960589  / # export SHELL=3D/bin/sh. /lava-11362061/=
environment

    2023-08-26T13:05:25.960799  =


    2023-08-26T13:05:26.061238  / # . /lava-11362061/environment/lava-11362=
061/bin/lava-test-runner /lava-11362061/1

    2023-08-26T13:05:26.061449  =


    2023-08-26T13:05:26.064170  / # /lava-11362061/bin/lava-test-runner /la=
va-11362061/1

    2023-08-26T13:05:26.144526  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-26T13:05:26.144818  + cd /lava-11362061/1/tests/1_boot<8>[   16=
.969614] <LAVA_SIGNAL_STARTRUN 1_bootrr 11362061_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
