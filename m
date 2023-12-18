Return-Path: <stable+bounces-7070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E6B816F8A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C18B288ECF
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE073A1D9;
	Mon, 18 Dec 2023 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Ffg3IuL9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0059A3D54A
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d2f1cecf89so8775575ad.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 04:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702904098; x=1703508898; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5/oRON01degT1xtw4mq7cMKp9d/1a/LEviSfIe/Mnok=;
        b=Ffg3IuL97Q231Tsm30YTsk2UkKJHUp2VwZQwVXqwLQm2kB2d8VCcxfNwi9Itos/P9t
         0oVW3dnw9lBDHoqIh+d+4VkFnqUFqS9xJ7gHT78hFJ1W6XpfQ2VMlhEYC/oF7TmTrrTM
         7CIMr5MRcqHf8wZ8U47YGK18xl6AcsirfWZikhRRIVi08omJQX+ySvJ+x0tsWHLWZ79Y
         29KPTGgdBiPOZC1EX2sSeMBWKXw14Dvel1Nm4o8MYKirDmvKoN/mvJwoX2EC884A8F6U
         mtsssCnPS3W63q2gGxMUK4n+lq33UmLPZe3KVtp626NPr9nqVisfyTB+5Vev4rmnw0OU
         8Ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702904098; x=1703508898;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/oRON01degT1xtw4mq7cMKp9d/1a/LEviSfIe/Mnok=;
        b=RHM8IdOOYpC8VUi6hlOBgvnfRF/zEnyDhJ+lWJKz5MUysVlk92pB6dwzzUEgayVX4k
         Bxb0OKWpozkbn0gSfMyPVJDqGlX7KDXTOAcetvezjks8A2/c+WTZ6usgkDAQg4sY3973
         npbg1VuzmkssYJnBOp6OoDKTyqPUcMV2BchvhDhOjTvpodiphP6AmfwW5RaHfwBDtjvG
         CO0LH9Fk6I/IWsKkhMYuukk9uDt5AzQlIM/1eagxRuQxOKySvU9Npi2o7hfWtfJA9uos
         3qrSheo6bb0BGbNhT8I6yrH4l3sfSVRdjShcnaJnIhO0AfDvR1OWyvEwDQfgGElyt3Mc
         T+aw==
X-Gm-Message-State: AOJu0YyiVq8sg3Sb6nQEGiQoLJfohJbtWAgeV/jk9Jh1jVn6UTVXjOaE
	Px5SAZTnPVzvpUKjio4ciQYJzj0ui5hpllf7Bk4=
X-Google-Smtp-Source: AGHT+IFNVuqYCXXZcynH3wKXEJTnF2Pl2vmn6ttgHVOazcA2kioQklPHquumVrAYCnTEwDP4oN7EOg==
X-Received: by 2002:a17:902:820b:b0:1d0:437a:35ac with SMTP id x11-20020a170902820b00b001d0437a35acmr6401597pln.37.1702904098499;
        Mon, 18 Dec 2023 04:54:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001d0cd9e4248sm18953923plk.196.2023.12.18.04.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 04:54:57 -0800 (PST)
Message-ID: <65804121.170a0220.9659e.9042@mx.google.com>
Date: Mon, 18 Dec 2023 04:54:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.204-66-g147920d742a6c
Subject: stable-rc/queue/5.10 baseline: 46 runs,
 1 regressions (v5.10.204-66-g147920d742a6c)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.10 baseline: 46 runs, 1 regressions (v5.10.204-66-g147920=
d742a6c)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.204-66-g147920d742a6c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.204-66-g147920d742a6c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      147920d742a6ce19f0764993a21f5bfa60c080eb =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/65800f45404101e44be134e4

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-66-g147920d742a6c/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.204=
-66-g147920d742a6c/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65800f45404101e44be13518
        failing since 307 days (last pass: v5.10.167-127-g921934d621e4, fir=
st fail: v5.10.167-139-gf9519a5a1701)

    2023-12-18T09:21:56.584599  <8>[   21.008135] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 367159_1.5.2.4.1>
    2023-12-18T09:21:56.692071  / # #
    2023-12-18T09:21:56.794300  export SHELL=3D/bin/sh
    2023-12-18T09:21:56.794799  #
    2023-12-18T09:21:56.896360  / # export SHELL=3D/bin/sh. /lava-367159/en=
vironment
    2023-12-18T09:21:56.896853  =

    2023-12-18T09:21:56.998524  / # . /lava-367159/environment/lava-367159/=
bin/lava-test-runner /lava-367159/1
    2023-12-18T09:21:56.999422  =

    2023-12-18T09:21:57.003587  / # /lava-367159/bin/lava-test-runner /lava=
-367159/1
    2023-12-18T09:21:57.111761  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20

