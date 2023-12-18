Return-Path: <stable+bounces-7816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0E381795D
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 19:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B1F2861E8
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 18:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66105BFAE;
	Mon, 18 Dec 2023 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ZOduxbk2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B4F5D735
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3ce28ace2so5654285ad.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 10:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702922671; x=1703527471; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2ks8dLgolHWtVZcn4WdZyGp3NEA2cq8NYB2+MxZ6dYo=;
        b=ZOduxbk2Z4vpld6tphRLTxClg7ybkTM0R+i9K6FEu3EEUVmSD/24N2/SOYlbiDo9AX
         UzjWFHFb1XfgZUYLOic/FI4LWugJ3E1M6lx+cJqqcLwRr3PyfbScH7ET+kH1Oup+LgnZ
         1x9z9MsR3f/b+grM+LsWRf6ciGlXB8L/N6hxq+z67BMIVOaqDSeUdBXEBRot4g0xe4Nn
         hrBM+sq9iQQh2xWzs/aqzp6/3VkpUFn2aXo8jQj8SGhEG0xRc8AjQawx6LN2ckBVCCKF
         eZ9JFtHdJ7Z+e2Fse1gr4JQa1sJEsGy5CSNqqShBDxjI/enhQBa1ed1M9/2HduIKb9wS
         ALug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702922671; x=1703527471;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ks8dLgolHWtVZcn4WdZyGp3NEA2cq8NYB2+MxZ6dYo=;
        b=TPzImpYJ5cHB5E4JtAOtK4xWZf1PzEY8B1IhwVNJ8snMT40nIkz0iFw1PXLk0+Ywwi
         Sdt7iLR0QIDnziIwrAdvuLJmPyrAov/s22ntxw4wh58JmgQlB52VrJYWfS9qVAjJRpTL
         HCkCK2HqO/J46jotpB7ogvPvf2gUsBj53rpcZrl931zxngjHyEi1y90FBUubrlKB9xIq
         IWWO8gg4oeyiHIN7YXloM+Ti0oXHxrVeWzdg7Y/vnHA2c7sN1RqU3sLJizfIuqNjFFZ7
         bWeJF120YDE32f4uEBkhcROJ2qwOp3mnvUCmr2k8zEDJlLehmw6F3Jak1YrGQZE9McB2
         HH2g==
X-Gm-Message-State: AOJu0YwWS77Y/O0xvah/xFo7KbBsUqvmdeubKJRhyi5wllCrj2xw+1D/
	QZxOhpcgrBrjeFegeGKyL0GM/jiDxHPi/O8BauI=
X-Google-Smtp-Source: AGHT+IHu7OmnjvjsfR/jf124twS5BkE985R3gpeE3RcUeZiz6gqsFxpodv2gXqv3HZNKdx7hMBwkIg==
X-Received: by 2002:a17:902:cec8:b0:1d3:6a49:ac0b with SMTP id d8-20020a170902cec800b001d36a49ac0bmr9891843plg.19.1702922671528;
        Mon, 18 Dec 2023 10:04:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v23-20020a170902e8d700b001d05fb4cf2csm19427319plg.15.2023.12.18.10.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 10:04:31 -0800 (PST)
Message-ID: <658089af.170a0220.7504c.949f@mx.google.com>
Date: Mon, 18 Dec 2023 10:04:31 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.204-62-gd1ec28a08d6ea
Subject: stable-rc/queue/5.10 baseline: 48 runs,
 1 regressions (v5.10.204-62-gd1ec28a08d6ea)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 48 runs, 1 regressions (v5.10.204-62-gd1ec28=
a08d6ea)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.204-62-gd1ec28a08d6ea/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.204-62-gd1ec28a08d6ea
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d1ec28a08d6ea016241f2ce60f801546b75de141 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65805f665acfeff476e13499

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-62-gd1ec28a08d6ea/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-62-gd1ec28a08d6ea/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65805f665acfeff476e134cf
        failing since 307 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-18T15:03:49.537173  + set +x
    2023-12-18T15:03:49.541115  <8>[   19.054490] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 368846_1.5.2.4.1>
    2023-12-18T15:03:49.649928  / # #
    2023-12-18T15:03:49.751604  export SHELL=3D/bin/sh
    2023-12-18T15:03:49.752008  #
    2023-12-18T15:03:49.853240  / # export SHELL=3D/bin/sh. /lava-368846/en=
vironment
    2023-12-18T15:03:49.853652  =

    2023-12-18T15:03:49.954976  / # . /lava-368846/environment/lava-368846/=
bin/lava-test-runner /lava-368846/1
    2023-12-18T15:03:49.955586  =

    2023-12-18T15:03:49.959865  / # /lava-368846/bin/lava-test-runner /lava=
-368846/1 =

    ... (12 line(s) more)  =

 =20

