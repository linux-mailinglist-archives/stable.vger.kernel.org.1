Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E30743C49
	for <lists+stable@lfdr.de>; Fri, 30 Jun 2023 14:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjF3Myd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 30 Jun 2023 08:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjF3Myd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 30 Jun 2023 08:54:33 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265052D4A
        for <stable@vger.kernel.org>; Fri, 30 Jun 2023 05:54:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6686ef86110so1060227b3a.2
        for <stable@vger.kernel.org>; Fri, 30 Jun 2023 05:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688129670; x=1690721670;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oVNoq2TKZAGFn5XsWv41NA4ZG/ftnpBkPveNgv4KKnk=;
        b=KoCG1fwZBFiXLKPkHrYuSg13LLcK+RWQeQJQW/FTb9XRg6tzdlYhQG03nbp4Uz7UuN
         CpvW7IlhTN5h8qZhgbnmtxsiHbJGT/EU3lxtJzjDYEKXwbpkV8XB5H6QMh59w9nf54Vt
         CO2atgDO2L4qWwmNMphojNZtU+ZOqTaupfuTItBkUPwqljHAoex6RgH4XuxlnMldKgN/
         KLdhM3CoZ6aEQ1KgQTNfMESNlPuL/QXcDRmXncnGeko9HsiKy+TYlVdV3fSrMNGPHvnj
         PIQAV24tSK/XcM/ytRnfOd5kjMl6Q1UesJP5xj/fHzA0wb0ZOXDVBsflnmvW2QTq8O2S
         VlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688129670; x=1690721670;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVNoq2TKZAGFn5XsWv41NA4ZG/ftnpBkPveNgv4KKnk=;
        b=D1RLNNJgGYHEcBWfvUS9OUbuz4B+PWInvXiqp3+2HrMPiWw18sNkx1oj7Cnm6Y2VwK
         8GbbFiiwzCxzIB2NevOro69YkDPaqyh7oTUior9PtCwJruMw0PKgt+qy1j1WRBkadgPh
         +1Iq9HF4pUJhYmKQuY2kejg+9y4mRcCoX/0eRRn1c1zsPkOfuwg6bQThQXgiGu4aPuYX
         njXRfmbVTyc3bOYN0Po275VY3baYkx7F/R0J8Bu50Ey8zYMZ46RfnXd187gRJV7Nf7Uk
         9VYyO818G56Zo/v2Z+xkq6a1CwW9Ptif1qrofCML0c6Cw9MYWMnzs2rHf+6qsuNTUIuA
         liVA==
X-Gm-Message-State: ABy/qLbJrjcZ9vUakDHORfGruOmB9zNlg1gcu2HCCRaNLCAFTGY+FbT4
        s7Z6dCKaNP20qxbvhhYPXmtGcU2hd1V+hPCh0lRyjA==
X-Google-Smtp-Source: APBJJlHOgg9cPXoKxxydD3qAsaghZ7hPM9VA3VEQD3pAKumeIx4+3WXPKrFWQUmOhOyqwJOP6T/tAg==
X-Received: by 2002:a05:6a00:2da0:b0:668:8596:752f with SMTP id fb32-20020a056a002da000b006688596752fmr2974470pfb.4.1688129670028;
        Fri, 30 Jun 2023 05:54:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g5-20020aa78745000000b00678159eacecsm7689500pfo.121.2023.06.30.05.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 05:54:29 -0700 (PDT)
Message-ID: <649ed085.a70a0220.8d572.0468@mx.google.com>
Date:   Fri, 30 Jun 2023 05:54:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.36-34-gbb9014bd0a31
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y baseline: 111 runs,
 6 regressions (v6.1.36-34-gbb9014bd0a31)
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

stable-rc/linux-6.1.y baseline: 111 runs, 6 regressions (v6.1.36-34-gbb9014=
bd0a31)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.36-34-gbb9014bd0a31/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.36-34-gbb9014bd0a31
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      bb9014bd0a3195cf910cede585b8dc0c4f85aa50 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649e9bb0aed69b5f80bb2aff

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
34-gbb9014bd0a31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
34-gbb9014bd0a31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649e9bb1aed69b5f80bb2b04
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-30T09:08:58.526779  <8>[   12.872991] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10964534_1.4.2.3.1>

    2023-06-30T09:08:58.530413  + set +x

    2023-06-30T09:08:58.634667  / # #

    2023-06-30T09:08:58.735303  export SHELL=3D/bin/sh

    2023-06-30T09:08:58.735545  #

    2023-06-30T09:08:58.836053  / # export SHELL=3D/bin/sh. /lava-10964534/=
environment

    2023-06-30T09:08:58.836240  =


    2023-06-30T09:08:58.936794  / # . /lava-10964534/environment/lava-10964=
534/bin/lava-test-runner /lava-10964534/1

    2023-06-30T09:08:58.937131  =


    2023-06-30T09:08:58.942932  / # /lava-10964534/bin/lava-test-runner /la=
