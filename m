Return-Path: <stable+bounces-6878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B65A8158AF
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 11:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115681C24A82
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 10:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6EF14005;
	Sat, 16 Dec 2023 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Dhdhsvgs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B3215487
	for <stable@vger.kernel.org>; Sat, 16 Dec 2023 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28a5d0ebf1fso2004868a91.0
        for <stable@vger.kernel.org>; Sat, 16 Dec 2023 02:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702723353; x=1703328153; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vznH3SadLA6gCy+XKISRisOKtAQBaNgPYoSkCaDk48I=;
        b=DhdhsvgsuGsMZTyLN66KBI4IxoQ1sFajOg451BdYSr4tUHGaC1yhRikutuLVGqekNr
         2CL1JzbSWrMK9DSbXgydr/LWKeBFMplj6QhsosPYSZ8pET+pBfX6BBGiD2xy5/hoojc/
         Rskcu8JNsZt+kIVj7daT8/m3QIWvcaV/Lr86WQ1/RLgNempoXvoLUrgbotWv3419Qul4
         kYsR7NJKCFy9MkMxylqIVcgz8FsIU5f9RroVMajIP8UtpBcsdKJCA/7lNSb5RuLPjW+V
         9w9UWH+u0mv2M3ebhI/Pmnr8mpXEELYHVl6TWL41Q9zCjxKi7T8kYafCgRYAsL7VCAci
         +mRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702723353; x=1703328153;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vznH3SadLA6gCy+XKISRisOKtAQBaNgPYoSkCaDk48I=;
        b=FquGQ0iN8bGcMgw/vDyIx0iUVObNtdxehq0yDMr8yjjqYbWfHbNAF210eaoIUu5Vq6
         sDjgA29sBd6vaSCj3Z5XBBM9+Q10CS7JAbB3HUqxWcd6yIAFXYEIyg7Y5PntV4UP2oAO
         5j8t7EjtLJd8TqT/28h77q41dXUnlEgKu3L4jsR0qoiMzJ+9eANOgdYOnMnaZ70VJb8j
         xvtufyPYdzdUbl2/5bZW/OWyifr4BSEdtRbHxw0UGV6oss0UJ6JfKdC4x6iT1i59HZdV
         /QhuHHVth80qVRketlJo27WdhNBF1DNYX7GvMjPe1QNsxSUqleHSssayG5SMXX/3HzXB
         R34Q==
X-Gm-Message-State: AOJu0YyMJ4nJwcUW+vpYPma3cl/GhgBfItksSWey6Src9CSm/BYu/Rwp
	ReHZ5SDBUZzpKxSR0TyVDCrBlK9kv3UeZY7Z4bg=
X-Google-Smtp-Source: AGHT+IEQ44EyT7WGKHustrQij6FVwnCnfMLuERxCpehIbuQiH3VD+OeheVj+QlS6x2NCGMrfhubCkw==
X-Received: by 2002:a17:90a:1c96:b0:28b:51c5:6f8 with SMTP id t22-20020a17090a1c9600b0028b51c506f8mr471973pjt.33.1702723353339;
        Sat, 16 Dec 2023 02:42:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 26-20020a17090a191a00b00286e69c8fb1sm17855685pjg.52.2023.12.16.02.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 02:42:32 -0800 (PST)
Message-ID: <657d7f18.170a0220.8d4c2.9b5e@mx.google.com>
Date: Sat, 16 Dec 2023 02:42:32 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.143-46-g7158dd3b52d95
Subject: stable-rc/queue/5.15 baseline: 105 runs,
 3 regressions (v5.15.143-46-g7158dd3b52d95)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 105 runs, 3 regressions (v5.15.143-46-g7158d=
d3b52d95)

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
nel/v5.15.143-46-g7158dd3b52d95/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.143-46-g7158dd3b52d95
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      7158dd3b52d95755f1d2a933caca00028524479c =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657d57aaef17a9205de13475

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-46-g7158dd3b52d95/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-46-g7158dd3b52d95/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657d57aaef17a9205de1347e
        failing since 23 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-16T08:01:33.144027  / # #

    2023-12-16T08:01:33.246130  export SHELL=3D/bin/sh

    2023-12-16T08:01:33.246866  #

    2023-12-16T08:01:33.348312  / # export SHELL=3D/bin/sh. /lava-12285712/=
environment

    2023-12-16T08:01:33.349043  =


    2023-12-16T08:01:33.450518  / # . /lava-12285712/environment/lava-12285=
712/bin/lava-test-runner /lava-12285712/1

    2023-12-16T08:01:33.451626  =


    2023-12-16T08:01:33.467946  / # /lava-12285712/bin/lava-test-runner /la=
va-12285712/1

    2023-12-16T08:01:33.517653  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-16T08:01:33.518175  + cd /lav<8>[   16.035031] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12285712_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657d48a30c15bcde07e134ab

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-46-g7158dd3b52d95/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-46-g7158dd3b52d95/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657d48a30c15bcde07e134b4
        failing since 23 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-16T06:50:00.994229  <8>[   16.138661] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 448349_1.5.2.4.1>
    2023-12-16T06:50:01.099250  / # #
    2023-12-16T06:50:01.201107  export SHELL=3D/bin/sh
    2023-12-16T06:50:01.201670  #
    2023-12-16T06:50:01.302651  / # export SHELL=3D/bin/sh. /lava-448349/en=
vironment
    2023-12-16T06:50:01.303231  =

    2023-12-16T06:50:01.404212  / # . /lava-448349/environment/lava-448349/=
bin/lava-test-runner /lava-448349/1
    2023-12-16T06:50:01.405240  =

    2023-12-16T06:50:01.409363  / # /lava-448349/bin/lava-test-runner /lava=
-448349/1
    2023-12-16T06:50:01.441465  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657d48a9439b778bb1e134eb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-46-g7158dd3b52d95/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.143=
-46-g7158dd3b52d95/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657d48a9439b778bb1e134f4
        failing since 23 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-16T06:57:42.007209  / # #

    2023-12-16T06:57:42.108172  export SHELL=3D/bin/sh

    2023-12-16T06:57:42.108960  #

    2023-12-16T06:57:42.210337  / # export SHELL=3D/bin/sh. /lava-12285710/=
environment

    2023-12-16T06:57:42.210992  =


    2023-12-16T06:57:42.312277  / # . /lava-12285710/environment/lava-12285=
710/bin/lava-test-runner /lava-12285710/1

    2023-12-16T06:57:42.312648  =


    2023-12-16T06:57:42.320830  / # /lava-12285710/bin/lava-test-runner /la=
va-12285710/1

    2023-12-16T06:57:42.386379  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-16T06:57:42.386841  + cd /lava-1228571<8>[   16.815079] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12285710_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

