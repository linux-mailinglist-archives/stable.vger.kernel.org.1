Return-Path: <stable+bounces-2649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633657F8F9C
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 23:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01031281439
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 22:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B962F30FA6;
	Sat, 25 Nov 2023 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="chnvZJPJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33122111
	for <stable@vger.kernel.org>; Sat, 25 Nov 2023 14:07:18 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cfbce92362so2205535ad.1
        for <stable@vger.kernel.org>; Sat, 25 Nov 2023 14:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700950037; x=1701554837; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yRQ6xJS+vKipicA9c0NlB59WXbMrZjJzPDngSEyI3V8=;
        b=chnvZJPJXyVoU73GJDrhfJQAuvqWyWRarfF7Ihv9o2N3SAmSOehv8Cehvk1UuqxLAh
         O/8Yq59lnGsnjutBFNA7KTgIVb6Vi9ZY2fOd/3i67wlYerVdDKNngUY2IdTI8hJbvak6
         96drtRw/HFv+3f1sisj4uxIm5Ky8oroRERJ2l8gFRBrm5KoROg056fTQoSgfOedoR153
         z6q+A2kWdT9HaML5GCXmrkbKDEO5TVRIa8fdTBsJ18/GbQpHsoTkcmabkhItcA9Brq4m
         faRpQEV5dxnSHUtyxYxzxDvd+a7JweytjKWPh/jlN4bNkuVTFTaWBAC5YcX7OpDu8snr
         ULgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700950037; x=1701554837;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRQ6xJS+vKipicA9c0NlB59WXbMrZjJzPDngSEyI3V8=;
        b=BGZVV8JfPo7Kyg1wYhosmYq0n9MXJOPZIfDVwLPG0f0beZnc0DmlVOH3EuqlwY/32o
         5HtyOjZ5jVCFdkKo3uN5oEMfae9ym1GbGKKZ2HiVfsCOYdVS/tWmdORuRU6NjtMylLtN
         qbmenr+duVmVEpBNy/1o/v+xKUJybMj9uD45egueCmTBa0plmzE8fqNURJsdQvZe7UtB
         8HqkLErr8dG8sNhmC3zSXKVXs4MeHkuYtS2y0rNZkylpBCtcb2ODAySrxs96TdP8m8QC
         wdcv4J18JFHwetZI3JuQBsXvuTM+IFazpq1Tz4BnKKAEz61y+9sG7hYXrDMhqleTAYaE
         xwXg==
X-Gm-Message-State: AOJu0Yyc/QKs+6DVS9n99S+UmR4vdxk/PPG0N2CD+FW8xcO8d0yz/iWM
	PMzpdauYJWdIAaqAXf3P+B366R+AqPPA5JCUmHg=
X-Google-Smtp-Source: AGHT+IG2ADjBhcezpUlZBrH99kJATbfwVVUaA8YNT/d8HS8XPmgPh0atzetCHIGRApdp/2JOp32JmA==
X-Received: by 2002:a17:902:d4c5:b0:1cc:22db:cf3d with SMTP id o5-20020a170902d4c500b001cc22dbcf3dmr15359586plg.15.1700950037159;
        Sat, 25 Nov 2023 14:07:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c14-20020a170902d48e00b001cf8c062610sm5332979plg.127.2023.11.25.14.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 14:07:16 -0800 (PST)
Message-ID: <65627014.170a0220.e1b7.c6b8@mx.google.com>
Date: Sat, 25 Nov 2023 14:07:16 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.63-369-g4cad21545d49d
Subject: stable-rc/queue/6.1 baseline: 146 runs,
 3 regressions (v6.1.63-369-g4cad21545d49d)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 146 runs, 3 regressions (v6.1.63-369-g4cad215=
45d49d)

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
el/v6.1.63-369-g4cad21545d49d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.63-369-g4cad21545d49d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4cad21545d49d4e1b3721aa0489c85600627deb9 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65623e3e600346e0a17e4a6d

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-36=
9-g4cad21545d49d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-36=
9-g4cad21545d49d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65623e3e600346e0a17e4a76
        failing since 3 days (last pass: v6.1.31-26-gef50524405c2, first fa=
il: v6.1.63-176-gecc0fed1ffa4)

    2023-11-25T18:40:50.301513  / # #

    2023-11-25T18:40:50.403359  export SHELL=3D/bin/sh

    2023-11-25T18:40:50.403573  #

    2023-11-25T18:40:50.504230  / # export SHELL=3D/bin/sh. /lava-12083652/=
environment

    2023-11-25T18:40:50.504518  =


    2023-11-25T18:40:50.605289  / # . /lava-12083652/environment/lava-12083=
652/bin/lava-test-runner /lava-12083652/1

    2023-11-25T18:40:50.606427  =


    2023-11-25T18:40:50.609984  / # /lava-12083652/bin/lava-test-runner /la=
va-12083652/1

    2023-11-25T18:40:50.671703  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-25T18:40:50.672199  + cd /lav<8>[   19.107798] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12083652_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65623e42600346e0a17e4a94

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-36=
9-g4cad21545d49d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-36=
9-g4cad21545d49d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65623e42600346e0a17e4a9d
        failing since 3 days (last pass: v6.1.22-372-g971903477e72, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-11-25T18:34:16.197886  <8>[   18.144354] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445270_1.5.2.4.1>
    2023-11-25T18:34:16.305104  / # #
    2023-11-25T18:34:16.406828  export SHELL=3D/bin/sh
    2023-11-25T18:34:16.407401  #
    2023-11-25T18:34:16.508440  / # export SHELL=3D/bin/sh. /lava-445270/en=
vironment
    2023-11-25T18:34:16.509124  =

    2023-11-25T18:34:16.610134  / # . /lava-445270/environment/lava-445270/=
bin/lava-test-runner /lava-445270/1
    2023-11-25T18:34:16.611080  =

    2023-11-25T18:34:16.613287  / # /lava-445270/bin/lava-test-runner /lava=
-445270/1
    2023-11-25T18:34:16.693354  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65623e52cdb76b3ea27e4a81

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-36=
9-g4cad21545d49d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.63-36=
9-g4cad21545d49d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65623e52cdb76b3ea27e4a8a
        failing since 3 days (last pass: v6.1.22-372-g971903477e72, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-11-25T18:41:04.918853  / # #

    2023-11-25T18:41:05.020725  export SHELL=3D/bin/sh

    2023-11-25T18:41:05.021480  #

    2023-11-25T18:41:05.122778  / # export SHELL=3D/bin/sh. /lava-12083650/=
environment

    2023-11-25T18:41:05.123473  =


    2023-11-25T18:41:05.224728  / # . /lava-12083650/environment/lava-12083=
650/bin/lava-test-runner /lava-12083650/1

    2023-11-25T18:41:05.225811  =


    2023-11-25T18:41:05.269686  / # /lava-12083650/bin/lava-test-runner /la=
va-12083650/1

    2023-11-25T18:41:05.307949  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-25T18:41:05.308450  + cd /lava-1208365<8>[   18.747654] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12083650_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

