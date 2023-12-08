Return-Path: <stable+bounces-5014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAB880A3CE
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 13:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE52E28189E
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 12:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C341947B;
	Fri,  8 Dec 2023 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="SDdQgy6c"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459E510D8
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 04:48:17 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d05212a7c5so14998985ad.0
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 04:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702039696; x=1702644496; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MrOl8XAWxE9LN2P2VbUngAvEwc000iu6177KAzwca6E=;
        b=SDdQgy6cNHiigq61jdZdGxpGmvNPYA4crsXyh+YcXhLdPfDhzRsTprmZQCF5EIDQTL
         etNVbOxy0Rdg8rUOLiC2CuC4bapC8QuE0CwOxrgdRNidVqEHIpzpedKXRUc5G6tNdGTx
         MBW3mcYnlmxfhiR1uin2W8W+AEm4/3sFMN4vFV+y/LJAkMvykLGJvP/YE2tScGR0EVG3
         j3jPa7fix8JzVa+ep9lYJs/mKjFHNstjFPbCaKVfRZBT1a0Zcm3qy/UeebkPgk7flOtB
         86dvhYPoFXH4O4q0u+w58aNU26eVBm9RawK55qA6g1JNybEuJu68X/cGYgz+hMlfmyw9
         DTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702039696; x=1702644496;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrOl8XAWxE9LN2P2VbUngAvEwc000iu6177KAzwca6E=;
        b=tY/kVpe6R9FHoGM3vQKZ1GsFEbRpPfRy9H8XrN0Y2++9ykCjzhl5ZhgmNS+5G9dEHj
         QUmlISzklp2dbb5nrrA5UHTDK3vauybg7mEWrd8Kk4JDnRbSZJXwe2Eo9/Z/vKBjc3Iz
         ojW+X9RpPAiinpK1MrpCLCug5EyheAYwEs/01STb/r09k5lzP5spDQHTMJJGJr1869Z+
         gfbFGOS6B2qElX/ikce82t5blnJ0cPAKX75gA5XOxjbV42JNQlPykYzRYpvHjhEYrhv9
         feGSdrqOsXL5igm7/no/wr+8yj5FDjax8W4qETdUIe/9jNxHAiZ7bz40VA/PFE/qMBRC
         gU3A==
X-Gm-Message-State: AOJu0YwZwj1l6AoGH/BW+AI1g+A1veByWT3PLy5Iy4vLfYtpZq/pffxH
	1ZxWXzjXf/6R6fEtr+mwurfJxuq1CKjTSHyZZZsSpA==
X-Google-Smtp-Source: AGHT+IFfKriWS9Evi/MW4v21vhxN5F5S32Eb7ACEFHU9gVL9nle+mF8Muv9acEO7ROg+fAu7XVz5Rw==
X-Received: by 2002:a17:903:22d2:b0:1d0:6d5d:5e4d with SMTP id y18-20020a17090322d200b001d06d5d5e4dmr3866151plg.59.1702039696226;
        Fri, 08 Dec 2023 04:48:16 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902dacb00b001d053a56fb4sm1611406plx.67.2023.12.08.04.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 04:48:15 -0800 (PST)
Message-ID: <6573108f.170a0220.46e6c.4a51@mx.google.com>
Date: Fri, 08 Dec 2023 04:48:15 -0800 (PST)
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
X-Kernelci-Kernel: v5.4.263
Subject: stable/linux-5.4.y baseline: 143 runs, 1 regressions (v5.4.263)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-5.4.y baseline: 143 runs, 1 regressions (v5.4.263)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
meson-gxbb-p200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.4.y/kernel/=
v5.4.263/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.4.y
  Describe: v5.4.263
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      34244ed6219a9eab1ce2262dc3c2bf39a3789b8a =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
meson-gxbb-p200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6572e05ea8ff42ca4fe13489

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.263/ar=
m64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.263/ar=
m64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6572e05ea8ff42ca4fe13=
48a
        new failure (last pass: v5.4.259) =

 =20

