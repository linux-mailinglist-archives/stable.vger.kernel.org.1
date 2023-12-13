Return-Path: <stable+bounces-6687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0775812397
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 00:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F75FB211F9
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 23:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876C479E18;
	Wed, 13 Dec 2023 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="kLZuo+et"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E5691
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 15:54:09 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ce6caedce6so4963840b3a.3
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 15:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702511648; x=1703116448; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+TFvAYFzwkjtXZKkfoD+mYADrCkNQ+hRBPt/lOZ6uI4=;
        b=kLZuo+etTTQattMlpMYYSupFRG76lNC2DbZQE07C8fdoTtgYmxFreBTovov9y3CENz
         SSfqMaw07dfvTpw0/0pnSVQ1rifwFFFChWWGV1tnnS3/i/iAlLATleDYk28hJks7u6Ul
         m67q6/oRCv4eN25cwJpQQ6SCSMgqSvUjSghX0/LhgAeg80xkigF1DK3acVx8/ex+viHa
         XD8Q1ccgpMyvuMxuS0y9eHo/C4aVvpWDC4rt2cwUKANDL8iMUdqqXyl80mSqpAM9JHiQ
         pEUKBCTJ+VPNZbOJ962TPmDB2DrpXvnzwBHOxfXO/WcYV8IBbpGYEXJrrxQcOj8mtV9H
         HViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702511648; x=1703116448;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TFvAYFzwkjtXZKkfoD+mYADrCkNQ+hRBPt/lOZ6uI4=;
        b=UzYCxUC7QhK4pmUQwdKlbOmarIBD/3ZF+WN5oDasCyP7BozNLfVBVwQzqZ7TGYiKHj
         mcVZ/1wFsObkwcM9WQem1s8/BnbvC0Ex6FodwGRVPvnkZmK8UHKCN2+G0v/J61b7mmTa
         ms4bOyb0SDYs4whNwSCTlLnXPe4yodwVo/DOwqAD1pdNmO9mRyCd0iGr+TkLdH6k4MW8
         NS65rA326K92R3R71VThvl+xlecO34CuWTfeZnGR98QDF+8XP2cgKXVXDv8iE0LlQxcH
         i4sipRycUOFkGJ17AFH0ACVS40vRagaoDIx2XnAaJaTyaFqdZyNflKzdLjbqAGZ7eGfn
         a1jQ==
X-Gm-Message-State: AOJu0YxBk2QVHHDO/icznGOg3xaqOs/TeStIQ/H5LOiqFieesN+rLjuZ
	fk/x6uudEEF+igBlNRrHd0P28rhkuShFvgYeZlN44A==
X-Google-Smtp-Source: AGHT+IH+UA77aLT52SgZrkIhagGkmPj+QC8+bztmhZ9uq40umeCP9Nm9Wu2NtxhfkxJqrNCHMg940g==
X-Received: by 2002:a05:6a20:9149:b0:18f:97c:4f43 with SMTP id x9-20020a056a20914900b0018f097c4f43mr4952220pzc.79.1702511648267;
        Wed, 13 Dec 2023 15:54:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902d51000b001d365153d09sm247915plg.184.2023.12.13.15.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 15:54:07 -0800 (PST)
Message-ID: <657a441f.170a0220.70bfe.1278@mx.google.com>
Date: Wed, 13 Dec 2023 15:54:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.302
Subject: stable/linux-4.19.y baseline: 132 runs, 2 regressions (v4.19.302)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-4.19.y baseline: 132 runs, 2 regressions (v4.19.302)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-10   | defconfig | 1     =
     =

meson-gxm-q200       | arm64 | lab-baylibre | gcc-10   | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/stable/branch/linux-4.19.y/kernel=
/v4.19.302/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-4.19.y
  Describe: v4.19.302
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      f93c1f58eb68bada8c86088104efe14cfe735957 =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/657a0c0a60283beae7e134e5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.302/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.302/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/657a0c0a60283be=
ae7e134e8
        failing since 5 days (last pass: v4.19.298, first fail: v4.19.301)
        3 lines

    2023-12-13T19:54:39.338306  kern  :emerg : Disabling IRQ #19
    2023-12-13T19:54:39.343649  kern  :emerg : Disabling IRQ #20
    2023-12-13T19:54:39.354682  kern  :emerg : Disabling IRQ <8>[   49.7525=
95] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines =
MEASUREMENT=3D3>
    2023-12-13T19:54:39.355256  #18   =

 =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
meson-gxm-q200       | arm64 | lab-baylibre | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/657a0c0660283beae7e134d6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-4.19.y/v4.19.302/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//stable/linux-4.19.y/v4.19.302/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/657a0c0660283be=
ae7e134d9
        failing since 35 days (last pass: v4.19.288, first fail: v4.19.298)
        1 lines

    2023-12-13T19:54:27.494257  kern  :emerg : Disabling IRQ #18
    2023-12-13T19:54:27.495046  <4>[   46.457821] ------------[ cut here ]-=
-----------
    2023-12-13T19:54:27.495679  <4>[   46.457911] WARNING: CPU: 0 PID: 0 at=
 drivers/mmc/host/meson-gx-mmc.c:1039 meson_mmc_irq+0x1c8/0x1dc
    2023-12-13T19:54:27.495890  <8>[   46.458442] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D1>   =

 =20

