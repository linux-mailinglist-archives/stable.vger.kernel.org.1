Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B7C6F63F1
	for <lists+stable@lfdr.de>; Thu,  4 May 2023 06:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjEDEQh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 4 May 2023 00:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjEDEQg (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 4 May 2023 00:16:36 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575701BCC
        for <stable@vger.kernel.org>; Wed,  3 May 2023 21:16:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-24dec03ad8fso61816a91.1
        for <stable@vger.kernel.org>; Wed, 03 May 2023 21:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683173793; x=1685765793;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q2KvVlWOLI9akjFxqMfzH7RROT365Avscgq7sQnIw8M=;
        b=tiLEjKGRM7C8U4T7nYVWWQQCbVocQzvo0iB2SThzgCmJ5Cz4OttwKhTqIiXzl9USSG
         0wR3jwwxev4GPDjzgFjPVyS1TFznlmWS8gkAmm2CYexziqGKBssI+92lsd2GCHAIE5No
         bDj4lj//My7UBF2CEPlNs+lcSEXecaNwqiJwBwHhPjsI/bgNSt//WeGAO8fU0hqPV6mT
         2uS+iswPveiR9O2Y5pqO8QOv590iw4wvJ+f5FaHT/xKjvJSh1AKBkTUzpU1g+UuIb96K
         XVuzwTsMJM0zJrCw6lrvLK9qvJpUfcHcJhXCdLNHGRh3YtzR5S02K82C1DdSh4n5nnOP
         4xgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683173793; x=1685765793;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2KvVlWOLI9akjFxqMfzH7RROT365Avscgq7sQnIw8M=;
        b=D55FGmLor2Mqa8WQSXQhC3Vv2qaO7eLY9q9RAFgCMJm993YZpD/D6Q8lDV0SkXu+jJ
         Wpd6tj/2FG0h7ny8z8bAIkInyB1iB4/3u/L77RGI8WaY0l0b3Dc/Vv+2tHc+IH3hYTp8
         mh0O2LMCJuNiKGSQSnKEY+hP+6x+vaFThhT1WSFwfH+kO5krQ9fj2yDDvTL9YlBRYBVK
         34pA7Z2qAkQU56DaL0eG6JV/tsRxeAJ+/Bq45ncLLCCmW/NRaveeKo6Y7EJI5LJOKSiV
         fOqGEm0+limacOn78IVf+2RZx7jshBkj198U5pWTGwxP/GKUA9FE7RbG0BrhM5WEPXEO
         DKnw==
X-Gm-Message-State: AC+VfDzh1Uokw3kAYhBN2EudwwdN/kXKKoJiQvEyLmjyyUyCVSpnQaQS
        03zd9Ln7w5+aojY7yAiVGpahhQt3Hp/67cHf5JE0dA==
X-Google-Smtp-Source: ACHHUZ4CHLCE+lG8ZGxLiEqY5i34EWzFOvYUzibtX6vO5Y3zw61D1eEE6moxH91EJ2+CsJPEjapujg==
X-Received: by 2002:a17:90b:1c08:b0:24d:ef91:b6d6 with SMTP id oc8-20020a17090b1c0800b0024def91b6d6mr805598pjb.44.1683173792963;
        Wed, 03 May 2023 21:16:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id na6-20020a17090b4c0600b0024b960de793sm2139995pjb.40.2023.05.03.21.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 21:16:32 -0700 (PDT)
Message-ID: <645331a0.170a0220.bc2f1.5044@mx.google.com>
Date:   Wed, 03 May 2023 21:16:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-371-g894cc675d8df
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 162 runs,
 11 regressions (v5.15.105-371-g894cc675d8df)
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

stable-rc/queue/5.15 baseline: 162 runs, 11 regressions (v5.15.105-371-g894=
cc675d8df)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

bcm2711-rpi-4-b              | arm64  | lab-linaro-lkft | gcc-10   | defcon=
fig                    | 1          =

beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.105-371-g894cc675d8df/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.105-371-g894cc675d8df
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      894cc675d8dfb0c7833c979049ba289858559882 =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6453057ef1d1b126662e8644

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6453057ef1d1b126662e8649
        failing since 36 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-04T01:08:07.224705  + set<8>[    8.893258] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10190033_1.4.2.3.1>

    2023-05-04T01:08:07.224787   +x

    2023-05-04T01:08:07.329353  / # #

    2023-05-04T01:08:07.429981  export SHELL=3D/bin/sh

    2023-05-04T01:08:07.430210  #

    2023-05-04T01:08:07.530720  / # export SHELL=3D/bin/sh. /lava-10190033/=
environment

    2023-05-04T01:08:07.530921  =


    2023-05-04T01:08:07.631414  / # . /lava-10190033/environment/lava-10190=
033/bin/lava-test-runner /lava-10190033/1

    2023-05-04T01:08:07.631794  =


    2023-05-04T01:08:07.636473  / # /lava-10190033/bin/lava-test-runner /la=
va-10190033/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64530073a8459d94132e85f3

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64530073a8459d94132e85f8
        failing since 36 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-04T00:46:26.801276  <8>[   10.723280] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10189994_1.4.2.3.1>

    2023-05-04T00:46:26.804875  + set +x

    2023-05-04T00:46:26.906216  =


    2023-05-04T00:46:27.006800  / # #export SHELL=3D/bin/sh

    2023-05-04T00:46:27.006978  =


    2023-05-04T00:46:27.107520  / # export SHELL=3D/bin/sh. /lava-10189994/=
environment

    2023-05-04T00:46:27.107729  =


    2023-05-04T00:46:27.208339  / # . /lava-10189994/environment/lava-10189=
994/bin/lava-test-runner /lava-10189994/1

    2023-05-04T00:46:27.208617  =


    2023-05-04T00:46:27.213855  / # /lava-10189994/bin/lava-test-runner /la=
va-10189994/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2711-rpi-4-b              | arm64  | lab-linaro-lkft | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6452fea7cbc3cc2c912e85ea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/arm64/defconfig/gcc-10/lab-linaro-lkft/baseline-bcm2711-=
rpi-4-b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/arm64/defconfig/gcc-10/lab-linaro-lkft/baseline-bcm2711-=
rpi-4-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6452fea7cbc3cc2c912e8=
5eb
        new failure (last pass: v5.15.105-370-g63bef32a2e80) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beagle-xm                    | arm    | lab-baylibre    | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645302036b8647a7082e863d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645302036b8647a7082e8=
63e
        failing since 89 days (last pass: v5.15.91-12-g3290f78df1ab, first =
fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
cubietruck                   | arm    | lab-baylibre    | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6452ffd302c9266bfc2e8659

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6452ffd302c9266bfc2e865e
        failing since 106 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-04T00:43:50.444654  + set +x<8>[    9.967514] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3549588_1.5.2.4.1>
    2023-05-04T00:43:50.445491  =

    2023-05-04T00:43:50.557228  / # #
    2023-05-04T00:43:50.661517  export SHELL=3D/bin/sh
    2023-05-04T00:43:50.662787  #
    2023-05-04T00:43:50.765321  / # export SHELL=3D/bin/sh. /lava-3549588/e=
nvironment
    2023-05-04T00:43:50.766631  =

    2023-05-04T00:43:50.869296  / # . /lava-3549588/environment/lava-354958=
8/bin/lava-test-runner /lava-3549588/1
    2023-05-04T00:43:50.871402  =

    2023-05-04T00:43:50.876397  / # /lava-3549588/bin/lava-test-runner /lav=
a-3549588/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645304fbf3df0b3ca32e85e8

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645304fbf3df0b3ca32e85ed
        failing since 36 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-04T01:05:48.915732  + set +x

    2023-05-04T01:05:48.922323  <8>[   10.723835] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10190032_1.4.2.3.1>

    2023-05-04T01:05:49.026422  / # #

    2023-05-04T01:05:49.127123  export SHELL=3D/bin/sh

    2023-05-04T01:05:49.127324  #

    2023-05-04T01:05:49.227857  / # export SHELL=3D/bin/sh. /lava-10190032/=
environment

    2023-05-04T01:05:49.228077  =


    2023-05-04T01:05:49.328636  / # . /lava-10190032/environment/lava-10190=
032/bin/lava-test-runner /lava-10190032/1

    2023-05-04T01:05:49.328935  =


    2023-05-04T01:05:49.333634  / # /lava-10190032/bin/lava-test-runner /la=
va-10190032/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6453043b3b1b10101e2e8612

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6453043b3b1b10101e2e8617
        failing since 36 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-04T01:02:31.114575  <8>[   10.263336] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10190044_1.4.2.3.1>

    2023-05-04T01:02:31.117760  + set +x

    2023-05-04T01:02:31.221982  / # #

    2023-05-04T01:02:31.322652  export SHELL=3D/bin/sh

    2023-05-04T01:02:31.322884  #

    2023-05-04T01:02:31.423417  / # export SHELL=3D/bin/sh. /lava-10190044/=
environment

    2023-05-04T01:02:31.423611  =


    2023-05-04T01:02:31.524079  / # . /lava-10190044/environment/lava-10190=
044/bin/lava-test-runner /lava-10190044/1

    2023-05-04T01:02:31.524371  =


    2023-05-04T01:02:31.529549  / # /lava-10190044/bin/lava-test-runner /la=
va-10190044/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64530070eccd5a7eba2e85ea

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64530070eccd5a7eba2e85ef
        failing since 36 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-04T00:46:32.422193  + set<8>[   11.086227] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10190050_1.4.2.3.1>

    2023-05-04T00:46:32.422772   +x

    2023-05-04T00:46:32.530536  / # #

    2023-05-04T00:46:32.632931  export SHELL=3D/bin/sh

    2023-05-04T00:46:32.633292  #

    2023-05-04T00:46:32.734297  / # export SHELL=3D/bin/sh. /lava-10190050/=
environment

    2023-05-04T00:46:32.735097  =


    2023-05-04T00:46:32.836611  / # . /lava-10190050/environment/lava-10190=
050/bin/lava-test-runner /lava-10190050/1

    2023-05-04T00:46:32.837867  =


    2023-05-04T00:46:32.843054  / # /lava-10190050/bin/lava-test-runner /la=
va-10190050/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6453007189b99aa0f92e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6453007189b99aa0f92e85eb
        failing since 36 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-04T00:46:35.498790  <8>[   11.440353] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10190056_1.4.2.3.1>

    2023-05-04T00:46:35.606861  / # #

    2023-05-04T00:46:35.709341  export SHELL=3D/bin/sh

    2023-05-04T00:46:35.710108  #

    2023-05-04T00:46:35.811728  / # export SHELL=3D/bin/sh. /lava-10190056/=
environment

    2023-05-04T00:46:35.812508  =


    2023-05-04T00:46:35.914112  / # . /lava-10190056/environment/lava-10190=
056/bin/lava-test-runner /lava-10190056/1

    2023-05-04T00:46:35.915390  =


    2023-05-04T00:46:35.919970  / # /lava-10190056/bin/lava-test-runner /la=
va-10190056/1

    2023-05-04T00:46:35.926020  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3328-rock64                | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6452fe66cc7687e8272e8723

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock=
64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6452fe67cc7687e8272e8728
        failing since 91 days (last pass: v5.15.72-36-g40cafafcdb983, first=
 fail: v5.15.90-215-gdf99871482a0)

    2023-05-04T00:37:48.870423  [   16.034356] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3549520_1.5.2.4.1>
    2023-05-04T00:37:48.975490  =

    2023-05-04T00:37:49.076890  / # #export SHELL=3D/bin/sh
    2023-05-04T00:37:49.077400  =

    2023-05-04T00:37:49.077647  / # [   16.165586] rockchip-drm display-sub=
system: [drm] Cannot find any crtc or sizes
    2023-05-04T00:37:49.178861  export SHELL=3D/bin/sh. /lava-3549520/envir=
onment
    2023-05-04T00:37:49.179351  =

    2023-05-04T00:37:49.280535  / # . /lava-3549520/environment/lava-354952=
0/bin/lava-test-runner /lava-3549520/1
    2023-05-04T00:37:49.281367  =

    2023-05-04T00:37:49.283831  / # /lava-3549520/bin/lava-test-runner /lav=
a-3549520/1 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre    | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645301ec90e2e765072e869c

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.105=
-371-g894cc675d8df/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645301ec90e2e765072e86c2
        failing since 106 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-04T00:52:32.519819  + set +x
    2023-05-04T00:52:32.524081  <8>[   16.061966] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3549531_1.5.2.4.1>
    2023-05-04T00:52:32.647134  / # #
    2023-05-04T00:52:32.754254  export SHELL=3D/bin/sh
    2023-05-04T00:52:32.756050  #
    2023-05-04T00:52:32.859382  / # export SHELL=3D/bin/sh. /lava-3549531/e=
nvironment
    2023-05-04T00:52:32.861103  =

    2023-05-04T00:52:32.964607  / # . /lava-3549531/environment/lava-354953=
1/bin/lava-test-runner /lava-3549531/1
    2023-05-04T00:52:32.967506  =

    2023-05-04T00:52:32.969653  / # /lava-3549531/bin/lava-test-runner /lav=
a-3549531/1 =

    ... (12 line(s) more)  =

 =20
