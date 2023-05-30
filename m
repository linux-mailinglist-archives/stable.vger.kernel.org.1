Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56319716F3D
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 22:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjE3Uz3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 16:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjE3Uz1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 16:55:27 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF40EC
        for <stable@vger.kernel.org>; Tue, 30 May 2023 13:55:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b01d3bb571so27497045ad.2
        for <stable@vger.kernel.org>; Tue, 30 May 2023 13:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685480125; x=1688072125;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XmpqaeX4mHaAdRtCxSbYqXZ/uv+p2qV7V0hyaQZoRBk=;
        b=KXLSBy8Z+Xj+LrGXl7Q0u2ELTVp23Y9j0O/IrfSgZ8Nm581OnKv1e/VFu+7HE3a/aC
         HmZNEegqsbZXUJrZ60O0xvb78m0IeTJ4UvFCjwCrkKQLuzZ49Ca/aaozjr4n3vPN3PIa
         Ob/8SewEVerAG7hWIrp0ZpuhRAKAcZ3a2FLNk14wEtp5k0mMm4XDQjOfoHsU4h7n6/1t
         BDSzvdLEhY1BbOGioMMkskdS65x2hHx+YS9TvvZ7P45bmEr3eCP4VgH/jvA6PF8VJER/
         RcYNvKhJnWjb0VeNZcXXtv1tKhIKMxLdrCK9VNBaPwD53COSKwTSnHmvw6MbaW0+BGg2
         PUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685480125; x=1688072125;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmpqaeX4mHaAdRtCxSbYqXZ/uv+p2qV7V0hyaQZoRBk=;
        b=hJIfNy+NKSXibvtyhNtJM6Yuidun2aC+6XaDdwloK/qbkxMt1QXUOg2/RMcrAovQrv
         e7u2gANeaiiKhUkoHN9dE/P3z0VVN5LBV5Gk976S2EQc+fMYXorfYEkIX1o8lqLf93sk
         5WCCgFo2FKyUs0MR+OmdXLKOz8QCvv3KUqBnJABBBLVC86zthsKYk8NRHZFF7DCiMH3P
         5tR4NflbsL0thJ6LWttPBwPGYE/5lqFEA5dX04F9bUI53q11aayyurKaKRDFv8wA+bvO
         +ZF6E4cTHStGqV50tT79SRtnRiQHqJy1SbiM1+d7+XE5dqkJyjTiWxCss+fgSaa4mEGE
         10gQ==
X-Gm-Message-State: AC+VfDx8LdS3UDVYw84LtQnPVyltk1+JbD/85Lq2z2Ae/9hyRQvQ1KV/
        Ormh1SH9wAbidp2INaRrOdA5Wko9DOCbhQsIsKiLRw==
X-Google-Smtp-Source: ACHHUZ7LO1g/59EtMDVb4nzkxNNRoaOJHcAYZkK0xruAZOWni0YCv/t5DI8Ke5Dq9jGhTd7x0tiMfQ==
X-Received: by 2002:a17:903:234c:b0:1b0:45e:fb02 with SMTP id c12-20020a170903234c00b001b0045efb02mr3781186plh.35.1685480124600;
        Tue, 30 May 2023 13:55:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b001b012589c49sm8767877plb.78.2023.05.30.13.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 13:55:24 -0700 (PDT)
Message-ID: <647662bc.170a0220.e74fb.011e@mx.google.com>
Date:   Tue, 30 May 2023 13:55:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.31
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-6.1.y baseline: 164 runs, 9 regressions (v6.1.31)
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