va-10964534/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649e9bb6aed69b5f80bb2b15

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
34-gbb9014bd0a31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
34-gbb9014bd0a31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649e9bb6aed69b5f80bb2b1a
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-30T09:08:47.797624  + set<8>[   11.844451] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10964550_1.4.2.3.1>

    2023-06-30T09:08:47.798174   +x

    2023-06-30T09:08:47.906231  / # #

    2023-06-30T09:08:48.008717  export SHELL=3D/bin/sh

    2023-06-30T09:08:48.009450  #

    2023-06-30T09:08:48.111065  / # export SHELL=3D/bin/sh. /lava-10964550/=
environment

    2023-06-30T09:08:48.111857  =


    2023-06-30T09:08:48.213532  / # . /lava-10964550/environment/lava-10964=
550/bin/lava-test-runner /lava-10964550/1

    2023-06-30T09:08:48.214794  =


    2023-06-30T09:08:48.219796  / # /lava-10964550/bin/lava-test-runner /la=
va-10964550/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649e9ba9aed69b5f80bb2ad0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
34-gbb9014bd0a31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
34-gbb9014bd0a31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649e9ba9aed69b5f80bb2ad5
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-30T09:08:41.317816  + set +x

    2023-06-30T09:08:41.324641  <8>[   10.234703] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10964541_1.4.2.3.1>

    2023-06-30T09:08:41.428369  / # #

    2023-06-30T09:08:41.528971  export SHELL=3D/bin/sh

    2023-06-30T09:08:41.529129  #

    2023-06-30T09:08:41.629776  / # export SHELL=3D/bin/sh. /lava-10964541/=
environment

    2023-06-30T09:08:41.629951  =


    2023-06-30T09:08:41.730442  / # . /lava-10964541/environment/lava-10964=
541/bin/lava-test-runner /lava-10964541/1

    2023-06-30T09:08:41.730684  =


    2023-06-30T09:08:41.735443  / # /lava-10964541/bin/lava-test-runner /la=
va-10964541/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649e9ba1362771f1eabb2a93

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
34-gbb9014bd0a31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
34-gbb9014bd0a31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649e9ba1362771f1eabb2a98
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-30T09:08:37.413890  <8>[    7.991011] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10964566_1.4.2.3.1>

    2023-06-30T09:08:37.417131  + set +x

    2023-06-30T09:08:37.523317  =


    2023-06-30T09:08:37.625251  / # #export SHELL=3D/bin/sh

    2023-06-30T09:08:37.626070  =


    2023-06-30T09:08:37.727583  / # export SHELL=3D/bin/sh. /lava-10964566/=
environment

    2023-06-30T09:08:37.728360  =


    2023-06-30T09:08:37.830071  / # . /lava-10964566/environment/lava-10964=
566/bin/lava-test-runner /lava-10964566/1

    2023-06-30T09:08:37.831320  =


    2023-06-30T09:08:37.837113  / # /lava-10964566/bin/lava-test-runner /la=
va-10964566/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649e9ba5aed69b5f80bb2a8c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
34-gbb9014bd0a31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
34-gbb9014bd0a31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649e9ba5aed69b5f80bb2a91
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-30T09:08:46.545282  + set<8>[   10.845441] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10964560_1.4.2.3.1>

    2023-06-30T09:08:46.545362   +x

    2023-06-30T09:08:46.649570  / # #

    2023-06-30T09:08:46.750109  export SHELL=3D/bin/sh

    2023-06-30T09:08:46.750281  #

    2023-06-30T09:08:46.850748  / # export SHELL=3D/bin/sh. /lava-10964560/=
environment

    2023-06-30T09:08:46.850949  =


    2023-06-30T09:08:46.951514  / # . /lava-10964560/environment/lava-10964=
560/bin/lava-test-runner /lava-10964560/1

    2023-06-30T09:08:46.951791  =


    2023-06-30T09:08:46.956440  / # /lava-10964560/bin/lava-test-runner /la=
va-10964560/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649e9b9a13f7ae3473bb2a7d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
34-gbb9014bd0a31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.36-=
34-gbb9014bd0a31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649e9b9a13f7ae3473bb2a82
        failing since 91 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-06-30T09:08:26.829574  + set<8>[   11.677181] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10964562_1.4.2.3.1>

    2023-06-30T09:08:26.829667   +x

    2023-06-30T09:08:26.933948  / # #

    2023-06-30T09:08:27.034764  export SHELL=3D/bin/sh

    2023-06-30T09:08:27.034976  #

    2023-06-30T09:08:27.135523  / # export SHELL=3D/bin/sh. /lava-10964562/=
environment

    2023-06-30T09:08:27.135767  =


    2023-06-30T09:08:27.236363  / # . /lava-10964562/environment/lava-10964=
562/bin/lava-test-runner /lava-10964562/1

    2023-06-30T09:08:27.236671  =


    2023-06-30T09:08:27.241029  / # /lava-10964562/bin/lava-test-runner /la=
va-10964562/1
 =

    ... (12 line(s) more)  =

 =20
