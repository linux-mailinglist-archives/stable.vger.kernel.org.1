Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B46770B492
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 07:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjEVFdL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 01:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjEVFdK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 01:33:10 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA11C1
        for <stable@vger.kernel.org>; Sun, 21 May 2023 22:33:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-25332422531so2212651a91.0
        for <stable@vger.kernel.org>; Sun, 21 May 2023 22:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684733587; x=1687325587;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4a1LcXDzuTszmXtnmOyJ610kmPZwkraHzfsBGQxryyU=;
        b=TR1NaVfSrFxklkS004bP7vBqPW4TsoUbWmCp/XN0H9BNTSL8RbqnEAc8ujK4FauSoc
         aFTFJMTwO7uAvX413LKS8Ssgp0TjA1bXH7v1eXySfI+qSpV3Y8pNG+za7PuDNczNMtV+
         /fg3p9wxMzSbFb/S7RDnMKF2ug3OC0qidxUy6LwBdGQSrHxnnbzPQqRrAUWpFYCIFn9x
         dnqyp2W2YrM9FAGiuMdllIi7UyzgBfeEshl9cqPB2fSnVLrSbl6f2OVx5XPeJCwL3vBK
         t8M+atqt1Jygw0zX9gz8+KK73F5TywqP83cHh+0xiNtyf8I42lHMcHZT9YIZpiFUw80Y
         Fa3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684733587; x=1687325587;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4a1LcXDzuTszmXtnmOyJ610kmPZwkraHzfsBGQxryyU=;
        b=gLUtsLAmkYbPv2b3JQ5cewzu79cx6fL74x/Fa4Ye3EW2nr6E/nlN/Vp7h6FlJ/kkgE
         rDCsNtD+32h2P2/rVeLv6OeKJkNvgY1xIX/+32FStKoCZ6KnNCE9lAYpqPKMLb88kJV3
         F2zwT7DpI08SXzBBCXG7Fsiq3B0CNC6uWQSK5aLLzdFmPr5DNjk4gRi+pqSHdY3McdhY
         65uGXSSgeyI2Oowbhb1vnhDk54nRf8bLpIZbng9sEyELYa7A6Y0sCj9ZhPMsM/R/+fK7
         MYpTSv0OFH92a0GyjWWHAzy/rJ5IE2mKLKQ3+Ay9SovvVfs5PTm07uKM4ju3XZOoDwOB
         npbQ==
X-Gm-Message-State: AC+VfDxCNf69ctm5XHjQFxpJXWaFyQ4hmEwNYXYq48BeklgqZEXKHGxe
        Sph4S3Eo+As0u1tClppscna1C9jy0j1ZIqdeGQA=
X-Google-Smtp-Source: ACHHUZ75FNiZjV1aeRKj9+LaWdIKpR8aLEso7ZoU4ur8yTP9YzIffvvaXK8oN5BExxlKlMCiA131Ig==
X-Received: by 2002:a17:90a:b902:b0:24e:201e:dcbd with SMTP id p2-20020a17090ab90200b0024e201edcbdmr10347231pjr.21.1684733586926;
        Sun, 21 May 2023 22:33:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ft17-20020a17090b0f9100b00246f9725ffcsm3266244pjb.33.2023.05.21.22.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:33:06 -0700 (PDT)
Message-ID: <646afe92.170a0220.57dd9.4ed7@mx.google.com>
Date:   Sun, 21 May 2023 22:33:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.112-106-gf196e96005aa3
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 124 runs,
 6 regressions (v5.15.112-106-gf196e96005aa3)
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

stable-rc/queue/5.15 baseline: 124 runs, 6 regressions (v5.15.112-106-gf196=
e96005aa3)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.112-106-gf196e96005aa3/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.112-106-gf196e96005aa3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      f196e96005aa37053654b243d7c85f226b6f3a60 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646ac4f64f2b597c9f2e860e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-gf196e96005aa3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-gf196e96005aa3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646ac4f64f2b597c9f2e8613
        failing since 54 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-22T01:26:55.337532  + <8>[   11.527377] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10405715_1.4.2.3.1>

    2023-05-22T01:26:55.338134  set +x

    2023-05-22T01:26:55.446089  / # #

    2023-05-22T01:26:55.548457  export SHELL=3D/bin/sh

    2023-05-22T01:26:55.549212  #

    2023-05-22T01:26:55.650636  / # export SHELL=3D/bin/sh. /lava-10405715/=
environment

    2023-05-22T01:26:55.651549  =


    2023-05-22T01:26:55.753339  / # . /lava-10405715/environment/lava-10405=
715/bin/lava-test-runner /lava-10405715/1

    2023-05-22T01:26:55.753720  =


    2023-05-22T01:26:55.758696  / # /lava-10405715/bin/lava-test-runner /la=
