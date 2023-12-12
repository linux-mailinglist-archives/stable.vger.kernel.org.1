Return-Path: <stable+bounces-6409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F1E80E54D
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 08:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7691F2264C
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 07:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6B917993;
	Tue, 12 Dec 2023 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="lrtIoHLg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD45A0
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 23:57:14 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c6839373f8so3814550a12.0
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 23:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702367833; x=1702972633; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kA2bzANlJbuwz9uQwZrpdxhnfEwv1K2R6T+0armRGBU=;
        b=lrtIoHLgBb9RwYDcozgobkHN/llZPIRc7ucdqAHDSws8FK8zDCvHvYoRc6hj5941Yz
         GQ35pHSYiOj4IYnZKBrBEplrGjJHrxNOQSyBcnFYfe1cp9HeZMg9D1Kg3uHgDPJ6WbWL
         Ixer3w+1aLPyPAayV1Ka0z8KwV+zOP8c96MWF6M6v87/4Qpt4rSggc5Wx3Yk/7ScMPCH
         tndu78F+TXOYr8Bak42KY36JMGLnOaT0op7lueHECkLmC96VLnEBOlxES37d+Pi7ljUL
         cxxXTV5vxdtdWC5RfEEW0kHfj+WHQxOuAObF2ESRDhkhPEF6ykWuC2m+bRdVNPhKOStx
         Sl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702367833; x=1702972633;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kA2bzANlJbuwz9uQwZrpdxhnfEwv1K2R6T+0armRGBU=;
        b=tl+HJnJk1c13AXR/htjd9LoFIdnOCOBTq/MjBXwfdbwUewNEpvhbOgbdmU0ZkxaRrw
         aIdU1EGUZFcUhZtpLN+vqC2Xs6QtmjDwQ3Oa3O4jqoLdyEsPTE7I//pWDlOq7NHgM3Q3
         QhUt/NA2Rtf0krPHA5QAVZ6uzrwJ35IgEs4z5WCZuL8ie5axdWW9iUcvxAF5eV2yTNVL
         kNTqiJFlpt6QrA9az1OaCxkvZ+ajHVB06h3dy5vl8fyOjlpNpi1jkSpil048lNRiZw/+
         xOyQH60vCDypKlQ4Say/BR9Dby+9jaRUBq3ZVJVENUlNJFd4EGI1TptbOs2gzK4BJWJJ
         aqRQ==
X-Gm-Message-State: AOJu0YyaDPKBkYeouwqzb1ajrEcCuxetx7PgQXYdAVKcIFvFubPt9duZ
	SKbtT4UT2tBXwtQ+qtgpIfKKIl6pR3UpVf8kM/aa8w==
X-Google-Smtp-Source: AGHT+IGRGQAoKRce4Op8D2orwOJkA0ssL6yJXr1yW7cQWw3QX5ZgBbwo8OwDmc3c4KtCkJzYVmBSpg==
X-Received: by 2002:a05:6a20:13d9:b0:190:e402:8bc6 with SMTP id ho25-20020a056a2013d900b00190e4028bc6mr3424112pzc.43.1702367833382;
        Mon, 11 Dec 2023 23:57:13 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c23-20020aa78817000000b006ce358d5d9asm7772868pfo.141.2023.12.11.23.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 23:57:12 -0800 (PST)
Message-ID: <65781258.a70a0220.31318.6586@mx.google.com>
Date: Mon, 11 Dec 2023 23:57:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.142-142-g83fb9eaaf8115
Subject: stable-rc/linux-5.15.y baseline: 104 runs,
 1 regressions (v5.15.142-142-g83fb9eaaf8115)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.15.y baseline: 104 runs, 1 regressions (v5.15.142-142-g83=
fb9eaaf8115)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.142-142-g83fb9eaaf8115/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.142-142-g83fb9eaaf8115
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      83fb9eaaf811580c8f9c768023db10686fd30985 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6577ddfd832db550a1e134d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
42-142-g83fb9eaaf8115/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
42-142-g83fb9eaaf8115/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/baseline-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6577ddfd832db550a1e13=
4da
        new failure (last pass: v5.15.142) =

 =20

