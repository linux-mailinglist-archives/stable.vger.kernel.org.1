Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346C26F19EA
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 15:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346217AbjD1Nry (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 09:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjD1Nrx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 09:47:53 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B22D3581
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 06:47:50 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64115e652eeso12614949b3a.0
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682689669; x=1685281669;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z03paMsxN7Ab9ao39kgYj16OlvNEUBVStYhIHW7Kivo=;
        b=QxOSpU/R/VDLBh0ncLKbBBXqoCf9ExB2CzXH3RhB94uK+4D0OqaxpvMW4YxjeS9OJH
         Ar84bN3oK6AKUWSnoqqZjrqpWg0mwSEES5+DKb2cHKTXKPosbRS/YH2E7AT6s0Gv37ol
         7gNOKxB7o9d1gdhuVX1sGP5lYiV/9PEnRD0zILxwLcB8QRlFjZmqVO2Ihv8vHVrFLqwu
         cBqgBJu/wDPvyKgVn7dQ7MaONwKXbw4PjMF06p6LgtIOuQ7ThvxT30uhbl2kd5AdICGn
         k7LpFI/RZRpP+5eeoKyn/AGDbQLROjymuQHW5r9O9MPMLS/PS28dYu7dEi1aDjlB+jLa
         xigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682689669; x=1685281669;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z03paMsxN7Ab9ao39kgYj16OlvNEUBVStYhIHW7Kivo=;
        b=eFBvFNF7Fq4mpGfBf1BKU1pO52OMrElCW+I8y4da+cS29JOdMVfzT6JYoboyRhZDpy
         bXi0TsOeu+GMojFPNGeYvDw7HW8HG1Pbzv0cKSjqmbijRkitdo8XrxgGLfdyAAbvTYen
         RlzQcNlR9O4yErYPuoax5CzWUEf0DtLJpUK1+m+REoZlv9gVICWrNUb14FQNpTbLC2pn
         LLIjuHoBBhmfDZdgYmnhfrxE6qoN5QUfk+EMvjvMFR9NPuczyC1R8xDE9IjED1K1Ba+l
         PwXfbYtPRtRD/9Xhz3R+F40nPd87Wx2zNr6v13ixU7RqgskoXyq0XBJNMKMyDMFb0E74
         X9ag==
X-Gm-Message-State: AC+VfDzPMcA0MFgO06J5SyY1zlmhyDegqM+jpDW5yn0jyIp00mWUIjpr
        D3sQ/9Pb0QlU+W+Yj/kLSluo27kQ05IhatxjvJY=
X-Google-Smtp-Source: ACHHUZ4wbqDZqL9tXoraVIT7kUUO8kMjDUVz6uNpMHXykBpGS6I11xh3tumeMBIWW1Mb9R1tvgF8sw==
X-Received: by 2002:a17:90b:4381:b0:247:56b3:4f2 with SMTP id in1-20020a17090b438100b0024756b304f2mr11553874pjb.7.1682689668840;
        Fri, 28 Apr 2023 06:47:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w18-20020a1709027b9200b001a687c505e9sm9248780pll.237.2023.04.28.06.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 06:47:48 -0700 (PDT)
Message-ID: <644bce84.170a0220.c589f.3299@mx.google.com>
Date:   Fri, 28 Apr 2023 06:47:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.105-357-g0df385178c8c
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.15.y baseline: 116 runs,
 10 regressions (v5.15.105-357-g0df385178c8c)
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

stable-rc/linux-5.15.y baseline: 116 runs, 10 regressions (v5.15.105-357-g0=
df385178c8c)

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

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.105-357-g0df385178c8c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.105-357-g0df385178c8c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      0df385178c8c3cb4935d16be7d3153aa177aca61 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644b91daf5786cd80f2e8630

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b91daf5786cd80f2e8635
        failing since 30 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-04-28T09:28:44.263405  <8>[   10.389421] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10149417_1.4.2.3.1>

    2023-04-28T09:28:44.266082  + set +x

    2023-04-28T09:28:44.371221  / # #

    2023-04-28T09:28:44.471926  export SHELL=3D/bin/sh

    2023-04-28T09:28:44.472185  #

    2023-04-28T09:28:44.572744  / # export SHELL=3D/bin/sh. /lava-10149417/=
environment

    2023-04-28T09:28:44.572986  =


    2023-04-28T09:28:44.673528  / # . /lava-10149417/environment/lava-10149=
417/bin/lava-test-runner /lava-10149417/1

    2023-04-28T09:28:44.673863  =


    2023-04-28T09:28:44.679182  / # /lava-10149417/bin/lava-test-runner /la=
va-10149417/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644b91fbdd62dcb5962e863e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b91fbdd62dcb5962e8643
        failing since 30 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-04-28T09:29:12.445551  + set<8>[   11.098731] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10149424_1.4.2.3.1>

    2023-04-28T09:29:12.446153   +x

    2023-04-28T09:29:12.554297  / # #

    2023-04-28T09:29:12.656875  export SHELL=3D/bin/sh

    2023-04-28T09:29:12.657681  #

    2023-04-28T09:29:12.759253  / # export SHELL=3D/bin/sh. /lava-10149424/=
environment

    2023-04-28T09:29:12.760052  =


    2023-04-28T09:29:12.861827  / # . /lava-10149424/environment/lava-10149=
424/bin/lava-test-runner /lava-10149424/1

    2023-04-28T09:29:12.863121  =


    2023-04-28T09:29:12.867940  / # /lava-10149424/bin/lava-test-runner /la=
va-10149424/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644b91e8af5fd8b5082e8618

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b91e8af5fd8b5082e861d
        failing since 30 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-04-28T09:28:50.861334  <8>[   10.028009] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10149427_1.4.2.3.1>

    2023-04-28T09:28:50.864359  + set +x

    2023-04-28T09:28:50.968767  #

    2023-04-28T09:28:51.071579  / # #export SHELL=3D/bin/sh

    2023-04-28T09:28:51.072344  =


    2023-04-28T09:28:51.173786  / # export SHELL=3D/bin/sh. /lava-10149427/=
environment

    2023-04-28T09:28:51.174554  =


    2023-04-28T09:28:51.275974  / # . /lava-10149427/environment/lava-10149=
427/bin/lava-test-runner /lava-10149427/1

    2023-04-28T09:28:51.277191  =


    2023-04-28T09:28:51.282667  / # /lava-10149427/bin/lava-test-runner /la=
va-10149427/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644b972bdafe307d7c2e861a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-b=
eagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644b972bdafe307d7c2e8=
61b
        failing since 350 days (last pass: v5.15.37-259-gab77581473a3, firs=
t fail: v5.15.39) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644b968ab6e831dc022e8612

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cu=
bietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b968ab6e831dc022e8617
        failing since 101 days (last pass: v5.15.82-124-gd731c63c25d1, firs=
t fail: v5.15.87-101-g5bcc318cb4cd)

    2023-04-28T09:48:47.663845  + set +x<8>[   10.018177] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3540171_1.5.2.4.1>
    2023-04-28T09:48:47.664621  =

    2023-04-28T09:48:47.774844  / # #
    2023-04-28T09:48:47.878086  export SHELL=3D/bin/sh
    2023-04-28T09:48:47.879209  #
    2023-04-28T09:48:47.981963  / # export SHELL=3D/bin/sh. /lava-3540171/e=
nvironment
    2023-04-28T09:48:47.983095  =

    2023-04-28T09:48:47.983813  / # <3>[   10.272808] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-04-28T09:48:48.085989  . /lava-3540171/environment/lava-3540171/bi=
n/lava-test-runner /lava-3540171/1
    2023-04-28T09:48:48.087541   =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644b91ebaf5fd8b5082e8625

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b91ebaf5fd8b5082e862a
        failing since 30 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-04-28T09:28:50.081421  + set +x

    2023-04-28T09:28:50.088258  <8>[   16.218942] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10149469_1.4.2.3.1>

    2023-04-28T09:28:50.192670  / # #

    2023-04-28T09:28:50.293253  export SHELL=3D/bin/sh

    2023-04-28T09:28:50.293476  #

    2023-04-28T09:28:50.393980  / # export SHELL=3D/bin/sh. /lava-10149469/=
environment

    2023-04-28T09:28:50.394175  =


    2023-04-28T09:28:50.494690  / # . /lava-10149469/environment/lava-10149=
469/bin/lava-test-runner /lava-10149469/1

    2023-04-28T09:28:50.495011  =


    2023-04-28T09:28:50.500057  / # /lava-10149469/bin/lava-test-runner /la=
va-10149469/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644b91e0f5786cd80f2e8641

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b91e0f5786cd80f2e8646
        failing since 30 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-04-28T09:28:46.991155  + set +x<8>[   10.883494] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10149415_1.4.2.3.1>

    2023-04-28T09:28:46.991698  =


    2023-04-28T09:28:47.098713  #

    2023-04-28T09:28:47.201428  / # #export SHELL=3D/bin/sh

    2023-04-28T09:28:47.202175  =


    2023-04-28T09:28:47.303846  / # export SHELL=3D/bin/sh. /lava-10149415/=
environment

    2023-04-28T09:28:47.304733  =


    2023-04-28T09:28:47.406508  / # . /lava-10149415/environment/lava-10149=
415/bin/lava-test-runner /lava-10149415/1

    2023-04-28T09:28:47.407789  =


    2023-04-28T09:28:47.414110  / # /lava-10149415/bin/lava-test-runner /la=
va-10149415/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644b91da04706074aa2e8608

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b91da04706074aa2e860d
        failing since 30 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-04-28T09:28:36.934765  + set<8>[   11.023165] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10149418_1.4.2.3.1>

    2023-04-28T09:28:36.934844   +x

    2023-04-28T09:28:37.038865  / # #

    2023-04-28T09:28:37.139401  export SHELL=3D/bin/sh

    2023-04-28T09:28:37.139584  #

    2023-04-28T09:28:37.240040  / # export SHELL=3D/bin/sh. /lava-10149418/=
environment

    2023-04-28T09:28:37.240220  =


    2023-04-28T09:28:37.340724  / # . /lava-10149418/environment/lava-10149=
418/bin/lava-test-runner /lava-10149418/1

    2023-04-28T09:28:37.340975  =


    2023-04-28T09:28:37.345816  / # /lava-10149418/bin/lava-test-runner /la=
va-10149418/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644b91c5c70ca285882e8649

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b91c5c70ca285882e864e
        failing since 30 days (last pass: v5.15.104, first fail: v5.15.104-=
147-gea115396267e)

    2023-04-28T09:28:25.042188  + set<8>[   11.688053] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10149384_1.4.2.3.1>

    2023-04-28T09:28:25.042291   +x

    2023-04-28T09:28:25.146481  / # #

    2023-04-28T09:28:25.247056  export SHELL=3D/bin/sh

    2023-04-28T09:28:25.247223  #

    2023-04-28T09:28:25.347735  / # export SHELL=3D/bin/sh. /lava-10149384/=
environment

    2023-04-28T09:28:25.347904  =


    2023-04-28T09:28:25.448409  / # . /lava-10149384/environment/lava-10149=
384/bin/lava-test-runner /lava-10149384/1

    2023-04-28T09:28:25.448654  =


    2023-04-28T09:28:25.453310  / # /lava-10149384/bin/lava-test-runner /la=
va-10149384/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
stm32mp157c-dk2              | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644b96424c453b69082e860f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
05-357-g0df385178c8c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-st=
m32mp157c-dk2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644b96424c453b69082e8614
        failing since 82 days (last pass: v5.15.59, first fail: v5.15.91-21=
-gd8296a906e7a)

    2023-04-28T09:47:38.660725  <8>[   11.547532] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3540178_1.5.2.4.1>
    2023-04-28T09:47:38.767764  / # #
    2023-04-28T09:47:38.869485  export SHELL=3D/bin/sh
    2023-04-28T09:47:38.869860  #
    2023-04-28T09:47:38.971232  / # export SHELL=3D/bin/sh. /lava-3540178/e=
nvironment
    2023-04-28T09:47:38.971828  =

    2023-04-28T09:47:39.073623  / # . /lava-3540178/environment/lava-354017=
8/bin/lava-test-runner /lava-3540178/1
    2023-04-28T09:47:39.074353  =

    2023-04-28T09:47:39.078890  / # /lava-3540178/bin/lava-test-runner /lav=
a-3540178/1
    2023-04-28T09:47:39.145703  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
