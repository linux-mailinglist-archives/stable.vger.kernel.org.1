Return-Path: <stable+bounces-3821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CCB8027AB
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 22:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670D01C20961
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 21:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB9A18B19;
	Sun,  3 Dec 2023 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="U55dMHWy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B9EA8
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 13:08:37 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d075359c8dso7686915ad.1
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 13:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701637716; x=1702242516; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BzuCy+4DOf+jNuP/4u3VpN6TDKwUyJ1k6EaFiUGrgLI=;
        b=U55dMHWyv0xQFrIm0/ROVwXepOLG+FzjfehGeJTXsUuEQFiu0zb4onZDUeT8jbsTOQ
         HZUI0zxafEPcCbH+HZh+nZkFqy9+bGWguSPilT4G4GQX29gmMB6RaN7HBjPuEmECRHm4
         MSMNdFbOjLA9hUoJ/FcbQvfC3rjbeOzIwqeOPiolXUwULzq/pftBQzUiEKRnF/ElvPzh
         YXw2Lnhhu4kdJjStLAAv7q3tfPzHdj3Uwh3OX+u3yDHqLT/66w7xz+gQjCQ0ZMYoctAr
         qafmR7TXVrt87unvQoM98jm36y3GwTbw8sX5LEVDQ3539pwyXvtTI7IgOZZwUnvZmZMj
         FBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701637716; x=1702242516;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzuCy+4DOf+jNuP/4u3VpN6TDKwUyJ1k6EaFiUGrgLI=;
        b=bzz/2g6E1BA9MN7UN66EwmOB84ZLpKxDZ/U2jHfebMSh6Q1iQeg4uJHr0VI2CNRO+E
         0IyCCo3Qigy6dlVn8dP988taZbrSQw1QiXEkM7viAQ2H5ZIPjEGX4LQGwJJlc9nsBhl9
         di0HJYUp0sK/FzAJiJ+/fvz50hLSHm20D+iqoxi29pmkmGiTFsQ9bdOmKWe9KaZzmpTc
         gwd1buY9zcynwc+IsNPbiPFm7FQDy7jVhGUIfaBVq3qviDirIwr3yPQDIsY2pXdgNbn9
         g+D9AzU5sQmZbIqO2xCHVXr44f1phq/nBpQaw0fE7iaQt2DkUZoeRVGjAxbIx/0Xh3wr
         bE8A==
X-Gm-Message-State: AOJu0YxhOtkmE/MD1MD3/2o7jB6jt/1Ltw8Fi5M2xcsEueI6ontBpn9C
	wxOoUnLDUssp4i8H2wxHcwKmAGxpQ6O/aDNPi6takg==
X-Google-Smtp-Source: AGHT+IE4KH4jIzlfiyY3Odshts+Ejt0YqnnVFcqo9FHFbdELojlUgNpVS11qArPfsEE0Z7ZCsuuiRA==
X-Received: by 2002:a17:902:e54b:b0:1d0:569f:edf with SMTP id n11-20020a170902e54b00b001d0569f0edfmr3913056plf.14.1701637715980;
        Sun, 03 Dec 2023 13:08:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o7-20020a170902778700b001cfb14a09a4sm6990946pll.126.2023.12.03.13.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 13:08:35 -0800 (PST)
Message-ID: <656cee53.170a0220.9a3bd.2ed5@mx.google.com>
Date: Sun, 03 Dec 2023 13:08:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.141-28-gd850ad6a35f1d
Subject: stable-rc/linux-5.15.y baseline: 131 runs,
 2 regressions (v5.15.141-28-gd850ad6a35f1d)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.15.y baseline: 131 runs, 2 regressions (v5.15.141-28-gd85=
0ad6a35f1d)

Regressions Summary
-------------------

platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 2        =
  =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.141-28-gd850ad6a35f1d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.141-28-gd850ad6a35f1d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d850ad6a35f1d4e6544aad4e6441ea69349e0d21 =



Test Regressions
---------------- =



platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 2        =
  =


  Details:     https://kernelci.org/test/plan/id/656cbc2adc5632023ae13513

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
41-28-gd850ad6a35f1d/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pi=
tx-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
41-28-gd850ad6a35f1d/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pi=
tx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656cbc2adc5632023ae13516
        new failure (last pass: v5.15.141)

    2023-12-03T17:34:09.592569  / # #
    2023-12-03T17:34:09.694617  export SHELL=3D/bin/sh
    2023-12-03T17:34:09.695323  #
    2023-12-03T17:34:09.796800  / # export SHELL=3D/bin/sh. /lava-401437/en=
vironment
    2023-12-03T17:34:09.797508  =

    2023-12-03T17:34:09.898788  / # . /lava-401437/environment/lava-401437/=
bin/lava-test-runner /lava-401437/1
    2023-12-03T17:34:09.899787  =

    2023-12-03T17:34:09.904450  / # /lava-401437/bin/lava-test-runner /lava=
-401437/1
    2023-12-03T17:34:09.966492  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-03T17:34:09.966916  + cd /l<8>[   12.173222] <LAVA_SIGNAL_START=
RUN 1_bootrr 401437_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/656=
cbc2adc5632023ae13526
        new failure (last pass: v5.15.141)

    2023-12-03T17:34:12.294399  /lava-401437/1/../bin/lava-test-case
    2023-12-03T17:34:12.294839  <8>[   14.595272] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-12-03T17:34:12.295192  /lava-401437/1/../bin/lava-test-case   =

 =20

