Return-Path: <stable+bounces-4863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEA280791B
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 21:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143A31F212D5
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 20:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDB049F8E;
	Wed,  6 Dec 2023 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="l0/YOKTd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA94D46
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 12:04:07 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d048c171d6so1337425ad.1
        for <stable@vger.kernel.org>; Wed, 06 Dec 2023 12:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701893047; x=1702497847; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ob60T0NrGqUGzifkPBT7deVP4S9B06W2D+dbO7sTLg=;
        b=l0/YOKTd4wOuA5IExXDWVy9ntNFVFlEk/g3dS40flGDZ0Z+AFdd8VMVjrXxxUlUWLW
         1OZ6nru7ipFVoAe7Q9j3IX5EyyIiK2EFh5S7X2NxNJHmJF95lCkr6iulM+GhFT9Sv0n3
         Umd3x8Z9iLB0Rdk03Vpw4Huzm7gCFC9XF3COTxWatYcrhXueUmQZk+5lcPfZk+VdCeTx
         JwDaFl8KJFGCcef+Wq1C6cVzeILBbCKXrT2YLFkDO59f10W8ZCjn90Wd6hjng2xuCz+V
         XvtgxXJc8J/Q/YGuiwzhZQ4GpNAV0aoFNDcS3X8De2sOuoRkBQWzjWTLEg2QH64beduT
         niVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893047; x=1702497847;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Ob60T0NrGqUGzifkPBT7deVP4S9B06W2D+dbO7sTLg=;
        b=H0vgBkPMpKPAUg2wPu0d6XozdKjCbITycVZxTlLrnJWWCCd6A8uAHIM0lhPKlCrzCS
         SArEoa1s1MdjrSbV5GYAUyZjAEl9P6gh0uGsPGtF5z6+xhS9I01QyCKJGtU7PiUfG6eE
         Na0Ld3TiyOyjriF7p9nHqWldoW7xIgMr8N+ZC+nt7hVpE6V3gJqQDGrB1L7zpZK9Opi7
         w8zPmucGut8WZFdGPvLU4HHnjPpeSDe/GP10aIBQi5/NjXLVPDVdK9+FRvc1BsBPrf4g
         f7hUKV2od8eLcyXZMQm2BiNGa6X1hY9jdTd7yEKveTG1l4m6ct3IVzcIkQk86zaNvNK+
         hIzw==
X-Gm-Message-State: AOJu0YyOqRiO1oa9FUq8EmpwTfIUzWOFjEkqL/+GOCdE5jSineGk8s24
	hzBtha51l6TF3+REUhxJqJahUWjakWIIbmKvua8KiA==
X-Google-Smtp-Source: AGHT+IHcsitKacLg59FyQ+P/hXEi9SR4yIJYiTS1zU21tZ9LEA8CckeiaBhhRNdTrFCQs3tkHEljaw==
X-Received: by 2002:a17:902:d511:b0:1d0:6ffd:9e13 with SMTP id b17-20020a170902d51100b001d06ffd9e13mr1571000plg.101.1701893046630;
        Wed, 06 Dec 2023 12:04:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iw1-20020a170903044100b001d1cd7e4acfsm198976plb.201.2023.12.06.12.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:04:06 -0800 (PST)
Message-ID: <6570d3b6.170a0220.7daa8.13ce@mx.google.com>
Date: Wed, 06 Dec 2023 12:04:06 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.65-106-gf012621e70aee
Subject: stable-rc/queue/6.1 baseline: 161 runs,
 5 regressions (v6.1.65-106-gf012621e70aee)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 161 runs, 5 regressions (v6.1.65-106-gf012621=
e70aee)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =

odroid-xu3         | arm   | lab-collabora | gcc-10   | multi_v7_defconfig =
 | 1          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.65-106-gf012621e70aee/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.65-106-gf012621e70aee
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f012621e70aeed17592bfd8e7a16155d5a6320dc =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beagle-xm          | arm   | lab-baylibre  | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6570a061a3b557f5b8e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
6-gf012621e70aee/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
6-gf012621e70aee/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6570a061a3b557f5b8e13=
476
        failing since 230 days (last pass: v6.1.22-477-g2128d4458cbc, first=
 fail: v6.1.22-474-gecc61872327e) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
odroid-xu3         | arm   | lab-collabora | gcc-10   | multi_v7_defconfig =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6570a04826bd66d2b8e13482

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
6-gf012621e70aee/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odroi=
d-xu3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
6-gf012621e70aee/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odroi=
d-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6570a04826bd66d2b8e13=
483
        new failure (last pass: v6.1.65-105-g564877350d4d) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6570a12450e3d9f583e13488

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
6-gf012621e70aee/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
6-gf012621e70aee/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6570a12450e3d9f583e1348d
        failing since 13 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-06T16:35:33.985546  / # #

    2023-12-06T16:35:34.087686  export SHELL=3D/bin/sh

    2023-12-06T16:35:34.088425  #

    2023-12-06T16:35:34.189632  / # export SHELL=3D/bin/sh. /lava-12198872/=
environment

    2023-12-06T16:35:34.189881  =


    2023-12-06T16:35:34.290564  / # . /lava-12198872/environment/lava-12198=
872/bin/lava-test-runner /lava-12198872/1

    2023-12-06T16:35:34.290912  =


    2023-12-06T16:35:34.293051  / # /lava-12198872/bin/lava-test-runner /la=
va-12198872/1

    2023-12-06T16:35:34.356253  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-06T16:35:34.356490  + cd /lav<8>[   19.059455] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12198872_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6570a108f0c8619c55e13514

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
6-gf012621e70aee/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
6-gf012621e70aee/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6570a108f0c8619c55e13519
        failing since 13 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-06T16:27:46.505595  <8>[   18.166313] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 446806_1.5.2.4.1>
    2023-12-06T16:27:46.610603  / # #
    2023-12-06T16:27:46.712276  export SHELL=3D/bin/sh
    2023-12-06T16:27:46.712901  #
    2023-12-06T16:27:46.813897  / # export SHELL=3D/bin/sh. /lava-446806/en=
vironment
    2023-12-06T16:27:46.814603  =

    2023-12-06T16:27:46.915647  / # . /lava-446806/environment/lava-446806/=
bin/lava-test-runner /lava-446806/1
    2023-12-06T16:27:46.916641  =

    2023-12-06T16:27:46.920933  / # /lava-446806/bin/lava-test-runner /lava=
-446806/1
    2023-12-06T16:27:46.999886  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6570a12761fc2097d5e13493

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
6-gf012621e70aee/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.65-10=
6-gf012621e70aee/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6570a12761fc2097d5e13498
        failing since 13 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-06T16:35:50.199681  / # #

    2023-12-06T16:35:50.301853  export SHELL=3D/bin/sh

    2023-12-06T16:35:50.302564  #

    2023-12-06T16:35:50.403969  / # export SHELL=3D/bin/sh. /lava-12198886/=
environment

    2023-12-06T16:35:50.404710  =


    2023-12-06T16:35:50.506141  / # . /lava-12198886/environment/lava-12198=
886/bin/lava-test-runner /lava-12198886/1

    2023-12-06T16:35:50.507224  =


    2023-12-06T16:35:50.548866  / # /lava-12198886/bin/lava-test-runner /la=
va-12198886/1

    2023-12-06T16:35:50.589002  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-06T16:35:50.589194  + cd /lava-1219888<8>[   19.152017] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12198886_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

