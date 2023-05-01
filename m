Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BCA6F2E4B
	for <lists+stable@lfdr.de>; Mon,  1 May 2023 06:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjEAECS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 1 May 2023 00:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjEAEBt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 1 May 2023 00:01:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D98BE48
        for <stable@vger.kernel.org>; Sun, 30 Apr 2023 20:56:32 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b67a26069so2495869b3a.0
        for <stable@vger.kernel.org>; Sun, 30 Apr 2023 20:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682913391; x=1685505391;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Frkz8Yn3nqka4e764aYz1uV9IgBTbvmmNv4kDCc9I4s=;
        b=uCdw+N+e5frTJy8AaynKkfoHzSXvrsZI34gSlB1w9McXycZ2rW/P6FxKpYgiNHgae8
         7OzuSzEA2tOYPb0dGev7AUbkcbdAciA48pJhzOOUCWUoJyCc7tj6Wy27ZGdJhqpZACaW
         nYmGIPaq5MbeCEc75jNM1wPZ49fQIjUJttU7w0825K5G7t9dEmUhli+7DtpvNQwvpJqK
         1vaF242ImsttiOnDKUWZK1Qv4C0sak5Gdwr2bgZyKY9hOh56jza7sveOvbV4ni2UQEwc
         unjCUxIwUSq3VAZeYQ1z2t/WW8WkvRfNlWrM3R3YuISqugKyfCLNtyIa/uVrrqR8I0ic
         StHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682913391; x=1685505391;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Frkz8Yn3nqka4e764aYz1uV9IgBTbvmmNv4kDCc9I4s=;
        b=GMcj4d9fefTXyV18Peec2UQt+iTty1KRVyad1Gout20XwfPXOjrDdWWzdIY6nluoi6
         XH0b4mQeW+niB+G34aejscXvogX+H2/c4zmUIC/vPFH7V5lK4xi0WRYEYe0/1dL25OhY
         NXu2rVWqzh2KJxE4wqmwiNLN3fj6uPSIDtjZhwvmdFclqMit5W9XlF/tRDC55edihmcP
         q9G/lsmUNt+VKwRMtNEpb8vMVHW1Ypf/gJMo2tE2T6ZsZ5wsItgGV49B0O2M92a1blrb
         GzS4JFBkFQjSt+3+MXF0lrWj3JeCjCLho2kAyZaUvzox5Zh4T2XJmRK2xJDHC3bmOGol
         lltg==
X-Gm-Message-State: AC+VfDywwXZuTf1AfAW22YfZ3+u/XFjFwg+OYY8Fe03nA0mMgAKLjCMP
        3r/6HIN3NJjpuczQPrq8KbH6HYMgES6oygrjO/A=
X-Google-Smtp-Source: ACHHUZ5Z1XdJFwh4RDk4gbqlCc+QYuB3+r4drhBtlR0HXemC4LI/bz8BdeRZVzxjSaFCM9zIbj+wzA==
X-Received: by 2002:a05:6a20:3947:b0:f6:7bb8:c8cc with SMTP id r7-20020a056a20394700b000f67bb8c8ccmr16085958pzg.41.1682913390973;
        Sun, 30 Apr 2023 20:56:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id co1-20020a17090afe8100b00247a09229besm5016478pjb.45.2023.04.30.20.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 20:56:30 -0700 (PDT)
Message-ID: <644f386e.170a0220.afd83.9414@mx.google.com>
Date:   Sun, 30 Apr 2023 20:56:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v5.15.110
X-Kernelci-Report-Type: test
Subject: stable/linux-5.15.y baseline: 224 runs, 18 regressions (v5.15.110)
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

