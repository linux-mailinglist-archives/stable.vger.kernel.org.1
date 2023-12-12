Return-Path: <stable+bounces-6400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3E780E3F9
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 06:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757481F21EFF
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 05:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F69D156CE;
	Tue, 12 Dec 2023 05:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="p/5c8zoS"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0738ABD
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 21:46:56 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3ba14203a34so931910b6e.1
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 21:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702360015; x=1702964815; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DagVTAcvOoC6oYlkxhMHSNYFyqJgrnX69/SqbEJYjGE=;
        b=p/5c8zoS/GWwlH/cm1O/YqVcwJfVmiLVtFNkFfkWYq9G4afqAF3aAxik4euF4NBfWF
         RDhvLAGECq5aPDearXXVFJzXaPgT+daRpgfeIvGZd4gaC9RC9/of5I8ziwV/tVWKjNzY
         4eF2qIlcG2/9suS2I+kq1l9tiMd2bBtg3KLpW67sRnhPhy671NMgSuQy63WBhBPr7Axl
         muJ4aM6Ggco+ldoDWe41JfHlZ2GDKdYPnBUahZnVUsu+smW0rcrl/Qs7EREtLxe70E+Z
         cbiVxduC8e9J+kZIZY47147rVTv11N6qeuNxa0HO9Xs9UlIbqyvz7Kp9l1/uARRTwYNu
         TULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702360015; x=1702964815;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DagVTAcvOoC6oYlkxhMHSNYFyqJgrnX69/SqbEJYjGE=;
        b=Aa+ULWxEkSpsYt0omepFlcz58imLXEXIeZSpLephbtO1Nvm+KfTW6wde3ajUnooLXY
         3u+965lh5J88+kTLwNgS40tWhiDSj33rlcb8U3Bfsm+bMry4EAk0nkw3SeRS2nebIn8U
         nTDEr1drZ+fNQQHXmKyXSzjj98gysnDhk+SbVtD0uZiPbQ0fYXMpB1yvMVLb7ZSe0uNo
         JQnMcorLJKj5TEv43sQEiXpNAgR2lHYCAR8UagUzhM/WEVgAVvGu3x42zsD+nXKV9FaG
         BEt3fH1qVo9SP6ZABoLNc93mbQagvt215xis0ANibW5S/68nAoKLSzYnkOUiZlj8pZzB
         FWLA==
X-Gm-Message-State: AOJu0YwKfIklrK+b7EHYb0dIzdsJw+08+Azkn5TZEoEo0YBKUTG5gpcx
	dyMh4dA7oFN7GwUoVV6TWpTuy8hNcuyk0uDxg2NPCA==
X-Google-Smtp-Source: AGHT+IFEG/3vSRqv1mdD9HYI2qY+LJtlkcw9cfppMFyPy1fxwoEDvSv18N61eUtZ4OPwGOT2Ca1QPg==
X-Received: by 2002:a05:6808:128e:b0:3b9:dfae:9f87 with SMTP id a14-20020a056808128e00b003b9dfae9f87mr8388294oiw.10.1702360014966;
        Mon, 11 Dec 2023 21:46:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z5-20020aa78885000000b0064fd4a6b306sm7230631pfe.76.2023.12.11.21.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 21:46:54 -0800 (PST)
Message-ID: <6577f3ce.a70a0220.68e46.5a3b@mx.google.com>
Date: Mon, 11 Dec 2023 21:46:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/4.19
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.301-55-g52602571f19c2
Subject: stable-rc/queue/4.19 baseline: 44 runs,
 1 regressions (v4.19.301-55-g52602571f19c2)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/4.19 baseline: 44 runs, 1 regressions (v4.19.301-55-g526025=
71f19c2)

Regressions Summary
-------------------

platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F4.19/ker=
nel/v4.19.301-55-g52602571f19c2/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/4.19
  Describe: v4.19.301-55-g52602571f19c2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      52602571f19c2ec9b86596b784057fbc6dd7b50d =



Test Regressions
---------------- =



platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6577c23a15e173c84ce13480

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.301=
-55-g52602571f19c2/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91s=
am9g20ek.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-4.19/v4.19.301=
-55-g52602571f19c2/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-at91s=
am9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6577c23a15e173c84ce134b5
        failing since 0 day (last pass: v4.19.301-37-g7937796e4223d, first =
fail: v4.19.301-40-g06ec8b55a272a)

    2023-12-12T02:14:42.608597  + set +x
    2023-12-12T02:14:42.609121  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 341875_1.5.2=
.4.1>
    2023-12-12T02:14:42.722234  / # #
    2023-12-12T02:14:42.825271  export SHELL=3D/bin/sh
    2023-12-12T02:14:42.826051  #
    2023-12-12T02:14:42.928056  / # export SHELL=3D/bin/sh. /lava-341875/en=
vironment
    2023-12-12T02:14:42.928837  =

    2023-12-12T02:14:43.030895  / # . /lava-341875/environment/lava-341875/=
bin/lava-test-runner /lava-341875/1
    2023-12-12T02:14:43.032295  =

    2023-12-12T02:14:43.035880  / # /lava-341875/bin/lava-test-runner /lava=
-341875/1 =

    ... (12 line(s) more)  =

 =20

