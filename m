Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9449774131E
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 15:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjF1N5a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 09:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjF1N5X (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 09:57:23 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69253268F
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 06:57:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b84c7a2716so1160885ad.3
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 06:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687960641; x=1690552641;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z95lw8r6QekD6NEOLubw1P4/tqpkx8mWP5/ShNK1ZTc=;
        b=V1L8uUlAEevpEtmdzQreDIU0aMC6tn1wGWZwIc5313rcK/1PsLmBn8Grwe9auiH7JO
         YEM7zkLPIXdZv1Oz/gS6dt0b66NTM0rvU4V0LXJxgueytprhtfXjkCIznAnWT7Bb9Hkc
         Yga2WI4zzT4agf/eojo6x4bo1tlfJPWo6sSAadzM1xYMpD0xKIXtQgYEadv5G5Zrm9od
         1QfX3inBgc+NTXOwEmRsFX3br112PAqxw5chLvkYryDIFcxRzAwc6qh8/LNCw7aNAvYE
         DBIVYHXS2ZYW/FvOsLU2rsHWXuxwY1Dow+qoOPl3mXzZjLkam5wB9VMuEXLBBofMr0hN
         pMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687960641; x=1690552641;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z95lw8r6QekD6NEOLubw1P4/tqpkx8mWP5/ShNK1ZTc=;
        b=YZaDl39kHoRFO/JLMnniShqvhoNGBglNsmCnnjuiPzljbHTJWUAlXABvE1TN6G/MUJ
         JdZdnNO23cYL1zJ3OVNgQQDWEQNF5iq0gp+LeGtBAoSCijlfJt8rARbT9wpFFLj+YZPC
         GiNUSIe0AarV5ZJKbuM4uXAnR/0zIQC+pYkVe+hhTnSYV8DpFhdz5TYwB13u2luwC0bF
         7OeGJNfGj5gNTSZnENy1ZoQqKH2J6kqeTXnIr7T2OUQoNdVGN+Ox4Wzzan0BzdJ696zY
         R02R6awZ2zjpxsZlZx+sel2C0+0QcDFqDokuoq2u7d5nZz8/UniNp0zmKVDBn4OpPHvW
         +8tQ==
X-Gm-Message-State: AC+VfDxMI0bdfXHMbl39vbKqW5oodhzJ/cgnfC0AsOgzfoVDKZn0A4fC
        5UmJoIzIS/UigMEtPXBpVNLm2OpWBmEWm3ZvbpSUQw==
X-Google-Smtp-Source: ACHHUZ7VacogJg4cHEhH2TBMQhk9jFUsLbllXvuIThUyXk12qE0wYmYvnh70/bg1ctijmlmOk2+aeA==
X-Received: by 2002:a17:902:ea02:b0:1b6:b95d:768e with SMTP id s2-20020a170902ea0200b001b6b95d768emr11572093plg.32.1687960640614;
        Wed, 28 Jun 2023 06:57:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001b694140d96sm7715134plb.170.2023.06.28.06.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 06:57:19 -0700 (PDT)
Message-ID: <649c3c3f.170a0220.7a902.e2f0@mx.google.com>
Date:   Wed, 28 Jun 2023 06:57:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186
Subject: stable/linux-5.10.y baseline: 103 runs, 1 regressions (v5.10.186)
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

stable/linux-5.10.y baseline: 103 runs, 1 regressions (v5.10.186)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.10.y/kernel=
/v5.10.186/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.10.y
  Describe: v5.10.186
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      381518b4a9165cd793599c1668c82079fcbcbe1f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c023a33f15d9cf330617b

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.10.y/v5.10.186/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.10.y/v5.10.186/=
x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/649c023a33f15d9cf3306184
        failing since 83 days (last pass: v5.10.176, first fail: v5.10.177)

    2023-06-28T09:49:48.724769  + <8>[   14.363494] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10934714_1.4.2.3.1>

    2023-06-28T09:49:48.724903  set +x

    2023-06-28T09:49:48.826137  #

    2023-06-28T09:49:48.926974  / # #export SHELL=3D/bin/sh

    2023-06-28T09:49:48.927189  =


    2023-06-28T09:49:49.027757  / # export SHELL=3D/bin/sh. /lava-10934714/=
environment

    2023-06-28T09:49:49.027969  =


    2023-06-28T09:49:49.128530  / # . /lava-10934714/environment/lava-10934=
714/bin/lava-test-runner /lava-10934714/1

    2023-06-28T09:49:49.128844  =


    2023-06-28T09:49:49.133556  / # /lava-10934714/bin/lava-test-runner /la=
va-10934714/1
 =

    ... (12 line(s) more)  =

 =20
