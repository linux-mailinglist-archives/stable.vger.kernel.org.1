Return-Path: <stable+bounces-2839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B197FAEB0
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 00:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7212B20E51
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 23:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8154649F7C;
	Mon, 27 Nov 2023 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="gDdBZUwV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E13187
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 15:49:29 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3605942a12.3
        for <stable@vger.kernel.org>; Mon, 27 Nov 2023 15:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701128968; x=1701733768; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eSVygo+Olzx5ZtxjrCq5SaUJCIAE1bycQTbI5spXEgA=;
        b=gDdBZUwVRb3sgqp6TS6l//6K+UdZwPA1QCHLms/2Z9Vw/0+gPDVsSQivCBier/MhmJ
         BTliSySsnppHwA/W3NJnYFOGZsg6sJf5yk6LQywfFU/bpUAxPPZEDqODdVm71rfx96bf
         76C8XOEcz6oNQQrOBDFn6CPLP5cSyIo8DTQf182ozYwS7EFZevCctz1Jzy5436RWxHsh
         03OiGUFC2ai8HxDtu503gpotfSSC/Uz1d9wuPEKu/U/XABMOgicEoHAePVnlFYnAvX4K
         OEoaKPp0VQcOVJVqdzuEtv7k7XCePFR4k5Znq4Ii6uvUzfZelFYbsJV06ibKUzqRtqVZ
         bk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701128968; x=1701733768;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eSVygo+Olzx5ZtxjrCq5SaUJCIAE1bycQTbI5spXEgA=;
        b=HEw7TzInDaAornqnPppchNQzXuFg7JQiaS71MrihVM3z993M+h+OqaGDdcun9+x/QN
         MZQTwp1si1Xzem4IKGeqisT4PrDCMNNVCUse2lCeqwq4g/ZMcY4wuCzYc0SxZschy0Uk
         GOhZpWe00n7tDaDjvb0RGB7KW/xlajaT/D9WuqiHvxUGj8FndXLCFUwDxMYaMVFxFKQD
         X2J8AvK8kkvAFG/w+SI2I2ccISa1vemw68+3kTmLS3VMeZgEshSRhZliifj+OVLTI1RL
         mWABtFiJ3zl68ME/iwry+AsPfowMF+x7/WwYU8go+nn1SrZ5XMJLG9zjsdy+p73XvA8+
         ddww==
X-Gm-Message-State: AOJu0YxZdfk9sxYAh82KwQQRi4t1Vw/a7pjvs/S/g40xcdMHPPa1obFK
	ZeipqXHwkOBkDwOJNm1nCuj6ZwrbK7hH23uaLmM=
X-Google-Smtp-Source: AGHT+IGBs1l3qW0BTAsdZMMqYJUJlyo/OyOCpchMu/ZzhJ1sp4xiVM1FIBbktJhSFh/6lmEz5unf8A==
X-Received: by 2002:a17:902:da82:b0:1cc:5674:9184 with SMTP id j2-20020a170902da8200b001cc56749184mr15664621plx.31.1701128968055;
        Mon, 27 Nov 2023 15:49:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902904500b001cf85115f3asm8838591plz.235.2023.11.27.15.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 15:49:27 -0800 (PST)
Message-ID: <65652b07.170a0220.2574.59fe@mx.google.com>
Date: Mon, 27 Nov 2023 15:49:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.63-368-g60c4064a8298e
Subject: stable-rc/linux-6.1.y baseline: 148 runs,
 1 regressions (v6.1.63-368-g60c4064a8298e)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-6.1.y baseline: 148 runs, 1 regressions (v6.1.63-368-g60c40=
64a8298e)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.63-368-g60c4064a8298e/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.63-368-g60c4064a8298e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      60c4064a8298ea9ea75155062f554d2097d8b5e6 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/6564fa2cb4bcd717f47e4a6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.63-=
368-g60c4064a8298e/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.63-=
368-g60c4064a8298e/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6564fa2cb4bcd717f47e4=
a70
        new failure (last pass: v6.1.63-367-g40fd07331b879) =

 =20

