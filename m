Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7386F1978
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 15:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjD1N3e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 09:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjD1N3d (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 09:29:33 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2F9B9
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 06:29:32 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-247296def99so6797483a91.1
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 06:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682688572; x=1685280572;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5nnR3MwlXXXNm7Ayi4DWuS1hvr9Kpu32p3FpgCZ/hF0=;
        b=GdRMVTMmB4mqzZm5n/8TqWm1L8k4Y45UL4fn+ECEV2K4waz76j2kPurWw2i6Se1UiS
         mlzE2UiAxbBH4C9AWoo73M2zbciaLsjlBguZG8T22lOytVg1te6izu0DTsQIlX6Bn+8U
         Tc3lGRqCGVU1YFyUJGIT1u5LO9H1fdStQkP6AqeFsGjJQ1jnoQuF9hna3HFrnuQwC8bH
         4fqP2ptXdayv91AEsed5eS3XPwI8YqT47PaYGgtfAOu+89iZqgt/JEOjvWwSlNnh0Jig
         lbnSBFE0cHw9XuqhTLkgif+DIXhDuVLWo3Ee9yQu20mluuGzHyy97NSYqzkSxSRyGpWr
         j6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682688572; x=1685280572;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nnR3MwlXXXNm7Ayi4DWuS1hvr9Kpu32p3FpgCZ/hF0=;
        b=R990+3fMt0tlrsVlw2gd88hdq3JnIRdFTpER43a4SepYTeZH0dJem7gl2N8VjhUBRd
         BqWj6sGtDLqA2uz8eTnEda/hOQ6tXBR0Qm6XkNUJ9tdFziI2jejlZJZPlwVQNNJYyO54
         FqvMMHkXYLO/s+OVcihCiyZX/CFpyxUxhs5E0h4wCfEQt0COAhooKDA/xxoJGXuWNFPf
         8/ugnXmThppOb5BxMZFAhkfvIBi19SPTpFwaErLr9DfrtfZ6fP5zEz4ObVDdsSrdCZth
         t9b0/RVaRTjkJGtIWDady9tFV2rsmo/aPWO5NT3wCnhtftKv2T4w+f+vSKoJvWrozSIa
         sRsg==
X-Gm-Message-State: AC+VfDwkN4bF5Kh0GJtS066vTxFfMkDfbhMkftOskF4lWbbiXhzNq5Rf
        26QkLcBWsFvXsX5JukJmZ01NBZnFtP7M/MVgmqc=
X-Google-Smtp-Source: ACHHUZ7Z+kjLEzlOvz0GfzGJA7pmmuxUlsq7DgugYPsrq9Fp4m+haQuec+CUHgK2F+xmcfUa0L3WCw==
X-Received: by 2002:a17:90b:1d8b:b0:246:b450:cafe with SMTP id pf11-20020a17090b1d8b00b00246b450cafemr5534718pjb.30.1682688571757;
        Fri, 28 Apr 2023 06:29:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id om12-20020a17090b3a8c00b002405d3bbe42sm15032664pjb.0.2023.04.28.06.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 06:29:30 -0700 (PDT)
Message-ID: <644bca3a.170a0220.36740.fe4a@mx.google.com>
Date:   Fri, 28 Apr 2023 06:29:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.279-177-g91ed867e7ad5
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-4.19.y baseline: 102 runs,
 3 regressions (v4.19.279-177-g91ed867e7ad5)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-4.19.y baseline: 102 runs, 3 regressions (v4.19.279-177-g91=
ed867e7ad5)

Regressions Summary
-------------------

platform   | arch | lab          | compiler | defconfig             | regre=
ssions
-----------+------+--------------+----------+-----------------------+------=
------
cubietruck | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig    | 1    =
      =

da850-lcdk | arm  | lab-baylibre | gcc-10   | davinci_all_defconfig | 2    =
      =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.279-177-g91ed867e7ad5/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.279-177-g91ed867e7ad5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      91ed867e7ad5722ce0b10b9faf0f527227048f37 =



Test Regressions
---------------- =



platform   | arch | lab          | compiler | defconfig             | regre=
ssions
-----------+------+--------------+----------+-----------------------+------=
------
cubietruck | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig    | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/644b8fd474684317712e85ea

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
79-177-g91ed867e7ad5/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
79-177-g91ed867e7ad5/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b8fd474684317712e85ef
        failing since 101 days (last pass: v4.19.268-50-gbf741d1d7e6d, firs=
t fail: v4.19.269-522-gc75d2b5524ab)

    2023-04-28T09:20:05.369736  <8>[    7.328704] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3540116_1.5.2.4.1>
    2023-04-28T09:20:05.479040  / # #
    2023-04-28T09:20:05.580543  export SHELL=3D/bin/sh
    2023-04-28T09:20:05.581590  #
    2023-04-28T09:20:05.683763  / # export SHELL=3D/bin/sh. /lava-3540116/e=
nvironment
    2023-04-28T09:20:05.684989  =

    2023-04-28T09:20:05.787581  / # . /lava-3540116/environment/lava-354011=
6/bin/lava-test-runner /lava-3540116/1
    2023-04-28T09:20:05.788714  =

    2023-04-28T09:20:05.793758  / # /lava-3540116/bin/lava-test-runner /lav=
a-3540116/1
    2023-04-28T09:20:05.877793  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform   | arch | lab          | compiler | defconfig             | regre=
ssions
-----------+------+--------------+----------+-----------------------+------=
------
da850-lcdk | arm  | lab-baylibre | gcc-10   | davinci_all_defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/644b909cf2c5d43f622e85f7

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: davinci_all_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
79-177-g91ed867e7ad5/arm/davinci_all_defconfig/gcc-10/lab-baylibre/baseline=
-da850-lcdk.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.2=
79-177-g91ed867e7ad5/arm/davinci_all_defconfig/gcc-10/lab-baylibre/baseline=
-da850-lcdk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/644b909cf2c5d43=
f622e85fe
        new failure (last pass: v4.19.279-170-g8d9ae4d546356)
        4 lines

    2023-04-28T09:23:20.493083  kern  :emerg : page:c6f51000 count:0 mapcou=
nt:-128 mapping:00000000 index:0x4
    2023-04-28T09:23:20.493706  kern  :emerg : flags: 0x0()
    2023-04-28T09:23:20.494509  kern  :emerg : page:c6f59000 count:0 mapcou=
nt:-128 mapping:00000000 index:0x4
    2023-04-28T09:23:20.496329  kern  :emerg : flags: 0x0()
    2023-04-28T09:23:20.560448  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Deme=
rg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D4>
    2023-04-28T09:23:20.561007  + set +x   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/644b909cf2c5d43=
f622e85ff
        new failure (last pass: v4.19.279-170-g8d9ae4d546356)
        6 lines

    2023-04-28T09:23:20.306622  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3400
    2023-04-28T09:23:20.307274  kern  :alert : raw: 00000000 00000100 00000=
200 00000000 00000004 0000000a ffffff7f 00000000
    2023-04-28T09:23:20.307439  kern  :alert : page dumped because: nonzero=
 mapcount
    2023-04-28T09:23:20.307586  kern  :alert : BUG: Bad page state in proce=
ss swapper  pfn:c3800
    2023-04-28T09:23:20.307728  kern  :alert : raw: 00000000 00000100 00000=
200 00000000 00000004 0000000a ffffff7f 00000000
    2023-04-28T09:23:20.310058  kern  :alert : page dumped because: nonzero=
 mapcount
    2023-04-28T09:23:20.351942  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dale=
rt RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D6>   =

 =20
