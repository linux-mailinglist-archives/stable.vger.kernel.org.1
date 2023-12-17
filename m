Return-Path: <stable+bounces-6932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D82B881638D
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 00:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436861F218C5
	for <lists+stable@lfdr.de>; Sun, 17 Dec 2023 23:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991594B123;
	Sun, 17 Dec 2023 23:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="sYHY4bd/"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4984B5AB
	for <stable@vger.kernel.org>; Sun, 17 Dec 2023 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7b6fe5d67d4so120773539f.3
        for <stable@vger.kernel.org>; Sun, 17 Dec 2023 15:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702857221; x=1703462021; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=40QkR54sdZsovmju5HAYrcIDVe9EAZp65OYSoUGzRUs=;
        b=sYHY4bd/DuGT03EImwK4Tmks1EFZBKkguw5o4daShxc9z8OEQuXI6KfySwXIT93Qdp
         QuOa9UlE6s0QE3Q6KsERj9wRmSbjV4+vcK6CdXKCf6u363/9fq6rfZV47aRcjLqaSaxf
         UgkoW5fyGSL8EbcFDZplCVYbaryHXPbhZAhgmjQJuQSMBppuDhNbLQzR3mBGXMmbZS2E
         FCIR+o/9RKBkT5WW8bS+9/DM2K1O80twt2Rh6J1tPg/4pJTYgr0eVCmq9ws+CbrMQQcq
         0oMaXLfu9XdUExny7NJ2DuKzFZ22ecSVD9A/VoyJo353O1rOT9vDjyOZV+g/TJrCrxxf
         /86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702857221; x=1703462021;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40QkR54sdZsovmju5HAYrcIDVe9EAZp65OYSoUGzRUs=;
        b=IE9NH/o/QPynQpQRVmyy2cLNfcckjusOXjNIfv+jVHFMQSnq5NNFZBaLWWz6omlpCb
         TrvKG1Bo/evLIvD9IDcuRo8MCnf9P0vxoSrYyRityrqcy+HAmy9lU0t/3DqIbqvd9IM0
         7WRKokf6kpgN49eIdD7Nv3dUUvSXONiq6jqSGUcBd7s3YYGIXJo2+FphHBmR3oBqe0J+
         xxGUGzOPaE3SWS7IXwmDr2KmmpM+B9fxAWmDKUfpL/0kHy/y6/FBXr5SYkYykwAQvGVQ
         zaB6aF0fQxXNjXF8YmKSDHHQd5Fz1TYmsUnxYu4iIj9nko6itJ7TtxRSbVuH5QTxi2mK
         WdFw==
X-Gm-Message-State: AOJu0YxeT5E2lI+9lRdm9rOohsIl548h9ZDJksVzScIm6Tadj0WsDL0Z
	SMtTkybL2vDNGwun+QHURKJKeMk92BD1LyzlUqc=
X-Google-Smtp-Source: AGHT+IEC6sCwInuCwBk8JeIMxfn5McVx2uKvdCUpqqdoIdpJ9cRnfoVxmxx/cNClXElnQpoIWSqfRQ==
X-Received: by 2002:a5e:a703:0:b0:7b7:187f:abd2 with SMTP id b3-20020a5ea703000000b007b7187fabd2mr14662004iod.14.1702857220901;
        Sun, 17 Dec 2023 15:53:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id hq7-20020a056a00680700b006d691da4cd5sm1159167pfb.112.2023.12.17.15.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 15:53:40 -0800 (PST)
Message-ID: <657f8a04.050a0220.55107.2446@mx.google.com>
Date: Sun, 17 Dec 2023 15:53:40 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.68-79-gcd84d41e714d8
Subject: stable-rc/queue/6.1 baseline: 113 runs,
 3 regressions (v6.1.68-79-gcd84d41e714d8)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 113 runs, 3 regressions (v6.1.68-79-gcd84d41e=
714d8)

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
el/v6.1.68-79-gcd84d41e714d8/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.68-79-gcd84d41e714d8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      cd84d41e714d82582cd2058ef5ef58b89a290c45 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657f58596530bff233e13475

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-79=
-gcd84d41e714d8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-79=
-gcd84d41e714d8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657f58596530bff233e1347a
        failing since 25 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-17T20:29:01.022970  / # #

    2023-12-17T20:29:01.125109  export SHELL=3D/bin/sh

    2023-12-17T20:29:01.125761  #

    2023-12-17T20:29:01.227083  / # export SHELL=3D/bin/sh. /lava-12294754/=
environment

    2023-12-17T20:29:01.227795  =


    2023-12-17T20:29:01.329218  / # . /lava-12294754/environment/lava-12294=
754/bin/lava-test-runner /lava-12294754/1

    2023-12-17T20:29:01.330304  =


    2023-12-17T20:29:01.347268  / # /lava-12294754/bin/lava-test-runner /la=
va-12294754/1

    2023-12-17T20:29:01.395588  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-17T20:29:01.396102  + cd /lav<8>[   19.109349] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12294754_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657f5853dd8ba13065e13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-79=
-gcd84d41e714d8/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-79=
-gcd84d41e714d8/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657f5853dd8ba13065e1347a
        failing since 25 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-17T20:21:18.951296  / # #
    2023-12-17T20:21:19.053021  export SHELL=3D/bin/sh
    2023-12-17T20:21:19.053640  #
    2023-12-17T20:21:19.154690  / # export SHELL=3D/bin/sh. /lava-448512/en=
vironment
    2023-12-17T20:21:19.155436  =

    2023-12-17T20:21:19.256618  / # . /lava-448512/environment/lava-448512/=
bin/lava-test-runner /lava-448512/1
    2023-12-17T20:21:19.257709  =

    2023-12-17T20:21:19.261254  / # /lava-448512/bin/lava-test-runner /lava=
-448512/1
    2023-12-17T20:21:19.340299  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-17T20:21:19.341015  + cd /lava-448512/<8>[   18.662028] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 448512_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657f5857dd8ba13065e134e3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-79=
-gcd84d41e714d8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-79=
-gcd84d41e714d8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657f5857dd8ba13065e134e8
        failing since 25 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-17T20:29:11.827764  / # #

    2023-12-17T20:29:11.929882  export SHELL=3D/bin/sh

    2023-12-17T20:29:11.930588  #

    2023-12-17T20:29:12.031988  / # export SHELL=3D/bin/sh. /lava-12294747/=
environment

    2023-12-17T20:29:12.032760  =


    2023-12-17T20:29:12.134267  / # . /lava-12294747/environment/lava-12294=
747/bin/lava-test-runner /lava-12294747/1

    2023-12-17T20:29:12.135400  =


    2023-12-17T20:29:12.152033  / # /lava-12294747/bin/lava-test-runner /la=
va-12294747/1

    2023-12-17T20:29:12.218923  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-17T20:29:12.219425  + cd /lava-1229474<8>[   19.291649] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12294747_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

