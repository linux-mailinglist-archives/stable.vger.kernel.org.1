Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779F673DEB2
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 14:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjFZMPt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 08:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjFZMPJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 08:15:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC76C170D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 05:14:10 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b7fb02edfaso10629805ad.3
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 05:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687781649; x=1690373649;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qmkXeqX7iyXk1cttJs3irnUfdZ/L21MgDj3FKui0M6c=;
        b=bJvUuQ7lCNvevuZAiMyEcYXsOVe+fXjYpBbl5H/0/TcXMx3iAPJeQC8jl6n5JU6+/6
         6+RKYD/nYuibQyrwIJzaq2TDbw8C0uoW4dxDuH6k39Vztul6b0nYC3hRkwwtIvRphLLS
         DWd/3mP+PQFQDJVnZuQOBRXQlKIQQdKyCAnv9kPnSI2HAnhTyhRlknfxcXoK1JePNyr8
         5eZZHd0mP63oiijYvDSSgXvLiqQavwRQ3bg+mWGiXSvtJtFKlWmtxaG9MmYOFW1+a73j
         aEtpzvWhdoh6BEyKLA4SLWwzLT9Pjcq1k5tvf/KDQHKZ/CS91LB9BkT8sb0wD7Ymifa+
         f2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687781649; x=1690373649;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmkXeqX7iyXk1cttJs3irnUfdZ/L21MgDj3FKui0M6c=;
        b=BJBgSAL3/6APO1sTj3Jif38ifUxzJrH3MNoxe4ybjFxtS2i+A5emHSe6EvuFNknNWU
         LNHVDiDDHMTSo4OJueLZGfG8MPdj/mPGwSHbnqgEnjwEpIMfYIP7uzo4HJ5zpr9vdQFh
         aFUPNZY0r4WF4xTVBNaLHI3kXNvf8x8q3DCzhWonpi04IhbVMn5dyu/txErD1eCvg6uP
         BxXKD5eprpNP4ZGaQgyJc9r92fgkgvjecAwTyKC2OR5wUwFMlbRx0FBiwO5MI/bYFq+k
         gAxyeKBGTJBMMjo1Ouwdapfc/PzvKN9eX16gbpT82Lm7AmhrmcY9/B5d8qrOdbCUSJ5C
         iPwg==
X-Gm-Message-State: AC+VfDzeSitrj1y0NZQu0ixLRHElqhkgVy79pWdREe50XDbCu9K0FXcx
        To+M3DMt/vNqIsOn4YZET8KmOl03nW49GrY7qf8=
X-Google-Smtp-Source: ACHHUZ5yv3KPWROP8KZVHss0cB6vyHaRpAIQjLsTtEmN5YHKmxulYsVdRuG/OuSam0foKcVRVMzWHw==
X-Received: by 2002:a17:902:e883:b0:1b5:5fd2:4d6e with SMTP id w3-20020a170902e88300b001b55fd24d6emr8368364plg.58.1687781649178;
        Mon, 26 Jun 2023 05:14:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g7-20020a170902934700b001b3bf8001a9sm4099485plp.48.2023.06.26.05.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 05:14:08 -0700 (PDT)
Message-ID: <64998110.170a0220.dd51a.69b1@mx.google.com>
Date:   Mon, 26 Jun 2023 05:14:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.118
Subject: stable-rc/linux-5.15.y baseline: 147 runs, 15 regressions (v5.15.118)
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

stable-rc/linux-5.15.y baseline: 147 runs, 15 regressions (v5.15.118)

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

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =

rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.118/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.118
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f67653019430833d5003f16817d7fa85272a6a76 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64994cf8f49b688a8f306163

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64994cf8f49b688a8f30616c
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-26T08:31:31.751371  + set +x

    2023-06-26T08:31:31.757988  <8>[   14.593377] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10909055_1.4.2.3.1>

    2023-06-26T08:31:31.866306  #

    2023-06-26T08:31:31.867581  =


    2023-06-26T08:31:31.969405  / # #export SHELL=3D/bin/sh

    2023-06-26T08:31:31.970101  =


    2023-06-26T08:31:32.071448  / # export SHELL=3D/bin/sh. /lava-10909055/=
