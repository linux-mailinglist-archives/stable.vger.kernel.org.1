Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862E77DD80C
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 23:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjJaWIR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 18:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjJaWIQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 18:08:16 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D036BF1
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 15:08:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso201580b3a.1
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 15:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698790092; x=1699394892; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ibn8mYQY/BatUxYIQc4XctPS5Q9LH3GJGURuAaJixn8=;
        b=Zfk47jwCsVybpenmUKoJSvcGFbtZQquZuh5rwnRR+zTnrpgvrgfO0ESdeG9B6logNj
         O9iIx6lXDUHADh2LVzfsR/EnGi5rJYc20O9xYG8+CcIOvF/mkqhRTlF28C8onftkGnVs
         e2BwW2Y/148hxhG/aNG82Df5ZXwgCbcOgLiIWG4drpr8rL7zLE0/oyoc0x/QOcbG0lru
         aVbAZDKfoHe96UMyfuu3a8q1jD02WVviq/wUuDG9mnvhDowLtdzX5NPFdPm3D8AE+zud
         rxJVQkDauXGh45v3lZn31oguIziAKc4/N9qSMeUfjf/ElUQiXW+YYX5tcFJSgyuPcHBQ
         mBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698790092; x=1699394892;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ibn8mYQY/BatUxYIQc4XctPS5Q9LH3GJGURuAaJixn8=;
        b=NRTYXs7AP/VcCDKifVU3PL+EE8li4iF+ey2q5YXybQGgEYO6zXVw+M/W0OIdrs6nLH
         Iw44DadVe20tJ0y6VqxpCbMl+4P/eDMT8b8n0HC6iFiRGJfESA7lctZHbLgu18JYqw17
         GVx55yPV7pIz6SZNbXQbOXhUDvJHp6tGuJIvlYLVWXFPionVx9ZEQ/DNqOBZCurjQsE8
         QgvCm+p6AsrWwJKCJJIkcOIvlN1v09XWj0FcaAAvOELmJ3icQrWoW4L14W9G+lF2SV3d
         shDPrMVCLVe/OZrqqZ8meJ90jgSFuCoAqEOkOAbm4RpYiPEY6dU8SS2Qwc3nMHy8i0dx
         YQKQ==
X-Gm-Message-State: AOJu0YwfK22ucT+Vjxht7AqhCce3a24zDfc/ICYnN7zgxPsbWNZ0ROrc
        kUwGxC5/7R8xbbKrUV7MyxBh6Y6Mdpv9iDLzruZwFQ==
X-Google-Smtp-Source: AGHT+IHEvi/0YKAITH67rHEp/sEzaRnQhQpUq6N4SWuKkZW6iE5tbijjp/Di6EEfI4LARFY3LHEPKg==
X-Received: by 2002:a05:6a20:1443:b0:17e:aa00:ca62 with SMTP id a3-20020a056a20144300b0017eaa00ca62mr5382940pzi.17.1698790091897;
        Tue, 31 Oct 2023 15:08:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fa13-20020a056a002d0d00b0069353ac3d38sm100727pfb.69.2023.10.31.15.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 15:08:11 -0700 (PDT)
Message-ID: <65417acb.050a0220.5f153.078f@mx.google.com>
Date:   Tue, 31 Oct 2023 15:08:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.60-87-gd87fdfa71a8c
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-6.1.y baseline: 167 runs,
 1 regressions (v6.1.60-87-gd87fdfa71a8c)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y baseline: 167 runs, 1 regressions (v6.1.60-87-gd87fdf=
a71a8c)

Regressions Summary
-------------------

platform         | arch | lab             | compiler | defconfig          |=
 regressions
-----------------+------+-----------------+----------+--------------------+=
------------
imx6dl-riotboard | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.60-87-gd87fdfa71a8c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.60-87-gd87fdfa71a8c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d87fdfa71a8c82a481a41421b387544c7012b21e =



Test Regressions
---------------- =



platform         | arch | lab             | compiler | defconfig          |=
 regressions
-----------------+------+-----------------+----------+--------------------+=
------------
imx6dl-riotboard | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/654149c8d8952e0dcbefcf32

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.60-=
87-gd87fdfa71a8c/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx=
6dl-riotboard.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.60-=
87-gd87fdfa71a8c/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx=
6dl-riotboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/654149c8d8952e0dcbefcf3b
        new failure (last pass: v6.1.60)

    2023-10-31T18:38:48.032926  + set[   14.963769] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1006109_1.5.2.3.1>
    2023-10-31T18:38:48.033123   +x
    2023-10-31T18:38:48.139348  / # #
    2023-10-31T18:38:48.240937  export SHELL=3D/bin/sh
    2023-10-31T18:38:48.241402  #
    2023-10-31T18:38:48.342639  / # export SHELL=3D/bin/sh. /lava-1006109/e=
nvironment
    2023-10-31T18:38:48.343114  =

    2023-10-31T18:38:48.444331  / # . /lava-1006109/environment/lava-100610=
9/bin/lava-test-runner /lava-1006109/1
    2023-10-31T18:38:48.444948  =

    2023-10-31T18:38:48.448063  / # /lava-1006109/bin/lava-test-runner /lav=
a-1006109/1 =

    ... (12 line(s) more)  =

 =20
