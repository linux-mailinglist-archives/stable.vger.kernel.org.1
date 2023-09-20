Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C82A7A8AA2
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 19:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjITRaT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 13:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjITRaT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 13:30:19 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8C0A3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 10:30:11 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68fb98745c1so28618b3a.1
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 10:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695231011; x=1695835811; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lc/yVaT51sw1mW3WGesxFhbkJ2M2f6yNX2lvO23F4bE=;
        b=xaRnEGxksoQ0rYk/9E8g+bqiuuT3x2BV5A+Gy7m5EeBWdAZGyrMAKTQZ6o1NI3AbQx
         ZBYpM3eXmgOztQ61SY6NP7TbVDB2a0Adq2yzVNNjj0YHKd6ECF0EmPEcRIpgK56hYZLA
         wFjOvVT9zgyUkGK9xufa8A6O3BhKqZ+BEACe+tSs2lTXq9BofUHxHyFdMT8P9Wfhf8Lb
         UPPXWHj+4Yh1SOPQfrKqf6tvnhE9MgpmuGJ6RRPZG2SHwuBXmZsLdXKww6M9fOL3rAAs
         KrZ2a24f5IR0Oxj+AEhCpFkNOFsYcj/1jnWER2vwNA1vwlXQBO2oRvEJ5KvajwwJyT+r
         HqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695231011; x=1695835811;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lc/yVaT51sw1mW3WGesxFhbkJ2M2f6yNX2lvO23F4bE=;
        b=RfPC16DRXjTA95GvlLJUByyGelB7I61atFzdG6NVgX6WJzYtytw/FLwEnG9UIiTXU/
         fFv74/E1nnjaArAnTlSEx9uuIbN7SH4S6mxSe/6u0/Dx5s3ttVCJTOiedmIBgou+4ayY
         U44ZqNZIBnyZyfJE9ZORFxmgySglwJ3R99FFBB9eGJCVdvqQKeqN6k38tAwjvvtepbRm
         4QpxYrBHrbHCJePVV4jwMteuYcCsD1ZvTyj0qfFjRyJ5TxzkXFi7cd0aIVHpM4HWui5l
         A35KFAXxLt2elTyY3kiL/XasBdDwiTfgiPJsfEw1uV3zdzKq7O0oiWVLo/wllrAnAuaJ
         RJpQ==
X-Gm-Message-State: AOJu0YyU2H1XkBYyXNfFbmrA2INSh3edBUp/6vAgWIBV8PtrhFfeCVQF
        j7a/GezIxCiBZwTdFgXBIy8Ij78XWnWIY9kITjVMPg==
X-Google-Smtp-Source: AGHT+IEPxWL1BfSliXNUKLeGEUBGMVz5tx57kkCbXa1pX5HXujIL4biOcIYj7qQE/X4YSXySmcm1MA==
X-Received: by 2002:a05:6a00:1995:b0:68f:c9df:2ccb with SMTP id d21-20020a056a00199500b0068fc9df2ccbmr3435266pfl.1.1695231010687;
        Wed, 20 Sep 2023 10:30:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t13-20020a63b70d000000b005741b5eee47sm8573053pgf.10.2023.09.20.10.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 10:30:10 -0700 (PDT)
Message-ID: <650b2c22.630a0220.4b7f1.a864@mx.google.com>
Date:   Wed, 20 Sep 2023 10:30:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.195-84-gf147286de8e5
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 119 runs,
 10 regressions (v5.10.195-84-gf147286de8e5)
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

stable-rc/linux-5.10.y baseline: 119 runs, 10 regressions (v5.10.195-84-gf1=
47286de8e5)

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

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.195-84-gf147286de8e5/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.195-84-gf147286de8e5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f147286de8e534b063d97de0c66a4a5895bfc6ad =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650af5fc92fd6e9cb38a0a7f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650af5fc92fd6e9cb38a0a88
        failing since 175 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-20T13:38:53.242229  + set +x

    2023-09-20T13:38:53.248846  <8>[   11.001455] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11579502_1.4.2.3.1>

    2023-09-20T13:38:53.356687  / # #

    2023-09-20T13:38:53.458929  export SHELL=3D/bin/sh

    2023-09-20T13:38:53.459667  #

    2023-09-20T13:38:53.561355  / # export SHELL=3D/bin/sh. /lava-11579502/=
