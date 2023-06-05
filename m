Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577AD722513
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 14:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjFEMA1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 08:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjFEMAW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 08:00:22 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1983131
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 05:00:14 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d44b198baso3371690b3a.0
        for <stable@vger.kernel.org>; Mon, 05 Jun 2023 05:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685966413; x=1688558413;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JZVXRGS6fLb13cB+n24KZvYUt4va5/rIPJbcQKa5fXM=;
        b=5iySa9B1ALs0jlk9zIz8vfuKDzDWqG+riIxwFc+u3hQ2OT9O0YQRMfpxVhwKhLPqVx
         K5yR23ji8rVrDqlCyZRMqfsmdPkLzPMZtJx3S/ar/+mJgSQOvNeWJ0DYa6r0NipUMVYZ
         20BgOLqX84jH6DwVp6R9/xNpfpoLBWZxoENl9hC6rLcYGtsaIPFWfNAtv1ZtFZUVxda+
         KnWrcSue9aRKUhuoNR4kyrQeR3xsUWsOmDgByIpjzZry1UEezFQJKA9mv7khw72IDwuT
         h5CGqIJKcBycjrWBwYP5NptZG0LZ8ScCBurnBEpFu6gWtWgzNkhKb3tGQ1xlaS3zxY4T
         Gziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685966413; x=1688558413;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZVXRGS6fLb13cB+n24KZvYUt4va5/rIPJbcQKa5fXM=;
        b=I3wovHQ506/FbWVtkCKn62JMd59/3WY+oddm8ifPrnvsu2TvL2WBrprVzcKoIB3qDy
         am0JlClfu1i23cVi/W3KoJqYAsUi8zgkqJgVdX31LYB8nYvnwD682g7lQ77clcpe+noF
         99IVj/mo9goyLkNhfrLw+bkjgFJ1Q09SvToBnk2jpNU+JSZQAf/ZL0RuI7TlwM1d37HV
         j65+VwOQk3Zc2uDNPvbHm+bt6rotVyvi0pCk42hxbVNB+LqO7ilMLt9qAn6xCrtaUWuu
         R8EDgld61dOL83y33YnD4hVykWeFsqpy/XuoQ/4HjMHoRb2IRMtMXPTW3CmcIJogtDT8
         Vekw==
X-Gm-Message-State: AC+VfDyw0paHEFQcc36M6xwiOk3SP9QpqQfNFLVD2r4hG/hEwMFnkw75
        BOe1TUk0rf+e8fIJXBI0DeeDFOidRe+rc5WD7CD6rw==
X-Google-Smtp-Source: ACHHUZ6MAdfhMRIMgdXQ6DyE/EHIwUbkRoCTtu9dCJ2GoHRolRLVID+FxSMCkm8fX4cNvzML8X0GOw==
X-Received: by 2002:a05:6a20:7d8c:b0:103:b585:b587 with SMTP id v12-20020a056a207d8c00b00103b585b587mr7194361pzj.13.1685966413165;
        Mon, 05 Jun 2023 05:00:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x19-20020a056a00271300b0063d2cd02d69sm5120334pfv.54.2023.06.05.05.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 05:00:12 -0700 (PDT)
Message-ID: <647dce4c.050a0220.24167.8221@mx.google.com>
Date:   Mon, 05 Jun 2023 05:00:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.115
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
Subject: stable/linux-5.15.y baseline: 206 runs, 23 regressions (v5.15.115)
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

stable/linux-5.15.y baseline: 206 runs, 23 regressions (v5.15.115)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm...ok+kselftest | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm...ok+kselftest | 4          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.115/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.115
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      d7af3e5ba454d007b4939f858739cf1cecdeab46 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d9364503328a313f5de26

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d9364503328a313f5de2f
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-05T07:48:42.077067  <8>[   10.918658] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10588777_1.4.2.3.1>

    2023-06-05T07:48:42.080709  + set +x

    2023-06-05T07:48:42.184664  / # #

    2023-06-05T07:48:42.285382  export SHELL=3D/bin/sh

    2023-06-05T07:48:42.285552  #

    2023-06-05T07:48:42.386124  / # export SHELL=3D/bin/sh. /lava-10588777/=
