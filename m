Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C20706DC8
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 18:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjEQQPP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 12:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjEQQPL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 12:15:11 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F082E93D7
        for <stable@vger.kernel.org>; Wed, 17 May 2023 09:15:02 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6439d505274so698782b3a.0
        for <stable@vger.kernel.org>; Wed, 17 May 2023 09:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684340102; x=1686932102;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pJ1/vFlw7Pn8jdpjPzTy/sHGlOMBn20EXmNAp0GOAv4=;
        b=Qg9SwRWeryD4OPcrpeEW/D6yUZqCYs/0pO4PqP/Y2GQE5cyI74DLGlx8MV1+c1YkDN
         Ajw/KWfnIok6V16s6bbRFUS9aS5oCJcB09XYqQ4197BDPlLkReZZHhRzkIqKlL9cQhae
         Iei6McZhYhlqJvRLXoqGnz217B/PzsGJhMlqpU7JhArAWdEIFFygfQIJtzbsNha8E7jZ
         cViyNUuJ6u4dDiFu5UJNvXQ+o8hyhr/QZOCP+wZK5WGpSG3KtnTIfsFTxocQdstjAbxu
         1Jcxr7U5N/A6I53BB905xJeKCs741LkI1LzDg+SG49PxZK8TJWWw15jTsBPWwj7znyYf
         bxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684340102; x=1686932102;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJ1/vFlw7Pn8jdpjPzTy/sHGlOMBn20EXmNAp0GOAv4=;
        b=j+2g1eHXN/l1sb6F+9BwXbQXZ0OeocrxqKlmHi2cJd09noaREj4qdnl56Pqr7r+kQz
         /H3dGYNnaO1nNEQZccT7nUaV/BI6Z1QURWLJeosTZiV2LGXKqXA6J4WyBFXdo5c8Kgi/
         GxZ6aexSp0wThPyhqYP0taW4mSrEa5Bx2IPuhktTJXEaU5mUCZBom+wrnjTmJqXDHBDk
         FwutRy1+lJOQtcPf+ahYKx+39SpHxvtYQQkF37l983jgvKIL5k71/hLsrO8srrPMSH4S
         SLHBFGHi1wqQ+lN4o955OKtb74MTvG6AeTykf0/DAHpOnSx1vmeN37MFf6Ow9FJBWT5N
         hhUw==
X-Gm-Message-State: AC+VfDzUDSFmu9c0qtVWG1H4FXvd29iyDXvn2kbyp4nE8rvd7kA7zwmj
        isbCQ4/GIhsY2nPJl6C0EtUUrEAsf8vcK9mIhHIjVw==
X-Google-Smtp-Source: ACHHUZ7NjkbObuWhM+9Pqx3Be6uZ/tSKuRXy2MO1TBgVVMpRe72ZJS1YavDtE8LkKIvnNfWrNAqtiA==
X-Received: by 2002:a05:6a21:3298:b0:104:beb4:da38 with SMTP id yt24-20020a056a21329800b00104beb4da38mr22191557pzb.35.1684340101816;
        Wed, 17 May 2023 09:15:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h7-20020a635747000000b0052cbd854927sm15344617pgm.18.2023.05.17.09.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 09:15:01 -0700 (PDT)
Message-ID: <6464fd85.630a0220.aa23d.c542@mx.google.com>
Date:   Wed, 17 May 2023 09:15:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v6.1.29
X-Kernelci-Report-Type: test
Subject: stable/linux-6.1.y baseline: 157 runs, 9 regressions (v6.1.29)
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

stable/linux-6.1.y baseline: 157 runs, 9 regressions (v6.1.29)

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


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.29/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.29
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      fa74641fb6b93a19ccb50579886ecc98320230f9 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c8d3664587110d2e8631

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.29/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.29/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c8d3664587110d2e8636
        failing since 47 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-17T12:29:53.839504  <8>[   10.123547] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10352476_1.4.2.3.1>

    2023-05-17T12:29:53.843039  + set +x

    2023-05-17T12:29:53.944729  /#

    2023-05-17T12:29:54.045509   # #export SHELL=3D/bin/sh

    2023-05-17T12:29:54.045748  =


    2023-05-17T12:29:54.146324  / # export SHELL=3D/bin/sh. /lava-10352476/=
environment

    2023-05-17T12:29:54.146536  =


    2023-05-17T12:29:54.247143  / # . /lava-10352476/environment/lava-10352=
476/bin/lava-test-runner /lava-10352476/1

    2023-05-17T12:29:54.247448  =


    2023-05-17T12:29:54.252379  / # /lava-10352476/bin/lava-test-runner /la=
va-10352476/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c8b873c6fc94202e8630

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.29/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.29/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c8b873c6fc94202e8635
        failing since 47 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-17T12:29:24.191386  + set<8>[   11.110977] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10352541_1.4.2.3.1>

    2023-05-17T12:29:24.191823   +x

    2023-05-17T12:29:24.295155  / # #

    2023-05-17T12:29:24.396117  export SHELL=3D/bin/sh

    2023-05-17T12:29:24.396922  #

    2023-05-17T12:29:24.498204  / # export SHELL=3D/bin/sh. /lava-10352541/=
environment

    2023-05-17T12:29:24.498429  =


    2023-05-17T12:29:24.599011  / # . /lava-10352541/environment/lava-10352=
541/bin/lava-test-runner /lava-10352541/1

    2023-05-17T12:29:24.599312  =


    2023-05-17T12:29:24.603869  / # /lava-10352541/bin/lava-test-runner /la=
