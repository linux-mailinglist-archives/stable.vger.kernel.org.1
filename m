Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF647A67D0
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 17:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjISPRF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 11:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjISPQz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 11:16:55 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A76DE5
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 08:16:48 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68fc9e0e22eso4513876b3a.1
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 08:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695136607; x=1695741407; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lx3eoSTFMvxxxb+aKKNsZoOh6TuMwhElsvydfkC5XXM=;
        b=YZ4O5foFN6ZhOKK2hGcBbfAVTKA5C5LhWgELoRwwe4cqHh0it6a6gl8CWL8XeQgYVz
         v6pWfeSpATznI+sSjG5iPJAmFK8YPo5NPZEpx/RC0Lc4NvZAIEMVxFeM2mTPslYuG2oP
         UsEO2oOwd7+A/kjfBVFy7WRLSX8UjwIxk+yfzjEUPCfobPPFh92OyWs7xvdM9JIpp5KI
         OtWENJ0vI+N3zhvpLC/lbPwa18lEVLGn+2949XPdZGiNxWxmIp+mp2ew/N9AX+jdLN1q
         amwUMsacnQQgTpoiCJbNHeEjXp1ngQ13sxJbnvAglyyITjWNUC8wlEazh/kcJNB7EsEx
         gKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695136607; x=1695741407;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lx3eoSTFMvxxxb+aKKNsZoOh6TuMwhElsvydfkC5XXM=;
        b=kUyO0rmV1449wZLsr2Bb/HOGhzuWhFUwtSv9DG5IuUMtPKA/vp05GEUYA1kxcpl2da
         LJaSygklaueN9nuxkpRJMm/VyJ/S1yD1in2rfG2zVfb1wAj5i4C6SU92b9ifZu2FDJvk
         XJFyyhMldsosL69J0ULSk+jWd4DQj5s5QkMXBUx/+FKik1caQLC/aTYLOGmR8U8kFAVq
         7PI2T+M3tYV+fAW2UePPp12mZKm3+YkbpT4MluXyiFxM9CLmbGg93RVpd+hXo/eenp2r
         JBCHg9+rLKeSnllgMToIvB2T/EHUZPK/dyqsSgGiU5qDAZ2QHu1wAsK1zkGZXqxU1v8L
         47YQ==
X-Gm-Message-State: AOJu0Yw+c9EakUX+H3SwHhJ2nnQJ3dpW0heOlvkDoKweQuUIJxdMsgar
        4y57N5CUfNNPTmSmq+RD/qQMmxDdgUtbhWrjQWim3Q==
X-Google-Smtp-Source: AGHT+IGI9NiL4HuKwvM4IMkoGNkRbaS8k4ag5UykGr6e/EoCfejzkJgstRVBclOu/LApQqYPX0ka9w==
X-Received: by 2002:a05:6a20:12ce:b0:137:2f8c:fab0 with SMTP id v14-20020a056a2012ce00b001372f8cfab0mr13976393pzg.49.1695136607092;
        Tue, 19 Sep 2023 08:16:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j15-20020aa783cf000000b0068e34f07eb5sm8775660pfn.165.2023.09.19.08.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 08:16:46 -0700 (PDT)
Message-ID: <6509bb5e.a70a0220.7a279.e66c@mx.google.com>
Date:   Tue, 19 Sep 2023 08:16:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v5.10.195
X-Kernelci-Report-Type: test
Subject: stable/linux-5.10.y baseline: 120 runs, 13 regressions (v5.10.195)
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

stable/linux-5.10.y baseline: 120 runs, 13 regressions (v5.10.195)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.195/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.195
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      5452d1be676cb0fb9dc417f7b48a917c9d020420 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65098a9a9cc9156a1b8a0a83

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65098a9a9cc9156a1b8a0=
a84
        new failure (last pass: v5.10.194) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65098a9f9cc9156a1b8a0a91

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65098a9f9cc9156a1b8a0=
a92
        new failure (last pass: v5.10.194) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6509885020deb39c238a0a6e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509885020deb39c238a0a77
        failing since 167 days (last pass: v5.10.176, first fail: v5.10.177)

    2023-09-19T11:38:44.662732  + <8>[   12.186589] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11570406_1.4.2.3.1>

    2023-09-19T11:38:44.662810  set +x

    2023-09-19T11:38:44.764097  #

    2023-09-19T11:38:44.764354  =


    2023-09-19T11:38:44.865026  / # #export SHELL=3D/bin/sh

    2023-09-19T11:38:44.865215  =


    2023-09-19T11:38:44.965695  / # export SHELL=3D/bin/sh. /lava-11570406/=
