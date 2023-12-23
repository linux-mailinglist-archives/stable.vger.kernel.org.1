Return-Path: <stable+bounces-8369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D4B81D23D
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 05:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B261C22219
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 04:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9C51C15;
	Sat, 23 Dec 2023 04:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="zbXN8YPK"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B1E6FAF
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 04:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-35fb39c9dcaso9376255ab.2
        for <stable@vger.kernel.org>; Fri, 22 Dec 2023 20:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703306617; x=1703911417; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8rLHZeRBXaBuOgWaQQ7FDIzXc4IT8zk5R5MkFmG965Y=;
        b=zbXN8YPKPipPqadeNTiTbvGbFZ/ILGql1R3mIxqa9kCbfdXlWhQ7H3OBq2FurrSwWL
         FxEu+ofq0rhCtvsobU+//DvqT0XQyBqZYGnoyTv7IwV0BgAA3QNpis069CHEcfTDZ4Gi
         Ob66TLdDXt1L9Tf6DXVTvZAGopWtRZ7Mo3kW6IhFEl4628lu2fiwiAmBWLJDt+PDea43
         wBHF9chizroq6TFjGTMo3fLwqAr8wMZ7iqzm29vFlc2F1UkHPWjpYEHtWR9rbvd4Cwf9
         4DIcC98i6u84xagLqLWq2ZoNKxqPnX9cYEchtPC+aG2MqnqfDrBTSIE/l50/XMITOTSc
         Rccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703306617; x=1703911417;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rLHZeRBXaBuOgWaQQ7FDIzXc4IT8zk5R5MkFmG965Y=;
        b=u5ILMtoNErqGm+ZiRoQh1NNUWRXRMOYUMJlSLKp1K0mViaXINrgq8vbIA8MS5r9fT1
         EfCIyN9OQDKASV6Sf8HCLLVtfpZAabCO5gENlqc6duppj4Io1mAH4mZExekWpNCGvArw
         SPj5FC2Puw116JTqCYSXmp77ma4v7VOChGIhIMyz3OMBD0IJFeOq45jspc1LpUnahOj/
         T8jxXumB2cVSLkPMlm7X6ErhzXCobgVhnbEnNvoJmX2+6D4z2ojPq97udbo0xurEDsEU
         3+dbPJY07J5IRUs5iWW9Xn7kxfZCpOFfJcVrCjcDNsWxt9LKnc7Ow6QsCvm0txKc0cDK
         n+4g==
X-Gm-Message-State: AOJu0Ywfu6MP6MZMB5/CHdmUa1W8FjxlSmfRbr/5uFor5FPZ2Ve9oXN8
	hUZe52PpjGZPVknLiNnXcdMqqgekMI0thCtEqW6oekUlPEU=
X-Google-Smtp-Source: AGHT+IHQmm9qt64fHu6hwirv2SEg0etlKkRUz1WSpNld/qLVHxziHmz5oxiiBxl0RoVSUmUnlG8yDQ==
X-Received: by 2002:a05:6e02:1583:b0:35f:575f:9fa0 with SMTP id m3-20020a056e02158300b0035f575f9fa0mr4176208ilu.56.1703306616793;
        Fri, 22 Dec 2023 20:43:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902fe1800b001d0c41b1d03sm4230287plj.32.2023.12.22.20.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 20:43:36 -0800 (PST)
Message-ID: <65866578.170a0220.8665f.e61c@mx.google.com>
Date: Fri, 22 Dec 2023 20:43:36 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.68-147-gd5d7086b58f64
Subject: stable-rc/queue/6.1 baseline: 88 runs,
 3 regressions (v6.1.68-147-gd5d7086b58f64)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 88 runs, 3 regressions (v6.1.68-147-gd5d7086b=
58f64)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.68-147-gd5d7086b58f64/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.68-147-gd5d7086b58f64
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d5d7086b58f64a350a7c66cdbd4f97db7c2e1780 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6586340d88ad05c69ce134e4

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-14=
7-gd5d7086b58f64/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-14=
7-gd5d7086b58f64/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6586340d88ad05c69ce134e9
        failing since 30 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-23T01:20:02.317150  / # #

    2023-12-23T01:20:02.417618  export SHELL=3D/bin/sh

    2023-12-23T01:20:02.417757  #

    2023-12-23T01:20:02.518164  / # export SHELL=3D/bin/sh. /lava-12357776/=
environment

    2023-12-23T01:20:02.518301  =


    2023-12-23T01:20:02.618740  / # . /lava-12357776/environment/lava-12357=
776/bin/lava-test-runner /lava-12357776/1

    2023-12-23T01:20:02.618933  =


    2023-12-23T01:20:02.630959  / # /lava-12357776/bin/lava-test-runner /la=
va-12357776/1

    2023-12-23T01:20:02.684151  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-23T01:20:02.684239  + cd /lava-123577<8>[   19.085110] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 12357776_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6586340b88ad05c69ce134d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-14=
7-gd5d7086b58f64/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-14=
7-gd5d7086b58f64/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6586340b88ad05c69ce134de
        failing since 30 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-23T01:12:37.617990  <8>[   18.033850] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 449592_1.5.2.4.1>
    2023-12-23T01:12:37.723009  / # #
    2023-12-23T01:12:37.824589  export SHELL=3D/bin/sh
    2023-12-23T01:12:37.825198  #
    2023-12-23T01:12:37.926183  / # export SHELL=3D/bin/sh. /lava-449592/en=
vironment
    2023-12-23T01:12:37.926830  =

    2023-12-23T01:12:38.027828  / # . /lava-449592/environment/lava-449592/=
bin/lava-test-runner /lava-449592/1
    2023-12-23T01:12:38.028662  =

    2023-12-23T01:12:38.033323  / # /lava-449592/bin/lava-test-runner /lava=
-449592/1
    2023-12-23T01:12:38.112337  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65863415898d9c4d31e134f5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-14=
7-gd5d7086b58f64/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-14=
7-gd5d7086b58f64/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65863415898d9c4d31e134fa
        failing since 30 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-23T01:20:19.559339  / # #

    2023-12-23T01:20:19.661619  export SHELL=3D/bin/sh

    2023-12-23T01:20:19.662320  #

    2023-12-23T01:20:19.763765  / # export SHELL=3D/bin/sh. /lava-12357782/=
environment

    2023-12-23T01:20:19.764566  =


    2023-12-23T01:20:19.865987  / # . /lava-12357782/environment/lava-12357=
782/bin/lava-test-runner /lava-12357782/1

    2023-12-23T01:20:19.867119  =


    2023-12-23T01:20:19.883803  / # /lava-12357782/bin/lava-test-runner /la=
va-12357782/1

    2023-12-23T01:20:19.949248  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-23T01:20:19.949384  + cd /lava-1235778<8>[   19.214400] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12357782_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