environment

    2023-09-20T13:38:53.562140  =


    2023-09-20T13:38:53.663943  / # . /lava-11579502/environment/lava-11579=
502/bin/lava-test-runner /lava-11579502/1

    2023-09-20T13:38:53.665175  =


    2023-09-20T13:38:53.670276  / # /lava-11579502/bin/lava-test-runner /la=
va-11579502/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650af5b4008ac9c8148a0a68

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650af5b4008ac9c8148a0a71
        failing since 175 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-20T13:39:05.437111  + set +x<8>[   12.855022] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11579490_1.4.2.3.1>

    2023-09-20T13:39:05.437195  =


    2023-09-20T13:39:05.538732  #

    2023-09-20T13:39:05.639500  / # #export SHELL=3D/bin/sh

    2023-09-20T13:39:05.639685  =


    2023-09-20T13:39:05.740263  / # export SHELL=3D/bin/sh. /lava-11579490/=
environment

    2023-09-20T13:39:05.740423  =


    2023-09-20T13:39:05.840945  / # . /lava-11579490/environment/lava-11579=
490/bin/lava-test-runner /lava-11579490/1

    2023-09-20T13:39:05.841266  =


    2023-09-20T13:39:05.846334  / # /lava-11579490/bin/lava-test-runner /la=
va-11579490/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650af7e28a9dbe61b18a0a46

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650af7e28a9dbe61b18a0a86
        new failure (last pass: v5.10.195)

    2023-09-20T13:46:49.641406  / # #
    2023-09-20T13:46:49.744476  export SHELL=3D/bin/sh
    2023-09-20T13:46:49.745291  #
    2023-09-20T13:46:49.847303  / # export SHELL=3D/bin/sh. /lava-120288/en=
vironment
    2023-09-20T13:46:49.848093  =

    2023-09-20T13:46:49.950082  / # . /lava-120288/environment/lava-120288/=
bin/lava-test-runner /lava-120288/1
    2023-09-20T13:46:49.951419  =

    2023-09-20T13:46:49.964098  / # /lava-120288/bin/lava-test-runner /lava=
-120288/1
    2023-09-20T13:46:50.023898  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-20T13:46:50.024410  + cd /lava-120288/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650af745c1b9fa35b08a0a45

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650af745c1b9fa35b08a0a4c
        failing since 64 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-20T13:44:02.009083  + set +x
    2023-09-20T13:44:02.009199  <8>[   83.880822] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010924_1.5.2.4.1>
    2023-09-20T13:44:02.115183  / # #
    2023-09-20T13:44:03.574721  export SHELL=3D/bin/sh
    2023-09-20T13:44:03.595130  #
    2023-09-20T13:44:03.595259  / # export SHELL=3D/bin/sh
    2023-09-20T13:44:05.547607  / # . /lava-1010924/environment
    2023-09-20T13:44:09.141046  /lava-1010924/bin/lava-test-runner /lava-10=
10924/1
    2023-09-20T13:44:09.161650  . /lava-1010924/environment
    2023-09-20T13:44:09.161760  / # /lava-1010924/bin/lava-test-runner /lav=
a-1010924/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650af72d9d69b01c1c8a0a7c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650af72d9d69b01c1c8a0a83
        failing since 64 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-20T13:43:55.369548  + set +x
    2023-09-20T13:43:55.369673  <8>[   84.236307] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010925_1.5.2.4.1>
    2023-09-20T13:43:55.475410  / # #
    2023-09-20T13:43:56.936522  export SHELL=3D/bin/sh
    2023-09-20T13:43:56.956979  #
    2023-09-20T13:43:56.957105  / # export SHELL=3D/bin/sh
    2023-09-20T13:43:58.909916  / # . /lava-1010925/environment
    2023-09-20T13:44:02.502386  /lava-1010925/bin/lava-test-runner /lava-10=
10925/1
    2023-09-20T13:44:02.523138  . /lava-1010925/environment
    2023-09-20T13:44:02.523291  / # /lava-1010925/bin/lava-test-runner /lav=