stable-rc/linux-6.1.y baseline: 164 runs, 9 regressions (v6.1.31)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.31/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.31
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d2869ace6eeb8ea8a6e70e6904524c5a6456d3fb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64762e83a7c1a0ca002e85e9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64762e83a7c1a0ca002e85ee
        failing since 61 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-30T17:12:15.429809  + set +x

    2023-05-30T17:12:15.436520  <8>[   11.399217] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10527875_1.4.2.3.1>

    2023-05-30T17:12:15.543520  / # #

    2023-05-30T17:12:15.645808  export SHELL=3D/bin/sh

    2023-05-30T17:12:15.646321  #

    2023-05-30T17:12:15.747355  / # export SHELL=3D/bin/sh. /lava-10527875/=
environment

    2023-05-30T17:12:15.748149  =


    2023-05-30T17:12:15.849842  / # . /lava-10527875/environment/lava-10527=
875/bin/lava-test-runner /lava-10527875/1

    2023-05-30T17:12:15.851123  =


    2023-05-30T17:12:15.857757  / # /lava-10527875/bin/lava-test-runner /la=
va-10527875/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64762e81d9c0713de22e8609

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C=
M1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64762e81d9c0713de22e860e
        failing since 61 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-30T17:12:18.590840  + set<8>[   11.323101] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10527834_1.4.2.3.1>

    2023-05-30T17:12:18.591463   +x

    2023-05-30T17:12:18.700404  / # #

    2023-05-30T17:12:18.803075  export SHELL=3D/bin/sh

    2023-05-30T17:12:18.803975  #

    2023-05-30T17:12:18.905584  / # export SHELL=3D/bin/sh. /lava-10527834/=
environment

    2023-05-30T17:12:18.906443  =


    2023-05-30T17:12:19.008142  / # . /lava-10527834/environment/lava-10527=
834/bin/lava-test-runner /lava-10527834/1

    2023-05-30T17:12:19.009533  =


    2023-05-30T17:12:19.014654  / # /lava-10527834/bin/lava-test-runner /la=
va-10527834/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64762e813fc6d164de2e862f

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-c=
x9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64762e813fc6d164de2e8634
        failing since 61 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-30T17:12:09.820263  <8>[    7.860558] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10527832_1.4.2.3.1>

    2023-05-30T17:12:09.823486  + set +x

    2023-05-30T17:12:09.925721  =


    2023-05-30T17:12:10.026492  / # #export SHELL=3D/bin/sh

    2023-05-30T17:12:10.026755  =


    2023-05-30T17:12:10.127389  / # export SHELL=3D/bin/sh. /lava-10527832/=
environment

    2023-05-30T17:12:10.127658  =


    2023-05-30T17:12:10.228299  / # . /lava-10527832/environment/lava-10527=
832/bin/lava-test-runner /lava-10527832/1

    2023-05-30T17:12:10.228736  =


    2023-05-30T17:12:10.233826  / # /lava-10527832/bin/lava-test-runner /la=
va-10527832/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64762e7f109f7fc64e2e85f7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64762e7f109f7fc64e2e85fc
        failing since 61 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-30T17:12:09.920172  + set +x

    2023-05-30T17:12:09.926565  <8>[   11.252655] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10527879_1.4.2.3.1>

    2023-05-30T17:12:10.030776  / # #

    2023-05-30T17:12:10.131416  export SHELL=3D/bin/sh

    2023-05-30T17:12:10.131659  #

    2023-05-30T17:12:10.232247  / # export SHELL=3D/bin/sh. /lava-10527879/=
environment

    2023-05-30T17:12:10.232473  =


    2023-05-30T17:12:10.333010  / # . /lava-10527879/environment/lava-10527=
879/bin/lava-test-runner /lava-10527879/1

    2023-05-30T17:12:10.333309  =


    2023-05-30T17:12:10.338626  / # /lava-10527879/bin/lava-test-runner /la=
va-10527879/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64762e70c8447b1be72e8623

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64762e70c8447b1be72e8628
        failing since 61 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-30T17:12:02.212780  <8>[   10.711995] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10527869_1.4.2.3.1>

    2023-05-30T17:12:02.216680  + set +x

    2023-05-30T17:12:02.320228  / # #

    2023-05-30T17:12:02.421042  export SHELL=3D/bin/sh

    2023-05-30T17:12:02.421229  #

    2023-05-30T17:12:02.521831  / # export SHELL=3D/bin/sh. /lava-10527869/=
