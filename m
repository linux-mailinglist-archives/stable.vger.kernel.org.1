Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C215E79080E
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 15:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjIBNJg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 09:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjIBNJg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 09:09:36 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59EE93
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 06:09:31 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf48546ccfso19029135ad.2
        for <stable@vger.kernel.org>; Sat, 02 Sep 2023 06:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693660171; x=1694264971; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yolNq63cTWbFLIXAtk+9igaf3SwyZXk9pjyNGkEglAo=;
        b=m9tTTdRC2tt2Svh5+JbnRZGcA/4iHLL9Xd44+0ZyYXnxxwjxj97wlYwrOJlCnSjG2N
         nwc/75OpKBw7jVfZwurvfwa2xvA7RVzMXaI1ITHB/EVwg1bmGtpHzpvR4latnYwdHuEr
         ArEA3SSCv3FAUqqzKnvX4MosBt5fNQ9mSyK6eaSlofmMnpdiuL5pPF1gUp09G/fr/kCZ
         5z+JpQjjvzwvtlTLLKu8fCjQYeRASfxAH/oCZN+HD6EcbSnjC3YHdvbJnAoCzpo0TlI6
         1JzdyCQRoEiO//3TrgbkzH+KYt90uxHCtv4hVCQ1igo1fToBGOPmHpRNgs/HsKC5JNY5
         Dfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693660171; x=1694264971;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yolNq63cTWbFLIXAtk+9igaf3SwyZXk9pjyNGkEglAo=;
        b=bncZzAJ2aisxlkmO8boutIwx0AqmznTH7dlq4yOGHVwNosRnX9d936h16WOi/XM2xB
         dPq+aJ8ySkhgXPvOWyMWnrPN62HxSjA3HTgO88vaoh+lLFF/qY+EetKpnEjE/JjUWH0L
         jjImsbtRDAsZPsSZD5lgEzXz51/DfOFV7SZJl92moHBLPmer0EC8rdXf1SI5Gpad3fhv
         dbHnhGwrFUHqDQxpGWdVfQK1LuDHxKsDct2lumAu6550Zv/jTdSDz7UPaxjR+Ppmx7bq
         DT2Uo87Gqg5zhfM4AEqUuPBJNgjwo8QZ5abvDs4pHIGzlRjbTZzZiMu/3xQCbZXrralA
         B4Vw==
X-Gm-Message-State: AOJu0YzcNJFHKOzXsA2eLeUjnA3qP4ZsIiF0w+eHmrLB+G5gTIhiQesr
        2M4OaSiLx1ulMlemCHFPmI5dw8+QLBS86Ckw/4o=
X-Google-Smtp-Source: AGHT+IGMZjVknKAXpHgN/g+RmoZrHyFcr/nGYVtIUGfq/QOWoKVdvGSfIEdHS/6aFsuTXOWxICNnkQ==
X-Received: by 2002:a17:903:120d:b0:1c0:c3cc:d12a with SMTP id l13-20020a170903120d00b001c0c3ccd12amr5554279plh.20.1693660170691;
        Sat, 02 Sep 2023 06:09:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bd10-20020a170902830a00b001bd99fd1114sm4622596plb.288.2023.09.02.06.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 06:09:30 -0700 (PDT)
Message-ID: <64f3340a.170a0220.ce1c5.9342@mx.google.com>
Date:   Sat, 02 Sep 2023 06:09:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.194
Subject: stable-rc/linux-5.10.y baseline: 126 runs, 13 regressions (v5.10.194)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 126 runs, 13 regressions (v5.10.194)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre  | gcc-10   | defconfi=
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

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.194/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.194
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      006d5847646be8d430ae201c445afa93f08c8e52 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64f301d0f13d833f1e286d6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f301d0f13d833f1e286d76
        failing since 227 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-09-02T09:35:05.488742  + set +x<8>[   11.106784] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3760637_1.5.2.4.1>
    2023-09-02T09:35:05.489312  =

    2023-09-02T09:35:05.599397  / # #
    2023-09-02T09:35:05.703135  export SHELL=3D/bin/sh
    2023-09-02T09:35:05.704499  #
    2023-09-02T09:35:05.806971  / # export SHELL=3D/bin/sh. /lava-3760637/e=
nvironment
    2023-09-02T09:35:05.807934  =

    2023-09-02T09:35:05.910133  / # . /lava-3760637/environment/lava-376063=
7/bin/lava-test-runner /lava-3760637/1
    2023-09-02T09:35:05.911877  =

    2023-09-02T09:35:05.916411  / # /lava-3760637/bin/lava-test-runner /lav=
a-3760637/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls2088a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f3025fd0a33a068b286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f3025fd0a33a068b286d6f
        failing since 46 days (last pass: v5.10.142, first fail: v5.10.186-=
332-gf98a4d3a5cec)

    2023-09-02T09:37:09.957556  [    9.978065] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1248884_1.5.2.4.1>
    2023-09-02T09:37:10.063498  =

    2023-09-02T09:37:10.165106  / # #export SHELL=3D/bin/sh
    2023-09-02T09:37:10.165613  =

    2023-09-02T09:37:10.266621  / # export SHELL=3D/bin/sh. /lava-1248884/e=
