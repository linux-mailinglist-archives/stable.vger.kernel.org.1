Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97F879B562
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbjIKVQn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbjIKLcR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 07:32:17 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E492CDD
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 04:32:12 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68fc081cd46so717423b3a.0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 04:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694431931; x=1695036731; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FuiefvSCPMoU8/mexaFuqfbtQ5M44EsV7rTIa/8KwtI=;
        b=ySyHdO0+GiDoMSyHnpT3NLMjNk/3/G0b4HEAN8xUUA+dZXJDYs/HF+oE6Xk+X2LiWh
         tp2JmY4anGY9FCJzUSjnubwdmUvk3CNMZ4DdUJMGpvBVWA4enRIFXBjnSzVBi6VC793e
         dler7rPtx/UkT5zhF6QcVEY8R3Qqlkoh6s6GT/8lVJhBNPqP4bqeVWX54PcOOXRW39kL
         V6qdnhDa+w7KWb1qaiB+fod6lavqXd0G6TXopcRrEqkTACvZMdGvZ+gzYL/zTAiEYNn7
         a/Cdyq56vF3weKytYHtlRpTWrbGsEcQvAHZBHKoQIM3EeWQkNyPMJQu+64KrgZaX/CKF
         oDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694431931; x=1695036731;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FuiefvSCPMoU8/mexaFuqfbtQ5M44EsV7rTIa/8KwtI=;
        b=wl76dBKi7sqQQV3SU/Y1c0IkTHUG5TenDu3kw9A6heUdJ4OUk4u0e3bb2K3vFHLKoL
         GocsTk6mNN618XKZb9kov50Rp/khV401VwHidmgtSe/Kjc6MPxb2FbJHThoBSVZiU6Tw
         edLWxeKv8cls5yfLWPUcHE/+8Cm3W5pOSrN1zujUZAJUYh8KK7mg5dVbll+rs9PKRlVQ
         dfVg19pR5LsbsEXQ67LqndW7BYSe0gWhC/uvlThnElZ3rN32y8hLeWjua2596Kbm+Pdf
         0Am0BLCPxmiXCy6WsWTek1nUolsENF1oUncKpYYa7omEwci3xR9uPW+IQx2TDXL6qOFS
         F1JA==
X-Gm-Message-State: AOJu0YxMHW/FQ2S22StauD0RlCuL3QkAjWaWbU2EOjjALh0+a4xyZ8Ug
        XZ1+BbcyM17yfdDRn2fNz5yne7BQATrSLJxvIac=
X-Google-Smtp-Source: AGHT+IFbmEDDTNjoV7kb+2fMjNiOJa7U692EZqz6ka4vBmL9gXm4XkhNKm7LJfAJFIat3ixH22tL5Q==
X-Received: by 2002:a05:6a00:3183:b0:68f:cb1d:8371 with SMTP id bj3-20020a056a00318300b0068fcb1d8371mr1202373pfb.30.1694431931535;
        Mon, 11 Sep 2023 04:32:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k6-20020aa78206000000b006878f50d071sm5404662pfi.203.2023.09.11.04.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 04:32:11 -0700 (PDT)
Message-ID: <64fefabb.a70a0220.3934d.c222@mx.google.com>
Date:   Mon, 11 Sep 2023 04:32:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.52-601-g0d9da1076cc2
Subject: stable-rc/linux-6.1.y baseline: 100 runs,
 9 regressions (v6.1.52-601-g0d9da1076cc2)
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

stable-rc/linux-6.1.y baseline: 100 runs, 9 regressions (v6.1.52-601-g0d9da=
1076cc2)

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

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.52-601-g0d9da1076cc2/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.52-601-g0d9da1076cc2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      0d9da1076cc25b7a8a82a39ffc1719b5be735ee8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fed68a6b047a1428286d7d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g0d9da1076cc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g0d9da1076cc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fed68a6b047a1428286d86
        failing since 164 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-11T08:58:50.728744  <8>[   10.152796] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11492317_1.4.2.3.1>

    2023-09-11T08:58:50.731846  + set +x

    2023-09-11T08:58:50.836720  / # #

    2023-09-11T08:58:50.937393  export SHELL=3D/bin/sh

    2023-09-11T08:58:50.937596  #

    2023-09-11T08:58:51.038085  / # export SHELL=3D/bin/sh. /lava-11492317/=
