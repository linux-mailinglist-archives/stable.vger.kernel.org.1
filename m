Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37D4735B15
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 17:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjFSPZF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 11:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjFSPYx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 11:24:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDAAF9
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 08:24:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b54f5aac48so10132845ad.2
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 08:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687188289; x=1689780289;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ObKkthxjdGr64SfVFRbfpptIx9bxGJtUTKNksoMdrwM=;
        b=HCTuNw4e0l+UOseNvgLRS+daf78ghXCYntusi3pWNApwpEb2VL+IE+kIfvfSAZ0Jge
         +gtAmr+QChOxlLjk8vrbarunxj0B3ab1qZlxpjrT3r+Qpn405q3x2OG8fgVQszIbssN6
         SHz/syQqAwhFERV9cdUYM7Ff0xe7cfxu0MPKHibALyFXhnRFo3GBi33a3jrX+KPtKcKp
         aET8y7/QJQw2kl4zTPDGgdQzrey8BMx0vbMfFDNENBBXfk2PZO0WnNSqRqYgGtV5rLh1
         LgtLi4+VafuzBLkoLtMsjXdCkxWHqfMHAI9O8lJBmQDqApeaJBCwByJpu2lcmEM8q5YH
         wyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687188289; x=1689780289;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObKkthxjdGr64SfVFRbfpptIx9bxGJtUTKNksoMdrwM=;
        b=SWdDXQugIY6gwL50SwXy0mBhirdoOu6TIJvvkQb8F3iwxymX1Et+zdDQOhuVvflDI7
         Asrq0vepgVLORmefzPDaN4//q4ii5VteRuzAr5bjMTDdDwiF1AvYGlf9YhKYtkYmVam1
         rHGmgdKxHL6xhQVFmD9+Njql1uMfAt+DTKekD94TeizVAONIHXkce93280OnRWk4TPWg
         qhdJWsApQwQ2X647WKOMPCuwa1aOJWeloOg5AZHnBeDqnZCRibb8Uh9VfTiobzKYmPDe
         hYMA5eli+lkjQS9zlV0ZAODznHiji2hXQBKqHG+SUc1YJIsKEWvh+WQmA1wGFPtvC9Fp
         J4xg==
X-Gm-Message-State: AC+VfDzTJ/Qs5xrt0Wp7gTRE0PL/y+FF24xl9gZy2Cks3oYY6yM+ABD0
        Uo+WW1e60PbN6UZuHCQP2VGd/5qZBfnvW1fEPQmd/37E
X-Google-Smtp-Source: ACHHUZ5rfsVKethY3PkQCxxLjycfO2wUPC3CjNTUB19Q3NSkkMQPUEWDCsK0misquWFXgknRMAQKeQ==
X-Received: by 2002:a17:902:da91:b0:1ae:6cf0:94eb with SMTP id j17-20020a170902da9100b001ae6cf094ebmr9818722plx.5.1687188289341;
        Mon, 19 Jun 2023 08:24:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902ed5400b001b03842ab78sm6559plb.89.2023.06.19.08.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:24:48 -0700 (PDT)
Message-ID: <64907340.170a0220.c8fbc.004d@mx.google.com>
Date:   Mon, 19 Jun 2023 08:24:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.34-167-g1781b36a0958
Subject: stable-rc/linux-6.1.y baseline: 171 runs,
 11 regressions (v6.1.34-167-g1781b36a0958)
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

stable-rc/linux-6.1.y baseline: 171 runs, 11 regressions (v6.1.34-167-g1781=
b36a0958)

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
g+arm64-chromebook   | 2          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.34-167-g1781b36a0958/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.34-167-g1781b36a0958
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      1781b36a0958c09ec269d0591f929be0590eeb96 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64903be47cf759dbdb306211

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64903be47cf759dbdb306216
        failing since 80 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-19T11:28:32.053028  + set +x

    2023-06-19T11:28:32.059615  <8>[    7.949389] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10813016_1.4.2.3.1>

    2023-06-19T11:28:32.161794  #

    2023-06-19T11:28:32.162089  =


    2023-06-19T11:28:32.262667  / # #export SHELL=3D/bin/sh

    2023-06-19T11:28:32.262854  =


    2023-06-19T11:28:32.363322  / # export SHELL=3D/bin/sh. /lava-10813016/=
environment

    2023-06-19T11:28:32.363537  =


    2023-06-19T11:28:32.464075  / # . /lava-10813016/environment/lava-10813=
016/bin/lava-test-runner /lava-10813016/1

    2023-06-19T11:28:32.464341  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64903be65cd8fd26d630619d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64903be65cd8fd26d63061a2
        failing since 80 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-19T11:28:17.617922  + <8>[   11.082133] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10813021_1.4.2.3.1>

    2023-06-19T11:28:17.618008  set +x

    2023-06-19T11:28:17.722179  / # #

    2023-06-19T11:28:17.822723  export SHELL=3D/bin/sh

    2023-06-19T11:28:17.822902  #

    2023-06-19T11:28:17.923459  / # export SHELL=3D/bin/sh. /lava-10813021/=
environment

    2023-06-19T11:28:17.923639  =


    2023-06-19T11:28:18.024205  / # . /lava-10813021/environment/lava-10813=
021/bin/lava-test-runner /lava-10813021/1

    2023-06-19T11:28:18.024538  =


    2023-06-19T11:28:18.029818  / # /lava-10813021/bin/lava-test-runner /la=
