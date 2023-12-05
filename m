Return-Path: <stable+bounces-4693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89826805893
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 16:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33BE91F217C5
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 15:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0848068E8D;
	Tue,  5 Dec 2023 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="EGkVyyYB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D0CB2
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 07:25:27 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d0b2752dc6so16657735ad.3
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 07:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701789927; x=1702394727; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NVuFxujP1SDNkLhki7E0YGwK/2XVcX2cc9LtWeZqgAA=;
        b=EGkVyyYByQ715rnHFwzpvlVJNgyAVwB0j+EVnVX3acZxJU56d2pR1bzSLQZkQF+lKj
         8+o96LXndpyL4CZp0/Eg0QTzXXyA/4Ri13whP7cf9a4MMhjVgBUaiuyXAx7/2RlXXf4g
         nJQcLOIzhR9Xoj8OnPZIckX7TKpcchZKDeq2NlpS1A1hZKZAx0QX9Kdxap4P2FIQKCa+
         6NroBU36h0c0dksdH15dB0VIaP+gN+Q1M5OUhD2f0hPcngcwxY6l4/Kxe22J3gG8VrUh
         amOI/qtYvB675wFIeAtimfEYh9+spEbtRZnGVC0yFJOyah3HWQVxSauSlg6eW0SulIrF
         YAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701789927; x=1702394727;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVuFxujP1SDNkLhki7E0YGwK/2XVcX2cc9LtWeZqgAA=;
        b=qiYRn123F3eL6hv5Oy6IiEjNdfk469F7ipwZbTc625d2nNWxVP9vVGJI50nC4DG0VY
         +HVCf64/VKpYyuFN27TOSHAfzRzir/Onz42a7B4wjHhRIgiyENXS56dcbVqBMMOV7wn6
         UwQKnjop1X4XxSiJb3meep6fXtH5/bS8MFDCt6upUDam2cCxRWJbZnGrW7Ygh04XGBLU
         M7+xdgug4qr/XhFL/EzQ5x5y5uMD8ZCcwOxFynVswxHTNdT3LAq4yjsbFdfgcP2K8YR/
         MbBpDx1HdDRBf6a4XThzbkKlWniy3R5z5RZ2iu/X6aSS7xZ5UKA8eadyrqBz6Og9ifGI
         Czxw==
X-Gm-Message-State: AOJu0YyW6YGxY+nODBXUA534Mr+qcvTWi5OXMH3zO4n6lLcDJx3gG2Z0
	Df6GtgnXVnR63eWxDonFX8Rch+D6R+2vxDq/8olKoA==
X-Google-Smtp-Source: AGHT+IGPPuSwUaj5M4uGACuJUQ/9PupPfABDg/ARyz0hjM0Gw/Jt14Y0vrANWvRrtrVcDYdyrHaMfA==
X-Received: by 2002:a17:902:7043:b0:1d0:6ffd:9e35 with SMTP id h3-20020a170902704300b001d06ffd9e35mr6039018plt.135.1701789927009;
        Tue, 05 Dec 2023 07:25:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902ead200b001cfc19c2d01sm9311382pld.296.2023.12.05.07.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:25:26 -0800 (PST)
Message-ID: <656f40e6.170a0220.85290.abc3@mx.google.com>
Date: Tue, 05 Dec 2023 07:25:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.300-72-g82300ecbea43
Subject: stable-rc/linux-4.19.y baseline: 125 runs,
 2 regressions (v4.19.300-72-g82300ecbea43)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.19.y baseline: 125 runs, 2 regressions (v4.19.300-72-g823=
00ecbea43)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
at91sam9g20ek    | arm  | lab-broonie | gcc-10   | multi_v5_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.300-72-g82300ecbea43/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.300-72-g82300ecbea43
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      82300ecbea435bee3c53b97f701e530cac79b81e =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
at91sam9g20ek    | arm  | lab-broonie | gcc-10   | multi_v5_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/656f0e76c57342177be13485

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-72-g82300ecbea43/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91=
sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-72-g82300ecbea43/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91=
sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656f0e77c57342177be134b7
        failing since 7 days (last pass: v4.19.299-93-g263cae4d5493f, first=
 fail: v4.19.299-93-gc66845304b463)

    2023-12-05T11:49:35.974745  + set +x
    2023-12-05T11:49:35.975286  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 307855_1.5.2=
.4.1>
    2023-12-05T11:49:36.088723  / # #
    2023-12-05T11:49:36.191947  export SHELL=3D/bin/sh
    2023-12-05T11:49:36.192729  #
    2023-12-05T11:49:36.294894  / # export SHELL=3D/bin/sh. /lava-307855/en=
vironment
    2023-12-05T11:49:36.295705  =

    2023-12-05T11:49:36.397843  / # . /lava-307855/environment/lava-307855/=
bin/lava-test-runner /lava-307855/1
    2023-12-05T11:49:36.399324  =

    2023-12-05T11:49:36.402785  / # /lava-307855/bin/lava-test-runner /lava=
-307855/1 =

    ... (12 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/656f102fa32f1595aae1348d

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-72-g82300ecbea43/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
00-72-g82300ecbea43/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656f102fa32f1595aae134bf
        new failure (last pass: v4.19.300-45-gc7158dd8db14c)

    2023-12-05T11:57:09.531052  + set +x<8>[   13.255971] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 308004_1.5.2.4.1>
    2023-12-05T11:57:09.531660  =

    2023-12-05T11:57:09.644315  / # #
    2023-12-05T11:57:09.747452  export SHELL=3D/bin/sh
    2023-12-05T11:57:09.748354  #
    2023-12-05T11:57:09.850486  / # export SHELL=3D/bin/sh. /lava-308004/en=
vironment
    2023-12-05T11:57:09.851399  =

    2023-12-05T11:57:09.953480  / # . /lava-308004/environment/lava-308004/=
bin/lava-test-runner /lava-308004/1
    2023-12-05T11:57:09.954913  =

    2023-12-05T11:57:09.959541  / # /lava-308004/bin/lava-test-runner /lava=
-308004/1 =

    ... (12 line(s) more)  =

 =20

