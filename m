Return-Path: <stable+bounces-6709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB508126C6
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 06:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F221C2143B
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 05:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11265683;
	Thu, 14 Dec 2023 05:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="lThWKAr6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0244AF5
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 21:02:29 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6d9f9fbfd11so4031090a34.2
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 21:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702530148; x=1703134948; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pf5fVOKaCiVqAaR4X1vZuK13Cu4jzvIL21iKZif6KWQ=;
        b=lThWKAr6qcc35LySyhbektvHSIHciJ9fqtwkbP6BtMCWXR+sdPyEJO0mxRQAp9gOs4
         VUGAp+xqucx6jfogmI7nnV4kAj0UdYhoN9s8s8kHnL+tQhIgSfKizSMdNxlMd19GTKth
         BDbYzPS/9TP49CdUiDtNzuIFjnDGMpsArb19nIxvRl1CSspN97dYYXj4MFb5/oKhIA4X
         a6fNwTlC8Z6nuHUBedkcPEyUoZO08posurPtYxZb4NuT0+PNimx6FwcW6P5QDfDjvV2F
         wHBTFThUFKiSN+jFaPZ3O5Lhr8JPGVV2ros6iTpmsjyzlg9QxrbbyjKlr6VyXeJPpyGd
         fbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702530148; x=1703134948;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pf5fVOKaCiVqAaR4X1vZuK13Cu4jzvIL21iKZif6KWQ=;
        b=R1OLiDBj8Y/PqZrhPnkLe+2nWBRExgmKzuZkiklJjxFEB1pWoYkv/rzojBe/Lvwt59
         v+ajgB+J14P/victoHLt4k0QcvCSObjEKkoLMcqOnZ1pC34X79bq65yi0QmFFOmRAypY
         wzf0+goH+PTbs6L0cccJe7APvpUPH4+iUYKA5iJAq3fisfKSxOUjBc+ZD2MqgYJhqBor
         eBcYff/9TvNHPZBLSSUAsWTtJymzXlGH3qMMhrGdnYZv/9gv+KvclepSwGaxw8gBwkTv
         INzLE6Abre7n8OMGpZ4MWr65h42O6ifMzmTc2rkKw3UJ6DiXTc0Jx+5Ir52SIRcn16ir
         c0bA==
X-Gm-Message-State: AOJu0Yy0/kYGT4/NN55OtpOxD6dsh+wVTS4N7VVyQu97LXQSAeyJiszB
	ho/naGoJLJhl/puQMDEwBlHMmfA8GGwTzVnVleI2uw==
X-Google-Smtp-Source: AGHT+IFmDLnQLau2QAY1jaEQq8qGMC5LKylfu8QHFBKueQNMrJBGts9wpuPIoIUaGNZ5eTcA4XkHXg==
X-Received: by 2002:a05:6808:3c99:b0:3b8:4164:5fe0 with SMTP id gs25-20020a0568083c9900b003b841645fe0mr12976029oib.37.1702530147891;
        Wed, 13 Dec 2023 21:02:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c10-20020a62f84a000000b006d0d83a11c9sm1754165pfm.202.2023.12.13.21.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 21:02:27 -0800 (PST)
Message-ID: <657a8c63.620a0220.51819.59b6@mx.google.com>
Date: Wed, 13 Dec 2023 21:02:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.68
Subject: stable/linux-6.1.y baseline: 161 runs, 2 regressions (v6.1.68)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable/linux-6.1.y baseline: 161 runs, 2 regressions (v6.1.68)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-10   | defconfig | 1   =
       =

r8a779m1-ulcb         | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.68/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.68
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      ba6f5fb465114fcd48ddb2c7a7740915b2289d6b =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/657a5816f71ed89ed3e1351e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.68/arm=
64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.68/arm=
64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657a5816f71ed89ed3e13=
51f
        new failure (last pass: v6.1.67) =

 =



platform              | arch  | lab           | compiler | defconfig | regr=
essions
----------------------+-------+---------------+----------+-----------+-----=
-------
r8a779m1-ulcb         | arm64 | lab-collabora | gcc-10   | defconfig | 1   =
       =


  Details:     https://kernelci.org/test/plan/id/657a5762ddef517eaee13483

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.68/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.68/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657a5762ddef517eaee13=
484
        new failure (last pass: v6.1.67) =

 =20

