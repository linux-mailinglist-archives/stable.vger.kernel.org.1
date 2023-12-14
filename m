Return-Path: <stable+bounces-6702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A83581254F
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 03:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6750F1C212C1
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 02:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320CF391;
	Thu, 14 Dec 2023 02:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="xHgUXu4x"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96660B7
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 18:32:39 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6da330ff8fdso1310455a34.0
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 18:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702521158; x=1703125958; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aDL3mM6D/0+VDV7gCvtGz8JFtWOgjMt6q9tF1JTFXdk=;
        b=xHgUXu4xxJPvUZHrbW1b8ooy8Kb3A5wi2qrUNgN+oqZuqYZjQgTDJGVwlyrU9l+rRX
         qfeSUX1eFaKO2UAT5PqQfd54TQ9SlPaxKrZwwm0/lma4E4kcsSHylD8CW9ncVfN0vtUY
         eq2+jgrrQgMgq3ldF+9QzmbnxpEN3tHhoF3wCp5YLo2ZNo628SPEKQzQ1kIw51zHrRxw
         xEDPXi0R8Xi7LOUzUt1pM4RGSut8rVFaq7z3YWKQXvdpAcqJfE5E82QUTAxIpOokEn+W
         zCi/CqC4O8l062+86ebbXlFq2tJmEsH4zrrrcU18rKydxWHKMN1xsqy9QbKrMWUrS/3U
         lYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702521158; x=1703125958;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDL3mM6D/0+VDV7gCvtGz8JFtWOgjMt6q9tF1JTFXdk=;
        b=CkzRCw8Sw1Gnr/P0lU2TKEZZF5IJIubka2ra8iRNfd54JuHBjswx6DeqZ0b1WGmC5K
         SSRR+MlcwIY9csYBm+cxACjPrcBZrn3qFw5cAGc+Y5SDNsNjKBVV5RQfTTwLAzDLFyml
         GJ3zSuZGuDHGA8Hl/CgfiGmBnoJwBaNQ8cFSZv5Nt2MHXwp8/j8l/CqN+jiPS2EuRNEi
         TKyK86+ux8066rI+K+viZoNCcRPsb7u25+deOla/ya2HVMRSENZHFRVNw9mOCkSVsnOW
         gofeTXGvg20nNhWHkS+XACnXal8gQIx7tzWASAwbDeC+8bSP5gQB+eJa/W+j2cyPFLb3
         PU3Q==
X-Gm-Message-State: AOJu0YxsM5b7oGEP5/F5QqS5E0KSW/L0tlrP9KDsa21dG22n6rqqd236
	/rp8h51hk1Szm13Tz2b1+VhVgCb7XDOPFkc+pEEuhw==
X-Google-Smtp-Source: AGHT+IEfO7YsA2pUeiMcBxqkkDwLPsC21T7+bO9PkMkJl8zVDYgeaoJo3IMvNgm8KPEF3UZVajBuxg==
X-Received: by 2002:a05:6808:11d0:b0:3ba:4c6:f39b with SMTP id p16-20020a05680811d000b003ba04c6f39bmr8627715oiv.98.1702521158471;
        Wed, 13 Dec 2023 18:32:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id it24-20020a056a00459800b006cbafa4b426sm10517919pfb.110.2023.12.13.18.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 18:32:37 -0800 (PST)
Message-ID: <657a6945.050a0220.3da06.17cd@mx.google.com>
Date: Wed, 13 Dec 2023 18:32:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.204
Subject: stable/linux-5.10.y baseline: 156 runs, 1 regressions (v5.10.204)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-5.10.y baseline: 156 runs, 1 regressions (v5.10.204)

Regressions Summary
-------------------

platform   | arch  | lab         | compiler | defconfig | regressions
-----------+-------+-------------+----------+-----------+------------
juno-uboot | arm64 | lab-broonie | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.204/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.204
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      b50306f77190155d2c14a72be5d2e02254d17dbd =



Test Regressions
---------------- =



platform   | arch  | lab         | compiler | defconfig | regressions
-----------+-------+-------------+----------+-----------+------------
juno-uboot | arm64 | lab-broonie | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/657a3825fc86d92232e13475

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.204/=
arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.204/=
arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a3826fc86d92232e134b5
        new failure (last pass: v5.10.203)

    2023-12-13T23:02:32.369502  <8>[   29.497489] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 350454_1.5.2.4.1>
    2023-12-13T23:02:32.477638  / # #
    2023-12-13T23:02:32.580474  export SHELL=3D/bin/sh
    2023-12-13T23:02:32.581248  #
    2023-12-13T23:02:32.683252  / # export SHELL=3D/bin/sh. /lava-350454/en=
vironment
    2023-12-13T23:02:32.683993  =

    2023-12-13T23:02:32.785950  / # . /lava-350454/environment/lava-350454/=
bin/lava-test-runner /lava-350454/1
    2023-12-13T23:02:32.787249  =

    2023-12-13T23:02:32.801767  / # /lava-350454/bin/lava-test-runner /lava=
-350454/1
    2023-12-13T23:02:32.860650  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20