environment

    2023-06-05T07:48:42.386297  =


    2023-06-05T07:48:42.486841  / # . /lava-10588777/environment/lava-10588=
777/bin/lava-test-runner /lava-10588777/1

    2023-06-05T07:48:42.487111  =


    2023-06-05T07:48:42.492719  / # /lava-10588777/bin/lava-test-runner /la=
va-10588777/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647d94549e08922001f5de2f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d94549e08922001f5de38
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-05T07:52:42.103463  <8>[   25.529657] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10588826_1.4.2.3.1>

    2023-06-05T07:52:42.107483  + set +x

    2023-06-05T07:52:42.211957  =


    2023-06-05T07:52:42.312536  / # #export SHELL=3D/bin/sh

    2023-06-05T07:52:42.312708  =


    2023-06-05T07:52:42.413223  / # export SHELL=3D/bin/sh. /lava-10588826/=
environment

    2023-06-05T07:52:42.413403  =


    2023-06-05T07:52:42.513979  / # . /lava-10588826/environment/lava-10588=
826/bin/lava-test-runner /lava-10588826/1

    2023-06-05T07:52:42.514248  =


    2023-06-05T07:52:42.520177  / # /lava-10588826/bin/lava-test-runner /la=
va-10588826/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d9367610d505654f5de64

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d9367610d505654f5de6d
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-05T07:48:31.299639  + set +x<8>[   10.838665] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10588765_1.4.2.3.1>

    2023-06-05T07:48:31.299756  =


    2023-06-05T07:48:31.404161  / # #

    2023-06-05T07:48:31.504747  export SHELL=3D/bin/sh

    2023-06-05T07:48:31.504977  #

    2023-06-05T07:48:31.605546  / # export SHELL=3D/bin/sh. /lava-10588765/=
environment

    2023-06-05T07:48:31.605741  =


    2023-06-05T07:48:31.706224  / # . /lava-10588765/environment/lava-10588=
765/bin/lava-test-runner /lava-10588765/1

    2023-06-05T07:48:31.706502  =


    2023-06-05T07:48:31.711278  / # /lava-10588765/bin/lava-test-runner /la=
va-10588765/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647d9442c63b422897f5de26

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d9442c63b422897f5de2f
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-05T07:52:16.112892  + <8>[   12.255395] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10588850_1.4.2.3.1>

    2023-06-05T07:52:16.113054  set +x

    2023-06-05T07:52:16.217917  / # #

    2023-06-05T07:52:16.318785  export SHELL=3D/bin/sh

    2023-06-05T07:52:16.319065  #

    2023-06-05T07:52:16.419695  / # export SHELL=3D/bin/sh. /lava-10588850/=
environment

    2023-06-05T07:52:16.419974  =


    2023-06-05T07:52:16.520638  / # . /lava-10588850/environment/lava-10588=
850/bin/lava-test-runner /lava-10588850/1

    2023-06-05T07:52:16.521079  =


    2023-06-05T07:52:16.525479  / # /lava-10588850/bin/lava-test-runner /la=
va-10588850/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d9352f4a6b2fc32f5de86

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d9352f4a6b2fc32f5de8f
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-05T07:48:26.502628  <8>[    8.211783] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10588736_1.4.2.3.1>

    2023-06-05T07:48:26.505967  + set +x

    2023-06-05T07:48:26.607352  #

    2023-06-05T07:48:26.607614  =


    2023-06-05T07:48:26.708226  / # #export SHELL=3D/bin/sh

    2023-06-05T07:48:26.708428  =


    2023-06-05T07:48:26.809034  / # export SHELL=3D/bin/sh. /lava-10588736/=
environment

    2023-06-05T07:48:26.809213  =


    2023-06-05T07:48:26.909711  / # . /lava-10588736/environment/lava-10588=
