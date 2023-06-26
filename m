Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E10A73DFDD
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 14:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjFZM4K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 08:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFZM4J (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 08:56:09 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2585BD8
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 05:56:04 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-19674cab442so2766928fac.3
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687784163; x=1690376163;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qtmCVN7SV/XrN7iwJWaOJ8HNJfIFULTyHd9l/jbuGyo=;
        b=skYv0r2O4lgZ2zj+xBo6ZPVEq67BhpHhT3YqMISGAzxBYaw0k1883vIEXB6f4iqjPi
         OTOJPlRi27n/poAd85SxlGE3SSZMroKlcIeqp/yPHXd3gJjZcKsBCU1l1L3yOiY0FnBe
         kn0JVPN9yGstM+VdfIaUAF+EkKe+iPStiCJZjoaeTS4QVKFBiNPDF42ZuTCxiZ6TZdb3
         w+hGDz0AqYprgBX/E9U0JjbSquxNU6oIjuOLsP6qsP7MHX6T+i4KhU+/T98TYaQP3uU9
         2Oin7X/VWJ8QiDt+W94NlJHBx+1npU+cqTEYB5/mCUCahdBuNR6ZNsDKx5HxJbp7D0+u
         S42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687784163; x=1690376163;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qtmCVN7SV/XrN7iwJWaOJ8HNJfIFULTyHd9l/jbuGyo=;
        b=dceYMHqj2Sa2F33Wwcl98laZxcAvgLUt1lI39qgGmrXDQIL1DT8azkGxXyxYKJnraj
         S4eBUTkv5FJk7FKHwc9mtf74MO9u9nvW4Cn8RSb1x1pJK4qzPShPgqDHPaj/WUcvCaxa
         6fkxKx3kxhWDdOhSyx9SEkYzMq2WKAh07QMNlEgHJvt5VzXHBVFZYHbrOWiJQWJ2h/5l
         AcB0SfyIlFRiIb2DLq92LlA+oRSiMe1uvwlubM6XkgMbhsujRpyOkckK3v/rQ61y0wSP
         gf7GoiRgdaCDTcjFenJ1X+j3tTjMlkOPSK49VJZM3x1Ho3bUgQ9yyoIPZBTxMudg1dBL
         q6Zg==
X-Gm-Message-State: AC+VfDw1u+qflSLdvta3fIYf33dskjhEgeXwmQNBxt4jDhXHt54fko/F
        wduk3rnckbQts0XBqwa60oUzjJ9DQjtyVRrsgys=
X-Google-Smtp-Source: ACHHUZ4RGXPgulC3P3cxBi/PbJ2L4YH6fzuE7GTRgzhv05Hj6nHN58bkwO1HH0I2m1/qrwissJR+/Q==
X-Received: by 2002:a05:6870:73c1:b0:19f:6950:b191 with SMTP id a1-20020a05687073c100b0019f6950b191mr19514132oan.23.1687784162123;
        Mon, 26 Jun 2023 05:56:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p38-20020a634f66000000b005535ddd8dcfsm4068342pgl.89.2023.06.26.05.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 05:56:01 -0700 (PDT)
Message-ID: <64998ae1.630a0220.cbaa4.6824@mx.google.com>
Date:   Mon, 26 Jun 2023 05:56:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.35
Subject: stable-rc/linux-6.1.y baseline: 134 runs, 12 regressions (v6.1.35)
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

stable-rc/linux-6.1.y baseline: 134 runs, 12 regressions (v6.1.35)

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

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.35/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.35
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e84a4e368abe42cf359fe237f0238820859d5044 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649341ab6f99eb88e030615c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649341ab6f99eb88e0306165
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-26T08:58:00.712657  <8>[   10.170219] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10909660_1.4.2.3.1>

    2023-06-26T08:58:00.716299  + set +x

    2023-06-26T08:58:00.824074  / # #

    2023-06-26T08:58:00.926198  export SHELL=3D/bin/sh

    2023-06-26T08:58:00.926885  #

    2023-06-26T08:58:01.028205  / # export SHELL=3D/bin/sh. /lava-10909660/=
environment

    2023-06-26T08:58:01.029028  =


    2023-06-26T08:58:01.130531  / # . /lava-10909660/environment/lava-10909=
660/bin/lava-test-runner /lava-10909660/1

    2023-06-26T08:58:01.131701  =


    2023-06-26T08:58:01.137219  / # /lava-10909660/bin/lava-test-runner /la=
va-10909660/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649341ae0c53c664b1306131

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649341ae0c53c664b130613a
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-26T08:54:58.236883  + set<8>[   11.105164] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10909678_1.4.2.3.1>

    2023-06-26T08:54:58.237033   +x

    2023-06-26T08:54:58.341052  / # #

    2023-06-26T08:54:58.441613  export SHELL=3D/bin/sh

    2023-06-26T08:54:58.441850  #

    2023-06-26T08:54:58.542377  / # export SHELL=3D/bin/sh. /lava-10909678/=
environment

    2023-06-26T08:54:58.542556  =


    2023-06-26T08:54:58.643089  / # . /lava-10909678/environment/lava-10909=
678/bin/lava-test-runner /lava-10909678/1

    2023-06-26T08:54:58.643357  =


    2023-06-26T08:54:58.648454  / # /lava-10909678/bin/lava-test-runner /la=
va-10909678/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6493419088e255107f306156

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493419088e255107f30615f
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-26T08:52:54.202274  <8>[   10.880085] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10909649_1.4.2.3.1>

    2023-06-26T08:52:54.205776  + set +x

    2023-06-26T08:52:54.307002  #

    2023-06-26T08:52:54.307261  =


    2023-06-26T08:52:54.407856  / # #export SHELL=3D/bin/sh

    2023-06-26T08:52:54.408052  =


    2023-06-26T08:52:54.508600  / # export SHELL=3D/bin/sh. /lava-10909649/=
environment

    2023-06-26T08:52:54.508827  =


    2023-06-26T08:52:54.609352  / # . /lava-10909649/environment/lava-10909=
649/bin/lava-test-runner /lava-10909649/1

    2023-06-26T08:52:54.609637  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6493409d36c66be82b3061d1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6493409d36c66be82b306=
1d2
        failing since 13 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649341973bad37172d30613c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649341973bad37172d306145
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-26T08:57:09.044392  + set +x

    2023-06-26T08:57:09.050658  <8>[   11.193829] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10909654_1.4.2.3.1>

    2023-06-26T08:57:09.154914  / # #

    2023-06-26T08:57:09.255565  export SHELL=3D/bin/sh

    2023-06-26T08:57:09.255760  #

    2023-06-26T08:57:09.356233  / # export SHELL=3D/bin/sh. /lava-10909654/=
environment

    2023-06-26T08:57:09.356458  =


    2023-06-26T08:57:09.457028  / # . /lava-10909654/environment/lava-10909=
654/bin/lava-test-runner /lava-10909654/1

    2023-06-26T08:57:09.457351  =


    2023-06-26T08:57:09.462363  / # /lava-10909654/bin/lava-test-runner /la=
va-10909654/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6493418fe3ced3d8d23061a2

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493418fe3ced3d8d23061ab
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-26T08:55:43.769805  <8>[   10.036530] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10909657_1.4.2.3.1>

    2023-06-26T08:55:43.772952  + set +x

    2023-06-26T08:55:43.874531  #

    2023-06-26T08:55:43.874856  =


    2023-06-26T08:55:43.975493  / # #export SHELL=3D/bin/sh

    2023-06-26T08:55:43.975847  =


    2023-06-26T08:55:44.076783  / # export SHELL=3D/bin/sh. /lava-10909657/=
environment

    2023-06-26T08:55:44.076981  =


    2023-06-26T08:55:44.177555  / # . /lava-10909657/environment/lava-10909=
657/bin/lava-test-runner /lava-10909657/1

    2023-06-26T08:55:44.177862  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649341a03ce7bcbe6e306132

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649341a03ce7bcbe6e30613b
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-26T08:51:28.902010  + set<8>[    8.723961] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10909633_1.4.2.3.1>

    2023-06-26T08:51:28.902551   +x

    2023-06-26T08:51:29.011033  / # #

    2023-06-26T08:51:29.113327  export SHELL=3D/bin/sh

    2023-06-26T08:51:29.114189  #

    2023-06-26T08:51:29.215427  / # export SHELL=3D/bin/sh. /lava-10909633/=
environment

    2023-06-26T08:51:29.215626  =


    2023-06-26T08:51:29.316124  / # . /lava-10909633/environment/lava-10909=
633/bin/lava-test-runner /lava-10909633/1

    2023-06-26T08:51:29.316448  =


    2023-06-26T08:51:29.320423  / # /lava-10909633/bin/lava-test-runner /la=
va-10909633/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6dl-riotboard             | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6493406df46df3ee36306398

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6493406df46df3ee363063a1
        new failure (last pass: v6.1.35-37-g639ecee7e0d3)

    2023-06-26T08:55:30.574503  + set[   14.930645] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 988060_1.5.2.3.1>
    2023-06-26T08:55:30.574856   +x
    2023-06-26T08:55:30.681702  / # #
    2023-06-26T08:55:30.784123  export SHELL=3D/bin/sh
    2023-06-26T08:55:30.784777  #
    2023-06-26T08:55:30.886322  / # export SHELL=3D/bin/sh. /lava-988060/en=
vironment
    2023-06-26T08:55:30.887070  =

    2023-06-26T08:55:30.988673  / # . /lava-988060/environment/lava-988060/=
bin/lava-test-runner /lava-988060/1
    2023-06-26T08:55:30.989607  =

    2023-06-26T08:55:30.992426  / # /lava-988060/bin/lava-test-runner /lava=
-988060/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649341995f5c038e3a30618d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649341995f5c038e3a306196
        failing since 83 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-26T08:52:27.362437  <8>[   12.110897] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10909659_1.4.2.3.1>

    2023-06-26T08:52:27.466814  / # #

    2023-06-26T08:52:27.567559  export SHELL=3D/bin/sh

    2023-06-26T08:52:27.567804  #

    2023-06-26T08:52:27.668313  / # export SHELL=3D/bin/sh. /lava-10909659/=
environment

    2023-06-26T08:52:27.668547  =


    2023-06-26T08:52:27.769076  / # . /lava-10909659/environment/lava-10909=
659/bin/lava-test-runner /lava-10909659/1

    2023-06-26T08:52:27.769406  =


    2023-06-26T08:52:27.774783  / # /lava-10909659/bin/lava-test-runner /la=
va-10909659/1

    2023-06-26T08:52:27.781502  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64934329246ac2eec8306136

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/64934329246ac2eec8306156
        failing since 41 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-26T09:09:53.706616  /lava-10910080/1/../bin/lava-test-case

    2023-06-26T09:09:53.712773  <8>[   22.947247] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64934329246ac2eec83061e2
        failing since 41 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-06-26T09:09:48.271037  + <8>[   17.506740] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10910080_1.5.2.3.1>

    2023-06-26T09:09:48.275650  set +x

    2023-06-26T09:09:48.382652  / # #

    2023-06-26T09:09:48.484797  export SHELL=3D/bin/sh

    2023-06-26T09:09:48.485462  #

    2023-06-26T09:09:48.586975  / # export SHELL=3D/bin/sh. /lava-10910080/=
environment

    2023-06-26T09:09:48.587804  =


    2023-06-26T09:09:48.689293  / # . /lava-10910080/environment/lava-10910=
080/bin/lava-test-runner /lava-10910080/1

    2023-06-26T09:09:48.690550  =


    2023-06-26T09:09:48.695766  / # /lava-10910080/bin/lava-test-runner /la=
va-10910080/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
qemu_mips-malta              | mips   | lab-collabora   | gcc-10   | malta_=
defconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/64934048fa86017c6e306136

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.35/=
mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64934048fa86017c6e306=
137
        failing since 2 days (last pass: v6.1.34-90-g7a9de0e648cfb, first f=
ail: v6.1.34-163-gfbff2eddae9a) =

 =20
