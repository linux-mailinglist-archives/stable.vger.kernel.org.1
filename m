Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5007AC2D1
	for <lists+stable@lfdr.de>; Sat, 23 Sep 2023 16:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjIWOoS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 23 Sep 2023 10:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjIWOoS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 23 Sep 2023 10:44:18 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC45D192
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 07:44:10 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3ae0b0e9a68so2084079b6e.0
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695480249; x=1696085049; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wEI/1t3uJXzPJgmk3aNvlJpT+FiDiUf2BknRFZB/E1M=;
        b=sqzkjZLoIwWIf51yWH4JyAAOGsI4X2atJJelxcGsKhGzjrjIo3TrvtYsd1OFbNORa0
         st+n+499RD2qM7pSVxB0e+UPQENRQbJWnMSg/jvqU0Ckmk3bZG5I16YdBOIUwH8SV5vd
         X5cC2XysDdDs9O056O8nKhX/ktKWaFxiHB83dHGkYiuSgXlHSJGjH4wFhGO9HO1xvp4o
         kv0ggseNgZr2RyPy+pbanzUVdL0omNQ+5B6QVV7TN/wbcPxSFVAyFWRk7HOBO3Aj1u1G
         9EJcsAylIrwR6nskSHuvNO/bIdP7UUzLResg1xmUVBpAu4+n0HKbspBjmcFpnZreTPBz
         /ZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695480249; x=1696085049;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEI/1t3uJXzPJgmk3aNvlJpT+FiDiUf2BknRFZB/E1M=;
        b=wOSIcVsRWnQ1z2/xmGWUjtcklK/46+LGC2OtfAfXLGIXcYqPF/kmttm+v9plE0wjLG
         +ToSvum8DdofMNDg8EH5RtDVdhhMYfR+KRDRCzqj61/Di6BIosVhuyq7L0W5wf/bZkuQ
         vRdMe6g9tLzz1N5AjKvCv/0FKd7yrfhKIQ7r7yMdJyCcN7VL1KlJ3Dan1CFSQK8QnEbZ
         kTmiscvSI1s5AvSXPfmKV/wfzvf75WtXXEAEXuz0SZ5fjZf/2Wp0p0PzIxA1L0whp4cv
         3u0Nicxl1GmO/sAnEmxB1QhvnFOgAiC8fY64ZdZZo5Mbb+azfN/nay7MN504byuT+61k
         73Ow==
X-Gm-Message-State: AOJu0YxozjzOxTS15X712AaZuL/hTXb1xBVQzLNcTtOBUf9rx+ekrWL+
        4aghl74KKC8lspb6GUeOFNTIWZY049nV0w+cRR28Vw==
X-Google-Smtp-Source: AGHT+IENjNxkMCY3/CByP1beHQKYKHwN2OIB0XUo8e9dFYNnI3mP8rnjuvEC78lXXVPbvq9bMIjrMQ==
X-Received: by 2002:a05:6808:1795:b0:3a1:b28f:814c with SMTP id bg21-20020a056808179500b003a1b28f814cmr3201563oib.1.1695480249511;
        Sat, 23 Sep 2023 07:44:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fe20-20020a056a002f1400b0068fadc9226dsm5043808pfb.33.2023.09.23.07.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 07:44:08 -0700 (PDT)
Message-ID: <650ef9b8.050a0220.52959.8c32@mx.google.com>
Date:   Sat, 23 Sep 2023 07:44:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.55
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 118 runs, 10 regressions (v6.1.55)
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

stable-rc/linux-6.1.y baseline: 118 runs, 10 regressions (v6.1.55)

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

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

odroid-xu3                   | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.55/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.55
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d23900f974e0fb995b36ef47283a5aa74ca25f51 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec61a53160bc14b8a0a73

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec61a53160bc14b8a0a7c
        failing since 176 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-23T11:05:06.810168  <8>[   10.318093] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11601474_1.4.2.3.1>

    2023-09-23T11:05:06.813686  + set +x

    2023-09-23T11:05:06.914831  / #

    2023-09-23T11:05:07.015540  # #export SHELL=3D/bin/sh

    2023-09-23T11:05:07.015819  =


    2023-09-23T11:05:07.116366  / # export SHELL=3D/bin/sh. /lava-11601474/=
environment

    2023-09-23T11:05:07.116549  =


    2023-09-23T11:05:07.217021  / # . /lava-11601474/environment/lava-11601=
474/bin/lava-test-runner /lava-11601474/1

    2023-09-23T11:05:07.217399  =


    2023-09-23T11:05:07.223250  / # /lava-11601474/bin/lava-test-runner /la=
va-11601474/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec61a53160bc14b8a0a7e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec61a53160bc14b8a0a87
        failing since 176 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-23T11:04:00.411562  + set<8>[    8.958895] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11601483_1.4.2.3.1>

    2023-09-23T11:04:00.412053   +x

    2023-09-23T11:04:00.519931  / # #

    2023-09-23T11:04:00.622382  export SHELL=3D/bin/sh

    2023-09-23T11:04:00.623170  #

    2023-09-23T11:04:00.724655  / # export SHELL=3D/bin/sh. /lava-11601483/=
environment

    2023-09-23T11:04:00.725575  =


    2023-09-23T11:04:00.827062  / # . /lava-11601483/environment/lava-11601=
