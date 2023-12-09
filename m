Return-Path: <stable+bounces-5174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478E480B5D2
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 19:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65AF1F20F8A
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 18:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055A819471;
	Sat,  9 Dec 2023 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="wwdjNzKZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D99C2
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 10:11:17 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6d84ddd642fso2165981a34.0
        for <stable@vger.kernel.org>; Sat, 09 Dec 2023 10:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702145476; x=1702750276; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MdOL9iaMXw8UYTJBDQXN2M7bTdXmnqWGkDuJmftlk+U=;
        b=wwdjNzKZb04+GQ9fkDHzl25oaTgYbhKlkIhAFp5evPBHte54OFMeH8aB8GQSGKu4Kk
         BMOftGE6g9E8K0LJnGGGtiZZwJ6sZZO/dA7jFRpJb6CAswtz1v4gOhsKnsggUiIqFqwn
         snN4PgdF6yqbuQLZ2PFejiFjNXlDErgk9UaYQdaDnn1bAZajlgNGjpR9bS56GHYpUR0+
         ZZu+1bFldrMnTU59JXL6J4DHst2FBcbO+dmFGdEqDu/WuHsqiiYpWYtkSmMsfsmPVmgB
         VVGfwzRsKFiGnewHje7E+sRPEECAJzRqFWkEkEI0lTJmuSGfHZOPaXLIw3eZjCckoV08
         hzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702145476; x=1702750276;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdOL9iaMXw8UYTJBDQXN2M7bTdXmnqWGkDuJmftlk+U=;
        b=W3OG3ymSIUU6HZh4/qdz5+dyCtoygycA9wpsAeyqADMp9lyeBaJi4ayZp/DHhT6UYd
         fsuNC4vWIbHuvBQQfW6ODbmPqmsEVtn+DTsMxlpDT8iVgvrl3zBkIFaxwtvl8P93coae
         DwFda3LCFIvJl0CxcAo+N5gLDu7HYnbTXzomAIzk3vd1b2Jt57ARyuJH16hG9UpjlyrX
         ZFOOvE0CiN5bClEYBcWR4fydxZThM4TuHOO+2c2Bcmh52O3uihyKRY3bcKGERWNi2V49
         lecBu7f7/T/V488c+oBCJxRI3hJwQrdUohbFcOCfrewgvoOaVaqiWHKT9j8G7fSBPYgd
         8aTQ==
X-Gm-Message-State: AOJu0YzUVWgvagJS2QuUIGxW3KNzNIuGF8g/r4x3DaWZruPbzP4xoXMP
	w6SjJeKA7xbS6ioJz3cckI5N8iUpm7tXB7LhZlThhQ==
X-Google-Smtp-Source: AGHT+IEA2iL/Eq50XGVzkcVOZINeOT8fBqv4jwmUxNUUERprSfiUQNByButruiiqQyK07ZqdJshJdA==
X-Received: by 2002:a05:6358:2612:b0:170:5522:597b with SMTP id l18-20020a056358261200b001705522597bmr2762316rwc.56.1702145475834;
        Sat, 09 Dec 2023 10:11:15 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001cfb93fa4fasm3664236pld.150.2023.12.09.10.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 10:11:15 -0800 (PST)
Message-ID: <6574adc3.170a0220.df6a9.b6f9@mx.google.com>
Date: Sat, 09 Dec 2023 10:11:15 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.142-97-gaf4126dfbd88e
Subject: stable-rc/queue/5.15 baseline: 105 runs,
 4 regressions (v5.15.142-97-gaf4126dfbd88e)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 105 runs, 4 regressions (v5.15.142-97-gaf412=
6dfbd88e)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
meson-gxbb-p200    | arm64 | lab-baylibre  | gcc-10   | defconfig | 1      =
    =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.142-97-gaf4126dfbd88e/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.142-97-gaf4126dfbd88e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      af4126dfbd88e96f7f2206a42d6459c9c3240b11 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
meson-gxbb-p200    | arm64 | lab-baylibre  | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65747879860d363ec0e134df

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-97-gaf4126dfbd88e/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-=
p200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-97-gaf4126dfbd88e/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-=
p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65747879860d363ec0e13=
4e0
        failing since 0 day (last pass: v5.15.142-48-gdbed703bb51c2, first =
fail: v5.15.142-77-ga64dd884b1d57) =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65747776c83a79eb55e13490

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-97-gaf4126dfbd88e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-97-gaf4126dfbd88e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-u=
lcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65747776c83a79eb55e13495
        failing since 17 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-09T14:26:45.546368  / # #

    2023-12-09T14:26:45.648482  export SHELL=3D/bin/sh

    2023-12-09T14:26:45.649202  #

    2023-12-09T14:26:45.750579  / # export SHELL=3D/bin/sh. /lava-12229883/=
environment

    2023-12-09T14:26:45.750815  =


    2023-12-09T14:26:45.851707  / # . /lava-12229883/environment/lava-12229=
883/bin/lava-test-runner /lava-12229883/1

    2023-12-09T14:26:45.852742  =


    2023-12-09T14:26:45.854729  / # /lava-12229883/bin/lava-test-runner /la=
va-12229883/1

    2023-12-09T14:26:45.918172  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-09T14:26:45.918638  + cd /lav<8>[   16.010284] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12229883_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65747769e3200cc6e2e134ba

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-97-gaf4126dfbd88e/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-97-gaf4126dfbd88e/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65747769e3200cc6e2e134bf
        failing since 17 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-09T14:19:12.337716  <8>[   16.225346] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447287_1.5.2.4.1>
    2023-12-09T14:19:12.442707  / # #
    2023-12-09T14:19:12.544311  export SHELL=3D/bin/sh
    2023-12-09T14:19:12.544895  #
    2023-12-09T14:19:12.645879  / # export SHELL=3D/bin/sh. /lava-447287/en=
vironment
    2023-12-09T14:19:12.646459  =

    2023-12-09T14:19:12.747481  / # . /lava-447287/environment/lava-447287/=
bin/lava-test-runner /lava-447287/1
    2023-12-09T14:19:12.748330  =

    2023-12-09T14:19:12.753035  / # /lava-447287/bin/lava-test-runner /lava=
-447287/1
    2023-12-09T14:19:12.785097  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65747779c741d0b823e13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-97-gaf4126dfbd88e/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-97-gaf4126dfbd88e/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65747779c741d0b823e1347a
        failing since 17 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-09T14:27:01.621975  / # #

    2023-12-09T14:27:01.724212  export SHELL=3D/bin/sh

    2023-12-09T14:27:01.724948  #

    2023-12-09T14:27:01.826272  / # export SHELL=3D/bin/sh. /lava-12229893/=
environment

    2023-12-09T14:27:01.826967  =


    2023-12-09T14:27:01.928355  / # . /lava-12229893/environment/lava-12229=
893/bin/lava-test-runner /lava-12229893/1

    2023-12-09T14:27:01.929445  =


    2023-12-09T14:27:01.946542  / # /lava-12229893/bin/lava-test-runner /la=
va-12229893/1

    2023-12-09T14:27:02.003952  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-09T14:27:02.004029  + cd /lava-1222989<8>[   16.816170] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12229893_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

