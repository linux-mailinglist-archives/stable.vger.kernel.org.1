Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31E5759EF3
	for <lists+stable@lfdr.de>; Wed, 19 Jul 2023 21:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjGSTtW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 19 Jul 2023 15:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjGSTtW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 19 Jul 2023 15:49:22 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65081BCF
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 12:49:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8ad907ba4so151315ad.0
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 12:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689796159; x=1692388159;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YAQMzy/70eRmQyuZDaYmDvMZumbif7d+1xQAH7JZ6HM=;
        b=BS4/UFBheblfEhZis9Eff5z508aOK/vO3WFI8qq6QEREZGl5UQO2u/+VLipdcS+oJL
         7ix9D9/7q1zYJAoPyRwVsTzExUWOX9SntxNlZ3KrvPeyns+RD0yAB+pPDBR/IgrgoYVS
         3UNjoj7f13n99jkyfILbA31O1+I5RAib/4w+wnPtDexkVCdcVBhpelDcDTnm8cbZyVpb
         k6+8v0WEteuAXz+dV+AwO2NrXnEvh/8WoOA6XJjqicnFOFIbIhc2XXpCK3d+h/xYfw0z
         hcZfKVSOPwo8puHXbwou/9qDCrGPzn7U1K3A33JxD47HdycwnsMvIJ6cRzXmvwAaFuq3
         c4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689796159; x=1692388159;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAQMzy/70eRmQyuZDaYmDvMZumbif7d+1xQAH7JZ6HM=;
        b=EUcm77qB9Oom1MaoSH9i4UScA/kgxKbqkowHbUS2O5t2+SfCpcqqjOw7fUriiVoIhQ
         zAfehzMa3UaqrVkjc0tRXxKCT2hk5GRDxGCFlfpzPWu2wAcX4EqTLASmO0urzQqtybw8
         mqH0JZWguN0m4eh6dgq/3WmMJ1UhUTJNpwJVarxiOO3pYiD3RxBXbD03sLzYs0Q55jyH
         5mNoSDS001pqow+hkfOs3eaFlCXXfmkhk6cv9D23ZLNdpSdFw/ugSQvnZ0vEuXMP1wbG
         rX7QTrrAVmaZFeReFAghDSOe6pm9h5BMD9Khdrh0JlaRpLTInwkWStRB63q0+l03P3zO
         Hp3Q==
X-Gm-Message-State: ABy/qLZJqUO0Es8DR1EyUdGsb+Km1/g8Tg4xrDeAwiFzbmwLZIwOTqF7
        mazO0retZbSz8e8KEj1w4uiR9S7uObqDlEMDwF9X5g==
X-Google-Smtp-Source: APBJJlGlnwdp3zdvdpLPiFaUHBdcjve+n4d/t30hcVb5AH0uf78P4JH9E+GkMFJRaw3ujAl4FanbWQ==
X-Received: by 2002:a17:903:18e:b0:1b7:f546:44d7 with SMTP id z14-20020a170903018e00b001b7f54644d7mr16319399plg.17.1689796158615;
        Wed, 19 Jul 2023 12:49:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b001b03cda6389sm4381233plf.10.2023.07.19.12.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:49:17 -0700 (PDT)
Message-ID: <64b83e3d.170a0220.cb1cc.9f63@mx.google.com>
Date:   Wed, 19 Jul 2023 12:49:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.39
X-Kernelci-Report-Type: test
Subject: stable/linux-6.1.y baseline: 161 runs, 11 regressions (v6.1.39)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-6.1.y baseline: 161 runs, 11 regressions (v6.1.39)

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

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.39/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.39
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      a456e17438819ed77f63d16926f96101ca215f09 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b80b7995676584dc8ace46

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C436=
FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b80b7995676584dc8ace4b
        failing since 111 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-19T16:12:42.716940  + set +x

    2023-07-19T16:12:42.723804  <8>[    7.999210] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11113069_1.4.2.3.1>

    2023-07-19T16:12:42.830092  #

    2023-07-19T16:12:42.831277  =


    2023-07-19T16:12:42.933081  / # #export SHELL=3D/bin/sh

    2023-07-19T16:12:42.933669  =


    2023-07-19T16:12:43.034983  / # export SHELL=3D/bin/sh. /lava-11113069/=
environment

    2023-07-19T16:12:43.035707  =


    2023-07-19T16:12:43.137106  / # . /lava-11113069/environment/lava-11113=
069/bin/lava-test-runner /lava-11113069/1

    2023-07-19T16:12:43.137983  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b80b8395676584dc8ace5e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-CM14=
00CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b80b8395676584dc8ace63
        failing since 111 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-19T16:12:44.979507  + set<8>[   10.994260] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11113098_1.4.2.3.1>

    2023-07-19T16:12:44.980086   +x

    2023-07-19T16:12:45.088071  / # #

    2023-07-19T16:12:45.190490  export SHELL=3D/bin/sh

    2023-07-19T16:12:45.191277  #

    2023-07-19T16:12:45.292720  / # export SHELL=3D/bin/sh. /lava-11113098/=
environment

    2023-07-19T16:12:45.293497  =


    2023-07-19T16:12:45.395451  / # . /lava-11113098/environment/lava-11113=
098/bin/lava-test-runner /lava-11113098/1

    2023-07-19T16:12:45.396712  =


    2023-07-19T16:12:45.401971  / # /lava-11113098/bin/lava-test-runner /la=
va-11113098/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b80b8062d12eb7ab8ace2c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-cx94=
00-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b80b8062d12eb7ab8ace31
        failing since 111 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-19T16:12:22.161296  <8>[   10.051905] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11113126_1.4.2.3.1>

    2023-07-19T16:12:22.164348  + set +x

    2023-07-19T16:12:22.265781  =


    2023-07-19T16:12:22.366427  / # #export SHELL=3D/bin/sh

    2023-07-19T16:12:22.366656  =


    2023-07-19T16:12:22.467160  / # export SHELL=3D/bin/sh. /lava-11113126/=
environment

    2023-07-19T16:12:22.467351  =


    2023-07-19T16:12:22.567901  / # . /lava-11113126/environment/lava-11113=
126/bin/lava-test-runner /lava-11113126/1

    2023-07-19T16:12:22.568226  =


    2023-07-19T16:12:22.573052  / # /lava-11113126/bin/lava-test-runner /la=
va-11113126/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b80b8e95676584dc8ace6b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
2b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b80b8e95676584dc8ace70
        failing since 111 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-19T16:12:41.814254  + set +x

    2023-07-19T16:12:41.821247  <8>[   10.414776] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11113046_1.4.2.3.1>

    2023-07-19T16:12:41.925972  / # #

    2023-07-19T16:12:42.026769  export SHELL=3D/bin/sh

    2023-07-19T16:12:42.027021  #

    2023-07-19T16:12:42.127621  / # export SHELL=3D/bin/sh. /lava-11113046/=
environment

    2023-07-19T16:12:42.127890  =


    2023-07-19T16:12:42.228485  / # . /lava-11113046/environment/lava-11113=
046/bin/lava-test-runner /lava-11113046/1

    2023-07-19T16:12:42.228851  =


    2023-07-19T16:12:42.233604  / # /lava-11113046/bin/lava-test-runner /la=
va-11113046/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b80b9990943c32418ace1e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b80b9990943c32418ace23
        failing since 111 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-19T16:12:51.756730  <8>[   10.015209] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11113043_1.4.2.3.1>

    2023-07-19T16:12:51.760342  + set +x

    2023-07-19T16:12:51.862144  =


    2023-07-19T16:12:51.962807  / # #export SHELL=3D/bin/sh

    2023-07-19T16:12:51.963041  =


    2023-07-19T16:12:52.063596  / # export SHELL=3D/bin/sh. /lava-11113043/=
environment

    2023-07-19T16:12:52.063842  =


    2023-07-19T16:12:52.164417  / # . /lava-11113043/environment/lava-11113=
043/bin/lava-test-runner /lava-11113043/1

    2023-07-19T16:12:52.164779  =


    2023-07-19T16:12:52.169487  / # /lava-11113043/bin/lava-test-runner /la=
va-11113043/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b80b6f95676584dc8ace3b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-1=
4a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b80b6f95676584dc8ace40
        failing since 111 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-19T16:12:14.009781  + <8>[   11.488966] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11113058_1.4.2.3.1>

    2023-07-19T16:12:14.009874  set +x

    2023-07-19T16:12:14.113840  / # #

    2023-07-19T16:12:14.214470  export SHELL=3D/bin/sh

    2023-07-19T16:12:14.214667  #

    2023-07-19T16:12:14.315190  / # export SHELL=3D/bin/sh. /lava-11113058/=
environment

    2023-07-19T16:12:14.315429  =


    2023-07-19T16:12:14.416025  / # . /lava-11113058/environment/lava-11113=
058/bin/lava-test-runner /lava-11113058/1

    2023-07-19T16:12:14.416369  =


    2023-07-19T16:12:14.420915  / # /lava-11113058/bin/lava-test-runner /la=