483/bin/lava-test-runner /lava-11601483/1

    2023-09-23T11:04:00.828445  =


    2023-09-23T11:04:00.833404  / # /lava-11601483/bin/lava-test-runner /la=
va-11601483/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec61439b616176d8a0ae6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec61439b616176d8a0aef
        failing since 176 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-23T11:03:34.694498  <8>[   10.566008] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11601491_1.4.2.3.1>

    2023-09-23T11:03:34.697477  + set +x

    2023-09-23T11:03:34.802489  #

    2023-09-23T11:03:34.905309  / # #export SHELL=3D/bin/sh

    2023-09-23T11:03:34.906109  =


    2023-09-23T11:03:35.007700  / # export SHELL=3D/bin/sh. /lava-11601491/=
environment

    2023-09-23T11:03:35.008490  =


    2023-09-23T11:03:35.110154  / # . /lava-11601491/environment/lava-11601=
491/bin/lava-test-runner /lava-11601491/1

    2023-09-23T11:03:35.111450  =


    2023-09-23T11:03:35.117017  / # /lava-11601491/bin/lava-test-runner /la=
va-11601491/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec866710aa7eb268a0ac2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ec866710aa7eb268a0=
ac3
        failing since 107 days (last pass: v6.1.31-40-g7d0a9678d276, first =
fail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec6071bf3fdfa4a8a0a99

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec6071bf3fdfa4a8a0aa2
        failing since 176 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-23T11:03:25.260204  + set +x

    2023-09-23T11:03:25.266552  <8>[   10.062219] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11601494_1.4.2.3.1>

    2023-09-23T11:03:25.370826  / # #

    2023-09-23T11:03:25.471390  export SHELL=3D/bin/sh

    2023-09-23T11:03:25.471588  #

    2023-09-23T11:03:25.572044  / # export SHELL=3D/bin/sh. /lava-11601494/=
environment

    2023-09-23T11:03:25.572221  =


    2023-09-23T11:03:25.672716  / # . /lava-11601494/environment/lava-11601=
494/bin/lava-test-runner /lava-11601494/1

    2023-09-23T11:03:25.672961  =


    2023-09-23T11:03:25.677922  / # /lava-11601494/bin/lava-test-runner /la=
va-11601494/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec61239b616176d8a0ac4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec61239b616176d8a0acd
        failing since 176 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-23T11:03:25.299723  + <8>[   11.183072] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11601478_1.4.2.3.1>

    2023-09-23T11:03:25.300245  set +x

    2023-09-23T11:03:25.407538  / # #

    2023-09-23T11:03:25.509760  export SHELL=3D/bin/sh

    2023-09-23T11:03:25.510653  #

    2023-09-23T11:03:25.612138  / # export SHELL=3D/bin/sh. /lava-11601478/=
environment

    2023-09-23T11:03:25.612940  =


    2023-09-23T11:03:25.714693  / # . /lava-11601478/environment/lava-11601=
478/bin/lava-test-runner /lava-11601478/1

    2023-09-23T11:03:25.716269  =


    2023-09-23T11:03:25.720997  / # /lava-11601478/bin/lava-test-runner /la=
va-11601478/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec6041bf3fdfa4a8a0a78

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec6041bf3fdfa4a8a0a81
        failing since 176 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-23T11:03:20.237372  <8>[   11.413519] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11601489_1.4.2.3.1>

    2023-09-23T11:03:20.345328  / # #

    2023-09-23T11:03:20.447797  export SHELL=3D/bin/sh

    2023-09-23T11:03:20.448564  #

    2023-09-23T11:03:20.549954  / # export SHELL=3D/bin/sh. /lava-11601489/=
environment

    2023-09-23T11:03:20.550592  =


    2023-09-23T11:03:20.652054  / # . /lava-11601489/environment/lava-11601=
489/bin/lava-test-runner /lava-11601489/1

    2023-09-23T11:03:20.653119  =


    2023-09-23T11:03:20.657850  / # /lava-11601489/bin/lava-test-runner /la=
va-11601489/1

    2023-09-23T11:03:20.665178  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
odroid-xu3                   | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec6e5c4d39634908a0a9f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ec6e5c4d39634908a0=
aa0
        new failure (last pass: v6.1.52-814-g5e5c3289d389) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec89e34a186a45c8a0acb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650ec89e34a186a45c8a0=
acc
        new failure (last pass: v6.1.54) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650ec84d643a86d42e8a0b40

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.55/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650ec84d643a86d42e8a0b49
        failing since 67 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-23T11:17:15.820655  / # #

    2023-09-23T11:17:15.922665  export SHELL=3D/bin/sh

    2023-09-23T11:17:15.923368  #

    2023-09-23T11:17:16.024842  / # export SHELL=3D/bin/sh. /lava-11601546/=
environment

    2023-09-23T11:17:16.025553  =


    2023-09-23T11:17:16.126984  / # . /lava-11601546/environment/lava-11601=
546/bin/lava-test-runner /lava-11601546/1

    2023-09-23T11:17:16.128040  =


    2023-09-23T11:17:16.145087  / # /lava-11601546/bin/lava-test-runner /la=
va-11601546/1

    2023-09-23T11:17:16.209799  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-23T11:17:16.210288  + cd /lava-1160154<8>[   18.787579] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11601546_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
