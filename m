Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A39879AD17
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344282AbjIKVNt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244290AbjIKT4V (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 15:56:21 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7092A125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 12:56:16 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68fb46f38f9so1546636b3a.1
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 12:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694462175; x=1695066975; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FJG1kxijo3whYqYBcFs44vQsM7HpPVX1ApH1lg/bMc4=;
        b=tc0k4XvQsBuB/OxRKA4deZucdOdhF4GL86ADdRVCXCC8k9zo9Ude8fwKTPUTqScs78
         xgcH/D9UWWBia5MiOEX895Np7KK4acVFXjRouYTPJisKSQbgtBLKkXwdpzCD5/YoyK57
         zTxqH4l4NSMKGwmf1jxS78xNYm6J+7NYAMmd5jrRSaELn0JDPIvumkGYXXZBnwgL45oi
         NHLRmhF5m5Y+NOjj/uv4UqDngoKPy0btZKA6ucmDCg+f4uXlmtzktjvH//292zn+BKY8
         iIzrpZOEPFPBm7hBfGKX/A+9YLcxQqACOjm2gzY6nJWdM6BPSiwr1OMBWg2cW1UIhWDU
         0dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694462175; x=1695066975;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJG1kxijo3whYqYBcFs44vQsM7HpPVX1ApH1lg/bMc4=;
        b=jJ7FYITXeHi/ha0MrsbiyguqvMFv3kyabx70G5ttnmVXgGqG5vYWMww4vv67DS7G54
         aHBN0H92FgIUEp8dzHA8YKFdhfJBFfjpb1o+XFfaxp+J3cDt3/ksq4a1Xiih42Dd8zm0
         iddPwJmL7L17blWkzmYg9Knv4yxgf/8BCXNxW0cRUb5cymxqsukri64mjuLB6ta7XZJG
         J+2/Z+JDxQeZMs1Y3gNVuv7Vz82vWZxy7KfmVbtFh1RsbFhT/odJqiu+HvmLb+DRtSih
         jql3c/xrwSQyZeeI3SA2lSfC0K1TINoIMuLo9x8OkPxOijY4UOBLNftjHblAgMXk9BVG
         ixRQ==
X-Gm-Message-State: AOJu0YzKsj+W6oriGKo9Mp70T4i4PB9IC2p9psmAr1BH79NxSvx+C86J
        A7fAkNHhNYE3X2soTxLDlz4YU3XmfpvsTQLdmCQ=
X-Google-Smtp-Source: AGHT+IG9I6moR29z0lP/+AiAb2OZJWYYF3RUWQch7ZLBzadO5DA1LepdxMBtdznOPvq5XPxz5y/sRA==
X-Received: by 2002:a05:6a00:2386:b0:68b:f529:a329 with SMTP id f6-20020a056a00238600b0068bf529a329mr9989220pfc.5.1694462175386;
        Mon, 11 Sep 2023 12:56:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78551000000b006878cc942f1sm1113636pfn.54.2023.09.11.12.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 12:56:14 -0700 (PDT)
Message-ID: <64ff70de.a70a0220.36bc2.4627@mx.google.com>
Date:   Mon, 11 Sep 2023 12:56:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.52-601-g6e71673725ca
Subject: stable-rc/linux-6.1.y baseline: 117 runs,
 9 regressions (v6.1.52-601-g6e71673725ca)
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

stable-rc/linux-6.1.y baseline: 117 runs, 9 regressions (v6.1.52-601-g6e716=
73725ca)

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
el/v6.1.52-601-g6e71673725ca/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.52-601-g6e71673725ca
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6e71673725ca14f97b45c5aeeceb462e3cafc16a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff3bfb7b4650431d286e53

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g6e71673725ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g6e71673725ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff3bfb7b4650431d286e5c
        failing since 165 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-11T16:10:23.136879  + set +x

    2023-09-11T16:10:23.143836  <8>[   10.849026] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11496817_1.4.2.3.1>

    2023-09-11T16:10:23.252174  #

    2023-09-11T16:10:23.253378  =


    2023-09-11T16:10:23.355231  / # #export SHELL=3D/bin/sh

    2023-09-11T16:10:23.355987  =


    2023-09-11T16:10:23.457489  / # export SHELL=3D/bin/sh. /lava-11496817/=
environment

    2023-09-11T16:10:23.458270  =


    2023-09-11T16:10:23.559809  / # . /lava-11496817/environment/lava-11496=
817/bin/lava-test-runner /lava-11496817/1

    2023-09-11T16:10:23.561020  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff3a2b3dffee59c5286dc8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g6e71673725ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g6e71673725ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff3a2b3dffee59c5286dd1
        failing since 165 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-11T16:02:42.722317  + set<8>[   11.874083] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11496833_1.4.2.3.1>

    2023-09-11T16:02:42.722894   +x

    2023-09-11T16:02:42.831373  / # #

    2023-09-11T16:02:42.933934  export SHELL=3D/bin/sh

    2023-09-11T16:02:42.934784  #

    2023-09-11T16:02:43.036472  / # export SHELL=3D/bin/sh. /lava-11496833/=
environment

    2023-09-11T16:02:43.037255  =


    2023-09-11T16:02:43.138713  / # . /lava-11496833/environment/lava-11496=
833/bin/lava-test-runner /lava-11496833/1

    2023-09-11T16:02:43.140050  =


    2023-09-11T16:02:43.144759  / # /lava-11496833/bin/lava-test-runner /la=
va-11496833/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff3a34a7c3986252286dbd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g6e71673725ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g6e71673725ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff3a34a7c3986252286dc6
        failing since 165 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-11T16:02:42.588635  <8>[    8.256119] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11496838_1.4.2.3.1>

    2023-09-11T16:02:42.592046  + set +x

    2023-09-11T16:02:42.698113  =


    2023-09-11T16:02:42.800267  / # #export SHELL=3D/bin/sh

    2023-09-11T16:02:42.801055  =


    2023-09-11T16:02:42.902841  / # export SHELL=3D/bin/sh. /lava-11496838/=
environment

    2023-09-11T16:02:42.903635  =


    2023-09-11T16:02:43.005307  / # . /lava-11496838/environment/lava-11496=
838/bin/lava-test-runner /lava-11496838/1

    2023-09-11T16:02:43.006598  =


    2023-09-11T16:02:43.012523  / # /lava-11496838/bin/lava-test-runner /la=
va-11496838/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff3b605f2d21d676286da9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g6e71673725ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g6e71673725ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff3b605f2d21d676286db2
        failing since 165 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-11T16:09:15.002122  + set +x

    2023-09-11T16:09:15.008610  <8>[   10.756438] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11496812_1.4.2.3.1>

    2023-09-11T16:09:15.116362  / # #

    2023-09-11T16:09:15.218745  export SHELL=3D/bin/sh

    2023-09-11T16:09:15.219539  #

    2023-09-11T16:09:15.321094  / # export SHELL=3D/bin/sh. /lava-11496812/=
environment

    2023-09-11T16:09:15.321872  =


    2023-09-11T16:09:15.423448  / # . /lava-11496812/environment/lava-11496=
812/bin/lava-test-runner /lava-11496812/1

    2023-09-11T16:09:15.424561  =


    2023-09-11T16:09:15.430298  / # /lava-11496812/bin/lava-test-runner /la=
va-11496812/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff3a27fb62caebb8286dae

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g6e71673725ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g6e71673725ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff3a27fb62caebb8286db7
        failing since 165 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-11T16:02:47.541151  + set<8>[   11.120860] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11496830_1.4.2.3.1>

    2023-09-11T16:02:47.541576   +x

    2023-09-11T16:02:47.648315  / # #

    2023-09-11T16:02:47.749124  export SHELL=3D/bin/sh

    2023-09-11T16:02:47.749799  #

    2023-09-11T16:02:47.851087  / # export SHELL=3D/bin/sh. /lava-11496830/=
environment

    2023-09-11T16:02:47.851813  =


    2023-09-11T16:02:47.953248  / # . /lava-11496830/environment/lava-11496=
830/bin/lava-test-runner /lava-11496830/1

    2023-09-11T16:02:47.954324  =


    2023-09-11T16:02:47.959315  / # /lava-11496830/bin/lava-test-runner /la=
va-11496830/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff3a18fb62caebb8286d7e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g6e71673725ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g6e71673725ca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff3a18fb62caebb8286d87
        failing since 165 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-09-11T16:02:21.925530  <8>[   11.377023] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11496798_1.4.2.3.1>

    2023-09-11T16:02:22.033487  / # #

    2023-09-11T16:02:22.135645  export SHELL=3D/bin/sh

    2023-09-11T16:02:22.135879  #

    2023-09-11T16:02:22.236399  / # export SHELL=3D/bin/sh. /lava-11496798/=
environment

    2023-09-11T16:02:22.236600  =


    2023-09-11T16:02:22.337210  / # . /lava-11496798/environment/lava-11496=
798/bin/lava-test-runner /lava-11496798/1

    2023-09-11T16:02:22.337463  =


    2023-09-11T16:02:22.342563  / # /lava-11496798/bin/lava-test-runner /la=
va-11496798/1

    2023-09-11T16:02:22.349225  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff3be67b4650431d286e0e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g6e71673725ca/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g6e71673725ca/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff3be67b4650431d286e17
        failing since 55 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-11T16:14:13.885758  / # #

    2023-09-11T16:14:13.986503  export SHELL=3D/bin/sh

    2023-09-11T16:14:13.986739  #

    2023-09-11T16:14:14.087431  / # export SHELL=3D/bin/sh. /lava-11496891/=
environment

    2023-09-11T16:14:14.087656  =


    2023-09-11T16:14:14.188308  / # . /lava-11496891/environment/lava-11496=
891/bin/lava-test-runner /lava-11496891/1

    2023-09-11T16:14:14.188593  =


    2023-09-11T16:14:14.199880  / # /lava-11496891/bin/lava-test-runner /la=
va-11496891/1

    2023-09-11T16:14:14.253679  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-11T16:14:14.254141  + cd /lav<8>[   19.089918] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11496891_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff3c025b2478988f286da2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g6e71673725ca/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g6e71673725ca/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ff3c025b2478988f286=
da3
        new failure (last pass: v6.1.52-601-g0d9da1076cc2) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ff3be55b2478988f286d6c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g6e71673725ca/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.52-=
601-g6e71673725ca/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ff3be55b2478988f286d75
        failing since 55 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-09-11T16:14:27.325525  / # #

    2023-09-11T16:14:27.426446  export SHELL=3D/bin/sh

    2023-09-11T16:14:27.426790  #

    2023-09-11T16:14:27.527395  / # export SHELL=3D/bin/sh. /lava-11496887/=
environment

    2023-09-11T16:14:27.527733  =


    2023-09-11T16:14:27.628283  / # . /lava-11496887/environment/lava-11496=
887/bin/lava-test-runner /lava-11496887/1

    2023-09-11T16:14:27.628599  =


    2023-09-11T16:14:27.638494  / # /lava-11496887/bin/lava-test-runner /la=
va-11496887/1

    2023-09-11T16:14:27.709538  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-11T16:14:27.709649  + cd /lava-1149688<8>[   18.731691] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11496887_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
