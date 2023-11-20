Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3887F17F6
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 16:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjKTP5b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 10:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjKTP5b (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 10:57:31 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712EDA7
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 07:57:27 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cf61eed213so7728995ad.2
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 07:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700495846; x=1701100646; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bUL1VABrFrhSpL4oMr23Ab03N/o+EdoLXm13sv8bGow=;
        b=j7SXMHRDPOzYhyA8Ix8IQMvizTGmj2vutRmotvrPFHD1HJsSST0Cl3zjq0DfoWC44x
         IHUh5zwuXyoi/fjS6XSgvxhJrJOXcdJXkJNVFL+zhhkQlbq6KvJVUon/G9ixZ7TE0P4S
         UdICEh39kJFhQ8rqTS7DrW9ZyovecXy3B4fQxujCTfvONktwEUJuJ86jPV5qfQN/yWxu
         wF+lBDJLgHhTyuplZmylQyQwS7n6o+HEtxtOs7HFKgmYC1DRKGuvzK7I2JVqhbGa69jA
         piQq1os2JIhP932OpDbCaah47TaaRaayb64quA3M4Lp8dMJYJxmP50zcIqYaU/gMT4+7
         qzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700495846; x=1701100646;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUL1VABrFrhSpL4oMr23Ab03N/o+EdoLXm13sv8bGow=;
        b=Y4kw4rrNe7cEIL+NIIKs3IrGyg/C+ztmMKGygYoa5L5pi8SAQDQG3tUtHTdlYlDjCD
         GuxTyXZzUqN3PhKelHTsLaMje7Cgd3vvYOENqH1cE15Pr/QgYSoKGrSfVdhH5Yg2/Ggq
         7CkFHtoXvtJGuCulWxHEJ2BCKDep8CbCGzG/rISWIo8FWr2m2YWRq7KsEQ3PM5vRsmkd
         iWwEESRkaA2Acjle/J3AhrZG5qCdX6LVgl8u5oRtupjTHxr1aeFmX5xvGWJZcozDPLzM
         qzfj+dam/t+13qUNMtiTDScMiL8qQFZIYvoDDE6xFX/hwe+u6fytD//6CJ6rEo/V7EcZ
         3Bpw==
X-Gm-Message-State: AOJu0YzWl9WsnrRgR984nvC1biBxaKyYx3Z/gXpA3jNjtTxa1CPTTE4H
        Ir4iXOijxHBnBWHL3GaJGOYb2YwxJXVXUC6ttGg=
X-Google-Smtp-Source: AGHT+IHp7wKsYvUr+0bXxslni3gB8wJnPldG41HQ5nMp3B4ErzUzfdH3NgNwaRPKkNhUFeLguXVIqA==
X-Received: by 2002:a17:903:1ca:b0:1c3:3b5c:1fbf with SMTP id e10-20020a17090301ca00b001c33b5c1fbfmr10157546plh.10.1700495846222;
        Mon, 20 Nov 2023 07:57:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090274c300b001cf50e0507asm4418788plt.11.2023.11.20.07.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:57:25 -0800 (PST)
Message-ID: <655b81e5.170a0220.4c91.9548@mx.google.com>
Date:   Mon, 20 Nov 2023 07:57:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v5.15.139
Subject: stable/linux-5.15.y baseline: 154 runs, 4 regressions (v5.15.139)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-5.15.y baseline: 154 runs, 4 regressions (v5.15.139)

Regressions Summary
-------------------

platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun7i-a20-cubieboard2       | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =

sun8i-a33-olinuxino         | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =

sun8i-h3-orangepi-pc        | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =

sun8i-r40-bananapi-m2-ultra | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.15.y/kernel=
/v5.15.139/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.15.y
  Describe: v5.15.139
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      2a910f4af54d11deaefdc445f895724371645a97 =



Test Regressions
---------------- =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun7i-a20-cubieboard2       | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/655b4a3ec80db2b9577e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.139/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun7i-a20-cubie=
board2.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.139/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun7i-a20-cubie=
board2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655b4a3ec80db2b9577e4=
a6e
        failing since 11 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun8i-a33-olinuxino         | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/655b4b927c1400abbf7e4a6f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.139/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-a33-olinu=
xino.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.139/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-a33-olinu=
xino.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655b4b927c1400abbf7e4=
a70
        failing since 11 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun8i-h3-orangepi-pc        | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/655b4c0aafbd704fbf7e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.139/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-h3-orange=
pi-pc.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.139/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-h3-orange=
pi-pc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655b4c0aafbd704fbf7e4=
a6e
        failing since 11 days (last pass: v5.15.137, first fail: v5.15.138) =

 =



platform                    | arch | lab        | compiler | defconfig     =
               | regressions
----------------------------+------+------------+----------+---------------=
---------------+------------
sun8i-r40-bananapi-m2-ultra | arm  | lab-clabbe | gcc-10   | multi_v7_defco=
nfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/655b4a2af2cf90516b7e4bd1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-5.15.y/v5.15.139/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-r40-banan=
api-m2-ultra.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.15.y/v5.15.139/=
arm/multi_v7_defconfig+kselftest/gcc-10/lab-clabbe/baseline-sun8i-r40-banan=
api-m2-ultra.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/655b4a2af2cf90516b7e4=
bd2
        failing since 11 days (last pass: v5.15.137, first fail: v5.15.138) =

 =20