stable/linux-5.15.y baseline: 224 runs, 18 regressions (v5.15.110)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.110/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.110
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      8a7f2a5c5aa1648edb4f2029c6ec33870afb7a95 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f023d726e4d7e892e8612

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f023d726e4d7e892e8617
        failing since 31 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-01T00:04:51.008069  + set +x

    2023-05-01T00:04:51.015252  <8>[   10.900868] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10163948_1.4.2.3.1>

    2023-05-01T00:04:51.119348  / # #

    2023-05-01T00:04:51.219978  export SHELL=3D/bin/sh

    2023-05-01T00:04:51.220147  #

    2023-05-01T00:04:51.320635  / # export SHELL=3D/bin/sh. /lava-10163948/=
environment

    2023-05-01T00:04:51.320794  =


    2023-05-01T00:04:51.421316  / # . /lava-10163948/environment/lava-10163=
948/bin/lava-test-runner /lava-10163948/1

    2023-05-01T00:04:51.421571  =


    2023-05-01T00:04:51.427391  / # /lava-10163948/bin/lava-test-runner /la=
va-10163948/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/644f05d462f3c2d4d52e866f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f05d462f3c2d4d52e8674
        failing since 31 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-01T00:20:29.212516  + set +x

    2023-05-01T00:20:29.219494  <8>[   11.721630] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10164093_1.4.2.3.1>

    2023-05-01T00:20:29.323709  / # #

    2023-05-01T00:20:29.424393  export SHELL=3D/bin/sh

    2023-05-01T00:20:29.424577  #

    2023-05-01T00:20:29.525044  / # export SHELL=3D/bin/sh. /lava-10164093/=
environment

    2023-05-01T00:20:29.525297  =


    2023-05-01T00:20:29.625877  / # . /lava-10164093/environment/lava-10164=
093/bin/lava-test-runner /lava-10164093/1

    2023-05-01T00:20:29.626144  =


    2023-05-01T00:20:29.632270  / # /lava-10164093/bin/lava-test-runner /la=
va-10164093/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f01b2f0877369382e8623

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f01b2f0877369382e8628
        failing since 31 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-01T00:02:35.239221  + set<8>[    8.888778] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10163901_1.4.2.3.1>

    2023-05-01T00:02:35.239781   +x

    2023-05-01T00:02:35.346947  / # #

    2023-05-01T00:02:35.449193  export SHELL=3D/bin/sh

    2023-05-01T00:02:35.449866  #

    2023-05-01T00:02:35.551272  / # export SHELL=3D/bin/sh. /lava-10163901/=
environment

    2023-05-01T00:02:35.552020  =


    2023-05-01T00:02:35.653527  / # . /lava-10163901/environment/lava-10163=
901/bin/lava-test-runner /lava-10163901/1

    2023-05-01T00:02:35.654852  =


    2023-05-01T00:02:35.659700  / # /lava-10163901/bin/lava-test-runner /la=
va-10163901/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/644f05e9039cd9a4722e85f9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f05e9039cd9a4722e85fe
        failing since 31 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-01T00:20:46.269692  + <8>[   11.828439] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10164074_1.4.2.3.1>

    2023-05-01T00:20:46.270320  set +x

    2023-05-01T00:20:46.378413  / # #

    2023-05-01T00:20:46.481014  export SHELL=3D/bin/sh

    2023-05-01T00:20:46.481815  #

    2023-05-01T00:20:46.583710  / # export SHELL=3D/bin/sh. /lava-10164074/=
environment

    2023-05-01T00:20:46.584518  =


    2023-05-01T00:20:46.686175  / # . /lava-10164074/environment/lava-10164=
074/bin/lava-test-runner /lava-10164074/1

    2023-05-01T00:20:46.687454  =


    2023-05-01T00:20:46.692279  / # /lava-10164074/bin/lava-test-runner /la=
va-10164074/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f019c33965e4a6e2e8607

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f019c33965e4a6e2e860c
        failing since 31 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-01T00:02:21.577129  <8>[   10.286878] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10163893_1.4.2.3.1>

    2023-05-01T00:02:21.580586  + set +x

    2023-05-01T00:02:21.687299  =


    2023-05-01T00:02:21.789336  / # #export SHELL=3D/bin/sh

    2023-05-01T00:02:21.790110  =


    2023-05-01T00:02:21.891648  / # export SHELL=3D/bin/sh. /lava-10163893/=
