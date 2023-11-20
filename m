Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96FF7F1762
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 16:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjKTPeG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 10:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbjKTPeF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 10:34:05 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DEBA7
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 07:34:01 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6c4cf0aea06so4329062b3a.0
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 07:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700494440; x=1701099240; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ImZmv4T0/rFZ47jhsUwkjXGGoPKDtbAyzi+PKcJdHn8=;
        b=g3w8bNpDF4axog3jXUOnojXxX35vVgxD+goxRG99iqxMz9ShYpTc4Fn41Whx2uozMt
         mON60BKZ8cdcuXFIxFYgYsBhfVRpQIHvaMZSeMKsFu8FMnpiJBxGGW/Y/UEwu1RLmUQp
         MLCdapcGHY3M5og4jDYu3xo0Fu12I9doVFrhaF60DAargE/PpZ3CMPXb9JDky2tWV5tC
         L8VzXOI2Syy951+J0F9U2wG7ISEqSYDsi1N5GdxsA1EZmfUs8yGdmDSm5wm46G4A7jcX
         MZhYSkEeoTq9+nEvqhIvEoq9Rk5BwbuzlR3sASsi9Wh3nTBM4YNjS5TkcitpvwD4xvP0
         casQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494440; x=1701099240;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImZmv4T0/rFZ47jhsUwkjXGGoPKDtbAyzi+PKcJdHn8=;
        b=JyBcUWZmADmkIMBGImlx2+Nb2Ms6f5lRjBD5YA38kcSeXfWy7STfPNV/1vdT452lm6
         OGIClndVmBccmXLKhZBaQnLKsY3bEM2DC0THiNLg79EW4vB0wfywvemtQftwA69tE9wn
         M4e3FnFKTXCAV9tTestoIYpz2M9bvHm19LSYEfHZt8BMDvCcORkkX6FFWs3I0FbWicj+
         dtZYsXlvGssUFksEICz93XoujMTam4rLAqudKFoLMHS/Za2eG6RFZ3afFgtelMYI3qPC
         sWn+co1LaWZ7Ye0aZp/BhAsJwO/Xkz685VxdBKG94h9lCiJwRmL4t2iVmOZhPcc/gkkc
         KsWQ==
X-Gm-Message-State: AOJu0Yy/DWaw/NHi4dHDOom6AkwwcIpYNv/gpyMcjkyWuK5gQZssk9zv
        v4DmQzpEEX3accw2815Oqcs8wWGAqTYLIWzvL4g=
X-Google-Smtp-Source: AGHT+IHC9ApwhwzBIONlmBwgUptU9Di4SoyPw+haxFS18US44DTf/ncYjI1BQrCQ5p3+3g49nBnhzw==
X-Received: by 2002:a05:6a20:4294:b0:188:f3d:ea35 with SMTP id o20-20020a056a20429400b001880f3dea35mr10084900pzj.50.1700494440486;
        Mon, 20 Nov 2023 07:34:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g23-20020aa78197000000b006905f6bfc37sm6208395pfi.31.2023.11.20.07.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:33:59 -0800 (PST)
Message-ID: <655b7c67.a70a0220.51204.fd9d@mx.google.com>
Date:   Mon, 20 Nov 2023 07:33:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v4.19.299
Subject: stable/linux-4.19.y baseline: 88 runs, 3 regressions (v4.19.299)
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

stable/linux-4.19.y baseline: 88 runs, 3 regressions (v4.19.299)

Regressions Summary
-------------------

platform         | arch  | lab          | compiler | defconfig           | =
regressions
-----------------+-------+--------------+----------+---------------------+-=
-----------
beaglebone-black | arm   | lab-broonie  | gcc-10   | omap2plus_defconfig | =
1          =

meson-gxm-q200   | arm64 | lab-baylibre | gcc-10   | defconfig           | =
2          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-4.19.y/kernel=
/v4.19.299/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-4.19.y
  Describe: v4.19.299
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      8dd1c3f9bd6a34c2b5c88320b4bade4212d4ec49 =



Test Regressions
---------------- =



platform         | arch  | lab          | compiler | defconfig           | =
regressions
-----------------+-------+--------------+----------+---------------------+-=
-----------
beaglebone-black | arm   | lab-broonie  | gcc-10   | omap2plus_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/655b4bbf1369cbc69d7e4a88

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.299/=
arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.299/=
arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655b4bbf1369cbc69d7e4aba
        failing since 12 days (last pass: v4.19.296, first fail: v4.19.298)

    2023-11-20T12:05:45.069981  + set +x<8>[   19.467941] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 255881_1.5.2.4.1>
    2023-11-20T12:05:45.070303  =

    2023-11-20T12:05:45.179860  / # #
    2023-11-20T12:05:45.281451  export SHELL=3D/bin/sh
    2023-11-20T12:05:45.281861  #
    2023-11-20T12:05:45.383076  / # export SHELL=3D/bin/sh. /lava-255881/en=
vironment
    2023-11-20T12:05:45.383495  =

    2023-11-20T12:05:45.484730  / # . /lava-255881/environment/lava-255881/=
bin/lava-test-runner /lava-255881/1
    2023-11-20T12:05:45.485324  =

    2023-11-20T12:05:45.493327  / # /lava-255881/bin/lava-test-runner /lava=
-255881/1 =

    ... (12 line(s) more)  =

 =



platform         | arch  | lab          | compiler | defconfig           | =
regressions
-----------------+-------+--------------+----------+---------------------+-=
-----------
meson-gxm-q200   | arm64 | lab-baylibre | gcc-10   | defconfig           | =
2          =


  Details:     https://kernelci.org/test/plan/id/655b4baa8952d9783d7e4a7e

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.299/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.299/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/655b4baa8952d97=
83d7e4a81
        failing since 12 days (last pass: v4.19.288, first fail: v4.19.298)
        1 lines

    2023-11-20T12:05:36.325041  kern  :emerg : Disabling IRQ #20
    2023-11-20T12:05:36.325592  <8>[   45.348353] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
    2023-11-20T12:05:36.325807  + set +x   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655b4baa8952d9783d7e4a87
        new failure (last pass: v4.19.298)

    2023-11-20T12:05:36.328698  <8>[   45.352623] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3841227_1.5.2.4.1>
    2023-11-20T12:05:36.433303  / # #
    2023-11-20T12:05:36.534577  export SHELL=3D/bin/sh
    2023-11-20T12:05:36.535092  #
    2023-11-20T12:05:36.635909  / # export SHELL=3D/bin/sh. /lava-3841227/e=
nvironment
    2023-11-20T12:05:36.636379  =

    2023-11-20T12:05:36.737187  / # . /lava-3841227/environment/lava-384122=
7/bin/lava-test-runner /lava-3841227/1
    2023-11-20T12:05:36.737797  =

    2023-11-20T12:05:36.742603  / # /lava-3841227/bin/lava-test-runner /lav=
a-3841227/1
    2023-11-20T12:05:36.812407  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (13 line(s) more)  =

 =20
