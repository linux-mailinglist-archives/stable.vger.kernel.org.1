Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BD57ED85A
	for <lists+stable@lfdr.de>; Thu, 16 Nov 2023 00:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjKOX7Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 18:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKOX7P (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 18:59:15 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B54711D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 15:59:12 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c4ed8eef16so229906b3a.0
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 15:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700092751; x=1700697551; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AXjCJJ/leSjT3NKj5Tb/Rv38FfEm0lTspiz9ppPVC08=;
        b=edkAO/eLCorXCIQ6dWj+FR6ROKCO7rOU6W8Ji9uatuNixxjjVvkmCAHraAKgu9F73v
         EAdlt/XtfGnz3dqeHjCW5kOt87oEmZQ0ULKXud5nj22jvszgWheTkvi6qspoqvPzIeWW
         dFYT569l9VHBVDQZyMZ0k85NmwrNJjyOx6AO5gQD1/Q0z3PpcB1SBPV70UMEEWXiVgkT
         ecmWuF+QMFvYzbrrJc4S2EwedfBp0dLZXjOI9LiFjBncweXu0surn9iSoukI7KCPmKJt
         MrJyuptNBgHc3uP5LWS3XBuOfdE/Pp2ZhUVRbcrAZMzH1UFNAoc9Jt7ug4mu8rlc6NhM
         J2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700092751; x=1700697551;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXjCJJ/leSjT3NKj5Tb/Rv38FfEm0lTspiz9ppPVC08=;
        b=ONlStD2gHiZW+Qyb9PTtVfkDgELpv7tT745XjBOYqzmnjRRcfXhSX+fSsg3S0/Zszn
         UPhie6m6zOGAf+VA+dKZbjFRiiBkoA9gfcRcdThVahkbW9KjsY0J3pjsNZJJco7LwmBb
         m6aW3ihUVWYGWV2a9NNZm9IVE1xJqyLfb7/I9MDq3mHNdNfnH+leiBa4U3Hn8pktN9Ix
         6ObgiZRy6rYx3N8qsLImUNg5GEr5MElJD1uKDDCMJ5NJPZsxh8DoCYmNUiK/+9okYXDY
         BjfxsGcmKG2RfvEFc4/TYPF+Y4rsawlAbOgMtvRCh54yQ1rLhz92k4rHiUGinKkGb0Jt
         Fg+Q==
X-Gm-Message-State: AOJu0Ywttp4u+kyAIPOhEcRWuVytVce1OkeNSCgEam6jgpzcmmvgAXIp
        m/IyTFhKq7b/eibHVaZJzv0eFIpvWbds9pLqa+ANSw==
X-Google-Smtp-Source: AGHT+IH3QYwRdnmQeP2ahIgbmNXJ4ELU75SYbe3aKmajMUPAsB7G5dE1jw6XwaZFze+zPCabGVGSRw==
X-Received: by 2002:aa7:80c8:0:b0:6ca:af85:f14 with SMTP id a8-20020aa780c8000000b006caaf850f14mr1999035pfn.32.1700092751339;
        Wed, 15 Nov 2023 15:59:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p40-20020a056a0026e800b006be5af77f06sm3352409pfw.2.2023.11.15.15.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 15:59:10 -0800 (PST)
Message-ID: <65555b4e.050a0220.8460b.b473@mx.google.com>
Date:   Wed, 15 Nov 2023 15:59:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.200-208-g56d7b7f72001
Subject: stable-rc/linux-5.10.y baseline: 115 runs,
 3 regressions (v5.10.200-208-g56d7b7f72001)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y baseline: 115 runs, 3 regressions (v5.10.200-208-g56=
d7b7f72001)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.200-208-g56d7b7f72001/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.200-208-g56d7b7f72001
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      56d7b7f72001d6cdd7f5e67809115743b1ad99be =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6555285d31cf337c077e4ab8

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00-208-g56d7b7f72001/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00-208-g56d7b7f72001/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6555285d31cf337c077e4af6
        failing since 0 day (last pass: v5.10.200, first fail: v5.10.200-20=
7-gc3a1f056425f)

    2023-11-15T20:21:23.118156  / # #
    2023-11-15T20:21:23.221120  export SHELL=3D/bin/sh
    2023-11-15T20:21:23.221897  #
    2023-11-15T20:21:23.323848  / # export SHELL=3D/bin/sh. /lava-244598/en=
vironment
    2023-11-15T20:21:23.324614  =

    2023-11-15T20:21:23.426544  / # . /lava-244598/environment/lava-244598/=
bin/lava-test-runner /lava-244598/1
    2023-11-15T20:21:23.427833  =

    2023-11-15T20:21:23.441056  / # /lava-244598/bin/lava-test-runner /lava=
-244598/1
    2023-11-15T20:21:23.501951  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-15T20:21:23.502521  + cd /lava-244598/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655527af34462079727e4a95

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00-208-g56d7b7f72001/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00-208-g56d7b7f72001/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655527af34462079727e4a9e
        failing since 35 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-15T20:18:46.166427  <8>[   16.957289] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 444147_1.5.2.4.1>
    2023-11-15T20:18:46.271469  / # #
    2023-11-15T20:18:46.373155  export SHELL=3D/bin/sh
    2023-11-15T20:18:46.373868  #
    2023-11-15T20:18:46.474865  / # export SHELL=3D/bin/sh. /lava-444147/en=
vironment
    2023-11-15T20:18:46.475461  =

    2023-11-15T20:18:46.576484  / # . /lava-444147/environment/lava-444147/=
bin/lava-test-runner /lava-444147/1
    2023-11-15T20:18:46.577498  =

    2023-11-15T20:18:46.581833  / # /lava-444147/bin/lava-test-runner /lava=
-444147/1
    2023-11-15T20:18:46.648895  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655527d4ab463dbd6c7e4aac

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00-208-g56d7b7f72001/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
00-208-g56d7b7f72001/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655527d4ab463dbd6c7e4ab5
        failing since 35 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-15T20:25:46.892297  / # #

    2023-11-15T20:25:46.992875  export SHELL=3D/bin/sh

    2023-11-15T20:25:46.993074  #

    2023-11-15T20:25:47.093565  / # export SHELL=3D/bin/sh. /lava-12011467/=
environment

    2023-11-15T20:25:47.093756  =


    2023-11-15T20:25:47.194261  / # . /lava-12011467/environment/lava-12011=
467/bin/lava-test-runner /lava-12011467/1

    2023-11-15T20:25:47.194559  =


    2023-11-15T20:25:47.205930  / # /lava-12011467/bin/lava-test-runner /la=
va-12011467/1

    2023-11-15T20:25:47.265856  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-15T20:25:47.266016  + cd /lava-1201146<8>[   18.220992] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12011467_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
