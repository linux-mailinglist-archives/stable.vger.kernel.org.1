Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2AF7D680B
	for <lists+stable@lfdr.de>; Wed, 25 Oct 2023 12:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbjJYKQP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 06:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbjJYKQF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 06:16:05 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA41185
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 03:16:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ca3a54d2c4so46256225ad.3
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 03:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698228962; x=1698833762; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qZrCjHvzjlWvLeDhBizXfUkQW61+HzBMLi2GBErW/FU=;
        b=2o0+okz7rNpZxEQGbA3gSJaDBw5eXeRNTEaADNAw+boE0ca3tul2uVtMeZJrUOCLYh
         C5nJbddRZWNwB81zkIzeup3P0n6TBt0/DLPqBuzRpY+7AM+gX1ZZeh5dz5pctSHrYsZQ
         56qZNDIbXl+hbdCVWOXR8JQQjaVLzVJtNmny/ILFsHLFnEqh3ZQqmnorhzA+iSK4/LsU
         Bg5A/tUsRrm+8c95pia5GH4E3hDq6CYew4nX6HLNQU4+VYUMcLyWKeUYxeiehMtHA741
         wrLKT76Of+InceLg3YFrISXIePFikxgJRnuuxFYS6B2nDvfPxrXXaeTC1NHqKEEvakRk
         Ne0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698228962; x=1698833762;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZrCjHvzjlWvLeDhBizXfUkQW61+HzBMLi2GBErW/FU=;
        b=xEvC7TR74j2Hst/P6bCoJYcMnSdhuDcPW3cmvQFU4thJAQll3cp7yWo+x09wLvTcGR
         OYDcX/ayg3ldVCbuPXgvb0MORk3Xdf/TqcggdHKyS+9SHNAk40z01AdMOU2im3ivst5y
         UAKKhvxNMJ19iH9BtSipX+j1oqWr+8cK13J9aMfY7Zn+mhJ+giM8wERGXyXWF70haKxb
         nxI2shHnplD0OC3bsWR4tDXoSL2M+oKs/8A3IVSqg4ew2L4nqla/onCdT5xnn4uhl48O
         ipsCXVDA0qfUWAZNId4ugbDNEuoJ/A+FLby5Ii0F4+j522fjLqFhoxp+ioJTJW2g2GAh
         Q/Nw==
X-Gm-Message-State: AOJu0YzKZIhVnKtdhTqcu8AGRdpztHgHQJifZdeoDGwopA2munSR1rSo
        einqkl3Lp1M9L8BFA0DS5x4uccUwIhw4pYbR8To=
X-Google-Smtp-Source: AGHT+IFp+NEHRFUKuAy1pqf2VBR4CxqmV0ADWP7stB4tNq570F+Eaclh4RTGeYYFq0aQ2m45fkueTw==
X-Received: by 2002:a17:902:f342:b0:1ca:7669:fbb0 with SMTP id q2-20020a170902f34200b001ca7669fbb0mr12962619ple.49.1698228962350;
        Wed, 25 Oct 2023 03:16:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b001c61bde04a7sm8811300plh.276.2023.10.25.03.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 03:16:01 -0700 (PDT)
Message-ID: <6538eae1.170a0220.b4648.cf0a@mx.google.com>
Date:   Wed, 25 Oct 2023 03:16:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.135-237-gbc0ffd9b5ee2
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.15.y baseline: 158 runs,
 1 regressions (v5.15.135-237-gbc0ffd9b5ee2)
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

stable-rc/linux-5.15.y baseline: 158 runs, 1 regressions (v5.15.135-237-gbc=
0ffd9b5ee2)

Regressions Summary
-------------------

platform | arch | lab          | compiler | defconfig          | regressions
---------+------+--------------+----------+--------------------+------------
panda    | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.135-237-gbc0ffd9b5ee2/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.135-237-gbc0ffd9b5ee2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      bc0ffd9b5ee2ac6b8d9c4d3eba4b4facfb911ae1 =



Test Regressions
---------------- =



platform | arch | lab          | compiler | defconfig          | regressions
---------+------+--------------+----------+--------------------+------------
panda    | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6538ba1b771c0da64eefcf02

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-237-gbc0ffd9b5ee2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pa=
nda.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
35-237-gbc0ffd9b5ee2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-pa=
nda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6538ba1b771c0da64eefcf0b
        new failure (last pass: v5.15.74-2-g741b5047a5f58)

    2023-10-25T06:47:26.020061  <8>[   11.792480] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3812592_1.5.2.4.1>
    2023-10-25T06:47:26.126703  / # #
    2023-10-25T06:47:26.227754  export SHELL=3D/bin/sh
    2023-10-25T06:47:26.228088  #
    2023-10-25T06:47:26.328873  / # export SHELL=3D/bin/sh. /lava-3812592/e=
nvironment
    2023-10-25T06:47:26.329297  =

    2023-10-25T06:47:26.430111  / # . /lava-3812592/environment/lava-381259=
2/bin/lava-test-runner /lava-3812592/1
    2023-10-25T06:47:26.430763  =

    2023-10-25T06:47:26.435793  / # /lava-3812592/bin/lava-test-runner /lav=
a-3812592/1
    2023-10-25T06:47:26.491853  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
