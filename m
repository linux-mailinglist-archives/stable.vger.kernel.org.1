Return-Path: <stable+bounces-2717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128887F9598
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 22:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C096F280D5C
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 21:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B53C13ACE;
	Sun, 26 Nov 2023 21:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="no3lTZQB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364FDF0
	for <stable@vger.kernel.org>; Sun, 26 Nov 2023 13:50:03 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfaaa79766so15846225ad.3
        for <stable@vger.kernel.org>; Sun, 26 Nov 2023 13:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701035402; x=1701640202; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7R0wJ5on6ffWMXAfu4RWTYFCLBhfVOuok3NAYnLz7p0=;
        b=no3lTZQBvT/YoZyIKlxHdXe9Bclywf0JMTEdUBGbARHoeyhLIvq/lNpVGhhPM6cRpc
         CnDCN0bh4OO6XF4LzdbXyJ0//ZPb2St/OpRtyObPkkpoMoDryusQlUxjHWgrZqKbVi5z
         ml43UFKWvxR60CtKXPgysKACnPc64CK5Mhf3XORnDSmE6p0HJEi5ka7KptafSiWtT7EA
         xfJUxhSYBEWy/Mg+B1+2trb9/3SbeTzlKIIpk3BnAA88PUt0Mqp5+HQdObNCBtsBaWru
         ZXYQZnAquLNsQvz6Orq1qE+INciBzJs6MLL8lyQiYbPmLPyFnB0d/ZI4Z0qLowylxHLg
         QF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701035402; x=1701640202;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7R0wJ5on6ffWMXAfu4RWTYFCLBhfVOuok3NAYnLz7p0=;
        b=GmuJI82gSideqZJw4g2/z6ANM6w7AC6uwFQn17IGhr8CvJQWhDXzDizfZO4NRpSdcE
         vIQ2kA3UTTYP0KTSoQKvv062cGicFI7S2rNHUKmlSXazfgKBLr0ZghaWGf3UFOW7rtgI
         0VlJc3m3p33OcGVs71iThCe6eNr76XtiCdwICNVH0wu9veYrppHauvzssIqrBuHHnsPW
         ABizsAZ3RRG4Nok+0Nnkdys29Sj3dnG18tn865jklLoQBhwPa4bobakoNC2DOnIZo7r/
         DbiyRYQbghWGE4/UkN7cKwcSYzNdL36EmKQz0Adp47rFyeM8NsAU7/NW/Rs5ss65o5I1
         F7jA==
X-Gm-Message-State: AOJu0YyFRwXRwOOJQJob9NkOfAN7rcRytx6YtjI/uz+X5WO6RYCpSzfa
	XMTWVx0TZR443bB/pavrtajPsHPRiOgBhN9HlBM=
X-Google-Smtp-Source: AGHT+IGj+ZvAab66aywZGWCuBAKxSIGqwQrEM7MQpU2Y3J1FidlUlxQtZ7mRiqc2Q+Aith10iRrSPg==
X-Received: by 2002:a17:902:c1d5:b0:1cc:4eb0:64cf with SMTP id c21-20020a170902c1d500b001cc4eb064cfmr10485094plc.52.1701035402233;
        Sun, 26 Nov 2023 13:50:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902daca00b001cfc46baa40sm1463087plx.158.2023.11.26.13.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 13:50:01 -0800 (PST)
Message-ID: <6563bd89.170a0220.39296.2acf@mx.google.com>
Date: Sun, 26 Nov 2023 13:50:01 -0800 (PST)
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
X-Kernelci-Kernel: v5.15.139-293-g0dd3c4f0979f2
Subject: stable-rc/linux-5.15.y baseline: 142 runs,
 1 regressions (v5.15.139-293-g0dd3c4f0979f2)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.15.y baseline: 142 runs, 1 regressions (v5.15.139-293-g0d=
d3c4f0979f2)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.139-293-g0dd3c4f0979f2/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.139-293-g0dd3c4f0979f2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      0dd3c4f0979f20e43760c2033c2fa1b1d3b89ecc =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/656389f82eed57200c7e4a79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
39-293-g0dd3c4f0979f2/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5=
-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
39-293-g0dd3c4f0979f2/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5=
-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/656389f82eed57200c7e4=
a7a
        new failure (last pass: v5.15.139-294-g938465379468a) =

 =20

