Return-Path: <stable+bounces-5260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEECA80C2BD
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 09:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BA8280D5D
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 08:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4CB20B21;
	Mon, 11 Dec 2023 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="osdl/qSp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABF2ED
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 00:08:37 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d30b544b35so2223205ad.2
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 00:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702282116; x=1702886916; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gJcbIOzMD2rHmLq4YQbEA3PdVg8acsg7NzbDCYhEjq0=;
        b=osdl/qSp5qbefnb56szs8LlQuTNwG9tQ707JCxH6bRAnel3yldMWmkCr2+c/mGaXrM
         b6KyNpwBsl+2AA63t01tKn0Sk0wjEINTSezv7BtfAFbd893/m8AGKSbziYYj8fYVkz+3
         mn4ryfPn55nXjo/UZRdEsUlS6fM2/6TKcc4rAKSdpNHAh3oc/mx9KzTJR2oPWXSJhRUQ
         koDm5zU9JQ72hL3MLMwV98iNcKhhqVn2ORvx1iRWzOkYa7DCDVtPcu6usuoxInRoeJIS
         cWxzDQbT/WzrQXMQLDJXIdv8+mMZ+Kk1PEML19uYp00L/y02O+JTvoX8eAVVPfXuCb4E
         FL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702282116; x=1702886916;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJcbIOzMD2rHmLq4YQbEA3PdVg8acsg7NzbDCYhEjq0=;
        b=r6vRBRNcUhT0qKI22Gn+xRTeeXPcemzoSrHCh2z8xpeoR6Anz6tPX0tOVNpUJJY3sm
         X5w4gtWyTKIPGiv86o2K0WNVdCd7TKX6tRkk8HibDxOu5nJd1WdUquNaUYIXkeP00hlT
         XPohgcsK6o3s+KRWfvjOAsAx811/CN9p3aJ7O1Er6XLdAv3OrTim5AprTm8rABWq60FM
         ptbWkh1ZrN+I3xTJyrWQ1Y+iUz4hL/wXHu+VhaaTn4Hdl9bJrk2r0AUznJvpn/iKy/dE
         4Lf8H9uHTbN0K9kPKnIsm8ssqrZEGeu85Ec5eDsHZdrtmBNlQv8Tn6ao5ZefAv+RpsFT
         JKGA==
X-Gm-Message-State: AOJu0YyUQsFX5BccMeC6Sxc/8r9vQFngsNwILh0t+ZJAauYTI5ZheKF9
	uqlMSzSyIGFmWEl+vlUfEyid8QfvzovhnLmpxghuNw==
X-Google-Smtp-Source: AGHT+IE44CH+P34xJ/c6zSgA8DGwex4VDpW7o98OiZ2UlAHTQFEqDGnmBN/EhG/jNDj90zI57OTVGQ==
X-Received: by 2002:a17:902:728e:b0:1d0:6ffd:f21c with SMTP id d14-20020a170902728e00b001d06ffdf21cmr1511050pll.114.1702282116412;
        Mon, 11 Dec 2023 00:08:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d90300b001d1db5e39a6sm5988173plz.59.2023.12.11.00.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 00:08:35 -0800 (PST)
Message-ID: <6576c383.170a0220.fe9c9.0405@mx.google.com>
Date: Mon, 11 Dec 2023 00:08:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.66-149-gd84f8303168b1
Subject: stable-rc/queue/6.1 baseline: 104 runs,
 4 regressions (v6.1.66-149-gd84f8303168b1)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 104 runs, 4 regressions (v6.1.66-149-gd84f830=
3168b1)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.66-149-gd84f8303168b1/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.66-149-gd84f8303168b1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d84f8303168b150ca33fdfccf7faba4087b8b54a =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65768e165a3de537cce13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-14=
9-gd84f8303168b1/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-14=
9-gd84f8303168b1/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65768e165a3de537cce13=
476
        failing since 234 days (last pass: v6.1.22-477-g2128d4458cbc, first=
 fail: v6.1.22-474-gecc61872327e) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65768df2f6d98014d1e13498

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-14=
9-gd84f8303168b1/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-14=
9-gd84f8303168b1/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65768df2f6d98014d1e1349d
        failing since 18 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-11T04:27:18.793601  / # #

    2023-12-11T04:27:18.895769  export SHELL=3D/bin/sh

    2023-12-11T04:27:18.896530  #

    2023-12-11T04:27:18.997973  / # export SHELL=3D/bin/sh. /lava-12241417/=
environment

    2023-12-11T04:27:18.998689  =


    2023-12-11T04:27:19.100144  / # . /lava-12241417/environment/lava-12241=
417/bin/lava-test-runner /lava-12241417/1

    2023-12-11T04:27:19.101272  =


    2023-12-11T04:27:19.117835  / # /lava-12241417/bin/lava-test-runner /la=
va-12241417/1

    2023-12-11T04:27:19.166606  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-11T04:27:19.167117  + cd /lav<8>[   19.070139] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12241417_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65768de78ad7279522e13540

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-14=
9-gd84f8303168b1/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-14=
9-gd84f8303168b1/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65768de78ad7279522e13545
        failing since 18 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-11T04:19:45.674898  <8>[   18.079794] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447553_1.5.2.4.1>
    2023-12-11T04:19:45.779891  / # #
    2023-12-11T04:19:45.881515  export SHELL=3D/bin/sh
    2023-12-11T04:19:45.882151  #
    2023-12-11T04:19:45.983130  / # export SHELL=3D/bin/sh. /lava-447553/en=
vironment
    2023-12-11T04:19:45.983713  =

    2023-12-11T04:19:46.084720  / # . /lava-447553/environment/lava-447553/=
bin/lava-test-runner /lava-447553/1
    2023-12-11T04:19:46.085577  =

    2023-12-11T04:19:46.090130  / # /lava-447553/bin/lava-test-runner /lava=
-447553/1
    2023-12-11T04:19:46.163112  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65768df4ee66168860e134de

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-14=
9-gd84f8303168b1/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-14=
9-gd84f8303168b1/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65768df4ee66168860e134e3
        failing since 18 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-11T04:27:33.416077  / # #

    2023-12-11T04:27:33.518099  export SHELL=3D/bin/sh

    2023-12-11T04:27:33.518760  #

    2023-12-11T04:27:33.619972  / # export SHELL=3D/bin/sh. /lava-12241419/=
environment

    2023-12-11T04:27:33.620676  =


    2023-12-11T04:27:33.721751  / # . /lava-12241419/environment/lava-12241=
419/bin/lava-test-runner /lava-12241419/1

    2023-12-11T04:27:33.721957  =


    2023-12-11T04:27:33.764357  / # /lava-12241419/bin/lava-test-runner /la=
va-12241419/1

    2023-12-11T04:27:33.803402  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-11T04:27:33.803483  + cd /lava-1224141<8>[   19.173813] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12241419_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