a-1010925/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650af7443490a496458a0a52

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baselin=
e-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650af7443490a496458a0a59
        failing since 64 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-20T13:44:16.396471  / # #
    2023-09-20T13:44:17.856570  export SHELL=3D/bin/sh
    2023-09-20T13:44:17.877034  #
    2023-09-20T13:44:17.877165  / # export SHELL=3D/bin/sh
    2023-09-20T13:44:19.829715  / # . /lava-1010923/environment
    2023-09-20T13:44:23.422978  /lava-1010923/bin/lava-test-runner /lava-10=
10923/1
    2023-09-20T13:44:23.443538  . /lava-1010923/environment
    2023-09-20T13:44:23.443648  / # /lava-1010923/bin/lava-test-runner /lav=
a-1010923/1
    2023-09-20T13:44:23.520407  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-20T13:44:23.520535  + cd /lava-1010923/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650af83264d9fce5e38a0a46

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650af83264d9fce5e38a0a4d
        failing since 64 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-20T13:48:20.464991  / # #
    2023-09-20T13:48:21.927285  export SHELL=3D/bin/sh
    2023-09-20T13:48:21.947834  #
    2023-09-20T13:48:21.948060  / # export SHELL=3D/bin/sh
    2023-09-20T13:48:23.904922  / # . /lava-1010935/environment
    2023-09-20T13:48:27.504231  /lava-1010935/bin/lava-test-runner /lava-10=
10935/1
    2023-09-20T13:48:27.525132  . /lava-1010935/environment
    2023-09-20T13:48:27.525242  / # /lava-1010935/bin/lava-test-runner /lav=
a-1010935/1
    2023-09-20T13:48:27.604988  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-20T13:48:27.605294  + cd /lava-1010935/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650af749c2f9283d178a0a4e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650af749c2f9283d178a0a57
        failing since 64 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-20T13:48:37.962149  / # #

    2023-09-20T13:48:38.062551  export SHELL=3D/bin/sh

    2023-09-20T13:48:38.062655  #

    2023-09-20T13:48:38.163057  / # export SHELL=3D/bin/sh. /lava-11579539/=
environment

    2023-09-20T13:48:38.163152  =


    2023-09-20T13:48:38.263745  / # . /lava-11579539/environment/lava-11579=
539/bin/lava-test-runner /lava-11579539/1

    2023-09-20T13:48:38.264696  =


    2023-09-20T13:48:38.276599  / # /lava-11579539/bin/lava-test-runner /la=
va-11579539/1

    2023-09-20T13:48:38.330424  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-20T13:48:38.331110  + cd /lav<8>[   16.408274] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11579539_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650af770c1b9fa35b08a0ac6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-ro=
ck-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650af770c1b9fa35b08a0acf
        failing since 26 days (last pass: v5.10.191, first fail: v5.10.190-=
136-gda59b7b5c515e)

    2023-09-20T13:45:09.719198  / # #

    2023-09-20T13:45:10.979000  export SHELL=3D/bin/sh

    2023-09-20T13:45:10.990016  #

    2023-09-20T13:45:10.990493  / # export SHELL=3D/bin/sh

    2023-09-20T13:45:12.732925  / # . /lava-11579541/environment

    2023-09-20T13:45:15.937124  /lava-11579541/bin/lava-test-runner /lava-1=
1579541/1

    2023-09-20T13:45:15.948148  . /lava-11579541/environment

    2023-09-20T13:45:15.950555  / # /lava-11579541/bin/lava-test-runner /la=
va-11579541/1

    2023-09-20T13:45:16.001492  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-20T13:45:16.001983  + cd /lava-11579541/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650af74ac1b9fa35b08a0a53

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
95-84-gf147286de8e5/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650af74ac1b9fa35b08a0a5c
        failing since 64 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-20T13:48:54.872011  / # #

    2023-09-20T13:48:54.972679  export SHELL=3D/bin/sh

    2023-09-20T13:48:54.973290  #

    2023-09-20T13:48:55.074522  / # export SHELL=3D/bin/sh. /lava-11579543/=
environment

    2023-09-20T13:48:55.075221  =


    2023-09-20T13:48:55.176657  / # . /lava-11579543/environment/lava-11579=
543/bin/lava-test-runner /lava-11579543/1

    2023-09-20T13:48:55.177716  =


    2023-09-20T13:48:55.186587  / # /lava-11579543/bin/lava-test-runner /la=
va-11579543/1

    2023-09-20T13:48:55.251415  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-20T13:48:55.251966  + cd /lava-1157954<8>[   18.284887] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11579543_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