736/bin/lava-test-runner /lava-10588736/1

    2023-06-05T07:48:26.909972  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647d9441cd74eb6990f5de54

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d9441cd74eb6990f5de5d
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-05T07:52:17.110214  <8>[   12.546874] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10588847_1.4.2.3.1>

    2023-06-05T07:52:17.113918  + set +x

    2023-06-05T07:52:17.216044  =


    2023-06-05T07:52:17.316667  / # #export SHELL=3D/bin/sh

    2023-06-05T07:52:17.316861  =


    2023-06-05T07:52:17.417405  / # export SHELL=3D/bin/sh. /lava-10588847/=
environment

    2023-06-05T07:52:17.417677  =


    2023-06-05T07:52:17.518334  / # . /lava-10588847/environment/lava-10588=
847/bin/lava-test-runner /lava-10588847/1

    2023-06-05T07:52:17.518759  =


    2023-06-05T07:52:17.523399  / # /lava-10588847/bin/lava-test-runner /la=
va-10588847/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647d98fc8f36705bcbf5de25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647d98fc8f36705bcbf5d=
e26
        failing since 60 days (last pass: v5.15.105, first fail: v5.15.106) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647d969052a838856af5de63

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d969052a838856af5de6c
        failing since 137 days (last pass: v5.15.82, first fail: v5.15.89)

    2023-06-05T08:01:53.479934  <8>[   10.056631] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3641650_1.5.2.4.1>
    2023-06-05T08:01:53.589910  / # #
    2023-06-05T08:01:53.693636  export SHELL=3D/bin/sh
    2023-06-05T08:01:53.694739  <3>[   10.113294] Bluetooth: hci0: command =
0x0c03 tx timeout
    2023-06-05T08:01:53.695305  #
    2023-06-05T08:01:53.797665  / # export SHELL=3D/bin/sh. /lava-3641650/e=
nvironment
    2023-06-05T08:01:53.798774  =

    2023-06-05T08:01:53.901405  / # . /lava-3641650/environment/lava-364165=
0/bin/lava-test-runner /lava-3641650/1
    2023-06-05T08:01:53.903320  =

    2023-06-05T08:01:53.908561  / # /lava-3641650/bin/lava-test-runner /lav=
a-3641650/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d938cb7481c66def5de25

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d938cb7481c66def5de2e
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-05T07:49:14.951475  + <8>[   10.051008] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10588742_1.4.2.3.1>

    2023-06-05T07:49:14.951602  set +x

    2023-06-05T07:49:15.053013  #

    2023-06-05T07:49:15.153901  / # #export SHELL=3D/bin/sh

    2023-06-05T07:49:15.154108  =


    2023-06-05T07:49:15.254695  / # export SHELL=3D/bin/sh. /lava-10588742/=
environment

    2023-06-05T07:49:15.254964  =


    2023-06-05T07:49:15.355559  / # . /lava-10588742/environment/lava-10588=
742/bin/lava-test-runner /lava-10588742/1

    2023-06-05T07:49:15.355888  =


    2023-06-05T07:49:15.360751  / # /lava-10588742/bin/lava-test-runner /la=
va-10588742/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647d94400f0533d52ff5de25

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d94400f0533d52ff5de2e
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-05T07:52:21.854700  + set<8>[   12.979577] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10588816_1.4.2.3.1>

    2023-06-05T07:52:21.854793   +x

    2023-06-05T07:52:21.958997  / # #

    2023-06-05T07:52:22.059653  export SHELL=3D/bin/sh

    2023-06-05T07:52:22.059868  #

    2023-06-05T07:52:22.160471  / # export SHELL=3D/bin/sh. /lava-10588816/=
environment

    2023-06-05T07:52:22.160674  =


    2023-06-05T07:52:22.261243  / # . /lava-10588816/environment/lava-10588=
816/bin/lava-test-runner /lava-10588816/1

    2023-06-05T07:52:22.261549  =


    2023-06-05T07:52:22.266862  / # /lava-10588816/bin/lava-test-runner /la=
va-10588816/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d9351f4a6b2fc32f5de78

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d9351f4a6b2fc32f5de81
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-05T07:48:27.587046  <8>[   10.239560] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10588700_1.4.2.3.1>

    2023-06-05T07:48:27.590613  + set +x

    2023-06-05T07:48:27.692042  =


    2023-06-05T07:48:27.792608  / # #export SHELL=3D/bin/sh

    2023-06-05T07:48:27.792808  =


    2023-06-05T07:48:27.893309  / # export SHELL=3D/bin/sh. /lava-10588700/=
