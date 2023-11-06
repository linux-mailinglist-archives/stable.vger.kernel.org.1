Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5816E7E2ECB
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 22:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjKFVRj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 16:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjKFVRj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 16:17:39 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F08A3
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 13:17:36 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6c34e87b571so3276162b3a.3
        for <stable@vger.kernel.org>; Mon, 06 Nov 2023 13:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699305455; x=1699910255; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oyeEEAy6a8tsXREZhG1ztwvFzi+cIg383B/ozWboQPY=;
        b=aB0dNgHjFobRbO/1R7mS77QaoTbEAHpPkkj3T8D3ardl5ZZP4wSEXeJkghHXcmEY5b
         UrUW5RKCNj6Xs9RsK50soZ7HIKYK4pxNqWbJh7tg2Vx9sbwb1liU9aJUMM2Dz+HHysQN
         EpdYNX199DAtiQJyl6bAU/yjEsAkvcOJiX52Gb8hIA/82tH3Y3r44koiBunoDWycgOxZ
         ys+Z+MlL19gyJ38rlcHigoQG4Ro/HGH5ZS2GRhzGaVjp0vWlzaDnkUZW6631/XtGPuZH
         VCIk6E8MUv8GHdKCkLHRPisIoO09vFaMs7gck5V+gNuPidqAktWJsE9t670CcgzNUojC
         SMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699305455; x=1699910255;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyeEEAy6a8tsXREZhG1ztwvFzi+cIg383B/ozWboQPY=;
        b=k+OFQItVvR8eXviFsikiIKX6b2SHS3Ki0HeFDpFnPLDI+WzUbrcB2GQYLM3Do1Eq2f
         Asqfb4LN2II5R24xb/uOci8u0q246HDkz4CF6qBXim2jRiz/sbBQvB732ETAoL27Yloj
         nc5IWlL4Z9UYWkSXK9uc2HUseapsbRSv3CPD4KjjTLxMtF10MR0j62EdzrqaGNZmlXUg
         dzRqCm61SLcF+H+4ZDdtqTI/dKUp07F/5rW1eqpRCdScaUopgjZkxvbp0rHMSs3BdP2z
         OxGL5dihO7KuzbPGF9MBhrktFzw+4lMlOCbY8t86rOOl/xhXzUA6Yg10K7whrKJf6tED
         x+JA==
X-Gm-Message-State: AOJu0YzI2u7s1P7QZhNlq8LKtVKHb3Ftcg5XW/eKLLY8v2Lt0ffdjlB9
        /1g2WYBSgVLiFeK/wwIoqs4ltSv6xi/nOfM+T/U/Ag==
X-Google-Smtp-Source: AGHT+IEQW964+XqwtK8BIjn9SDC/7b4pRtC+vwod8Gj11jbjIJ6RYVdaS4yk6oCmblvJjYfej6fiLw==
X-Received: by 2002:a05:6a00:98b:b0:68f:c865:5ba8 with SMTP id u11-20020a056a00098b00b0068fc8655ba8mr30962987pfg.18.1699305455617;
        Mon, 06 Nov 2023 13:17:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s2-20020a62e702000000b006bda45671b1sm6017848pfh.101.2023.11.06.13.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 13:17:35 -0800 (PST)
Message-ID: <654957ef.620a0220.7b38c.d9c2@mx.google.com>
Date:   Mon, 06 Nov 2023 13:17:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.61-63-gf2e7db5bff466
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y baseline: 159 runs,
 3 regressions (v6.1.61-63-gf2e7db5bff466)
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

stable-rc/linux-6.1.y baseline: 159 runs, 3 regressions (v6.1.61-63-gf2e7db=
5bff466)

Regressions Summary
-------------------

platform           | arch  | lab         | compiler | defconfig           |=
 regressions
-------------------+-------+-------------+----------+---------------------+=
------------
beaglebone-black   | arm   | lab-broonie | gcc-10   | omap2plus_defconfig |=
 1          =

kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig           |=
 2          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.61-63-gf2e7db5bff466/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.61-63-gf2e7db5bff466
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f2e7db5bff4666814d68d4f2a8f1818be97f5e70 =



Test Regressions
---------------- =



platform           | arch  | lab         | compiler | defconfig           |=
 regressions
-------------------+-------+-------------+----------+---------------------+=
------------
beaglebone-black   | arm   | lab-broonie | gcc-10   | omap2plus_defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/65492683f48e1eb165efcf6a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.61-=
63-gf2e7db5bff466/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.61-=
63-gf2e7db5bff466/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65492683f48e1eb165efc=
f6b
        new failure (last pass: v6.1.61) =

 =



platform           | arch  | lab         | compiler | defconfig           |=
 regressions
-------------------+-------+-------------+----------+---------------------+=
------------
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig           |=
 2          =


  Details:     https://kernelci.org/test/plan/id/6549264321207efc29efcf20

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.61-=
63-gf2e7db5bff466/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-=
imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.61-=
63-gf2e7db5bff466/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-=
imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6549264321207efc29efcf27
        new failure (last pass: v6.1.61)

    2023-11-06T17:45:16.848471  / # #
    2023-11-06T17:45:16.950261  export SHELL=3D/bin/sh
    2023-11-06T17:45:16.950880  #
    2023-11-06T17:45:17.052147  / # export SHELL=3D/bin/sh. /lava-393391/en=
vironment
    2023-11-06T17:45:17.052872  =

    2023-11-06T17:45:17.154210  / # . /lava-393391/environment/lava-393391/=
bin/lava-test-runner /lava-393391/1
    2023-11-06T17:45:17.155131  =

    2023-11-06T17:45:17.160834  / # /lava-393391/bin/lava-test-runner /lava=
-393391/1
    2023-11-06T17:45:17.225548  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-06T17:45:17.225933  + cd /lava-393391/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/654=
9264321207efc29efcf37
        new failure (last pass: v6.1.61)

    2023-11-06T17:45:19.593436  /lava-393391/1/../bin/lava-test-case
    2023-11-06T17:45:19.593744  <8>[   17.051492] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>   =

 =20
