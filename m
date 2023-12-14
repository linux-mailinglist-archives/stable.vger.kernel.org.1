Return-Path: <stable+bounces-6771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AC7813C5A
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 22:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0860283798
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 21:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC082BCF8;
	Thu, 14 Dec 2023 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="2xh4Z8lW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5287D6E2D6
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 21:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ce33234fd7so4838243b3a.0
        for <stable@vger.kernel.org>; Thu, 14 Dec 2023 13:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702588125; x=1703192925; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+JKvuQfT9vNMi3oJ0vqtbjC2Pa62bJq87ULYcrpdjmM=;
        b=2xh4Z8lWNR/0ZSfGyLy5VZkfMXeuvadBbKAK1FTZX+KbiLbI7NfnN4DD+Wb1TlMuVe
         RznwjVOp3Jncpzbe3zmXhGJc473/WhR0JJNnm38Ejso4z05XTzKBWBxYM/+WWe1/TA29
         12M9Lfqgp+3U5GIO/jDB880p/Nqh8RI1LgUK7HJ584zYHLyThE6Hc/uulYgd6VYfsquo
         qIad4Wk9IWHGDkrsi1losCnbQGw3Zk36VgUCU4rnxYf0KG8oSywkbygovQjHx54v+opm
         OWc/WgfO95EC5uR2sCv/Ygzd2vJ2UxmUnmI1BLiTbEPQHwMQn7wdR0XUMOobbRCZTZ5N
         TdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702588125; x=1703192925;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JKvuQfT9vNMi3oJ0vqtbjC2Pa62bJq87ULYcrpdjmM=;
        b=MWZxPdlKjsOtbH+6/AZG1/TwqJSIFnVB7C2f6MMrabyf5OrOakbFn7/auIkYIS+lh3
         0cCgROTL8TL6hYHrXsbW6Ekr0PXxKPgQ9jAY+yeRFsdgqxqMkRUnuJry/fygAjaMyxIW
         CCqGI1OgcAGAkpEmY3tcIF8buVvY7G2asJNNEW57OCNc3Tf0pWU+0YwHLPuCOMqETHzj
         UubCMLZoxN+YkzS1KMiPm6GBQAB42debgVZ5mB/BD9E0w0YqRUXFEdzkHcQPHriOrdfw
         sPo9hAjOvLp1+y22yVs4oujMH7YQ/p8yZ9FjviKwJtxB/UEJLmFjfkRFcBPT/QwAv6Ud
         Zyew==
X-Gm-Message-State: AOJu0YxJUIlvetuZ8ytqQj3jxDHb4ybJk7qDaTFfuWKoeKQjPYCk55t7
	CjgTjk7pf+YbI/fHGe6KlKqHR3OOP4lhceehoxU=
X-Google-Smtp-Source: AGHT+IHNoD6Gy6T6KbsKUEG1o1wm6X1JSHtcFHLhohR+1qUIGrSBcvs1wn+KqKZUJwuKMv5TVBsZ/w==
X-Received: by 2002:a05:6a21:6da1:b0:18b:3297:3e1a with SMTP id wl33-20020a056a216da100b0018b32973e1amr5415089pzb.47.1702588125095;
        Thu, 14 Dec 2023 13:08:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b001d1d8f654ccsm12783516plg.31.2023.12.14.13.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 13:08:44 -0800 (PST)
Message-ID: <657b6edc.170a0220.d9448.7f21@mx.google.com>
Date: Thu, 14 Dec 2023 13:08:44 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.68-10-gfcce3e8006ffb
Subject: stable-rc/queue/6.1 baseline: 110 runs,
 4 regressions (v6.1.68-10-gfcce3e8006ffb)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 110 runs, 4 regressions (v6.1.68-10-gfcce3e80=
06ffb)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig | 1      =
    =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.68-10-gfcce3e8006ffb/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.68-10-gfcce3e8006ffb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      fcce3e8006ffb5a4298ac9fe5a60fa68dcf8dd3b =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657b3bfcb1acf82f5de136b8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
-gfcce3e8006ffb/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-im=
x8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
-gfcce3e8006ffb/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-im=
x8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657b3bfcb1acf82f5de13=
6b9
        new failure (last pass: v6.1.67-194-gb1f34ec337363) =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657b3b01bb920ee75ce134fc

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
-gfcce3e8006ffb/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
-gfcce3e8006ffb/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b3b01bb920ee75ce13501
        failing since 22 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-14T17:34:51.227655  / # #

    2023-12-14T17:34:51.328143  export SHELL=3D/bin/sh

    2023-12-14T17:34:51.328289  #

    2023-12-14T17:34:51.428735  / # export SHELL=3D/bin/sh. /lava-12273683/=
environment

    2023-12-14T17:34:51.428859  =


    2023-12-14T17:34:51.529304  / # . /lava-12273683/environment/lava-12273=
683/bin/lava-test-runner /lava-12273683/1

    2023-12-14T17:34:51.529501  =


    2023-12-14T17:34:51.540857  / # /lava-12273683/bin/lava-test-runner /la=
va-12273683/1

    2023-12-14T17:34:51.594210  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T17:34:51.594301  + cd /lav<8>[   19.108804] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12273683_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657b3af8bb920ee75ce134f1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
-gfcce3e8006ffb/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
-gfcce3e8006ffb/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b3af8bb920ee75ce134f6
        failing since 22 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-14T17:27:15.197489  <8>[   18.095868] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 448116_1.5.2.4.1>
    2023-12-14T17:27:15.302410  / # #
    2023-12-14T17:27:15.404011  export SHELL=3D/bin/sh
    2023-12-14T17:27:15.404612  #
    2023-12-14T17:27:15.505588  / # export SHELL=3D/bin/sh. /lava-448116/en=
vironment
    2023-12-14T17:27:15.506175  =

    2023-12-14T17:27:15.607183  / # . /lava-448116/environment/lava-448116/=
bin/lava-test-runner /lava-448116/1
    2023-12-14T17:27:15.608069  =

    2023-12-14T17:27:15.612794  / # /lava-448116/bin/lava-test-runner /lava=
-448116/1
    2023-12-14T17:27:15.691733  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657b3b155fa0147677e13481

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
-gfcce3e8006ffb/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
-gfcce3e8006ffb/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657b3b155fa0147677e13486
        failing since 22 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-14T17:35:02.999762  / # #

    2023-12-14T17:35:03.100311  export SHELL=3D/bin/sh

    2023-12-14T17:35:03.100506  #

    2023-12-14T17:35:03.200979  / # export SHELL=3D/bin/sh. /lava-12273694/=
environment

    2023-12-14T17:35:03.201197  =


    2023-12-14T17:35:03.301683  / # . /lava-12273694/environment/lava-12273=
694/bin/lava-test-runner /lava-12273694/1

    2023-12-14T17:35:03.301982  =


    2023-12-14T17:35:03.313656  / # /lava-12273694/bin/lava-test-runner /la=
va-12273694/1

    2023-12-14T17:35:03.384470  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T17:35:03.384705  + cd /lava-1227369<8>[   19.105193] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12273694_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

