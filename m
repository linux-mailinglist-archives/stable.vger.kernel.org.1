Return-Path: <stable+bounces-207853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 303B1D0A5B8
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 14:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 241F230ABEE4
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E5835B149;
	Fri,  9 Jan 2026 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="L/F4zWBe"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A05233C1A3
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963547; cv=none; b=GyqgpSeOrL5qJ5APng/BLgskoP2/+Qizu7FltLatc1ISdA6bD1AtyDMl0q9U8301ZO8ddTNaO7+IodWmk1uhOIqV53iwNdJNnRXmtTEItgz6IzTSId00JGVoRHYvwKuA7CUTJ8VLsKYCHSo6JfQV8hI0lRRLkvKsm4D6mV1AKAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963547; c=relaxed/simple;
	bh=JWD1ns03/UimTgvTV3BIIS1yCeecR3hdhmAql0mXkQ4=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=kN6TOskarm7PThIeKI5tP5MLG4rDtRrTrpnh4VJl346tm50zK8PI3EBJpNqRgxxI6Bi/sB1G/T8SYelTqujk3uII8M6LHa59YUnhN0nHA1NP/p8OfSYpoo0naNDyqf2HnHHTvF3qy6BFP1eldbxqiPVjAGX9loenDiVT26rCEJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=L/F4zWBe; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-11f1fb91996so4900984c88.1
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 04:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1767963546; x=1768568346; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nruWATuUBnUP5zzgyeUOVcRGXbEibVZtF1VO3eIlpw8=;
        b=L/F4zWBedNeNskG3sZQhgKAWXvCV+4mq818evCUmQG+sly8jdOy+ZHYj8MmU0LPgfD
         24upC1EvBuAD2PZENgBS09mOOcl6TF6VIOuhYVSlvcFDdqBDuQj4JGMksSpOZXhKyQZd
         +1ajE1NNB/L5MDUyLi3Swsn0MuAaOQ7fA9ERqoBYfOXkDLGsz6MFxtP+7ln20/57ewnW
         WY1QF7u63B+rSnP8G7ecD9PlXgvTBzys4kQYZs/UI1RxXjI3El4pPQ/fOGZ3+MsVFj+O
         rji/351uEEDS1waQkGAgzwlKCSNOZIos8BZoSV2uoPZc5XU81swep+UqM1HUVU7bOhY8
         XsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963546; x=1768568346;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nruWATuUBnUP5zzgyeUOVcRGXbEibVZtF1VO3eIlpw8=;
        b=WdNNn/o20eBksGj9lLN+GkxuosUiKduqtQw5dYqYT266C2Rbcho80twSgQ4jXByfHx
         27Mylx+et8yJFmjLVMwqIwYBDHHhmHisWAY/RJAE6jKjMVBMC6KTwGDR7oITc2kEhNBw
         dn1cP1Y0tDLZDPxFLxI97NMQWydCPGau8hpiqTUc5OlUd5PFK6CKuimYyGXCvcKVbsNp
         IGZ0uffJVaDzrFiuUqMu//jsjVyUj5VJZNvSP24DwXfdE7CSj31Ol4Q8pTGo96hX+ZzN
         dcJ6UABVm5kbgbxNh4FdPav+mOsj4gnek3hoJ28lDukYHfH0gUIfuzcYFymLlcrWeC5p
         EdDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXekmoIZGzjdFADIt2jCMINmttn2HEqGdJmZ8B0405epJ5CTh+w/Zp7YlUyJvIuBoL4feZxEls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ZYz20leobjghZtlHo22ZIzC/rlv0zLGM9y56wBxcwBo9quXU
	x3QCWSkJcPtZVjVBNbRxsWYJu5PSrcYXDfAmKNAIP0yAOrjZmVmeM3pCdeR43bSvNlA=
X-Gm-Gg: AY/fxX4x/qyxUrRCnJIe3viF+Hc9ObHo4dX72MdL2PxyVqAa/9dgEBEhVNkK/33T8z9
	eliuzbcYpV9d13I1Zc1HjDgRXQfIE2ZGMh+YOO+qkv2vkVPyCKPOCVSK5lND5onN6svxVUHV7kc
	FJ04EjUFG38WOlagis2bhdu3B/cF1Jk+NweJRI9Kd/TP5cQUFOE+kGlkq4C3A+xZOAKmN5DDJkZ
	b93yL2KK4Fvs2adDOBXTBaGIxHKPLnqrrzrvyKIE2uXo0N5GXph1WPQYLYzfRcRMOj+S7oJMKWY
	q/xaLr8+MvUQFJNh0hclQDM5D6LTCrilZSLbjpd/I2dSZzEbFREvq3CfPujZYzVRoEOjyE3Xobd
	MWFtymH+Nip5/XSczb96NWrVcudJKrMSOWik4MZQ8L73jU4g+6uHIJtqxURci6Wq49u5kHpAqW3
	8U/0ea
