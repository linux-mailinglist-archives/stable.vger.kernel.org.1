Return-Path: <stable+bounces-2843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D547FAF63
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 02:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD1F1C20C07
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 01:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7090615C9;
	Tue, 28 Nov 2023 01:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="LdPENrtM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5D6C2
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 17:08:39 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfc1512df1so14773375ad.2
        for <stable@vger.kernel.org>; Mon, 27 Nov 2023 17:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701133719; x=1701738519; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fPpGILtLRtc2JKAZk+wS5JiLcn8NSyRaL4fa5c3U7g0=;
        b=LdPENrtMzlQHyX6jWSPUTtrFS1Ps9XNKeSHL0FlxhZ86Od+6V3vV39n7u5q9vQSlNr
         LY70WJyJyEO7Zd6NVl9NfqRrgcqyjtuti7ZVT6xU1/eoy1NhTpXUF+ISDIM49nKZsG2G
         ZBzSEVIKrEtLGv7xuuKqbHwiAFlquMLiYsAjpYTsNTveb5oVmvV/1iZiiiTNbUk3lnqd
         sVFgtMz8KnX0RMpckLVM3dUO3Q6z19E1jiGWeOpTc8fuC6FKoWxqXwRxUC2aJxEAePTE
         Q6qnx9GwK48JC3s2otmGx40gzIjwMn/liatURkd/sn2igNkdBE+SHmG+xglobItl7Sqz
         DEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701133719; x=1701738519;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPpGILtLRtc2JKAZk+wS5JiLcn8NSyRaL4fa5c3U7g0=;
        b=cfUFwBDYQQfi0HlaL4ZY5Of14WbBXoRrPFxov16q6hzsmHoao1K+kr8SjJhvVYfqFC
         mBk6AVf/Ny211eWu9K9Hque+R86pCBjjXpYjAnTbPmlPWQz62EB6iQFk6O1RmpcwW8g4
         rzzlPM+r/OxyyvEP2I5+C04hi4vwLGYlFLvLPsFFZRkOYrLGafZAkMgrHvyolA9wHHBl
         H0nE5Lt77IgrS2RUet5mUY9XQ0UxT12po5roq4JKdwdgjRURp3qsSG8W4tUX9otY+7O/
         oBY3NTFPcZTaCqg2nfLcC+1ZTCiGUSZ07epGlAYzTYDaVyKRb6fiRw8q/ugIOLR4CWiW
         q23g==
X-Gm-Message-State: AOJu0YzumZNTzivhg8kNLB3iBmU6mVCliML8MS83ZUdwsqZUD/QjD6Iq
	FQ4FanbyCFeFv3MoSC0sIg8xat9kiJf9uVAgC4Q=
X-Google-Smtp-Source: AGHT+IH9Ytd/Vzr7A7cFLQiWU7mH2zq0ifM5EECWj6PlcPz8AgIwaf3arJd6rtqOQnFan3DcnYjF9Q==
X-Received: by 2002:a17:902:e843:b0:1cf:d24c:7b6c with SMTP id t3-20020a170902e84300b001cfd24c7b6cmr4555619plg.59.1701133719040;
        Mon, 27 Nov 2023 17:08:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ja20-20020a170902efd400b001cfb93fa4fasm4914363plb.150.2023.11.27.17.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 17:08:38 -0800 (PST)
Message-ID: <65653d96.170a0220.96365.b912@mx.google.com>
Date: Mon, 27 Nov 2023 17:08:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.63-367-g5fee4f75be63
Subject: stable-rc/queue/6.1 baseline: 148 runs,
 4 regressions (v6.1.63-367-g5fee4f75be63)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 148 runs, 4 regressions (v6.1.63-367-g5fee4f7=
5be63)

Regressions Summary
-------------------

platform           | arch  | lab             | compiler | defconfig        =
  | regressions
-------------------+-------+-----------------+----------+------------------=
--+------------
imx6dl-riotboard   | arm   | lab-pengutronix | gcc-10   | multi_v7_defconfi=
g | 1          =

r8a77960-ulcb      | arm64 | lab-collabora   | gcc-10   | defconfig        =
  | 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe      | gcc-10   | defconfig        =
  | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora   | gcc-10   | defconfig        =
  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.63-367-g5fee4f75be63/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.63-367-g5fee4f75be63
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5fee4f75be6323b6e3e3de6b73da6df8602a0c44 =



Test Regressions
---------------- =



platform           | arch  | lab             | compiler | defconfig        =
  | regressions
