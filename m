Return-Path: <stable+bounces-3111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E9C7FCC35
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 02:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFE17B21548
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 01:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297B8185B;
	Wed, 29 Nov 2023 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="I6Wc9ktw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586B819A6
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 17:12:06 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso4788165a12.3
        for <stable@vger.kernel.org>; Tue, 28 Nov 2023 17:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701220325; x=1701825125; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/Dos5PCmE7QY95fUggkj+Dy06pH9j4lU9KJLB8AwW+4=;
        b=I6Wc9ktw8PQwAW7G9tQW7Y/MHxeXQq5IEqNObTXKrIxnLfV3W60G1Vt0xVWPIgNk6y
         91elPVjmhGFFt9fBWwDYFMkgLXr0jWhZNX+6q/0+O7IRZ38FEvu86jXVEhnqosYnvgtp
         Mv5yPY5FjkpOmeuxfsUif31wD2sQ6EtioFYCXa45viZa7b6vRs1UT4Hl7xIYaugaxuqY
         Uwq6LXCxMAKKebxlG/2ExHH4mkWQHR647hkSap6neOvJu52O8dle/mDRWGsPKpFRFCTe
         YkTtFkL7FZFNtvrYETA2NV12J3Vsz5/dHDGI576shCHCxXDlhnTOn9GpISJ7ti1VANo0
         V/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701220325; x=1701825125;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Dos5PCmE7QY95fUggkj+Dy06pH9j4lU9KJLB8AwW+4=;
        b=CjRsdFbIpSJ32rkNDDGk0WYa7hFu3uQzLZK0gSoQqohVJTDD0nkoHGt0G/AZFzdzmK
         gbnGLHzWvdfab6b9vuvKloM1rPdGTpaYlugYRXKsOClYMi5TpUGImiLp/Gl0ycaQ6K96
         0lbVM5BtGxgqqVwN5Wqxh/doYRJdv+GZiNTR0AW6+PysZunCEvT/4p1azxq1vNFkpAvI
         oYIYSButf8V2sxXIrDuiExgLtqO+qOcGcUoIDFU9J7vBS/J1IRGB+X777W5IFqsWtEaJ
         lTgVKG49MbV3las7J79EZP/OoJDL/HHzpm2iz2CFYSen9gP8/xnO2tqMKcCrmuVkU1fB
         r+SQ==
X-Gm-Message-State: AOJu0YxQ+T51ucaQI798VzaEW1O2VO3r4NFskylS6evnU0SZKNlkdCQB
	5NXBax9ogOMCLcTdcqa2mCsrUrNms5YMZkKGYrE=
X-Google-Smtp-Source: AGHT+IFXxoowwTitDG33iTAve/qDSctdIXtwssgZi8hrZ5rGrAajY5bbO2H2kRs954GUuhIlPt35/g==
X-Received: by 2002:a05:6a21:7896:b0:18b:4e8c:471d with SMTP id bf22-20020a056a21789600b0018b4e8c471dmr24253317pzc.59.1701220325311;
        Tue, 28 Nov 2023 17:12:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o1-20020a056a00214100b006cb6ba5fe72sm9663526pfk.122.2023.11.28.17.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 17:12:04 -0800 (PST)
Message-ID: <65668fe4.050a0220.9a567.9019@mx.google.com>
Date: Tue, 28 Nov 2023 17:12:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v4.19.300
Subject: stable/linux-4.19.y baseline: 129 runs, 3 regressions (v4.19.300)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-4.19.y baseline: 129 runs, 3 regressions (v4.19.300)

Regressions Summary
-------------------

platform         | arch  | lab          | compiler | defconfig           | =
regressions
-----------------+-------+--------------+----------+---------------------+-=
-----------
beaglebone-black | arm   | lab-cip      | gcc-10   | omap2plus_defconfig | =
1          =

meson-gxm-q200   | arm64 | lab-baylibre | gcc-10   | defconfig           | =
2          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-4.19.y/kernel=
/v4.19.300/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-4.19.y
  Describe: v4.19.300
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      979b2ade8052a563f9cdd9913e45c2462a7c665a =



Test Regressions
---------------- =



platform         | arch  | lab          | compiler | defconfig           | =
regressions
-----------------+-------+--------------+----------+---------------------+-=
-----------
beaglebone-black | arm   | lab-cip      | gcc-10   | omap2plus_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6566679b5c53aa08fa7e4a7e

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.300/=
arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.300/=
arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6566679b5c53aa08fa7e4ab4
        new failure (last pass: v4.19.299)

    2023-11-28T22:19:32.095471  + set +x
    2023-11-28T22:19:32.100958  <8>[   10.652963] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1047658_1.5.2.4.1>
    2023-11-28T22:19:32.213123  / # #
    2023-11-28T22:19:32.315128  export SHELL=3D/bin/sh
    2023-11-28T22:19:32.315775  #
    2023-11-28T22:19:32.417060  / # export SHELL=3D/bin/sh. /lava-1047658/e=
nvironment
    2023-11-28T22:19:32.417715  =

    2023-11-28T22:19:32.518994  / # . /lava-1047658/environment/lava-104765=
8/bin/lava-test-runner /lava-1047658/1
    2023-11-28T22:19:32.520049  =

    2023-11-28T22:19:32.531567  / # /lava-1047658/bin/lava-test-runner /lav=
a-1047658/1 =

    ... (12 line(s) more)  =

 =



platform         | arch  | lab          | compiler | defconfig           | =
regressions
-----------------+-------+--------------+----------+---------------------+-=
-----------
meson-gxm-q200   | arm64 | lab-baylibre | gcc-10   | defconfig           | =
2          =


  Details:     https://kernelci.org/test/plan/id/65665d9e7bff86d6ce7e4a8c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.300/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.300/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/65665d9e7bff86d=
6ce7e4a8f
        failing since 20 days (last pass: v4.19.288, first fail: v4.19.298)
        1 lines

    2023-11-28T21:37:16.787670  kern  :emerg : Disabling IRQ #20
    2023-11-28T21:37:16.788230  <8>[   49.938263] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>
    2023-11-28T21:37:16.788432  + set +x   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65665d9e7bff86d6ce7e4a95
        failing since 8 days (last pass: v4.19.298, first fail: v4.19.299)

    2023-11-28T21:37:16.790602  <8>[   49.942469] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3851685_1.5.2.4.1>
    2023-11-28T21:37:16.894607  / # #
    2023-11-28T21:37:16.995663  export SHELL=3D/bin/sh
    2023-11-28T21:37:16.995992  #
    2023-11-28T21:37:17.096747  / # export SHELL=3D/bin/sh. /lava-3851685/e=
nvironment
    2023-11-28T21:37:17.097074  =

    2023-11-28T21:37:17.197833  / # . /lava-3851685/environment/lava-385168=
5/bin/lava-test-runner /lava-3851685/1
    2023-11-28T21:37:17.198373  =

    2023-11-28T21:37:17.205178  / # /lava-3851685/bin/lava-test-runner /lav=
a-3851685/1
    2023-11-28T21:37:17.274971  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =20

