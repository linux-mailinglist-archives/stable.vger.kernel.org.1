Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D31716B59
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 19:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjE3RmQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 13:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjE3RmP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 13:42:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CA8EC
        for <stable@vger.kernel.org>; Tue, 30 May 2023 10:42:13 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64fec2e0e25so1282623b3a.1
        for <stable@vger.kernel.org>; Tue, 30 May 2023 10:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685468532; x=1688060532;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dF/AysXNfrpHKXoOdmdsooHJQ35vhMgAAela34Lg/fQ=;
        b=rGjW01QoJZ12/4V9PFH/tCkbE1EeQ5+ToNE8hvi9liwiqpkWQ5MRG9Rz0FW0usOWNo
         WZq86dUE/K091kxNJHuE9fVdVpoyQz3KPLYmLZUJ1XQ65wtFZH5RD0T5R3h1Op/mdPoL
         geIKT6mp0y9Y1Pm1plF+3Bv77E2bKDQDeohvx1xfdDAR70rVBTL/F7yLXtGsSwEQJK/N
         hvXbFjCtBikaSbxr6qBeYFRfP+fOk+NtSBqPzGB471UyKM/IlnxWsgZDQAUVRRRdoDl3
         5UDmdQ+xZfL/4Vt1UJRPEDkgVPSPaTOFKLo74Tv68e/6DdJZgnKPh7NzwiSphykvV0XX
         t3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685468532; x=1688060532;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dF/AysXNfrpHKXoOdmdsooHJQ35vhMgAAela34Lg/fQ=;
        b=a5AYzVMsIEgVXRvBL1nd7x4oiCQz4KFs0kLLdUn73DiCS5VASHo9h470pQEMftfNAV
         +eOPXtXHZVkYXmu0EB5NoWaJnWf+IdlkvJoCYToVhmoV/IPoTglKf8cIHS+fxh7D8mpY
         FsX+pvrmNHOBLWdiMcCAdbfXV1bcUsLR0q4TRwzdtkqd3xGw/SMFeO7CDkCxYpMmL2hp
         VCXI4ebX//bdL+9Jk/S2+TWw8BfLE3+wsdPohRgLAfzp5VnwoeNzhRuxWhHlbVmWaiC1
         +RkgdEC8QeH2W+pJHIuYNpOHYY1EFBxVhFWU7E3ph6m2KSM8C3kGDzs4CApvlCkQxD6o
         7Kuw==
X-Gm-Message-State: AC+VfDxSHk5BY6nnx58CJ1L7bXYgG7rdEa60v4Bj36pO6sPjzIS3g4mS
        9x7Zu4jdpdgw2WVBEYCI+PJsoy9DqQbzC0HAvn9jXg==
X-Google-Smtp-Source: ACHHUZ5PIxzE0rxDEY+2tATbeq/ust/koluue7XtlNXxB0QctfLzwXChgYPyjWCvfNnhm0miknYB8Q==
X-Received: by 2002:a05:6a00:1a91:b0:64d:61f2:ca88 with SMTP id e17-20020a056a001a9100b0064d61f2ca88mr3210928pfv.12.1685468532558;
        Tue, 30 May 2023 10:42:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g3-20020a62e303000000b0064fdf5b1d7esm1868196pfh.157.2023.05.30.10.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 10:42:12 -0700 (PDT)
Message-ID: <64763574.620a0220.c8de9.3d2f@mx.google.com>
Date:   Tue, 30 May 2023 10:42:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v5.10.181
X-Kernelci-Report-Type: test
Subject: stable/linux-5.10.y baseline: 132 runs, 3 regressions (v5.10.181)
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

stable/linux-5.10.y baseline: 132 runs, 3 regressions (v5.10.181)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.181/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.181
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      272d4b8a5b96dda1374b9039a884cce2cd9cb630 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6476028a26880a54712e85f9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.181/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.181/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6476028a26880a54712e85fe
        failing since 55 days (last pass: v5.10.176, first fail: v5.10.177)

    2023-05-30T14:04:39.150045  + set +x

    2023-05-30T14:04:39.156565  <8>[    8.246743] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10524975_1.4.2.3.1>

    2023-05-30T14:04:39.261031  / # #

    2023-05-30T14:04:39.361807  export SHELL=3D/bin/sh

    2023-05-30T14:04:39.362028  #

    2023-05-30T14:04:39.462607  / # export SHELL=3D/bin/sh. /lava-10524975/=
environment

    2023-05-30T14:04:39.462814  =


    2023-05-30T14:04:39.563375  / # . /lava-10524975/environment/lava-10524=
975/bin/lava-test-runner /lava-10524975/1

    2023-05-30T14:04:39.563728  =


    2023-05-30T14:04:39.567926  / # /lava-10524975/bin/lava-test-runner /la=
va-10524975/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/647604afd9c473857a2e85f8

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.181/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.181/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/647604afd9c473857a2e85fe
        failing since 74 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-05-30T14:13:50.616711  /lava-10525146/1/../bin/lava-test-case

    2023-05-30T14:13:50.627680  <8>[   33.456669] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/647604afd9c473857a2e85ff
        failing since 74 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-05-30T14:13:49.580414  /lava-10525146/1/../bin/lava-test-case

    2023-05-30T14:13:49.590785  <8>[   32.419901] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20
