Return-Path: <stable+bounces-3583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0CA7FFE95
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 23:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0D71C20C6E
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 22:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C3430334;
	Thu, 30 Nov 2023 22:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="XhYM+eO8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E0B91
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 14:41:15 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cd89f2af9dso1496577b3a.1
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 14:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701384074; x=1701988874; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uoMMgS5eqjNOdN75a+2E4PfTWSpWSErdPsXQqDjyQmE=;
        b=XhYM+eO8c19CrWzn9kYdKTuVBYGIRU6sTcxy4ckmRplGWaGoFvGEDv+jJ8FF+5xt0e
         TQEfc1QiuP8Un+6BNI2IFA2vUweQGmC8+t/7KK/QHtTqzvTRQaKmgWJAQDt5RzkhfK+m
         hWJWYK7t/O0UrtNvVxBuybTkNjsfcSgF2qvX5WZXZtWZqMDwrpjUqO0lAdhzRJTljUzl
         O1LFGeEpne7vzRUbZA5DA3O68eFbMlKaeGk5f0xKK38EF/mRR2nij+eDKDIuNyB2/7lq
         aKLyuKYfgGFzUZ2XJm/9zU8YLl6MqAihGUyVgcStXSgW3Hg9BTsixThUf4+UpALd3fLs
         AUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701384074; x=1701988874;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoMMgS5eqjNOdN75a+2E4PfTWSpWSErdPsXQqDjyQmE=;
        b=h1C/nj2Hdn5rR5hlnDn5SQsZfB7CXHB2tsSTcEqdRhB65X6tZvWcjF7ZjCPl7AXCq6
         rJ+Bd26+XcgYCMZwhGVQ8sopsrnoU9jnytlVw6VtFIYXUSEbwPcG/78DzfQ5g3FAV9AB
         6fCQOuTLf6cLttGNcj/8pUKlDp1MNSFVWmriaWAzaVlyh5/QJSr+/feB34HZQiQiFJjI
         SrPwk4EGYO9QS6P/PXIAO0mKbffIOP26o49Hyw8ctHiH4JTefJEXHe98JEpnbZISGw73
         weEMXR18lK0YB5aflCgTKltANfx9wCmpV7vPUlZuPvENeKWDAiC8g1wygZnqfsqYoonW
         qtoQ==
X-Gm-Message-State: AOJu0Yzm5pjZHEiNjxunu6SvnbDkQ4TK3NmCA26I7qKUtFEJ4K6+fPLA
	B/eG7FLeDjT3gOKOTwYeCOBaQ/ndZkI8qYFxHgRsIA==
X-Google-Smtp-Source: AGHT+IFCBlTfW+OOUDa2aSn3pl7yM21fNKk98IvaKiROqIBw8vVjrmdOiC1UPdzt9E9Qbo/G3NxZaA==
X-Received: by 2002:a05:6a20:9147:b0:18c:331f:3abe with SMTP id x7-20020a056a20914700b0018c331f3abemr24392322pzc.24.1701384074174;
        Thu, 30 Nov 2023 14:41:14 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x1-20020aa784c1000000b006cdd9c52f0asm1722641pfn.8.2023.11.30.14.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:41:13 -0800 (PST)
Message-ID: <65690f89.a70a0220.9c63b.5ee7@mx.google.com>
Date: Thu, 30 Nov 2023 14:41:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.4.262-51-g998061b53b73c
Subject: stable-rc/linux-5.4.y baseline: 136 runs,
 1 regressions (v5.4.262-51-g998061b53b73c)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.4.y baseline: 136 runs, 1 regressions (v5.4.262-51-g99806=
1b53b73c)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.4.y/kern=
el/v5.4.262-51-g998061b53b73c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.4.y
  Describe: v5.4.262-51-g998061b53b73c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      998061b53b73cc706fc15740789787f10df1e082 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/6568dcd50a4c94e5817e4aaf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.262=
-51-g998061b53b73c/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.4.y/v5.4.262=
-51-g998061b53b73c/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/b=
aseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6568dcd50a4c94e5817e4=
ab0
        new failure (last pass: v5.4.262) =

 =20

