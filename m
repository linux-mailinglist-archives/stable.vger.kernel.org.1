Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4C774E2BB
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 02:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjGKAoz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 20:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGKAox (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 20:44:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9077CE42
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 17:44:52 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-262e3c597b9so3733996a91.0
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 17:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689036291; x=1691628291;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fRiGUVYaOB1PvZhKv7q5G7sVJ4FZl5aC21eVvYXBBJ8=;
        b=tycU3m50a+oFi97bNj9fldQt9vGQQar6N64oPPOP/iL0oEPm/AxZJFdyzb9yMdteBA
         OFPZoyvd5T/8C5DGrjNPPDYz5neSMdSWg5VQIw1TABGwsuJJBYogqc8B3MWXKJx19FJn
         JoQW53vvVUvgk28oB4d0KYnv+LuG2atlHcGfY9VNN1uhpMFlGvXy5Gd6Wn2VW8q311yd
         Li6nqfjc1r8NV3QGV5yDmfG39rmj5/zKJxx3htxRdCPArlfPDcgb+B+7wfhpWqOmKlNK
         JL3TLM5zDT2L6/jVecSPdJAyMvnbM1W3vQsdHBrJjIG9G4+2Ox0e3b8Qq4S+h6LaODr6
         cHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689036291; x=1691628291;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fRiGUVYaOB1PvZhKv7q5G7sVJ4FZl5aC21eVvYXBBJ8=;
        b=luLo16ceaPbM5eBKXlJxx5a+vn0nbe2d8/TQybwA657z+o2WyBTaLycOlgl6NYMEJ2
         UTF+9zWzOLH/eqhydjj8CyEc1mGSjpSkIw72Vz9qIpo9KAPZ/y0hcJuX+csK17A4SZeX
         mW5UU2NK3gElL/xDjQbfD6IQ6Rw2XSAGD2VSvrv3VnuUGTpBz1eygm93akeoHrDNTHss
         wySOdU/1Z3r6kfT0m+2+dmZF21tfMkqlORyEuZ3w3yIoUlUDQw7Di6tYo4QuiccMScOg
         Aod/erJ60OP2Fuu22bNnq1xYSY8Lk9pDEk+doVSICxsoOBhxYoHrt0ZhX5pxIslYz3kQ
         6lgQ==
X-Gm-Message-State: ABy/qLa9RqrzRgA+Nx7+VaWoXrtEHe3JFJ8+o8rABsrKHIWumm9ZiM1t
        9grDDUNsfIt1aLorCRgmeO/UXNGEo5/PaRncL2NdNQ==
X-Google-Smtp-Source: APBJJlHdFpDRRHxlZmVTNz91OjIjg6+1/XquSFoAbyD4nNPmXVC3x0Lt9hDshT+3JqQylGCsTD9BFw==
X-Received: by 2002:a17:90a:ebc5:b0:262:dc67:98cd with SMTP id cf5-20020a17090aebc500b00262dc6798cdmr14837459pjb.5.1689036291428;
        Mon, 10 Jul 2023 17:44:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h13-20020a17090a3d0d00b00263dab4841dsm559712pjc.30.2023.07.10.17.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 17:44:50 -0700 (PDT)
Message-ID: <64aca602.170a0220.6ee0f.1cfc@mx.google.com>
Date:   Mon, 10 Jul 2023 17:44:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.3.11-439-g4882b85b0b1d
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.3.y
Subject: stable-rc/linux-6.3.y baseline: 169 runs,
 2 regressions (v6.3.11-439-g4882b85b0b1d)
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

stable-rc/linux-6.3.y baseline: 169 runs, 2 regressions (v6.3.11-439-g4882b=
85b0b1d)

Regressions Summary
-------------------

platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora   | gcc-10   | x86_64_def=
con...6-chromebook | 1          =

imx8mm-innocomm-wb15-evk | arm64  | lab-pengutronix | gcc-10   | defconfig =
                   | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.3.y/kern=
el/v6.3.11-439-g4882b85b0b1d/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.11-439-g4882b85b0b1d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4882b85b0b1dc42e2ee6554fdb1eb956bd2c6015 =



Test Regressions
---------------- =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
acer-chromebox-cxi4-puff | x86_64 | lab-collabora   | gcc-10   | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ac70007f9bc636febb2a81

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.11-=
439-g4882b85b0b1d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.11-=
439-g4882b85b0b1d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabo=
ra/baseline-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ac70007f9bc636febb2=
a82
        new failure (last pass: v6.3.11-441-gb95b57082420) =

 =



platform                 | arch   | lab             | compiler | defconfig =
                   | regressions
-------------------------+--------+-----------------+----------+-----------=
-------------------+------------
imx8mm-innocomm-wb15-evk | arm64  | lab-pengutronix | gcc-10   | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/64ac70b2c78f077680bb2a75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.11-=
439-g4882b85b0b1d/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-in=
nocomm-wb15-evk.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.11-=
439-g4882b85b0b1d/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-in=
nocomm-wb15-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ac70b2c78f077680bb2=
a76
        new failure (last pass: v6.3.11-440-g3b3c1cd9a77d) =

 =20
