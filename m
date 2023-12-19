Return-Path: <stable+bounces-7918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4D88187FD
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 13:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33D41C242E5
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 12:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF67818650;
	Tue, 19 Dec 2023 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="aPS5pWi1"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0271CA92
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59082c4aadaso2997679eaf.0
        for <stable@vger.kernel.org>; Tue, 19 Dec 2023 04:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702990259; x=1703595059; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7b81lGAH1thVqo77DkFrVuJKjAuHzMaNTegsLv+olAU=;
        b=aPS5pWi1Z14RdfLyG0T14QPrmfDDCO1E46Tz0cPPerT5V7UPjbzFS1jHPe+7jsp8ka
         xj1YoE14TYQjdFd6xhStZzWjXLNKpHcmAwLs/QDE2x4vBA2voeZFmCpfINiSve4GpjQf
         B2K/pyOYjUJycGG3u9USJkJwtOp7ZbCfC3GBqqwcqfmXFdkJEKs7m8hv/DxAhJcznOo9
         5ZsmRWqOz3Nuygp4DSO6wfp3TOlbhm6tutRkosqNlQ7lxFU3TVTmMy0gQDsqL9ZdZzfv
         N/8YaSsbUPAhcAcUiHotPxxN8OOPYa+2aNwsBMvd/gKjei+/Ngp6Uuk98Ee0YlgvNZQG
         uC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702990259; x=1703595059;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7b81lGAH1thVqo77DkFrVuJKjAuHzMaNTegsLv+olAU=;
        b=sMeflojOJv2HxIj9ATp3WjS6fa78kTuOm19dkJ3Rb2stl5EI+9q/zKR8BUh5c866Mw
         pyEiph+3VlPDoj/IVt5eNRrqVVYzN3AO1LDCO1kiIYEeI8Y3lhJxWxKj4eUBCBJHO9Xn
         IsI6RUlslAPQDY0WEPnlUG8Ez8WJXx9BjyeNyFLpMpPEXTfrG+yF9XHCVavGYIshXYhZ
         5qYyyx/0FoDjue47+yBLUQVRef0MUst7m+a1XRjzqueYNT2N7Qe4vPTAkdYK0qRXQzSd
         ySpFJjnFrEiXl17+lPt0HIz7YX95uNxKYcQw7o8T3qtKF/Xyw5LC6fVGyKNp5lGBINME
         n+XQ==
X-Gm-Message-State: AOJu0YwPLClQItafg0sPWmt1gY2o0Yiy+bK8u95Otxve+/F115DsXF9S
	AbNub+2vRwZqO2z7ydU+t1W+Tm73Gc/EILn41Bw=
X-Google-Smtp-Source: AGHT+IECkuTOrKdbS5gkUEBBEpjUOWUBKEZTUCaNJbh1XZQ+2r1q4StnI893hr0kQ92hIMyKvGKnAA==
X-Received: by 2002:a05:6358:728e:b0:170:3ef2:de12 with SMTP id w14-20020a056358728e00b001703ef2de12mr13945184rwf.46.1702990258792;
        Tue, 19 Dec 2023 04:50:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j15-20020a170902da8f00b001c9db5e2929sm21004841plx.93.2023.12.19.04.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 04:50:58 -0800 (PST)
Message-ID: <658191b2.170a0220.c3b4d.d339@mx.google.com>
Date: Tue, 19 Dec 2023 04:50:58 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.68-106-gdfaaf0666f4b
Subject: stable-rc/queue/6.1 baseline: 111 runs,
 3 regressions (v6.1.68-106-gdfaaf0666f4b)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 111 runs, 3 regressions (v6.1.68-106-gdfaaf06=
66f4b)

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
el/v6.1.68-106-gdfaaf0666f4b/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.68-106-gdfaaf0666f4b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      dfaaf0666f4b0e8c0c373f37876d20c20ef7c375 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65815d3cfa8a4b7efae134e6

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
6-gdfaaf0666f4b/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
6-gdfaaf0666f4b/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65815d3cfa8a4b7efae134eb
        failing since 26 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-19T09:14:25.807290  / # #

    2023-12-19T09:14:25.909414  export SHELL=3D/bin/sh

    2023-12-19T09:14:25.909643  #

    2023-12-19T09:14:26.010443  / # export SHELL=3D/bin/sh. /lava-12312051/=
environment

    2023-12-19T09:14:26.011106  =


    2023-12-19T09:14:26.112405  / # . /lava-12312051/environment/lava-12312=
051/bin/lava-test-runner /lava-12312051/1

    2023-12-19T09:14:26.113516  =


    2023-12-19T09:14:26.115555  / # /lava-12312051/bin/lava-test-runner /la=
va-12312051/1

    2023-12-19T09:14:26.179208  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-19T09:14:26.179722  + cd /lav<8>[   19.093063] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12312051_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65815d3c3183c0e089e13476

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
6-gdfaaf0666f4b/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
6-gdfaaf0666f4b/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65815d3c3183c0e089e1347b
        failing since 26 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-19T09:06:46.560334  <8>[   18.055588] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 448913_1.5.2.4.1>
    2023-12-19T09:06:46.665312  / # #
    2023-12-19T09:06:46.767022  export SHELL=3D/bin/sh
    2023-12-19T09:06:46.767745  #
    2023-12-19T09:06:46.868753  / # export SHELL=3D/bin/sh. /lava-448913/en=
vironment
    2023-12-19T09:06:46.869356  =

    2023-12-19T09:06:46.970407  / # . /lava-448913/environment/lava-448913/=
bin/lava-test-runner /lava-448913/1
    2023-12-19T09:06:46.971368  =

    2023-12-19T09:06:46.975683  / # /lava-448913/bin/lava-test-runner /lava=
-448913/1
    2023-12-19T09:06:47.048741  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65815d3d4f05eb2ff7e134af

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
6-gdfaaf0666f4b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-10=
6-gdfaaf0666f4b/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pin=
e-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65815d3d4f05eb2ff7e134b4
        failing since 26 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-19T09:14:36.663266  / # #

    2023-12-19T09:14:36.765355  export SHELL=3D/bin/sh

    2023-12-19T09:14:36.766051  #

    2023-12-19T09:14:36.867456  / # export SHELL=3D/bin/sh. /lava-12312056/=
environment

    2023-12-19T09:14:36.868137  =


    2023-12-19T09:14:36.969490  / # . /lava-12312056/environment/lava-12312=
056/bin/lava-test-runner /lava-12312056/1

    2023-12-19T09:14:36.970544  =


    2023-12-19T09:14:36.987404  / # /lava-12312056/bin/lava-test-runner /la=
va-12312056/1

    2023-12-19T09:14:37.053130  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-19T09:14:37.053624  + cd /lava-1231205<8>[   19.184402] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12312056_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

