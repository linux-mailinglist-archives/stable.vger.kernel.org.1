Return-Path: <stable+bounces-5284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C46A80C634
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 11:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A751F20CD4
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 10:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636D922EE3;
	Mon, 11 Dec 2023 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="F2cYaeKw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ACAB8
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 02:18:08 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d30141d108so2847645ad.2
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 02:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702289888; x=1702894688; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ujf7mLC7WvsU0XlB1BVgRT3unTDLhvqws9b19Z83lGY=;
        b=F2cYaeKw62SuC2AUCog/wBrVnev2noBOjlvjnyfPdYVTxG3LV10U1Db6XipdPs6JUZ
         /7X2K9FKERePuwsl9DxdRs+gfeNddm7yVEqZGyjA+TkiFZo30EUO2djiSbqDiPyfUkGG
         UhVsWyU3M37m8lodpOSswHa1dc0JSP6SOFP32w4OfXS5c9aLwEdIJfy33tmZWdDA8nds
         3bk76CqjSubuEzK55Jou3hxQuR9fZg1e9FRf03CrgFt+tr5cb2Z/yUVtEkCzMGpGVc67
         +DD6pirziyAzQWJztyDUXVtsNE9PKtUgucug69TJcjEL2XrlllOW1qyo+wROwnZWVz0m
         HjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289888; x=1702894688;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ujf7mLC7WvsU0XlB1BVgRT3unTDLhvqws9b19Z83lGY=;
        b=eh/GgTeh5cNlTVDraL+RKAMtZ49lhjo1lwVGi6KeEPXOGUvlZlyvN1xO2B7AGGnJT4
         q2rhtwoOqLpOpcVGYOiejUkRVKcNigmlPlRbFPMlJ63oGvOYRLRKwrFiG9X9qFHj6dYu
         b3J+4d0SjuObP/BiktdfKpuvzMrA+P9wcXUJSNiShVR9AUyZ6Fm2/JvS3ivpP8VnZtgX
         hgDP/616mRfmM4VQ6e/nMuWowK/5rnHL3eVtcmD1XpivBGf2YQMY6v4W7U/Ib0oZKzNd
         IoGrLJUvn+CKj02DoCEG5QO6JM99jV63sGhs8KA+N8h2cWpYNdIY39KRFPDrWE0o6vMF
         CmFQ==
X-Gm-Message-State: AOJu0YxE8VdRDzVJSFGC0J5fSswiBnsIjorBIb4o5pimwd87Wj5BisGt
	SNyFAMqDT4hZvp055BhKsaRSdeGSlR1agHszaAq1bQ==
X-Google-Smtp-Source: AGHT+IFOZwynpgl7FTPG++y6vIcz/uN10zmkOjiJFCaHkkX/3wI6J5e/uW41wn7r+et8zIJiIBA9nw==
X-Received: by 2002:a17:902:ec89:b0:1d0:aa79:6ef5 with SMTP id x9-20020a170902ec8900b001d0aa796ef5mr1508118plg.123.1702289887888;
        Mon, 11 Dec 2023 02:18:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902c08300b001d0b3c4f5fbsm6263757pld.63.2023.12.11.02.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:18:07 -0800 (PST)
Message-ID: <6576e1df.170a0220.327e8.09f2@mx.google.com>
Date: Mon, 11 Dec 2023 02:18:07 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.66-165-g5921722632a98
Subject: stable-rc/queue/6.1 baseline: 138 runs,
 4 regressions (v6.1.66-165-g5921722632a98)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 138 runs, 4 regressions (v6.1.66-165-g5921722=
632a98)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-10   | defconfig | 1   =
       =

r8a77960-ulcb         | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =

sun50i-h6-pine-h64    | arm64 | lab-clabbe    | gcc-10   | defconfig | 1   =
       =

sun50i-h6-pine-h64    | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.66-165-g5921722632a98/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.66-165-g5921722632a98
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      5921722632a9847bb0be4acec8f02106952f5189 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/6576adc9d07073ddf2e1363a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-16=
5-g5921722632a98/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-kha=
das-vim2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-16=
5-g5921722632a98/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-kha=
das-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6576adc9d07073ddf2e13=
63b
        new failure (last pass: v6.1.66-149-gd84f8303168b1) =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
r8a77960-ulcb         | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/6576c2f37fb4b34c81e134b9

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-16=
5-g5921722632a98/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-16=
5-g5921722632a98/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576c2f37fb4b34c81e134be
        failing since 18 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-11T08:13:28.847182  / # #

    2023-12-11T08:13:28.949378  export SHELL=3D/bin/sh

    2023-12-11T08:13:28.950100  #

    2023-12-11T08:13:29.051423  / # export SHELL=3D/bin/sh. /lava-12243007/=
environment

    2023-12-11T08:13:29.052107  =


    2023-12-11T08:13:29.153491  / # . /lava-12243007/environment/lava-12243=
007/bin/lava-test-runner /lava-12243007/1

    2023-12-11T08:13:29.154460  =


    2023-12-11T08:13:29.155887  / # /lava-12243007/bin/lava-test-runner /la=
va-12243007/1

    2023-12-11T08:13:29.220235  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-11T08:13:29.220783  + cd /lav<8>[   19.110502] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12243007_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
sun50i-h6-pine-h64    | arm64 | lab-clabbe    | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/6576acb2fc43b4d4d1e13475

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-16=
5-g5921722632a98/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-16=
5-g5921722632a98/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576acb2fc43b4d4d1e1347a
        failing since 18 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-11T06:31:09.061224  <8>[   18.121860] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447580_1.5.2.4.1>
    2023-12-11T06:31:09.166186  / # #
    2023-12-11T06:31:09.267828  export SHELL=3D/bin/sh
    2023-12-11T06:31:09.268519  #
    2023-12-11T06:31:09.369506  / # export SHELL=3D/bin/sh. /lava-447580/en=
vironment
    2023-12-11T06:31:09.370096  =

    2023-12-11T06:31:09.471122  / # . /lava-447580/environment/lava-447580/=
bin/lava-test-runner /lava-447580/1
    2023-12-11T06:31:09.472010  =

    2023-12-11T06:31:09.476580  / # /lava-447580/bin/lava-test-runner /lava=
-447580/1
    2023-12-11T06:31:09.549641  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
sun50i-h6-pine-h64    | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/6576acd41d4dbc3f5fe134b8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-16=
5-g5921722632a98/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.66-16=
5-g5921722632a98/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6576acd41d4dbc3f5fe134bd
        failing since 18 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-11T06:39:01.401881  / # #

    2023-12-11T06:39:01.502532  export SHELL=3D/bin/sh

    2023-12-11T06:39:01.502777  #

    2023-12-11T06:39:01.603545  / # export SHELL=3D/bin/sh. /lava-12243008/=
environment

    2023-12-11T06:39:01.603785  =


    2023-12-11T06:39:01.704389  / # . /lava-12243008/environment/lava-12243=
008/bin/lava-test-runner /lava-12243008/1

    2023-12-11T06:39:01.704698  =


    2023-12-11T06:39:01.715496  / # /lava-12243008/bin/lava-test-runner /la=
va-12243008/1

    2023-12-11T06:39:01.788016  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-11T06:39:01.788547  + cd /lava-1224300<8>[   19.181892] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12243008_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

