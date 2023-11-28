Return-Path: <stable+bounces-2841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B434B7FAF1C
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 01:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68073281730
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 00:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15D9EA0;
	Tue, 28 Nov 2023 00:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="vRmvWzHc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431F41B5
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 16:35:35 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cf856663a4so33607515ad.3
        for <stable@vger.kernel.org>; Mon, 27 Nov 2023 16:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701131734; x=1701736534; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Lws/RfzupBy9pbe4CTIUSyXkVc/ESyTNoIczldax+4=;
        b=vRmvWzHc+2qWRmNY85GR8y92TqUK2PJUIhQLrVyOr8xvbZ+GnXkI2Xth3bdlDF2jhQ
         bwHQEez+lxkVnUx2K4Z8OtqqbbfA0BLYPmF44e7O2HwSRBM1gYhgFyCtCaFxkw6n09SP
         IF8+HadRUAGAInykbkNgsuyShRdTU6R84u5cqk2nVvOQ+OzmGvQO2npK8+kj5WFVzdVJ
         AgFLCN13WlQ27QUuRg/UNjTPsYUNke/hng2v2Cfdg03HXLz64UPTGwpOBL+NUpidtZrx
         +CnMnhJZCDaGYY+bzqlHHD0xzcgj1B6+dY+9VxdDtfwI+FZGEEM/SYS3cQiOg8dKuQR2
         ZB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701131734; x=1701736534;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Lws/RfzupBy9pbe4CTIUSyXkVc/ESyTNoIczldax+4=;
        b=H72AAv582X92+73TiEOle86fBYwO0hVgUBoDuoa+og4ts7G9awSnopNEjXc9s7cELi
         yBIwGJheNPtNnAxZOdrMOB09HPr2jmcXrMhmdhF0G1wU3i7/ASkJc/3/MlE9qqoyI2E4
         EF2CwwIlGbzmKruiNBcFe/R5OI2UsLjdiSjaCmG4zrnPXw0Pg3hEtcz3drEGmg+3GnGx
         e2OhGhuVx51+Th3GBZ2FJsp2h8xx/9jq5YkIKMXVr3ys1+zGY1Dlfp1fsseyQ+0kcxQO
         B7eJ9fz30Z6p4iqfACBx+nELXors8dOu4IhPTumr78sVWEtKz4UV/h7QbuiEhoRrS5Hq
         CqjA==
X-Gm-Message-State: AOJu0Yx7ef+Q9QNIW4ochTGiGW8Ag31a+da+cXI1tp8EbGTZE/M6PsVs
	ocDGfyuHYFpMJa4hdzwlCUcXHHroWTKYkLPmrx4=
X-Google-Smtp-Source: AGHT+IEuaBire1BE2lQ0mdMGZR30FIKC+8xcK5kbSH4DiBRCeE5r8cOzbG8PA+1yivV3Y0VwtBMSAw==
X-Received: by 2002:a17:902:8214:b0:1cf:e19e:2505 with SMTP id x20-20020a170902821400b001cfe19e2505mr2385978pln.61.1701131734253;
        Mon, 27 Nov 2023 16:35:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001b7f40a8959sm8937005pld.76.2023.11.27.16.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 16:35:33 -0800 (PST)
Message-ID: <656535d5.170a0220.3fc22.5db3@mx.google.com>
Date: Mon, 27 Nov 2023 16:35:33 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.139-291-g3a968ce68298
Subject: stable-rc/queue/5.15 baseline: 143 runs,
 3 regressions (v5.15.139-291-g3a968ce68298)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 143 runs, 3 regressions (v5.15.139-291-g3a96=
8ce68298)

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
nel/v5.15.139-291-g3a968ce68298/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.139-291-g3a968ce68298
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      3a968ce68298fe183d161da65c9b074dcf0b2a55 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656503aebf439cb4847e4a85

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-291-g3a968ce68298/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-291-g3a968ce68298/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656503aebf439cb4847e4a8e
        failing since 5 days (last pass: v5.15.114-13-g095e387c3889, first =
fail: v5.15.139-172-gb60494a37c0c)

    2023-11-27T21:07:45.164389  / # #

    2023-11-27T21:07:45.264900  export SHELL=3D/bin/sh

    2023-11-27T21:07:45.265006  #

    2023-11-27T21:07:45.365418  / # export SHELL=3D/bin/sh. /lava-12098680/=
environment

    2023-11-27T21:07:45.365527  =


    2023-11-27T21:07:45.465950  / # . /lava-12098680/environment/lava-12098=
680/bin/lava-test-runner /lava-12098680/1

    2023-11-27T21:07:45.466132  =


    2023-11-27T21:07:45.478059  / # /lava-12098680/bin/lava-test-runner /la=
va-12098680/1

    2023-11-27T21:07:45.521278  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-27T21:07:45.537131  + cd /lav<8>[   16.006137] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12098680_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6565038e3134ba23d07e4aa4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-291-g3a968ce68298/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-291-g3a968ce68298/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6565038e3134ba23d07e4aad
        failing since 5 days (last pass: v5.15.105-206-g4548859116b8, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-11-27T21:00:54.216149  <8>[   16.062034] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445528_1.5.2.4.1>
    2023-11-27T21:00:54.321263  / # #
    2023-11-27T21:00:54.422882  export SHELL=3D/bin/sh
    2023-11-27T21:00:54.423474  #
    2023-11-27T21:00:54.524458  / # export SHELL=3D/bin/sh. /lava-445528/en=
vironment
    2023-11-27T21:00:54.525033  =

    2023-11-27T21:00:54.626012  / # . /lava-445528/environment/lava-445528/=
bin/lava-test-runner /lava-445528/1
    2023-11-27T21:00:54.626864  =

    2023-11-27T21:00:54.631326  / # /lava-445528/bin/lava-test-runner /lava=
-445528/1
    2023-11-27T21:00:54.663509  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656503af2e3dfd0f987e4a79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-291-g3a968ce68298/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.139=
-291-g3a968ce68298/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656503af2e3dfd0f987e4a82
        failing since 5 days (last pass: v5.15.105-206-g4548859116b8, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-11-27T21:07:58.455784  / # #

    2023-11-27T21:07:58.557722  export SHELL=3D/bin/sh

    2023-11-27T21:07:58.557950  #

    2023-11-27T21:07:58.658558  / # export SHELL=3D/bin/sh. /lava-12098684/=
environment

    2023-11-27T21:07:58.658829  =


    2023-11-27T21:07:58.759497  / # . /lava-12098684/environment/lava-12098=
684/bin/lava-test-runner /lava-12098684/1

    2023-11-27T21:07:58.759850  =


    2023-11-27T21:07:58.763504  / # /lava-12098684/bin/lava-test-runner /la=
va-12098684/1

    2023-11-27T21:07:58.805655  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-27T21:07:58.839013  + cd /lava-1209868<8>[   16.812734] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12098684_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