va-11113058/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b80b6595676584dc8ace2f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo-TP=
ad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b80b6595676584dc8ace34
        failing since 111 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-07-19T16:12:22.140915  + <8>[   11.712102] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11113107_1.4.2.3.1>

    2023-07-19T16:12:22.141009  set +x

    2023-07-19T16:12:22.244983  / # #

    2023-07-19T16:12:22.345612  export SHELL=3D/bin/sh

    2023-07-19T16:12:22.345786  #

    2023-07-19T16:12:22.446326  / # export SHELL=3D/bin/sh. /lava-11113107/=
environment

    2023-07-19T16:12:22.446516  =


    2023-07-19T16:12:22.547069  / # . /lava-11113107/environment/lava-11113=
107/bin/lava-test-runner /lava-11113107/1

    2023-07-19T16:12:22.547385  =


    2023-07-19T16:12:22.552268  / # /lava-11113107/bin/lava-test-runner /la=
va-11113107/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b809185d77cf12548ace1c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b809185d77cf12548ace21
        new failure (last pass: v6.1.38)

    2023-07-19T16:03:55.522553  / # #

    2023-07-19T16:03:55.624685  export SHELL=3D/bin/sh

    2023-07-19T16:03:55.625423  #

    2023-07-19T16:03:55.726829  / # export SHELL=3D/bin/sh. /lava-11112928/=
environment

    2023-07-19T16:03:55.727540  =


    2023-07-19T16:03:55.828976  / # . /lava-11112928/environment/lava-11112=
928/bin/lava-test-runner /lava-11112928/1

    2023-07-19T16:03:55.830067  =


    2023-07-19T16:03:55.847001  / # /lava-11112928/bin/lava-test-runner /la=
va-11112928/1

    2023-07-19T16:03:55.895212  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-19T16:03:55.895724  + cd /lav<8>[   19.077454] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11112928_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b80943f74204afc88ace2f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/arm=
64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b80943f74204afc88ace34
        new failure (last pass: v6.1.38)

    2023-07-19T16:02:51.905752  / # #

    2023-07-19T16:02:52.985141  export SHELL=3D/bin/sh

    2023-07-19T16:02:52.986907  #

    2023-07-19T16:02:54.476109  / # export SHELL=3D/bin/sh. /lava-11112918/=
environment

    2023-07-19T16:02:54.477874  =


    2023-07-19T16:02:57.200352  / # . /lava-11112918/environment/lava-11112=
918/bin/lava-test-runner /lava-11112918/1

    2023-07-19T16:02:57.202489  =


    2023-07-19T16:02:57.215665  / # /lava-11112918/bin/lava-test-runner /la=
va-11112918/1

    2023-07-19T16:02:57.231875  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-19T16:02:57.274981  + cd /lava-111129<8>[   28.465079] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11112918_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b8092b8bcb3edecc8ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/arm=
64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/arm=
64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b8092b8bcb3edecc8ace21
        new failure (last pass: v6.1.29)

    2023-07-19T16:02:35.962650  / # #
    2023-07-19T16:02:36.064349  export SHELL=3D/bin/sh
    2023-07-19T16:02:36.064721  #
    2023-07-19T16:02:36.166037  / # export SHELL=3D/bin/sh. /lava-3723109/e=
nvironment
    2023-07-19T16:02:36.166394  =

    2023-07-19T16:02:36.267733  / # . /lava-3723109/environment/lava-372310=
9/bin/lava-test-runner /lava-3723109/1
    2023-07-19T16:02:36.268342  =

    2023-07-19T16:02:36.273853  / # /lava-3723109/bin/lava-test-runner /lav=
a-3723109/1
    2023-07-19T16:02:36.345741  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-19T16:02:36.346226  + cd /lava-3723109<8>[   18.682096] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 3723109_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64b8092c5d77cf12548ace89

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.39/arm=
64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b8092c5d77cf12548ace8e
        new failure (last pass: v6.1.29)

    2023-07-19T16:04:07.434714  / # #

    2023-07-19T16:04:07.536801  export SHELL=3D/bin/sh

    2023-07-19T16:04:07.537536  #

    2023-07-19T16:04:07.638928  / # export SHELL=3D/bin/sh. /lava-11112927/=
environment

    2023-07-19T16:04:07.639633  =


    2023-07-19T16:04:07.741059  / # . /lava-11112927/environment/lava-11112=
927/bin/lava-test-runner /lava-11112927/1

    2023-07-19T16:04:07.742129  =


    2023-07-19T16:04:07.759301  / # /lava-11112927/bin/lava-test-runner /la=
va-11112927/1

    2023-07-19T16:04:07.825212  + export 'TESTRUN_ID=3D1_bootrr'

    2023-07-19T16:04:07.825722  + cd /lava-1111292<8>[   16.949323] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11112927_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