va-10352541/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c8b7f8f24fbdd02e8634

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.29/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.29/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c8b7f8f24fbdd02e8639
        failing since 47 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-17T12:29:23.792119  <8>[   10.932055] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10352488_1.4.2.3.1>

    2023-05-17T12:29:23.792659  + set +x

    2023-05-17T12:29:23.898651  =


    2023-05-17T12:29:24.000688  / # #export SHELL=3D/bin/sh

    2023-05-17T12:29:24.001390  =


    2023-05-17T12:29:24.102754  / # export SHELL=3D/bin/sh. /lava-10352488/=
environment

    2023-05-17T12:29:24.102944  =


    2023-05-17T12:29:24.203625  / # . /lava-10352488/environment/lava-10352=
488/bin/lava-test-runner /lava-10352488/1

    2023-05-17T12:29:24.203932  =


    2023-05-17T12:29:24.209022  / # /lava-10352488/bin/lava-test-runner /la=
va-10352488/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c9827cab060a152e8612

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.29/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.29/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c9827cab060a152e8617
        failing since 47 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-17T12:32:55.510159  + set +x

    2023-05-17T12:32:55.516635  <8>[   10.670050] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10352537_1.4.2.3.1>

    2023-05-17T12:32:55.621116  / # #

    2023-05-17T12:32:55.721742  export SHELL=3D/bin/sh

    2023-05-17T12:32:55.721947  #

    2023-05-17T12:32:55.822503  / # export SHELL=3D/bin/sh. /lava-10352537/=
environment

    2023-05-17T12:32:55.822731  =


    2023-05-17T12:32:55.923307  / # . /lava-10352537/environment/lava-10352=
537/bin/lava-test-runner /lava-10352537/1

    2023-05-17T12:32:55.923603  =


    2023-05-17T12:32:55.928055  / # /lava-10352537/bin/lava-test-runner /la=
va-10352537/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c8d90b16ea0dda2e8613

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.29/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.29/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c8d90b16ea0dda2e8618
        failing since 47 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-17T12:29:57.182066  <8>[   10.343835] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10352530_1.4.2.3.1>

    2023-05-17T12:29:57.185488  + set +x

    2023-05-17T12:29:57.291601  =


    2023-05-17T12:29:57.393394  / # #export SHELL=3D/bin/sh

    2023-05-17T12:29:57.394208  =


    2023-05-17T12:29:57.495686  / # export SHELL=3D/bin/sh. /lava-10352530/=
environment

    2023-05-17T12:29:57.496470  =


    2023-05-17T12:29:57.597944  / # . /lava-10352530/environment/lava-10352=
530/bin/lava-test-runner /lava-10352530/1

    2023-05-17T12:29:57.599071  =


    2023-05-17T12:29:57.604180  / # /lava-10352530/bin/lava-test-runner /la=
va-10352530/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c85429900cca3a2e85f8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.29/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.29/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c85429900cca3a2e85fd
        failing since 47 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-17T12:27:48.009235  + set<8>[   11.093065] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10352540_1.4.2.3.1>

    2023-05-17T12:27:48.009657   +x

    2023-05-17T12:27:48.119410  / # #

    2023-05-17T12:27:48.221581  export SHELL=3D/bin/sh

    2023-05-17T12:27:48.221808  #

    2023-05-17T12:27:48.322499  / # export SHELL=3D/bin/sh. /lava-10352540/=
environment

    2023-05-17T12:27:48.323205  =


    2023-05-17T12:27:48.424634  / # . /lava-10352540/environment/lava-10352=
540/bin/lava-test-runner /lava-10352540/1

    2023-05-17T12:27:48.425779  =


    2023-05-17T12:27:48.431470  / # /lava-10352540/bin/lava-test-runner /la=
va-10352540/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464c86b11b56df2152e8662

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.29/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.29/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464c86b11b56df2152e8667
        failing since 47 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-17T12:28:11.777652  + set<8>[   11.667843] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10352507_1.4.2.3.1>

    2023-05-17T12:28:11.777745   +x

    2023-05-17T12:28:11.881925  / # #

    2023-05-17T12:28:11.982459  export SHELL=3D/bin/sh

    2023-05-17T12:28:11.982685  #

    2023-05-17T12:28:12.083189  / # export SHELL=3D/bin/sh. /lava-10352507/=
environment

    2023-05-17T12:28:12.083368  =


    2023-05-17T12:28:12.183845  / # . /lava-10352507/environment/lava-10352=
507/bin/lava-test-runner /lava-10352507/1

    2023-05-17T12:28:12.184138  =


    2023-05-17T12:28:12.189156  / # /lava-10352507/bin/lava-test-runner /la=
va-10352507/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6464ccc8fb24a6f0802e85e9

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.29/arm=
64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui-ja=
cuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.29/arm=
64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui-ja=
cuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6464ccc8fb24a6f0802e85ed
        failing since 5 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-05-17T12:46:49.509594  /lava-10353188/1/../bin/lava-test-case

    2023-05-17T12:46:49.516149  <8>[   23.027182] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464ccc8fb24a6f0802e8679
        failing since 5 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-05-17T12:46:44.033585  + set +x

    2023-05-17T12:46:44.040270  <8>[   17.550074] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10353188_1.5.2.3.1>

    2023-05-17T12:46:44.145769  / # #

    2023-05-17T12:46:44.246461  export SHELL=3D/bin/sh

    2023-05-17T12:46:44.246638  #

    2023-05-17T12:46:44.347141  / # export SHELL=3D/bin/sh. /lava-10353188/=
environment

    2023-05-17T12:46:44.347325  =


    2023-05-17T12:46:44.447839  / # . /lava-10353188/environment/lava-10353=
188/bin/lava-test-runner /lava-10353188/1

    2023-05-17T12:46:44.448139  =


    2023-05-17T12:46:44.453088  / # /lava-10353188/bin/lava-test-runner /la=
va-10353188/1
 =

    ... (13 line(s) more)  =

 =20
