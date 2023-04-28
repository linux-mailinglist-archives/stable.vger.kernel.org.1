Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9626F1F19
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 22:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346493AbjD1UFB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 16:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346460AbjD1UFA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 16:05:00 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557A4213C
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 13:04:59 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b733fd00bso354891b3a.0
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 13:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682712298; x=1685304298;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iQrAfF07srJvGGA/FlmbQzij1pWlORRqsJkQtwWG3a4=;
        b=Ab4U24CylwSfvYWmMuXL4VuUSPjzAqstuB39yfTRIecfSTEaNys3U0j5miXfYmbiIY
         HgFG64tyw7WqCMQUCflvIzEACudRZpavFykiw4SUv7+Q1eyBQLi5kL//opEGKNW+Nrwf
         8vRvnwYU46zikaGO98bOIFICuHlGTMHM7vGEuelvNL7ZwhOGm6CakDXuwETJXg3PLRah
         DFdyLHa6LGkAqmodvcmOgL2ONEYtyf6yQoxJSwVUMlVysLF4QTf5yZ9J58aNLrh1mlie
         8JlkQBiGvVMk4/rOAJSac3Ag9eMGyqS2k1m5A3G2m/DmIgIDS/kMyd5U5dyW+jbzKaZX
         BgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682712298; x=1685304298;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQrAfF07srJvGGA/FlmbQzij1pWlORRqsJkQtwWG3a4=;
        b=M3xnYb8jXK5ovnDIMbOMafQi7OCNRBWoZ/a96KZX0kRUAnIJPQzmZp08IWP0axNV5Z
         phIrWOWJ5wJ19fPfakSu5O5gPmhw9PDi21f99hEmXv1FbT+wxypPLaogeyiWj50JQFwN
         VUg3jAkon2ydF+1C+zXtuJGIvcsyzKr/aluaSGdjmhGAVAOgIpEvTVbfWI3lUxf2NhhV
         psPQ4Df5yUjNq995zBiuAG9rSjbGSOM2w1jb9HwmFGQZsOrXoEIWa5+W/I7UBn1aCWoE
         c40RIg0R8QZJUFnKCmDdbMS2tfVaB/4X2s7am3CfQ2H56ZY0PP4758jQbKgVMwdTKZ2o
         Bkmg==
X-Gm-Message-State: AC+VfDy8F/QmNDNMTUOBGaw6cDh0m8NueDQIU9fEJnNOFrHRU65Zli8x
        JaoOFPeyVGHGVyW214kLHGmUEKlOIHFTcWv0DcQ=
X-Google-Smtp-Source: ACHHUZ4hZwCwuOBJIP/mlDliKxn8YaJtx9mPF3yMy5MfvDYhESvFg7+SccoptuKE4V04+NkFvFfQmA==
X-Received: by 2002:a05:6a20:4412:b0:f2:a0d1:af6c with SMTP id ce18-20020a056a20441200b000f2a0d1af6cmr8620413pzb.0.1682712298219;
        Fri, 28 Apr 2023 13:04:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b3-20020a631b03000000b0050f93a3586fsm13275022pgb.37.2023.04.28.13.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 13:04:57 -0700 (PDT)
Message-ID: <644c26e9.630a0220.67042.bf06@mx.google.com>
Date:   Fri, 28 Apr 2023 13:04:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.10
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.176-372-gc1ed79b00c93
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.10 baseline: 76 runs,
 3 regressions (v5.10.176-372-gc1ed79b00c93)
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

stable-rc/queue/5.10 baseline: 76 runs, 3 regressions (v5.10.176-372-gc1ed7=
9b00c93)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.10/ker=
nel/v5.10.176-372-gc1ed79b00c93/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.10
  Describe: v5.10.176-372-gc1ed79b00c93
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c1ed79b00c93fb5b44e3b5267fbef715833ce0f8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644bf20cd1d5c1f0242e85e7

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gc1ed79b00c93/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gc1ed79b00c93/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bf20cd1d5c1f0242e861d
        failing since 73 days (last pass: v5.10.167-127-g921934d621e4, firs=
t fail: v5.10.167-139-gf9519a5a1701)

    2023-04-28T16:19:04.368176  <8>[   19.046872] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 398754_1.5.2.4.1>
    2023-04-28T16:19:04.478369  / # #
    2023-04-28T16:19:04.581689  export SHELL=3D/bin/sh
    2023-04-28T16:19:04.582620  #
    2023-04-28T16:19:04.684735  / # export SHELL=3D/bin/sh. /lava-398754/en=
vironment
    2023-04-28T16:19:04.685706  =

    2023-04-28T16:19:04.787872  / # . /lava-398754/environment/lava-398754/=
bin/lava-test-runner /lava-398754/1
    2023-04-28T16:19:04.789477  =

    2023-04-28T16:19:04.793817  / # /lava-398754/bin/lava-test-runner /lava=
-398754/1
    2023-04-28T16:19:04.902354  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bed15fa3e9d9ef92e8622

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gc1ed79b00c93/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gc1ed79b00c93/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bed15fa3e9d9ef92e8627
        failing since 29 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-04-28T15:57:59.750431  + set +x

    2023-04-28T15:57:59.756943  <8>[   17.672153] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10152831_1.4.2.3.1>

    2023-04-28T15:57:59.861020  / # #

    2023-04-28T15:57:59.961563  export SHELL=3D/bin/sh

    2023-04-28T15:57:59.961744  #

    2023-04-28T15:58:00.062222  / # export SHELL=3D/bin/sh. /lava-10152831/=
environment

    2023-04-28T15:58:00.062419  =


    2023-04-28T15:58:00.162908  / # . /lava-10152831/environment/lava-10152=
831/bin/lava-test-runner /lava-10152831/1

    2023-04-28T15:58:00.163168  =


    2023-04-28T15:58:00.167497  / # /lava-10152831/bin/lava-test-runner /la=
va-10152831/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644bed13b7df6dce3f2e8608

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gc1ed79b00c93/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.10/v5.10.176=
-372-gc1ed79b00c93/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644bed13b7df6dce3f2e860d
        failing since 29 days (last pass: v5.10.176-61-g2332301f1fab4, firs=
t fail: v5.10.176-104-g2b4187983740)

    2023-04-28T15:57:48.963087  + set +x

    2023-04-28T15:57:48.969883  <8>[   11.965718] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10152803_1.4.2.3.1>

    2023-04-28T15:57:49.073536  / # #

    2023-04-28T15:57:49.174236  export SHELL=3D/bin/sh

    2023-04-28T15:57:49.174436  #

    2023-04-28T15:57:49.274945  / # export SHELL=3D/bin/sh. /lava-10152803/=
environment

    2023-04-28T15:57:49.275149  =


    2023-04-28T15:57:49.375631  / # . /lava-10152803/environment/lava-10152=
803/bin/lava-test-runner /lava-10152803/1

    2023-04-28T15:57:49.375922  =


    2023-04-28T15:57:49.381224  / # /lava-10152803/bin/lava-test-runner /la=
va-10152803/1
 =

    ... (12 line(s) more)  =

 =20
