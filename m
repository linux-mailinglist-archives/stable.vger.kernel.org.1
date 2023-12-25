Return-Path: <stable+bounces-8443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36D181DEBF
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 08:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C77E1F215A2
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 07:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4290F111B;
	Mon, 25 Dec 2023 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="IM3wdpkV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1610956
	for <stable@vger.kernel.org>; Mon, 25 Dec 2023 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3cfb1568eso30073825ad.1
        for <stable@vger.kernel.org>; Sun, 24 Dec 2023 23:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703487927; x=1704092727; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YiSJdr2UD3qnqc1wF/GjaTE8l+tZuOmse7xvZrFb+Y4=;
        b=IM3wdpkVzVpvFZNYVgTKS5J/HqV4bYh+8DOSA6Zf82Gn17oCyePg0FO6GPXOVfAArD
         qQ+nYMQ6DvGe6sy2juDPIg+wvt/FFHcQQtEzbkZQE+LWRIesl8vYdFkVLvgZYMCFjP0P
         sZQqyLf3lBi2MydzLuPAx7A7P5kb9OgCmR2brPbyDCx5BZSXfGgObOhwkisEu705LpEe
         HDY3oo7A5jw9aLFf38OgUUqvDs7C1CNrvCKS3YV2ch4HCjZvSthw7sNW6MNYoqjUzfPa
         JTKkLbXdrKGKH7FQ/9mrLdAJDKNc9EVzER+bvh4CtmYM9QpTpPrXLKsS1kb2yqUvGzTi
         FVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703487927; x=1704092727;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YiSJdr2UD3qnqc1wF/GjaTE8l+tZuOmse7xvZrFb+Y4=;
        b=uSuiHFZG5cgW9smjDMX6r33FRB6DLQaJC1ghLDCj7weMbNI8tkUrQcLDahfk0FOJgx
         3PLbuwR77JwNtgqUh8nFFN98wFUaQjYHkuUqk4Ue4V6ehovI8er7OIEUTsEdh57J78fc
         WwxBtVKJKZN8/Y9OYzce8s+W9GPwa5o8FiyNwfQSoobrkM3+9GMJNavTsM8vVPD3F+Ko
         724xKqNFDQZiZE8AcfFbCpK/HCbdZ6BfUIA8x6F9MglnGyJZu/b0XO7hrgbDxCW9M6oY
         d2OCZx0PTJ1Sywrbu1OTb0B2Xzj+kJ3gXY8lQknFsrt17yqGRXduxVSC67UpETjAmbbL
         YdYA==
X-Gm-Message-State: AOJu0YwxqdYLUJPMSuwGNZxzUx9JSem35f0FhcU4hfllS+R8zIHh7bUp
	y30vMWJ6TDiSKppB3alRX0Bj15+dkDhzCJ/yjp4p6+1CiAs=
X-Google-Smtp-Source: AGHT+IHHAO/wW/m20A1T40skJEpvHY5lhllPYJ6FbEYrMQ3p3T0PEL2uqVgHS5R5e1jS9+nft2lcPA==
X-Received: by 2002:a17:902:c412:b0:1d4:202f:945d with SMTP id k18-20020a170902c41200b001d4202f945dmr6967697plk.98.1703487927110;
        Sun, 24 Dec 2023 23:05:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902cec400b001c62b9a51a4sm7571599plg.239.2023.12.24.23.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 23:05:26 -0800 (PST)
Message-ID: <658929b6.170a0220.ca89c.445a@mx.google.com>
Date: Sun, 24 Dec 2023 23:05:26 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.68-165-g5fc04d6b4e97d
Subject: stable-rc/queue/6.1 baseline: 107 runs,
 3 regressions (v6.1.68-165-g5fc04d6b4e97d)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 107 runs, 3 regressions (v6.1.68-165-g5fc04d6=
b4e97d)

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
el/v6.1.68-165-g5fc04d6b4e97d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.68-165-g5fc04d6b4e97d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5fc04d6b4e97db031aaba0590121c108eb39a9a0 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6588f64011ebfc4846e1348f

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-16=
5-g5fc04d6b4e97d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-16=
5-g5fc04d6b4e97d/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6588f64011ebfc4846e13498
        failing since 32 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-25T03:33:16.723290  / # #

    2023-12-25T03:33:16.825879  export SHELL=3D/bin/sh

    2023-12-25T03:33:16.826650  #

    2023-12-25T03:33:16.928084  / # export SHELL=3D/bin/sh. /lava-12377138/=
environment

    2023-12-25T03:33:16.928896  =


    2023-12-25T03:33:17.030387  / # . /lava-12377138/environment/lava-12377=
138/bin/lava-test-runner /lava-12377138/1

    2023-12-25T03:33:17.031607  =


    2023-12-25T03:33:17.046618  / # /lava-12377138/bin/lava-test-runner /la=
va-12377138/1

    2023-12-25T03:33:17.096869  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-25T03:33:17.097391  + cd /lava-123771<8>[   19.075498] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 12377138_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6588f6289613e0c210e13479

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-16=
5-g5fc04d6b4e97d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-16=
5-g5fc04d6b4e97d/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6588f6289613e0c210e13482
        failing since 32 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-25T03:25:22.358554  <8>[   18.130768] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 449844_1.5.2.4.1>
    2023-12-25T03:25:22.463545  / # #
    2023-12-25T03:25:22.565141  export SHELL=3D/bin/sh
    2023-12-25T03:25:22.565700  #
    2023-12-25T03:25:22.666779  / # export SHELL=3D/bin/sh. /lava-449844/en=
vironment
    2023-12-25T03:25:22.667320  =

    2023-12-25T03:25:22.768361  / # . /lava-449844/environment/lava-449844/=
bin/lava-test-runner /lava-449844/1
    2023-12-25T03:25:22.769250  =

    2023-12-25T03:25:22.773940  / # /lava-449844/bin/lava-test-runner /lava=
-449844/1
    2023-12-25T03:25:22.846946  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6588f65311ebfc4846e134ff

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-16=
5-g5fc04d6b4e97d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-16=
5-g5fc04d6b4e97d/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6588f65311ebfc4846e13508
        failing since 32 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-25T03:33:29.455632  / # #

    2023-12-25T03:33:29.557815  export SHELL=3D/bin/sh

    2023-12-25T03:33:29.558528  #

    2023-12-25T03:33:29.659920  / # export SHELL=3D/bin/sh. /lava-12377143/=
environment

    2023-12-25T03:33:29.660692  =


    2023-12-25T03:33:29.762122  / # . /lava-12377143/environment/lava-12377=
143/bin/lava-test-runner /lava-12377143/1

    2023-12-25T03:33:29.763207  =


    2023-12-25T03:33:29.779789  / # /lava-12377143/bin/lava-test-runner /la=
va-12377143/1

    2023-12-25T03:33:29.845773  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-25T03:33:29.846277  + cd /lava-1237714<8>[   19.216073] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12377143_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

