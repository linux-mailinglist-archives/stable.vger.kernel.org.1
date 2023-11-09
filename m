Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927737E6A8B
	for <lists+stable@lfdr.de>; Thu,  9 Nov 2023 13:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjKIM1L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 9 Nov 2023 07:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjKIM1L (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 9 Nov 2023 07:27:11 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236F22590
        for <stable@vger.kernel.org>; Thu,  9 Nov 2023 04:27:09 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5b9a456798eso631770a12.3
        for <stable@vger.kernel.org>; Thu, 09 Nov 2023 04:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699532828; x=1700137628; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7Qjd5/kPH5QYW8g/2BX8bZVkaOki3Rhy5j/CnXN6tg=;
        b=idxgpw3rB8xO7lQdcH+c/AHe55sNVATH63MlblhMnY6lxms89F3GOB0xguLMWfexgb
         2GUXiHravM/A/ItAalIE0jfD/SFSy/bP9SjcaV0y76fSNXCH4I+d85Gckv+g7Q7nXOEE
         oDvcovp1lOmlizVw6V29ulVZBtg/plTzVAS91jDqXxY1KDMr/uQJeLLySQAjTzIQbAqm
         F2D9V31+JJRpI0oMJyZy8g0rj2AwpKLOr6Ti4AzmjeKvXgCoBvwSsM3KB72N06F2OHlv
         H3rPoLS46PjrxZUiqBc4kmYCtgJwblGngBRnI2VrbRmIUc8LUjcekSxQMmNM0LZJauJR
         e6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699532828; x=1700137628;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7Qjd5/kPH5QYW8g/2BX8bZVkaOki3Rhy5j/CnXN6tg=;
        b=lQS79DZtWrCDCyI0w269iuMry1wWnOX4J3Np8lf/cvR4WgMN4UrASK6X5KQ4Hl4jH7
         7iNbVdemt2zrssfAEJOc+2VFdTLQXYXTV2ORYmo4vmohlnAIrkXak+8CyK2B1Zuncpgq
         myuWeFowXw6AK8aEcD4JEaVahWj/T855tXxzzoq/hXOIGwbSXrZdYyj5swYIWBlzL8rn
         zRRJ+nHY7HJDjWJ6C8CnitfvccchK9xe4WtGpwb/T2AY2WFQc0qX+MGzBvz1ibPw8iMG
         5clCb81SlxdeOnM0IaAKYQPR4DDTc+czM69toPb+lOWFWPdSc4drzhPQxURGtgC+1Y8h
         O2wg==
X-Gm-Message-State: AOJu0Yzm4+ptoMlrx+Bw9OIaXXysC8v+KciRbh/DLI90xQPXLsPuwM0B
        xyUGOZoi/pc22l2+w1cSvpJmX2gGVUHF29denmplcg==
X-Google-Smtp-Source: AGHT+IGnlub1YGh7uRo4kcQXohieCJO3+mEseMlAAewvgPdPtTrWv2yNC2OkpapOnWzURGFZp2Wjvg==
X-Received: by 2002:a05:6a20:ddaf:b0:17d:d70f:a2c4 with SMTP id kw47-20020a056a20ddaf00b0017dd70fa2c4mr3946554pzb.26.1699532828179;
        Thu, 09 Nov 2023 04:27:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m11-20020a62f20b000000b006887be16675sm10458906pfh.205.2023.11.09.04.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 04:27:07 -0800 (PST)
Message-ID: <654cd01b.620a0220.0bb3.a05d@mx.google.com>
Date:   Thu, 09 Nov 2023 04:27:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.138
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
Subject: stable/linux-5.15.y baseline: 184 runs, 4 regressions (v5.15.138)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-5.15.y baseline: 184 runs, 4 regressions (v5.15.138)

Regressions Summary
-------------------

platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun7i-a20-cubieboard2       | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =

sun8i-a33-olinuxino         | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =

sun8i-h3-orangepi-pc        | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =

sun8i-r40-bananapi-m2-ultra | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.138/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.138
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      80529b4968a8052f894d00021a576d8a2d89aa08 =



Test Regressions
---------------- =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun7i-a20-cubieboard2       | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/654c9be3f7a8cbe148efcf1c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.138/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun7i-a20-cubie=
board2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.138/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun7i-a20-cubie=
board2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/654c9be3f7a8cbe148efc=
f1d
        new failure (last pass: v5.15.137) =

 =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun8i-a33-olinuxino         | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/654c9be1d2d9693132efcf0f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.138/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-a33-olinu=
xino.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.138/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-a33-olinu=
xino.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/654c9be1d2d9693132efc=
f10
        new failure (last pass: v5.15.137) =

 =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun8i-h3-orangepi-pc        | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/654c9d865d01aa532befcef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.138/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-h3-orange=
pi-pc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.138/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-h3-orange=
pi-pc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/654c9d865d01aa532befc=
ef7
        new failure (last pass: v5.15.137) =

 =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun8i-r40-bananapi-m2-ultra | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/654c9d9afed9c16a32efcef7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.138/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-r40-banan=
api-m2-ultra.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.138/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-r40-banan=
api-m2-ultra.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/654c9d9afed9c16a32efc=
ef8
        new failure (last pass: v5.15.137) =

 =20