environment

    2023-05-01T00:02:21.892458  =


    2023-05-01T00:02:21.994233  / # . /lava-10163893/environment/lava-10163=
893/bin/lava-test-runner /lava-10163893/1

    2023-05-01T00:02:21.995678  =


    2023-05-01T00:02:22.000716  / # /lava-10163893/bin/lava-test-runner /la=
va-10163893/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/644f05d0c872c585832e861e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f05d0c872c585832e8623
        failing since 31 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-01T00:20:23.642814  <8>[   10.761099] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10164107_1.4.2.3.1>

    2023-05-01T00:20:23.645777  + set +x

    2023-05-01T00:20:23.746958  #

    2023-05-01T00:20:23.847751  / # #export SHELL=3D/bin/sh

    2023-05-01T00:20:23.847908  =


    2023-05-01T00:20:23.948421  / # export SHELL=3D/bin/sh. /lava-10164107/=
environment

    2023-05-01T00:20:23.948584  =


    2023-05-01T00:20:24.049078  / # . /lava-10164107/environment/lava-10164=
107/bin/lava-test-runner /lava-10164107/1

    2023-05-01T00:20:24.049340  =


    2023-05-01T00:20:24.054469  / # /lava-10164107/bin/lava-test-runner /la=
va-10164107/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644f0479c35757b49b2e8672

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644f0479c35757b49b2e8=
673
        failing since 25 days (last pass: v5.15.105, first fail: v5.15.106) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
cubietruck                   | arm    | lab-baylibre  | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/644f04014abb6b54352e85ed

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f04014abb6b54352e85f2
        failing since 102 days (last pass: v5.15.82, first fail: v5.15.89)

    2023-05-01T00:12:35.118492  <8>[    9.976380] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3544720_1.5.2.4.1>
    2023-05-01T00:12:35.229447  / # #
    2023-05-01T00:12:35.333441  export SHELL=3D/bin/sh
    2023-05-01T00:12:35.334621  #
    2023-05-01T00:12:35.436978  / # export SHELL=3D/bin/sh. /lava-3544720/e=
nvironment
    2023-05-01T00:12:35.438199  =

    2023-05-01T00:12:35.540542  / # . /lava-3544720/environment/lava-354472=
0/bin/lava-test-runner /lava-3544720/1
    2023-05-01T00:12:35.542343  =

    2023-05-01T00:12:35.542814  / # <3>[   10.352697] Bluetooth: hci0: comm=
and 0xfc18 tx timeout
    2023-05-01T00:12:35.547579  /lava-3544720/bin/lava-test-runner /lava-35=
44720/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f01b2f0877369382e8618

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f01b2f0877369382e861d
        failing since 31 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-01T00:02:38.034340  + set +x

    2023-05-01T00:02:38.040955  <8>[   10.741196] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10163936_1.4.2.3.1>

    2023-05-01T00:02:38.145412  / # #

    2023-05-01T00:02:38.246099  export SHELL=3D/bin/sh

    2023-05-01T00:02:38.246289  #

    2023-05-01T00:02:38.346773  / # export SHELL=3D/bin/sh. /lava-10163936/=
environment

    2023-05-01T00:02:38.347022  =


    2023-05-01T00:02:38.447529  / # . /lava-10163936/environment/lava-10163=
936/bin/lava-test-runner /lava-10163936/1

    2023-05-01T00:02:38.447869  =


    2023-05-01T00:02:38.452826  / # /lava-10163936/bin/lava-test-runner /la=
