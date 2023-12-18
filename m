Return-Path: <stable+bounces-6995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0686A816DB7
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4491C22A19
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 12:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4EF41C77;
	Mon, 18 Dec 2023 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="fjYvkalR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877BE4B127
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d7609cb6d2so282997b3a.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 04:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702901573; x=1703506373; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YaB1XQgj+pKNWhRQxhtAq1i3TL2AjLD+ofZITiJyJeI=;
        b=fjYvkalRKUEiiQ8qdVewW6SOtNODOYOFUWaZnAfM9/HERVUb0NYF+5nX+NxbYLdjqW
         S2y9sDLMF8nT39hbMgNLbz8cOTQsy2jmca7trOOkKAXvUDjiaQ5G/N1Rpr54RA3d3DMt
         SQvD/8IV19ynO2PTPqKgUC/fgyc5sBzwipjoATGQN1wCJw5LqdehvsePMvXvVqyY6dkn
         yyZKYOumVR6fWsDX/HdYQ51HG5WjGO8zIEKzf8VvdraROH2SkPmjBzKqQBGuerGFwgkI
         92f5EYPTu+dTlJhYfY7BoHTl567vDmAIwkTaz9DYzLzkzSnCXzlTen56ch/HnJb7Dw2b
         cGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702901573; x=1703506373;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YaB1XQgj+pKNWhRQxhtAq1i3TL2AjLD+ofZITiJyJeI=;
        b=E2+1Hl0xhkWYBetH7cPCT6Srw5ILw+1MqQXZ5SvWdtUutWtnA3vezPK9tvRtnGKgQl
         7Pd76OOjyeTbYYHPVr9jkHsAyOMr61DaGzBtzMpI7wEg5Lhg4CrE2kw361hJmjp0lcj/
         doNXBzhJhw26wxnjFeS/D+UniosLFnoivHCWp6E4dcreUsHOKkafh/cR7oVNNwwfmAKE
         3gA6xRJB5nsMkDAt72NfxBkSYniWOAsvWaW6BQ0Vz5VLYFl/nIb6NLFM8uguCIQcjrtH
         T6H4isw3SEJn53w/8kDJrq5sUVV0Pr+YfmxAy+kcqkWWhCDPLMN0mGFgu9ViyOSzbCVW
         I+cA==
X-Gm-Message-State: AOJu0Ywr49ku7k1YbvQCIUX3Sb0MFZARIKFFhFOk4QpNlN14Q5tHR+Bp
	IPM7Xdmsvx9h+0tglHSUpO4pBpK1VWoRoS+Dk4k=
X-Google-Smtp-Source: AGHT+IEva3vciui2qapFiNROyfZkq9SSzxWtKhfB66aj/EP2vPWy5D0OsNGp3ilwUwNq1YBpLxxgBQ==
X-Received: by 2002:a05:6a00:10d3:b0:6c3:1b90:8552 with SMTP id d19-20020a056a0010d300b006c31b908552mr8039155pfu.17.1702901572887;
        Mon, 18 Dec 2023 04:12:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r3-20020aa79883000000b006cbb65edcbfsm18606498pfl.12.2023.12.18.04.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 04:12:52 -0800 (PST)
Message-ID: <65803744.a70a0220.2219b.7666@mx.google.com>
Date: Mon, 18 Dec 2023 04:12:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.68-84-gb80fad87cf99e
Subject: stable-rc/linux-6.1.y baseline: 113 runs,
 1 regressions (v6.1.68-84-gb80fad87cf99e)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-6.1.y baseline: 113 runs, 1 regressions (v6.1.68-84-gb80fad=
87cf99e)

Regressions Summary
-------------------

platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.1.y/kern=
el/v6.1.68-84-gb80fad87cf99e/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.1.y
  Describe: v6.1.68-84-gb80fad87cf99e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      b80fad87cf99e36b4ad5e5352f647b7f7bce6f31 =



Test Regressions
---------------- =



platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/658003d79d9ae6017ae13477

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.68-=
84-gb80fad87cf99e/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-=
imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.1.y/v6.1.68-=
84-gb80fad87cf99e/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-=
imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/658003d79d9ae6017ae13=
478
        new failure (last pass: v6.1.68) =

 =20

