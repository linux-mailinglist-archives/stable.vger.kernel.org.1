Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CB178397E
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 07:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjHVFuO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 01:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjHVFuN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 01:50:13 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11841133
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 22:50:11 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a40d8557eso1332144b3a.1
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 22:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692683410; x=1693288210;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+UNx1PeSdMDFNmnkbuCI8hRY+J6VokQj5ehHLimVckc=;
        b=bkOCQKAWxGLR1b+PeTdJ7fhaX8AiImOVry7qjoKa+f/5WoqpQo8b2yXQGvD50Npc08
         Onm0wcs8xjrWFVrSzh83bkIsO6bK6+sCSRQWaYTv+X+wBdhEGqbSuJ5kjRskuQjB9W6v
         4hXn4NMuKBjSDwXzyLFFeAjUAX4VEHC+zkuaGuUVSQWF/lNewt/YG7IRGReB+nMyBUuj
         7VG2L6JT2ANg+CVZmgIouBAmgfcoWaden8xTRmpBhshfg3XuuU+lGIGNJuq5CCg4mq3z
         cgv4cbQ//wRpmjer5Tp8arWhzvQzSX0xMeO7gKHZbf4bb+Uz+oGuZVEefi7y/etIZAQ7
         OOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692683410; x=1693288210;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UNx1PeSdMDFNmnkbuCI8hRY+J6VokQj5ehHLimVckc=;
        b=PfVPB9dcmo4/3uRXtfzRG+Nbh1pSqITA/R6TrLyZDikzfg97ytRWvKlWSQhEtotRXA
         yoN9IwiX2i7OBRLZHBDwWmVw0qgoa+rKQGeQgv0sW0FWCsY1YQzraVUjTwOHkTdkD3/X
         svqRRTgVCIuBg/sTnuniZFCp5Wiy6Zu0S1leaKyDlgvsjPtcg0O3ktVg8/iXDhLClDt5
         22atMfkxpKwj6GryOXYLfVSDQuOiK4X28wqKRDq1Sqo0z+xYNciuBcy5RSrHrfT3tq87
         8U2RthvZoxrlB+MEDnVyNoiMeiriZ4VBWu46fP1ocWa8pXizjpqrp3TXQSEdcXergz1x
         +T6Q==
X-Gm-Message-State: AOJu0Yzjiee80Q1pXir7tIggoucjgcPLlnJpDVKYROL5Z2lu2OBpFmp2
        c/9ZaOPXtWTgzIug1YILNusIZ1SFLH9wQptORQXaRQ==
X-Google-Smtp-Source: AGHT+IG2zx5reQyvlRsoVoGhpMS9sWNz7geR5hRXKcoz/Yjbwra2G7FAal7C1BHj/MFU2aau+iLIQg==
X-Received: by 2002:a05:6a00:a1f:b0:68a:6149:71cb with SMTP id p31-20020a056a000a1f00b0068a614971cbmr4048967pfh.5.1692683410031;
        Mon, 21 Aug 2023 22:50:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a2-20020aa780c2000000b00688214cff65sm7034358pfn.44.2023.08.21.22.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 22:50:09 -0700 (PDT)
Message-ID: <64e44c91.a70a0220.767da.cece@mx.google.com>
Date:   Mon, 21 Aug 2023 22:50:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.127-138-gfc9952e796d10
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.15.y baseline: 89 runs,
 6 regressions (v5.15.127-138-gfc9952e796d10)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 89 runs, 6 regressions (v5.15.127-138-gfc9=
952e796d10)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =

cubietruck         | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig =
 | 1          =

fsl-ls2088a-rdb    | arm64 | lab-nxp       | gcc-10   | defconfig          =
 | 1          =

fsl-lx2160a-rdb    | arm64 | lab-nxp       | gcc-10   | defconfig          =
 | 1          =

r8a779m1-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.127-138-gfc9952e796d10/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.127-138-gfc9952e796d10
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      fc9952e796d10f995ee74ab63b7f990fec0d8eca =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64e41bde11327b4ee8dc95d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27-138-gfc9952e796d10/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-=
beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27-138-gfc9952e796d10/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-=
beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64e41bde11327b4ee8dc9=
5da
        failing since 27 days (last pass: v5.15.120, first fail: v5.15.122-=
79-g3bef1500d246a) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
cubietruck         | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64e41bb9c6e59a1b43dc95cd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27-138-gfc9952e796d10/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27-138-gfc9952e796d10/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-c=
ubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e41bb9c6e59a1b43dc95d2
        failing since 216 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-08-22T02:21:30.645367  + set +x<8>[    9.957520] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3744863_1.5.2.4.1>
    2023-08-22T02:21:30.645583  =

    2023-08-22T02:21:30.751977  / # #
    2023-08-22T02:21:30.853514  export SHELL=3D/bin/sh
    2023-08-22T02:21:30.854383  #
    2023-08-22T02:21:30.956422  / # export SHELL=3D/bin/sh. /lava-3744863/e=
