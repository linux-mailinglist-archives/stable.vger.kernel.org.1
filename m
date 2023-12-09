Return-Path: <stable+bounces-5177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA5980B5F6
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 20:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337011F20610
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 19:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C6B199DF;
	Sat,  9 Dec 2023 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="IjG+5qxc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4065F9
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 11:01:28 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2866951b6e0so3106955a91.2
        for <stable@vger.kernel.org>; Sat, 09 Dec 2023 11:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702148487; x=1702753287; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v36n2EP/9JVL5do+eiZLChl8nhRY9QX04CvFRb4BQmQ=;
        b=IjG+5qxch591XjkySfXhofXGTRtBekw65GlX2N8tZBtS5qWcaJMUeJwqWnXpNYM1Yh
         FMSkMtBrYexnNdPY6Rkvh4eJV+tNxCMOfXfzAjN7KOTBS248CnXzWqy4sV0AL0nEj2Vy
         Rcv98/AhHAQKDbklN3Tzgxn60rBJ32q5ekdcMT/7a8bxjSAa9s+BbtiQnTWveVGUapK0
         bAjX/kd2qIfB3NjjZOoul2V9qxCRNLFUrnAjHTk0JET9kpTadqLMUeTJ1pMerbs/N0Ph
         ZVR5p6WqcY495JxSqXVUx/oe21Dou3jHfQ5G1HjjpOJpVwCB2wNmQDSM6zk45Cu3sd/i
         8OYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702148487; x=1702753287;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v36n2EP/9JVL5do+eiZLChl8nhRY9QX04CvFRb4BQmQ=;
        b=qldDz/NPej1piObt7IzCFx9mYWFDM850iCCbaWnWiSL/qtk7NXHVegykxogghg5WLV
         gv4ji90AAIgKD93CmkEXrDQTgVmC0/qqW4vgGNKQplNEr6VRLDVVgdYVoqN8rY45KqsB
         /TWWNl/in5dDzf7zWdxOkUsunbhvAr/6X0JG5T4T3WsvwoC+RLG+E8b0EKt7nvT7WJ/A
         zTljXR7db+uSqBQdyev60+NT1PL/V/5nKHbMlu+AqjnqMtunLD5ov6/oJnVF+LPDvPrK
         xovtbbNe2PmOmQIlVo/GMn+nas8N/N7T8WavaHCo2AHy0cdKLvbIwqU/B2Y54ES9fTGI
         Kj8w==
X-Gm-Message-State: AOJu0Yzn3nBLyFqUgOR3FNCIQzXnB5Rc1mYgMDV0chQLwK/shB5LXztt
	2Exy7D8hJjs5jhXsQrLR5k55azv9fY69UimrUk+vMA==
X-Google-Smtp-Source: AGHT+IEO8l80yD6D4fCRoAzfsb06fWClMDcsPdQqi8at3WZPp861eyUUNFEj3Y6ddRJKRHIY2pb0HA==
X-Received: by 2002:a17:902:b683:b0:1d0:6ffd:9e25 with SMTP id c3-20020a170902b68300b001d06ffd9e25mr2042515pls.119.1702148487372;
        Sat, 09 Dec 2023 11:01:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902d4c100b001cfcd4eca11sm3681375plg.114.2023.12.09.11.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 11:01:26 -0800 (PST)
Message-ID: <6574b986.170a0220.7b052.b2b3@mx.google.com>
Date: Sat, 09 Dec 2023 11:01:26 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.66-135-gd37672462f1e8
Subject: stable-rc/queue/6.1 baseline: 151 runs,
 4 regressions (v6.1.66-135-gd37672462f1e8)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 151 runs, 4 regressions (v6.1.66-135-gd376724=
62f1e8)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
   | regressions
----------------------+-------+---------------+----------+-----------------=
---+------------
at91-sama5d4_xplained | arm   | lab-baylibre  | gcc-10   | multi_v7_defconf=
ig | 1          =

r8a77960-ulcb         | arm64 | lab-collabora | gcc-10   | defconfig       =
   | 1          =

sun50i-h6-pine-h64    | arm64 | lab-clabbe    | gcc-10   | defconfig       =
   | 1          =

sun50i-h6-pine-h64    | arm64 | lab-collabora | gcc-10   | defconfig       =
   | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.66-135-gd37672462f1e8/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.66-135-gd37672462f1e8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d37672462f1e8aca757b9d8ce7350f10cc37ae7c =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
   | regressions