environment

    2023-09-11T08:58:51.038333  =


    2023-09-11T08:58:51.138860  / # . /lava-11492317/environment/lava-11492=
317/bin/lava-test-runner /lava-11492317/1

    2023-09-11T08:58:51.139222  =


    2023-09-11T08:58:51.183726  / # /lava-11492317/bin/lava-test-runner /la=
va-11492317/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fef0bc5f242d8c8e286d6f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g0d9da1076cc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g0d9da1076cc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fef0bc5f242d8c8e286d78
        failing since 164 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-11T10:49:33.744446  + set<8>[   11.475922] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11492283_1.4.2.3.1>

    2023-09-11T10:49:33.744900   +x

    2023-09-11T10:49:33.853580  / # #

    2023-09-11T10:49:33.956036  export SHELL=3D/bin/sh

    2023-09-11T10:49:33.956783  #

    2023-09-11T10:49:34.058430  / # export SHELL=3D/bin/sh. /lava-11492283/=
environment

    2023-09-11T10:49:34.059167  =


    2023-09-11T10:49:34.160564  / # . /lava-11492283/environment/lava-11492=
283/bin/lava-test-runner /lava-11492283/1

    2023-09-11T10:49:34.161877  =


    2023-09-11T10:49:34.166201  / # /lava-11492283/bin/lava-test-runner /la=
va-11492283/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64feede31c5905edd4286dc7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g0d9da1076cc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g0d9da1076cc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64feede31c5905edd4286dd0
        failing since 164 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-11T10:36:59.701641  <8>[   10.338912] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11492298_1.4.2.3.1>

    2023-09-11T10:36:59.702170  + set +x

    2023-09-11T10:36:59.810055  / # #

    2023-09-11T10:36:59.912249  export SHELL=3D/bin/sh

    2023-09-11T10:36:59.912685  #

    2023-09-11T10:37:00.013563  / # export SHELL=3D/bin/sh. /lava-11492298/=
environment

    2023-09-11T10:37:00.014398  =


    2023-09-11T10:37:00.116297  / # . /lava-11492298/environment/lava-11492=
298/bin/lava-test-runner /lava-11492298/1

    2023-09-11T10:37:00.117426  =


    2023-09-11T10:37:00.123070  / # /lava-11492298/bin/lava-test-runner /la=
va-11492298/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fee078454a8a1368286d78

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g0d9da1076cc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g0d9da1076cc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fee078454a8a1368286d81
        failing since 164 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-11T09:41:19.280174  + set +x

    2023-09-11T09:41:19.286867  <8>[   10.373610] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11492316_1.4.2.3.1>

    2023-09-11T09:41:19.395305  / # #

    2023-09-11T09:41:19.497684  export SHELL=3D/bin/sh

    2023-09-11T09:41:19.498405  #

    2023-09-11T09:41:19.599744  / # export SHELL=3D/bin/sh. /lava-11492316/=
environment

    2023-09-11T09:41:19.600556  =


    2023-09-11T09:41:19.702049  / # . /lava-11492316/environment/lava-11492=
316/bin/lava-test-runner /lava-11492316/1

    2023-09-11T09:41:19.703251  =


    2023-09-11T09:41:19.708526  / # /lava-11492316/bin/lava-test-runner /la=
va-11492316/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64fed7b8df21125aea286d6c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g0d9da1076cc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g0d9da1076cc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fed7b8df21125aea286d75
        failing since 164 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-11T09:02:50.554490  + <8>[   11.541135] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11492293_1.4.2.3.1>

    2023-09-11T09:02:50.554579  set +x

    2023-09-11T09:02:50.658846  / # #

    2023-09-11T09:02:50.759566  export SHELL=3D/bin/sh

    2023-09-11T09:02:50.759808  #

    2023-09-11T09:02:50.860406  / # export SHELL=3D/bin/sh. /lava-11492293/=
environment

    2023-09-11T09:02:50.860615  =


    2023-09-11T09:02:50.961134  / # . /lava-11492293/environment/lava-11492=