-------------------+-------+-----------------+----------+------------------=
--+------------
imx6dl-riotboard   | arm   | lab-pengutronix | gcc-10   | multi_v7_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/65650c6ae2a588ab957e4aa8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-36=
7-g5fee4f75be63/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-36=
7-g5fee4f75be63/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6=
dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65650c6ae2a588ab957e4ab1
        new failure (last pass: v6.1.63-369-g4cad21545d49d)

    2023-11-27T21:38:26.194056  + set[   15.009670] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1011567_1.5.2.3.1>
    2023-11-27T21:38:26.194278   +x
    2023-11-27T21:38:26.299408  / # #
    2023-11-27T21:38:26.400587  export SHELL=3D/bin/sh
    2023-11-27T21:38:26.401207  #
    2023-11-27T21:38:26.502232  / # export SHELL=3D/bin/sh. /lava-1011567/e=
nvironment
    2023-11-27T21:38:26.502714  =

    2023-11-27T21:38:26.603567  / # . /lava-1011567/environment/lava-101156=
7/bin/lava-test-runner /lava-1011567/1
    2023-11-27T21:38:26.604225  =

    2023-11-27T21:38:26.607143  / # /lava-1011567/bin/lava-test-runner /lav=
a-1011567/1 =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab             | compiler | defconfig        =
  | regressions
-------------------+-------+-----------------+----------+------------------=
--+------------
r8a77960-ulcb      | arm64 | lab-collabora   | gcc-10   | defconfig        =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/65650a9218f6bbed687e4aac

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-36=
7-g5fee4f75be63/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-36=
7-g5fee4f75be63/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65650a9218f6bbed687e4ab5
        failing since 5 days (last pass: v6.1.31-26-gef50524405c2, first fa=
il: v6.1.63-176-gecc0fed1ffa4)

    2023-11-27T21:37:04.789998  / # #

    2023-11-27T21:37:04.892159  export SHELL=3D/bin/sh

    2023-11-27T21:37:04.892870  #

    2023-11-27T21:37:04.994316  / # export SHELL=3D/bin/sh. /lava-12098932/=
environment

    2023-11-27T21:37:04.995043  =


    2023-11-27T21:37:05.096509  / # . /lava-12098932/environment/lava-12098=
932/bin/lava-test-runner /lava-12098932/1

    2023-11-27T21:37:05.097701  =


    2023-11-27T21:37:05.114772  / # /lava-12098932/bin/lava-test-runner /la=
va-12098932/1

    2023-11-27T21:37:05.163113  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-27T21:37:05.163627  + cd /lav<8>[   19.096916] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12098932_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab             | compiler | defconfig        =
  | regressions
-------------------+-------+-----------------+----------+------------------=
--+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe      | gcc-10   | defconfig        =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/65650a6ffe3517e64f7e4a71

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-36=
7-g5fee4f75be63/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-36=
7-g5fee4f75be63/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65650a6ffe3517e64f7e4a7a
        failing since 5 days (last pass: v6.1.22-372-g971903477e72, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-11-27T21:30:17.291892  / # #
    2023-11-27T21:30:17.393347  export SHELL=3D/bin/sh
    2023-11-27T21:30:17.393909  #
    2023-11-27T21:30:17.494943  / # export SHELL=3D/bin/sh. /lava-445538/en=
vironment
    2023-11-27T21:30:17.495660  =

    2023-11-27T21:30:17.597015  / # . /lava-445538/environment/lava-445538/=
bin/lava-test-runner /lava-445538/1
    2023-11-27T21:30:17.598310  =

    2023-11-27T21:30:17.603054  / # /lava-445538/bin/lava-test-runner /lava=
-445538/1
    2023-11-27T21:30:17.676574  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-27T21:30:17.676894  + cd /lava-445538/<8>[   18.570074] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 445538_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab             | compiler | defconfig        =
  | regressions
-------------------+-------+-----------------+----------+------------------=
--+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora   | gcc-10   | defconfig        =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/65650a91de97a0eac17e4a89

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-36=
7-g5fee4f75be63/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-36=
7-g5fee4f75be63/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65650a91de97a0eac17e4a92
        failing since 5 days (last pass: v6.1.22-372-g971903477e72, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-11-27T21:37:18.299679  / # #

    2023-11-27T21:37:18.401881  export SHELL=3D/bin/sh

    2023-11-27T21:37:18.402599  #

    2023-11-27T21:37:18.503949  / # export SHELL=3D/bin/sh. /lava-12098930/=
environment

    2023-11-27T21:37:18.504667  =


    2023-11-27T21:37:18.606133  / # . /lava-12098930/environment/lava-12098=
930/bin/lava-test-runner /lava-12098930/1

    2023-11-27T21:37:18.607231  =


    2023-11-27T21:37:18.623932  / # /lava-12098930/bin/lava-test-runner /la=
va-12098930/1

    2023-11-27T21:37:18.689733  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-27T21:37:18.690240  + cd /lava-1209893<8>[   18.723340] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12098930_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

