Return-Path: <stable+bounces-6711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE748127BD
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 07:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C6B28243C
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 06:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0FDC8CC;
	Thu, 14 Dec 2023 06:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="CBg2L32c"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56ABE4
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 22:09:38 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-28aec2f2b74so837752a91.1
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 22:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702534178; x=1703138978; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yfKOQDFFxx0mKM+FxakoBjvDzDziTCGBPNqQ8ogE3Ak=;
        b=CBg2L32cIO4Xi3jRSgz4B/8IVjRoUbx7VQkobXnS4Lsw4934jMmWeK3/m4PS5TpRNh
         3TYIxnqBOo29ejb2fGn17Q+u8rPKRoy4WDaS5aE2gBJNRrmuj5LyF4dR+jSn6qgqnaW7
         LBE5pyjZVaZh63HrSunEujZyaJCkNK/IZYqzeLxzQaULqC713B72pSLpbcRoLbo3ynUa
         1G3DBf6AvYQvdeNkVcYAXvY/WRywUe+1s8EYgiRAAODhwfrEd7xKQWX6fR8CI1xvog1u
         txcljXaniXwgSFUq55ZN97zGRG/FzwKwTEXOpbXlR9JQkuCMXapYnJykKrkyvKwRqVyG
         FTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702534178; x=1703138978;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yfKOQDFFxx0mKM+FxakoBjvDzDziTCGBPNqQ8ogE3Ak=;
        b=kHfxMp6iLXTx3zIxuYQ8T8UAgHsXM8/wFzguvsMM/JRxFd5UT/M0Dx3ImzatErySNm
         zGsoqtxRYR30btf9zuSi7VIkK3GiG+lOrkkTmCRYJjVJKnwsxbbw5vShjUEqcFLueAC8
         itXPAMq4arA8w8DG7b1TuHG+hta5TZ5bUh+ZwT1A9dxR2T5LRxQyFoTrPu9BgA2qzW26
         Z5Znw/TdOSu7us7UMXBqAuyUAwepR5tEJYbbb0dmZFRs79Z0wWKgdtZSoFtYjbynQyAo
         tVD2USImQGgFDlEQvGzo5K6GfcTbC3jwTUpsJ2tYqlcZ2fXddnAKT2g796K4mAdF6rLF
         LcQQ==
X-Gm-Message-State: AOJu0YwDz+YlyzeaLlfT6tZQdwhl93o/uvGDNZNgAOceY5tkrvyE916V
	MugKMf+na+a3tVu26JKmt/yyzZ2dQIgJnDB8PZ/WBg==
X-Google-Smtp-Source: AGHT+IG2TxCOmcO7+d6n9OsLo+lLGynfPqotYet5uAC5qsxTGghFin50Cgj2fGghw/52X5ubtfvxhg==
X-Received: by 2002:a17:90a:69a3:b0:28b:1011:6356 with SMTP id s32-20020a17090a69a300b0028b10116356mr12641pjj.33.1702534177875;
        Wed, 13 Dec 2023 22:09:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a198c00b00286d905535bsm13194977pji.0.2023.12.13.22.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 22:09:37 -0800 (PST)
Message-ID: <657a9c21.170a0220.bf3b3.9a4c@mx.google.com>
Date: Wed, 13 Dec 2023 22:09:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.302
Subject: stable-rc/linux-4.19.y baseline: 95 runs, 1 regressions (v4.19.302)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-4.19.y baseline: 95 runs, 1 regressions (v4.19.302)

Regressions Summary
-------------------

platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-4.19.y/ker=
nel/v4.19.302/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-4.19.y
  Describe: v4.19.302
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f93c1f58eb68bada8c86088104efe14cfe735957 =



Test Regressions
---------------- =



platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/657a68d9da44640aade13496

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
02/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-4.19.y/v4.19.3=
02/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a68d9da44640aade134ba
        failing since 15 days (last pass: v4.19.299-93-g263cae4d5493f, firs=
t fail: v4.19.299-93-gc66845304b463)

    2023-12-14T02:30:10.715673  + set +x
    2023-12-14T02:30:10.716690  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 351652_1.5.2=
.4.1>
    2023-12-14T02:30:10.831930  / # #
    2023-12-14T02:30:10.935937  export SHELL=3D/bin/sh
    2023-12-14T02:30:10.936800  #
    2023-12-14T02:30:11.038564  / # export SHELL=3D/bin/sh. /lava-351652/en=
vironment
    2023-12-14T02:30:11.039520  =

    2023-12-14T02:30:11.141818  / # . /lava-351652/environment/lava-351652/=
bin/lava-test-runner /lava-351652/1
    2023-12-14T02:30:11.143503  =

    2023-12-14T02:30:11.147080  / # /lava-351652/bin/lava-test-runner /lava=
-351652/1 =

    ... (12 line(s) more)  =

 =20

