Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96FE76CBE7
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 13:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjHBLkk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 07:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjHBLkj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 07:40:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E7FC0
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 04:40:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bbbbb77b38so40211235ad.3
        for <stable@vger.kernel.org>; Wed, 02 Aug 2023 04:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690976436; x=1691581236;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+WO/i/XwcHFF6nYj+VKNGjtNKQFe4ccLW6h3xjF9B1k=;
        b=wGRA6jiLe0whFSUJO5qnIoLIyFiMQlMerU/gxggLYbputVvtVGR9CALs9mGWtkHyXh
         8+cN4RLRaBywMdAJJWWmM3Fcm6xHylDgp1AoNcqXEcgpy+ZguuvAWrMYydyNtTltZqMX
         +DPEtmui2hTSytlSPwahjOCiB7Q5ic+1pj7A2VBLhVBEb3q64f71HVU8uiU21WfYaUI7
         7AEJamkjjUH6Wk7ClI08du7emOSUdZHpGmuU8HcDtkRji8wRwx7UOX+QPhhx6mYleNpN
         wF5w/KZ/Y6E+urG2fl1OwCYVlQwlKMfMUQrTlayL2W095VYnDYiB0EOVPow9ZsIRG1cW
         SdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690976436; x=1691581236;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WO/i/XwcHFF6nYj+VKNGjtNKQFe4ccLW6h3xjF9B1k=;
        b=B/eiAoeZ+f7bjMJUhf6T8XpT6DBKEroXBA8GXE15HJhyAaPvnh3XDYDat/HEL8Sefg
         8aAhcHu1MK1RHT1sLWli2ukYRmId7lJ6/REFib6V3G4w0zrt1fr0v7CODoZHr3mHxKg0
         3qAepUdntAhosNxrrMGJvZ2SP3kEHKtx5vHOrl0mqKQnHXcd2BkVlotF4qdLWFDc72Cj
         gZEWuhvv4igW4Qjy2rfbBv0GqoaFzEedINP3Z6o1pe8YD4uwopQMSLXVe5fSDg/wCQSd
         d/w2G8VRLnC2DmlDZMij/ANNqgBUFtc2+fCxmHi6ePDKqEOcK8Id83CBxbEqdN98HJIo
         Sqxw==
X-Gm-Message-State: ABy/qLY5lRyJHk1uJTmIp0IWtcnQLXzOPXtgeiKJMHTeaZAq4f5r58VT
        wvEQsY+qFOHK8xNiTrY3VLQCWNP2pYs0KKUESUGSkQ==
X-Google-Smtp-Source: APBJJlF3zAXhPc5CzGj7etp1vg7riD7RQsUvJZ75pUZ9waPMmQ0Zpg/5MAqXBM/9lD73RTkl0R7+Yg==
X-Received: by 2002:a17:903:44e:b0:1bb:bc6d:457 with SMTP id iw14-20020a170903044e00b001bbbc6d0457mr12175056plb.36.1690976435791;
        Wed, 02 Aug 2023 04:40:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b0019ee045a2b3sm12167411plf.308.2023.08.02.04.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 04:40:35 -0700 (PDT)
Message-ID: <64ca40b3.170a0220.ecbdc.77ea@mx.google.com>
Date:   Wed, 02 Aug 2023 04:40:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.42-226-gbdcf4e82a088
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
Subject: stable-rc/linux-6.1.y baseline: 129 runs,
 11 regressions (v6.1.42-226-gbdcf4e82a088)
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

stable-rc/linux-6.1.y baseline: 129 runs, 11 regressions (v6.1.42-226-gbdcf=
4e82a088)

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

