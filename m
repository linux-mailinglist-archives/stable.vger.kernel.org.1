Return-Path: <stable+bounces-3728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BC1802399
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84248280D78
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 12:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B74FC154;
	Sun,  3 Dec 2023 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="vE7uED2z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0110EF2
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 04:05:23 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5c27ee9c36bso1716022a12.1
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 04:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701605123; x=1702209923; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BF+SeIZviyvryhhOZQnqaBv8T76pvqJgtwfqYZg3qYE=;
        b=vE7uED2ztOoa/2/PZWnffXwgxkWFzr3JvUFDNHxHw6y/j4d9+v94vctqBe+KPot0dp
         JXjnWAI7f1FmcpkWr5ME6QznUfCTW2oKZmhUgXoUzWOP/7+Kc1790FGrUPKaKf3qm+qQ
         M2UfcDFuDnz7oizSyq3T5FxlCbiRokBx8ERPPXoyt+BkwiXK/HQ9HTfEDMkToeVUFWYw
         AV2PpCKFJBPsI9Wn9Iz1CrU1JZqC+WNcXQyzp2ZlEXbrDIVjNX+eKPaqHOKnAxzo24Ii
         vpyEzUk2K5NVSvc9jQofVK7Rin4DSRvCw7xLpiUjx2FuxtIJ9HMQuF0nLuHksHyDE4tA
         Mk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701605123; x=1702209923;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BF+SeIZviyvryhhOZQnqaBv8T76pvqJgtwfqYZg3qYE=;
        b=dki683QjPcOzWZAsz5+Ax1gL5b33f5OHRChZluvJbNPDO0i2h1lnYdxO4AkN9fjdOX
         +Y1uwmTvWGFjwx2glhsd7CI/w/WErBk1H23zmX7bAQ2cGXzZt961paiJRFZ/4bvO33EZ
         2UMkA+ilnTJQJnDhrzMZArHVrGVTKDVv/ZKSIh9ASRL8zIx+t1J8oAXgHNfIlunB0KhW
         7MEKYI83wlSm1B7V1eqOZ3r+EYgKGl8wyXi2dyTnQfju/OKmNBh2WaFzAcJG1oRO3ZXx
         KcXIUJpEd20Ql9huS8ibcdtxwmjgkK99o/HiACYPuKml2oN/ElTM8w6vzn3sBagUJZbH
         MhFw==
X-Gm-Message-State: AOJu0Yzx9VvZSFIkjqtAylNzOccq0MqpR3AoJWUSK6e9thYJ93K9x4bj
	iiFZuzBL/cNT+WNBdkJgI2WxIW2qMvfFuNqqQjlJTA==
X-Google-Smtp-Source: AGHT+IH3kfNJwZSUh8SuSoGCBntpAW/msKoit/rfC0Jco/y8/NcoSR6XbLubA3ptDyGSm87DNvS6dA==
X-Received: by 2002:a17:903:2348:b0:1cf:a70b:39cd with SMTP id c8-20020a170903234800b001cfa70b39cdmr2816617plh.39.1701605122921;
        Sun, 03 Dec 2023 04:05:22 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902d48100b001d057080022sm4460101plg.20.2023.12.03.04.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 04:05:22 -0800 (PST)
Message-ID: <656c6f02.170a0220.29171.b2aa@mx.google.com>
Date: Sun, 03 Dec 2023 04:05:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.141
Subject: stable/linux-5.15.y baseline: 207 runs, 4 regressions (v5.15.141)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-5.15.y baseline: 207 runs, 4 regressions (v5.15.141)

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
/v5.15.141/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.141
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      9b91d36ba301db86bbf9e783169f7f6abf2585d8 =



Test Regressions
---------------- =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun7i-a20-cubieboard2       | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/656c3d82bd091064b0e13481

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.141/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun7i-a20-cubie=
board2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.141/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun7i-a20-cubie=
board2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c3d82bd091064b0e13=
482
        failing since 23 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun8i-a33-olinuxino         | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/656c3d83bd091064b0e13487

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.141/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-a33-olinu=
xino.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.141/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-a33-olinu=
xino.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c3d83bd091064b0e13=
488
        failing since 23 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun8i-h3-orangepi-pc        | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/656c3eec1f86295441e13480

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.141/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-h3-orange=
pi-pc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.141/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-h3-orange=
pi-pc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c3eec1f86295441e13=
481
        failing since 23 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun8i-r40-bananapi-m2-ultra | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/656c3efe1f86295441e13493

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.141/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-r40-banan=
api-m2-ultra.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.141/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-r40-banan=
api-m2-ultra.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656c3efe1f86295441e13=
494
        failing since 23 days (last pass: v5.15.137, first fail: v5.15.138) =

 =20

