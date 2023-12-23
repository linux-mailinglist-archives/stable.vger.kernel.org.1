Return-Path: <stable+bounces-8407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1962A81D69B
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 22:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6CC61C215D2
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 21:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDB9168CD;
	Sat, 23 Dec 2023 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="m/VEHO7/"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061E168A8
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 21:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3ba14203a34so2687041b6e.1
        for <stable@vger.kernel.org>; Sat, 23 Dec 2023 13:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703366576; x=1703971376; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IZml0EZHJ+zEGJ0WVGuLwTooo3dymOS1hDNGgwPuYGo=;
        b=m/VEHO7/e0PU32BbDwKsS7RFUg6ghFPIWzHpKPSN/CGqGbBGBBXr8cvBF8630BxBdC
         TwjNVsAvXO7vnFsMpza5kwFW3/gVdjK8VmY805Z5zQ8nEEcDv40eK+LUTBHfRtFG8edb
         F54i2oZCtSELJjIGN13GKnMKSbOwfbfwaqPKXI3rO4VfmJ+2GbO+OKtzY1Tehy5F3JI+
         hwZ4B8Rq2SCAzYSFJ+jke8JwqBV9Ph4kYCdRCBklKBo3sPZC6EgNJpDAhK2PIY5Fi1hq
         8DPCbgCC+vG/IoXc854Z76xr4JEJnDfJ0hRrAfR643HE6oun7n1bZVbF+sb0Z9PpDfuy
         bBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703366576; x=1703971376;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZml0EZHJ+zEGJ0WVGuLwTooo3dymOS1hDNGgwPuYGo=;
        b=Somxj5676VtL9d8THOkaa8OdNpl6/8J0TwIcFlcfqIGhvPWG2EkAWvMmgOEg6w7AeD
         fxrVcgu5xKiz9Stj8UMle3MA/z6vpRoUN0k7JmhEFNwoNYMeaVlwOEnJd0IATzhKIdxR
         JBiSs0Vr6TzQh+One8brZgxd/2g0AF7cW948dzHQf4Lnil+RxdHnnpJQ5kDkbD35LnPS
         fzMXHV6NG3Hl+LVBws+3NW/X1yjEM6M18RyEg7cA7V1n2YNaErrA8xr4e372iCFMIlIg
         IEwRLvWRfBoPXEo+G2Rvp/g/9a5WcHurdYJCnK+LhPOGlhASV0XA1QB2hfjwE9eR+HVH
         vuRA==
X-Gm-Message-State: AOJu0YzfOnmpo8dC+GUjdyJcbNH+hfQgWCjMyjhnBzqPf9eOAyckzHe8
	zylEEHdCB0zAiNrJnLgIf9hVxSanvGdbjzFuE1wvNuk8Ypk=
X-Google-Smtp-Source: AGHT+IEwzX/C94R+tpuiA5QPQIgnEMaYe68c3Ypq1y25s4VtulhE7MdQoVGr1SbEcqXSAPETm+H2jg==
X-Received: by 2002:aca:1214:0:b0:3bb:68ad:f838 with SMTP id 20-20020aca1214000000b003bb68adf838mr3802758ois.44.1703366576661;
        Sat, 23 Dec 2023 13:22:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x23-20020a056a00189700b006d9a6953f08sm1345643pfh.103.2023.12.23.13.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 13:22:56 -0800 (PST)
Message-ID: <65874fb0.050a0220.12d89.24f2@mx.google.com>
Date: Sat, 23 Dec 2023 13:22:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.6
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.6.7-246-g9ddf911049886
Subject: stable-rc/queue/6.6 baseline: 112 runs,
 1 regressions (v6.6.7-246-g9ddf911049886)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.6 baseline: 112 runs, 1 regressions (v6.6.7-246-g9ddf9110=
49886)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
mt8192-asurada-spherion-r0 | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.6/kern=
el/v6.6.7-246-g9ddf911049886/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.6
  Describe: v6.6.7-246-g9ddf911049886
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      9ddf911049886afac1c06696073380e3233b6233 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
mt8192-asurada-spherion-r0 | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65871dbd4234cfc180e134be

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-246=
-g9ddf911049886/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8192-asurada-spherion-r0.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-246=
-g9ddf911049886/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8192-asurada-spherion-r0.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65871dbd4234cfc180e13=
4bf
        failing since 0 day (last pass: v6.6.7-236-g5f9f9b8ff175a, first fa=
il: v6.6.7-236-g0ddffa163cd8) =

 =20