environment

    2023-06-26T08:31:32.072183  =


    2023-06-26T08:31:32.173576  / # . /lava-10909055/environment/lava-10909=
055/bin/lava-test-runner /lava-10909055/1

    2023-06-26T08:31:32.174696  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64994cce25db662adc30612e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64994cce25db662adc306137
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-26T08:30:53.129424  + set<8>[   11.850585] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10909016_1.4.2.3.1>

    2023-06-26T08:30:53.129960   +x

    2023-06-26T08:30:53.237247  / # #

    2023-06-26T08:30:53.339359  export SHELL=3D/bin/sh

    2023-06-26T08:30:53.340065  #

    2023-06-26T08:30:53.441444  / # export SHELL=3D/bin/sh. /lava-10909016/=
environment

    2023-06-26T08:30:53.442203  =


    2023-06-26T08:30:53.543726  / # . /lava-10909016/environment/lava-10909=
016/bin/lava-test-runner /lava-10909016/1

    2023-06-26T08:30:53.545121  =


    2023-06-26T08:30:53.549887  / # /lava-10909016/bin/lava-test-runner /la=
va-10909016/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64994ce1c3f580178f30617c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asu=
s-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64994ce1c3f580178f306185
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-26T08:31:23.218891  <8>[   11.228080] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10909095_1.4.2.3.1>

    2023-06-26T08:31:23.222319  + set +x

    2023-06-26T08:31:23.328468  =


    2023-06-26T08:31:23.430074  / # #export SHELL=3D/bin/sh

    2023-06-26T08:31:23.430312  =


    2023-06-26T08:31:23.530904  / # export SHELL=3D/bin/sh. /lava-10909095/=
environment

    2023-06-26T08:31:23.531118  =


    2023-06-26T08:31:23.631699  / # . /lava-10909095/environment/lava-10909=
095/bin/lava-test-runner /lava-10909095/1

    2023-06-26T08:31:23.631976  =


    2023-06-26T08:31:23.637267  / # /lava-10909095/bin/lava-test-runner /la=
va-10909095/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64994ce536755c2fe6306139

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64994ce536755c2fe6306142
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-26T08:31:20.002868  + set +x

    2023-06-26T08:31:20.009716  <8>[   10.937754] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10909053_1.4.2.3.1>

    2023-06-26T08:31:20.117087  / # #

    2023-06-26T08:31:20.219114  export SHELL=3D/bin/sh

    2023-06-26T08:31:20.219834  #

    2023-06-26T08:31:20.321223  / # export SHELL=3D/bin/sh. /lava-10909053/=
environment

    2023-06-26T08:31:20.321917  =


    2023-06-26T08:31:20.423292  / # . /lava-10909053/environment/lava-10909=
053/bin/lava-test-runner /lava-10909053/1

    2023-06-26T08:31:20.424391  =


    2023-06-26T08:31:20.428597  / # /lava-10909053/bin/lava-test-runner /la=
va-10909053/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64994ccdc2a9f382383061af

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64994ccdc2a9f382383061b8
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-26T08:31:08.314524  + set +x<8>[   13.874334] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10909075_1.4.2.3.1>

    2023-06-26T08:31:08.314618  =


    2023-06-26T08:31:08.416236  #

    2023-06-26T08:31:08.517076  / # #export SHELL=3D/bin/sh

    2023-06-26T08:31:08.517259  =


    2023-06-26T08:31:08.617802  / # export SHELL=3D/bin/sh. /lava-10909075/=
environment

    2023-06-26T08:31:08.618040  =


    2023-06-26T08:31:08.718554  / # . /lava-10909075/environment/lava-10909=
075/bin/lava-test-runner /lava-10909075/1

    2023-06-26T08:31:08.718920  =


    2023-06-26T08:31:08.723972  / # /lava-10909075/bin/lava-test-runner /la=
