Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD02477AF82
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 04:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjHNCXp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 22:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjHNCXX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 22:23:23 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C9F130
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 19:23:21 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bcd4b5ebbaso3460557a34.1
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 19:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691979800; x=1692584600;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=17EXNgJ5vlref2YfpdWU+HbJu1vXi2IWNi4iLv7DsY0=;
        b=C1PQ9CEjTlxJmU8VhKdhlNkR4fZWCa2+QeyZqzTO+jzc1c4JoTSgkYfXItNGo1D+i2
         76BLc8qHsteEQjR4ScY+RdW8fDKoK21T4LnPsWfvVznP4Y3HdNVyJ5R/AMMAT38mag9h
         fZCNIIDybWIUb/UGOs2XabblCn6uUwxnAUZ+VlV6yf4jakQgkl0+r2V42lNlEkGgvng6
         UASkr2qr/2xvDDihnUHn599/yAfdwAQr/ZhHYDYhLYVi7soYlqmpBYIe4Z1dVYDfrooT
         LYBl48fapmT2AsdweQTZ0w4byA8vaXUpKlf9lGfYQS/p9WuBDLbnMgh9uss54WG30bcN
         7k8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691979800; x=1692584600;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17EXNgJ5vlref2YfpdWU+HbJu1vXi2IWNi4iLv7DsY0=;
        b=IMaQWcWFe/qiZWqkQyVY2aISIRbhxNFXR7rX7t4MdwOhU7DJNMAknoPs9m6tEfQbDF
         9z8uzOmNazsZ844dk6cWtszHsrgwzDalfTqQdv6/gOTyx+i7eAZS2PtmwDx2JXI6xwwl
         jhy0ycBh0MaBmLaMDqKUno0FHlYNtptFpwI1Kg1rXtunCBQEI7Eay1krEIvZmzWsOAF3
         XM4JCHPIt9DmxUj3msuk0iWGn8HJfy8HF0woqRyh/Qkb5BI42WjhZsHnfMCmeuR4YYCZ
         ynfDJHewi+nsYUWhOGFWNHKBh9qO8j0GboLBtIA60lpGeu2v7qUnEhx8y0YJZe4+h6IY
         vFhA==
X-Gm-Message-State: AOJu0YwbLyFbHQ5Ub/IgTXx1b8H11gNsqgKdHVxfUtM4JMu5C2NSZbpO
        1ILuflv7zFlkLYwSCwHbGC3HQWHQ1i3fgpGQFmUKbwrl
X-Google-Smtp-Source: AGHT+IF9+YUeUWO1DsBC4n4UU026DCfN5QLaWDUlUMN2BMq17qHhClYOlPojkROh0uOfSUFnvLYIhA==
X-Received: by 2002:a05:6830:1683:b0:6bc:8cd2:dd9c with SMTP id k3-20020a056830168300b006bc8cd2dd9cmr7457413otr.36.1691979800445;
        Sun, 13 Aug 2023 19:23:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id pj1-20020a17090b4f4100b002696bd123e4sm6862630pjb.46.2023.08.13.19.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 19:23:19 -0700 (PDT)
Message-ID: <64d99017.170a0220.7729e.b813@mx.google.com>
Date:   Sun, 13 Aug 2023 19:23:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.45-150-gdbb92b2240ba
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y baseline: 125 runs,
 11 regressions (v6.1.45-150-gdbb92b2240ba)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y baseline: 125 runs, 11 regressions (v6.1.45-150-gdbb9=
2b2240ba)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.45-150-gdbb92b2240ba/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.45-150-gdbb92b2240ba
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      dbb92b2240baeb83c338da3c22ea784f13375059 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d95ac18612ac9af535b1ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d95ac18612ac9af535b=
1ed
        new failure (last pass: v6.1.45-128-ge73191cf0a0b2) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d95a8094ee36674635b22e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d95a8094ee36674635b233
        failing since 136 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-13T22:34:40.870748  + set +x

    2023-08-13T22:34:40.877677  <8>[   10.372032] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11280414_1.4.2.3.1>

    2023-08-13T22:34:40.979953  #

    2023-08-13T22:34:41.080917  / # #export SHELL=3D/bin/sh

    2023-08-13T22:34:41.081161  =


    2023-08-13T22:34:41.181732  / # export SHELL=3D/bin/sh. /lava-11280414/=
