Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4D77D7865
	for <lists+stable@lfdr.de>; Thu, 26 Oct 2023 01:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjJYXKr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 19:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjJYXKq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 19:10:46 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0352129
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 16:10:43 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b20a48522fso259160b3a.1
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 16:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698275443; x=1698880243; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ugl3NYmjIHFY6fy4wh06xTOJDK5TYu77on143In2ZM=;
        b=T66LZRL2T0L+WwS26b+Az3q4H11LmeaKc4xwrmR8GHOFmeRjLhjvCM5wxYJ1hQxeOL
         PJD4/qh1b9p01StDUC4PyplSFkuzDjhWBdmtd8mBEL+3EKMSorhjoj137CkxPuv5LaRg
         2xS+OhHW0exPztQfnXp75BgPAO+sISloyZgL6Bj+sOxyAD12vtWRzSF35ellW9f23i/6
         SR3pqSl19y94E22W/E6clm250HoMcs1TK5YHXty9Ak2aw9NGf2XH/pwuBdto1UY5is1k
         NYHj1/XhMnR63ldVZ+tNQA+B6fMSEKofOLiahxpWjTWHGPlPnoN3re6w7JqPoUfYqNbs
         oq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698275443; x=1698880243;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Ugl3NYmjIHFY6fy4wh06xTOJDK5TYu77on143In2ZM=;
        b=EBjtsmF5KxIhAnpa5Jaa8n9GWpx1c4hkjeLngM2N4Y4ssPM8vtL3t1KpTAaAzkrTqk
         BMRznbRCdlO8wbZOQCntsYKdgLKxiSwNr32ahWTwe/ZiF8tzvrynxZ8Am0w6Y79pie+L
         R4BlOXluKmspxsaL1I5FG0YiVU3Hfxm2vyGPeRh7tH8JdDXBPKlV0oRCLf/qK24LiOzV
         k/juI/KiVPq3gaPo1pXYsPRkN+UVbE1EjQAr8w2Rf6cekpusfwwEpx86uzAtycch+QiP
         S9R+rVW5YnAQO7mnNstROCktVs54X059tb4/9UTt8BxygjHzktD3DJFVk6RklMS/kCsQ
         TGxw==
X-Gm-Message-State: AOJu0YyStdo2Zh+BP87qOaWPWOk8bVMhM+jjSsS/+RxsfhcdfNphj/x+
        UlPjtP5a+PXT+nu9WyogdGdnP28I4YjE2Lu9mS8=
X-Google-Smtp-Source: AGHT+IHsE/g2tK29PydjNCHly0O0XxttwNoEIGi4b0f/m8YrPFkc6+rrPpOa9gXupsphXKNT9s+qOA==
X-Received: by 2002:a05:6a21:47c6:b0:174:129d:3978 with SMTP id as6-20020a056a2147c600b00174129d3978mr6335749pzc.32.1698275443039;
        Wed, 25 Oct 2023 16:10:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k1-20020aa79981000000b0068be3489b0dsm10165868pfh.172.2023.10.25.16.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 16:10:42 -0700 (PDT)
Message-ID: <6539a072.a70a0220.b41f3.2eb9@mx.google.com>
Date:   Wed, 25 Oct 2023 16:10:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15.137
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
Subject: stable/linux-5.15.y baseline: 259 runs, 1 regressions (v5.15.137)
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

stable/linux-5.15.y baseline: 259 runs, 1 regressions (v5.15.137)

Regressions Summary
-------------------

platform      | arch  | lab        | compiler | defconfig | regressions
--------------+-------+------------+----------+-----------+------------
rk3399-roc-pc | arm64 | lab-clabbe | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.137/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.137
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      12952a23a5da6459aaaaa3ae4bc8ce8fef952ef5 =



Test Regressions
---------------- =



platform      | arch  | lab        | compiler | defconfig | regressions
--------------+-------+------------+----------+-----------+------------
rk3399-roc-pc | arm64 | lab-clabbe | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65396a9d949627589eefcefa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.137/=
arm64/defconfig/gcc-10/lab-clabbe/baseline-rk3399-roc-pc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.137/=
arm64/defconfig/gcc-10/lab-clabbe/baseline-rk3399-roc-pc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65396a9d949627589eefcf03
        new failure (last pass: v5.15.136)

    2023-10-25T19:20:38.114559  <8>[   16.116512] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 440396_1.5.2.4.1>
    2023-10-25T19:20:38.219994  / # #
    2023-10-25T19:20:38.321621  export SHELL=3D/bin/sh
    2023-10-25T19:20:38.322193  #
    2023-10-25T19:20:38.423242  / # export SHELL=3D/bin/sh. /lava-440396/en=
vironment
    2023-10-25T19:20:38.423773  =

    2023-10-25T19:20:38.524782  / # . /lava-440396/environment/lava-440396/=
bin/lava-test-runner /lava-440396/1
    2023-10-25T19:20:38.525693  =

    2023-10-25T19:20:38.530864  / # /lava-440396/bin/lava-test-runner /lava=
-440396/1
    2023-10-25T19:20:38.576004  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (40 line(s) more)  =

 =20