va-10909075/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64994cba5cf162b99230612e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64994cba5cf162b992306137
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-26T08:30:27.420524  + set<8>[   10.814873] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10909014_1.4.2.3.1>

    2023-06-26T08:30:27.420639   +x

    2023-06-26T08:30:27.524786  / # #

    2023-06-26T08:30:27.625364  export SHELL=3D/bin/sh

    2023-06-26T08:30:27.625569  #

    2023-06-26T08:30:27.726062  / # export SHELL=3D/bin/sh. /lava-10909014/=
environment

    2023-06-26T08:30:27.726256  =


    2023-06-26T08:30:27.826810  / # . /lava-10909014/environment/lava-10909=
014/bin/lava-test-runner /lava-10909014/1

    2023-06-26T08:30:27.827160  =


    2023-06-26T08:30:27.831879  / # /lava-10909014/bin/lava-test-runner /la=
va-10909014/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx53-qsrb                   | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64994d6f3f27d8111e306130

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64994d6f3f27d8111e306139
        failing since 146 days (last pass: v5.15.81-122-gc5f8d4a5d3c8, firs=
t fail: v5.15.90-205-g5605d15db022)

    2023-06-26T08:33:42.392108  + set +x
    2023-06-26T08:33:42.392316  [    9.450150] <LAVA_SIGNAL_ENDRUN 0_dmesg =
988038_1.5.2.3.1>
    2023-06-26T08:33:42.499430  / # #
    2023-06-26T08:33:42.601097  export SHELL=3D/bin/sh
    2023-06-26T08:33:42.601559  #
    2023-06-26T08:33:42.702816  / # export SHELL=3D/bin/sh. /lava-988038/en=
vironment
    2023-06-26T08:33:42.703296  =

    2023-06-26T08:33:42.804578  / # . /lava-988038/environment/lava-988038/=
bin/lava-test-runner /lava-988038/1
    2023-06-26T08:33:42.805245  =

    2023-06-26T08:33:42.807753  / # /lava-988038/bin/lava-test-runner /lava=
-988038/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64994cbc5cf162b992306139

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-len=
ovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64994cbc5cf162b992306142
        failing since 89 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-06-26T08:30:37.444173  <8>[   11.187399] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10909078_1.4.2.3.1>

    2023-06-26T08:30:37.548753  / # #

    2023-06-26T08:30:37.649385  export SHELL=3D/bin/sh

    2023-06-26T08:30:37.649634  #

    2023-06-26T08:30:37.750197  / # export SHELL=3D/bin/sh. /lava-10909078/=
environment

    2023-06-26T08:30:37.750457  =


    2023-06-26T08:30:37.851057  / # . /lava-10909078/environment/lava-10909=
078/bin/lava-test-runner /lava-10909078/1

    2023-06-26T08:30:37.851376  =


    2023-06-26T08:30:37.855612  / # /lava-10909078/bin/lava-test-runner /la=
va-10909078/1

    2023-06-26T08:30:37.861080  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 4          =


  Details:     https://kernelci.org/test/plan/id/64994c19dd86ac7048306132

  Results:     153 PASS, 14 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-ku=
kui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-ku=
kui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/64994c19dd86ac7048306150
        failing since 42 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-26T08:27:57.559340  /lava-10908958/1/../bin/lava-test-case

    2023-06-26T08:27:57.565492  <8>[   61.556746] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.generic-adc-thermal-probed: https://kernelci.org/test/c=
