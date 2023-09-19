Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D9F7A69E1
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 19:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjISRte (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 13:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjISRtd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 13:49:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7052999
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 10:49:26 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68c576d35feso5474024b3a.2
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 10:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695145765; x=1695750565; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FEgtF/s1AQstcBUbbxoG0I/0EyPTPqlx4cPZTPtfUVM=;
        b=yPvDdeWbhpYtjoQMQSSrSCUfqx4F77XbyLk53BZTfXBEXsUjgOulM/6qPP/uVLjpSA
         Cx4kyW7UMrrFn05oIp5y22Na1iYWM1BSu02oBo8F+NBVUMdYlLdSiQPS57Zsg9taemVb
         aaqR//bWecgpB+9MvacYQM6EQG/ayA6Nswk5mPf6WeIdeIWGoKTigmsbH4IpFPGPNhOS
         PlIzHs9Fiv9x0V39p5wQV83rjz/vZwQcpaPEs8FTum/VSS2oJKJLU/H8GLjfK1van9j5
         noRul0FgVNbrjfw19tdAwSnrCacsSFQynhTv4gtouT3aCnWZFQTEC7BicDp9Zq+SU2+J
         7lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695145765; x=1695750565;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEgtF/s1AQstcBUbbxoG0I/0EyPTPqlx4cPZTPtfUVM=;
        b=jNcY9zWZaqtBfWMyLcioD4LYCJ6gAyQa58+AJRAQobDdZGAob3njOT5qa5Eex7jaRN
         cpAV8dTCZw5i4DIGZTryV2lka743P01tvzdbQmbpHV11Uv53a3rcZ3n5XOiC+Vt4Bi0P
         zAFtoc6x35L9VlVE6lkwEvs5/4MWU0kgjhnhe36wYa7iAsoKKvFcfIX49iC5HG/fODko
         wjBRyJ6l8yzNpuMffWnMWDtHv912VlBdizMyO6FDsKlg/zzPmgsx9xIAljTQMu3hhF98
         vG0UjuxzsW3oH+J+Eo+uNok0zGoGmA0/NKnPYnftAfuD9IbcOO6pJszDTxyJZaw+EI7k
         C7Vg==
X-Gm-Message-State: AOJu0YzhGvvX2oNI/DrYa5ji0F4vxe1I3Fv4/59cDok25yS2wjD/FqPC
        ngOzH9LTrOk7jczep7FnzFuFGOBXIQdCiK5ybAC/GA==
X-Google-Smtp-Source: AGHT+IEJ5vMjo0C0w162ngItGlbgmVR9O3E/ZTVuGEfVFNxphoDPNA7PAZvhoNaJDJXB+ggaxD+5hw==
X-Received: by 2002:a05:6a00:2284:b0:68f:bbc3:df44 with SMTP id f4-20020a056a00228400b0068fbbc3df44mr567669pfe.0.1695145765345;
        Tue, 19 Sep 2023 10:49:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s22-20020aa78d56000000b0068fc48fcaa8sm8811952pfe.155.2023.09.19.10.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:49:24 -0700 (PDT)
Message-ID: <6509df24.a70a0220.6679e.e0d1@mx.google.com>
Date:   Tue, 19 Sep 2023 10:49:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.195
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 114 runs, 6 regressions (v5.10.195)
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

stable-rc/linux-5.10.y baseline: 114 runs, 6 regressions (v5.10.195)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.195/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.195
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5452d1be676cb0fb9dc417f7b48a917c9d020420 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6509acca363c22f9768a0a42

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509acca363c22f9768a0a4b
        failing since 174 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-19T14:14:27.525231  + set +x

    2023-09-19T14:14:27.532288  <8>[   14.555341] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11571529_1.4.2.3.1>

    2023-09-19T14:14:27.636204  / # #

    2023-09-19T14:14:27.736829  export SHELL=3D/bin/sh

    2023-09-19T14:14:27.737008  #

    2023-09-19T14:14:27.837536  / # export SHELL=3D/bin/sh. /lava-11571529/=
environment

    2023-09-19T14:14:27.837691  =


    2023-09-19T14:14:27.938214  / # . /lava-11571529/environment/lava-11571=
529/bin/lava-test-runner /lava-11571529/1

    2023-09-19T14:14:27.938493  =


    2023-09-19T14:14:27.943855  / # /lava-11571529/bin/lava-test-runner /la=
va-11571529/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6509accb5ed91242ab8a0a53

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509accb5ed91242ab8a0a5c
        failing since 174 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-19T14:15:53.269266  <8>[   11.428707] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11571517_1.4.2.3.1>

    2023-09-19T14:15:53.272348  + set +x

    2023-09-19T14:15:53.373809  =


    2023-09-19T14:15:53.474360  / # #export SHELL=3D/bin/sh

    2023-09-19T14:15:53.474569  =


    2023-09-19T14:15:53.575056  / # export SHELL=3D/bin/sh. /lava-11571517/=
environment

    2023-09-19T14:15:53.575240  =


    2023-09-19T14:15:53.675714  / # . /lava-11571517/environment/lava-11571=
517/bin/lava-test-runner /lava-11571517/1

    2023-09-19T14:15:53.675983  =


    2023-09-19T14:15:53.680781  / # /lava-11571517/bin/lava-test-runner /la=
va-11571517/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509ae7a707363daa08a0a4d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509ae7a707363daa08a0a54
        failing since 63 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-19T14:21:05.709298  / # #
    2023-09-19T14:21:07.169194  export SHELL=3D/bin/sh
    2023-09-19T14:21:07.189778  #
    2023-09-19T14:21:07.189965  / # export SHELL=3D/bin/sh
    2023-09-19T14:21:09.142986  / # . /lava-1010425/environment
    2023-09-19T14:21:12.739517  /lava-1010425/bin/lava-test-runner /lava-10=
10425/1
    2023-09-19T14:21:12.760144  . /lava-1010425/environment
    2023-09-19T14:21:12.760266  / # /lava-1010425/bin/lava-test-runner /lav=
a-1010425/1
    2023-09-19T14:21:12.794507  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-19T14:21:12.842167  + cd /lava-1010425/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509addc2416a52ca88a0aba

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509addc2416a52ca88a0ac3
        failing since 63 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-19T14:23:14.127815  / # #

    2023-09-19T14:23:14.230023  export SHELL=3D/bin/sh

    2023-09-19T14:23:14.230732  #

    2023-09-19T14:23:14.331991  / # export SHELL=3D/bin/sh. /lava-11571574/=
environment

    2023-09-19T14:23:14.332693  =


    2023-09-19T14:23:14.434131  / # . /lava-11571574/environment/lava-11571=
574/bin/lava-test-runner /lava-11571574/1

    2023-09-19T14:23:14.435224  =


    2023-09-19T14:23:14.451915  / # /lava-11571574/bin/lava-test-runner /la=
va-11571574/1

    2023-09-19T14:23:14.501320  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T14:23:14.501827  + cd /lav<8>[   16.413410] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11571574_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509ae1272056e6f008a0a58

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509ae1272056e6f008a0a61
        failing since 25 days (last pass: v5.10.191, first fail: v5.10.190-=
136-gda59b7b5c515e)

    2023-09-19T14:19:38.183048  / # #

    2023-09-19T14:19:39.444196  export SHELL=3D/bin/sh

    2023-09-19T14:19:39.455148  #

    2023-09-19T14:19:39.455617  / # export SHELL=3D/bin/sh

    2023-09-19T14:19:41.196514  / # . /lava-11571569/environment

    2023-09-19T14:19:44.396759  /lava-11571569/bin/lava-test-runner /lava-1=
1571569/1

    2023-09-19T14:19:44.408203  . /lava-11571569/environment

    2023-09-19T14:19:44.408525  / # /lava-11571569/bin/lava-test-runner /la=
va-11571569/1

    2023-09-19T14:19:44.464245  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T14:19:44.464733  + cd /lava-11571569/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509adef6416c885a68a0a46

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509adef6416c885a68a0a4f
        failing since 63 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-19T14:23:29.767915  / # #

    2023-09-19T14:23:29.870078  export SHELL=3D/bin/sh

    2023-09-19T14:23:29.870777  #

    2023-09-19T14:23:29.972107  / # export SHELL=3D/bin/sh. /lava-11571571/=
environment

    2023-09-19T14:23:29.972794  =


    2023-09-19T14:23:30.074116  / # . /lava-11571571/environment/lava-11571=
571/bin/lava-test-runner /lava-11571571/1

    2023-09-19T14:23:30.074413  =


    2023-09-19T14:23:30.076541  / # /lava-11571571/bin/lava-test-runner /la=
va-11571571/1

    2023-09-19T14:23:30.120044  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T14:23:30.150330  + cd /lava-1157157<8>[   18.192378] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11571571_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
