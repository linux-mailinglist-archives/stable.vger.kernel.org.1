Return-Path: <stable+bounces-5023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3E180A4E8
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 14:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16ACE2817AD
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 13:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEF51DA4E;
	Fri,  8 Dec 2023 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="24zR5yC2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA631706
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 05:58:29 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ceb93fb381so1227477b3a.0
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 05:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702043909; x=1702648709; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gCjeHbBa3c9rkFw7BA90YhuuokD5ZoloJ9w6pQ1XlE8=;
        b=24zR5yC2kpMCdvmMAxo8msJq3r8d+77sFga2abh+LSAjP+ca4aS29mka7UknjZYJV4
         Rn7jYJh6XQ0zSGOjTqgCSPcJQ6UEBDwdCFKl2lC4z2nAiFAQRA+iuGagV2eW69dE4cvx
         VDzz2/4mB8S5LjLVPszIaV++pgmAxzzj742rqWVuHKroFlWDPxAItMW1uFFeM8l7Wi+h
         eBkCb5cAE+qE3YxYTQv8662LO+750NLwxt5TqNZP2zTmQHRc57aaBBCXdAmkTcCyLcqy
         9NaDHwpHrYVX5jd+deBV6TOKLOUd8a1/OoCIEpTcp4RTRFuymhVIcGT5dYJkOny91yC+
         qvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702043909; x=1702648709;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCjeHbBa3c9rkFw7BA90YhuuokD5ZoloJ9w6pQ1XlE8=;
        b=DJ1pGgAwVE/uXCKV1L8XzllitacrktLXeXp2wtxcjyT3b8pkxn/L06/BJqI9tNG8u3
         RipJWJn0aaltqSgEP1iwPaA2/JHqW3y22xHh9a3gd/83Q0i8RKY4fi4I650Waj6cnBFM
         9cgSHvWJkZBzWdz2rsm3owT6yC0TJMuRdzcGhrLu4oUvuBDD/u/h0vokkqzc+26VxE07
         5nAzPIUnDbUtpICrNqso2yokuFRHiuH8EuW6FVfLbP0V0P4RdhMZK2vl87PW10gwx8we
         evJg+IH7yAZZvpsI+OCi5kuv7oc42VoRCFLqC3Bp4OxMdmT4pLT2K1+CshBs25lHDk3L
         Wdmw==
X-Gm-Message-State: AOJu0YxM8mfFdnITW2QItPgBR+TdJRREgg78mdKu7NDEFsG0UuWw5oi4
	sIcuThVnmbKYSGERQAnG22QacZP3m+cOLsbiw3Xxow==
X-Google-Smtp-Source: AGHT+IGSNmLy1qnSA1PHG0b5tAvZxftctfHPzhgafC//v6JqW/FY8DjPDJ0pedKi+lN3LNbLYVC5tg==
X-Received: by 2002:a05:6a20:1609:b0:187:bb9c:569 with SMTP id l9-20020a056a20160900b00187bb9c0569mr236634pzj.5.1702043908920;
        Fri, 08 Dec 2023 05:58:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z1-20020aa79901000000b006ce41b15613sm1580311pff.112.2023.12.08.05.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:58:28 -0800 (PST)
Message-ID: <65732104.a70a0220.6136.4ae3@mx.google.com>
Date: Fri, 08 Dec 2023 05:58:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.203
Subject: stable/linux-5.10.y baseline: 155 runs, 1 regressions (v5.10.203)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-5.10.y baseline: 155 runs, 1 regressions (v5.10.203)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
meson-gxbb-p200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.203/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.203
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      d330ef1d295df26d38e7c6d8e74462ab8a396527 =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
meson-gxbb-p200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6572f0dcaa8e5e809de134af

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.203/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.203/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6572f0dcaa8e5e809de13=
4b0
        new failure (last pass: v5.10.199) =

 =20