ase/id/64994c19dd86ac7048306150
        failing since 42 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-26T08:27:57.559340  /lava-10908958/1/../bin/lava-test-case

    2023-06-26T08:27:57.565492  <8>[   61.556746] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dgeneric-adc-thermal-probed RESULT=3Dfail>
   =


  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/64994c19dd86ac7048306152
        failing since 42 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-26T08:27:56.519017  /lava-10908958/1/../bin/lava-test-case

    2023-06-26T08:27:56.525819  <8>[   60.516675] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64994c19dd86ac70483061da
        failing since 42 days (last pass: v5.15.110, first fail: v5.15.111-=
130-g93ae50a86a5dd)

    2023-06-26T08:27:42.358366  + <8>[   46.352643] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10908958_1.5.2.3.1>

    2023-06-26T08:27:42.363263  set +x

    2023-06-26T08:27:42.468378  / #

    2023-06-26T08:27:42.571335  # #export SHELL=3D/bin/sh

    2023-06-26T08:27:42.572162  =


    2023-06-26T08:27:42.673896  / # export SHELL=3D/bin/sh. /lava-10908958/=
environment

    2023-06-26T08:27:42.674729  =


    2023-06-26T08:27:42.776400  / # . /lava-10908958/environment/lava-10908=
958/bin/lava-test-runner /lava-10908958/1

    2023-06-26T08:27:42.777923  =


    2023-06-26T08:27:42.782944  / # /lava-10908958/bin/lava-test-runner /la=
va-10908958/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6499502d6fd04b8bd630613d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6499502d6fd04b8bd6306146
        failing since 18 days (last pass: v5.15.72-38-gebe70cd7f5413, first=
 fail: v5.15.114-196-g00621f2608ac)

    2023-06-26T08:45:16.254373  [   16.039552] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3693249_1.5.2.4.1>
    2023-06-26T08:45:16.359312  =

    2023-06-26T08:45:16.359658  / # [   16.061604] rockchip-drm display-sub=
system: [drm] Cannot find any crtc or sizes
    2023-06-26T08:45:16.461596  #export SHELL=3D/bin/sh
    2023-06-26T08:45:16.462063  =

    2023-06-26T08:45:16.563493  / # export SHELL=3D/bin/sh. /lava-3693249/e=
nvironment
    2023-06-26T08:45:16.563934  =

    2023-06-26T08:45:16.665330  / # . /lava-3693249/environment/lava-369324=
9/bin/lava-test-runner /lava-3693249/1
    2023-06-26T08:45:16.665976  =

    2023-06-26T08:45:16.669396  / # /lava-3693249/bin/lava-test-runner /lav=
a-3693249/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64995224933a5ee70230619a

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64995225933a5ee7023061c9
        failing since 159 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-26T08:53:35.794768  + set +x
    2023-06-26T08:53:35.798911  <8>[   16.060138] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3693245_1.5.2.4.1>
    2023-06-26T08:53:35.919957  / # #
    2023-06-26T08:53:36.026013  export SHELL=3D/bin/sh
    2023-06-26T08:53:36.027562  #
    2023-06-26T08:53:36.130993  / # export SHELL=3D/bin/sh. /lava-3693245/e=
nvironment
    2023-06-26T08:53:36.132579  =

    2023-06-26T08:53:36.235978  / # . /lava-3693245/environment/lava-369324=
5/bin/lava-test-runner /lava-3693245/1
    2023-06-26T08:53:36.238726  =

    2023-06-26T08:53:36.241757  / # /lava-3693245/bin/lava-test-runner /lav=
a-3693245/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6499522f3b1029a3e630612e

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
18/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6499522f3b1029a3e630615e
        failing since 159 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-06-26T08:53:55.838122  + set +x
    2023-06-26T08:53:55.842335  <8>[   16.058618] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 666406_1.5.2.4.1>
    2023-06-26T08:53:55.954857  / # #
    2023-06-26T08:53:56.058426  export SHELL=3D/bin/sh
    2023-06-26T08:53:56.058954  #
    2023-06-26T08:53:56.160662  / # export SHELL=3D/bin/sh. /lava-666406/en=
vironment
    2023-06-26T08:53:56.161240  =

    2023-06-26T08:53:56.263281  / # . /lava-666406/environment/lava-666406/=
bin/lava-test-runner /lava-666406/1
    2023-06-26T08:53:56.264229  =

    2023-06-26T08:53:56.268109  / # /lava-666406/bin/lava-test-runner /lava=
-666406/1 =

    ... (12 line(s) more)  =

 =20
