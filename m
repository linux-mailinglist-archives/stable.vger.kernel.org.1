Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4748D7E6E85
	for <lists+stable@lfdr.de>; Thu,  9 Nov 2023 17:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjKIQVe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 9 Nov 2023 11:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKIQVd (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 9 Nov 2023 11:21:33 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C806235AA
        for <stable@vger.kernel.org>; Thu,  9 Nov 2023 08:21:31 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc7077d34aso9131355ad.2
        for <stable@vger.kernel.org>; Thu, 09 Nov 2023 08:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699546891; x=1700151691; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e89d33Hy46eGm1f8p9NuUhbcACH9Nn4RV7P6pbaJhCY=;
        b=T5nl5rEJaYHy3rKROakw0A4hP9hhTDeHP6d25vtrIqXytTiB7zYO12kJo0jO3m9fKx
         a2wnjAdpcGv0zxRtptxUyG/5xbTSCSRt4BDWZAhuiYyXD80chSck6W+1ld4tlEZlaIpa
         rtMRfe9/Ge3bDNwfVip3BK9VN8lg+Wq5HX7T5BOtJ5vAxTY8khhVymBECKo97SVh09jC
         A+CF3pCFDiYWL4O1qYoja77oSVq1NC+iGL3dRIQbaPEmQh89b9Y7uyGp9GwadvF2NjDh
         ltkTVZcAZBaeOADCTelS/0VA+PziUbjDZEev7am9Zz+VRf/2lFd9OtdnuehiYYVIG2kK
         FwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699546891; x=1700151691;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e89d33Hy46eGm1f8p9NuUhbcACH9Nn4RV7P6pbaJhCY=;
        b=fXNfkfsrr+JB/SAPL9FjWt+emz5SRDj8ZqzkumauQdTBjZGnC6QzuqJ4UiD8D/Sl07
         2TSwDMH2KZvgPTyNFiLc42YuR9GGE/6W6QyvnLVws1MlRBVQ/Mjvo4mB9sJJHgJ/Wacd
         Ln7vgAUHN7DnunFmYub/1CdkLZcaIDh6wzGrZda6arSQmFu93pB9zKh2Ean1gNJt9y4w
         dNbKZjHMnFa/UWCbyi5l72vljzN2+7n/XgNzNeW7idfBvfopvzLJrGdRBNf9SX9TaW4Y
         Czm6zwZyFSBmsjaVmbKEAqfWQeNgcLGQbAl61qXRDcmu7HpCQdFN1A3SeH/5MOJiSb/7
         fUQQ==
X-Gm-Message-State: AOJu0YxEldF+DFvyxvEl/fXVsz8/xvrR655eZxXTh5k/Yzxf/tXhvztk
        HKdw6YRaZe7iw2WxVQ1xL/yiXkzth1RE3whBFBfCKQ==
X-Google-Smtp-Source: AGHT+IHxZDPpWEr0FLpVDjS9NRS+Acr+QyTT5jgBJ/vHHymCf8zr3auwDeaomTKLRU4M4BggO/CpGA==
X-Received: by 2002:a17:902:7c0d:b0:1cc:e823:c8cc with SMTP id x13-20020a1709027c0d00b001cce823c8ccmr3661064pll.41.1699546890807;
        Thu, 09 Nov 2023 08:21:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b001cbf3824360sm3765638pll.95.2023.11.09.08.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 08:21:30 -0800 (PST)
Message-ID: <654d070a.170a0220.bdf7b.bf18@mx.google.com>
Date:   Thu, 09 Nov 2023 08:21:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.4.260
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.4.y baseline: 109 runs, 1 regressions (v5.4.260)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.4.y baseline: 109 runs, 1 regressions (v5.4.260)

Regressions Summary
-------------------

platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.4.y/kern=
el/v5.4.260/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.4.y
  Describe: v5.4.260
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      87e8e7a7aa1f96276252a90373de1d56add31918 =



Test Regressions
---------------- =



platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/654cd60ff2c48c3ceeefcf16

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.260=
/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.260=
/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/654cd60ff2c48c3ceeefc=
f17
        new failure (last pass: v5.4.259-75-gca21f12ba7d85) =

 =20
