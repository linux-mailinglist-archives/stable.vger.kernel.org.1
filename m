Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1B76F9233
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 15:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjEFNMm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 09:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjEFNMl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 09:12:41 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750141A48E
        for <stable@vger.kernel.org>; Sat,  6 May 2023 06:12:39 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ab0c697c84so20836325ad.3
        for <stable@vger.kernel.org>; Sat, 06 May 2023 06:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683378758; x=1685970758;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t2Pox4n4cD2/QisbSH54ioFoU1pGMaxgXAws2IfIsrU=;
        b=SW8CnBiV52/Wsj3uOVnPMn2xYSPx0FfjePhBv4cwYIEX2R0dbUEgi4717pRQRZaQvs
         bnt5bjw57XaTKwTqniL2KDp8t4JDBQCpgF4g0wu1ZQp7WRui4wno/8fw+WufptTjKUzi
         EUiFAtfKxsMCPFcd+lGZ69EscB/nGqJFnmghTOK84D4SIFCRNHewkfycx7avVN2VzGun
         Wh+i4RzjKNZ6W7woLVnckqCAUFUMgkYn6DhlkY8IR0OSPn/LT5tSh0h036u1O+nQ3LnC
         wXigNtMrkrDPeMP9YX0oZoyRvbKBUb0qTtnoN2k6NzfqlJXa3ELcsmjDeiAptMlEkBF5
         024A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683378758; x=1685970758;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2Pox4n4cD2/QisbSH54ioFoU1pGMaxgXAws2IfIsrU=;
        b=YQqKqX3oJKXPgzqx+BDPauGHaXehbEl86cCTLqx5846NFPR7lbYdBoeOUJS+NKnmaJ
         dMF9XTsQYpmxa9VUomV8g5eu3DieSY/As1Stfojps4RsOzwdH7VZt8gGXSIoy1VNbppV
         M9YHDZDO7NSMm3ajSCMFDUQXDwGkt/TfaogunlKrTLzykyMauHSI7QkY2lHQYJHTjDMR
         wQle7jmI8KbR/4N2f1dF4ySIASNbKHy35c9p2F3rS/MiQOAsQAAQrXr4zuOLkiSfkrG+
         pvufjzHekxRfS4C/O+yzVykDQrQcpa0LcFmrXpRAxGqgExmPLeBaoZdFXWAf/D16/s5g
         A88g==
X-Gm-Message-State: AC+VfDxlmCtEz04K5jZv9FXVCaSNwB29jMAE2R3dlJ4V15PDIwOt3KSk
        d+BDLNg2oxtrdMQ2lk4v64c9nXWPBzuoqicI7JehJA==
X-Google-Smtp-Source: ACHHUZ6x5nWFdNok1LZGYRsg3YR8vHXQvrcoGaybijxbR5HQGedyCzu5xkrlVRJXBzl4yg+7E+VFhw==
X-Received: by 2002:a17:903:1110:b0:1ab:74c:bdf2 with SMTP id n16-20020a170903111000b001ab074cbdf2mr6176037plh.28.1683378758472;
        Sat, 06 May 2023 06:12:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bg8-20020a1709028e8800b001a96d295f15sm3565811plb.284.2023.05.06.06.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 06:12:37 -0700 (PDT)
Message-ID: <64565245.170a0220.cc01a.6888@mx.google.com>
Date:   Sat, 06 May 2023 06:12:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v6.1.22-704-ga3dcd1f09de2
X-Kernelci-Report-Type: test
Subject: stable-rc/queue/6.1 baseline: 163 runs,
 7 regressions (v6.1.22-704-ga3dcd1f09de2)
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

stable-rc/queue/6.1 baseline: 163 runs, 7 regressions (v6.1.22-704-ga3dcd1f=
09de2)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.22-704-ga3dcd1f09de2/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.22-704-ga3dcd1f09de2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a3dcd1f09de2b628b6dbef91ab9e0a0a55d1192a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64561bb91a3806df4f2e85e6

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-70=
4-ga3dcd1f09de2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-70=
4-ga3dcd1f09de2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64561bb91a3806df4f2e85eb
        failing since 38 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-06T09:19:35.172112  + set +x

    2023-05-06T09:19:35.178656  <8>[   10.375265] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10214896_1.4.2.3.1>

    2023-05-06T09:19:35.280462  #

    2023-05-06T09:19:35.280732  =


    2023-05-06T09:19:35.381277  / # #export SHELL=3D/bin/sh

    2023-05-06T09:19:35.381467  =


    2023-05-06T09:19:35.482017  / # export SHELL=3D/bin/sh. /lava-10214896/=
environment

    2023-05-06T09:19:35.482198  =


    2023-05-06T09:19:35.582685  / # . /lava-10214896/environment/lava-10214=
896/bin/lava-test-runner /lava-10214896/1

    2023-05-06T09:19:35.582969  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64561bab0021ef2ce22e85f4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-70=
4-ga3dcd1f09de2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-70=
4-ga3dcd1f09de2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64561bab0021ef2ce22e85f9
        failing since 38 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-06T09:19:20.646545  + set<8>[   11.998815] <LAVA_SIGNAL_ENDRUN =
0_dmesg 10214862_1.4.2.3.1>

    2023-05-06T09:19:20.646637   +x

    2023-05-06T09:19:20.750977  / # #

    2023-05-06T09:19:20.851548  export SHELL=3D/bin/sh

    2023-05-06T09:19:20.851709  #

    2023-05-06T09:19:20.952214  / # export SHELL=3D/bin/sh. /lava-10214862/=
