Return-Path: <stable+bounces-8385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2C581D4AA
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 15:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEACBB20E9D
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 14:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB9CCA78;
	Sat, 23 Dec 2023 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="UfxWPvFx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2856DDA1
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3d0faf262so21789805ad.3
        for <stable@vger.kernel.org>; Sat, 23 Dec 2023 06:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703342447; x=1703947247; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KE1XQ6HDFwvihZQo5kmc1A0gButQlZBEMfMbvjaDXtE=;
        b=UfxWPvFxTbtxgikUdLdh9SyW4D0H5VzQKAHFnd2uyY8bquLpGHVdGm6sXChSC0lgOz
         b5qRYo1rWCKnB+KV3xWDIuO4nhAZHv6teDG3qWjQdWLMqcWPPJ4Br7WK/Wortd4W8+QZ
         qNaQDBOkFlwCo8EEtFPu358gwG7FIUygmOHy91pnaiSWWwW+UnO+J0yvItZCRiabl7Ro
         yiPRNHAyQ8MyFDH9/BusnBXF/RErSOTPZfuRWr9rSsR84Y1SwCH2QappqMTsiL1GJ8H1
         kKnrfKWxfUQF6jhYPpZdbRh183WmtOFuzjEvsmr1FAtamNQAtHetr5b7MHaD9DQ6kZ78
         9XgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703342447; x=1703947247;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KE1XQ6HDFwvihZQo5kmc1A0gButQlZBEMfMbvjaDXtE=;
        b=JnxVZkWcm6MSq1CjsV+nP+kvVGOgMHYMsO/4tgXCUGhV7EgAC054ynb5WQC6S/1wzG
         GAkNvkMbrXIu54vw8QVDuxxCmLjS6VxYLKEJsmhnhb5w9CNDG3Zacb44b5KGEIpvR3Ho
         hLQ5iBGUVJdX/eU4V6GBmqBsnbBSqS2ZvnyExuTnVW7wHlCxzz36+AgfT56/OOw7k5Ez
         bUHOuodSHhZTA4JsEQPdUf6OvNxFbDuFrc6W/3j6I7Oq9IgTqBMmBtV0uJyHxONgzrs6
         7fIBCvuJHhbyC5O+siXGD6eKXvSzo0rMnHoYe0S5sWleq4iQQfavQPZ0DfhA1J+fQHGP
         Ufgg==
X-Gm-Message-State: AOJu0YzxH85ijC+Y2WQCr2m52lAA6ItDgCHTMTHWb2gYvx0+7MmHux7P
	gAfMhxU4jzTAhUk1qyRzqlssrTYPuL89+3nfW9e2VZ9wYqk=
X-Google-Smtp-Source: AGHT+IHX31SwvpzMnUp8rRYDjnMftl8OXKRE3DP1rSpca5Deipj0UBcws+mnVOThiqAngC29RqfL1Q==
X-Received: by 2002:a17:903:114:b0:1d4:1b8e:30d1 with SMTP id y20-20020a170903011400b001d41b8e30d1mr2711485plc.29.1703342447563;
        Sat, 23 Dec 2023 06:40:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d10-20020a170903230a00b001c5b8087fe5sm5193110plh.94.2023.12.23.06.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 06:40:47 -0800 (PST)
Message-ID: <6586f16f.170a0220.d0975.fc2b@mx.google.com>
Date: Sat, 23 Dec 2023 06:40:47 -0800 (PST)
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
X-Kernelci-Kernel: v6.6.7-236-g0ddffa163cd8
Subject: stable-rc/queue/6.6 baseline: 112 runs,
 1 regressions (v6.6.7-236-g0ddffa163cd8)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.6 baseline: 112 runs, 1 regressions (v6.6.7-236-g0ddffa16=
3cd8)

Regressions Summary
-------------------

platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
mt8192-asurada-spherion-r0 | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.6/kern=
el/v6.6.7-236-g0ddffa163cd8/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.6
  Describe: v6.6.7-236-g0ddffa163cd8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      0ddffa163cd841bd63e048102ab1bc5b6d5f8a21 =



Test Regressions
---------------- =



platform                   | arch  | lab           | compiler | defconfig  =
                | regressions
---------------------------+-------+---------------+----------+------------=
----------------+------------
mt8192-asurada-spherion-r0 | arm64 | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6586be68ef9255ca93e134c8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-236=
-g0ddffa163cd8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseli=
ne-mt8192-asurada-spherion-r0.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-236=
-g0ddffa163cd8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseli=
ne-mt8192-asurada-spherion-r0.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6586be68ef9255ca93e13=
4c9
        new failure (last pass: v6.6.7-236-g5f9f9b8ff175a) =

 =20