environment

    2023-08-13T22:34:41.181948  =


    2023-08-13T22:34:41.282449  / # . /lava-11280414/environment/lava-11280=
414/bin/lava-test-runner /lava-11280414/1

    2023-08-13T22:34:41.282741  =


    2023-08-13T22:34:41.288845  / # /lava-11280414/bin/lava-test-runner /la=
va-11280414/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d95a8694ee36674635b27d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d95a8694ee36674635b282
        failing since 136 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-13T22:34:29.740581  + <8>[   11.612526] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11280406_1.4.2.3.1>

    2023-08-13T22:34:29.741006  set +x

    2023-08-13T22:34:29.848150  / # #

    2023-08-13T22:34:29.950417  export SHELL=3D/bin/sh

    2023-08-13T22:34:29.951252  #

    2023-08-13T22:34:30.052801  / # export SHELL=3D/bin/sh. /lava-11280406/=
environment

    2023-08-13T22:34:30.053602  =


    2023-08-13T22:34:30.155325  / # . /lava-11280406/environment/lava-11280=
406/bin/lava-test-runner /lava-11280406/1

    2023-08-13T22:34:30.156681  =


    2023-08-13T22:34:30.161517  / # /lava-11280406/bin/lava-test-runner /la=
va-11280406/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d95a906bb62ec06f35b206

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d95a906bb62ec06f35b20b
        failing since 136 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-13T22:34:36.141273  <8>[   10.424829] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11280410_1.4.2.3.1>

    2023-08-13T22:34:36.144641  + set +x

    2023-08-13T22:34:36.246038  =


    2023-08-13T22:34:36.346618  / # #export SHELL=3D/bin/sh

    2023-08-13T22:34:36.346772  =


    2023-08-13T22:34:36.447289  / # export SHELL=3D/bin/sh. /lava-11280410/=
environment

    2023-08-13T22:34:36.447438  =


    2023-08-13T22:34:36.547958  / # . /lava-11280410/environment/lava-11280=
410/bin/lava-test-runner /lava-11280410/1

    2023-08-13T22:34:36.548190  =


    2023-08-13T22:34:36.552822  / # /lava-11280410/bin/lava-test-runner /la=
va-11280410/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d95f94f6440b327935b201

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d95f94f6440b327935b=
202
        failing since 67 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d95a74d68493c92935b201

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d95a74d68493c92935b206
        failing since 136 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-13T22:34:18.299707  + set +x

    2023-08-13T22:34:18.305763  <8>[   10.520115] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11280403_1.4.2.3.1>

    2023-08-13T22:34:18.410601  / # #

    2023-08-13T22:34:18.511266  export SHELL=3D/bin/sh

    2023-08-13T22:34:18.511507  #

    2023-08-13T22:34:18.611983  / # export SHELL=3D/bin/sh. /lava-11280403/=
environment

    2023-08-13T22:34:18.612163  =


    2023-08-13T22:34:18.712642  / # . /lava-11280403/environment/lava-11280=
403/bin/lava-test-runner /lava-11280403/1

    2023-08-13T22:34:18.712906  =


    2023-08-13T22:34:18.717629  / # /lava-11280403/bin/lava-test-runner /la=
va-11280403/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d95a7d94ee36674635b218

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d95a7d94ee36674635b21d
        failing since 136 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-13T22:34:20.606788  + set<8>[   11.542358] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11280380_1.4.2.3.1>

    2023-08-13T22:34:20.607381   +x

    2023-08-13T22:34:20.715519  / # #

    2023-08-13T22:34:20.817989  export SHELL=3D/bin/sh

    2023-08-13T22:34:20.818885  #

    2023-08-13T22:34:20.920639  / # export SHELL=3D/bin/sh. /lava-11280380/=