environment

    2023-09-19T11:38:44.965919  =


    2023-09-19T11:38:45.066518  / # . /lava-11570406/environment/lava-11570=
406/bin/lava-test-runner /lava-11570406/1

    2023-09-19T11:38:45.066809  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65098d2d3a809f9d8f8a0a58

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65098d2d3a809f9d8f8a0a5f
        failing since 23 days (last pass: v5.10.185, first fail: v5.10.192)

    2023-09-19T11:59:20.418835  + set +x
    2023-09-19T11:59:20.422074  <8>[   83.991649] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010157_1.5.2.4.1>
    2023-09-19T11:59:20.532131  / # #
    2023-09-19T11:59:21.996689  export SHELL=3D/bin/sh
    2023-09-19T11:59:22.017651  #
    2023-09-19T11:59:22.018109  / # export SHELL=3D/bin/sh
    2023-09-19T11:59:23.976034  / # . /lava-1010157/environment
    2023-09-19T11:59:27.578041  /lava-1010157/bin/lava-test-runner /lava-10=
10157/1
    2023-09-19T11:59:27.599529  . /lava-1010157/environment
    2023-09-19T11:59:27.599944  / # /lava-1010157/bin/lava-test-runner /lav=
a-1010157/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65098e09980d3c745e8a0a55

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rz=
g2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65098e09980d3c745e8a0a5c
        failing since 54 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-09-19T12:03:02.870240  + set +x
    2023-09-19T12:03:02.873460  <8>[   84.037608] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010165_1.5.2.4.1>
    2023-09-19T12:03:02.981285  / # #
    2023-09-19T12:03:04.445595  export SHELL=3D/bin/sh
    2023-09-19T12:03:04.466541  #
    2023-09-19T12:03:04.467001  / # export SHELL=3D/bin/sh
    2023-09-19T12:03:06.425029  / # . /lava-1010165/environment
    2023-09-19T12:03:10.027048  /lava-1010165/bin/lava-test-runner /lava-10=
10165/1
    2023-09-19T12:03:10.048507  . /lava-1010165/environment
    2023-09-19T12:03:10.048924  / # /lava-1010165/bin/lava-test-runner /lav=
a-1010165/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65098c67bd4dee76818a0a46

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rz=
g2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rz=
g2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65098c67bd4dee76818a0a4d
        failing since 54 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-09-19T11:55:57.855308  + set +x
    2023-09-19T11:55:57.855492  <8>[   84.277146] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010166_1.5.2.4.1>
    2023-09-19T11:55:57.967326  / # #
    2023-09-19T11:55:59.452297  export SHELL=3D/bin/sh
    2023-09-19T11:55:59.476458  #
    2023-09-19T11:55:59.476664  / # export SHELL=3D/bin/sh
    2023-09-19T11:56:01.452279  / # . /lava-1010166/environment
    2023-09-19T11:56:05.137298  /lava-1010166/bin/lava-test-runner /lava-10=
10166/1
    2023-09-19T11:56:05.158155  . /lava-1010166/environment
    2023-09-19T11:56:05.158293  / # /lava-1010166/bin/lava-test-runner /lav=
a-1010166/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65098a863b20115c638a0a42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65098a863b20115c638a0a49
        failing since 54 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-09-19T11:48:08.405829  / # #
    2023-09-19T11:48:09.866299  export SHELL=3D/bin/sh
    2023-09-19T11:48:09.886822  #
    2023-09-19T11:48:09.887023  / # export SHELL=3D/bin/sh
    2023-09-19T11:48:11.839772  / # . /lava-1010162/environment
    2023-09-19T11:48:15.444560  /lava-1010162/bin/lava-test-runner /lava-10=
10162/1
    2023-09-19T11:48:15.465540  . /lava-1010162/environment
    2023-09-19T11:48:15.465677  / # /lava-1010162/bin/lava-test-runner /lav=
