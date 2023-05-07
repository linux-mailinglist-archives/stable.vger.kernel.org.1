Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1503C6F98D5
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 16:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjEGOJp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 10:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEGOJo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 10:09:44 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2511A49F7
        for <stable@vger.kernel.org>; Sun,  7 May 2023 07:09:43 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aaed87d8bdso24349405ad.3
        for <stable@vger.kernel.org>; Sun, 07 May 2023 07:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683468582; x=1686060582;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hfHMc8VmZxUvkBHwXjCpv2wnPsOH2u0eIopuUWk5QQY=;
        b=ISIvjOYyQuZlmJchEhd8SBfsWrh5L2E6BVvr+xPcl7mSbTYYgxzpABpmTzs3AdBHWT
         J2p5X6frLVon3Uho+mRqU1hJcznoH1HvJzdZ+Fo//+qj5ojQ869b+QK9TzZP5K86tDAt
         Kcj7ibOLqR3Bss1WvBFD+n3XSVzY8lMFAI31ucFiM9s2RPEfQ7sN6LttGBDeEjfYYv5M
         d/osrFrvTRRZLha6k+QNb//wQA1EgFmq7/Fagoh+7uG8OTwl49BxvyqtAHVuIXhdmvca
         E6+7PBu+QJCVIWrxLE2Vz1QjfhYdl+iDz5C835kOWZ8IEX4EY9mYUAk6Xdr0QCeaTWec
         o9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683468582; x=1686060582;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfHMc8VmZxUvkBHwXjCpv2wnPsOH2u0eIopuUWk5QQY=;
        b=Sse9l3PoVp5b4EqbUga4IlGHupbIFu7HquGPpWd/zRFBHHbOLrWQKvM6WN6InKQy9Q
         Lfa7Crc1xPwEQUGQnbpgZX1p19wEVceTZPDlr1kerFwmJQN86ib71E6FtFEZgWoeocO4
         u8ydItefkzhktJZTIeXJUs5P5P8+WFAf8J160YihdS+vDQAq2ypXfxz3ZdRSTuJUbDUT
         vfgzXmES0/TeTYdPJeQhR4wFvry+X/g3WGMAhcH/X5Pg2ZFHcQqaDF2ZAjlzXQ86qkgo
         euatcXHNI+a/MGG5C0/gi3arls13I06mNKfE+ye2XipB+9ZOJAf6/JfQA82enU8Vx+EJ
         YClQ==
X-Gm-Message-State: AC+VfDykCPbL9ErX0izze2VZUuKgwI97yzZN0+ngaPPlpediBO9xw2Di
        JekIdez8WmLGEqBXWJMavdQLRMoJbZbUdfwPy82ADg==
X-Google-Smtp-Source: ACHHUZ4iwb9Y66HINMhQ5X/L+/9fCaMI4PwwBfVOx/hEbiPAk3ooXfgawbvI6IbcIwlXik2YfeQchQ==
X-Received: by 2002:a17:902:b946:b0:1a9:9a18:3458 with SMTP id h6-20020a170902b94600b001a99a183458mr7258165pls.31.1683468582057;
        Sun, 07 May 2023 07:09:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090a408500b0024c1ac09394sm8160641pjg.19.2023.05.07.07.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 07:09:41 -0700 (PDT)
Message-ID: <6457b125.170a0220.b3771.04ea@mx.google.com>
Date:   Sun, 07 May 2023 07:09:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-639-g1bcbd29cf5f8
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 120 runs,
 4 regressions (v5.10.176-639-g1bcbd29cf5f8)
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

stable-rc/queue/5.10 baseline: 120 runs, 4 regressions (v5.10.176-639-g1bcb=
d29cf5f8)

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

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.176-639-g1bcbd29cf5f8/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-639-g1bcbd29cf5f8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      1bcbd29cf5f8cad7e59cb4bf2b424f807743ee3d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64577ea71f523c834d2e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-639-g1bcbd29cf5f8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-639-g1bcbd29cf5f8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64577ea71f523c834d2e85eb
        failing since 38 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-07T10:33:58.562146  + <8>[   10.202034] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10226060_1.4.2.3.1>

    2023-05-07T10:33:58.562606  set +x

    2023-05-07T10:33:58.668383  =


    2023-05-07T10:33:58.770335  / # #export SHELL=3D/bin/sh

    2023-05-07T10:33:58.771149  =


    2023-05-07T10:33:58.872601  / # export SHELL=3D/bin/sh. /lava-10226060/=
environment

    2023-05-07T10:33:58.873482  =


    2023-05-07T10:33:58.975141  / # . /lava-10226060/environment/lava-10226=
060/bin/lava-test-runner /lava-10226060/1

    2023-05-07T10:33:58.976484  =


    2023-05-07T10:33:58.980836  / # /lava-10226060/bin/lava-test-runner /la=
va-10226060/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64577eb1fde1e640512e862b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-639-g1bcbd29cf5f8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-639-g1bcbd29cf5f8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64577eb1fde1e640512e8630
        failing since 38 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-05-07T10:34:03.065911  + set +x

    2023-05-07T10:34:03.072322  <8>[   14.084943] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10226118_1.4.2.3.1>

    2023-05-07T10:34:03.176848  / # #

    2023-05-07T10:34:03.279164  export SHELL=3D/bin/sh

    2023-05-07T10:34:03.279451  #

    2023-05-07T10:34:03.380353  / # export SHELL=3D/bin/sh. /lava-10226118/=
environment

    2023-05-07T10:34:03.381140  =


    2023-05-07T10:34:03.482797  / # . /lava-10226118/environment/lava-10226=
118/bin/lava-test-runner /lava-10226118/1

    2023-05-07T10:34:03.484070  =


    2023-05-07T10:34:03.488989  / # /lava-10226118/bin/lava-test-runner /la=
va-10226118/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64577f837366d796cc2e865f

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-639-g1bcbd29cf5f8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-639-g1bcbd29cf5f8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ba=
seline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/64577f837366d796cc2e8665
        failing since 54 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-07T10:37:36.359004  /lava-10226141/1/../bin/lava-test-case

    2023-05-07T10:37:36.370550  <8>[   61.993466] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/64577f837366d796cc2e8666
        failing since 54 days (last pass: v5.10.172-529-g06956b9e9396, firs=
t fail: v5.10.173-69-gfcbe6bd469ed)

    2023-05-07T10:37:35.323747  /lava-10226141/1/../bin/lava-test-case

    2023-05-07T10:37:35.335100  <8>[   60.957898] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20
