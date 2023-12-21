Return-Path: <stable+bounces-8251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A5C81B9D3
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 15:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072631C21572
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B261A1DFF1;
	Thu, 21 Dec 2023 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="xKnZtDi0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E4E1DFD1
	for <stable@vger.kernel.org>; Thu, 21 Dec 2023 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d940d14d69so605524b3a.1
        for <stable@vger.kernel.org>; Thu, 21 Dec 2023 06:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703170119; x=1703774919; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SFv0x7SuJgIFV0Sn7BHrLJBTJ8r9pbtypA/y5RUufmQ=;
        b=xKnZtDi0gpTp2mu82olP2u2ra0g/KYi7V2wKX8Gx+g18NV3Wh+cx4m+sGZPZ9XWmk/
         LX6GSLSB/QwAvYpqUE2wFLrgHbWVpTZB06hqp/8YcscfGhpqhxMNIhsLkQPtNMEd8Tw0
         q8lDS/PlSan8dxmFoMp8rVNR2BqcCA7bOe8nIJhbCZlOJsTFb+iRX8Xd9BpHeIrEc6Gn
         QatT+MK+YOMjCa+UzC65ZJpsZ6z8K0umuudTuv/ENuwCPwGvRMYniPYa+wDjfGgkP2JW
         0SlRcs0xmxUCpfpKG5cx9Kc1S0ciq9V781kC+GSa/zEYbfyHNVvsAdgpyOLWmhMkcS+s
         XOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703170119; x=1703774919;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFv0x7SuJgIFV0Sn7BHrLJBTJ8r9pbtypA/y5RUufmQ=;
        b=IuX0RRl/pMCZttonivncf0tlQl0G8fM94S5bcbLnzP1Iipj/0Jy5JRdJ1M5IXpL9PQ
         UlONsnWMfCm55/xBdHe/IFESd5RlzY5+umg4QMLi1rpi9RRYZp/cBb79w6hGvMKf3nbk
         CVCOP2o72157hSdeImDX52zoO76INT0Il0M2Sv/mnbm2ZX0WJ2lSX93AEDlbwtDhbZ9m
         YQwPjN1bFxNOh82SkmPzLGW3a18AkiSyBEpBnSrrb7Y9OiGlF6gkvMyJ4rfNPuYMyHQF
         pCC9fFCKIYDCstX+ssFVZRn5EnutQOFc7rwDMe/cZ6k78boBH0BMQK15TqCqqrPfrgyp
         27cA==
X-Gm-Message-State: AOJu0YzdvXDy2Yvts70eFyTT0C1Sf9HzHOHi1pGf0ZrPObS+F3afTsx+
	3dPjG2TQof70B9hDaR8ULzZWZjV8LrysKiOXdFo=
X-Google-Smtp-Source: AGHT+IG+dKOhDZF62yVI5tbsa212D12Lk+XlXR0TgHt4PbzQFGvvPvdqprGIhOjzYvxuNzYX5e7vwA==
X-Received: by 2002:aa7:8744:0:b0:6d2:ed2a:7b71 with SMTP id g4-20020aa78744000000b006d2ed2a7b71mr5182878pfo.66.1703170118825;
        Thu, 21 Dec 2023 06:48:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i26-20020aa78b5a000000b006cdb17f9ffdsm1697774pfd.66.2023.12.21.06.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 06:48:38 -0800 (PST)
Message-ID: <65845046.a70a0220.d7b91.5043@mx.google.com>
Date: Thu, 21 Dec 2023 06:48:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.6
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.6.7-168-g611edaf5fedea
Subject: stable-rc/queue/6.6 baseline: 87 runs,
 1 regressions (v6.6.7-168-g611edaf5fedea)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.6 baseline: 87 runs, 1 regressions (v6.6.7-168-g611edaf5f=
edea)

Regressions Summary
-------------------

platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.6/kern=
el/v6.6.7-168-g611edaf5fedea/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.6
  Describe: v6.6.7-168-g611edaf5fedea
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      611edaf5fedea04df15f13c80a8d88ab76c9f6e9 =



Test Regressions
---------------- =



platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/65841d385b9a1133c0e13495

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-168=
-g611edaf5fedea/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-im=
x8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-168=
-g611edaf5fedea/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-im=
x8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65841d385b9a1133c0e13=
496
        new failure (last pass: v6.6.7-166-g4a769d77505ba) =

 =20

