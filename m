Return-Path: <stable+bounces-3112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138897FCC5A
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 02:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EA22832A8
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 01:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ADB1854;
	Wed, 29 Nov 2023 01:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="YL3nkkqF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3A519AB
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 17:31:27 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c1a75a4b6cso3696042a12.2
        for <stable@vger.kernel.org>; Tue, 28 Nov 2023 17:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701221487; x=1701826287; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=47b6PCreSNS6LSX5dAfJrvbqH7KVQmMyYvhZ/ekQzyU=;
        b=YL3nkkqFDdtJVxVQrybiHBaBjl9islD17YT8Xb2KLX/XB4rWVc5KgOcBUE9CQ3ELee
         HC+VRLo6wOUnkLltJU4AW1L3VXR63e8JDClsXPKAd4h0Ogk7IdE6QIacF0GiKXR9/8ce
         slw+zSeK7tPJ5Ua0AyvQ9+sn9L8ozVjLr7FYn/12+1elqKNPlm8b+QaxqAdN7a+0nG/G
         jZWoP/Wx2CyYn+VYRT87DNhwnY4Hj1UT19jMTnUGJsv2VAKG2ul6tPMPAS9/T8Q/Sqxj
         dHy1uuQ4/Wa1F07uPIGXn1oVhgFR3c655h9VJ47DfgGS5wI7M0edlTN3EEncGx2hbrV1
         FNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701221487; x=1701826287;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47b6PCreSNS6LSX5dAfJrvbqH7KVQmMyYvhZ/ekQzyU=;
        b=AJiLQhl6+td6xKm4qCUaS/uU8xHOli+gVuVw+fy/PqYTQJWebaNtuLVwSdTw163tjW
         bQDdYnUrUj8/WHxpLC95ULKu1m3S+xs04I54849DEj15YQwC7LYPMSBbrG8K9D80kViC
         Wdm66r5uJ8jd3r9Jzn6XcUoJ7GLPpMr/3P7I43S306Q1WjlLDZzsZzGLbpVak7a8t1+z
         eyLaoGDb4P/X1PXQhRStiPtvUqSF8Wt3Gf2FuhPVys4srMCc6C++34ZsjnsSkMavF7wa
         Q1mrTKPusVjvQBoXkn1RLnYyCfMj6bJ2t1WeTSS0q2rqPKfcclqSCm+alzn5zDnW3CKK
         VQoQ==
X-Gm-Message-State: AOJu0Yyf8gEMc3fom7Ofm3HJFFIaVuDn4PIgvRkAeDATm3S0n6Y/umFj
	9RiGrW6EaA4G1dqRboSoDWbf2WO2yejai0QmhyU=
X-Google-Smtp-Source: AGHT+IGLDV2hSsVpJHfDMydqIRC796joRiJvzSG39b25LnicbCuu+5/qvtMI6ZSCMKa0nBtuVlAk4A==
X-Received: by 2002:a05:6a20:42a6:b0:18c:771:7dfa with SMTP id o38-20020a056a2042a600b0018c07717dfamr17510530pzj.3.1701221486893;
        Tue, 28 Nov 2023 17:31:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id li6-20020a17090b48c600b00282ecb631a9sm130322pjb.25.2023.11.28.17.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 17:31:26 -0800 (PST)
Message-ID: <6566946e.170a0220.a1e5.06a7@mx.google.com>
Date: Tue, 28 Nov 2023 17:31:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v5.15.140
Subject: stable/linux-5.15.y baseline: 218 runs, 4 regressions (v5.15.140)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-5.15.y baseline: 218 runs, 4 regressions (v5.15.140)

Regressions Summary
-------------------

platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun7i-a20-cubieboard2       | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =

sun8i-a33-olinuxino         | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =

sun8i-h3-orangepi-pc        | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =

sun8i-r40-bananapi-m2-ultra | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.140/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.140
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      a78d278e01b1b608f90077258debc7a98de51482 =



Test Regressions
---------------- =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun7i-a20-cubieboard2       | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/656662a08fbe5e00447e4a6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.140/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun7i-a20-cubie=
board2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.140/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun7i-a20-cubie=
board2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656662a08fbe5e00447e4=
a70
        failing since 19 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun8i-a33-olinuxino         | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6566629fb8338889387e4af3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.140/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-a33-olinu=
xino.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.140/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-a33-olinu=
xino.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6566629fb8338889387e4=
af4
        failing since 19 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun8i-h3-orangepi-pc        | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65666457cb260b0b757e4abd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.140/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-h3-orange=
pi-pc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.140/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-h3-orange=
pi-pc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65666457cb260b0b757e4=
abe
        failing since 19 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun8i-r40-bananapi-m2-ultra | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6566646bead902c7967e4ae4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.140/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-r40-banan=
api-m2-ultra.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.140/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-r40-banan=
api-m2-ultra.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6566646bead902c7967e4=
ae5
        failing since 19 days (last pass: v5.15.137, first fail: v5.15.138) =

 =20