va-10163936/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/644f05c8e40df9eea02e85fc

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f05c8e40df9eea02e8601
        failing since 31 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-01T00:20:07.041685  + set<8>[   12.614912] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10164085_1.4.2.3.1>

    2023-05-01T00:20:07.041768   +x

    2023-05-01T00:20:07.145753  / # #

    2023-05-01T00:20:07.246313  export SHELL=3D/bin/sh

    2023-05-01T00:20:07.246495  #

    2023-05-01T00:20:07.346962  / # export SHELL=3D/bin/sh. /lava-10164085/=
environment

    2023-05-01T00:20:07.347219  =


    2023-05-01T00:20:07.447795  / # . /lava-10164085/environment/lava-10164=
085/bin/lava-test-runner /lava-10164085/1

    2023-05-01T00:20:07.448057  =


    2023-05-01T00:20:07.452784  / # /lava-10164085/bin/lava-test-runner /la=
va-10164085/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f019f33965e4a6e2e8621

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f019f33965e4a6e2e8626
        failing since 31 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-01T00:02:26.999748  <8>[   11.541954] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10163879_1.4.2.3.1>

    2023-05-01T00:02:27.003069  + set +x

    2023-05-01T00:02:27.104318  #

    2023-05-01T00:02:27.104612  =


    2023-05-01T00:02:27.205192  / # #export SHELL=3D/bin/sh

    2023-05-01T00:02:27.205401  =


    2023-05-01T00:02:27.305879  / # export SHELL=3D/bin/sh. /lava-10163879/=
environment

    2023-05-01T00:02:27.306122  =


    2023-05-01T00:02:27.406634  / # . /lava-10163879/environment/lava-10163=
879/bin/lava-test-runner /lava-10163879/1

    2023-05-01T00:02:27.406926  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/644f05bae40df9eea02e85e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f05bae40df9eea02e85ee
        failing since 31 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-01T00:20:04.101891  + set<8>[   11.945957] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10164075_1.4.2.3.1>

    2023-05-01T00:20:04.102525   +x

    2023-05-01T00:20:04.210116  #

    2023-05-01T00:20:04.211096  =


    2023-05-01T00:20:04.312776  / # #export SHELL=3D/bin/sh

    2023-05-01T00:20:04.313441  =


    2023-05-01T00:20:04.414760  / # export SHELL=3D/bin/sh. /lava-10164075/=
environment

    2023-05-01T00:20:04.415463  =


    2023-05-01T00:20:04.517022  / # . /lava-10164075/environment/lava-10164=
075/bin/lava-test-runner /lava-10164075/1

    2023-05-01T00:20:04.518057  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f01bb8983baea3c2e8624

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f01bb8983baea3c2e8629
        failing since 31 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-01T00:02:58.405569  + <8>[   10.786373] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10163917_1.4.2.3.1>

    2023-05-01T00:02:58.406046  set +x

    2023-05-01T00:02:58.513828  / # #

    2023-05-01T00:02:58.616409  export SHELL=3D/bin/sh

    2023-05-01T00:02:58.617206  #

    2023-05-01T00:02:58.718829  / # export SHELL=3D/bin/sh. /lava-10163917/=
environment

    2023-05-01T00:02:58.719680  =


    2023-05-01T00:02:58.821356  / # . /lava-10163917/environment/lava-10163=
917/bin/lava-test-runner /lava-10163917/1

    2023-05-01T00:02:58.822613  =


    2023-05-01T00:02:58.827959  / # /lava-10163917/bin/lava-test-runner /la=
va-10163917/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/644f05c8d8daf9b3962e86d6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f05c8d8daf9b3962e86db
        failing since 31 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-01T00:20:15.976022  + <8>[   11.968294] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10164090_1.4.2.3.1>

    2023-05-01T00:20:15.976496  set +x

    2023-05-01T00:20:16.084118  / # #

    2023-05-01T00:20:16.186498  export SHELL=3D/bin/sh

    2023-05-01T00:20:16.187315  #

    2023-05-01T00:20:16.289110  / # export SHELL=3D/bin/sh. /lava-10164090/=
