Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D8870128A
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 01:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjELXiY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 19:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjELXiX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 19:38:23 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987AB19AD
        for <stable@vger.kernel.org>; Fri, 12 May 2023 16:38:20 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6439d505274so6481513b3a.0
        for <stable@vger.kernel.org>; Fri, 12 May 2023 16:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683934699; x=1686526699;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eNAmwPk5s3fmv+8h83ta2F0YruID1d6d1N0nXJMTn2U=;
        b=keyKqKZi8jf02q0doKuMcoecBCrwf9mysHbMH9EXc5LpuGXII5RjqpHlp8J/qA+H4c
         YxdghNSQ3maG+yAe4kxuMvaEa+eaZTDe6NW5IO9tehFmp2TECfUgIsM5EHdO0tSL0LNs
         iHYMT8H1TG6ZUqZvbtNChgGMoxkpdfiBdrhJwGfPnhJLEQuBkvVY77LMtqstvK0OA4ER
         +ihl3kpFvFl04h2NjH3B28vdrC55scseiYPGvh/bnaCaUTmyBo9FaYOaRPOF9M0CqnSv
         2mMqLXpjXW7Vy11HTxHTJ+dQ/xFktvqdWJ35p9tqT6UaTSnxeqsI/abPzbr73unzdxQe
         CFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683934699; x=1686526699;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNAmwPk5s3fmv+8h83ta2F0YruID1d6d1N0nXJMTn2U=;
        b=SdSTEjWxDnO77gtmiMIINGYl10LE43YZpKYnzpMOxD4WEax+8l2lizBM5CP36Mw75q
         idRJgenk7TWHHja4qES4YV3k19VbByWYkJ4ocivvqBHGKWItbI8nm+Pc5y1eI19HQVwK
         w0wfuJA/diU7XToEVXmJk0W4IVnk7XNcoOXLUoVDRT9peG4CeS1vzgWsq7Nr5ChpampI
         w5j0ju4Iril3l6w3I2qoskmcUzk5L2IB34KkV6d1RrdLOu5sD2Vbeo27VnA9Z/IMuDG3
         SJE+NL5eLoI1XAnCtYUkDgV12+ML2/DZc+4L0hpqHIKraiNHHE2Kyrrsl5ppU/lF9lp2
         gZ+w==
X-Gm-Message-State: AC+VfDx5cTwl1v8KG+umXEFkux3XjKyO6JE5pKT7pJ85fmDpfkt6zOzB
        VlkrO0EYzxYFkwK9vUzMmY/n70hnbg5QTVLcJjw=
X-Google-Smtp-Source: ACHHUZ5gZwcVmYIPTkSL276yTBiwzcK9I4n1DeSOkUfmPlZPOjdAI4yxXy0QwKXFFC+imBAU52n6zg==
X-Received: by 2002:a05:6a00:2289:b0:643:90ee:587 with SMTP id f9-20020a056a00228900b0064390ee0587mr35520932pfe.18.1683934699259;
        Fri, 12 May 2023 16:38:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y16-20020aa78550000000b0063b898b3502sm7558066pfn.153.2023.05.12.16.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 16:38:18 -0700 (PDT)
Message-ID: <645ecdea.a70a0220.4b4e4.08d9@mx.google.com>
Date:   Fri, 12 May 2023 16:38:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.111-63-g8716f8247ea80
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/5.15 baseline: 168 runs,
 11 regressions (v5.15.111-63-g8716f8247ea80)
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

stable-rc/queue/5.15 baseline: 168 runs, 11 regressions (v5.15.111-63-g8716=
f8247ea80)

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

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.111-63-g8716f8247ea80/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.111-63-g8716f8247ea80
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      8716f8247ea80f2accf69f60401e91eb592fa778 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645e96719d6ed3195f2e862c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e96719d6ed3195f2e8631
        failing since 45 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-12T19:41:15.399979  + set<8>[    8.904092] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10299313_1.4.2.3.1>

    2023-05-12T19:41:15.400585   +x

    2023-05-12T19:41:15.508525  / # #

    2023-05-12T19:41:15.609106  export SHELL=3D/bin/sh

    2023-05-12T19:41:15.609290  #

    2023-05-12T19:41:15.709786  / # export SHELL=3D/bin/sh. /lava-10299313/=
