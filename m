Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510C9714132
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 01:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjE1XJh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 19:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjE1XJf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 19:09:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDC0BB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 16:09:33 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-25394160fd3so1748714a91.3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 16:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685315372; x=1687907372;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N8Eyt9j8ZhvnuaqwNtGLBmC2o5fWsIDhoXKJEcN86x4=;
        b=lNi5hk61gp2pE9xjF2N0MxuLizeLOLdV5Bb6pFA2uEkXNdoA7ZlsRHdfSx83qNBMIs
         FRASEghI9YPxLdzCQ4I+qz0sqcYh54cPTDg+eDbcuTC/csfGN1elv+rq0HN5a1pf1zD0
         PG9psU6R2HKn8k3O/vWQqf4IJDAGkrdQA3DN9LLMl/aHh6zlJeFzCD9Jsux7dO/+y4Fr
         bHc8/bLuj8IDs1CfOK7SfCR0+uabaK15Bzb1st2ZnMQUsPofRJSiuTgKajofMiuWK0A9
         CLaqj371WCmBtDwaJfd83zJYQBfg+cIp3gZQgENtQ/Ib5zDRArUxe8n3x9aTXpD33ire
         9YEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685315372; x=1687907372;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8Eyt9j8ZhvnuaqwNtGLBmC2o5fWsIDhoXKJEcN86x4=;
        b=YQiUgVHIKnNkq5aGKYFsm00VFhrtubFK8D2zy3VIVpOyhsl9K0C7UbshSRIj9pEjyF
         u4UOdA4V+PaW6mS+4k3a3lEiDsaNerLq9yP4dg38q7Byb/dcDxUKDKxmVa0M/xYjoY2F
         O51nVV4Unq102as/Qe2beHoL/ALSlwwLz9eNgA/PLJbza3jzIi3Bo6MB7QK1L95DmjRN
         w6pya/qnNEuGMECw9KuByHHs1S/msk9kZOIShtxUvf7aJwrJq2mw+BQgTBVB9VXn26Km
         uAzpB8wJkqqeGlKBipEDdREhgL7vEgDevGszEifUe68lX6Xv/1JnaROEySpWoOrXsfaX
         JoGQ==
X-Gm-Message-State: AC+VfDxfwL21xtuWAClZHxINyGQALQCyaFbTiGEC3/2GO53x5iJg+pCs
        waGu1dDILedVnsVCHHbw8M55BSIUChcT55b16Zer8w==
X-Google-Smtp-Source: ACHHUZ4EaaGnqrhhqqdoc9rnoRgicc/D+r65AhUPhpoOa8bD4ThXP/chZ+5WrXpQZ+SP8V4JnlvUhw==
X-Received: by 2002:a17:90a:b109:b0:24c:df8:8efa with SMTP id z9-20020a17090ab10900b0024c0df88efamr8369558pjq.39.1685315372447;
        Sun, 28 May 2023 16:09:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id oj16-20020a17090b4d9000b00252a7b73486sm5844683pjb.29.2023.05.28.16.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 16:09:31 -0700 (PDT)
Message-ID: <6473df2b.170a0220.cd618.b8a0@mx.google.com>
Date:   Sun, 28 May 2023 16:09:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.29-413-g605b0c0bebca
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 154 runs,
 7 regressions (v6.1.29-413-g605b0c0bebca)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y baseline: 154 runs, 7 regressions (v6.1.29-413-g605b0=
c0bebca)

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

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
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
el/v6.1.29-413-g605b0c0bebca/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.29-413-g605b0c0bebca
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      605b0c0bebca019875175033319894f890f068af =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473a84c0971d661f22e860e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g605b0c0bebca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g605b0c0bebca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473a84c0971d661f22e8613
        failing since 59 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-28T19:15:08.055451  + set +x

    2023-05-28T19:15:08.062411  <8>[   10.894622] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10497643_1.4.2.3.1>

    2023-05-28T19:15:08.068886  <6>[   10.902298] lava-test-shell (236) use=
d greatest stack depth: 13312 bytes left

    2023-05-28T19:15:08.177289  / # #

    2023-05-28T19:15:08.280120  export SHELL=3D/bin/sh

    2023-05-28T19:15:08.280934  #

    2023-05-28T19:15:08.382622  / # export SHELL=3D/bin/sh. /lava-10497643/=
environment

    2023-05-28T19:15:08.383442  =


    2023-05-28T19:15:08.485261  / # . /lava-10497643/environment/lava-10497=
643/bin/lava-test-runner /lava-10497643/1

    2023-05-28T19:15:08.486650  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473a84c594d001ec82e8601

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g605b0c0bebca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g605b0c0bebca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473a84c594d001ec82e8606
        failing since 59 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-28T19:15:06.378342  + set +x<8>[   11.190768] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10497692_1.4.2.3.1>

    2023-05-28T19:15:06.378830  =


    2023-05-28T19:15:06.487758  / # #

    2023-05-28T19:15:06.590521  export SHELL=3D/bin/sh

    2023-05-28T19:15:06.591387  #

    2023-05-28T19:15:06.693028  / # export SHELL=3D/bin/sh. /lava-10497692/=