environment

    2023-05-01T00:20:16.289912  =


    2023-05-01T00:20:16.391531  / # . /lava-10164090/environment/lava-10164=
090/bin/lava-test-runner /lava-10164090/1

    2023-05-01T00:20:16.392773  =


    2023-05-01T00:20:16.398143  / # /lava-10164090/bin/lava-test-runner /la=
va-10164090/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644f01a2b78fc1d3c02e85fb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f01a2b78fc1d3c02e8600
        failing since 31 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-01T00:02:30.148015  + set<8>[   11.342910] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10163895_1.4.2.3.1>

    2023-05-01T00:02:30.148560   +x

    2023-05-01T00:02:30.256848  / # #

    2023-05-01T00:02:30.359179  export SHELL=3D/bin/sh

    2023-05-01T00:02:30.359504  #

    2023-05-01T00:02:30.460331  / # export SHELL=3D/bin/sh. /lava-10163895/=
environment

    2023-05-01T00:02:30.461133  =


    2023-05-01T00:02:30.562956  / # . /lava-10163895/environment/lava-10163=
895/bin/lava-test-runner /lava-10163895/1

    2023-05-01T00:02:30.564221  =


    2023-05-01T00:02:30.568976  / # /lava-10163895/bin/lava-test-runner /la=
va-10163895/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/644f05d910244fdd172e862b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora/basel=
ine-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f05d910244fdd172e8630
        failing since 31 days (last pass: v5.15.104, first fail: v5.15.105)

    2023-05-01T00:20:17.506185  + <8>[   12.981626] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10164108_1.4.2.3.1>

    2023-05-01T00:20:17.506272  set +x

    2023-05-01T00:20:17.610625  / # #

    2023-05-01T00:20:17.711263  export SHELL=3D/bin/sh

    2023-05-01T00:20:17.711475  #

    2023-05-01T00:20:17.812019  / # export SHELL=3D/bin/sh. /lava-10164108/=
environment

    2023-05-01T00:20:17.812241  =


    2023-05-01T00:20:17.912781  / # . /lava-10164108/environment/lava-10164=
108/bin/lava-test-runner /lava-10164108/1

    2023-05-01T00:20:17.913059  =


    2023-05-01T00:20:17.917695  / # /lava-10164108/bin/lava-test-runner /la=
va-10164108/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/644f03b5b1077d9ba72e85f4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
arm64/defconfig+arm64-chromebook+kselftest/gcc-10/lab-collabora/baseline-mt=
8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644f03b5b1077d9ba72e8=
5f5
        failing since 96 days (last pass: v5.15.89, first fail: v5.15.90) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3328-rock64                | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/644f076c815163f2652e8613

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.110/=
arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644f076c815163f2652e8618
        new failure (last pass: v5.15.71)

    2023-05-01T00:27:15.541820  [   16.038050] <LAVA_SIGNAL_ENDRUN 0_dmesg =
3544779_1.5.2.4.1>
    2023-05-01T00:27:15.646668  =

    2023-05-01T00:27:15.646945  / # [   16.066081] rockchip-drm display-sub=
system: [drm] Cannot find any crtc or sizes
    2023-05-01T00:27:15.748579  #export SHELL=3D/bin/sh
    2023-05-01T00:27:15.749082  =

    2023-05-01T00:27:15.850586  / # export SHELL=3D/bin/sh. /lava-3544779/e=
nvironment
    2023-05-01T00:27:15.850958  =

    2023-05-01T00:27:15.951968  / # . /lava-3544779/environment/lava-354477=
9/bin/lava-test-runner /lava-3544779/1
    2023-05-01T00:27:15.952540  =

    2023-05-01T00:27:15.955184  / # /lava-3544779/bin/lava-test-runner /lav=
a-3544779/1 =

    ... (13 line(s) more)  =

 =20