nvironment
    2023-09-02T09:37:10.267063  =

    2023-09-02T09:37:10.368050  / # . /lava-1248884/environment/lava-124888=
4/bin/lava-test-runner /lava-1248884/1
    2023-09-02T09:37:10.368745  =

    2023-09-02T09:37:10.373043  / # /lava-1248884/bin/lava-test-runner /lav=
a-1248884/1
    2023-09-02T09:37:10.386988  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f300d4603facf198286dc0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f300d4603facf198286dc9
        failing since 157 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-02T09:30:36.257307  + set +x

    2023-09-02T09:30:36.264096  <8>[   14.985507] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11410298_1.4.2.3.1>

    2023-09-02T09:30:36.368245  / # #

    2023-09-02T09:30:36.468842  export SHELL=3D/bin/sh

    2023-09-02T09:30:36.469054  #

    2023-09-02T09:30:36.569539  / # export SHELL=3D/bin/sh. /lava-11410298/=
environment

    2023-09-02T09:30:36.569766  =


    2023-09-02T09:30:36.670321  / # . /lava-11410298/environment/lava-11410=
298/bin/lava-test-runner /lava-11410298/1

    2023-09-02T09:30:36.670672  =


    2023-09-02T09:30:36.674883  / # /lava-11410298/bin/lava-test-runner /la=
va-11410298/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64f300b655ebb91525286d6d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f300b655ebb91525286d76
        failing since 157 days (last pass: v5.10.176, first fail: v5.10.176=
-105-g18265b240021)

    2023-09-02T09:30:20.163829  + set +x<8>[   11.701820] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11410280_1.4.2.3.1>

    2023-09-02T09:30:20.163952  =


    2023-09-02T09:30:20.265947  #

    2023-09-02T09:30:20.366890  / # #export SHELL=3D/bin/sh

    2023-09-02T09:30:20.367181  =


    2023-09-02T09:30:20.467782  / # export SHELL=3D/bin/sh. /lava-11410280/=
environment

    2023-09-02T09:30:20.468025  =


    2023-09-02T09:30:20.568584  / # . /lava-11410280/environment/lava-11410=
280/bin/lava-test-runner /lava-11410280/1

    2023-09-02T09:30:20.568963  =


    2023-09-02T09:30:20.573529  / # /lava-11410280/bin/lava-test-runner /la=
va-11410280/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f3026ad0a33a068b286d79

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f3026ad0a33a068b286db9
        failing since 1 day (last pass: v5.10.192-85-gc40f751018f92, first =
fail: v5.10.193-12-ge25611a229ff9)

    2023-09-02T09:37:25.591147  / # #
    2023-09-02T09:37:25.694109  export SHELL=3D/bin/sh
    2023-09-02T09:37:25.694886  #
    2023-09-02T09:37:25.796762  / # export SHELL=3D/bin/sh. /lava-83967/env=
ironment
    2023-09-02T09:37:25.797529  =

    2023-09-02T09:37:25.899507  / # . /lava-83967/environment/lava-83967/bi=
n/lava-test-runner /lava-83967/1
    2023-09-02T09:37:25.900757  =

    2023-09-02T09:37:25.914158  / # /lava-83967/bin/lava-test-runner /lava-=
83967/1
    2023-09-02T09:37:25.973952  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-02T09:37:25.974484  + cd /lava-83967/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f303485448009734286d8e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12b-a311d-khadas-vim=
3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12b-a311d-khadas-vim=
3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64f303485448009734286=
d8f
        new failure (last pass: v5.10.193-12-ge25611a229ff9) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f30767fd354ae329286d89

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774a1-hihope=
-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f30767fd354ae329286d8c
        failing since 46 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-02T09:58:45.382697  + set +x
    2023-09-02T09:58:45.383256  <8>[   83.850703] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1004288_1.5.2.4.1>
    2023-09-02T09:58:45.491537  / # #
    2023-09-02T09:58:46.963364  export SHELL=3D/bin/sh
    2023-09-02T09:58:46.984593  #
    2023-09-02T09:58:46.985197  / # export SHELL=3D/bin/sh
    2023-09-02T09:58:48.951431  / # . /lava-1004288/environment
    2023-09-02T09:58:52.569213  /lava-1004288/bin/lava-test-runner /lava-10=
04288/1
    2023-09-02T09:58:52.591172  . /lava-1004288/environment
    2023-09-02T09:58:52.591598  / # /lava-1004288/bin/lava-test-runner /lav=
a-1004288/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f305007497b2a621286d83

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope=
-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope=
-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f305007497b2a621286d86
        failing since 46 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-02T09:48:15.702952  + set +x
    2023-09-02T09:48:15.703168  <8>[   84.136545] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1004283_1.5.2.4.1>
    2023-09-02T09:48:15.808402  / # #
    2023-09-02T09:48:17.268693  export SHELL=3D/bin/sh
    2023-09-02T09:48:17.289165  #
    2023-09-02T09:48:17.289285  / # export SHELL=3D/bin/sh
    2023-09-02T09:48:19.242630  / # . /lava-1004283/environment
    2023-09-02T09:48:22.838613  /lava-1004283/bin/lava-test-runner /lava-10=
