Return-Path: <stable+bounces-3747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F8F8023FA
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 14:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722F31F210C5
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FA3E555;
	Sun,  3 Dec 2023 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="KNR3kZ1Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E4EFC
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 05:03:10 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6ce4d4c5ea2so9478b3a.0
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 05:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701608589; x=1702213389; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kjMG2sYhaSc+D1CWutGgEHkSb6iOvQx1eaXwsm/gEJ0=;
        b=KNR3kZ1Qz68ZRdFoDyr4lrWvcvohJuL7I4Or4qyyaBzDDYHMoQJ3BHuh/fBgpMHEU7
         ItyAimV1KcWehKjyHs/n8k08+buBpaU00/E5xKF+2fGTtf8DHJ84uCQ0shCu9YVSWeRN
         FbxMIkX2DNgHFuoaIG08KnK6rcR5jDVxWu6CVGuQC3f1OXYFKTdmMXHB+Z26jr7nYea0
         T3jS7DgP5IZQ63xlk8jr9IDOAddTyiAv0flYOV7DUFCZXFTKOgp4eSEndz3TcpGzz8vk
         q8ic0p+4K4kVS59xqs2jHfxUe48rRVYlEiAYCnu+lhEvw60Td8k8DOWyy3AfY4aByy/i
         3Qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701608589; x=1702213389;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjMG2sYhaSc+D1CWutGgEHkSb6iOvQx1eaXwsm/gEJ0=;
        b=nfivGyp2nHz0ZchwTRYSVbDw+nyjV/hPNC8pEQ+X9JU2ufcZgNrgRFJT3K/CIN/ilW
         i1dM0R9kDrOUSAwzM8JXha+1Vqa0Qz+AXFgnRPcpguanjCK4y6h27yjztwycWEqdYs8g
         M7QDvx2AmuLOk5LAjN05UFY/rtC9xSxK/QpIE0TrRzIoE7eg1e5rHuvnJPidRaLXP/Iv
         +4Pn2bF1WITwynm/RoKCGEVyuDC7BbTNLwhfPA4VCafftpNwFDkvEpd4mdSFxx6l3q0/
         dFQAY6QwykFz4DxHLEnVf2rGaod7XSXmbhPpg11x4WTdM6pcyElM0jpjl2GeaaX4ZJhm
         2hQg==
X-Gm-Message-State: AOJu0Ywk8XwYYkNzXukzxNLP+eZDmFmfGLkOfop5I1e9zY8NltCbANLq
	7EYlrtpCaNEVWFtf+S1eNCUNj/H7QGUmIofhR94tXQ==
X-Google-Smtp-Source: AGHT+IG7X1OzJ4lv2qSIJzDxEis2USMDfwXy8keOncjz4dbvmfGuk6fU6HRPWvsUuSrIC5QkDYD6Mg==
X-Received: by 2002:a05:6a20:734d:b0:186:c0fe:b842 with SMTP id v13-20020a056a20734d00b00186c0feb842mr1168512pzc.2.1701608589286;
        Sun, 03 Dec 2023 05:03:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q13-20020a056a0002ad00b006cde7dd80cbsm1863063pfs.191.2023.12.03.05.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 05:03:08 -0800 (PST)
Message-ID: <656c7c8c.050a0220.210d3.3375@mx.google.com>
Date: Sun, 03 Dec 2023 05:03:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.202
Subject: stable-rc/linux-5.10.y baseline: 149 runs, 4 regressions (v5.10.202)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y baseline: 149 runs, 4 regressions (v5.10.202)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
              | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

sun50i-h6-pine-h64       | arm64 | lab-clabbe    | gcc-10   | defconfig    =
              | 1          =

sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.202/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.202
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      479e8b8925415420b31e2aa65f9b0db3dea2adf4 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/6566d5255323c9da4a7e4a80

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6566d5255323c9da4a7e4abe
        new failure (last pass: v5.10.201-185-ga30cecbc89f2f)

    2023-12-03T09:36:28.475201  / # #
    2023-12-03T09:36:28.578133  export SHELL=3D/bin/sh
    2023-12-03T09:36:28.578946  #
    2023-12-03T09:36:28.680849  / # export SHELL=3D/bin/sh. /lava-300390/en=
vironment
    2023-12-03T09:36:28.681652  =

    2023-12-03T09:36:28.783610  / # . /lava-300390/environment/lava-300390/=
bin/lava-test-runner /lava-300390/1
    2023-12-03T09:36:28.784895  =

    2023-12-03T09:36:28.797975  / # /lava-300390/bin/lava-test-runner /lava=
-300390/1
    2023-12-03T09:36:28.858784  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-03T09:36:28.859298  + cd /lava-300390/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6566d673d8fb5b2b027e4aa1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope=
-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-r8a774b1-hihope=
-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6566d673d8fb5b2b027e4=
aa2
        new failure (last pass: v5.10.202-71-ga7f0dd50ec8cc) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
sun50i-h6-pine-h64       | arm64 | lab-clabbe    | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/6566d3c89370224a937e4a73

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6566d3c89370224a937e4a7c
        failing since 49 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-12-03T09:31:02.824042  <8>[   16.984061] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446316_1.5.2.4.1>
    2023-12-03T09:31:02.929069  / # #
    2023-12-03T09:31:03.030768  export SHELL=3D/bin/sh
    2023-12-03T09:31:03.031470  #
    2023-12-03T09:31:03.132458  / # export SHELL=3D/bin/sh. /lava-446316/en=
vironment
    2023-12-03T09:31:03.133080  =

    2023-12-03T09:31:03.234076  / # . /lava-446316/environment/lava-446316/=
bin/lava-test-runner /lava-446316/1
    2023-12-03T09:31:03.234960  =

    2023-12-03T09:31:03.239228  / # /lava-446316/bin/lava-test-runner /lava=
-446316/1
    2023-12-03T09:31:03.306332  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/6566d3e64e65403d3e7e4ab9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6566d3e64e65403d3e7e4ac2
        failing since 49 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-12-03T09:37:47.957235  / # #

    2023-12-03T09:37:48.059247  export SHELL=3D/bin/sh

    2023-12-03T09:37:48.059936  #

    2023-12-03T09:37:48.161199  / # export SHELL=3D/bin/sh. /lava-12166831/=
environment

    2023-12-03T09:37:48.161897  =


    2023-12-03T09:37:48.263308  / # . /lava-12166831/environment/lava-12166=
831/bin/lava-test-runner /lava-12166831/1

    2023-12-03T09:37:48.264385  =


    2023-12-03T09:37:48.281140  / # /lava-12166831/bin/lava-test-runner /la=
va-12166831/1

    2023-12-03T09:37:48.321641  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-03T09:37:48.340546  + cd /lava-1216683<8>[   18.226294] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12166831_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

