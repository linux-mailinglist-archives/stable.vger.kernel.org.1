Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676F972C5F4
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 15:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbjFLN3X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 09:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbjFLN3M (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 09:29:12 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD8F9E
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 06:29:11 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-655fce0f354so3361238b3a.0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 06:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686576550; x=1689168550;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A8kTVO8xsKPfip5/PhsOzAra7TV0zUW59K4v8z3e2Fg=;
        b=FpNIw2HEG0aI+wj1N3bHIeMB8llS5oNbMFT8uXs3UMssMmB5FFyBxE9XMQuGYJmcLj
         ggN+f/9qZSOz3Yw86ZLp1cHeF3bKB077TER1A9AlS6ftm0+wNjiZLK2xQwSUMl3S118b
         jMzFrVTnTDx3N/w2wSKZZ1qvw+8NyL6nW2cngsvZQn5iu0RcunPOeUp86Dr808OzLTA6
         HVAQXYYxyGCI96iccEo2PLtA/t9EaGNUMOYhXahhNZnK4c6O3UszlgAuDMbXqacfiPHC
         NwqJ3usUdlPujz+LT1Ai+c9D+f/Xdwg0r3clmvgdF/zgh5OXLlPVmAbzwNzF3wzM19/D
         ZGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686576550; x=1689168550;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8kTVO8xsKPfip5/PhsOzAra7TV0zUW59K4v8z3e2Fg=;
        b=bpNVHk0/DDWAPEMNrzYt8AvYZ23V7Xws/DuEAyBvQj6D21f11CD9cDqeOgL9NTxCyw
         UYnzRI7IUiL8it5NduyaLwOR7ABIDVuzidJyuimLiTXpEYCxxBJmRZj+tv03tiMJN7cN
         k67vH/PHp7MfdgpMCXxXrqZuobaplxpwInc0Oi48Oxhvf1+sWnR10g+GMmwZiEiUJhA8
         6ncBWI8JvG78u+BE9+RODTGe51ubx0X51GA+3wX7/9lap4u62q2NKMHefo8P+mZHIUFk
         a4+5sl+LZzInYU7+4MV+4WemPjGzSXu6a01aZaca0WlwKoFyHwMLS/DGaKGqYGLI5Kux
         QZMg==
X-Gm-Message-State: AC+VfDz0hIiwJEotIFd7L62dmyeg23QA+SSlWr5oghvpRFW+QleV9NL+
        4+gZ06ucyeRW6+w72i/GNkH3F8tgz+si+0cMlqiy3A==
X-Google-Smtp-Source: ACHHUZ6Lw3r0d0WDKs7t5rM1zcb9Ff3cY0qUh1N8ijcgNImfdWcAuNhXcchOiwgIOBkYJbX3UHLOxg==
X-Received: by 2002:a05:6a00:1a8d:b0:662:3964:ee2f with SMTP id e13-20020a056a001a8d00b006623964ee2fmr11344108pfv.18.1686576550465;
        Mon, 12 Jun 2023 06:29:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a10-20020aa780ca000000b00640f1e4a811sm6897280pfn.22.2023.06.12.06.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 06:29:09 -0700 (PDT)
Message-ID: <64871da5.a70a0220.61550.d647@mx.google.com>
Date:   Mon, 12 Jun 2023 06:29:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3.7-153-g1fda3156534da
Subject: stable-rc/linux-6.3.y baseline: 179 runs,
 2 regressions (v6.3.7-153-g1fda3156534da)
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

stable-rc/linux-6.3.y baseline: 179 runs, 2 regressions (v6.3.7-153-g1fda31=
56534da)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
kontron-pitx-imx8m           | arm64 | lab-kontron   | gcc-10   | defconfig=
                  | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.3.y/kern=
el/v6.3.7-153-g1fda3156534da/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.7-153-g1fda3156534da
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      1fda3156534da72bf65987c5ed2d56b55d8c1d19 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
kontron-pitx-imx8m           | arm64 | lab-kontron   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6486e809bb70e6d606306136

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.7-1=
53-g1fda3156534da/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-=
imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.7-1=
53-g1fda3156534da/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-=
imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6486e809bb70e6d606306=
137
        new failure (last pass: v6.3.7) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6486ecfc6186c787c130615c

  Results:     164 PASS, 8 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.7-1=
53-g1fda3156534da/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.7-1=
53-g1fda3156534da/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/bas=
eline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mtk-thermal-probed: https://kernelci.org/test/case/id/6=
486ecfc6186c787c1306175
        failing since 10 days (last pass: v6.3.5, first fail: v6.3.5-46-gb8=
c049753f7c)

    2023-06-12T10:01:19.480731  /lava-10687748/1/../bin/lava-test-case

    2023-06-12T10:01:19.490852  <8>[   28.480575] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmtk-thermal-probed RESULT=3Dfail>
   =

 =20
