Return-Path: <stable+bounces-6706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B208125D2
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 04:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0AD7282A88
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 03:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987F41376;
	Thu, 14 Dec 2023 03:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="uk237IHJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C5C10D
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 19:15:36 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7b6fe5d67d4so284815539f.3
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 19:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702523735; x=1703128535; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l+Ew0K7gBHFvhAhjTY4jtqkP/iG3ctKWSQEnTLVMhKY=;
        b=uk237IHJn+rMEpmrygJEITqVcqaKkBNPjC+vAymAID7TXDuNaZRe69lOsoVRSDQ3gq
         2iEiEBEbYgik81G810mP7uF1UNyPhYj9qWhx65D0OZgGzqnSE2TjBG4AqQaBwZWaUj9e
         XO4MCVeKM5TvMfhzc5xcWIlXZUI0J1faxTM3I42wieQ/YRAawndFrEle0n+4M/oYEO5j
         In05DHSbK77WIaJTLafnoXCCeFnt4seuh/YnvajBmFlsJo11EUlL/gnNYzlMKjA/ZCsc
         kVAL6BnaRpklKXQkEMIiS+cmuDwCoJ2/mMp4Zlohp8sD5TnF0uo9ykYxhvQlruPyBWvS
         n3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702523735; x=1703128535;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+Ew0K7gBHFvhAhjTY4jtqkP/iG3ctKWSQEnTLVMhKY=;
        b=W1EENQEzC6N6IqfpYEQ0ZUHOI8DEcm7cqgwi5zfEOi4DAxwmN9LD6C9oHmo/Clx24D
         KIPad3VVmskTwFM6t/itfTt9EwtqNEGhya6aLKtpFG4wVD04OaUElTBss922LRvqrim1
         s8nGjjrbh5pyritgP2JclG7D18MFVV3PDq4pZxb2gRs/17GcNaOoXEYRpv+CJsCMcNuc
         iO55FP2NV2oedldrPVFFjKEG+x9JBJP6ZyCslpNcAmpUIQ0EONi23nv7pq79XTofnkc0
         JwffYMkN5ofUop+CHHCYQs9STi8/aXB0FSF+uy3UY0KO4S4KPe2m8/ZzhsmtrVqIC4G2
         grzQ==
X-Gm-Message-State: AOJu0YzD8NzNUXzR1fkR7PVBfQwrUqpAPdIqCuOzpvhpEzt17gzHmvyI
	Y5Pf4jrdBYJuuXLfcGlSK/KCjfCSzch2PXvyY5VFXw==
X-Google-Smtp-Source: AGHT+IHXyGLzQVy0wvR7qTvfsMDPmNE9HLaSYj5dZwTA2ZahPNhCrE6IabJSq2iBeB0PZ5rgAivvWw==
X-Received: by 2002:a05:6e02:2169:b0:35d:7658:a3e0 with SMTP id s9-20020a056e02216900b0035d7658a3e0mr10107089ilv.26.1702523735252;
        Wed, 13 Dec 2023 19:15:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e5cd00b001d0be32b0basm11219788plf.217.2023.12.13.19.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 19:15:34 -0800 (PST)
Message-ID: <657a7356.170a0220.77f6e.3893@mx.google.com>
Date: Wed, 13 Dec 2023 19:15:34 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.143
Subject: stable/linux-5.15.y baseline: 236 runs, 4 regressions (v5.15.143)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-5.15.y baseline: 236 runs, 4 regressions (v5.15.143)

Regressions Summary
-------------------

platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun7i-a20-cubieboard2       | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =

sun8i-a33-olinuxino         | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =

sun8i-h3-orangepi-pc        | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =

sun8i-r40-bananapi-m2-ultra | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.143/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.143
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      d0fc081c62410e8ec014afea88e4e5e6a3bc14c4 =



Test Regressions
---------------- =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun7i-a20-cubieboard2       | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/657a407db57ae174fee13476

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.143/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun7i-a20-cubie=
board2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.143/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun7i-a20-cubie=
board2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657a407db57ae174fee13=
477
        failing since 34 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun8i-a33-olinuxino         | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/657a407feb5e4c1cf8e1347a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.143/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-a33-olinu=
xino.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.143/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-a33-olinu=
xino.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657a407feb5e4c1cf8e13=
47b
        failing since 34 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun8i-h3-orangepi-pc        | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/657a429a83038e9571e13577

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.143/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-h3-orange=
pi-pc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.143/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-h3-orange=
pi-pc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657a429a83038e9571e13=
578
        failing since 34 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun8i-r40-bananapi-m2-ultra | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/657a42aee3b345435be13476

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.143/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-r40-banan=
api-m2-ultra.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.143/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-r40-banan=
api-m2-ultra.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657a42aee3b345435be13=
477
        failing since 34 days (last pass: v5.15.137, first fail: v5.15.138) =

 =20