293/bin/lava-test-runner /lava-11492293/1

    2023-09-11T09:02:50.961432  =


    2023-09-11T09:02:50.965842  / # /lava-11492293/bin/lava-test-runner /la=
va-11492293/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64feebc646040cf83f286d71

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g0d9da1076cc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g0d9da1076cc2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64feebc646040cf83f286d7a
        failing since 164 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-11T10:28:11.074704  <8>[   11.859766] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11492324_1.4.2.3.1>

    2023-09-11T10:28:11.182218  / # #

    2023-09-11T10:28:11.284199  export SHELL=3D/bin/sh

    2023-09-11T10:28:11.284504  #

    2023-09-11T10:28:11.385207  / # export SHELL=3D/bin/sh. /lava-11492324/=
environment

    2023-09-11T10:28:11.385384  =


    2023-09-11T10:28:11.485895  / # . /lava-11492324/environment/lava-11492=
324/bin/lava-test-runner /lava-11492324/1

    2023-09-11T10:28:11.486158  =


    2023-09-11T10:28:11.491032  / # /lava-11492324/bin/lava-test-runner /la=
va-11492324/1

    2023-09-11T10:28:11.497458  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64fecfb5166b823686286d7c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g0d9da1076cc2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g0d9da1076cc2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fecfb5166b823686286d85
        failing since 55 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-11T08:32:38.293752  / # #

    2023-09-11T08:32:38.394584  export SHELL=3D/bin/sh

    2023-09-11T08:32:38.394948  #

    2023-09-11T08:32:38.495522  / # export SHELL=3D/bin/sh. /lava-11492339/=
environment

    2023-09-11T08:32:38.495746  =


    2023-09-11T08:32:38.596275  / # . /lava-11492339/environment/lava-11492=
339/bin/lava-test-runner /lava-11492339/1

    2023-09-11T08:32:38.596551  =


    2023-09-11T08:32:38.607020  / # /lava-11492339/bin/lava-test-runner /la=
va-11492339/1

    2023-09-11T08:32:38.660786  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-11T08:32:38.660873  + cd /lav<8>[   19.141873] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11492339_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64fed0ed948a41c669286db4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g0d9da1076cc2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g0d9da1076cc2/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fed0ed948a41c669286dbd
        failing since 55 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-11T08:33:21.174164  / # #

    2023-09-11T08:33:22.252633  export SHELL=3D/bin/sh

    2023-09-11T08:33:22.254357  #

    2023-09-11T08:33:23.743873  / # export SHELL=3D/bin/sh. /lava-11492337/=
environment

    2023-09-11T08:33:23.745618  =


    2023-09-11T08:33:26.467704  / # . /lava-11492337/environment/lava-11492=
337/bin/lava-test-runner /lava-11492337/1

    2023-09-11T08:33:26.470070  =


    2023-09-11T08:33:26.483892  / # /lava-11492337/bin/lava-test-runner /la=
va-11492337/1

    2023-09-11T08:33:26.537005  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-11T08:33:26.537535  + cd /lava-114923<8>[   28.537609] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11492337_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64fed1338e6aaec034286d7a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g0d9da1076cc2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g0d9da1076cc2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64fed1338e6aaec034286d83
        failing since 55 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-11T08:39:12.149853  / # #

    2023-09-11T08:39:12.250332  export SHELL=3D/bin/sh

    2023-09-11T08:39:12.250503  #

    2023-09-11T08:39:12.350984  / # export SHELL=3D/bin/sh. /lava-11492332/=
environment

    2023-09-11T08:39:12.351214  =


    2023-09-11T08:39:12.451675  / # . /lava-11492332/environment/lava-11492=
332/bin/lava-test-runner /lava-11492332/1

    2023-09-11T08:39:12.452004  =


    2023-09-11T08:39:12.463634  / # /lava-11492332/bin/lava-test-runner /la=
va-11492332/1

    2023-09-11T08:39:12.535923  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-11T08:39:12.536041  + cd /lava-11492332/1/tests/1_boot<8>[   16=
.978038] <LAVA_SIGNAL_STARTRUN 1_bootrr 11492332_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
