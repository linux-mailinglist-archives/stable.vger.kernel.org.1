Return-Path: <stable+bounces-6989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD024816C19
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 12:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BCD1C23199
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 11:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5857F19458;
	Mon, 18 Dec 2023 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="dwvihh5T"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3662199BF
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cd82917ecfso1308080a12.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 03:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702898520; x=1703503320; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5mJrrgKkKl/1iDMJNYkAFkR4277123PfvU2U2DIy2k8=;
        b=dwvihh5TYPmIu/ndlj/y3plowCFHgl0WZa6QIUw+CMNOisTMTwa2fGowItQm1wUfNn
         /umR36A7I0HM+Tdc8L92VmhGU7d3lJNMtE+wz+6n4J8kroAQuxTlObboS0HGhpP7uCop
         XRZlnug/uqtf3dv3FbS1baLUdLof+p5sTO1TC5Znbej34a/ljp6y7k3wL2iFLCRTA9cv
         dlRUjY+jDQTVDlrtObLgOP9Y2nr56EaFi0+mQrfb6BsvI5WXiYbnt3+zNEeN4Vf1rz4R
         ms/9DMXHMrWYt9UppodRVRwOCia/qHXXIMqFVNEL7v6uEhBvOLV9DN2fRVaw0/9DRNw2
         HrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702898520; x=1703503320;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mJrrgKkKl/1iDMJNYkAFkR4277123PfvU2U2DIy2k8=;
        b=e14K4L09laItDQUsrnHaeOhIr50HN6UXcq/bdEQESIum4gr78GpQ0V/pFUAdeFGpyf
         Fkl82PCuhMCJ12Mcp9D8CcSUZUzzSDQQSJ7r4wVK+AaqO8QFXsUSAizLnbpWPBpvvO/y
         MbHdpFbUQdjNGallb4paKJPC6QGm27A33M8pCvUWO8S3s9Wc3jWdjRGaXXHBZWifyG8J
         HcZsxv+sWaM90CwdA61ZhH1lgjHmTrhUlFdGovXk2Zwd538ywcSoJfjwc6GCzM4FyFbm
         jYuArH+VPlQPnQaDRKyL62FsMX74sA/Eq3w3EMfUGXR2HVIzcg/22yZgimPKQxa6MzTg
         Rwqw==
X-Gm-Message-State: AOJu0YyTr3MgA9+OlkUltCDEfG0LgsJlY84cEAolW618+l5OMlF0fPUa
	oj8fu7YuLBs2sRBUknpXzyyyb/WGoaI/qtmfP80=
X-Google-Smtp-Source: AGHT+IFVRlDvvapStG6bDo//OgxCSJ8pFObZ7sA1PI0c8TjgUJRNBr9Xx19mBLZ8tunUBQ1HQTWANQ==
X-Received: by 2002:a17:903:1205:b0:1d0:af43:9354 with SMTP id l5-20020a170903120500b001d0af439354mr18429086plh.100.1702898520520;
        Mon, 18 Dec 2023 03:22:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v21-20020a17090a899500b0028b73564d7dsm2457806pjn.24.2023.12.18.03.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 03:22:00 -0800 (PST)
Message-ID: <65802b58.170a0220.c4717.4a45@mx.google.com>
Date: Mon, 18 Dec 2023 03:22:00 -0800 (PST)
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
X-Kernelci-Kernel: v4.19.302-32-gb2fab883a7817
Subject: stable-rc/linux-4.19.y baseline: 94 runs,
 1 regressions (v4.19.302-32-gb2fab883a7817)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.19.y baseline: 94 runs, 1 regressions (v4.19.302-32-gb2fa=
b883a7817)

Regressions Summary
-------------------

platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.302-32-gb2fab883a7817/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.302-32-gb2fab883a7817
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b2fab883a7817921e05d3919787ef3d00196948c =



Test Regressions
---------------- =



platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/657ffa2af1b48003cce13493

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
02-32-gb2fab883a7817/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
02-32-gb2fab883a7817/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657ffa2af1b48003cce134c5
        failing since 20 days (last pass: v4.19.299-93-g263cae4d5493f, firs=
t fail: v4.19.299-93-gc66845304b463)

    2023-12-18T07:51:31.684299  + set +x
    2023-12-18T07:51:31.684755  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 366511_1.5.2=
.4.1>
    2023-12-18T07:51:31.797134  / # #
    2023-12-18T07:51:31.900063  export SHELL=3D/bin/sh
    2023-12-18T07:51:31.900952  #
    2023-12-18T07:51:32.003033  / # export SHELL=3D/bin/sh. /lava-366511/en=
vironment
    2023-12-18T07:51:32.003895  =

    2023-12-18T07:51:32.105964  / # . /lava-366511/environment/lava-366511/=
bin/lava-test-runner /lava-366511/1
    2023-12-18T07:51:32.107404  =

    2023-12-18T07:51:32.111018  / # /lava-366511/bin/lava-test-runner /lava=
-366511/1 =

    ... (12 line(s) more)  =

 =20