environment

    2023-05-30T17:12:02.522004  =


    2023-05-30T17:12:02.622629  / # . /lava-10527869/environment/lava-10527=
869/bin/lava-test-runner /lava-10527869/1

    2023-05-30T17:12:02.622923  =


    2023-05-30T17:12:02.628045  / # /lava-10527869/bin/lava-test-runner /la=
va-10527869/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64762e822a80bdbc982e8618

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64762e822a80bdbc982e861d
        failing since 61 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-30T17:12:12.272518  + set<8>[   11.695960] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10527855_1.4.2.3.1>

    2023-05-30T17:12:12.272601   +x

    2023-05-30T17:12:12.377070  / # #

    2023-05-30T17:12:12.477715  export SHELL=3D/bin/sh

    2023-05-30T17:12:12.478009  #

    2023-05-30T17:12:12.578528  / # export SHELL=3D/bin/sh. /lava-10527855/=
environment

    2023-05-30T17:12:12.578749  =


    2023-05-30T17:12:12.679393  / # . /lava-10527855/environment/lava-10527=
855/bin/lava-test-runner /lava-10527855/1

    2023-05-30T17:12:12.679732  =


    2023-05-30T17:12:12.684797  / # /lava-10527855/bin/lava-test-runner /la=
va-10527855/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64762e8da7c1a0ca002e860e

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-lenovo=
-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64762e8da7c1a0ca002e8613
        failing since 61 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-05-30T17:12:26.467246  <8>[   11.050136] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10527850_1.4.2.3.1>

    2023-05-30T17:12:26.571320  / # #

    2023-05-30T17:12:26.671968  export SHELL=3D/bin/sh

    2023-05-30T17:12:26.672148  #

    2023-05-30T17:12:26.772611  / # export SHELL=3D/bin/sh. /lava-10527850/=
environment

    2023-05-30T17:12:26.772796  =


    2023-05-30T17:12:26.873299  / # . /lava-10527850/environment/lava-10527=
850/bin/lava-test-runner /lava-10527850/1

    2023-05-30T17:12:26.873564  =


    2023-05-30T17:12:26.878495  / # /lava-10527850/bin/lava-test-runner /la=
va-10527850/1

    2023-05-30T17:12:26.885207  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8183-kukui-...uniper-sku16 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64762edd9b80240bee2e85f5

  Results:     166 PASS, 5 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.31/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mt6577-auxadc-probed: https://kernelci.org/test/case/id=
/64762edd9b80240bee2e8611
        failing since 19 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-05-30T17:13:40.919794  /lava-10527929/1/../bin/lava-test-case

    2023-05-30T17:13:40.926013  <8>[   22.946356] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmt6577-auxadc-probed RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64762edd9b80240bee2e869d
        failing since 19 days (last pass: v6.1.27, first fail: v6.1.28)

    2023-05-30T17:13:35.458292  + set +x

    2023-05-30T17:13:35.464269  <8>[   17.484253] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10527929_1.5.2.3.1>

    2023-05-30T17:13:35.570326  / # #

    2023-05-30T17:13:35.671079  export SHELL=3D/bin/sh

    2023-05-30T17:13:35.671297  #

    2023-05-30T17:13:35.771822  / # export SHELL=3D/bin/sh. /lava-10527929/=
environment

    2023-05-30T17:13:35.772079  =


    2023-05-30T17:13:35.872698  / # . /lava-10527929/environment/lava-10527=
929/bin/lava-test-runner /lava-10527929/1

    2023-05-30T17:13:35.873056  =


    2023-05-30T17:13:35.878671  / # /lava-10527929/bin/lava-test-runner /la=
va-10527929/1
 =

    ... (13 line(s) more)  =

 =20
