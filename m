Return-Path: <stable+bounces-8408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C4481D6AD
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 23:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A951C20EE3
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 22:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF78168A8;
	Sat, 23 Dec 2023 22:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="0cDDlg1d"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C0C18B19
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3ea5cc137so23521695ad.0
        for <stable@vger.kernel.org>; Sat, 23 Dec 2023 14:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703368862; x=1703973662; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zO8jMQQYtaMR6GqoD27FHimJqM7nwWxuDe1/gQ5dSfE=;
        b=0cDDlg1dppo6zDL7SzXSNLD+X12RfJrwzj6h4JQGyclMvvC0wvsbnTxkbhPXU80kI5
         PIG0BSnv8cTxc6tc6lrzdbNHPNghFISmnaF+xu6xVaH++uxgcw+Ig1+d5ZDKULIzBX9U
         5GqHmospHT+ZuqcM2I/lSDzdlZT4wiOwcZtPxyP98aSpDnHnL6Pns7P6Z3XEZNiGj0AI
         PIfX/ZU9uoq9sUj40rvoUw/4DErNoeq+NlMNlGs78w2ADwbznYZtU4Y3lCYjQ7Tu9uo7
         KdOn2I3V1zAdirLkG6+KQ3Sz82vBVXTpF05+G/lVTjQDwjzVfhzq1R5bLSis8hdzWQlU
         4CRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703368862; x=1703973662;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zO8jMQQYtaMR6GqoD27FHimJqM7nwWxuDe1/gQ5dSfE=;
        b=UrIrVcB6iuNolxal0dQiLIzZvaEHuaWMMT+kqmi/XwC89Pz6o3hgTYc2RdW5VQMr0J
         Y5c8r7iX1cWKTQGo4JOjhr/7RRD9ju4yHTkd0qfiBDsM5l0AJYxRsvIhTmgsCyxz0Bcz
         EXzSxHRKlJblcggnRLLCkwmMct6hzeK2ywU2ytxg/zNDCSkbPO5lz4UlG4phdOo+H8et
         uDUd2OLrbqXZ8pzgPQBFOVk+zWbQ7mOJfXCgywn6iNFoheTSBEhOSBzlxs/sSyIykLSj
         MoWxE/4vmH9dbUm9DsBmn5fROKRdGjYnzLlUzh338SE6qkW5FWx+cIwHpfEUUzJt7PnM
         lETw==
X-Gm-Message-State: AOJu0YzRAguNIclg1EDNDDHbpi3krPJO9edG/nLT36Kqx/aVenQYwiUb
	OCb6i8CQsPtyFU+G+WDeDGW65nm98NoykztEo65q9Jz5PD4=
X-Google-Smtp-Source: AGHT+IGEyoS5NSYyNGQ3otUmoFe85fyc2UY5XWkgbtOZ0jI/+hGk52zZc4E7Fqph9bGZRdno7wmLog==
X-Received: by 2002:a17:902:e541:b0:1d3:ac23:b511 with SMTP id n1-20020a170902e54100b001d3ac23b511mr4439107plf.54.1703368862153;
        Sat, 23 Dec 2023 14:01:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ee8200b001d362b6b0eesm5560834pld.168.2023.12.23.14.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 14:01:01 -0800 (PST)
Message-ID: <6587589d.170a0220.2884.010c@mx.google.com>
Date: Sat, 23 Dec 2023 14:01:01 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.68-153-g6433185371d8
Subject: stable-rc/queue/6.1 baseline: 110 runs,
 4 regressions (v6.1.68-153-g6433185371d8)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 110 runs, 4 regressions (v6.1.68-153-g6433185=
371d8)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
qemu_smp8_riscv64  | riscv | lab-collabora | gcc-10   | defconfig | 1      =
    =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.68-153-g6433185371d8/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.68-153-g6433185371d8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6433185371d86547d5279e6ccb95bae1d0bdad4e =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
qemu_smp8_riscv64  | riscv | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/658722d79c5b8415e1e13480

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-15=
3-g6433185371d8/riscv/defconfig/gcc-10/lab-collabora/baseline-qemu_smp8_ris=
cv64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-15=
3-g6433185371d8/riscv/defconfig/gcc-10/lab-collabora/baseline-qemu_smp8_ris=
cv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/riscv/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/658722d79c5b8415e1e13=
481
        new failure (last pass: v6.1.68-147-gd5d7086b58f64) =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/658724f1f4f0113fa0e134fd

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-15=
3-g6433185371d8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-15=
3-g6433185371d8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658724f1f4f0113fa0e13506
        failing since 31 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-23T18:27:47.664128  / # #

    2023-12-23T18:27:47.766305  export SHELL=3D/bin/sh

    2023-12-23T18:27:47.767043  #

    2023-12-23T18:27:47.868503  / # export SHELL=3D/bin/sh. /lava-12366617/=
environment

    2023-12-23T18:27:47.869228  =


    2023-12-23T18:27:47.970606  / # . /lava-12366617/environment/lava-12366=
617/bin/lava-test-runner /lava-12366617/1

    2023-12-23T18:27:47.971732  =


    2023-12-23T18:27:47.988237  / # /lava-12366617/bin/lava-test-runner /la=
va-12366617/1

    2023-12-23T18:27:48.037273  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-23T18:27:48.037773  + cd /lav<8>[   19.053754] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12366617_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/658724d566c70091efe134a7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-15=
3-g6433185371d8/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-15=
3-g6433185371d8/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658724d566c70091efe134b0
        failing since 31 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-23T18:20:00.868046  <8>[   18.066744] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 449738_1.5.2.4.1>
    2023-12-23T18:20:00.973005  / # #
    2023-12-23T18:20:01.074632  export SHELL=3D/bin/sh
    2023-12-23T18:20:01.075226  #
    2023-12-23T18:20:01.176214  / # export SHELL=3D/bin/sh. /lava-449738/en=
vironment
    2023-12-23T18:20:01.176811  =

    2023-12-23T18:20:01.277816  / # . /lava-449738/environment/lava-449738/=
bin/lava-test-runner /lava-449738/1
    2023-12-23T18:20:01.278741  =

    2023-12-23T18:20:01.282909  / # /lava-449738/bin/lava-test-runner /lava=
-449738/1
    2023-12-23T18:20:01.361987  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/658725067ae5f86601e13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-15=
3-g6433185371d8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-15=
3-g6433185371d8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/658725067ae5f86601e1347e
        failing since 31 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-23T18:28:04.510267  / # #

    2023-12-23T18:28:04.612383  export SHELL=3D/bin/sh

    2023-12-23T18:28:04.613092  #

    2023-12-23T18:28:04.714500  / # export SHELL=3D/bin/sh. /lava-12366623/=
environment

    2023-12-23T18:28:04.715224  =


    2023-12-23T18:28:04.816690  / # . /lava-12366623/environment/lava-12366=
623/bin/lava-test-runner /lava-12366623/1

    2023-12-23T18:28:04.817810  =


    2023-12-23T18:28:04.834164  / # /lava-12366623/bin/lava-test-runner /la=
va-12366623/1

    2023-12-23T18:28:04.900243  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-23T18:28:04.900777  + cd /lava-1236662<8>[   19.187729] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12366623_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

