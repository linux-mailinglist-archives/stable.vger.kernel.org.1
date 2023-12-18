Return-Path: <stable+bounces-7822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2BA8179B6
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 19:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40008B22528
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 18:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43798830;
	Mon, 18 Dec 2023 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="SB6LFvjE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFEB2904
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3ae590903so10466795ad.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 10:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702924253; x=1703529053; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ySPrNasAbpAREBhG5CH+g5MVJnT6jUMKnsFi78eArXE=;
        b=SB6LFvjEvJaXV0xavrYBJ1XqR23IIVyvf+A7G4rooStWFQHqVqkLH58vPXtB7ZK+LN
         zxP9cApYaLOMI53qQm5mH9gyZcqCEDkzkdi6LuO/mBLEMNjwQ5CI03TAzarUCi6PNQhf
         k9xuYLpxtffAN3QUHJBG2eCaB4LmIllvlv8VKx/q6LPBe9/NsIg3FsDIS/QUx1NAj6K5
         VVtGjSApg6ttLp2UKtixz+oF/D/PRcgKBatOmtMEv5VTs4wdNk340z7/hCQAYSdGNmcJ
         hw1vsj8qhg9Gjzl5mB71oYZbHn574fry0t+CDTjwTsgvE1UvVcxCxd1pjRpQ9Q+Fmfua
         EBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702924253; x=1703529053;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ySPrNasAbpAREBhG5CH+g5MVJnT6jUMKnsFi78eArXE=;
        b=Ks75bYayhRYkKoBo/KxODdT/N5j5prboqslPbdJN4jFRbi2fZP4iFezYthdAwj6PYr
         oN6ieJoHHnymYqD7kgk/YhFoMravhRBdcTmHKIEb73EOHICxdrAXq59CMCT+nLFaHkir
         9uKsgFOzL2rKQhb45jUoQzzR720e/ugzQxaK61pzQKx85fZ1oDGcPKDnKsk1KxYL7iOS
         cmIjcCuoOT5Ccp/4vwLg4MV7o0tfaNmB/5nfsMgKLYYFG3F4VMNg8jyxE93esSxEFHSr
         7S2Y6HIGA5jHCKaLainaLZ0Ewl25WGWODyrxWAYcaPsttu1MjH9hc4zhzOT3Av6mG414
         KRYw==
X-Gm-Message-State: AOJu0YyZxNal/jMkGNcbcEcumzL5JSYakRFiha+Tym2iqcPrQwLqLE6e
	Qi0Nlnc/UiDVhSkVcxVrUxZ8GGl/gwNsr0tkaz4=
X-Google-Smtp-Source: AGHT+IGelDXNxgCOosmsW9Gqo14mEX9/5nzQSqLto8W3Q7u5i2pOxIZWAzX+2yhn5WNFG1hLun/26w==
X-Received: by 2002:a17:902:f782:b0:1d3:41b6:6d83 with SMTP id q2-20020a170902f78200b001d341b66d83mr9623253pln.11.1702924252625;
        Mon, 18 Dec 2023 10:30:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902848200b001d09c539c96sm7884251plo.229.2023.12.18.10.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 10:30:52 -0800 (PST)
Message-ID: <65808fdc.170a0220.d0781.6156@mx.google.com>
Date: Mon, 18 Dec 2023 10:30:52 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.68-106-ge1524ddfd1363
Subject: stable-rc/queue/6.1 baseline: 109 runs,
 3 regressions (v6.1.68-106-ge1524ddfd1363)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 109 runs, 3 regressions (v6.1.68-106-ge1524dd=
fd1363)

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
el/v6.1.68-106-ge1524ddfd1363/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.68-106-ge1524ddfd1363
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e1524ddfd136335ae3100dc3c8df219da10f6d44 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65805bb906ab90788fe13594

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
6-ge1524ddfd1363/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
6-ge1524ddfd1363/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65805bb906ab90788fe13599
        failing since 25 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-18T14:55:38.003286  / # #

    2023-12-18T14:55:38.105428  export SHELL=3D/bin/sh

    2023-12-18T14:55:38.106132  #

    2023-12-18T14:55:38.207525  / # export SHELL=3D/bin/sh. /lava-12303951/=
environment

    2023-12-18T14:55:38.208235  =


    2023-12-18T14:55:38.309830  / # . /lava-12303951/environment/lava-12303=
951/bin/lava-test-runner /lava-12303951/1

    2023-12-18T14:55:38.310768  =


    2023-12-18T14:55:38.327838  / # /lava-12303951/bin/lava-test-runner /la=
va-12303951/1

    2023-12-18T14:55:38.376449  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-18T14:55:38.376949  + cd /lav<8>[   19.115576] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12303951_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65805ba3fa15b47c3ce1348d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
6-ge1524ddfd1363/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
6-ge1524ddfd1363/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65805ba3fa15b47c3ce13492
        failing since 25 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-18T14:47:45.827145  <8>[   18.098414] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 448727_1.5.2.4.1>
    2023-12-18T14:47:45.932100  / # #
    2023-12-18T14:47:46.033845  export SHELL=3D/bin/sh
    2023-12-18T14:47:46.034459  #
    2023-12-18T14:47:46.135494  / # export SHELL=3D/bin/sh. /lava-448727/en=
vironment
    2023-12-18T14:47:46.136132  =

    2023-12-18T14:47:46.237143  / # . /lava-448727/environment/lava-448727/=
bin/lava-test-runner /lava-448727/1
    2023-12-18T14:47:46.238128  =

    2023-12-18T14:47:46.242310  / # /lava-448727/bin/lava-test-runner /lava=
-448727/1
    2023-12-18T14:47:46.321370  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65805bba1a4e0bdcaae13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
6-ge1524ddfd1363/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
6-ge1524ddfd1363/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65805bba1a4e0bdcaae1347a
        failing since 25 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-18T14:55:51.454715  / # #

    2023-12-18T14:55:51.556773  export SHELL=3D/bin/sh

    2023-12-18T14:55:51.557459  #

    2023-12-18T14:55:51.658679  / # export SHELL=3D/bin/sh. /lava-12303962/=
environment

    2023-12-18T14:55:51.659317  =


    2023-12-18T14:55:51.760500  / # . /lava-12303962/environment/lava-12303=
962/bin/lava-test-runner /lava-12303962/1

    2023-12-18T14:55:51.761032  =


    2023-12-18T14:55:51.762841  / # /lava-12303962/bin/lava-test-runner /la=
va-12303962/1

    2023-12-18T14:55:51.844003  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-18T14:55:51.844536  + cd /lava-1230396<8>[   19.222591] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12303962_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

