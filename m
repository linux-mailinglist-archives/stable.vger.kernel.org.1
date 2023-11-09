Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6260E7E6D88
	for <lists+stable@lfdr.de>; Thu,  9 Nov 2023 16:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjKIPgo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 9 Nov 2023 10:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjKIPgn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 9 Nov 2023 10:36:43 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DB51BEC
        for <stable@vger.kernel.org>; Thu,  9 Nov 2023 07:36:41 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6c4b06af98bso724843b3a.2
        for <stable@vger.kernel.org>; Thu, 09 Nov 2023 07:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699544200; x=1700149000; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ql0mPfiOiRxAJK8uTl/AYjrpV23/jtSSCejKtyMmiKY=;
        b=V+MLFYBvezjJrCQG9MqO35HpoPjUckoDPfuAR5x3ODVpBVQzp4fs6+ABAo65ynlXPD
         fMi+6gYxWQTKqUJWORaC3opPP+QbmBcUy8JybjOLIHye1f9n8JM/OoY/BD9A2kW8Fgew
         l5cl8HmvdVVto+QZl8VRIreYGxbVMq7KA48pL+qQog4GUtHsjCw6Gw8wAEDPl0b+7OSM
         aWg45Y9bp9FvOnK17uXi8wkI51og5C4ByklbtyJZLPMF9fsHwMXc+1qNBgc/hAT1vqty
         I7YKC11ZAcvef3SA3kWQUbSls4t6QkOScz2cpDfEUUl8NdX+j7Qp4H7R3qGl+cntAkD6
         h/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699544200; x=1700149000;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ql0mPfiOiRxAJK8uTl/AYjrpV23/jtSSCejKtyMmiKY=;
        b=Sp6D3QUSqfL6HKVqmGw3xzf3EWlH3cNyJ2ePVVU+fi8zOR4HnTUHTstxLFh8M1VJiQ
         xf8zUky/dm5px1faM+7DtkzHUoeL/mFC29KXFFRj8Z+UezcZXMHtHIFBpTTO+tkuTcnU
         XRn/dZ4C70ZEmGfzGcywYd4Y+sScW0d1OSJ2HW4ryfaZI1A+Gksy8V8zVXrUcdqYPQH8
         8nRwTmsd83KR3PLyHCmu0NKMlfq02V+UmBNpj7MsIxpFxcPdDQEUhPH4S7JUFU36T1HK
         ouGAZinxq/sE06tSo3FVcpW1e4LZfHf90CutjleRIvSQUVScBmJ/u609N1PLIPBPd7kd
         WaJg==
X-Gm-Message-State: AOJu0YyEatS0m1nd3eI8VEQ5+/CoJbRbG4houPblIS+le7QvvJRWERsf
        2a8pQZfSun7gFI53S2MEoNcbjMFn+mYrTmDYC3USlg==
X-Google-Smtp-Source: AGHT+IHrgKTi0TdNxCtzt/h0H7W4nysv3t2BeugSI6VP1AstoK0r7l/RRzeGvYeIJKzK2OmrxMAnFg==
X-Received: by 2002:a05:6a21:339b:b0:16b:d137:de59 with SMTP id yy27-20020a056a21339b00b0016bd137de59mr6212804pzb.28.1699544200066;
        Thu, 09 Nov 2023 07:36:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b24-20020a630c18000000b005b9288d51f0sm4855281pgl.48.2023.11.09.07.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 07:36:39 -0800 (PST)
Message-ID: <654cfc87.630a0220.1faf7.d9c4@mx.google.com>
Date:   Thu, 09 Nov 2023 07:36:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.62
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y baseline: 118 runs, 2 regressions (v6.1.62)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y baseline: 118 runs, 2 regressions (v6.1.62)

Regressions Summary
-------------------

platform                | arch  | lab          | compiler | defconfig | reg=
ressions
------------------------+-------+--------------+----------+-----------+----=
--------
meson-gxl-s905d-p230    | arm64 | lab-baylibre | gcc-10   | defconfig | 1  =
        =

sun50i-a64-bananapi-m64 | arm64 | lab-clabbe   | gcc-10   | defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.62/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.62
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      fb2635ac69abac0060cc2be2873dc4f524f12e66 =



Test Regressions
---------------- =



platform                | arch  | lab          | compiler | defconfig | reg=
ressions
------------------------+-------+--------------+----------+-----------+----=
--------
meson-gxl-s905d-p230    | arm64 | lab-baylibre | gcc-10   | defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/654ccca260da9b2af0efcef4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.62/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.62/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/654ccca260da9b2af0efc=
ef5
        new failure (last pass: v6.1.61-63-gf2e7db5bff466) =

 =



platform                | arch  | lab          | compiler | defconfig | reg=
ressions
------------------------+-------+--------------+----------+-----------+----=
--------
sun50i-a64-bananapi-m64 | arm64 | lab-clabbe   | gcc-10   | defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/654ccca660da9b2af0efcef9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.62/=
arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-a64-bananapi-m64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.62/=
arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-a64-bananapi-m64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/654ccca660da9b2af0efc=
efa
        new failure (last pass: v6.1.18-146-g7887563347ee) =

 =20