nvironment
    2023-08-22T02:21:30.957281  =

    2023-08-22T02:21:31.059104  / # . /lava-3744863/environment/lava-374486=
3/bin/lava-test-runner /lava-3744863/1
    2023-08-22T02:21:31.059721  =

    2023-08-22T02:21:31.064685  / # /lava-3744863/bin/lava-test-runner /lav=
a-3744863/1 =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
fsl-ls2088a-rdb    | arm64 | lab-nxp       | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64e41bb5a9a9efb028dc95f2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27-138-gfc9952e796d10/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27-138-gfc9952e796d10/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e41bb5a9a9efb028dc95f5
        failing since 38 days (last pass: v5.15.67, first fail: v5.15.119-1=
6-g66130849c020f)

    2023-08-22T02:21:20.782475  + [   15.400373] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1244649_1.5.2.4.1>
    2023-08-22T02:21:20.782744  set +x
    2023-08-22T02:21:20.887659  =

    2023-08-22T02:21:20.988459  / # #export SHELL=3D/bin/sh
    2023-08-22T02:21:20.988869  =

    2023-08-22T02:21:21.089817  / # export SHELL=3D/bin/sh. /lava-1244649/e=
nvironment
    2023-08-22T02:21:21.090220  =

    2023-08-22T02:21:21.191197  / # . /lava-1244649/environment/lava-124464=
9/bin/lava-test-runner /lava-1244649/1
    2023-08-22T02:21:21.191866  =

    2023-08-22T02:21:21.195911  / # /lava-1244649/bin/lava-test-runner /lav=
a-1244649/1 =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
fsl-lx2160a-rdb    | arm64 | lab-nxp       | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64e41ba1a9a9efb028dc95e0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27-138-gfc9952e796d10/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27-138-gfc9952e796d10/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-r=
db.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e41ba1a9a9efb028dc95e3
        failing since 171 days (last pass: v5.15.79, first fail: v5.15.98)

    2023-08-22T02:21:09.138502  [   11.258348] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1244648_1.5.2.4.1>
    2023-08-22T02:21:09.241365  =

    2023-08-22T02:21:09.342098  / # #export SHELL=3D/bin/sh
    2023-08-22T02:21:09.342391  =

    2023-08-22T02:21:09.443017  / # export SHELL=3D/bin/sh. /lava-1244648/e=
nvironment
    2023-08-22T02:21:09.443301  =

    2023-08-22T02:21:09.543921  / # . /lava-1244648/environment/lava-124464=
8/bin/lava-test-runner /lava-1244648/1
    2023-08-22T02:21:09.544336  =

    2023-08-22T02:21:09.548298  / # /lava-1244648/bin/lava-test-runner /lav=
a-1244648/1
    2023-08-22T02:21:09.564255  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
r8a779m1-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64e41b6ab24aee9981dc965b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27-138-gfc9952e796d10/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m=
1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27-138-gfc9952e796d10/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m=
1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e41b6ab24aee9981dc9660
        failing since 33 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-22T02:20:08.510546  / # #

    2023-08-22T02:20:09.590267  export SHELL=3D/bin/sh

    2023-08-22T02:20:09.592181  #

    2023-08-22T02:20:11.082124  / # export SHELL=3D/bin/sh. /lava-11328309/=
environment

    2023-08-22T02:20:11.084061  =


    2023-08-22T02:20:13.806740  / # . /lava-11328309/environment/lava-11328=
309/bin/lava-test-runner /lava-11328309/1

    2023-08-22T02:20:13.808872  =


    2023-08-22T02:20:13.820057  / # /lava-11328309/bin/lava-test-runner /la=
va-11328309/1

    2023-08-22T02:20:13.879344  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-22T02:20:13.879776  + cd /lava-113283<8>[   25.499670] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11328309_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/64e41b3930c259c86fdc95f6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27-138-gfc9952e796d10/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
27-138-gfc9952e796d10/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e41b3930c259c86fdc95fb
        failing since 33 days (last pass: v5.15.120-274-g478387c57e172, fir=
st fail: v5.15.120)

    2023-08-22T02:21:02.335152  / # #

    2023-08-22T02:21:02.437293  export SHELL=3D/bin/sh

    2023-08-22T02:21:02.438041  #

    2023-08-22T02:21:02.539439  / # export SHELL=3D/bin/sh. /lava-11328319/=
environment

    2023-08-22T02:21:02.540182  =


    2023-08-22T02:21:02.641756  / # . /lava-11328319/environment/lava-11328=
319/bin/lava-test-runner /lava-11328319/1

    2023-08-22T02:21:02.642917  =


    2023-08-22T02:21:02.644209  / # /lava-11328319/bin/lava-test-runner /la=
va-11328319/1

    2023-08-22T02:21:02.685506  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-22T02:21:02.718074  + cd /lava-1132831<8>[   16.747241] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11328319_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