----------------------+-------+---------------+----------+-----------------=
---+------------
at91-sama5d4_xplained | arm   | lab-baylibre  | gcc-10   | multi_v7_defconf=
ig | 1          =


  Details:     https://kernelci.org/test/plan/id/657483fdeeca3b992de134a9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-13=
5-gd37672462f1e8/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-s=
ama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-13=
5-gd37672462f1e8/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-s=
ama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657483fdeeca3b992de13=
4aa
        new failure (last pass: v6.1.66-15-ga472e3690d9cb) =

 =



platform              | arch  | lab           | compiler | defconfig       =
   | regressions
----------------------+-------+---------------+----------+-----------------=
---+------------
r8a77960-ulcb         | arm64 | lab-collabora | gcc-10   | defconfig       =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/65748435ca3c6e2843e1348d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-13=
5-gd37672462f1e8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-13=
5-gd37672462f1e8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65748435ca3c6e2843e13492
        failing since 16 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-09T15:21:19.041307  / # #

    2023-12-09T15:21:19.143450  export SHELL=3D/bin/sh

    2023-12-09T15:21:19.144171  #

    2023-12-09T15:21:19.245516  / # export SHELL=3D/bin/sh. /lava-12230462/=
environment

    2023-12-09T15:21:19.246156  =


    2023-12-09T15:21:19.347509  / # . /lava-12230462/environment/lava-12230=
462/bin/lava-test-runner /lava-12230462/1

    2023-12-09T15:21:19.348672  =


    2023-12-09T15:21:19.355429  / # /lava-12230462/bin/lava-test-runner /la=
va-12230462/1

    2023-12-09T15:21:19.414670  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-09T15:21:19.415193  + cd /lav<8>[   19.167530] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12230462_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform              | arch  | lab           | compiler | defconfig       =
   | regressions
----------------------+-------+---------------+----------+-----------------=
---+------------
sun50i-h6-pine-h64    | arm64 | lab-clabbe    | gcc-10   | defconfig       =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/657484262ae82a2bc1e134c4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-13=
5-gd37672462f1e8/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-13=
5-gd37672462f1e8/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657484262ae82a2bc1e134c9
        failing since 16 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-09T15:13:36.542179  <8>[   18.143893] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447297_1.5.2.4.1>
    2023-12-09T15:13:36.647218  / # #
    2023-12-09T15:13:36.748864  export SHELL=3D/bin/sh
    2023-12-09T15:13:36.749497  #
    2023-12-09T15:13:36.850485  / # export SHELL=3D/bin/sh. /lava-447297/en=
vironment
    2023-12-09T15:13:36.851090  =

    2023-12-09T15:13:36.952088  / # . /lava-447297/environment/lava-447297/=
bin/lava-test-runner /lava-447297/1
    2023-12-09T15:13:36.952841  =

    2023-12-09T15:13:36.957354  / # /lava-447297/bin/lava-test-runner /lava=
-447297/1
    2023-12-09T15:13:37.030294  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform              | arch  | lab           | compiler | defconfig       =
   | regressions
----------------------+-------+---------------+----------+-----------------=
---+------------
sun50i-h6-pine-h64    | arm64 | lab-collabora | gcc-10   | defconfig       =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/6574844b2f56bd4de1e13477

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-13=
5-gd37672462f1e8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-13=
5-gd37672462f1e8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6574844b2f56bd4de1e1347c
        failing since 16 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-09T15:21:34.240483  / # #

    2023-12-09T15:21:34.342701  export SHELL=3D/bin/sh

    2023-12-09T15:21:34.343406  #

    2023-12-09T15:21:34.444781  / # export SHELL=3D/bin/sh. /lava-12230463/=
environment

    2023-12-09T15:21:34.445494  =


    2023-12-09T15:21:34.546684  / # . /lava-12230463/environment/lava-12230=
463/bin/lava-test-runner /lava-12230463/1

    2023-12-09T15:21:34.546984  =


    2023-12-09T15:21:34.548065  / # /lava-12230463/bin/lava-test-runner /la=
va-12230463/1

    2023-12-09T15:21:34.629121  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-09T15:21:34.629295  + cd /lava-1223046<8>[   19.117379] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12230463_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