04283/1
    2023-09-02T09:48:22.859656  . /lava-1004283/environment
    2023-09-02T09:48:22.859848  / # /lava-1004283/bin/lava-test-runner /lav=
a-1004283/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f30280d0a33a068b286dc2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f30280d0a33a068b286dc5
        failing since 46 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-02T09:37:46.467252  / # #
    2023-09-02T09:37:47.926707  export SHELL=3D/bin/sh
    2023-09-02T09:37:47.947164  #
    2023-09-02T09:37:47.947285  / # export SHELL=3D/bin/sh
    2023-09-02T09:37:49.899441  / # . /lava-1004273/environment
    2023-09-02T09:37:53.492914  /lava-1004273/bin/lava-test-runner /lava-10=
04273/1
    2023-09-02T09:37:53.513474  . /lava-1004273/environment
    2023-09-02T09:37:53.513572  / # /lava-1004273/bin/lava-test-runner /lav=
a-1004273/1
    2023-09-02T09:37:53.591653  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-02T09:37:53.591823  + cd /lava-1004273/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64f303d7fda7774942286ea2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f303d7fda7774942286ea5
        failing since 46 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-02T09:43:15.690117  / # #
    2023-09-02T09:43:17.150879  export SHELL=3D/bin/sh
    2023-09-02T09:43:17.171461  #
    2023-09-02T09:43:17.171673  / # export SHELL=3D/bin/sh
    2023-09-02T09:43:19.124898  / # . /lava-1004287/environment
    2023-09-02T09:43:22.719431  /lava-1004287/bin/lava-test-runner /lava-10=
04287/1
    2023-09-02T09:43:22.740144  . /lava-1004287/environment
    2023-09-02T09:43:22.740273  / # /lava-1004287/bin/lava-test-runner /lav=
a-1004287/1
    2023-09-02T09:43:22.819200  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-02T09:43:22.819506  + cd /lava-1004287/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f32dfee12b05d0e0286d73

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f32dfee12b05d0e0286d7c
        failing since 46 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-02T12:44:58.070301  / # #

    2023-09-02T12:44:58.172407  export SHELL=3D/bin/sh

    2023-09-02T12:44:58.173142  #

    2023-09-02T12:44:58.274551  / # export SHELL=3D/bin/sh. /lava-11410397/=
environment

    2023-09-02T12:44:58.275244  =


    2023-09-02T12:44:58.376679  / # . /lava-11410397/environment/lava-11410=
397/bin/lava-test-runner /lava-11410397/1

    2023-09-02T12:44:58.377786  =


    2023-09-02T12:44:58.379843  / # /lava-11410397/bin/lava-test-runner /la=
va-11410397/1

    2023-09-02T12:44:58.443490  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-02T12:44:58.443998  + cd /lav<8>[   16.466563] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11410397_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f301df7ca4211b1a286e0a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f301df7ca4211b1a286e13
        failing since 8 days (last pass: v5.10.191, first fail: v5.10.190-1=
36-gda59b7b5c515e)

    2023-09-02T09:36:38.408767  / # #

    2023-09-02T09:36:39.670151  export SHELL=3D/bin/sh

    2023-09-02T09:36:39.681117  #

    2023-09-02T09:36:39.681596  / # export SHELL=3D/bin/sh

    2023-09-02T09:36:41.425651  / # . /lava-11410390/environment

    2023-09-02T09:36:44.631371  /lava-11410390/bin/lava-test-runner /lava-1=
1410390/1

    2023-09-02T09:36:44.642899  . /lava-11410390/environment

    2023-09-02T09:36:44.643231  / # /lava-11410390/bin/lava-test-runner /la=
va-11410390/1

    2023-09-02T09:36:44.698685  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-02T09:36:44.699174  + cd /lava-11410390/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64f301d97ca4211b1a286dde

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
94/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64f301d97ca4211b1a286de7
        failing since 46 days (last pass: v5.10.186-221-gf178eace6e074, fir=
st fail: v5.10.186-332-gf98a4d3a5cec)

    2023-09-02T09:36:48.336033  / # #

    2023-09-02T09:36:48.438149  export SHELL=3D/bin/sh

    2023-09-02T09:36:48.438849  #

    2023-09-02T09:36:48.540153  / # export SHELL=3D/bin/sh. /lava-11410396/=
environment

    2023-09-02T09:36:48.540863  =


    2023-09-02T09:36:48.642336  / # . /lava-11410396/environment/lava-11410=
396/bin/lava-test-runner /lava-11410396/1

    2023-09-02T09:36:48.643469  =


    2023-09-02T09:36:48.660111  / # /lava-11410396/bin/lava-test-runner /la=
va-11410396/1

    2023-09-02T09:36:48.718156  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-02T09:36:48.718655  + cd /lava-1141039<8>[   18.278871] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11410396_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
