Return-Path: <stable+bounces-2842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 075357FAF44
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 01:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A535F281A0D
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 00:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A7E64B;
	Tue, 28 Nov 2023 00:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="UyqkXtz0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A631B8
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 16:48:05 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ce656b9780so37024805ad.2
        for <stable@vger.kernel.org>; Mon, 27 Nov 2023 16:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701132484; x=1701737284; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TiCPHFXYszRoCriWdGRQMyMaqZONjFduQGQvRkcNZLI=;
        b=UyqkXtz0cGQLSO44bV/Mq0IEHAMPKxfunFdNTD3nrsubw1yfjmzkXb1H79+JWI6RWM
         N2fkGqjUBBe/ehydCMgSdBSwfAFwXKNDA5xtU7nEXQMxYfmS6JchRJR4pYcf4R7Nz5Un
         9V3fYScjxceJXTHOlw7kRu3UUy9fXftAWRNKGsOv3GMKeQQETajZ8ToyF2zYXoJkFi+L
         SZhZnOM4cJfBvBU6vazun1ObTmyLN32kM6AuQmKDuCA7vBEt2mza1rTLvpQdBvGwZVPK
         G9rJhCY6QtJSVwdX3W6RMkkQi5e2KRk2d6+8PzDzZU4crRk0hwr9Cf0CQbFSLrfWLni4
         Qomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701132484; x=1701737284;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TiCPHFXYszRoCriWdGRQMyMaqZONjFduQGQvRkcNZLI=;
        b=BEAF7XwdhEjG9P1WT3gPysIQyqg5o+TAQLdrr0Uk9TQDSwZwtUQMyUQ5Y+1vUfL+bN
         +WF/nGN2IS/BspgizbPkVWqYCrePxwUiMMmTVtCfTDrksLh5zZn09pCIpDVcgzv9sprs
         9sPRnjbTtC85tAYAO8usEFGG7lFjrLGT8jI70T8jMnMTQEf+I7TG4OGJ7YsN9cDBcUg6
         /dovcsAzJYimgykjYUgiyOcYX2YIvN1Wci6z1ZHmD8Y6111B3aRqRM145gUJYNJNlJVr
         Smcx8WVcwxLKDb3zljDnpiXpK/IYWnT5k90+DfvEZwd3lZNGWgyyCeygj9O8k4Wps1Zg
         5YrA==
X-Gm-Message-State: AOJu0YyDXkg9gTKQlMZMVUuymtKkAzQygfXJU2udNbaktI1/wAJYo3fm
	676ONeI4UGjfjLqJTjAu3SWlv798ExBl8iAfloo=
X-Google-Smtp-Source: AGHT+IElCv4oV9bybKoHXfmcuxeDchnp0Kn/R4OozkeAyyv5sLvOgGb1yNPxDsDmFMGdx6iiZB+D7w==
X-Received: by 2002:a17:902:b718:b0:1cc:7d96:3fe7 with SMTP id d24-20020a170902b71800b001cc7d963fe7mr10906196pls.28.1701132483905;
        Mon, 27 Nov 2023 16:48:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b001c613091aeasm8865351plf.297.2023.11.27.16.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 16:48:03 -0800 (PST)
Message-ID: <656538c3.170a0220.11fa11.5b61@mx.google.com>
Date: Mon, 27 Nov 2023 16:48:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.201-188-g80dc4301c91e1
Subject: stable-rc/linux-5.10.y baseline: 147 runs,
 3 regressions (v5.10.201-188-g80dc4301c91e1)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y baseline: 147 runs, 3 regressions (v5.10.201-188-g80=
dc4301c91e1)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.201-188-g80dc4301c91e1/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.201-188-g80dc4301c91e1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      80dc4301c91e15c9c3cf12b393d70e0952bcd9ee =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656506d2615e0c03cc7e4ac1

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-188-g80dc4301c91e1/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-188-g80dc4301c91e1/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboo=
t.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656506d2615e0c03cc7e4b01
        new failure (last pass: v5.10.201-188-g2f84e268b78b3)

    2023-11-27T21:14:26.251922  / # #
    2023-11-27T21:14:26.354925  export SHELL=3D/bin/sh
    2023-11-27T21:14:26.355903  #
    2023-11-27T21:14:26.457919  / # export SHELL=3D/bin/sh. /lava-279017/en=
vironment
    2023-11-27T21:14:26.458398  =

    2023-11-27T21:14:26.559856  / # . /lava-279017/environment/lava-279017/=
bin/lava-test-runner /lava-279017/1
    2023-11-27T21:14:26.561297  =

    2023-11-27T21:14:26.575196  / # /lava-279017/bin/lava-test-runner /lava=
-279017/1
    2023-11-27T21:14:26.635049  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-27T21:14:26.635616  + cd /lava-279017/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6565051e85227b9aae7e4aad

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-188-g80dc4301c91e1/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-188-g80dc4301c91e1/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6565051e85227b9aae7e4ab6
        failing since 47 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-27T21:07:33.184583  / # #
    2023-11-27T21:07:33.286212  export SHELL=3D/bin/sh
    2023-11-27T21:07:33.286807  #
    2023-11-27T21:07:33.387813  / # export SHELL=3D/bin/sh. /lava-445533/en=
vironment
    2023-11-27T21:07:33.388399  =

    2023-11-27T21:07:33.489412  / # . /lava-445533/environment/lava-445533/=
bin/lava-test-runner /lava-445533/1
    2023-11-27T21:07:33.490323  =

    2023-11-27T21:07:33.494583  / # /lava-445533/bin/lava-test-runner /lava=
-445533/1
    2023-11-27T21:07:33.561714  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-27T21:07:33.562150  + cd /lava-445533/<8>[   17.455229] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 445533_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/656505400228643e0a7e4a94

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-188-g80dc4301c91e1/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-188-g80dc4301c91e1/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/656505400228643e0a7e4a9d
        failing since 47 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-27T21:14:30.945765  / # #

    2023-11-27T21:14:31.047715  export SHELL=3D/bin/sh

    2023-11-27T21:14:31.048406  #

    2023-11-27T21:14:31.149791  / # export SHELL=3D/bin/sh. /lava-12098849/=
environment

    2023-11-27T21:14:31.150455  =


    2023-11-27T21:14:31.251765  / # . /lava-12098849/environment/lava-12098=
849/bin/lava-test-runner /lava-12098849/1

    2023-11-27T21:14:31.252781  =


    2023-11-27T21:14:31.269702  / # /lava-12098849/bin/lava-test-runner /la=
va-12098849/1

    2023-11-27T21:14:31.313720  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-27T21:14:31.328725  + cd /lava-1209884<8>[   18.138674] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12098849_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

