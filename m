Return-Path: <stable+bounces-6933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FD08163B7
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 01:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6921C215C1
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 00:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93692628;
	Mon, 18 Dec 2023 00:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="mLIE8+z5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5356D374
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 00:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d383c7a751so20532735ad.1
        for <stable@vger.kernel.org>; Sun, 17 Dec 2023 16:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702858410; x=1703463210; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NiVQbtPP3P4shwMYv6BbETMdXTQ260CBRLqr0+mQy24=;
        b=mLIE8+z556aTGs7A2DkYUQRyzwZY6NJ8G7KhJglqoFD3+Edq7+3UN6mlhSJuVucTFl
         WQ31GlvHGCpzTu5Nu01viVwonAMSc6yx1XmqTP9RZng5/QQC52IQo5dSjc52ll/vAM/t
         lkADkU6GYFtJJ066c0ZYcJutQSzbe/IrWV7IiXJt2DxzUpwarrHXREr5ao3DJnSJzQ4+
         giAybmqqco/PkI08+0ZbEn/HOetQZ5uRvRWZ8Ujfvqp+zibt1OZfh5dLyLc6gx4uNnfY
         AzrJjs4TITvA/SzdLfskVzvS6QTMkXCCxTLbbOStlgwyRRWbt4iMatjx/xF6+gqsngwY
         qUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702858410; x=1703463210;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NiVQbtPP3P4shwMYv6BbETMdXTQ260CBRLqr0+mQy24=;
        b=UABY4w9CmtVv1z6xRr5V1j+nB4jeYrlVuV/+XmHQWoL2TFCljDx8UfhUW66j/UYYP8
         UZPQ9KhI2T2RUvrjExmNyqONriTHYeg3+DNzIvK5Xjs7uy5uS6DqXkovz0dbncSoaSKs
         RrnrPtLtY89eFbicnLdzGjz+MeHmwnTF6KCfqRqXM9beyOm79iePGYYQayuDTHSxhfK+
         IBafgppOzh0XRlRIjuEwneDmNDHso13HD8EtedsBtuGexGlTl8KFXcWJZCCe8EqwePf3
         PtMdUH4U56q2Tao1s775QvmjgzL4c7mTXvDYPYOhgfN51ngOafZjPzdIG2TFTkAIrKsH
         bT/Q==
X-Gm-Message-State: AOJu0Yzej4wUDZqfw9OzhQnMylBV+aLXzG8GRQ1YOejq1cfjKeylbfFT
	RDgCLm6U5EgHTY7OVxcE1evXi7b6Gp6tZ0ogEWk=
X-Google-Smtp-Source: AGHT+IEGPw+VrF8GwcK/cgmrAGSzJeVWKhh8LMdHoNpw2o5iez1rQV005plIM8ktXUPqTrF/nxvsaA==
X-Received: by 2002:a17:903:228b:b0:1d0:b6d1:d465 with SMTP id b11-20020a170903228b00b001d0b6d1d465mr19583710plh.56.1702858410045;
        Sun, 17 Dec 2023 16:13:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b24-20020a170902b61800b001cfc68aca48sm17640304pls.135.2023.12.17.16.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 16:13:29 -0800 (PST)
Message-ID: <657f8ea9.170a0220.f39a.49f9@mx.google.com>
Date: Sun, 17 Dec 2023 16:13:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.204-56-g66e9372e76961
Subject: stable-rc/queue/5.10 baseline: 46 runs,
 1 regressions (v5.10.204-56-g66e9372e76961)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 46 runs, 1 regressions (v5.10.204-56-g66e937=
2e76961)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.204-56-g66e9372e76961/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.204-56-g66e9372e76961
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      66e9372e7696129bb675a1b93821e3594f96ca0b =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/657f596b717f61265fe134b0

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-56-g66e9372e76961/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-56-g66e9372e76961/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657f596b717f61265fe134e6
        failing since 306 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-17T20:25:59.655654  <8>[   20.190609] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 364654_1.5.2.4.1>
    2023-12-17T20:25:59.763236  / # #
    2023-12-17T20:25:59.865682  export SHELL=3D/bin/sh
    2023-12-17T20:25:59.866309  #
    2023-12-17T20:25:59.967910  / # export SHELL=3D/bin/sh. /lava-364654/en=
vironment
    2023-12-17T20:25:59.968538  =

    2023-12-17T20:26:00.070359  / # . /lava-364654/environment/lava-364654/=
bin/lava-test-runner /lava-364654/1
    2023-12-17T20:26:00.071189  =

    2023-12-17T20:26:00.076460  / # /lava-364654/bin/lava-test-runner /lava=
-364654/1
    2023-12-17T20:26:00.181108  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20

