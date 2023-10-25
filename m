Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1AF7D66C6
	for <lists+stable@lfdr.de>; Wed, 25 Oct 2023 11:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjJYJ3w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 05:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjJYJ3v (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 05:29:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4B9CE
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 02:29:46 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9d3a21f7aso46264375ad.2
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 02:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698226186; x=1698830986; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Au5t4F47itTZt5jIy7aNWlhgCj7NGJ4C6BwNQW6/9r0=;
        b=NQFTdScCQIPT8v3aRdw7S4d5AJiSi2rKltvWscu2tqO4nLyyHWh1fTGEYRG14nXOeV
         aouUPTcazlk/rpVmDtEKbvnHUlkrT2rRNMClJaIVbotZ4BTJRdt+wDt2xNfsYuSmKmMj
         Ab9CIQQS0Ba5pAIlK016dDAd9l0ISVFCoNMVLnMi+3M/N0CovN/xcSYOFWwEuJuMGKYk
         2nrE6ZAW2wo4gPBlUfz+TdtCqUchSG2PLhYsiwgfNZ/SWvkslBBKQ1UGR8bAkO0LumXY
         EHq1JfYDbBonWPmxr1DQQcVDEJ/pzqgHSXGCwXTqowgKn95V2SirVzF4wDge3h/oTt/c
         h63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698226186; x=1698830986;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Au5t4F47itTZt5jIy7aNWlhgCj7NGJ4C6BwNQW6/9r0=;
        b=cEDnlogq838FKlqSYht3ln7hiDmHuF3iLIwZw40XnsTMW5+otl1QCWaECrGRx4inN2
         8tmAm4kyiEQq7Tlksxf21lnSbId8CR+jPI5p3KE5Kv1YichQSFv1pikqsBl9+5l/auYw
         PcBdE6QuwZ+KSG7N8+QNy3p7uUNxKUWJnV8YIKkYk5xYyKxVeg9HPU4ogSELkQ8dvku4
         jLM+Rse0D0V239JgLTz6i4QiOnBMauQ3o9wwf+fty/fOVya2qzbj862FTeV8ZWQ5EJWM
         auEhsrjUEWvSKsHDxnhFcBYpSYMfkK4RUk5rHWu3gJ5DvBOIQzzmPL7G/WypY/x/GncU
         VYxQ==
X-Gm-Message-State: AOJu0YxhOX6RfeZR5VlX3mtRWcq5LbEy0+B2vxheFhgBLxyH7rKKJ8n7
        NjwIMKTb3pVEvV0afoF4Oy/YUuWe645rmTSth/BZSQ==
X-Google-Smtp-Source: AGHT+IE8hVaMGEjne37hArS86LMQva8tTxtsJ8n6j8gjDNAvoyHPusuPRrKGpdRgDdDwjtyGp89dAw==
X-Received: by 2002:a17:903:2642:b0:1ca:7439:f74f with SMTP id je2-20020a170903264200b001ca7439f74fmr14392419plb.60.1698226185815;
        Wed, 25 Oct 2023 02:29:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902ee4200b001c73d829fb7sm8808934plo.15.2023.10.25.02.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 02:29:45 -0700 (PDT)
Message-ID: <6538e009.170a0220.ff7e6.d5e9@mx.google.com>
Date:   Wed, 25 Oct 2023 02:29:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.4.258-121-g18f5a3e6c35c
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.4.y baseline: 149 runs,
 1 regressions (v5.4.258-121-g18f5a3e6c35c)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.4.y baseline: 149 runs, 1 regressions (v5.4.258-121-g18f5=
a3e6c35c)

Regressions Summary
-------------------

platform | arch | lab          | compiler | defconfig          | regressions
---------+------+--------------+----------+--------------------+------------
panda    | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.4.y/kern=
el/v5.4.258-121-g18f5a3e6c35c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.4.y
  Describe: v5.4.258-121-g18f5a3e6c35c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      18f5a3e6c35c0a03c6667581701af2288329ca82 =



Test Regressions
---------------- =



platform | arch | lab          | compiler | defconfig          | regressions
---------+------+--------------+----------+--------------------+------------
panda    | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6538af419d5ce058a2efcf41

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.258=
-121-g18f5a3e6c35c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.258=
-121-g18f5a3e6c35c/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pand=
a.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6538af419d5ce058a2efcf4a
        new failure (last pass: v5.4.218-5-g5a1de46f7e74)

    2023-10-25T06:01:16.104331  <8>[   21.108093] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3812392_1.5.2.4.1>
    2023-10-25T06:01:16.209398  #
    2023-10-25T06:01:16.311173  / # #export SHELL=3D/bin/sh
    2023-10-25T06:01:16.311685  =

    2023-10-25T06:01:16.412574  / # export SHELL=3D/bin/sh. /lava-3812392/e=
nvironment
    2023-10-25T06:01:16.413083  =

    2023-10-25T06:01:16.513978  / # . /lava-3812392/environment/lava-381239=
2/bin/lava-test-runner /lava-3812392/1
    2023-10-25T06:01:16.514751  =

    2023-10-25T06:01:16.519727  / # /lava-3812392/bin/lava-test-runner /lav=
a-3812392/1
    2023-10-25T06:01:16.577772  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