odroid-xu3                   | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.42-226-gbdcf4e82a088/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.42-226-gbdcf4e82a088
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      bdcf4e82a088a0bc7c5557d08d0c86c67bbda149 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0c884fa86a54ca35b23f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ca0c884fa86a54ca35b=
240
        failing since 0 day (last pass: v6.1.42-221-gf40ed79b9e80, first fa=
il: v6.1.42-229-g9f9cafb143051) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0b9c45b204db6d35b202

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0b9c45b204db6d35b207
        failing since 124 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-02T07:53:59.827968  + set +x

    2023-08-02T07:53:59.834489  <8>[   10.292781] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11188471_1.4.2.3.1>

    2023-08-02T07:53:59.941811  #

    2023-08-02T07:54:00.043574  / # #export SHELL=3D/bin/sh

    2023-08-02T07:54:00.044414  =


    2023-08-02T07:54:00.145990  / # export SHELL=3D/bin/sh. /lava-11188471/=
environment

    2023-08-02T07:54:00.146793  =


    2023-08-02T07:54:00.248693  / # . /lava-11188471/environment/lava-11188=
471/bin/lava-test-runner /lava-11188471/1

    2023-08-02T07:54:00.249924  =


    2023-08-02T07:54:00.256155  / # /lava-11188471/bin/lava-test-runner /la=
va-11188471/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0b92e0baec3b1435b220

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0b92e0baec3b1435b225
        failing since 124 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-02T07:53:40.043165  + set<8>[   11.115465] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11188489_1.4.2.3.1>

    2023-08-02T07:53:40.043275   +x

    2023-08-02T07:53:40.147991  / # #

    2023-08-02T07:53:40.248692  export SHELL=3D/bin/sh

    2023-08-02T07:53:40.248925  #

    2023-08-02T07:53:40.349456  / # export SHELL=3D/bin/sh. /lava-11188489/=
environment

    2023-08-02T07:53:40.349663  =


    2023-08-02T07:53:40.450212  / # . /lava-11188489/environment/lava-11188=
489/bin/lava-test-runner /lava-11188489/1

    2023-08-02T07:53:40.450549  =


    2023-08-02T07:53:40.455186  / # /lava-11188489/bin/lava-test-runner /la=
va-11188489/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0b8f21cca77a2035b23b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0b8f21cca77a2035b240
        failing since 124 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-02T07:53:39.210501  <8>[   10.006403] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11188468_1.4.2.3.1>

    2023-08-02T07:53:39.213720  + set +x

    2023-08-02T07:53:39.315228  /#

    2023-08-02T07:53:39.416026   # #export SHELL=3D/bin/sh

    2023-08-02T07:53:39.416232  =


    2023-08-02T07:53:39.516806  / # export SHELL=3D/bin/sh. /lava-11188468/=
environment

    2023-08-02T07:53:39.517002  =


    2023-08-02T07:53:39.617486  / # . /lava-11188468/environment/lava-11188=
468/bin/lava-test-runner /lava-11188468/1

    2023-08-02T07:53:39.617833  =


    2023-08-02T07:53:39.622675  / # /lava-11188468/bin/lava-test-runner /la=
