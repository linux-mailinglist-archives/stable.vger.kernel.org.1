Return-Path: <stable+bounces-2640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E737F8F69
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 22:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDC328143C
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 21:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CCA30D0F;
	Sat, 25 Nov 2023 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="gjJ4bulo"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC90511D
	for <stable@vger.kernel.org>; Sat, 25 Nov 2023 13:07:27 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b8643f996aso87064b6e.3
        for <stable@vger.kernel.org>; Sat, 25 Nov 2023 13:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700946446; x=1701551246; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nLcHu7p9AjuefP1p4LpqT2VyWRPlbrNm9z6V5I0BTb0=;
        b=gjJ4buloI/jiXrSS5P5UNVk3cpemAPsujvrQ96k0YXF/sHupZ/znc64Oc3zJBn01QQ
         7hH7T32mQdw4jWHtxrzsaswoE9SVxJWtLP+OhfG8AgqhdNIzMkO7lzdQaVdhTzC5yJnP
         axlBBP9OqBaMCE8G0S9InYGed+2vxuobN8ZZTrikQ/qGCUPPWSxnCM/VBh+6eMX/9ElC
         Nt68Aq3w6HPiO+v4cRAisWRA5IKnQ0OW4h3Ipj3qh/c5LkcAMZ987iJZ3E2BYqU6vF7y
         UoAC508pyvD43BXxgqMdyJC6SNMCZyACGMGXnXGvK/wZkzIf2IIWTUXqkr5CagS1Qw8u
         Sgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700946446; x=1701551246;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLcHu7p9AjuefP1p4LpqT2VyWRPlbrNm9z6V5I0BTb0=;
        b=H3B3yaEsOPSW6AfM+vdKItgaqFfqLG5uLCAUoGUz4TRqfE3p3BZZUYMCX3HzC1tKcS
         w2dGiztjFtQ4JVj57gcWZg9/lOO/kciUe9yPNr7Tr9lcwmG/wtK8eQEGowNmbO6db1P+
         aZbAGOQnorNpnH6SFu0PA3HumFSK2KwXAngRwiGJ4lEOu5OQl64wsmjGIZUC5rFhq967
         zQnL30oJfkMWC7lesXtiOQTctQ6Cz5C+c6wYEQLyAN04aLMiQW/iGyJAp+d/fCEhWkWu
         ezXHUzbd/uwvxmj3allFr2Rpu5Kviy7EJxY2vLzUdcAHV7lOaWYK346nFhOkojAbTMRn
         25VQ==
X-Gm-Message-State: AOJu0Yz8LkKpYoLct0F+sMXnXdY3KbxNzz+RxlkAvxM9kGxUNAjyUKqj
	aPKpj8i/JkUd6BAM5giN6qg0z/9Kr6nuB7FH4yY=
X-Google-Smtp-Source: AGHT+IHQde9p6Ys9xUwyHFaI8Tq+ZYxDsmvRfwsZ7A9oDu7l7/wn9fJygF+K8NwMvqXj4L0n69ePrQ==
X-Received: by 2002:a05:6808:11c6:b0:3af:d9ea:74b6 with SMTP id p6-20020a05680811c600b003afd9ea74b6mr9080387oiv.43.1700946446701;
        Sat, 25 Nov 2023 13:07:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t25-20020a6564d9000000b0059d34fb9ccasm4461999pgv.2.2023.11.25.13.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 13:07:26 -0800 (PST)
Message-ID: <6562620e.650a0220.4832c.9ae7@mx.google.com>
Date: Sat, 25 Nov 2023 13:07:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.139-293-g21c10d48c6d8c
Subject: stable-rc/queue/5.15 baseline: 142 runs,
 4 regressions (v5.15.139-293-g21c10d48c6d8c)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 142 runs, 4 regressions (v5.15.139-293-g21c1=
0d48c6d8c)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =

rk3399-gru-kevin   | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
        | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.139-293-g21c10d48c6d8c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.139-293-g21c10d48c6d8c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      21c10d48c6d8c3b1e1bbc5ebc0f81991b35d52bc =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/656230e24044d1ca737e4ad3

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-293-g21c10d48c6d8c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-293-g21c10d48c6d8c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656230e24044d1ca737e4adc
        failing since 3 days (last pass: v5.15.114-13-g095e387c3889, first =
fail: v5.15.139-172-gb60494a37c0c)

    2023-11-25T17:43:45.560329  / # #

    2023-11-25T17:43:45.662591  export SHELL=3D/bin/sh

    2023-11-25T17:43:45.663360  #

    2023-11-25T17:43:45.764820  / # export SHELL=3D/bin/sh. /lava-12083290/=
environment

    2023-11-25T17:43:45.765612  =


    2023-11-25T17:43:45.866943  / # . /lava-12083290/environment/lava-12083=
290/bin/lava-test-runner /lava-12083290/1

    2023-11-25T17:43:45.868153  =


    2023-11-25T17:43:45.883577  / # /lava-12083290/bin/lava-test-runner /la=
va-12083290/1

    2023-11-25T17:43:45.934397  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-25T17:43:45.934911  + cd /lav<8>[   16.034512] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12083290_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
rk3399-gru-kevin   | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65623234b919495ebc7e4b1e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-293-g21c10d48c6d8c/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-293-g21c10d48c6d8c/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65623234b919495ebc7e4=
b1f
        new failure (last pass: v5.15.139-297-g00c97fe3c5f3d) =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/656230ce4aacd4be9d7e4b43

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-293-g21c10d48c6d8c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-293-g21c10d48c6d8c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656230ce4aacd4be9d7e4b4c
        failing since 3 days (last pass: v5.15.105-206-g4548859116b8, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-11-25T17:37:08.707913  <8>[   16.070605] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445256_1.5.2.4.1>
    2023-11-25T17:37:08.812922  / # #
    2023-11-25T17:37:08.914552  export SHELL=3D/bin/sh
    2023-11-25T17:37:08.915187  #
    2023-11-25T17:37:09.016190  / # export SHELL=3D/bin/sh. /lava-445256/en=
vironment
    2023-11-25T17:37:09.016808  =

    2023-11-25T17:37:09.117914  / # . /lava-445256/environment/lava-445256/=
bin/lava-test-runner /lava-445256/1
    2023-11-25T17:37:09.118882  =

    2023-11-25T17:37:09.123123  / # /lava-445256/bin/lava-test-runner /lava=
-445256/1
    2023-11-25T17:37:09.155252  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
        | regressions
-------------------+-------+---------------+----------+--------------------=
--------+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/656230e180c512b48f7e4a6d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-293-g21c10d48c6d8c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-293-g21c10d48c6d8c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656230e180c512b48f7e4a76
        failing since 3 days (last pass: v5.15.105-206-g4548859116b8, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-11-25T17:43:59.405527  / # #

    2023-11-25T17:43:59.507880  export SHELL=3D/bin/sh

    2023-11-25T17:43:59.508585  #

    2023-11-25T17:43:59.610013  / # export SHELL=3D/bin/sh. /lava-12083283/=
environment

    2023-11-25T17:43:59.610720  =


    2023-11-25T17:43:59.712161  / # . /lava-12083283/environment/lava-12083=
283/bin/lava-test-runner /lava-12083283/1

    2023-11-25T17:43:59.713308  =


    2023-11-25T17:43:59.729757  / # /lava-12083283/bin/lava-test-runner /la=
va-12083283/1

    2023-11-25T17:43:59.788969  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-25T17:43:59.789521  + cd /lava-1208328<8>[   16.767550] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12083283_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

