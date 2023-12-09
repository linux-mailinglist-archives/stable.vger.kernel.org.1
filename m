Return-Path: <stable+bounces-5111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7200E80B401
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 12:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A0FB20AED
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 11:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C34213FED;
	Sat,  9 Dec 2023 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="XxGfeT9J"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D86110D8
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 03:33:35 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-58df5988172so1663651eaf.0
        for <stable@vger.kernel.org>; Sat, 09 Dec 2023 03:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702121614; x=1702726414; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OsshStsTQc0qMRLYCSXcgcwOMIk4H7omdQj6vmabu0o=;
        b=XxGfeT9J8Jg+8dVqoOosN4Kkasp99MhA7iHIGy2cHP5JdjdZ146xJpAP/ISvG72sap
         eXvOacuuUIiSdn6dWfVHhSAqPy6yJJyek1a+3NynmX9mgA07eBZMo/6yAlr0x1cb/TuW
         NSC7ZPwrQM07SgBs82+4heIwx+AwQP1cQBPlGrQD1W5P2/GFTKSNHz0abgUWxZzSH4pb
         WQAQ/EQMw/1gdos90HAhvvTgir/NoTbeC45V26C15ofL2CI8GJDk4yODJAmmeCOeq8y8
         sUo30217a9saXHvHQ2ytCuoU7sEx6Y/vXFlUg4S/jwGn1O2dWu0Vh8yRJbASayU+u90J
         NOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702121614; x=1702726414;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsshStsTQc0qMRLYCSXcgcwOMIk4H7omdQj6vmabu0o=;
        b=NW2mw/ZhscMYSXk4Llo3eu/Bbw6iRT1/uAPyMnTy2ko3Xw7SOhfeZb+2uuwVukua/R
         IRXPBD0jkdvCfFJjdJ48nOix4RAqpwlKggQogOorU/r23a6MPBkqCFTQFfyTwtHeWEph
         uSSGA7BpsASK6Zc6/VCOhYMPrtz5iOGEyK5L1mYwh0NBvFx2ch78n0MkvnfMhkN3hoV0
         omyB4RsG/TtuK1VJA+jTbrKSAbc6uA/tJzqaYwZcVEqgmTizDPYCObgdklUoXViqRXKy
         s+U4gfzSVw2NQpMjni4ZeFXibgpyqhcnK3e/RJrH9PUioBZ5K7TLSOAjJgDVU50TbGqd
         TLNg==
X-Gm-Message-State: AOJu0YwQyRgFUMSRQ5MDNee+k/ZXmLtaE34pbU4d/PZYuDk72RAKBphF
	g5n0fkOgcms0iZdBIRkuPxn3ofvjlKZVA0NfJG1j8g==
X-Google-Smtp-Source: AGHT+IFuq0xHZorZDNri3/hZDiWFimlvrWbCBjKgTORP6htFiq13X8K7oLA07ZCAg8T08kME1n4egg==
X-Received: by 2002:a05:6358:881:b0:170:6fc7:c2f2 with SMTP id m1-20020a056358088100b001706fc7c2f2mr1642278rwj.14.1702121613789;
        Sat, 09 Dec 2023 03:33:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id qa6-20020a17090b4fc600b0028613dcb810sm3456708pjb.23.2023.12.09.03.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 03:33:33 -0800 (PST)
Message-ID: <6574508d.170a0220.afda8.ae59@mx.google.com>
Date: Sat, 09 Dec 2023 03:33:33 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.66-98-g1985fd91c0333
Subject: stable-rc/queue/6.1 baseline: 108 runs,
 5 regressions (v6.1.66-98-g1985fd91c0333)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 108 runs, 5 regressions (v6.1.66-98-g1985fd91=
c0333)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
    | regressions
----------------------+-------+---------------+----------+-----------------=
----+------------
beagle-xm             | arm   | lab-baylibre  | gcc-10   | omap2plus_defcon=
fig | 1          =

meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-10   | defconfig       =
    | 1          =

r8a77960-ulcb         | arm64 | lab-collabora | gcc-10   | defconfig       =
    | 1          =

sun50i-h6-pine-h64    | arm64 | lab-clabbe    | gcc-10   | defconfig       =
    | 1          =

sun50i-h6-pine-h64    | arm64 | lab-collabora | gcc-10   | defconfig       =
    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.66-98-g1985fd91c0333/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.66-98-g1985fd91c0333
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      1985fd91c0333212253b0bf5d3d970dbd267553c =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
    | regressions
