Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71245749220
	for <lists+stable@lfdr.de>; Thu,  6 Jul 2023 02:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjGFAAv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 20:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGFAAv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 20:00:51 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15896199E
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 17:00:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b8b318c5cfso22705ad.1
        for <stable@vger.kernel.org>; Wed, 05 Jul 2023 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688601649; x=1691193649;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fLTXggKRC3dA0xaEeWzXwWPadxO9IedEfVtfvOBvKZw=;
        b=QR8CsMCuK+GxP6BuekM+i6zNmXVbr7be4mfN8PLCh9TWjj2EFShu2StBgLr2pDmYin
         dYi4zOCtHT03616H/Kwn+nmfBfOrgTN7HpNvuSW1OJsjWiR96qNoBdDomeAn7l6BRxsk
         73bir1SjrcTMHBjmD36GxSYLnEw3T4bB8seVxL4XNapxGALsVOB4joSVCxM1XgzB1G7M
         CnDE2vRw3V34UHtgSZLNxZLI35d2EdlpwLiR0g1Ibm2D0cOlB3OxpislQnwEFV0nNlD+
         uZwMovbCSVHkVNQQ2MjyRU8eYgYdPuBrQivm9173fL3ia8hrUDEifPAhVtsTGyqDBn2t
         ixsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688601649; x=1691193649;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLTXggKRC3dA0xaEeWzXwWPadxO9IedEfVtfvOBvKZw=;
        b=bJeLu9DbVZ5llwEBlHM2P8BmhDshrTL3mhb7nLj0rGgdYXtDhvamBO5vpSuUNrIEzO
         pJI8SofMF7UArVlEdkOPdgYLrMrQqdtwF7uvEXkA81fZrZfbvXF7dqHDdL0dJvg3Mh5r
         i6hqCMZLFjmhkUInF1M8YM1l1zvklBGucYst+yXexcrijmbKnVo8lfZ+b4lDnJePjank
         XqFMp+vtq65gNODOb8arrpgU6GBiRSSg24gsI5di+XovMrK1Qi2hM3LY3nWfzhvDSWtF
         b5H9iLkvQd5oYrnu1Kv2cq0dti5fzF8V9cs+/OmO9XTgYJml1iLb1P1/Cw8c7zwk56rJ
         YdKw==
X-Gm-Message-State: ABy/qLZD/R5n+CdvjwiAfxBY5xapdDPaJXiJlrLDlIfNUblzPcmNppx4
        39SBDAY79AxB5tV1C6Zf4Ocf7DK4gX0CN0O+xiDFWw==
X-Google-Smtp-Source: APBJJlEr24KfHmNIYlj7gY64CbqGeQGQA+5B8ufmfCEE6ZrHuT73dvdZNgS6HQjeo4ar6a0av5mucg==
X-Received: by 2002:a17:902:e80b:b0:1ab:11c8:777a with SMTP id u11-20020a170902e80b00b001ab11c8777amr455802plg.13.1688601648976;
        Wed, 05 Jul 2023 17:00:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b001b85a56597bsm41985plg.185.2023.07.05.17.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 17:00:48 -0700 (PDT)
Message-ID: <64a60430.170a0220.71309.028f@mx.google.com>
Date:   Wed, 05 Jul 2023 17:00:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.3.12
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.3.y
Subject: stable/linux-6.3.y baseline: 126 runs, 1 regressions (v6.3.12)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-6.3.y baseline: 126 runs, 1 regressions (v6.3.12)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.3.y/kernel/=
v6.3.12/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.3.y
  Describe: v6.3.12
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      eceb0b18ae34b399856a2dd1eee8c18b2341e6f0 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a5ccde3deaa75484bb2a8c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.3.y/v6.3.12/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-chro=
mebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.3.y/v6.3.12/x86=
_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-acer-chro=
mebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a5ccde3deaa75484bb2=
a8d
        new failure (last pass: v6.3.11) =

 =20