environment

    2023-06-05T07:48:27.893522  =


    2023-06-05T07:48:27.994071  / # . /lava-10588700/environment/lava-10588=
700/bin/lava-test-runner /lava-10588700/1

    2023-06-05T07:48:27.994375  =


    2023-06-05T07:48:27.999411  / # /lava-10588700/bin/lava-test-runner /la=
va-10588700/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647d942ba7df2dac5df5de4b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d942ba7df2dac5df5de54
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-05T07:51:58.148106  + set +x

    2023-06-05T07:51:58.154876  <8>[   11.616195] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10588840_1.4.2.3.1>

    2023-06-05T07:51:58.259778  / # #

    2023-06-05T07:51:58.360666  export SHELL=3D/bin/sh

    2023-06-05T07:51:58.360954  #

    2023-06-05T07:51:58.461600  / # export SHELL=3D/bin/sh. /lava-10588840/=
environment

    2023-06-05T07:51:58.461897  =


    2023-06-05T07:51:58.562530  / # . /lava-10588840/environment/lava-10588=
840/bin/lava-test-runner /lava-10588840/1

    2023-06-05T07:51:58.562889  =


    2023-06-05T07:51:58.568239  / # /lava-10588840/bin/lava-test-runner /la=
va-10588840/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d93675e98c6065df5de5f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d93675e98c6065df5de68
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-05T07:48:29.178597  + set<8>[   11.110361] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10588764_1.4.2.3.1>

    2023-06-05T07:48:29.178727   +x

    2023-06-05T07:48:29.283018  / # #

    2023-06-05T07:48:29.383745  export SHELL=3D/bin/sh

    2023-06-05T07:48:29.384000  #

    2023-06-05T07:48:29.484580  / # export SHELL=3D/bin/sh. /lava-10588764/=
environment

    2023-06-05T07:48:29.484809  =


    2023-06-05T07:48:29.585365  / # . /lava-10588764/environment/lava-10588=
764/bin/lava-test-runner /lava-10588764/1

    2023-06-05T07:48:29.585713  =


    2023-06-05T07:48:29.590094  / # /lava-10588764/bin/lava-test-runner /la=
va-10588764/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647d943f2b1fb7c422f5de36

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d943f2b1fb7c422f5de3f
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-05T07:52:23.772119  <8>[   12.123409] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10588849_1.4.2.3.1>

    2023-06-05T07:52:23.880420  / # #

    2023-06-05T07:52:23.983118  export SHELL=3D/bin/sh

    2023-06-05T07:52:23.983958  #

    2023-06-05T07:52:24.085525  / # export SHELL=3D/bin/sh. /lava-10588849/=
environment

    2023-06-05T07:52:24.086320  =


    2023-06-05T07:52:24.187980  / # . /lava-10588849/environment/lava-10588=
849/bin/lava-test-runner /lava-10588849/1

    2023-06-05T07:52:24.189357  =


    2023-06-05T07:52:24.194358  / # /lava-10588849/bin/lava-test-runner /la=
va-10588849/1

    2023-06-05T07:52:24.206646  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/647d963f4d2fd493b3f5dec2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d963f4d2fd493b3f5decb
        failing since 123 days (last pass: v5.15.81, first fail: v5.15.91)

    2023-06-05T08:00:39.740007  + set +x
    2023-06-05T08:00:39.740186  [    9.387216] <LAVA_SIGNAL_ENDRUN 0_dmesg =
967346_1.5.2.3.1>
    2023-06-05T08:00:39.847818  / # #
    2023-06-05T08:00:39.949612  export SHELL=3D/bin/sh
    2023-06-05T08:00:39.950218  #
    2023-06-05T08:00:40.051696  / # export SHELL=3D/bin/sh. /lava-967346/en=
vironment
    2023-06-05T08:00:40.052231  =

    2023-06-05T08:00:40.153706  / # . /lava-967346/environment/lava-967346/=
