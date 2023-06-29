Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E64F7430D9
	for <lists+stable@lfdr.de>; Fri, 30 Jun 2023 01:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjF2XEh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 19:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2XEg (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 19:04:36 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4452D7F
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 16:04:35 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a0423ea749so885483b6e.0
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 16:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688079874; x=1690671874;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DwodCGzutQqLtzlVVwU6QxNQID+knOAEhL9+Z+qErx8=;
        b=ZQUPtiQCTLtcnmlB83WEsW2gnQVuaDQegTGPQrvgSz+G7oOlmJDXLHkUn8o37+Sbov
         hraWhqSSzVcgnJKXkkpALK1fZB+mFjhtXP0EsVH/pCdA53H9bey3B8giwd3B/p/262H0
         na7KI1CQK9RuAsVwX1YygCOCM3GqVIqYOaijfs0xjcx9PH4UsmeMj5WhzmQfo+AXq3Eh
         u7mI3Rz4odSlA8I5M+eCPO+Sp7WGmr3HBBlDQ5ttplzjVNNnOYOD7DCzpivAsrXhapzE
         ifeuHpUhGvJXTUVlFkZkDR9/wQfR5ockIk3pFQCfNlBDuSIqwhd3LcK7rhzVKDFkX2Uc
         382A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688079874; x=1690671874;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwodCGzutQqLtzlVVwU6QxNQID+knOAEhL9+Z+qErx8=;
        b=gbJWWxrh6aGBnpT6kdlkiCWiw0lew7UzeKXc/SyJrJ4hJMxzkdDnmvJthsOoDL9cjZ
         Ez+0xn8rqYNklb27BEQa1TWMsO0WWb+7PEnYAlpndFYj9VoRpdTkJHVoV6hpknVW1Ny+
         XMM8Zr6malXaSkZ9hKzAb7cQzmO7HcbKgZqJno0XxdCIyIjg0mLUiYC+c30Kly9JHm+X
         kIdOY3pcfa643UyLTiarCJv6SA0FqxYMRcbtn8Un18IIUFdX7rS7zL3XDw8scvKtbVdA
         TjkwrZFpvMGUlp/XoFbDzQz9oPYKstT/eyhc/mpxMo4+eEGXjxuuv5qVXGgEQidjeawd
         rccg==
X-Gm-Message-State: AC+VfDxTVqBKBJ8Ts0SxVJm28xRmJhTT+aPCRuJqVEqcyLLJcGWGK7RQ
        X8PDeexqYxnLnQRWW1XkCcnVQfFD8+hA650Dh4ax4g==
X-Google-Smtp-Source: ACHHUZ4arwXrrFzU0tNgAE/TX68EBygwFyXl4V7ULxJP9kaJhRHIJB8nCgcM2TUT9bUaYPXdzizN+Q==
X-Received: by 2002:a05:6808:5c7:b0:3a3:7adc:dec7 with SMTP id d7-20020a05680805c700b003a37adcdec7mr801629oij.38.1688079874002;
        Thu, 29 Jun 2023 16:04:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x14-20020aa784ce000000b00674364577dasm7418923pfn.203.2023.06.29.16.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 16:04:33 -0700 (PDT)
Message-ID: <649e0e01.a70a0220.18333.f4a9@mx.google.com>
Date:   Thu, 29 Jun 2023 16:04:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.186-9-g479d05f2ce65
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
Subject: stable-rc/linux-5.10.y baseline: 114 runs,
 5 regressions (v5.10.186-9-g479d05f2ce65)
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

stable-rc/linux-5.10.y baseline: 114 runs, 5 regressions (v5.10.186-9-g479d=
05f2ce65)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.186-9-g479d05f2ce65/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.186-9-g479d05f2ce65
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      479d05f2ce65df3c7c2ed2b9509c1aafc1a97095 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/649e05cc6936741bc4bb2a9a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-9-g479d05f2ce65/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-9-g479d05f2ce65/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-bea=
gle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649e05cc6936741bc4bb2=
a9b
        new failure (last pass: v5.10.185) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649e04507a83f1f1b8bb2a79

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-9-g479d05f2ce65/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-9-g479d05f2ce65/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubi=
etruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649e04507a83f1f1b8bb2a7e
        failing since 162 days (last pass: v5.10.158-107-gd2432186ff47, fir=
st fail: v5.10.162-852-geeaac3cf2eb3)

    2023-06-29T22:22:55.067659  <8>[   11.204507] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3700030_1.5.2.4.1>
    2023-06-29T22:22:55.174285  / # #
    2023-06-29T22:22:55.275758  export SHELL=3D/bin/sh
    2023-06-29T22:22:55.276499  #
    2023-06-29T22:22:55.378155  / # export SHELL=3D/bin/sh. /lava-3700030/e=
nvironment
    2023-06-29T22:22:55.378516  =

    2023-06-29T22:22:55.479684  / # . /lava-3700030/environment/lava-370003=
0/bin/lava-test-runner /lava-3700030/1
    2023-06-29T22:22:55.480608  =

    2023-06-29T22:22:55.484979  / # /lava-3700030/bin/lava-test-runner /lav=
a-3700030/1
    2023-06-29T22:22:55.570756  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649dd51eef06426c2bbb2a95

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-9-g479d05f2ce65/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-9-g479d05f2ce65/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649dd51eef06426c2bbb2a9a
        failing since 92 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-29T19:01:49.181474  + <8>[   10.512344] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10953656_1.4.2.3.1>

    2023-06-29T19:01:49.181854  set +x

    2023-06-29T19:01:49.286938  #

    2023-06-29T19:01:49.288059  =


    2023-06-29T19:01:49.389881  / # #export SHELL=3D/bin/sh

    2023-06-29T19:01:49.390605  =


    2023-06-29T19:01:49.492099  / # export SHELL=3D/bin/sh. /lava-10953656/=
environment

    2023-06-29T19:01:49.492915  =


    2023-06-29T19:01:49.594493  / # . /lava-10953656/environment/lava-10953=
656/bin/lava-test-runner /lava-10953656/1

    2023-06-29T19:01:49.595686  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649dd4dc4a5ab19c1cbb2aaa

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-9-g479d05f2ce65/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-9-g479d05f2ce65/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649dd4dd4a5ab19c1cbb2aaf
        failing since 92 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-06-29T19:00:29.709138  <8>[   11.369493] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10953661_1.4.2.3.1>

    2023-06-29T19:00:29.712508  + set +x

    2023-06-29T19:00:29.820944  / # #

    2023-06-29T19:00:29.923194  export SHELL=3D/bin/sh

    2023-06-29T19:00:29.923954  #

    2023-06-29T19:00:30.025182  / # export SHELL=3D/bin/sh. /lava-10953661/=
environment

    2023-06-29T19:00:30.025819  =


    2023-06-29T19:00:30.127053  / # . /lava-10953661/environment/lava-10953=
661/bin/lava-test-runner /lava-10953661/1

    2023-06-29T19:00:30.127795  =


    2023-06-29T19:00:30.133035  / # /lava-10953661/bin/lava-test-runner /la=
va-10953661/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/649dd742613ed6f445bb2abb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-9-g479d05f2ce65/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-i=
wg20d-q7.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
86-9-g479d05f2ce65/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7743-i=
wg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649dd742613ed6f445bb2=
abc
        failing since 0 day (last pass: v5.10.185, first fail: v5.10.186) =

 =20
