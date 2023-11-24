Return-Path: <stable+bounces-111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BB47F7155
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 11:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1E91C20DA2
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 10:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67991946A;
	Fri, 24 Nov 2023 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="lkqoJNco"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D7B92
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 02:24:07 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cbe6d514cdso1246434b3a.1
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 02:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700821446; x=1701426246; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3f0aUNazdHogwLhoPMhJqe06TN+lnu/oGjHephJEErw=;
        b=lkqoJNcoDPQ+CspbimRVPwe0y+xDVHPj49ej9WUQJKzhqL4OmewmZ4QgRiBNcF23tn
         DNW2FjOU5twksRHAM1uTP19gmJ44VTS8vAjbg5+WhTWqRms4NnMmQK+okE2seTm9OfA6
         b82xg+1pylG98fk5iQRkwGkSN1Y1b/yc1NZw8/XiA+N7xwO9J/aNBSF1nU4NcGVardTH
         CQKtsY8Edpt1yV6BiUV/sn9J3SqHkPnJkPmGrG6w4gRgBfhGgnXLK3iKRNCdmgQ0z6f2
         O8xkNL6lVOEzgLrjVUuR1Vw4+y51fLiUdBFyQoOswqhfk3FFznyU4lr5zK9EW7tgqDQc
         dYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700821446; x=1701426246;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3f0aUNazdHogwLhoPMhJqe06TN+lnu/oGjHephJEErw=;
        b=AJKHf7gi2TuIc+wELukmX8+aCyu900KPNzkKoqLiGyi8jMCyoZ4U1bOyhipAalgo/3
         9S77MW3IuCtuAg8lMLZmtA6hGygEJz6+rU43tMP4gsR2WX7/IDr35a04lPQb/u4HdEOb
         jsa8x1BzeP6NBn7MEHPwzsurUlw8KVccO75Bv6LGkKhZ5FTV7ycu3VBmNsdNBUeqvew2
         QPgEKCEJkA0iDVxCC3dCfVl/WCklfAEqFJU3pe32kJUZ4kHqcLvJacB0GWjAzaTK31NA
         Sw6YYRSM0+JFPj5FsY/hOKJ071+aXlL2w9iSuV2nDpaAV/sFGvFZgaQWXXUY+j4RsyUf
         wO1w==
X-Gm-Message-State: AOJu0YzjYLiRXECHkAC83XPqiQ8GrVy8koCMdAO/i9NMbOT+cxYmYB6m
	Ywdrk6Ev+VAlwjIgR4JmCxhUcGAm+OU+U3OG6Ic=
X-Google-Smtp-Source: AGHT+IHvSCZBivHIgSDEJuraR7II9T7GcT9Dzby+ToOcq7gJ1v0w2p1ZCtQdesOwvTlkVBwcd/vHIQ==
X-Received: by 2002:a05:6a20:144e:b0:18a:d766:cae1 with SMTP id a14-20020a056a20144e00b0018ad766cae1mr2124530pzi.54.1700821446258;
        Fri, 24 Nov 2023 02:24:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e22-20020aa78256000000b006cb81192469sm2560192pfn.169.2023.11.24.02.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 02:24:05 -0800 (PST)
Message-ID: <656079c5.a70a0220.149ba.60dd@mx.google.com>
Date: Fri, 24 Nov 2023 02:24:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: queue/4.19
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v4.19.299-76-ge745246f71bf0
Subject: stable-rc/queue/4.19 baseline: 54 runs,
 1 regressions (v4.19.299-76-ge745246f71bf0)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.19 baseline: 54 runs, 1 regressions (v4.19.299-76-ge74524=
6f71bf0)

Regressions Summary
-------------------

platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F4.19/ker=
nel/v4.19.299-76-ge745246f71bf0/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/4.19
  Describe: v4.19.299-76-ge745246f71bf0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e745246f71bf06d88a79d5a08f23374e648e001b =



Test Regressions
---------------- =



platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6560487a6b310f751a7e4a6f

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.299=
-76-ge745246f71bf0/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91s=
am9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.299=
-76-ge745246f71bf0/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91s=
am9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6560487a6b310f751a7e4aa2
        failing since 1 day (last pass: v4.19.284-5-gd33af5806015, first fa=
il: v4.19.299-50-gaa3fbf0e1c59)

    2023-11-24T06:53:06.334742  + set +x
    2023-11-24T06:53:06.335219  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 268576_1.5.2=
.4.1>
    2023-11-24T06:53:06.447716  / # #
    2023-11-24T06:53:06.550683  export SHELL=3D/bin/sh
    2023-11-24T06:53:06.551534  #
    2023-11-24T06:53:06.653482  / # export SHELL=3D/bin/sh. /lava-268576/en=
vironment
    2023-11-24T06:53:06.654328  =

    2023-11-24T06:53:06.756309  / # . /lava-268576/environment/lava-268576/=
bin/lava-test-runner /lava-268576/1
    2023-11-24T06:53:06.757630  =

    2023-11-24T06:53:06.761217  / # /lava-268576/bin/lava-test-runner /lava=
-268576/1 =

    ... (12 line(s) more)  =

 =20

