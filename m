Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D847174D2
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 06:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjEaEI2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 00:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjEaEIF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 00:08:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633A610CA
        for <stable@vger.kernel.org>; Tue, 30 May 2023 21:07:20 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-256931ec244so2220567a91.3
        for <stable@vger.kernel.org>; Tue, 30 May 2023 21:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685506033; x=1688098033;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7LhzAVS6961y7CSvcvL2y7opPlrYVbBGb10CSEnAJyM=;
        b=o1ogV+SuWUTongazzZfmPVaFJ3Tz6LF34PeEtxwUjnC0Q1qzoL2kI3FFwn3bmpfQar
         NiMEKHh5Rh20gYHOmZAN7OWqRBJr7mxWF1P9BrFO5KOZpbrEw0TZ/7NAJyERT+wYxQMV
         cDcxUQnJJmC4aR4oMyzLe9DvdDgoRccd5lv8T3z4cLtHP78oJo2sjlFLZ1KeC68OeG4d
         XuZlUgjzizkjKvRAKXRzTHMcRlPyXGPYAsuDlq0O/iy84bXglOyMnDoO+BHWLo1VwKNl
         bDfKxuN4wtB+7aeRJaCeTtotZiqcm3oaaAOWTjjP9AQg7zet6YgtG7++gX864mRR2Dc/
         G5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685506033; x=1688098033;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LhzAVS6961y7CSvcvL2y7opPlrYVbBGb10CSEnAJyM=;
        b=biXyNNXOWJk3DqKTyca7kpRc6O0jqblsXJbLKaTQU8uHPARAgNUCubKjuXRuvSLzHM
         ehO/S4fG8cfO3572WegEKmy0wtPXzRdj6HKo8g9yaoLd0xhMEqHP8jXKujW9P2b5cG9P
         3Px1G4N/qzkKuJklM6tyPfl9kauV8acL4FsjhE8hKSaChxGXuC8Sa2fK5zFlMqagNLsB
         9piigrTnbT21kgjlNYDzpqWBTAZshXw1lcps4IMZqt70k6y2jNi7Wj1beb4Fka4BrVNS
         rakxTB4K8bMf0Mp7git6dP7wy3krIcGtl27L3IDU09u4IJKFRfTY8OCGrAaI7+7ZWYLM
         Ktcg==
X-Gm-Message-State: AC+VfDxxwwYuvMAxLF3LUjkNsqYoPQe2w1DoKEgFVmoiQneepd+6ZwFg
        S+XTMtmJ/MkBoOPVwJMdtMjlJ4CGAbBh5g59lkeZAQ==
X-Google-Smtp-Source: ACHHUZ7jGdO+qXE8DOpsD3jRRrERFRJeKpyqH6ZmFT+e1Q1Yg/A3vZfIcepe4RKIlk3e7+qw64H++w==
X-Received: by 2002:a17:90a:a392:b0:256:257e:cba9 with SMTP id x18-20020a17090aa39200b00256257ecba9mr4333749pjp.13.1685506033643;
        Tue, 30 May 2023 21:07:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090aad8d00b00252a7b73486sm193502pjq.29.2023.05.30.21.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 21:07:13 -0700 (PDT)
Message-ID: <6476c7f1.170a0220.5a2f6.0738@mx.google.com>
Date:   Tue, 30 May 2023 21:07:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.3
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.3.5-41-gb9f6b865c55f2
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.3 baseline: 166 runs,
 2 regressions (v6.3.5-41-gb9f6b865c55f2)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/queue/6.3 baseline: 166 runs, 2 regressions (v6.3.5-41-gb9f6b865c=
55f2)

Regressions Summary
-------------------

platform                     | arch   | lab          | compiler | defconfig=
        | regressions
-----------------------------+--------+--------------+----------+----------=
--------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre | gcc-10   | x86_64_de=
fconfig | 1          =

sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre | gcc-10   | sunxi_def=
config  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.3/kern=
el/v6.3.5-41-gb9f6b865c55f2/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.3
  Describe: v6.3.5-41-gb9f6b865c55f2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b9f6b865c55f21c95739fdf14f92d5e07552d651 =



Test Regressions
---------------- =



platform                     | arch   | lab          | compiler | defconfig=
        | regressions
-----------------------------+--------+--------------+----------+----------=
--------+------------
qemu_x86_64-uefi-mixed       | x86_64 | lab-baylibre | gcc-10   | x86_64_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64769148c5356a519b2e85e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.3/v6.3.5-41-=
gb9f6b865c55f2/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x8=
6_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.3/v6.3.5-41-=
gb9f6b865c55f2/x86_64/x86_64_defconfig/gcc-10/lab-baylibre/baseline-qemu_x8=
6_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64769148c5356a519b2e8=
5e7
        new failure (last pass: v6.3.5-41-gb4d8aea953f2) =

 =



platform                     | arch   | lab          | compiler | defconfig=
        | regressions
-----------------------------+--------+--------------+----------+----------=
--------+------------
sun8i-h3-libretech-all-h3-cc | arm    | lab-baylibre | gcc-10   | sunxi_def=
config  | 1          =


  Details:     https://kernelci.org/test/plan/id/647691c1604835634b2e85e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.3/v6.3.5-41-=
gb9f6b865c55f2/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-li=
bretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.3/v6.3.5-41-=
gb9f6b865c55f2/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-li=
bretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647691c1604835634b2e85eb
        failing since 0 day (last pass: v6.3.3-491-gda6d197f2db4, first fai=
l: v6.3.5-41-g8b53689a0fb0)

    2023-05-31T00:15:36.831652  + set +x
    2023-05-31T00:15:36.833716  <8>[    9.721063] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3632787_1.5.2.4.1>
    2023-05-31T00:15:36.939274  / # #
    2023-05-31T00:15:37.041066  export SHELL=3D/bin/sh
    2023-05-31T00:15:37.041448  #
    2023-05-31T00:15:37.142796  / # export SHELL=3D/bin/sh. /lava-3632787/e=
nvironment
    2023-05-31T00:15:37.143187  =

    2023-05-31T00:15:37.244540  / # . /lava-3632787/environment/lava-363278=
7/bin/lava-test-runner /lava-3632787/1
    2023-05-31T00:15:37.245215  =

    2023-05-31T00:15:37.264417  / # /lava-3632787/bin/lava-test-runner /lav=
a-3632787/1 =

    ... (12 line(s) more)  =

 =20