bin/lava-test-runner /lava-967346/1
    2023-06-05T08:00:40.154386  =

    2023-06-05T08:00:40.156625  / # /lava-967346/bin/lava-test-runner /lava=
-967346/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647d93645e98c6065df5de3a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d93645e98c6065df5de43
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-05T07:48:32.381495  + set<8>[   11.570453] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10588715_1.4.2.3.1>

    2023-06-05T07:48:32.381976   +x

    2023-06-05T07:48:32.489606  / # #

    2023-06-05T07:48:32.592190  export SHELL=3D/bin/sh

    2023-06-05T07:48:32.593098  #

    2023-06-05T07:48:32.694568  / # export SHELL=3D/bin/sh. /lava-10588715/=
environment

    2023-06-05T07:48:32.695262  =


    2023-06-05T07:48:32.796847  / # . /lava-10588715/environment/lava-10588=
715/bin/lava-test-runner /lava-10588715/1

    2023-06-05T07:48:32.798310  =


    2023-06-05T07:48:32.802781  / # /lava-10588715/bin/lava-test-runner /la=
va-10588715/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647d9442b84ed0b798f5de37

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d9442b84ed0b798f5de40
        failing since 66 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-06-05T07:52:07.116882  + <8>[   12.176991] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10588827_1.4.2.3.1>

    2023-06-05T07:52:07.116966  set +x

    2023-06-05T07:52:07.220906  / # #

    2023-06-05T07:52:07.321501  export SHELL=3D/bin/sh

    2023-06-05T07:52:07.321683  #

    2023-06-05T07:52:07.422200  / # export SHELL=3D/bin/sh. /lava-10588827/=
environment

    2023-06-05T07:52:07.422381  =


    2023-06-05T07:52:07.522870  / # . /lava-10588827/environment/lava-10588=
827/bin/lava-test-runner /lava-10588827/1

    2023-06-05T07:52:07.523140  =


    2023-06-05T07:52:07.528359  / # /lava-10588827/bin/lava-test-runner /la=
va-10588827/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/647d9761829c956783f5de69

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647d9761829c956783f5d=
e6a
        failing since 131 days (last pass: v5.15.89, first fail: v5.15.90) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm...ok+kselftest | 4          =


  Details:     https://kernelci.org/test/plan/id/647d969a162d5d2e12f5de2e

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/647d969a162d5d2e12f5de4c
        failing since 24 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-06-05T08:02:07.129422  /lava-10588894/1/../bin/lava-test-case

    2023-06-05T08:02:07.147860  <8>[   69.791320] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/647d969a162d5d2e12f5de4c
        failing since 24 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-06-05T08:02:07.129422  /lava-10588894/1/../bin/lava-test-case

    2023-06-05T08:02:07.147860  <8>[   69.791320] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/647d969a162d5d2e12f5de4e
        failing since 24 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-06-05T08:02:06.017356  /lava-10588894/1/../bin/lava-test-case

    2023-06-05T08:02:06.035426  <8>[   68.678676] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647d969a162d5d2e12f5ded6
        failing since 24 days (last pass: v5.15.110, first fail: v5.15.111)

    2023-06-05T08:01:46.852249  + set +x<8>[   49.499656] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10588894_1.5.2.3.1>

    2023-06-05T08:01:46.855850  =


    2023-06-05T08:01:46.963383  / # #

    2023-06-05T08:01:47.063987  export SHELL=3D/bin/sh

    2023-06-05T08:01:47.064171  #

    2023-06-05T08:01:47.164705  / # export SHELL=3D/bin/sh. /lava-10588894/=
environment

    2023-06-05T08:01:47.164959  =


    2023-06-05T08:01:47.265522  / # . /lava-10588894/environment/lava-10588=
894/bin/lava-test-runner /lava-10588894/1

    2023-06-05T08:01:47.265794  =


    2023-06-05T08:01:47.271178  / # /lava-10588894/bin/lava-test-runner /la=
va-10588894/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647db64b96fbf02126f5de9c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.115/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/647db64b96fbf02126f5d=
e9d
        new failure (last pass: v5.15.114) =

 =20
