Return-Path: <stable+bounces-8390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 680F781D4DC
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 16:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4171C210A1
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 15:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0CADF66;
	Sat, 23 Dec 2023 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="OJkatoyy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F533DF43
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d774533e73so2647719b3a.1
        for <stable@vger.kernel.org>; Sat, 23 Dec 2023 07:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703345375; x=1703950175; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hlmFk9+3bckouWKS/k1QhxV+4m+xSAHp68bZbzB07TE=;
        b=OJkatoyyGMCZin1h3aDOiD8gJumISBhQBh5egBoe0CyKMeU4GCep6PSZgVrMCYaTmF
         7B1Y3RUS2BE1D4vftOyayIZ4hRgwynrGMHoKwvqGVa5Z8DORydBZikVINfQ8Fq2ZKUrY
         Za5rWki1yt97728jBln9s8zuPKIiuYHB+acybUfpKaJ/HSET3O54H1R7XnOtRZI+Kyca
         m/juxe2/be2kMQxbSLldixL3wwNPqPKElosXbDcoi4PbvFKQS2XPeIDV2Ls1HYHf9NBX
         XPRgjRIyULLkTQCyE42J8f+JbtioIVaTfPiWqy5MdRQ+Nr37HeYa7iKuOL//ehD/8gCv
         KjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703345375; x=1703950175;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlmFk9+3bckouWKS/k1QhxV+4m+xSAHp68bZbzB07TE=;
        b=C78rrN/W0sgAizQez5U90ezjRIC2/mgN7URzY2xT6B326xUJB6G4T9Y71mobIvndX4
         1XY/KQV5oGrINSeBmW7kkqdFUi8cw9+fpvaw22k4iHffTwY6ym6jGuxDBEp8EhzdoSx0
         AgX5L2+mF0ODcj69nArOR7kwLBjPFWXZtOPiiwi/oqsA3grBpaFzYhAWmg43V1KsYJ8G
         UPvggaz5CCPPlpD4aYrhUE2iJ6mjQHgQIpLAOhOcn2bOmdZ26J0Z5nXtZv0o7gvs+aRr
         Q6zYhcOOa/pH96qGuMIQzhROSr7P63doXKUVwkcO6060RNkfJwXaFF8pZVsbHdnOcgeq
         T+Pw==
X-Gm-Message-State: AOJu0YyGhy+PI/R7x6dU7XzBupN1HJN3sTniISa1VXE4JWOLU+LglOeQ
	bIybpUHgr9bsOW/LshLceKsK2i2L3RPhJ7UiiFtwVNkZhJY=
X-Google-Smtp-Source: AGHT+IHWXdNo0t0kip/hQMTiFMwXVQNYV+0yAaoAOWAnEX2jZe29xMhV8kKLzmB3gIMkZ403pKzibg==
X-Received: by 2002:a05:6a20:7351:b0:195:111b:e218 with SMTP id v17-20020a056a20735100b00195111be218mr3778268pzc.81.1703345374941;
        Sat, 23 Dec 2023 07:29:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e13-20020a62ee0d000000b006d9ab3cd847sm591841pfi.209.2023.12.23.07.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 07:29:34 -0800 (PST)
Message-ID: <6586fcde.620a0220.3a1eb.0d8c@mx.google.com>
Date: Sat, 23 Dec 2023 07:29:34 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.145
Subject: stable/linux-5.15.y baseline: 213 runs, 3 regressions (v5.15.145)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-5.15.y baseline: 213 runs, 3 regressions (v5.15.145)

Regressions Summary
-------------------

platform              | arch | lab        | compiler | defconfig           =
         | regressions
----------------------+------+------------+----------+---------------------=
---------+------------
sun7i-a20-cubieboard2 | arm  | lab-clabbe | gcc-10   | multi_v7_defconfig+k=
selftest | 1          =

sun8i-a33-olinuxino   | arm  | lab-clabbe | gcc-10   | multi_v7_defconfig+k=
selftest | 1          =

sun8i-h3-orangepi-pc  | arm  | lab-clabbe | gcc-10   | multi_v7_defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.145/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.145
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      d93fa2c78854d25ed4b67ac87f1c3c264d8b27fb =



Test Regressions
---------------- =



platform              | arch | lab        | compiler | defconfig           =
         | regressions
----------------------+------+------------+----------+---------------------=
---------+------------
sun7i-a20-cubieboard2 | arm  | lab-clabbe | gcc-10   | multi_v7_defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6586cb6b41c76fff4de13482

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.145/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun7i-a20-cubie=
board2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.145/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun7i-a20-cubie=
board2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6586cb6b41c76fff4de13=
483
        failing since 44 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform              | arch | lab        | compiler | defconfig           =
         | regressions
----------------------+------+------------+----------+---------------------=
---------+------------
sun8i-a33-olinuxino   | arm  | lab-clabbe | gcc-10   | multi_v7_defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6586cb7f5f78dbccfae134c7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.145/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-a33-olinu=
xino.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.145/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-a33-olinu=
xino.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6586cb7f5f78dbccfae13=
4c8
        failing since 44 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform              | arch | lab        | compiler | defconfig           =
         | regressions
----------------------+------+------------+----------+---------------------=
---------+------------
sun8i-h3-orangepi-pc  | arm  | lab-clabbe | gcc-10   | multi_v7_defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6586cdaf41f82baf86e134f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.145/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-h3-orange=
pi-pc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.145/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-h3-orange=
pi-pc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6586cdaf41f82baf86e13=
4f3
        failing since 44 days (last pass: v5.15.137, first fail: v5.15.138) =

 =20