va-11188468/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beagle-xm                    | arm    | lab-baylibre  | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca10e23da7b145bc35cbbe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beag=
le-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ca10e23da7b145bc35c=
bbf
        failing since 55 days (last pass: v6.1.31-40-g7d0a9678d276, first f=
ail: v6.1.31-266-g8f4f686e321c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0b85804af55fa635b22b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0b85804af55fa635b230
        failing since 124 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-02T07:54:07.061332  + set +x

    2023-08-02T07:54:07.068178  <8>[   10.315543] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11188504_1.4.2.3.1>

    2023-08-02T07:54:07.176429  / # #

    2023-08-02T07:54:07.279115  export SHELL=3D/bin/sh

    2023-08-02T07:54:07.279979  #

    2023-08-02T07:54:07.381725  / # export SHELL=3D/bin/sh. /lava-11188504/=
environment

    2023-08-02T07:54:07.382503  =


    2023-08-02T07:54:07.484070  / # . /lava-11188504/environment/lava-11188=
504/bin/lava-test-runner /lava-11188504/1

    2023-08-02T07:54:07.485443  =


    2023-08-02T07:54:07.490850  / # /lava-11188504/bin/lava-test-runner /la=
va-11188504/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0b97e28cd29a7835b1e4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0b97e28cd29a7835b1e9
        failing since 124 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-02T07:53:42.533738  + set +x<8>[   11.127995] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11188475_1.4.2.3.1>

    2023-08-02T07:53:42.533839  =


    2023-08-02T07:53:42.638536  / # #

    2023-08-02T07:53:42.739177  export SHELL=3D/bin/sh

    2023-08-02T07:53:42.739388  #

    2023-08-02T07:53:42.839889  / # export SHELL=3D/bin/sh. /lava-11188475/=
environment

    2023-08-02T07:53:42.840093  =


    2023-08-02T07:53:42.940580  / # . /lava-11188475/environment/lava-11188=
475/bin/lava-test-runner /lava-11188475/1

    2023-08-02T07:53:42.940914  =


    2023-08-02T07:53:42.945420  / # /lava-11188475/bin/lava-test-runner /la=
va-11188475/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0b8821cca77a2035b22d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0b8821cca77a2035b232
        failing since 124 days (last pass: v6.1.21, first fail: v6.1.22)

    2023-08-02T07:53:44.576525  + set<8>[   11.455553] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11188488_1.4.2.3.1>

    2023-08-02T07:53:44.576620   +x

    2023-08-02T07:53:44.681345  / # #

    2023-08-02T07:53:44.781983  export SHELL=3D/bin/sh

    2023-08-02T07:53:44.782204  #

    2023-08-02T07:53:44.882777  / # export SHELL=3D/bin/sh. /lava-11188488/=
environment

    2023-08-02T07:53:44.882961  =


    2023-08-02T07:53:44.983496  / # . /lava-11188488/environment/lava-11188=
488/bin/lava-test-runner /lava-11188488/1

    2023-08-02T07:53:44.983777  =


    2023-08-02T07:53:44.988787  / # /lava-11188488/bin/lava-test-runner /la=
va-11188488/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
odroid-xu3                   | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0e051e55ce808c35b264

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odro=
id-xu3.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-odro=
id-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ca0e051e55ce808c35b=
265
        new failure (last pass: v6.1.42-229-g9f9cafb143051) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a779m1-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0de6960702050535b246

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ul=
cb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0de6960702050535b24b
        failing since 15 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-02T08:03:51.841576  / # #

    2023-08-02T08:03:52.921705  export SHELL=3D/bin/sh

    2023-08-02T08:03:52.923572  #

    2023-08-02T08:03:54.414292  / # export SHELL=3D/bin/sh. /lava-11188606/=
environment

    2023-08-02T08:03:54.416278  =


    2023-08-02T08:03:57.140598  / # . /lava-11188606/environment/lava-11188=
606/bin/lava-test-runner /lava-11188606/1

    2023-08-02T08:03:57.142901  =


    2023-08-02T08:03:57.149515  / # /lava-11188606/bin/lava-test-runner /la=
va-11188606/1

    2023-08-02T08:03:57.210766  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-02T08:03:57.211265  + cd /lava-111886<8>[   28.509810] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11188606_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ca0de01e55ce808c35b1de

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.42-=
226-gbdcf4e82a088/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ca0de01e55ce808c35b1e3
        failing since 15 days (last pass: v6.1.38-393-gb6386e7314b4, first =
fail: v6.1.38-590-gce7ec1011187)

    2023-08-02T08:04:59.687369  / # #

    2023-08-02T08:04:59.789535  export SHELL=3D/bin/sh

    2023-08-02T08:04:59.790241  #

    2023-08-02T08:04:59.891670  / # export SHELL=3D/bin/sh. /lava-11188602/=
environment

    2023-08-02T08:04:59.892374  =


    2023-08-02T08:04:59.993812  / # . /lava-11188602/environment/lava-11188=
602/bin/lava-test-runner /lava-11188602/1

    2023-08-02T08:04:59.994914  =


    2023-08-02T08:05:00.011711  / # /lava-11188602/bin/lava-test-runner /la=
va-11188602/1

    2023-08-02T08:05:00.078589  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-02T08:05:00.079110  + cd /lava-11188602/1/tests/1_boot<8>[   16=
.914209] <LAVA_SIGNAL_STARTRUN 1_bootrr 11188602_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20
