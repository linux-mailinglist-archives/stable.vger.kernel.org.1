Return-Path: <stable+bounces-5056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8B380ACA1
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 20:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5281C20A04
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 19:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7068C481A0;
	Fri,  8 Dec 2023 19:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="v80DkEHm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791CB84
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 11:07:07 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d076ebf79cso18766775ad.1
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 11:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702062426; x=1702667226; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mVbkmuO5Z+fNvL9e2BgfAX3Q87e4Uhtihro+6T/7P0g=;
        b=v80DkEHmyJfZaXWzV2THzETs+Ae/RPEosrIaStmkWrVS8h0pf/zagqrYSnqtobfwfW
         6wdbPqAHE6RAC9FDKjcmI9wB89hWnlX21CZC5FZoQrc7ILlETYsPMANLFBbfCwLf+uDq
         jRsmzOA+XIBsWUdPmgLVnU3ZHrWk00DcKVEarjDVDiuXyMSBj3US91ZLsvI0lEAOefZH
         If28HzXIxJ+U1vLiRv/LCI6hElC6nhUM2g84vTGC7+TYf4u2v0K7IGQ0uc9BhvUyK4u2
         PG2azwqgDHhuimTgTpGFKPyG4VYuo02WnOpUS+TNY4cqaQJP13jjM1cbVVyFoMYz3wVM
         hkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702062426; x=1702667226;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mVbkmuO5Z+fNvL9e2BgfAX3Q87e4Uhtihro+6T/7P0g=;
        b=myLw/7xmBLD2wJa4Hz185QpQqj4zJ7Y7odq2Vme9ImHhybFLaVUy553+PxysFfC0aD
         2MHIItb0XC5Rg9m259QZOM2l5XPiWZ7zX+3eYu4UebxP9bWatP6MYxldWlpLSy2H6kAC
         lW8pK+keYZOJOYyxyz7aHwtQRs+VS94UrpSUm9zWR24IL8JE6Ekmc+QwyoWvtps7P5t7
         xw6gw8LzTLd+qcvS2EMldTdmqmpl2CbJvaHfjOPo/6xc7asz6uH5LGofAlGZpGFMkCn0
         Q5hxPWYWe6wGoc9KUqp4yP9odDJXxhI1iWYNQH0W58fe4uwjzdfpb1GDE1a/G4pxUWAU
         BWkg==
X-Gm-Message-State: AOJu0YyxGaxx5gwfLI+CKdLc86zdJ9zdAM6HY8QI+Zep/Oa5q+acJXqI
	6XUi+Wl4dufu2I1JQ2/+3YQplVGPKlk4KfHpBxkAng==
X-Google-Smtp-Source: AGHT+IFYIJkxhjhkymfVaU4n61zeNPHoc5tRHEg7tpQgq10NY69s7Bq2tpHz2ff3QVzMsH2gLRmJTQ==
X-Received: by 2002:a17:902:900b:b0:1d0:6ffd:cecf with SMTP id a11-20020a170902900b00b001d06ffdcecfmr459478plp.136.1702062426442;
        Fri, 08 Dec 2023 11:07:06 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902d38d00b001b7cbc5871csm2054339pld.53.2023.12.08.11.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 11:07:05 -0800 (PST)
Message-ID: <65736959.170a0220.ccfb3.767c@mx.google.com>
Date: Fri, 08 Dec 2023 11:07:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.66
Subject: stable-rc/linux-6.1.y baseline: 118 runs, 1 regressions (v6.1.66)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-6.1.y baseline: 118 runs, 1 regressions (v6.1.66)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
meson-gxbb-p200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.66/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.66
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6c6a6c7e211cc02943dcb8c073919d2105054886 =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
meson-gxbb-p200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6573354dfd72308bade134d7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.66/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.66/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6573354dfd72308bade13=
4d8
        new failure (last pass: v6.1.60) =

 =20