va-10405715/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646ac4f45b811464be2e8636

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-gf196e96005aa3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-gf196e96005aa3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646ac4f45b811464be2e863b
        failing since 54 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-22T01:26:54.098192  <8>[   10.486568] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10405679_1.4.2.3.1>

    2023-05-22T01:26:54.101794  + set +x

    2023-05-22T01:26:54.207038  #

    2023-05-22T01:26:54.208402  =


    2023-05-22T01:26:54.310343  / # #export SHELL=3D/bin/sh

    2023-05-22T01:26:54.311181  =


    2023-05-22T01:26:54.412500  / # export SHELL=3D/bin/sh. /lava-10405679/=
environment

    2023-05-22T01:26:54.412854  =


    2023-05-22T01:26:54.513900  / # . /lava-10405679/environment/lava-10405=
679/bin/lava-test-runner /lava-10405679/1

    2023-05-22T01:26:54.515247  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646ac4d3bbd04c5c2c2e8622

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-gf196e96005aa3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-gf196e96005aa3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646ac4d3bbd04c5c2c2e8627
        failing since 54 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-22T01:26:33.617426  + set +x

    2023-05-22T01:26:33.624046  <8>[   11.171776] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10405722_1.4.2.3.1>

    2023-05-22T01:26:33.728483  / # #

    2023-05-22T01:26:33.829093  export SHELL=3D/bin/sh

    2023-05-22T01:26:33.829290  #

    2023-05-22T01:26:33.929814  / # export SHELL=3D/bin/sh. /lava-10405722/=
environment

    2023-05-22T01:26:33.930008  =


    2023-05-22T01:26:34.030519  / # . /lava-10405722/environment/lava-10405=
722/bin/lava-test-runner /lava-10405722/1

    2023-05-22T01:26:34.030803  =


    2023-05-22T01:26:34.035516  / # /lava-10405722/bin/lava-test-runner /la=
va-10405722/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646ac4d6698c8c4b412e85f4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-gf196e96005aa3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-gf196e96005aa3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646ac4d6698c8c4b412e85f9
        failing since 54 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-22T01:26:31.514727  + set +x

    2023-05-22T01:26:31.520987  <8>[   11.033641] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10405721_1.4.2.3.1>

    2023-05-22T01:26:31.625890  / # #

    2023-05-22T01:26:31.728035  export SHELL=3D/bin/sh

    2023-05-22T01:26:31.728739  #

    2023-05-22T01:26:31.830257  / # export SHELL=3D/bin/sh. /lava-10405721/=
environment

    2023-05-22T01:26:31.830439  =


    2023-05-22T01:26:31.930969  / # . /lava-10405721/environment/lava-10405=
721/bin/lava-test-runner /lava-10405721/1

    2023-05-22T01:26:31.931218  =


    2023-05-22T01:26:31.936900  / # /lava-10405721/bin/lava-test-runner /la=
va-10405721/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646ac4ebd8067ab9562e8645

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-gf196e96005aa3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-gf196e96005aa3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646ac4ebd8067ab9562e864a
        failing since 54 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-22T01:26:46.223813  + <8>[   11.273627] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10405737_1.4.2.3.1>

    2023-05-22T01:26:46.223889  set +x

    2023-05-22T01:26:46.328075  / # #

    2023-05-22T01:26:46.428778  export SHELL=3D/bin/sh

    2023-05-22T01:26:46.428977  #

    2023-05-22T01:26:46.529494  / # export SHELL=3D/bin/sh. /lava-10405737/=
environment

    2023-05-22T01:26:46.529679  =


    2023-05-22T01:26:46.630202  / # . /lava-10405737/environment/lava-10405=
737/bin/lava-test-runner /lava-10405737/1

    2023-05-22T01:26:46.630471  =


    2023-05-22T01:26:46.635250  / # /lava-10405737/bin/lava-test-runner /la=
va-10405737/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646ac4d6698c8c4b412e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-gf196e96005aa3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.112=
-106-gf196e96005aa3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646ac4d6698c8c4b412e85ec
        failing since 54 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-22T01:26:34.904857  + set +x<8>[   11.319104] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10405693_1.4.2.3.1>

    2023-05-22T01:26:34.904954  =


    2023-05-22T01:26:35.008996  / # #

    2023-05-22T01:26:35.109666  export SHELL=3D/bin/sh

    2023-05-22T01:26:35.109859  #

    2023-05-22T01:26:35.210345  / # export SHELL=3D/bin/sh. /lava-10405693/=
environment

    2023-05-22T01:26:35.210528  =


    2023-05-22T01:26:35.311017  / # . /lava-10405693/environment/lava-10405=
693/bin/lava-test-runner /lava-10405693/1

    2023-05-22T01:26:35.311292  =


    2023-05-22T01:26:35.315933  / # /lava-10405693/bin/lava-test-runner /la=
va-10405693/1
 =

    ... (12 line(s) more)  =

 =20