environment

    2023-05-12T19:41:15.709970  =


    2023-05-12T19:41:15.810451  / # . /lava-10299313/environment/lava-10299=
313/bin/lava-test-runner /lava-10299313/1

    2023-05-12T19:41:15.810711  =


    2023-05-12T19:41:15.815724  / # /lava-10299313/bin/lava-test-runner /la=
va-10299313/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645e966c9d6ed3195f2e8611

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e966c9d6ed3195f2e8616
        failing since 45 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-12T19:41:15.717633  <8>[   10.393215] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10299273_1.4.2.3.1>

    2023-05-12T19:41:15.720724  + set +x

    2023-05-12T19:41:15.827818  / # #

    2023-05-12T19:41:15.929961  export SHELL=3D/bin/sh

    2023-05-12T19:41:15.930599  #

    2023-05-12T19:41:16.031855  / # export SHELL=3D/bin/sh. /lava-10299273/=
environment

    2023-05-12T19:41:16.032555  =


    2023-05-12T19:41:16.133906  / # . /lava-10299273/environment/lava-10299=
273/bin/lava-test-runner /lava-10299273/1

    2023-05-12T19:41:16.134223  =


    2023-05-12T19:41:16.139370  / # /lava-10299273/bin/lava-test-runner /la=
va-10299273/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/645e9784d6d75b199b2e85fe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645e9784d6d75b199b2e8=
5ff
        failing since 98 days (last pass: v5.15.91-12-g3290f78df1ab, first =
fail: v5.15.91-18-ga7afd81d41cb) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/645e982d9ebfc167072e8608

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e982d9ebfc167072e860d
        failing since 115 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-12T19:48:44.782243  + set +x<8>[   10.044046] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3581249_1.5.2.4.1>
    2023-05-12T19:48:44.782440  =

    2023-05-12T19:48:44.888751  / # #
    2023-05-12T19:48:44.990518  export SHELL=3D/bin/sh
    2023-05-12T19:48:44.990968  #
    2023-05-12T19:48:45.092410  / # export SHELL=3D/bin/sh. /lava-3581249/e=
nvironment
    2023-05-12T19:48:45.092855  =

    2023-05-12T19:48:45.093075  / # <3>[   10.272681] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-05-12T19:48:45.194344  . /lava-3581249/environment/lava-3581249/bi=
n/lava-test-runner /lava-3581249/1
    2023-05-12T19:48:45.195343   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645e986ba3c57b082a2e8605

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e986ba3c57b082a2e860a
        failing since 45 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-12T19:49:48.184976  + set +x

    2023-05-12T19:49:48.191729  <8>[   10.789447] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10299282_1.4.2.3.1>

    2023-05-12T19:49:48.295841  / # #

    2023-05-12T19:49:48.398024  export SHELL=3D/bin/sh

    2023-05-12T19:49:48.398804  #

    2023-05-12T19:49:48.500162  / # export SHELL=3D/bin/sh. /lava-10299282/=
environment

    2023-05-12T19:49:48.500511  =


    2023-05-12T19:49:48.601257  / # . /lava-10299282/environment/lava-10299=
282/bin/lava-test-runner /lava-10299282/1

    2023-05-12T19:49:48.601541  =


    2023-05-12T19:49:48.606678  / # /lava-10299282/bin/lava-test-runner /la=
va-10299282/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645e9761e5586ffedf2e8622

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e9761e5586ffedf2e8627
        failing since 45 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-12T19:45:17.766259  <8>[   10.553305] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10299265_1.4.2.3.1>

    2023-05-12T19:45:17.769192  + set +x

    2023-05-12T19:45:17.874489  / # #

    2023-05-12T19:45:17.975394  export SHELL=3D/bin/sh

    2023-05-12T19:45:17.975689  #

    2023-05-12T19:45:18.076340  / # export SHELL=3D/bin/sh. /lava-10299265/=
environment

    2023-05-12T19:45:18.076683  =


    2023-05-12T19:45:18.177386  / # . /lava-10299265/environment/lava-10299=
265/bin/lava-test-runner /lava-10299265/1

    2023-05-12T19:45:18.177909  =


    2023-05-12T19:45:18.182713  / # /lava-10299265/bin/lava-test-runner /la=