environment

    2023-08-13T22:34:20.921427  =


    2023-08-13T22:34:21.023174  / # . /lava-11280380/environment/lava-11280=
380/bin/lava-test-runner /lava-11280380/1

    2023-08-13T22:34:21.024380  =


    2023-08-13T22:34:21.029851  / # /lava-11280380/bin/lava-test-runner /la=
va-11280380/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d95a8894ee36674635b28b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d95a8894ee36674635b290
        failing since 136 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-13T22:34:28.690126  + <8>[   11.308292] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11280382_1.4.2.3.1>

    2023-08-13T22:34:28.690209  set +x

    2023-08-13T22:34:28.794505  / # #

    2023-08-13T22:34:28.895048  export SHELL=3D/bin/sh

    2023-08-13T22:34:28.895221  #

    2023-08-13T22:34:28.995681  / # export SHELL=3D/bin/sh. /lava-11280382/=
environment

    2023-08-13T22:34:28.995858  =


    2023-08-13T22:34:29.096370  / # . /lava-11280382/environment/lava-11280=
382/bin/lava-test-runner /lava-11280382/1

    2023-08-13T22:34:29.096625  =


    2023-08-13T22:34:29.101393  / # /lava-11280382/bin/lava-test-runner /la=
va-11280382/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d95b3b283c4d549135b25f

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d95b3b283c4d549135b264
        failing since 27 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-13T22:39:19.246439  / # #

    2023-08-13T22:39:19.348537  export SHELL=3D/bin/sh

    2023-08-13T22:39:19.349231  #

    2023-08-13T22:39:19.450545  / # export SHELL=3D/bin/sh. /lava-11280435/=
environment

    2023-08-13T22:39:19.451253  =


    2023-08-13T22:39:19.552714  / # . /lava-11280435/environment/lava-11280=
435/bin/lava-test-runner /lava-11280435/1

    2023-08-13T22:39:19.553838  =


    2023-08-13T22:39:19.570438  / # /lava-11280435/bin/lava-test-runner /la=
va-11280435/1

    2023-08-13T22:39:19.618872  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-13T22:39:19.619361  + cd /lav<8>[   19.100844] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11280435_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d95b692eac29562535b230

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d95b692eac29562535b235
        failing since 27 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-13T22:39:02.237562  / # #

    2023-08-13T22:39:03.315046  export SHELL=3D/bin/sh

    2023-08-13T22:39:03.316339  #

    2023-08-13T22:39:04.803769  / # export SHELL=3D/bin/sh. /lava-11280432/=
environment

    2023-08-13T22:39:04.805642  =


    2023-08-13T22:39:07.530528  / # . /lava-11280432/environment/lava-11280=
432/bin/lava-test-runner /lava-11280432/1

    2023-08-13T22:39:07.532872  =


    2023-08-13T22:39:07.547616  / # /lava-11280432/bin/lava-test-runner /la=
va-11280432/1

    2023-08-13T22:39:07.600675  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-13T22:39:07.601191  + cd /lava-112804<8>[   28.469967] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11280432_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d95b4f551e974d2b35b1da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.45-=
150-gdbb92b2240ba/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d95b4f551e974d2b35b1df
        failing since 27 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-13T22:39:31.629071  / # #

    2023-08-13T22:39:31.731265  export SHELL=3D/bin/sh

    2023-08-13T22:39:31.731973  #

    2023-08-13T22:39:31.833446  / # export SHELL=3D/bin/sh. /lava-11280426/=
environment

    2023-08-13T22:39:31.834157  =


    2023-08-13T22:39:31.935587  / # . /lava-11280426/environment/lava-11280=
426/bin/lava-test-runner /lava-11280426/1

    2023-08-13T22:39:31.936711  =


    2023-08-13T22:39:31.953248  / # /lava-11280426/bin/lava-test-runner /la=
va-11280426/1

    2023-08-13T22:39:32.019126  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-13T22:39:32.019634  + cd /lava-1128042<8>[   16.988068] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11280426_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
