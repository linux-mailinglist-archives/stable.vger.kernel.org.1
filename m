Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C346FC1D4
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 10:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjEIIjV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 04:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjEIIjU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 04:39:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE9059C1
        for <stable@vger.kernel.org>; Tue,  9 May 2023 01:39:17 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64395e2a715so5481966b3a.3
        for <stable@vger.kernel.org>; Tue, 09 May 2023 01:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683621557; x=1686213557;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8GpoR52za5g3ACUMCffHUF7s6W4JU4rarkGpL7+thxs=;
        b=4Hb7wT1Zyp5qyG/XHoVpIHlXhg4cCSNPiS3psaRK6vWNKcwQ6XLS42twqN99ZBYOGa
         iHihMz24T5xXeGIny9+6s0h2wnhSRKyE7X4FKQg+xpnOzX9sR2Gmha2AUNCpWTK8xfMR
         YzfWi9RrddKhnfpOcH5XLH7Fo54sIk0OeFBFrBzKzVaZNpPUnMtMbD4TxLwqmgBH+9lP
         c60GIq1vrMKiJWqj+MdzMQ4ndFH0cd0me3/FcaEX4OyJONqFWkLZk9MLft/YK+L+Soq/
         OOqjV1t1IGt74V8VdbNwo3jCuiL5SA4r3enhiRF1x23pbs//YX8q48fQk6d8vAstR6i0
         lnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683621557; x=1686213557;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8GpoR52za5g3ACUMCffHUF7s6W4JU4rarkGpL7+thxs=;
        b=KQEGTum7rbEqotKqOPQozSuNkJcie/CP/cBMXjEYbGAPZtEfcPNf1rFWGD6YSGPBD4
         /bUz/43c+ru1j0v8WRmn1GNoV2nlqkw88fUzAVWK/upVI5RpEMGjf9RWOjopOXmmybUI
         VC30Ept3Ls4GVjabtB9U9x3l03PbzJP+OfgHwYophTUjxTORfo/jpuCXCa28V+I7Ycfh
         h8j1nASkQjetey5kJqZHE6rPswqYcW1r1ukge7XUxM89IWEAnv5FU30Kun3p7yCI6f5r
         JkmfjNqaSrvyu/7hCHnKDor94Ov2da4ScwvBq0KGwis10PQ0Q0a0S3qH944V4jVOX+lJ
         /wZQ==
X-Gm-Message-State: AC+VfDylwFwzTE6no/FmsqR6/u+qqEQkcti04+FRv3cFQfAXA5vn1BDk
        XYCHhsOph6qZp6wxy6WCvw5EW7u9a/QGcDa1SzrHVw==
X-Google-Smtp-Source: ACHHUZ7HFwPzDgc2Hlpu3Xhiu9NUivOJpnYt9qk00iTO9NrXmatIV+34cJn0ZbusKZ9f9ISNYGaQHQ==
X-Received: by 2002:a05:6a20:9e91:b0:ee:ac3c:d2de with SMTP id mq17-20020a056a209e9100b000eeac3cd2demr13884092pzb.28.1683621556723;
        Tue, 09 May 2023 01:39:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q17-20020a62ae11000000b0063b8ce0e860sm1272002pff.21.2023.05.09.01.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 01:39:16 -0700 (PDT)
Message-ID: <645a06b4.620a0220.e2d74.2fee@mx.google.com>
Date:   Tue, 09 May 2023 01:39:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-1201-gc4ffdce6b0d1
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 162 runs,
 11 regressions (v6.1.22-1201-gc4ffdce6b0d1)
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

stable-rc/queue/6.1 baseline: 162 runs, 11 regressions (v6.1.22-1201-gc4ffd=
ce6b0d1)

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

mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =

qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.22-1201-gc4ffdce6b0d1/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.22-1201-gc4ffdce6b0d1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      c4ffdce6b0d1ef008198bf5321b55dd41bd0cae8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459d0a8cbbea6aee02e85fd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459d0a8cbbea6aee02e8602
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T04:48:20.942594  <8>[   10.253080] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10249976_1.4.2.3.1>

    2023-05-09T04:48:20.945485  + set +x

    2023-05-09T04:48:21.050105  / # #

    2023-05-09T04:48:21.150660  export SHELL=3D/bin/sh

    2023-05-09T04:48:21.150838  #

    2023-05-09T04:48:21.251340  / # export SHELL=3D/bin/sh. /lava-10249976/=
environment

    2023-05-09T04:48:21.251538  =


    2023-05-09T04:48:21.352130  / # . /lava-10249976/environment/lava-10249=
976/bin/lava-test-runner /lava-10249976/1

    2023-05-09T04:48:21.352439  =


    2023-05-09T04:48:21.357605  / # /lava-10249976/bin/lava-test-runner /la=
va-10249976/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459d0a6e77a5b08382e864b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459d0a6e77a5b08382e8650
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T04:48:31.494274  + set +x<8>[   11.345860] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10250016_1.4.2.3.1>

    2023-05-09T04:48:31.494807  =


    2023-05-09T04:48:31.602221  / # #

    2023-05-09T04:48:31.702959  export SHELL=3D/bin/sh

    2023-05-09T04:48:31.703192  #

    2023-05-09T04:48:31.803772  / # export SHELL=3D/bin/sh. /lava-10250016/=
environment

    2023-05-09T04:48:31.804002  =


    2023-05-09T04:48:31.904674  / # . /lava-10250016/environment/lava-10250=
016/bin/lava-test-runner /lava-10250016/1

    2023-05-09T04:48:31.905895  =


    2023-05-09T04:48:31.910921  / # /lava-10250016/bin/lava-test-runner /la=
va-10250016/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459d0ba42f09f12702e8600

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459d0ba42f09f12702e8605
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T04:48:36.554032  <8>[   10.160947] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10250017_1.4.2.3.1>

    2023-05-09T04:48:36.557444  + set +x

    2023-05-09T04:48:36.658933  #

    2023-05-09T04:48:36.660199  =


    2023-05-09T04:48:36.761853  / # #export SHELL=3D/bin/sh

    2023-05-09T04:48:36.762590  =


    2023-05-09T04:48:36.864180  / # export SHELL=3D/bin/sh. /lava-10250017/=
environment

    2023-05-09T04:48:36.864913  =


    2023-05-09T04:48:36.966395  / # . /lava-10250017/environment/lava-10250=
017/bin/lava-test-runner /lava-10250017/1

    2023-05-09T04:48:36.967598  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459d09a89acd099842e85f9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459d09a89acd099842e85fe
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T04:48:16.574883  + set +x

    2023-05-09T04:48:16.581380  <8>[   11.689247] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10249982_1.4.2.3.1>

    2023-05-09T04:48:16.686043  / # #

    2023-05-09T04:48:16.786609  export SHELL=3D/bin/sh

    2023-05-09T04:48:16.786764  #

    2023-05-09T04:48:16.887254  / # export SHELL=3D/bin/sh. /lava-10249982/=
environment

    2023-05-09T04:48:16.887422  =


    2023-05-09T04:48:16.987968  / # . /lava-10249982/environment/lava-10249=
982/bin/lava-test-runner /lava-10249982/1

    2023-05-09T04:48:16.988203  =


    2023-05-09T04:48:16.992506  / # /lava-10249982/bin/lava-test-runner /la=
va-10249982/1
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459d0962dbbf20ff72e85fd

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459d0962dbbf20ff72e8602
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T04:48:08.791894  + set +x<8>[   10.235897] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10249990_1.4.2.3.1>

    2023-05-09T04:48:08.792003  =


    2023-05-09T04:48:08.893873  #

    2023-05-09T04:48:08.994701  / # #export SHELL=3D/bin/sh

    2023-05-09T04:48:08.994923  =


    2023-05-09T04:48:09.095412  / # export SHELL=3D/bin/sh. /lava-10249990/=