va-10813021/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64903be5580abec62e306169

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64903be5580abec62e30616e
        failing since 80 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-19T11:28:29.832152  <8>[    8.593109] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10813027_1.4.2.3.1>

    2023-06-19T11:28:29.835560  + set +x

    2023-06-19T11:28:29.937121  #

    2023-06-19T11:28:29.937434  =


    2023-06-19T11:28:30.038054  / # #export SHELL=3D/bin/sh

    2023-06-19T11:28:30.038244  =


    2023-06-19T11:28:30.138759  / # export SHELL=3D/bin/sh. /lava-10813027/=
environment

    2023-06-19T11:28:30.138963  =


    2023-06-19T11:28:30.239534  / # . /lava-10813027/environment/lava-10813=
027/bin/lava-test-runner /lava-10813027/1

    2023-06-19T11:28:30.239832  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64903fb2fabf41e355306156

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64903fb2fabf41e355306=
157
        failing since 11 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64903beebe52ab2c8c306158

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64903beebe52ab2c8c30615d
        failing since 80 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-19T11:28:35.428143  + set +x

    2023-06-19T11:28:35.434470  <8>[   12.623710] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10813051_1.4.2.3.1>

    2023-06-19T11:28:35.539444  / # #

    2023-06-19T11:28:35.640070  export SHELL=3D/bin/sh

    2023-06-19T11:28:35.640245  #

    2023-06-19T11:28:35.740834  / # export SHELL=3D/bin/sh. /lava-10813051/=
environment

    2023-06-19T11:28:35.741008  =


    2023-06-19T11:28:35.841514  / # . /lava-10813051/environment/lava-10813=
051/bin/lava-test-runner /lava-10813051/1

    2023-06-19T11:28:35.841812  =


    2023-06-19T11:28:35.846873  / # /lava-10813051/bin/lava-test-runner /la=
va-10813051/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64903bebe6b38cebf130612e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64903bebe6b38cebf1306133
        failing since 80 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-19T11:28:34.410548  + set<8>[   10.619968] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10813045_1.4.2.3.1>

    2023-06-19T11:28:34.410988   +x

    2023-06-19T11:28:34.515944  / #

    2023-06-19T11:28:34.618670  # #export SHELL=3D/bin/sh

    2023-06-19T11:28:34.619407  =


    2023-06-19T11:28:34.720659  / # export SHELL=3D/bin/sh. /lava-10813045/=
environment

    2023-06-19T11:28:34.720973  =


    2023-06-19T11:28:34.821721  / # . /lava-10813045/environment/lava-10813=
045/bin/lava-test-runner /lava-10813045/1

    2023-06-19T11:28:34.822134  =


    2023-06-19T11:28:34.827081  / # /lava-10813045/bin/lava-test-runner /la=
va-10813045/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64903be9718ca215d2306183

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64903be9718ca215d2306188
        failing since 80 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-19T11:28:31.583081  + <8>[   10.947409] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10813047_1.4.2.3.1>

    2023-06-19T11:28:31.583577  set +x

    2023-06-19T11:28:31.692093  / # #

    2023-06-19T11:28:31.795024  export SHELL=3D/bin/sh

    2023-06-19T11:28:31.795799  #

    2023-06-19T11:28:31.897531  / # export SHELL=3D/bin/sh. /lava-10813047/=
environment

    2023-06-19T11:28:31.898283  =


    2023-06-19T11:28:31.999790  / # . /lava-10813047/environment/lava-10813=
047/bin/lava-test-runner /lava-10813047/1

    2023-06-19T11:28:32.001205  =


    2023-06-19T11:28:32.005862  / # /lava-10813047/bin/lava-test-runner /la=
va-10813047/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64903bfe387e4768ef30615f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64903bfe387e4768ef306164
        failing since 80 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-19T11:28:47.827591  <8>[   11.483347] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10813039_1.4.2.3.1>

    2023-06-19T11:28:47.935726  / # #

    2023-06-19T11:28:48.038341  export SHELL=3D/bin/sh

    2023-06-19T11:28:48.039134  #

    2023-06-19T11:28:48.140664  / # export SHELL=3D/bin/sh. /lava-10813039/=
environment

    2023-06-19T11:28:48.141486  =


    2023-06-19T11:28:48.243061  / # . /lava-10813039/environment/lava-10813=
039/bin/lava-test-runner /lava-10813039/1

    2023-06-19T11:28:48.244353  =


    2023-06-19T11:28:48.249512  / # /lava-10813039/bin/lava-test-runner /la=
va-10813039/1

    2023-06-19T11:28:48.255805  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64903f27ec7ea3d85d3061f1

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/64903f27ec7ea3d85d30620d
        failing since 38 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-19T11:42:22.389679  /lava-10813277/1/../bin/lava-test-case
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64903f27ec7ea3d85d306299
        failing since 38 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-19T11:42:16.982308  + set +x

    2023-06-19T11:42:16.988723  <8>[   17.526227] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10813277_1.5.2.3.1>

    2023-06-19T11:42:17.096828  / # #

    2023-06-19T11:42:17.199393  export SHELL=3D/bin/sh

    2023-06-19T11:42:17.200426  #

    2023-06-19T11:42:17.301949  / # export SHELL=3D/bin/sh. /lava-10813277/=
environment

    2023-06-19T11:42:17.302798  =


    2023-06-19T11:42:17.404575  / # . /lava-10813277/environment/lava-10813=
277/bin/lava-test-runner /lava-10813277/1

    2023-06-19T11:42:17.405778  =


    2023-06-19T11:42:17.411064  / # /lava-10813277/bin/lava-test-runner /la=
va-10813277/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64903d5ac4747e308a30612f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.34-=
167-g1781b36a0958/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_m=
ips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64903d5ac4747e308a306=
130
        failing since 0 day (last pass: v6.1.34-90-g7a9de0e648cfb, first fa=
il: v6.1.34-163-gfbff2eddae9a) =

 =20
