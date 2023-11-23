Return-Path: <stable+bounces-14-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0557F57CE
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 06:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C36EBB20E72
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 05:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42520B658;
	Thu, 23 Nov 2023 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="IZgyJogK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED733CB
	for <stable@vger.kernel.org>; Wed, 22 Nov 2023 21:36:06 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cbbfdf72ecso554568b3a.2
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 21:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700717766; x=1701322566; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tWdeV6uCV6NwjCW3Gg00IsxuFUVq2AwrcaMg/Su4dak=;
        b=IZgyJogKctNCfhC1Tt2DaS3xXZFuopvkoD6DtcK2lDFVjWD2EtkaN5001jTA9mkugg
         hjRpq1UDXqFo20qWHAvLiqSxnNvKY4+tQSAD1JX7jBMDYhSJDDmHMQcNJEg1h8l+5kmV
         jVITt6HdEjfWF7+fiTBKKzGTt/UKdFVzyMePQ6GEvQ4AfkUiefm4wCImVlpLTtiMUTcd
         9jXKDaJbjnuMn+8eN3LN30+7Nls6HOmT9I0L0zOP1JbTGK8SFrzWaU/thc86ObEb03Mq
         eL624lW8q+u2Uzz08Ez3qBS0PxMsLGQzNwD3hHI+raH1s54HDOpRxFRKdiwSKbDZxcIa
         HMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700717766; x=1701322566;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWdeV6uCV6NwjCW3Gg00IsxuFUVq2AwrcaMg/Su4dak=;
        b=wpkvppGkh0pB5DSxw1ATlfm7z/azwCmEqpt88kmSGdKemPYoLDwvZ1eRlOencqoV+R
         rXcoK++/c+8/TdAHSsgvbqVlOxrUykNac3PR2rLSq7EGkaetnaAVy66feo3Eu1gZoQaL
         zKfUcFCfyvNRB1/BKpRqVfnWYICik+dpL8F76skiC/8KOehymNWejSAehy1shd6Wwh4f
         3I9j/jr+bUAYzu7hgAw5OVns44kj0glHQop8tdTcRnrmbay3IJrFX0NPX/Nr4GcpUPBh
         nVNqhAtraj8/tQFekm3xndTO2+bQCN5aDSoiOLWTGPRAaA8X+YT00xbOnOFi0atNAlj+
         2pBg==
X-Gm-Message-State: AOJu0YweipZpU3z/8/iq6cJ5SmoyRQAtuzv4vH9VM11NfWC586vaMQaX
	13lKkx1R+0NiUAxAD7Ddbq9JJugYUbSLjDW6bp8=
X-Google-Smtp-Source: AGHT+IHwsGjX7et76vEz4SLVTvFvUx5dO+DMeLBwqdEBMHkKeTOBIRpyFyKp0oLbrJgOgv1FShZ8Nw==
X-Received: by 2002:a05:6a00:21c9:b0:690:41a1:9b6a with SMTP id t9-20020a056a0021c900b0069041a19b6amr4906984pfj.5.1700717765786;
        Wed, 22 Nov 2023 21:36:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e21-20020a656495000000b005b8ebef9fa0sm375794pgv.83.2023.11.22.21.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 21:36:05 -0800 (PST)
Message-ID: <655ee4c5.650a0220.9f78f.0fc2@mx.google.com>
Date: Wed, 22 Nov 2023 21:36:05 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.63-236-gfd300c969e06
Subject: stable-rc/queue/6.1 baseline: 140 runs,
 4 regressions (v6.1.63-236-gfd300c969e06)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 140 runs, 4 regressions (v6.1.63-236-gfd300c9=
69e06)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

rk3399-rock-pi-4b  | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.63-236-gfd300c969e06/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.63-236-gfd300c969e06
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      fd300c969e06ce802c2fd24217f52eea87204999 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655eb3e3184fdd00537e4a7d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-23=
6-gfd300c969e06/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-23=
6-gfd300c969e06/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655eb3e4184fdd00537e4a86
        failing since 0 day (last pass: v6.1.31-26-gef50524405c2, first fai=
l: v6.1.63-176-gecc0fed1ffa4)

    2023-11-23T02:13:40.644723  / # #

    2023-11-23T02:13:40.745430  export SHELL=3D/bin/sh

    2023-11-23T02:13:40.745669  #

    2023-11-23T02:13:40.846253  / # export SHELL=3D/bin/sh. /lava-12064219/=
environment

    2023-11-23T02:13:40.846529  =


    2023-11-23T02:13:40.947219  / # . /lava-12064219/environment/lava-12064=
219/bin/lava-test-runner /lava-12064219/1

    2023-11-23T02:13:40.948150  =


    2023-11-23T02:13:40.953268  / # /lava-12064219/bin/lava-test-runner /la=
va-12064219/1

    2023-11-23T02:13:41.013136  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-23T02:13:41.013597  + cd /lava-120642<8>[   19.067612] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 12064219_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
rk3399-rock-pi-4b  | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655eb4dbd5994b22137e4ac3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-23=
6-gfd300c969e06/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-p=
i-4b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-23=
6-gfd300c969e06/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-p=
i-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655eb4dbd5994b22137e4=
ac4
        new failure (last pass: v6.1.63-176-gecc0fed1ffa4) =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655eb3e89da4f811377e4adb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-23=
6-gfd300c969e06/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-23=
6-gfd300c969e06/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655eb3e89da4f811377e4ae4
        failing since 0 day (last pass: v6.1.22-372-g971903477e72, first fa=
il: v6.1.63-176-gecc0fed1ffa4)

    2023-11-23T02:07:13.838759  / # #
    2023-11-23T02:07:13.940497  export SHELL=3D/bin/sh
    2023-11-23T02:07:13.941123  #
    2023-11-23T02:07:14.042126  / # export SHELL=3D/bin/sh. /lava-444968/en=
vironment
    2023-11-23T02:07:14.042738  =

    2023-11-23T02:07:14.143786  / # . /lava-444968/environment/lava-444968/=
bin/lava-test-runner /lava-444968/1
    2023-11-23T02:07:14.144730  =

    2023-11-23T02:07:14.147385  / # /lava-444968/bin/lava-test-runner /lava=
-444968/1
    2023-11-23T02:07:14.226290  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-23T02:07:14.226991  + cd /lava-444968/<8>[   18.570088] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 444968_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655eb3f415440fda317e4ab1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-23=
6-gfd300c969e06/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-23=
6-gfd300c969e06/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/655eb3f415440fda317e4aba
        failing since 0 day (last pass: v6.1.22-372-g971903477e72, first fa=
il: v6.1.63-176-gecc0fed1ffa4)

    2023-11-23T02:13:56.171905  / # #

    2023-11-23T02:13:56.273861  export SHELL=3D/bin/sh

    2023-11-23T02:13:56.274526  #

    2023-11-23T02:13:56.375654  / # export SHELL=3D/bin/sh. /lava-12064225/=
environment

    2023-11-23T02:13:56.376326  =


    2023-11-23T02:13:56.477466  / # . /lava-12064225/environment/lava-12064=
225/bin/lava-test-runner /lava-12064225/1

    2023-11-23T02:13:56.478419  =


    2023-11-23T02:13:56.480294  / # /lava-12064225/bin/lava-test-runner /la=
va-12064225/1

    2023-11-23T02:13:56.560524  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-23T02:13:56.561010  + cd /lava-1206422<8>[   18.752783] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12064225_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