environment

    2023-05-28T19:15:06.693927  =


    2023-05-28T19:15:06.795614  / # . /lava-10497692/environment/lava-10497=
692/bin/lava-test-runner /lava-10497692/1

    2023-05-28T19:15:06.797005  =


    2023-05-28T19:15:06.801829  / # /lava-10497692/bin/lava-test-runner /la=
va-10497692/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473a84b0971d661f22e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g605b0c0bebca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g605b0c0bebca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473a84b0971d661f22e8605
        failing since 59 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-28T19:15:03.325306  <8>[   11.943826] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10497640_1.4.2.3.1>

    2023-05-28T19:15:03.328663  + set +x

    2023-05-28T19:15:03.429867  #

    2023-05-28T19:15:03.430139  =


    2023-05-28T19:15:03.530709  / # #export SHELL=3D/bin/sh

    2023-05-28T19:15:03.530879  =


    2023-05-28T19:15:03.631395  / # export SHELL=3D/bin/sh. /lava-10497640/=
environment

    2023-05-28T19:15:03.631567  =


    2023-05-28T19:15:03.732105  / # . /lava-10497640/environment/lava-10497=
640/bin/lava-test-runner /lava-10497640/1

    2023-05-28T19:15:03.732365  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473a83b468639df002e85f1

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g605b0c0bebca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g605b0c0bebca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473a83b468639df002e85f6
        failing since 59 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-28T19:15:01.438477  + set +x

    2023-05-28T19:15:01.444963  <8>[   10.677478] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10497686_1.4.2.3.1>

    2023-05-28T19:15:01.549118  / # #

    2023-05-28T19:15:01.649693  export SHELL=3D/bin/sh

    2023-05-28T19:15:01.649867  #

    2023-05-28T19:15:01.750353  / # export SHELL=3D/bin/sh. /lava-10497686/=
environment

    2023-05-28T19:15:01.750551  =


    2023-05-28T19:15:01.851086  / # . /lava-10497686/environment/lava-10497=
686/bin/lava-test-runner /lava-10497686/1

    2023-05-28T19:15:01.851372  =


    2023-05-28T19:15:01.855633  / # /lava-10497686/bin/lava-test-runner /la=
va-10497686/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473a83512e6d9ce112e85ee

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g605b0c0bebca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g605b0c0bebca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473a83512e6d9ce112e85f3
        failing since 59 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-28T19:14:55.456192  + set<8>[   10.283089] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10497661_1.4.2.3.1>

    2023-05-28T19:14:55.456303   +x

    2023-05-28T19:14:55.558125  #

    2023-05-28T19:14:55.658884  / # #export SHELL=3D/bin/sh

    2023-05-28T19:14:55.659091  =


    2023-05-28T19:14:55.759616  / # export SHELL=3D/bin/sh. /lava-10497661/=
environment

    2023-05-28T19:14:55.759825  =


    2023-05-28T19:14:55.860360  / # . /lava-10497661/environment/lava-10497=
661/bin/lava-test-runner /lava-10497661/1

    2023-05-28T19:14:55.860630  =


    2023-05-28T19:14:55.865860  / # /lava-10497661/bin/lava-test-runner /la=
va-10497661/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473a852594d001ec82e8643

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g605b0c0bebca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g605b0c0bebca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473a852594d001ec82e8648
        failing since 59 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-28T19:15:11.617649  + set<8>[   10.883495] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10497672_1.4.2.3.1>

    2023-05-28T19:15:11.617733   +x

    2023-05-28T19:15:11.721961  / # #

    2023-05-28T19:15:11.822578  export SHELL=3D/bin/sh

    2023-05-28T19:15:11.822764  #

    2023-05-28T19:15:11.923354  / # export SHELL=3D/bin/sh. /lava-10497672/=
environment

    2023-05-28T19:15:11.923514  =


    2023-05-28T19:15:12.024011  / # . /lava-10497672/environment/lava-10497=
672/bin/lava-test-runner /lava-10497672/1

    2023-05-28T19:15:12.024261  =


    2023-05-28T19:15:12.028974  / # /lava-10497672/bin/lava-test-runner /la=
va-10497672/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6473a83b40c35dd0672e8613

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g605b0c0bebca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.29-=
413-g605b0c0bebca/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230519.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6473a83b40c35dd0672e8618
        failing since 59 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-28T19:14:59.010590  + set +x<8>[   11.754625] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10497669_1.4.2.3.1>

    2023-05-28T19:14:59.010670  =


    2023-05-28T19:14:59.114857  / # #

    2023-05-28T19:14:59.215415  export SHELL=3D/bin/sh

    2023-05-28T19:14:59.215585  #

    2023-05-28T19:14:59.316230  / # export SHELL=3D/bin/sh. /lava-10497669/=
environment

    2023-05-28T19:14:59.317142  =


    2023-05-28T19:14:59.418874  / # . /lava-10497669/environment/lava-10497=
669/bin/lava-test-runner /lava-10497669/1

    2023-05-28T19:14:59.420294  =


    2023-05-28T19:14:59.424597  / # /lava-10497669/bin/lava-test-runner /la=
va-10497669/1
 =

    ... (12 line(s) more)  =

 =20
