Return-Path: <stable+bounces-4809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9409D806696
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 06:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E7B1C21163
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 05:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E452DFC0C;
	Wed,  6 Dec 2023 05:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="PMTCpQ/c"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E232E18F
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 21:28:36 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-db537948ea0so4841336276.2
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 21:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701840515; x=1702445315; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hwnxRDek95yiP6aWnXotCYiX9/bBo4wJ7SWzIKgTPQg=;
        b=PMTCpQ/cYbrRikSdUbTm6tN8QlZUesM2W+CSwdnOFP3xr3JoJ2pJlLl6XPesm7uyGC
         EaU3Kbeo2i6cEUUyDpVilZnNYRh6otbepvIPd1tdPByg+1Q1LLxO0lgrtbkOwNhZdK4q
         44LBaZw1JcRu4Y15IREDp6/olHz8/vbJaO1W4SKmYlKna1Zvx6zOlB+qkJKLAj2rKcdk
         5Elk1E9kLnIZNwOdPysbGHCFLFEaOveO5CP3+fQfTmnJAcPV8PQTDiSVdIHzZeR38+HQ
         PBE8uiDRthR8wReWiQV0k4uEXXYss2dz+Sp0BkoYn7kwY83Kq5idrSQpkVSZZFcrA9R/
         n7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701840515; x=1702445315;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hwnxRDek95yiP6aWnXotCYiX9/bBo4wJ7SWzIKgTPQg=;
        b=BsLOotZ9gqoy6gOqLdS9r5CZkY0Jau2svcWtLuMdc25iiKpWHvedGHD2SIy2Odnog4
         vZrCY5jhtD3vJjrkptjCW1/fHwbRO7GispBVWPOCok8swZu3GULtyfEbVBZsVH77kjvH
         psA316lnGY6JUCtL7KOGA8AtN+xd+OegTel/gbnnZt5a5pCDVrJGNCAfNqVpXtGscuxo
         zKpraZZ8vCRJ/9Ogmp1TzgLV/p5Ufr/uoZo1EyXyJtoJrRm4s9aGetBzORHN8YfNMazL
         qH/TFvx5SLekiKKCN9R6IxAJjms5KsT4hAL3O2hsAAFKOINt/wnGOb1OdsIXQwByFvpN
         ickg==
X-Gm-Message-State: AOJu0YzaeQjn9XfkoufyiXszciu6xlXkT5MXUoDBV3nMQBcPd3zhSFIC
	jPhbAyWE5zWUT35ohILDH55JQonGLs2jaWdswIJ3Hw==
X-Google-Smtp-Source: AGHT+IGZDMH7s4dIlL+VRtJhr7fHiLg8Bc+jF26xwMbvZYBE4lfrgMIQqdYdH5fFIYM80E1qV+0K3g==
X-Received: by 2002:a25:2f4d:0:b0:db5:449c:5ebf with SMTP id v74-20020a252f4d000000b00db5449c5ebfmr227724ybv.38.1701840515626;
        Tue, 05 Dec 2023 21:28:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p29-20020a63741d000000b005bd3f34b10dsm5129037pgc.24.2023.12.05.21.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 21:28:35 -0800 (PST)
Message-ID: <65700683.630a0220.1d45e.e844@mx.google.com>
Date: Tue, 05 Dec 2023 21:28:35 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.202-132-g3e5897d7b363
Subject: stable-rc/linux-5.10.y baseline: 157 runs,
 2 regressions (v5.10.202-132-g3e5897d7b363)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y baseline: 157 runs, 2 regressions (v5.10.202-132-g3e=
5897d7b363)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.202-132-g3e5897d7b363/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.202-132-g3e5897d7b363
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3e5897d7b3637fe06435b1b778ed77c76ef7612d =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656fd3ba21a112e78de13539

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-132-g3e5897d7b363/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-132-g3e5897d7b363/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656fd3ba21a112e78de1353e
        failing since 56 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-12-06T01:51:44.684781  <8>[   16.933695] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446710_1.5.2.4.1>
    2023-12-06T01:51:44.789745  / # #
    2023-12-06T01:51:44.891496  export SHELL=3D/bin/sh
    2023-12-06T01:51:44.892097  #
    2023-12-06T01:51:44.993064  / # export SHELL=3D/bin/sh. /lava-446710/en=
vironment
    2023-12-06T01:51:44.993606  =

    2023-12-06T01:51:45.094636  / # . /lava-446710/environment/lava-446710/=
bin/lava-test-runner /lava-446710/1
    2023-12-06T01:51:45.095590  =

    2023-12-06T01:51:45.100069  / # /lava-446710/bin/lava-test-runner /lava=
-446710/1
    2023-12-06T01:51:45.167094  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656fd38d8c7588dbe1e13539

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-132-g3e5897d7b363/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-132-g3e5897d7b363/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656fd38d8c7588dbe1e1353e
        failing since 56 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-12-06T01:58:32.219497  / # #

    2023-12-06T01:58:32.321654  export SHELL=3D/bin/sh

    2023-12-06T01:58:32.322359  #

    2023-12-06T01:58:32.423762  / # export SHELL=3D/bin/sh. /lava-12192675/=
environment

    2023-12-06T01:58:32.424508  =


    2023-12-06T01:58:32.525869  / # . /lava-12192675/environment/lava-12192=
675/bin/lava-test-runner /lava-12192675/1

    2023-12-06T01:58:32.526954  =


    2023-12-06T01:58:32.544049  / # /lava-12192675/bin/lava-test-runner /la=
va-12192675/1

    2023-12-06T01:58:32.584796  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-06T01:58:32.602743  + cd /lava-1219267<8>[   18.225853] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12192675_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