environment

    2023-05-06T09:19:20.952397  =


    2023-05-06T09:19:21.052868  / # . /lava-10214862/environment/lava-10214=
862/bin/lava-test-runner /lava-10214862/1

    2023-05-06T09:19:21.053217  =


    2023-05-06T09:19:21.058236  / # /lava-10214862/bin/lava-test-runner /la=
va-10214862/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64561ba90021ef2ce22e85e7

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-70=
4-ga3dcd1f09de2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-70=
4-ga3dcd1f09de2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64561ba90021ef2ce22e85ec
        failing since 38 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-06T09:19:14.924383  <8>[   10.504983] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10214858_1.4.2.3.1>

    2023-05-06T09:19:14.927714  + set +x

    2023-05-06T09:19:15.032168  / # #

    2023-05-06T09:19:15.132843  export SHELL=3D/bin/sh

    2023-05-06T09:19:15.133042  #

    2023-05-06T09:19:15.233605  / # export SHELL=3D/bin/sh. /lava-10214858/=
environment

    2023-05-06T09:19:15.233820  =


    2023-05-06T09:19:15.334439  / # . /lava-10214858/environment/lava-10214=
858/bin/lava-test-runner /lava-10214858/1

    2023-05-06T09:19:15.334803  =


    2023-05-06T09:19:15.339794  / # /lava-10214858/bin/lava-test-runner /la=
va-10214858/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64561b9be3c39446fc2e8646

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-70=
4-ga3dcd1f09de2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-70=
4-ga3dcd1f09de2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64561b9be3c39446fc2e864b
        failing since 38 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-06T09:19:11.503888  + set +x

    2023-05-06T09:19:11.510515  <8>[   10.515447] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10214913_1.4.2.3.1>

    2023-05-06T09:19:11.614618  / # #

    2023-05-06T09:19:11.715296  export SHELL=3D/bin/sh

    2023-05-06T09:19:11.715503  #

    2023-05-06T09:19:11.816054  / # export SHELL=3D/bin/sh. /lava-10214913/=
environment

    2023-05-06T09:19:11.816255  =


    2023-05-06T09:19:11.916759  / # . /lava-10214913/environment/lava-10214=
913/bin/lava-test-runner /lava-10214913/1

    2023-05-06T09:19:11.917127  =


    2023-05-06T09:19:11.921670  / # /lava-10214913/bin/lava-test-runner /la=
va-10214913/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64561ba6e3c39446fc2e865a

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-70=
4-ga3dcd1f09de2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-70=
4-ga3dcd1f09de2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64561ba6e3c39446fc2e865f
        failing since 38 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-06T09:19:17.251164  <8>[   10.465801] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10214900_1.4.2.3.1>

    2023-05-06T09:19:17.254660  + set +x

    2023-05-06T09:19:17.359420  #

    2023-05-06T09:19:17.360556  =


    2023-05-06T09:19:17.462184  / # #export SHELL=3D/bin/sh

    2023-05-06T09:19:17.462893  =


    2023-05-06T09:19:17.564166  / # export SHELL=3D/bin/sh. /lava-10214900/=
environment

    2023-05-06T09:19:17.564511  =


    2023-05-06T09:19:17.665305  / # . /lava-10214900/environment/lava-10214=
900/bin/lava-test-runner /lava-10214900/1

    2023-05-06T09:19:17.666369  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64561bb04a811af9452e8602

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-70=
4-ga3dcd1f09de2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-70=
4-ga3dcd1f09de2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64561bb04a811af9452e8607
        failing since 38 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-06T09:19:18.841986  + <8>[   10.706668] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10214872_1.4.2.3.1>

    2023-05-06T09:19:18.842091  set +x

    2023-05-06T09:19:18.946860  / # #

    2023-05-06T09:19:19.047517  export SHELL=3D/bin/sh

    2023-05-06T09:19:19.047709  #

    2023-05-06T09:19:19.148191  / # export SHELL=3D/bin/sh. /lava-10214872/=
environment

    2023-05-06T09:19:19.148392  =


    2023-05-06T09:19:19.248893  / # . /lava-10214872/environment/lava-10214=
872/bin/lava-test-runner /lava-10214872/1

    2023-05-06T09:19:19.249209  =


    2023-05-06T09:19:19.253656  / # /lava-10214872/bin/lava-test-runner /la=
va-10214872/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64561ba4cd419e8a932e85f0

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-70=
4-ga3dcd1f09de2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.22-70=
4-ga3dcd1f09de2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora=
/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64561ba4cd419e8a932e85f5
        failing since 38 days (last pass: v6.1.21-104-gd5eb32be5b26, first =
fail: v6.1.21-224-g1abeb39fad59)

    2023-05-06T09:19:20.729038  + <8>[   11.294299] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10214871_1.4.2.3.1>

    2023-05-06T09:19:20.729179  set +x

    2023-05-06T09:19:20.833766  / # #

    2023-05-06T09:19:20.934437  export SHELL=3D/bin/sh

    2023-05-06T09:19:20.934697  #

    2023-05-06T09:19:21.035297  / # export SHELL=3D/bin/sh. /lava-10214871/=
environment

    2023-05-06T09:19:21.035558  =


    2023-05-06T09:19:21.136153  / # . /lava-10214871/environment/lava-10214=
871/bin/lava-test-runner /lava-10214871/1

    2023-05-06T09:19:21.136484  =


    2023-05-06T09:19:21.140937  / # /lava-10214871/bin/lava-test-runner /la=
va-10214871/1
 =

    ... (12 line(s) more)  =

 =20