environment

    2023-05-09T04:48:09.095655  =


    2023-05-09T04:48:09.196194  / # . /lava-10249990/environment/lava-10249=
990/bin/lava-test-runner /lava-10249990/1

    2023-05-09T04:48:09.196480  =


    2023-05-09T04:48:09.202026  / # /lava-10249990/bin/lava-test-runner /la=
va-10249990/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459d0bb600c4aa1572e85f9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459d0bb600c4aa1572e85fe
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T04:48:35.872845  + <8>[   10.976906] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10250024_1.4.2.3.1>

    2023-05-09T04:48:35.873275  set +x

    2023-05-09T04:48:35.980715  / # #

    2023-05-09T04:48:36.083254  export SHELL=3D/bin/sh

    2023-05-09T04:48:36.084151  #

    2023-05-09T04:48:36.185848  / # export SHELL=3D/bin/sh. /lava-10250024/=
environment

    2023-05-09T04:48:36.186646  =


    2023-05-09T04:48:36.288429  / # . /lava-10250024/environment/lava-10250=
024/bin/lava-test-runner /lava-10250024/1

    2023-05-09T04:48:36.289751  =


    2023-05-09T04:48:36.294583  / # /lava-10250024/bin/lava-test-runner /la=
va-10250024/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459d0c7096100363c2e85fb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459d0c7096100363c2e8600
        failing since 41 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-09T04:48:54.916516  <8>[   11.388293] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10249996_1.4.2.3.1>

    2023-05-09T04:48:55.021344  / # #

    2023-05-09T04:48:55.122061  export SHELL=3D/bin/sh

    2023-05-09T04:48:55.122255  #

    2023-05-09T04:48:55.222809  / # export SHELL=3D/bin/sh. /lava-10249996/=
environment

    2023-05-09T04:48:55.223005  =


    2023-05-09T04:48:55.323580  / # . /lava-10249996/environment/lava-10249=
996/bin/lava-test-runner /lava-10249996/1

    2023-05-09T04:48:55.323901  =


    2023-05-09T04:48:55.327927  / # /lava-10249996/bin/lava-test-runner /la=
va-10249996/1

    2023-05-09T04:48:55.335310  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6459d4bf49dd1b463a2e85ea

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/6459d4bf49dd1b463a2e8606
        failing since 2 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-09T05:05:54.238072  /lava-10250400/1/../bin/lava-test-case

    2023-05-09T05:05:54.244699  <8>[   22.986287] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6459d4c049dd1b463a2e8692
        failing since 2 days (last pass: v6.1.22-704-ga3dcd1f09de2, first f=
ail: v6.1.22-1160-g24230ce6f2e2)

    2023-05-09T05:05:48.772987  + <8>[   17.516040] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10250400_1.5.2.3.1>

    2023-05-09T05:05:48.776188  set +x

    2023-05-09T05:05:48.885016  / # #

    2023-05-09T05:05:48.987176  export SHELL=3D/bin/sh

    2023-05-09T05:05:48.988057  #

    2023-05-09T05:05:49.089590  / # export SHELL=3D/bin/sh. /lava-10250400/=
environment

    2023-05-09T05:05:49.090291  =


    2023-05-09T05:05:49.191702  / # . /lava-10250400/environment/lava-10250=
400/bin/lava-test-runner /lava-10250400/1

    2023-05-09T05:05:49.192904  =


    2023-05-09T05:05:49.197848  / # /lava-10250400/bin/lava-test-runner /la=
va-10250400/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_mips-malta              | mips   | lab-collabora | gcc-10   | malta_de=
fconfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/6459d32f721ffffe702e8622

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mi=
ps-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mi=
ps-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459d32f721ffffe702e8=
623
        failing since 1 day (last pass: v6.1.22-1159-g8729cbdc1402, first f=
ail: v6.1.22-1196-g571a2463c150b) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6459d1c6f816e265782e8635

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-12=
01-gc4ffdce6b0d1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6459d1c6f816e265782e8=
636
        new failure (last pass: v6.1.22-1203-gcbbb6e9daa79) =

 =20
