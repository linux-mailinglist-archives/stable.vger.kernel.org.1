Return-Path: <stable+bounces-8211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3133281ABE5
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 01:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC51228783B
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 00:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52AA64F;
	Thu, 21 Dec 2023 00:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="3dknGsKz"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89612912
	for <stable@vger.kernel.org>; Thu, 21 Dec 2023 00:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7b7fdde8b56so14802539f.1
        for <stable@vger.kernel.org>; Wed, 20 Dec 2023 16:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703119920; x=1703724720; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jgqbvg3qTqKEpVmknKHDPC3PrF6RkmJPcOA9pi8liDY=;
        b=3dknGsKzetqzWb9vJe7taaJnfpqFO+mKW+Rk1hc7OMQxAfouH6ITxfoEGkDkD/VB4P
         M66g57+0nMfnwKe8beNuVnV9Ne9zalnELkJ2ltVn6Vn7fGUsB1BmCyzDyy2RykuSTE9L
         rFtYEADHzPAPqM84sMW1xFdCBWwzjoxI5KdosAjRoUy3pneUL9CFVPuLDXUgZmrQA6X6
         RzbzPwdlikk/96p1U9VndFfjqAUUIliAUk372LF0fo7iCzXMNAdobVJFjvUB0Y+I/Ki9
         CUx848nmAHCoYIoUwHifzRj7mywBe3kPlsyWVnsc34s+Qexwpz21/FFCKtg6ItcrjQTF
         K2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703119920; x=1703724720;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgqbvg3qTqKEpVmknKHDPC3PrF6RkmJPcOA9pi8liDY=;
        b=eibGxVNmRUHQ6tQLhlcpp/12SlneRx+xP4lS2I9tIweacNPWwwvhWKjwSDpA9Lk3ad
         7QQ0xiZMkQuOMdW7LunO8PArjHkixR+YEdl8bd9vYPkRUoI45hUghZpttDWOq07XXqmR
         QjROiZ2IdKz4gYxckgifWl2bz8qp21bThV0toMnW/5OLmdNHUMgTzpgMmif1mha8wM85
         0GffMSg3BSdeYT1oWAMGBGd4GbcYVUE5x0ZZV3MlNGoS8knjZ1mt5uZwgJqviZFvvYve
         WR4Vfsk7VojiYSuKZkzpu+b56z6sYU2VMSnA284vmQQBcEgh+ZZ6hFeN5zT4ZGcClgz7
         DnHQ==
X-Gm-Message-State: AOJu0YyB/OPwBwEovPEW77HAuSAq0kTwOuWZWsGdNBaggp5laNU6oYi/
	vpduGwxtqay++8QHVmRJGcqgZGp5t6zHX+JYmGE=
X-Google-Smtp-Source: AGHT+IH5L6kktU1NMq7eoVc/LUqHTrREpZfIWuYZ3Pk8+3nUPPlgDkc6c5Wl/64hJIYdRuAQrk1pMA==
X-Received: by 2002:a05:6e02:18c7:b0:35f:cb0b:d4ce with SMTP id s7-20020a056e0218c700b0035fcb0bd4cemr2294818ilu.123.1703119920302;
        Wed, 20 Dec 2023 16:52:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e5c100b001d3e2578e66sm313187plf.243.2023.12.20.16.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 16:51:59 -0800 (PST)
Message-ID: <65838c2f.170a0220.3345c.1833@mx.google.com>
Date: Wed, 20 Dec 2023 16:51:59 -0800 (PST)
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
X-Kernelci-Kernel: v4.19.302-36-g2fba28e43c215
Subject: stable-rc/linux-4.19.y baseline: 91 runs,
 2 regressions (v4.19.302-36-g2fba28e43c215)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.19.y baseline: 91 runs, 2 regressions (v4.19.302-36-g2fba=
28e43c215)

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
nel/v4.19.302-36-g2fba28e43c215/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.302-36-g2fba28e43c215
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      2fba28e43c215b728400054b0f62c3c9024b541f =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
at91sam9g20ek    | arm  | lab-broonie | gcc-10   | multi_v5_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65835a3f9a1d55cc8ee1349d

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
02-36-g2fba28e43c215/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
02-36-g2fba28e43c215/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at9=
1sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65835a3f9a1d55cc8ee134cf
        failing since 22 days (last pass: v4.19.299-93-g263cae4d5493f, firs=
t fail: v4.19.299-93-gc66845304b463)

    2023-12-20T21:18:15.463535  + set +x
    2023-12-20T21:18:15.464056  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 379349_1.5.2=
.4.1>
    2023-12-20T21:18:15.576201  / # #
    2023-12-20T21:18:15.678910  export SHELL=3D/bin/sh
    2023-12-20T21:18:15.679686  #
    2023-12-20T21:18:15.781595  / # export SHELL=3D/bin/sh. /lava-379349/en=
vironment
    2023-12-20T21:18:15.782447  =

    2023-12-20T21:18:15.884407  / # . /lava-379349/environment/lava-379349/=
bin/lava-test-runner /lava-379349/1
    2023-12-20T21:18:15.885719  =

    2023-12-20T21:18:15.889340  / # /lava-379349/bin/lava-test-runner /lava=
-379349/1 =

    ... (12 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65835b8db7c8a5e9f1e13484

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
02-36-g2fba28e43c215/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
02-36-g2fba28e43c215/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65835b8db7c8a5e9f1e134b6
        failing since 2 days (last pass: v4.19.302-32-gb2fab883a7817, first=
 fail: v4.19.302-37-gc6ac8872cc6c4)

    2023-12-20T21:24:06.638482  + set +x<8>[   17.196179] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 379430_1.5.2.4.1>
    2023-12-20T21:24:06.638907  =

    2023-12-20T21:24:06.749109  / # #
    2023-12-20T21:24:06.851635  export SHELL=3D/bin/sh
    2023-12-20T21:24:06.852138  #
    2023-12-20T21:24:06.954050  / # export SHELL=3D/bin/sh. /lava-379430/en=
vironment
    2023-12-20T21:24:06.954634  =

    2023-12-20T21:24:07.056520  / # . /lava-379430/environment/lava-379430/=
bin/lava-test-runner /lava-379430/1
    2023-12-20T21:24:07.057254  =

    2023-12-20T21:24:07.061931  / # /lava-379430/bin/lava-test-runner /lava=
-379430/1 =

    ... (12 line(s) more)  =

 =20

