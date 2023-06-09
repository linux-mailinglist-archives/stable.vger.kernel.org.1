Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FEF729EA8
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 17:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjFIPfq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 9 Jun 2023 11:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238515AbjFIPfq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Jun 2023 11:35:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4122D70
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 08:35:42 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-652d76be8c2so2012619b3a.3
        for <stable@vger.kernel.org>; Fri, 09 Jun 2023 08:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686324941; x=1688916941;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8HEI3dCeVOcwjgbf8Ssm2HJ+flA2+a5YDruvHCxmwus=;
        b=2V9DcK6cttLVU6YbhinS7dWBqwhg5ILR1YZURaw+hhniy8//v/AJg57rKDIjb65lTw
         iv+3An98YdksYRiUVxLK49kZ3Tambe/uwt1gayKAqrHA5TrldGNlS09HujWQTi66kfzU
         BoC7/yLF/IbqhyD0vWNfpogRLLkAEC2hF2WNoe/JALWFTCSbtTwMMBWgHf2EaE4e48gb
         zwcyTPdDGMw2FB3JcX3cfVNCFg6jeuXBB3KHDP6KtxRqak3HvLOLSTSiHaHVT4iMLgjo
         YZe14HxNyEqIFNzGQIvq2Auco+qKfLM7cw/zq+JEgwELGrVFjZCslwE6uq/pNzx4YSxN
         VIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686324941; x=1688916941;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HEI3dCeVOcwjgbf8Ssm2HJ+flA2+a5YDruvHCxmwus=;
        b=jh5KgI+1xg9cSdm4xt60JxI78KK+mUIl/w499ZFKu4s2Ag2Np6PYnx7IFnOzc191c8
         UxZKu9XPttNMQC0JsS84xAZvfUC8y/bsiqNY2fRNYF48Xa3kNY0ceFtbZNK9XyvbAYlE
         LsO3r1f4FwZAFBZjgNBS/hgq8xzMokGU6xJpHrxMonUD25iUJ/teTb14e15z1RtJYpI/
         TKAT+Rob9m+sZYPL9w42RE3V+DRAPfMRrHLOT9uw/62rHh0D2UI52Ii4tVwF5soC4Dq/
         X0Gk3tvU69ATSsekIfjnYdASYt4xLUzlEdrxjU7IbjyAR4PC9QcO3f5ioT2M5wxTWtwU
         DlXQ==
X-Gm-Message-State: AC+VfDy9IKNzuIjuALC2XQg7LulXLoHF92pxULDyS12wG9H59YLB3UEl
        543cD1R0SKlGcOHc9WZSJLAFicMaHyucZ88sNoBHhQ==
X-Google-Smtp-Source: ACHHUZ5JX7Vl2a8RgaDVp+aEiaGgZWMgCI8aNpEG9MbHUkmjxqO87i/p+3NM04nfIHi09J2fM4UDNw==
X-Received: by 2002:a05:6a00:138f:b0:663:716e:e752 with SMTP id t15-20020a056a00138f00b00663716ee752mr1939654pfg.26.1686324940912;
        Fri, 09 Jun 2023 08:35:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y23-20020aa78557000000b0063b8ddf77f7sm2806306pfn.211.2023.06.09.08.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:35:40 -0700 (PDT)
Message-ID: <648346cc.a70a0220.b4e2e.5867@mx.google.com>
Date:   Fri, 09 Jun 2023 08:35:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3.7
Subject: stable/linux-6.3.y baseline: 179 runs, 3 regressions (v6.3.7)
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

stable/linux-6.3.y baseline: 179 runs, 3 regressions (v6.3.7)

Regressions Summary
-------------------

platform         | arch  | lab             | compiler | defconfig          =
| regressions
-----------------+-------+-----------------+----------+--------------------=
+------------
at91sam9g20ek    | arm   | lab-broonie     | gcc-10   | at91_dt_defconfig  =
| 1          =

imx6dl-riotboard | arm   | lab-pengutronix | gcc-10   | multi_v7_defconfig =
| 1          =

meson-gxm-q200   | arm64 | lab-baylibre    | gcc-10   | defconfig          =
| 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.3.y/kernel/=
v6.3.7/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.3.y
  Describe: v6.3.7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      e282393f9d0cd66cee8c68a80f4936f46c449b2d =



Test Regressions
---------------- =



platform         | arch  | lab             | compiler | defconfig          =
| regressions
-----------------+-------+-----------------+----------+--------------------=
+------------
at91sam9g20ek    | arm   | lab-broonie     | gcc-10   | at91_dt_defconfig  =
| 1          =


  Details:     https://kernelci.org/test/plan/id/64830f2654239f1e3b30614e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.3.y/v6.3.7/arm/=
at91_dt_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.3.y/v6.3.7/arm/=
at91_dt_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64830f2654239f1e3b306=
14f
        new failure (last pass: v6.3.6) =

 =



platform         | arch  | lab             | compiler | defconfig          =
| regressions
-----------------+-------+-----------------+----------+--------------------=
+------------
imx6dl-riotboard | arm   | lab-pengutronix | gcc-10   | multi_v7_defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/648311a3eb3d9373ee306197

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.3.y/v6.3.7/arm/=
multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.3.y/v6.3.7/arm/=
multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648311a3eb3d9373ee30619c
        new failure (last pass: v6.3.6)

    2023-06-09T11:48:27.274253  + set[   15.035241] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 972355_1.5.2.3.1>
    2023-06-09T11:48:27.274510   +x
    2023-06-09T11:48:27.380479  / # #
    2023-06-09T11:48:27.482228  export SHELL=3D/bin/sh
    2023-06-09T11:48:27.482678  #
    2023-06-09T11:48:27.583917  / # export SHELL=3D/bin/sh. /lava-972355/en=
vironment
    2023-06-09T11:48:27.584403  =

    2023-06-09T11:48:27.685727  / # . /lava-972355/environment/lava-972355/=
bin/lava-test-runner /lava-972355/1
    2023-06-09T11:48:27.686386  =

    2023-06-09T11:48:27.689241  / # /lava-972355/bin/lava-test-runner /lava=
-972355/1 =

    ... (12 line(s) more)  =

 =



platform         | arch  | lab             | compiler | defconfig          =
| regressions
-----------------+-------+-----------------+----------+--------------------=
+------------
meson-gxm-q200   | arm64 | lab-baylibre    | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/64831204a236e6e92b3061f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.3.y/v6.3.7/arm6=
4/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.3.y/v6.3.7/arm6=
4/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64831204a236e6e92b306=
1f3
        new failure (last pass: v6.3.6) =

 =20
