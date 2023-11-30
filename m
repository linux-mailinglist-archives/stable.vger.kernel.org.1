Return-Path: <stable+bounces-3588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A717FFFCB
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 00:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A581C20C87
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 23:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3912D5955E;
	Thu, 30 Nov 2023 23:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="vaI1iD6U"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5295B133
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 15:59:43 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfc9c4acb6so14898755ad.0
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 15:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701388782; x=1701993582; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i/l/qJ4G62fZrYGVEQvOmLFq8Nyj4KJ0yeOUWUHi5GM=;
        b=vaI1iD6UGw+7/wQ59g9drcDEqA5hBwp2IWQzHQVJu/Q0mSNsG4iBLy5TUOPC4R+oCo
         cjRmwP8j8eeNRjD2d6msQWIuZ3plGZoTzVB3hvxDo6XpKP6FdeX1K1st9/V6i36Cls6V
         EMlsUHJIidMsPj0pFZMTj9NxNxtiHjofsZZ45u8KwiJhUpbjnczKJrt+nOqQ65QQZL/T
         tItdz+6VaL14ZqyOp0tb+1GxYPkq6SW+B3yEmU8ahkpPNoLLfJ1lS16EMFOcfzTjIt6b
         AQEXqekvQF+xFjLMuYzzuxbzJfTU8CJilnY4Tm2hsYVLOzxzIlzhZIv9UzrTQ6Wq31q4
         EBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701388782; x=1701993582;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/l/qJ4G62fZrYGVEQvOmLFq8Nyj4KJ0yeOUWUHi5GM=;
        b=lAgMiM+xmU8yA7EEtiIaL5WdHKU3Wh74vdUG5EXKttfJPvG5rOfZFHRT8kmIHmSCzK
         wzmQ+rgFXoG3UfXO64fjUyfUVqmMbB4hw0+A9/fu1ojWeVptQ2VvdlSLC6ARuCkMBOVA
         LXxugCDU1CdBUcGopDbCcbkO41YAR0XMf6kG3sWy3cAnXIq4PRzwZSWEyZpE94r8Plm9
         ApigjtJPFuJP5+UxFRALwGj2Trk8Eo1tgw65N/2dtNqAng1lv5aWFLxZJtB4pGU/EtkV
         HBacscfxAdq2/3JyhW7q1K5Ez9j8geFGFXeYjBNgC+jkBYJb+J4d5W8mXPlo38dw61Ei
         52Dw==
X-Gm-Message-State: AOJu0YyaQt/QF5P7nR8Z9jWE6sVvcX0x9+G+Fb3/bL6+FaI5rh842Kky
	x5OFXHld3WfCGsY5EH3RGxEdfWkLM8dU4uFbyvyuaA==
X-Google-Smtp-Source: AGHT+IHYyVIK8RF70DIHyVlwJj1xhY3yVj1ggmiEnUIJaLMWiwGlegXiBK+gGaAyTZK3Eun744esPw==
X-Received: by 2002:a17:902:e5c8:b0:1d0:16b3:dff4 with SMTP id u8-20020a170902e5c800b001d016b3dff4mr8157361plf.51.1701388782279;
        Thu, 30 Nov 2023 15:59:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iy3-20020a170903130300b001ca4c20003dsm2000261plb.69.2023.11.30.15.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:59:41 -0800 (PST)
Message-ID: <656921ed.170a0220.f16b8.6992@mx.google.com>
Date: Thu, 30 Nov 2023 15:59:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.64-83-g49ac60b65ef71
Subject: stable-rc/linux-6.1.y baseline: 149 runs,
 1 regressions (v6.1.64-83-g49ac60b65ef71)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-6.1.y baseline: 149 runs, 1 regressions (v6.1.64-83-g49ac60=
b65ef71)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.64-83-g49ac60b65ef71/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.64-83-g49ac60b65ef71
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      49ac60b65ef717d2d74b3b83ca97b61a011557de =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/6568f2391b76fc2b537e4b6b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.64-=
83-g49ac60b65ef71/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagl=
ebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.64-=
83-g49ac60b65ef71/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beagl=
ebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6568f2391b76fc2b537e4=
b6c
        new failure (last pass: v6.1.64) =

 =20

