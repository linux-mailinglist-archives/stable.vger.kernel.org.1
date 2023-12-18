Return-Path: <stable+bounces-6935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3815E8163D9
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 01:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548951C212A4
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 00:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA5C80E;
	Mon, 18 Dec 2023 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="BEoParDz"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32FF64E
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 00:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-591a6f1385eso1624660eaf.0
        for <stable@vger.kernel.org>; Sun, 17 Dec 2023 16:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702860068; x=1703464868; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bWpmLKaQpoM0zf03W0+JenLhHZDCgQg27E9qhMEs4A0=;
        b=BEoParDz13euR71HMI8qiOrTclmSzmILrYk4lxmQid258GJI7npc7iuDOUKhBgXg43
         vdITD786THhNu3O5Mi4vYKodb1Ngf8y3Ncl4PetwqIqHvJMNiii34CxdUuR1KeQUu3Ws
         agrd+qwsRY/KAWYdPlxvQgy3kKOSBmCNTL8WmZlER1t/mxDgFfHVLogOF/0YE30Pil1m
         UuykwM3uobi+5sJv+Jf/txMs3z4KubEG5vrpZBy9WI0Ii4FKDqOu2oUN/miTQKM+Dzah
         HrX+GHqtzG68GdyAZq5qX+4SDPMwdgHdKvlgEsszBYPUq2rEHwAn+RzX7sgsgGIwx9Ua
         2p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702860068; x=1703464868;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWpmLKaQpoM0zf03W0+JenLhHZDCgQg27E9qhMEs4A0=;
        b=nKs7Zsfu61/JUbg87yWcC/efjZLv/7nb7buPM4Q6tF7xfwwtKZ8uJS/yt+Az5eLR/f
         959VtUnZx31AkxIHkzJ34Bn772hHk2FkcKhYy8fItIkz4qYMIM2omICpPCTEuK3a/pIO
         d9UgfV1suptOi8BBLk/yCNscte4VXEa+dVN5/ifGUgyUFtEekAgZHRnGUXsXHytvp4Yf
         v5fZsw31xJLc/vwzKHb6f+oKwRNo57A428bj9Q+GyRz9eGsZ7XYAx1qzCyI0MU4LWlId
         zj6XkZy052UnKtQ8ljRLgN3iapH5OxWFKVfpEmo+FVDTaD1Y7KsTaU46/7paGFAdVn5G
         w+1w==
X-Gm-Message-State: AOJu0YyMeMMOrI5OblnL554HjGvR5upTSUt4Bm0uVxlfwrDMjfu5hyMt
	jJ9OwnjV2ISKnC3Ud1oAIAFw/tChemnam0q+pzM=
X-Google-Smtp-Source: AGHT+IFukY1VsyziwGehEWqAmMRSxCF4K0jFM2g4aj0ZTbyPYKuy/NZm9FTe7W1WxtI6tjJkqIOUPA==
X-Received: by 2002:a05:6358:787:b0:170:b81b:4a20 with SMTP id n7-20020a056358078700b00170b81b4a20mr15897755rwj.51.1702860068426;
        Sun, 17 Dec 2023 16:41:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id qi9-20020a17090b274900b0028a28ad810csm18613663pjb.56.2023.12.17.16.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 16:41:07 -0800 (PST)
Message-ID: <657f9523.170a0220.5f114.77b0@mx.google.com>
Date: Sun, 17 Dec 2023 16:41:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.143-70-gfaee57311dcc8
Subject: stable-rc/queue/5.15 baseline: 108 runs,
 3 regressions (v5.15.143-70-gfaee57311dcc8)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 108 runs, 3 regressions (v5.15.143-70-gfaee5=
7311dcc8)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.143-70-gfaee57311dcc8/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.143-70-gfaee57311dcc8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      faee57311dcc8e2c09f9f6d83c7e8342f498f616 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657f5f9eb23f080417e134b1

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-70-gfaee57311dcc8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-70-gfaee57311dcc8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657f5f9eb23f080417e134b4
        failing since 25 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-17T20:59:53.894310  / # #

    2023-12-17T20:59:53.994803  export SHELL=3D/bin/sh

    2023-12-17T20:59:53.994902  #

    2023-12-17T20:59:54.095301  / # export SHELL=3D/bin/sh. /lava-12295068/=
environment

    2023-12-17T20:59:54.095423  =


    2023-12-17T20:59:54.195863  / # . /lava-12295068/environment/lava-12295=
068/bin/lava-test-runner /lava-12295068/1

    2023-12-17T20:59:54.196058  =


    2023-12-17T20:59:54.208019  / # /lava-12295068/bin/lava-test-runner /la=
va-12295068/1

    2023-12-17T20:59:54.248386  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-17T20:59:54.267015  + cd /lav<8>[   15.972469] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12295068_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657f5f99b23f080417e13497

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-70-gfaee57311dcc8/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-70-gfaee57311dcc8/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657f5f99b23f080417e1349c
        failing since 25 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-17T20:52:20.775616  <8>[   16.070093] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 448517_1.5.2.4.1>
    2023-12-17T20:52:20.880504  / # #
    2023-12-17T20:52:20.982130  export SHELL=3D/bin/sh
    2023-12-17T20:52:20.982735  #
    2023-12-17T20:52:21.083719  / # export SHELL=3D/bin/sh. /lava-448517/en=
vironment
    2023-12-17T20:52:21.084328  =

    2023-12-17T20:52:21.185330  / # . /lava-448517/environment/lava-448517/=
bin/lava-test-runner /lava-448517/1
    2023-12-17T20:52:21.186218  =

    2023-12-17T20:52:21.190938  / # /lava-448517/bin/lava-test-runner /lava=
-448517/1
    2023-12-17T20:52:21.258976  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657f5f9d575c8572ace13574

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-70-gfaee57311dcc8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-70-gfaee57311dcc8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657f5f9d575c8572ace13579
        failing since 25 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-17T21:00:07.694360  / # #

    2023-12-17T21:00:07.796369  export SHELL=3D/bin/sh

    2023-12-17T21:00:07.796601  #

    2023-12-17T21:00:07.897196  / # export SHELL=3D/bin/sh. /lava-12295065/=
environment

    2023-12-17T21:00:07.897440  =


    2023-12-17T21:00:07.998174  / # . /lava-12295065/environment/lava-12295=
065/bin/lava-test-runner /lava-12295065/1

    2023-12-17T21:00:07.998597  =


    2023-12-17T21:00:08.002354  / # /lava-12295065/bin/lava-test-runner /la=
va-12295065/1

    2023-12-17T21:00:08.044815  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-17T21:00:08.076356  + cd /lava-1229506<8>[   16.821339] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12295065_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

