Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE9770CF67
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 02:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjEWAjN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 20:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbjEWAbC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 20:31:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F35DE54
        for <stable@vger.kernel.org>; Mon, 22 May 2023 17:22:11 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d3e5e5980so4217246b3a.2
        for <stable@vger.kernel.org>; Mon, 22 May 2023 17:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684801330; x=1687393330;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bfLRs0E+Aa8rk4h81lIJXCafDV42fF7smgLguBlASec=;
        b=QrOuEVodMTYdhj5SJjv/kldUZcj2gMvx61YfOhvq2qtcm4Gi9sX2EgaG7n3/GrVWLM
         q8sy177L2x9H9hau8iGSliUstOXnc7Mks26EqIORx52xhvfkb6enJulM/fb6nnH9Ukbx
         eUvnjlwcTazj9YumfXmLzd+pyCu1Xfw87qqAj04LqSM/jdwU6I8jIFx/QHDXYwVehiG2
         U1V9QtRUAoverwnY7JsCjiu6MaB/CpuRZXcEYfn92nVayzausWIrR8B1c5uSDXElexlM
         kq3DPRpNBmdOAgkFeNXiWOGhIRSHrFYqiXf9tObZ/fb1q/Qg4fvIiPYPc/2KLfZyT4Uq
         Ws1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684801330; x=1687393330;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bfLRs0E+Aa8rk4h81lIJXCafDV42fF7smgLguBlASec=;
        b=AzxX6C7EpgooNGZcXK/1vjR5tEJZ/lUDc4ZOOoORn8HaD+/zKZPLJ14qigwXOdc/xd
         it7i60oJdUcL+tsi8e6RpvqSvpITME3nNochEWsttY0bmDaLRFR6Rcf610KoEkYP3i8T
         +m5bNPJND186vpwQeBXOluZ8p0b9OSu5eUSFDP8+sRiX+kQhBPoUvxy8m4JO123U9j9P
         TJ5OZrRvmZNtkwUJKwNvaEL2BSnfL78qJ6nIz096cYc/EieDjjJlZlVAFZ5i3zyENWZl
         VxTNQz1QA4yP3riqAvX4fnSF+VdFlGjMtYDUkZv4OLI28fdDwHvwikJXmbA7g/qMO2XW
         qhzA==
X-Gm-Message-State: AC+VfDxWi2+ljFfoZtEkz/zkcffYLCPj16ulIoWHan2iB5FfyEsb4t8f
        fpvEWUAaMrC+XvEAaR2heyiCHySpq5EnntTPg56Y0w==
X-Google-Smtp-Source: ACHHUZ6lYmzxdZSZ7y25h0yNe61BcgcJRBpseG2bR7WcFznNHnm4WYzU2/Q14YHy5hiHK1wa3Oc6Jw==
X-Received: by 2002:a05:6a00:c88:b0:639:a518:3842 with SMTP id a8-20020a056a000c8800b00639a5183842mr18994865pfv.7.1684801330652;
        Mon, 22 May 2023 17:22:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m2-20020aa79002000000b0064d3446df87sm4620862pfo.183.2023.05.22.17.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 17:22:10 -0700 (PDT)
Message-ID: <646c0732.a70a0220.889b2.8597@mx.google.com>
Date:   Mon, 22 May 2023 17:22:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180-154-gfd59dd82642d
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 170 runs,
 2 regressions (v5.10.180-154-gfd59dd82642d)
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

stable-rc/linux-5.10.y baseline: 170 runs, 2 regressions (v5.10.180-154-gfd=
59dd82642d)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.180-154-gfd59dd82642d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.180-154-gfd59dd82642d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      fd59dd82642d6c5b122f4f122a04f629155c1658 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bd2a2482de28f0d2e860c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-154-gfd59dd82642d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-154-gfd59dd82642d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bd2a2482de28f0d2e8611
        failing since 55 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-05-22T20:37:45.497253  + set +x

    2023-05-22T20:37:45.503800  <8>[   11.378418] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10416404_1.4.2.3.1>

    2023-05-22T20:37:45.608382  / # #

    2023-05-22T20:37:45.708983  export SHELL=3D/bin/sh

    2023-05-22T20:37:45.709159  #

    2023-05-22T20:37:45.809727  / # export SHELL=3D/bin/sh. /lava-10416404/=
environment

    2023-05-22T20:37:45.809907  =


    2023-05-22T20:37:45.910486  / # . /lava-10416404/environment/lava-10416=
404/bin/lava-test-runner /lava-10416404/1

    2023-05-22T20:37:45.910755  =


    2023-05-22T20:37:45.915607  / # /lava-10416404/bin/lava-test-runner /la=
va-10416404/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646bd29f658512a8492e85f6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-154-gfd59dd82642d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80-154-gfd59dd82642d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646bd29f658512a8492e85fb
        failing since 55 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-05-22T20:37:35.872886  <8>[   12.743550] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10416391_1.4.2.3.1>

    2023-05-22T20:37:35.875313  + set +x

    2023-05-22T20:37:35.977518  =


    2023-05-22T20:37:36.078282  / # #export SHELL=3D/bin/sh

    2023-05-22T20:37:36.078533  =


    2023-05-22T20:37:36.179166  / # export SHELL=3D/bin/sh. /lava-10416391/=
environment

    2023-05-22T20:37:36.179431  =


    2023-05-22T20:37:36.280069  / # . /lava-10416391/environment/lava-10416=
391/bin/lava-test-runner /lava-10416391/1

    2023-05-22T20:37:36.280486  =


    2023-05-22T20:37:36.285203  / # /lava-10416391/bin/lava-test-runner /la=
va-10416391/1
 =

    ... (12 line(s) more)  =

 =20