va-10299265/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645e9684de383743f92e8608

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e9684de383743f92e860d
        failing since 45 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-12T19:41:28.860653  + <8>[   11.278726] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10299324_1.4.2.3.1>

    2023-05-12T19:41:28.860784  set +x

    2023-05-12T19:41:28.965167  / # #

    2023-05-12T19:41:29.065889  export SHELL=3D/bin/sh

    2023-05-12T19:41:29.066132  #

    2023-05-12T19:41:29.166681  / # export SHELL=3D/bin/sh. /lava-10299324/=
environment

    2023-05-12T19:41:29.166918  =


    2023-05-12T19:41:29.267472  / # . /lava-10299324/environment/lava-10299=
324/bin/lava-test-runner /lava-10299324/1

    2023-05-12T19:41:29.267799  =


    2023-05-12T19:41:29.272318  / # /lava-10299324/bin/lava-test-runner /la=
va-10299324/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-pitx-imx8m           | arm64  | lab-kontron   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645e962028562d058b2e85f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx=
-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx=
-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/645e962028562d058b2e8=
5f8
        new failure (last pass: v5.15.111-63-g64f6528a07317) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645e9770675e6fbef02e85fd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e9770675e6fbef02e8602
        failing since 45 days (last pass: v5.15.104-76-g9168fe5021cf1, firs=
t fail: v5.15.104-83-ga131fb06fbdb)

    2023-05-12T19:45:33.506937  + set<8>[   11.573368] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10299268_1.4.2.3.1>

    2023-05-12T19:45:33.507023   +x

    2023-05-12T19:45:33.611293  / # #

    2023-05-12T19:45:33.711899  export SHELL=3D/bin/sh

    2023-05-12T19:45:33.712097  #

    2023-05-12T19:45:33.812677  / # export SHELL=3D/bin/sh. /lava-10299268/=
environment

    2023-05-12T19:45:33.812813  =


    2023-05-12T19:45:33.913356  / # . /lava-10299268/environment/lava-10299=
268/bin/lava-test-runner /lava-10299268/1

    2023-05-12T19:45:33.913571  =


    2023-05-12T19:45:33.918281  / # /lava-10299268/bin/lava-test-runner /la=
va-10299268/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/645e965259024b92392e85f5

  Results:     38 PASS, 8 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-=
pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e965259024b92392e8621
        failing since 114 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.87-100-ge215d5ead661)

    2023-05-12T19:40:35.803403  + set +x
    2023-05-12T19:40:35.806600  <8>[   16.078504] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3581170_1.5.2.4.1>
    2023-05-12T19:40:35.928252  / # #
    2023-05-12T19:40:36.035261  export SHELL=3D/bin/sh
    2023-05-12T19:40:36.036888  #
    2023-05-12T19:40:36.140444  / # export SHELL=3D/bin/sh. /lava-3581170/e=
nvironment
    2023-05-12T19:40:36.142102  =

    2023-05-12T19:40:36.245764  / # . /lava-3581170/environment/lava-358117=
0/bin/lava-test-runner /lava-3581170/1
    2023-05-12T19:40:36.248680  =

    2023-05-12T19:40:36.251921  / # /lava-3581170/bin/lava-test-runner /lav=
a-3581170/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun8i-h2-plus-orangepi-r1    | arm    | lab-baylibre  | gcc-10   | sunxi_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/645e9579851e8252092e8635

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
2-plus-orangepi-r1.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.111=
-63-g8716f8247ea80/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h=
2-plus-orangepi-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/645e9579851e8252092e863a
        failing since 101 days (last pass: v5.15.82-123-gd03dbdba21ef, firs=
t fail: v5.15.90-203-gea2e94bef77e)

    2023-05-12T19:37:04.658468  / # #
    2023-05-12T19:37:04.764172  export SHELL=3D/bin/sh
    2023-05-12T19:37:04.765790  #
    2023-05-12T19:37:04.869059  / # export SHELL=3D/bin/sh. /lava-3581191/e=
nvironment
    2023-05-12T19:37:04.870724  =

    2023-05-12T19:37:04.974094  / # . /lava-3581191/environment/lava-358119=
1/bin/lava-test-runner /lava-3581191/1
    2023-05-12T19:37:04.976943  =

    2023-05-12T19:37:04.983734  / # /lava-3581191/bin/lava-test-runner /lav=
a-3581191/1
    2023-05-12T19:37:05.095527  + export 'TESTRUN_ID=3D1_bootrr'
    2023-05-12T19:37:05.129397  + cd /lava-3581191/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
