Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E757DF549
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 15:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjKBOtq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 10:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKBOtq (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 10:49:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0614B7
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 07:49:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-280109daaaaso908549a91.3
        for <stable@vger.kernel.org>; Thu, 02 Nov 2023 07:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698936579; x=1699541379; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wILz5+OS2rT7uUC8K1ys1Dt0BuHucJ/vRSC48Wip5Zs=;
        b=CH08wWxV1vZVF0G/AUDA6+QtznQji6twSXW0Mhgjo/onWH1+Px71tcOrWhGRlF1zVI
         iP1X3ORStNXZ3oQ7GAASnvLeS5thoeTL3iIDfQhe+ldBMsC1itRTGFG1WpUSXxzrfmsB
         XPaG9T/eSifBzGV6hfrPEk/TbSgZg9xbKkJApXCHPD+IQMgNX2UG69IayGGRGAecdlSI
         Xr+a22FR1dp83apjU+bTfLGAdlAm6eRRGx/n0DwSnHW/J5TI9woKQWq2eb1W5q8jw3qq
         mQX/RsCbZZ7pciNfOdv+H8d41TOXeM9bV2StRSRGHW2nHrr+flhGYVpmfRg4mJ1p68+E
         aPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698936579; x=1699541379;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wILz5+OS2rT7uUC8K1ys1Dt0BuHucJ/vRSC48Wip5Zs=;
        b=gPyyCIrW4MYNHcpx2oiTO9jdn1rHc8357zGItgF+c7jn369kheCrxAtou5zkDS/KC9
         iiYbLXsanzYAyWgyKF7zxTCypNy8svOHiFGWvT1iFUOUjml/5lmNtbWRbaUOruf0ivZg
         oxxaUU3+JC74Q+rYbncf+c3yFulyTPApdN+m5Uhx9uBGjdzyHFl2fO/Wy653j5GY/TrI
         AbeIXBPMK+MKhwMG9ZIbaMYviwcHj+Q7C0aJHa9ZQzvx2ng3HRsxvVXuGngA3jp/SFYk
         98tZq0A7YbolrlhsOAsEpGLJ3W8RRav80ZlFNNizh4WWSJh1Zrb8JcSzZmYPSbS6Qqbn
         okJQ==
X-Gm-Message-State: AOJu0YxZDdUS61sdrS3XqQWzZAxw6FuncjsHZYwm21WU+RAeifE1Ic9t
        CcHdfLbiN0VTqfLf9isT5YMLoSlBISUVtH6N5Ak3Jg==
X-Google-Smtp-Source: AGHT+IG+vDkvwmX8CIOMGUPD99v4pWIJg6dBndzlNEW+yVOmPb80xi8Xr5LXqrleVH/aJcNzBLvLwQ==
X-Received: by 2002:a17:90a:fd8e:b0:27f:f61c:327d with SMTP id cx14-20020a17090afd8e00b0027ff61c327dmr15414782pjb.0.1698936579640;
        Thu, 02 Nov 2023 07:49:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 24-20020a17090a035800b0028009de5c65sm2765493pjf.39.2023.11.02.07.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 07:49:39 -0700 (PDT)
Message-ID: <6543b703.170a0220.e3436.7657@mx.google.com>
Date:   Thu, 02 Nov 2023 07:49:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.137
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.15.y baseline: 168 runs, 1 regressions (v5.15.137)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 168 runs, 1 regressions (v5.15.137)

Regressions Summary
-------------------

platform | arch | lab          | compiler | defconfig          | regressions
---------+------+--------------+----------+--------------------+------------
panda    | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.137/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.137
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      12952a23a5da6459aaaaa3ae4bc8ce8fef952ef5 =



Test Regressions
---------------- =



platform | arch | lab          | compiler | defconfig          | regressions
---------+------+--------------+----------+--------------------+------------
panda    | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6539425bc3c04fb105efcf0e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
37/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
37/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6539425bc3c04fb105efcf16
        failing since 0 day (last pass: v5.15.74-2-g741b5047a5f58, first fa=
il: v5.15.135-237-gbc0ffd9b5ee2)

    2023-10-25T16:28:59.288638  + <8>[   11.654632] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 3814138_1.5.2.4.1>
    2023-10-25T16:28:59.288855  set +x
    2023-10-25T16:28:59.393322  / # #
    2023-10-25T16:28:59.494657  export SHELL=3D/bin/sh
    2023-10-25T16:28:59.495157  #
    2023-10-25T16:28:59.595991  / # export SHELL=3D/bin/sh. /lava-3814138/e=
nvironment
    2023-10-25T16:28:59.596491  =

    2023-10-25T16:28:59.697336  / # . /lava-3814138/environment/lava-381413=
8/bin/lava-test-runner /lava-3814138/1
    2023-10-25T16:28:59.698048  =

    2023-10-25T16:28:59.703091  / # /lava-3814138/bin/lava-test-runner /lav=
a-3814138/1 =

    ... (12 line(s) more)  =

 =20