a-1010162/1
    2023-09-19T11:48:15.541831  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-19T11:48:15.542039  + cd /lava-1010162/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65098bb23ef005f4708a0a42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65098bb23ef005f4708a0a49
        failing since 54 days (last pass: v5.10.184, first fail: v5.10.188)

    2023-09-19T11:52:33.075671  <8>[   85.185752] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-09-19T11:52:33.075773  + set +x
    2023-09-19T11:52:33.075862  <8>[   85.196916] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010167_1.5.2.4.1>
    2023-09-19T11:52:33.178683  / # #
    2023-09-19T11:52:34.644309  export SHELL=3D/bin/sh
    2023-09-19T11:52:34.665081  #
    2023-09-19T11:52:34.665287  / # export SHELL=3D/bin/sh
    2023-09-19T11:52:36.619902  / # . /lava-1010167/environment
    2023-09-19T11:52:40.218444  /lava-1010167/bin/lava-test-runner /lava-10=
10167/1
    2023-09-19T11:52:40.239215  . /lava-1010167/environment =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65099eb022654425018a0a7d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65099eb022654425018a0a86
        failing since 54 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-09-19T13:18:24.671860  / # #

    2023-09-19T13:18:24.774001  export SHELL=3D/bin/sh

    2023-09-19T13:18:24.774706  #

    2023-09-19T13:18:24.876123  / # export SHELL=3D/bin/sh. /lava-11570455/=
environment

    2023-09-19T13:18:24.876855  =


    2023-09-19T13:18:24.978156  / # . /lava-11570455/environment/lava-11570=
455/bin/lava-test-runner /lava-11570455/1

    2023-09-19T13:18:24.979259  =


    2023-09-19T13:18:24.996066  / # /lava-11570455/bin/lava-test-runner /la=
va-11570455/1

    2023-09-19T13:18:25.045055  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T13:18:25.045565  + cd /lav<8>[   16.492711] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11570455_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/65098aaab48886f2628a0a49

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65098aaab48886f2628a0a53
        failing since 185 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-09-19T11:49:01.546868  /lava-11570467/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65098aaab48886f2628a0a54
        failing since 185 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-09-19T11:49:00.509003  /lava-11570467/1/../bin/lava-test-case

    2023-09-19T11:49:00.520430  <8>[   33.929657] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65098a0792ef83248f8a0b25

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65098a0792ef83248f8a0b2e
        failing since 23 days (last pass: v5.10.191, first fail: v5.10.192)

    2023-09-19T11:47:53.834480  / # #

    2023-09-19T11:47:55.095627  export SHELL=3D/bin/sh

    2023-09-19T11:47:55.106587  #

    2023-09-19T11:47:55.107054  / # export SHELL=3D/bin/sh

    2023-09-19T11:47:56.851186  / # . /lava-11570454/environment

    2023-09-19T11:48:00.057065  /lava-11570454/bin/lava-test-runner /lava-1=
1570454/1

    2023-09-19T11:48:00.068536  . /lava-11570454/environment

    2023-09-19T11:48:00.069517  / # /lava-11570454/bin/lava-test-runner /la=
va-11570454/1

    2023-09-19T11:48:00.124595  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T11:48:00.125082  + cd /lava-11570454/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650989e5ad235c4fce8a0bb1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.195/=
arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650989e5ad235c4fce8a0bba
        failing since 54 days (last pass: v5.10.185, first fail: v5.10.188)

    2023-09-19T11:49:53.336765  / # #

    2023-09-19T11:49:53.438822  export SHELL=3D/bin/sh

    2023-09-19T11:49:53.439548  #

    2023-09-19T11:49:53.540957  / # export SHELL=3D/bin/sh. /lava-11570463/=
environment

    2023-09-19T11:49:53.541665  =


    2023-09-19T11:49:53.642941  / # . /lava-11570463/environment/lava-11570=
463/bin/lava-test-runner /lava-11570463/1

    2023-09-19T11:49:53.643950  =


    2023-09-19T11:49:53.688109  / # /lava-11570463/bin/lava-test-runner /la=
va-11570463/1

    2023-09-19T11:49:53.718619  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T11:49:53.718848  + cd /lava-1157046<8>[   18.287866] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11570463_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