----------------------+-------+---------------+----------+-----------------=
----+------------
beagle-xm             | arm   | lab-baylibre  | gcc-10   | omap2plus_defcon=
fig | 1          =


  Details:     https://kernelci.org/test/plan/id/65741ccdce8eec5095e1352b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-98=
-g1985fd91c0333/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-98=
-g1985fd91c0333/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle=
-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65741ccdce8eec5095e13=
52c
        failing since 232 days (last pass: v6.1.22-477-g2128d4458cbc, first=
 fail: v6.1.22-474-gecc61872327e) =

 =



platform              | arch  | lab           | compiler | defconfig       =
    | regressions
----------------------+-------+---------------+----------+-----------------=
----+------------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-10   | defconfig       =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/65741c62913df64471e134a3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-98=
-g1985fd91c0333/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-khad=
as-vim2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-98=
-g1985fd91c0333/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-khad=
as-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65741c62913df64471e13=
4a4
        new failure (last pass: v6.1.66-63-gdd66d04a6991a) =

 =



platform              | arch  | lab           | compiler | defconfig       =
    | regressions
----------------------+-------+---------------+----------+-----------------=
----+------------
r8a77960-ulcb         | arm64 | lab-collabora | gcc-10   | defconfig       =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/657421f0ba97ebb79de13559

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-98=
-g1985fd91c0333/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-98=
-g1985fd91c0333/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657421f0ba97ebb79de13562
        failing since 16 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-09T08:21:57.741550  / # #

    2023-12-09T08:21:57.843667  export SHELL=3D/bin/sh

    2023-12-09T08:21:57.844421  #

    2023-12-09T08:21:57.945727  / # export SHELL=3D/bin/sh. /lava-12228494/=
environment

    2023-12-09T08:21:57.946464  =


    2023-12-09T08:21:58.047863  / # . /lava-12228494/environment/lava-12228=
494/bin/lava-test-runner /lava-12228494/1

    2023-12-09T08:21:58.049005  =


    2023-12-09T08:21:58.092823  / # /lava-12228494/bin/lava-test-runner /la=
va-12228494/1

    2023-12-09T08:21:58.114645  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-09T08:21:58.115150  + cd /lava-122284<8>[   19.133096] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 12228494_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform              | arch  | lab           | compiler | defconfig       =
    | regressions
----------------------+-------+---------------+----------+-----------------=
----+------------
sun50i-h6-pine-h64    | arm64 | lab-clabbe    | gcc-10   | defconfig       =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/65741b44ee38f6a81de13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-98=
-g1985fd91c0333/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-98=
-g1985fd91c0333/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65741b44ee38f6a81de1347e
        failing since 16 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-09T07:46:06.401407  <8>[   18.109988] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447261_1.5.2.4.1>
    2023-12-09T07:46:06.506399  / # #
    2023-12-09T07:46:06.608072  export SHELL=3D/bin/sh
    2023-12-09T07:46:06.608727  #
    2023-12-09T07:46:06.709728  / # export SHELL=3D/bin/sh. /lava-447261/en=
vironment
    2023-12-09T07:46:06.710329  =

    2023-12-09T07:46:06.811353  / # . /lava-447261/environment/lava-447261/=
bin/lava-test-runner /lava-447261/1
    2023-12-09T07:46:06.812245  =

    2023-12-09T07:46:06.816595  / # /lava-447261/bin/lava-test-runner /lava=
-447261/1
    2023-12-09T07:46:06.895582  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform              | arch  | lab           | compiler | defconfig       =
    | regressions
----------------------+-------+---------------+----------+-----------------=
----+------------
sun50i-h6-pine-h64    | arm64 | lab-collabora | gcc-10   | defconfig       =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/65741b7377bcdf99e5e13488

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-98=
-g1985fd91c0333/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-98=
-g1985fd91c0333/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65741b7377bcdf99e5e13491
        failing since 16 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-09T07:54:15.258770  / # #

    2023-12-09T07:54:15.359482  export SHELL=3D/bin/sh

    2023-12-09T07:54:15.359745  #

    2023-12-09T07:54:15.460307  / # export SHELL=3D/bin/sh. /lava-12228479/=
environment

    2023-12-09T07:54:15.460437  =


    2023-12-09T07:54:15.560900  / # . /lava-12228479/environment/lava-12228=
479/bin/lava-test-runner /lava-12228479/1

    2023-12-09T07:54:15.561107  =


    2023-12-09T07:54:15.572436  / # /lava-12228479/bin/lava-test-runner /la=
va-12228479/1

    2023-12-09T07:54:15.643224  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-09T07:54:15.643324  + cd /lava-1222847<8>[   19.108683] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12228479_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

