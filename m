Return-Path: <stable+bounces-3587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2F77FFF35
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 00:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8021C20CD6
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 23:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AA861FA8;
	Thu, 30 Nov 2023 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Z11MJFQb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82F0D5C
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 15:10:49 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cb55001124so2079905b3a.0
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 15:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701385849; x=1701990649; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=le83jAtfQz28YY2KQZBSdsjlDJZHuK4uPYM6MkTSf74=;
        b=Z11MJFQbUs2mDQi+gkpduLEGPt/jfCir5ZQOCQuuYMgWLqG2DtGKeYNjzosJHZ4KZe
         iz2OqsQFQnZmsGAIQ/8Y9ibKkPH0abUiMkk9lMxAagLgzYcZ4sMVaZOWkbOudjn0nxov
         gOjQu0XeSi68SLJb6oxFnQubvgpZDpZOjV4DEAt+NBv0rDsS43v7X3W5LNPwrCdWIBpo
         k9wzzpEK66EPo+HxAhmyM/k1LKq+nyg6ZpfRjwWz+NYSMXUicQgQkS5hgEbSx1J0RENy
         5q7EC0TcMm3LvXXZ9QhSMJx38MDelDmxFqzBgqORsNyBceEf2035QUSicyvVOwKfnoCe
         Lf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701385849; x=1701990649;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=le83jAtfQz28YY2KQZBSdsjlDJZHuK4uPYM6MkTSf74=;
        b=pJXoW11x1enXJur61sd8kkm5vFtugibywxYBTTD9gvsZWV+0+WQZP8jbOpY99K05Bl
         qkvksGeNt/ppk3vDSFzavOTfeizxe1UG2Fd8SIu/JpfRKLOCDpwKUwfEVRCNkUl0EbEE
         DZdsK5/AaS86c3l1fPclnaqWbWVxDEd33CjUf1ZhgNSZQVzcZ/ke5byKS49qE8j3s3Ov
         Dgv/cj0iaYu2VnIoGkaLEoBRxCElsSXtGZqjDNMG7aKE4mPAEM3q59kyiYchvqA7dOMY
         8vLIicKNnjUtCPGPlRqjB5KYteqX6jR4y0gexixk7qNzSStqRomIJfdm3PH6CQhRRY7D
         3/nw==
X-Gm-Message-State: AOJu0Yx9IyRQMoj8nY7oJFzmJVUMhTSzJsLNzf3uhbr8NyfMHdVJclNn
	uQ4ZzzCX5eIEj45xiBSe86clTPElA/8KVMmg7nxITA==
X-Google-Smtp-Source: AGHT+IE2GAPK0bQ0K0jcm1gee4KfIk6CWG30Cpavrrd8+eFHvmDYwi4AdKsM6XtT12PycGc5ohvYsA==
X-Received: by 2002:a05:6a20:bb08:b0:18b:ca68:4e9a with SMTP id fc8-20020a056a20bb0800b0018bca684e9amr26238977pzb.28.1701385848716;
        Thu, 30 Nov 2023 15:10:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t10-20020a65608a000000b005acd5d7e11bsm1582307pgu.35.2023.11.30.15.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:10:48 -0800 (PST)
Message-ID: <65691678.650a0220.7e954.4dce@mx.google.com>
Date: Thu, 30 Nov 2023 15:10:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.140-70-g66b7d5ed6e672
Subject: stable-rc/linux-5.15.y baseline: 100 runs,
 1 regressions (v5.15.140-70-g66b7d5ed6e672)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.15.y baseline: 100 runs, 1 regressions (v5.15.140-70-g66b=
7d5ed6e672)

Regressions Summary
-------------------

platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.140-70-g66b7d5ed6e672/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.140-70-g66b7d5ed6e672
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      66b7d5ed6e672f126e1cfd6c53868c6610ca5686 =



Test Regressions
---------------- =



platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/6568e640d39eefe1757e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
40-70-g66b7d5ed6e672/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pi=
tx-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
40-70-g66b7d5ed6e672/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pi=
tx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6568e640d39eefe1757e4=
a6e
        new failure (last pass: v5.15.140) =

 =20

