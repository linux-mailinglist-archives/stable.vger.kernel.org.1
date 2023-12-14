Return-Path: <stable+bounces-6690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 298F5812409
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 01:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0781F21918
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 00:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713EE634;
	Thu, 14 Dec 2023 00:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="PSR+C5xs"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6296F5
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 16:44:36 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b9efed2e6fso4570446b6e.0
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 16:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702514676; x=1703119476; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c6Fxnu4z9F/JsMpwk+cogEH+YEwfxIsAJE+5VcbYKMA=;
        b=PSR+C5xsu6EXB0u8FzbrqjKL+6B1PEj3oHV+fAL60PrQoWVD0ufbfwaOyi15kg+OQa
         Flz+XHLtZ8/x2cS7wFHYOTy9jfDGj+SNwXB67rh0T5hO5zwUSUhFuAUUF7XVgynGcaht
         F8zS9jg3oiR9UQrzJXcoTUm7Zbqaolz02T5T3hhPH9YmUFzdhEQ+C+fCUdAy1OmPLRvs
         Irkj3h/2dutTXkW5u874nNbRhQQs0iJfaNOPcXz2HI/J+pxjBD14hXIVcq2wiuMph6iK
         1WswKYRyfvrLXHYAht4eV4Cse1zCGr99SvVqKvI3EdMOfgXiqQQZuEn5+9e5gyWTXDt4
         7zXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702514676; x=1703119476;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6Fxnu4z9F/JsMpwk+cogEH+YEwfxIsAJE+5VcbYKMA=;
        b=mwNfTQPWSZuoi43UkQ+QmMLiI1SqUSU5pBgLULIC4c+KM7l/mLhQ7PFebi1qJKI/PV
         VEuwY4pz+RvELHFvM+8kTDUNoGdwgAm4xSskB0tdktXlOdjObeVbjQoC9m3D8J8bh+o/
         wKsjHNsydDYE19QF0m4Wgj1dHTtekumSU401944N5OdhbiRYiawv/i295jmX6aDCi7aW
         k2FGPhFCgABYEH18Rxz3wZx9MaERk6pW0iFVU3Bv8iPwNNcv7iFs3Gvlph5VoUveFSe3
         8wn4xpv5FjmeOlxdQ5UD6MFn55sXa2loI+H4zjoEhe1Y4uvH3sCnAo7ksShCT3L5iiZy
         m2Uw==
X-Gm-Message-State: AOJu0YwK1Ui+p1XFKMrozhYmrb00jKT1MKuteGw8a8subWNns1INaMjX
	WO3bVlh3dmlkGM+PeuG7wFI0tyB6s3GO+72OLCzDvw==
X-Google-Smtp-Source: AGHT+IFSjYTOD/2OsQvH7+DJL55lu6YCq6r/5afROtrcM6yvlyUE8E+1jdzWFxBAElyH99Qvciid2A==
X-Received: by 2002:a05:6808:2020:b0:3b8:b063:824a with SMTP id q32-20020a056808202000b003b8b063824amr11050884oiw.76.1702514675803;
        Wed, 13 Dec 2023 16:44:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f7-20020aa79d87000000b006ce5b4ade28sm10789227pfq.174.2023.12.13.16.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 16:44:35 -0800 (PST)
Message-ID: <657a4ff3.a70a0220.57712.2e60@mx.google.com>
Date: Wed, 13 Dec 2023 16:44:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.4.264
Subject: stable/linux-5.4.y baseline: 146 runs, 1 regressions (v5.4.264)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-5.4.y baseline: 146 runs, 1 regressions (v5.4.264)

Regressions Summary
-------------------

platform  | arch | lab          | compiler | defconfig          | regressio=
ns
----------+------+--------------+----------+--------------------+----------=
--
beagle-xm | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.4.y/kernel/=
v5.4.264/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.4.y
  Describe: v5.4.264
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      16e6e107a688046df37976fb6d7310e886c8115d =



Test Regressions
---------------- =



platform  | arch | lab          | compiler | defconfig          | regressio=
ns
----------+------+--------------+----------+--------------------+----------=
--
beagle-xm | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/657a1a6bb9f2d11895e1347a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.264/ar=
m/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.264/ar=
m/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657a1a6bb9f2d11895e13=
47b
        new failure (last pass: v5.4.263) =

 =20