X-Google-Smtp-Source: AGHT+IFmcz5isFk3V55g5aarTBb2X/5f+zvxiTNS1HQTgudND9YZDkrSg7+GbbfqvlL/8ySQ/SPsvw==
X-Received: by 2002:a05:7022:628e:b0:119:e569:f275 with SMTP id a92af1059eb24-121f8b45aa2mr9320933c88.30.1767963545510;
        Fri, 09 Jan 2026 04:59:05 -0800 (PST)
Received: from 1c5061884604 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24346b5sm17520260c88.3.2026.01.09.04.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 04:59:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjE1Lnk6IChidWlsZCkgaW1w?=
 =?utf-8?b?bGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYX19hY2Nlc3Nfb2vigJk7?=
 =?utf-8?b?IGRpZCB5b3UgbWVhbiDigJhhY2NlLi4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 09 Jan 2026 12:59:04 -0000
Message-ID: <176796354429.952.3722081270630564687@1c5061884604>





Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 implicit declaration of function ‘__access_ok’; did you mean ‘access_ok’? [-Werror=implicit-function-declaration] in mm/maccess.o (mm/maccess.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:0c63e4dbb44c9b76d839bfeb8915e39be9e56566
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  0d9534c7d771ce08f816b189a8634517e0ccdb07


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
mm/maccess.c:227:14: error: implicit declaration of function ‘__access_ok’; did you mean ‘access_ok’? [-Werror=implicit-function-declaration]
  227 |         if (!__access_ok(src, size))
      |              ^~~~~~~~~~~
      |              access_ok
  CC      fs/proc/array.o
  CC      fs/iomap/fiemap.o
cc1: some warnings being treated as errors

=====================================================


# Builds where the incident occurred:

## cros://chromeos-5.15/arm64/chromiumos-qualcomm.flavour.config+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-chromeos-qualcomm-6960efc5cbfd84c3cde53eef/.config
- dashboard: https://d.kernelci.org/build/maestro:6960efc5cbfd84c3cde53eef

## defconfig+arm64-chromebook+kcidebug+lab-setup on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-chromebook-kcidebug-6960ef8acbfd84c3cde53e91/.config
- dashboard: https://d.kernelci.org/build/maestro:6960ef8acbfd84c3cde53e91

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-kselftest-16k_pages-6960ef86cbfd84c3cde53e8e/.config
- dashboard: https://d.kernelci.org/build/maestro:6960ef86cbfd84c3cde53e8e

## defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-chromebook-6960efc1cbfd84c3cde53eec/.config
- dashboard: https://d.kernelci.org/build/maestro:6960efc1cbfd84c3cde53eec

## defconfig+lab-setup+kselftest on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-6960ef82cbfd84c3cde53e8b/.config
- dashboard: https://d.kernelci.org/build/maestro:6960ef82cbfd84c3cde53e8b

## imx_v6_v7_defconfig on (arm):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm-imx_v6_v7_defconfig-6960ef72cbfd84c3cde53e7f/.config
- dashboard: https://d.kernelci.org/build/maestro:6960ef72cbfd84c3cde53e7f

## multi_v5_defconfig on (arm):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm-multi_v5_defconfig-6960ef76cbfd84c3cde53e82/.config
- dashboard: https://d.kernelci.org/build/maestro:6960ef76cbfd84c3cde53e82

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm-6960ef6ecbfd84c3cde53e7b/.config
- dashboard: https://d.kernelci.org/build/maestro:6960ef6ecbfd84c3cde53e7b

## vexpress_defconfig on (arm):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm-vexpress_defconfig-6960ef7ecbfd84c3cde53e88/.config
- dashboard: https://d.kernelci.org/build/maestro:6960ef7ecbfd84c3cde53e88


#kernelci issue maestro:0c63e4dbb44c9b76d839bfeb8915e39be9e56566

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

