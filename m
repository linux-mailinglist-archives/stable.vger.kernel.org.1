Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E3B706BDF
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 16:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjEQO6i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 10:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjEQO6e (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 10:58:34 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D34869E
        for <stable@vger.kernel.org>; Wed, 17 May 2023 07:58:21 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6439b410679so632123b3a.0
        for <stable@vger.kernel.org>; Wed, 17 May 2023 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684335500; x=1686927500;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d9O87TFkEIPAH17KbKTXdpto4wa3oyV//9woqpcQt0E=;
        b=mRkE3a7q7Faogqg1F+95JYPVzN28imFcAYCANh8qwtQF+ai+5SAPDpUBPzUuShGHq8
         rzSEozCfE9Law/K11ii7EpHtT/ZE2bv/5Uwtw4ZxDt+pqOxZbCP59GUcIZ9T7uyzmE3z
         2a2RT/VvDTSiuwA+BjYLvDECJEUVs99ahXEnpfMoJqrPOMgxJpH+FqzkHDoLDou8GW6G
         hwWZYYli0ZL/nXB79k1iidhcgiD7IM9X4ao2PvCHhDC1TbJYTy7O4JEY6v5oDi7bJUnQ
         iqnH0aOQxXvuPvLqAZtxCrI9cz2ei4T3FLssnMuETKT5p+phFP9CtqgR6QsAj02q0f38
         6Nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335500; x=1686927500;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9O87TFkEIPAH17KbKTXdpto4wa3oyV//9woqpcQt0E=;
        b=P6E6e9kO+VGYSIF7gQjUhkz+L8jI8vt1PXq8d256rO1WVDw4N450H1g9XalXqbPiag
         youlM+w9ODvZkJC3aVqD3WKCjqu2a63iKJxfRforA87SVHfi/EMTIAg7oV6YNZHVYjLX
         k29PRHn7aG+l6+rCE/7+y4W+3oXfYRHax1ybbcbr9cGV+Z4EKxtwJiIcW4/t4osEmZl/
         07Tmv+XWAvqI9Dg78BRF1KwpQ6EZ8x3sInYS8LvtTYEmAWQlwOnkvE1y5kJUO9Ov1xCb
         0FzrfWhbAuBw4IIYWsoS7GZX4TNIy1uuGTJnw8/ckqqmAfgCrPNcVvFX5NvAEI7t02Vu
         y91A==
X-Gm-Message-State: AC+VfDxWWvMPWstNO4tziBdPcvXyTew7olgUm2WHnPWO0B91iK/IW01W
        1WGQLnNkvT/86tcWlQvCnBWU0B58nqmpJGZuTZLq4Q==
X-Google-Smtp-Source: ACHHUZ4HEu5Q2WRcE0vWb0WBfFlze60q52EM3ALeIDBeHAUHlLdby9s7eohxn91/9Ti6PmKoimyltQ==
X-Received: by 2002:aa7:8886:0:b0:64a:5cde:3a7d with SMTP id z6-20020aa78886000000b0064a5cde3a7dmr1421128pfe.27.1684335500682;
        Wed, 17 May 2023 07:58:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z9-20020aa785c9000000b0064caa2b06e9sm5135597pfn.167.2023.05.17.07.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 07:58:20 -0700 (PDT)
Message-ID: <6464eb8c.a70a0220.bdc36.9a45@mx.google.com>
Date:   Wed, 17 May 2023 07:58:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v5.10.180
X-Kernelci-Report-Type: test
Subject: stable/linux-5.10.y baseline: 165 runs, 4 regressions (v5.10.180)
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

stable/linux-5.10.y baseline: 165 runs, 4 regressions (v5.10.180)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2711-rpi-4-b              | arm64  | lab-linaro-lkft | gcc-10   | defcon=
fig                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.180/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.180
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      4c893ff55907c61456bcb917781c0dd687a1e123 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2711-rpi-4-b              | arm64  | lab-linaro-lkft | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6464b92eb6925cc2df2e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.180/=
arm64/defconfig/gcc-10/lab-linaro-lkft/baseline-bcm2711-rpi-4-b.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.180/=
arm64/defconfig/gcc-10/lab-linaro-lkft/baseline-bcm2711-rpi-4-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6464b92eb6925cc2df2e8=
5e7
        failing since 41 days (last pass: v5.10.176, first fail: v5.10.177) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464b6c84a1faff4da2e8650

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.180/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.180/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464b6c84a1faff4da2e8655
        failing since 42 days (last pass: v5.10.176, first fail: v5.10.177)

    2023-05-17T11:12:50.654810  + set +x

    2023-05-17T11:12:50.661065  <8>[   14.170077] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10350164_1.4.2.3.1>

    2023-05-17T11:12:50.766040  / # #

    2023-05-17T11:12:50.866678  export SHELL=3D/bin/sh

    2023-05-17T11:12:50.866860  #

    2023-05-17T11:12:50.967454  / # export SHELL=3D/bin/sh. /lava-10350164/=
environment

    2023-05-17T11:12:50.967681  =


    2023-05-17T11:12:51.068231  / # . /lava-10350164/environment/lava-10350=
164/bin/lava-test-runner /lava-10350164/1

    2023-05-17T11:12:51.068497  =


    2023-05-17T11:12:51.072986  / # /lava-10350164/bin/lava-test-runner /la=
va-10350164/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6464bb1ef9e7df8b412e8608

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.180/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.180/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6464bb1ef9e7df8b412e860e
        failing since 60 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-05-17T11:31:21.980533  /lava-10350847/1/../bin/lava-test-case

    2023-05-17T11:31:21.991444  <8>[   35.235712] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6464bb1ef9e7df8b412e860f
        failing since 60 days (last pass: v5.10.174, first fail: v5.10.175)

    2023-05-17T11:31:20.943307  /lava-10350847/1/../bin/lava-test-case

    2023-05-17T11:31:20.954613  <8>[   34.198517] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20
