Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1BA7D75B4
	for <lists+stable@lfdr.de>; Wed, 25 Oct 2023 22:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbjJYU2r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 16:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbjJYU2e (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 16:28:34 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D0730C7
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 13:27:08 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ca74e77aecso9942165ad.1
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698265627; x=1698870427; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pOyOLJOPzbUw/qsJJ6QsQzwHy6J0glfSG/JDA76Q2HI=;
        b=FPXfOayzR4gZ1eEa4N8ChD/8govETQKqHJjVnq+29aO6tqdgCKEttO17t1hAcOrfHs
         fO3bj3qYeJTTsC48yrDkkzoTRjn49jTchPxPEmHteFVuKZxKpnMVlajXa4CsEGg57Nuv
         cLwaaDtdspsYMd367E6wwVuwHNxZ4dTQkZc7TjdOm7redjUNPNPn3IjrqloEKK3ysSAN
         k707fEyKMif6k/ATUp3yWRpacn8g72y8c4FplMlQJPycI/Vw2oYukYphxsxlLg+OVgUk
         VC08c1z8HbPKXMzIkAKEOU9cvuzHOfYdzPD7U24vy7BFvDRy3zmJ0bR+NIVSuxgwZLVR
         UBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265627; x=1698870427;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOyOLJOPzbUw/qsJJ6QsQzwHy6J0glfSG/JDA76Q2HI=;
        b=kh1q4bMVrYwsZilMapBQ1P09uI3C4YYqbjiafeZu/KOvJbfWL9BYLcbg9o3Y7PXbpk
         HFcf7XX4KfddejaErKqYPTe3Ip28LOyNoWiS5xwH2xVuxt9zjZMJR0TF/BMYPcnTBZcC
         n07dJnn5+ddFwuZkwQuLQRNWft2pmtbRMfLujlwRsvIYseQs1C108aiKHNbESzThh+d/
         z/N5DQRlZl6EyfW4z1R3nnRSS96/f5/uyafhlH1vcvOMKv9Q6NMZ+vhF0zLld0zASAF5
         LK6vxtcJOdPIWX07Ed1nB6iOggMGorIgMXkckOuwf9UiOcQCigB6d6aMIu8eC++RjFmK
         jZhQ==
X-Gm-Message-State: AOJu0YyLKSSrUFR3vZ7+vwOP0UlewG9s5qMvVdRLWXkUNftg6/H/rBLU
        NEYJi0ziPqtqbXW0B4rrAGgpE0WF/KoLvT92E9s=
X-Google-Smtp-Source: AGHT+IEZrTY6E3f+O5leIa3cJFOmR1P+3eOzOXvT4Z5cyyHhuulRgWmIYI/znAPDNW48glbdIdBGGw==
X-Received: by 2002:a17:902:ec86:b0:1bc:edd:e891 with SMTP id x6-20020a170902ec8600b001bc0edde891mr984193plg.1.1698265627366;
        Wed, 25 Oct 2023 13:27:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902ed8c00b001c76fcccee8sm9662120plj.156.2023.10.25.13.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:27:06 -0700 (PDT)
Message-ID: <65397a1a.170a0220.16721.1254@mx.google.com>
Date:   Wed, 25 Oct 2023 13:27:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.137
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.15.y baseline: 147 runs, 1 regressions (v5.15.137)
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

stable-rc/linux-5.15.y baseline: 147 runs, 1 regressions (v5.15.137)

Regressions Summary
-------------------

platform | arch | lab          | compiler | defconfig          | regressions
---------+------+--------------+----------+--------------------+------------
panda    | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.137/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.137
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      12952a23a5da6459aaaaa3ae4bc8ce8fef952ef5 =



Test Regressions
---------------- =



platform | arch | lab          | compiler | defconfig          | regressions
---------+------+--------------+----------+--------------------+------------
panda    | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6539425bc3c04fb105efcf0e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
37/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
37/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6539425bc3c04fb105efcf16
        failing since 0 day (last pass: v5.15.74-2-g741b5047a5f58, first fa=
il: v5.15.135-237-gbc0ffd9b5ee2)

    2023-10-25T16:28:59.288638  + <8>[   11.654632] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 3814138_1.5.2.4.1>
    2023-10-25T16:28:59.288855  set +x
    2023-10-25T16:28:59.393322  / # #
    2023-10-25T16:28:59.494657  export SHELL=3D/bin/sh
    2023-10-25T16:28:59.495157  #
    2023-10-25T16:28:59.595991  / # export SHELL=3D/bin/sh. /lava-3814138/e=
nvironment
    2023-10-25T16:28:59.596491  =

    2023-10-25T16:28:59.697336  / # . /lava-3814138/environment/lava-381413=
8/bin/lava-test-runner /lava-3814138/1
    2023-10-25T16:28:59.698048  =

    2023-10-25T16:28:59.703091  / # /lava-3814138/bin/lava-test-runner /lav=
a-3814138/1 =

    ... (12 line(s) more)  =

 =20
