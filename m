Return-Path: <stable+bounces-8441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534BB81DE97
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 07:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765111C20B42
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 06:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4D6110E;
	Mon, 25 Dec 2023 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="0yBP9eh4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C35110B
	for <stable@vger.kernel.org>; Mon, 25 Dec 2023 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3ef33e68dso23609775ad.1
        for <stable@vger.kernel.org>; Sun, 24 Dec 2023 22:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703485267; x=1704090067; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+75qrJeQctZWMh3Vk2eVlJbgFRZnrsFopEPZCFL3Mjc=;
        b=0yBP9eh4AjGDgK7wbDg8j5BSQrld1sogYzWfpXo7pLGRSvtbg3km2RNIw4RqVRqovJ
         F66dJUKxBbd97xCSlGNBTLHWeML0fBDS4U6nWsNgCu75YhBv7T2EZ1tZcOJcqM2iDZFd
         Lgf9hdOe/HaKZnwRQxaYq46o5fh+tCHSuT3JgEWkNUftKJD8t7zuEPga7OQ9IduDA2En
         3fpA+ppUOBdD0ir/zGushBhB959j7te2Q2xu9rkHWR5gAC84I/eDd9Lq3T1H06vfzbvw
         QFMptERcf9T0ramkfclhlD084RA7Ex4MFH3AWaN1TroUwndeATzxFAa/zDx69jAIB9sI
         s/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703485267; x=1704090067;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+75qrJeQctZWMh3Vk2eVlJbgFRZnrsFopEPZCFL3Mjc=;
        b=jJg0ugyv23/QlG9/2ypvVaVrHs6+HA5t8q2O2nfr5Z6IXVYfiL9kdkbloI5geSfhYA
         1r56TIMmBldy8m2JGmvYupJN2ldCCY1Yz/Bdl79LcAuwdkLTsxN7DD9O82TMNVdyfdth
         VRd47basTz3Jsd5+R2Rxdm47z0QU+mQXF/WCJTOo9zIJpEMl2aSGXcRwSdB25nSLErAd
         URqVG/fnYnheqiV2TZHeUzZgmXpZtm78D+tUO53TsFQNhLwzynNECQTCDbe46LRrLr/p
         5HkO0xbmhgvoA63OQ567fYeMvZLD9UQSoqRa+9hkHXK7xB/SmGV4xNirCpUz4J4MPXNh
         cITg==
X-Gm-Message-State: AOJu0Ywhecmaa9+vfBypTECcJ0JC7ftUJNcgxI1EsYLxlnO2mvnUJ1KB
	qmiqsjsymSKn7XysAFq82Mu+uzr6P1EJ7Mx6jUwVHXTtna0=
X-Google-Smtp-Source: AGHT+IHrCwqq0CLSzDerXsnmrZmPgXZ+RR5m/EnHXMHBnA+BXwbRd39GfqNDr5BYGAwgHYXlx4nqqA==
X-Received: by 2002:a17:902:c244:b0:1d3:d1ee:9bea with SMTP id 4-20020a170902c24400b001d3d1ee9beamr5586652plg.53.1703485267063;
        Sun, 24 Dec 2023 22:21:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902e85200b001d3be09f374sm7380144plg.275.2023.12.24.22.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 22:21:06 -0800 (PST)
Message-ID: <65891f52.170a0220.69206.3640@mx.google.com>
Date: Sun, 24 Dec 2023 22:21:06 -0800 (PST)
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
X-Kernelci-Kernel: v6.6.7-255-ga21961156b26a
Subject: stable-rc/queue/6.6 baseline: 111 runs,
 1 regressions (v6.6.7-255-ga21961156b26a)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.6 baseline: 111 runs, 1 regressions (v6.6.7-255-ga2196115=
6b26a)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.6/kern=
el/v6.6.7-255-ga21961156b26a/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.6
  Describe: v6.6.7-255-ga21961156b26a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a21961156b26a29f2e7852b29512c23c8c14cc17 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6588eeb4724887c840e13482

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-255=
-ga21961156b26a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-255=
-ga21961156b26a/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6588eeb4724887c840e13=
483
        new failure (last pass: v6.6.7-247-ga9715522c0820) =

 =20

