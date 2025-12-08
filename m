Return-Path: <stable+bounces-200306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0984CCABD8B
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 03:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 367B83000924
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 02:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A83B274B51;
	Mon,  8 Dec 2025 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="uZtkDBul"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21328237713
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765161006; cv=none; b=WNK2MqPNLS+4DRMEx8y2OEFtNq8TiIHZdJ5JD2KLIppLVs6Dm7+wi29RSLXGipNVqstXscURSAb23qb0FhBDNkn/kBWSE89/4CbUgNjhR0zw3lKKhqgDKQYGbB3Q1+4BMoYDIrLxPUxqzZYxIPOgQ6lRNJF2wCD/ijklNRgpSDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765161006; c=relaxed/simple;
	bh=xiJZPms0PiP/upw21jd6j2Ylg8fEjw8wjWhupiPUvas=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=XwDwDdhNFJv1/0r+HosshbQAEEj7qerVF+xT0kS3tuFf2dkkakr00nDu5xlO9MfWUQFIRTae6x9Ub0tWOZ5pmacC5XNTKAYRisaVIXH/AcYH4ZXJX+ZOdC48uYC46sCU/6N4dhBnpEgXzTiFmklpE651O/7P+HWwIZXotNaPNBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=uZtkDBul; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso2160323a12.0
        for <stable@vger.kernel.org>; Sun, 07 Dec 2025 18:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1765161003; x=1765765803; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0ZnmUTJp5LGs3m3+7yqvfIp4B01nzjSXhUBc9KqWdI=;
        b=uZtkDBuluoRGUZ8eTepGKbyKz/ayMvi7MdzxiWIIVAuC7f0C+AMlQ6mgE1hS7HlXMa
         sFQaDYbrMO4WJJiTxBNji18i6azytwwrkrIrYWGcaQw+RamsvrhUSqGPCidhaLQY7ehr
         qn2bUZR9l57TTpe/U8KLj0ch+QadEVT8WPyJmFq+d+q0C4xP1IyZYpvkmRJ2O3zjGDwq
         bstx6ue7tlbrqnp7ePoImYscS7DouiArF5+8Zdbld2qYbNuAXZSuFIMQYca815U+UXXh
         Z+nU4Z3nNRcouKgVW8ol0FaMBnCqCL8WmF2VlfTOSLu33P1EJKo7A2DbVDg5T59umZxN
         jcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765161003; x=1765765803;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0ZnmUTJp5LGs3m3+7yqvfIp4B01nzjSXhUBc9KqWdI=;
        b=VmSBwfnDz0qP5HyrNDft0+RS407dkUfXyKaoTsFaBcyjPeus9iNGK6e9Z7Q4I/3aB6
         02qdt+AX5r29g7tFC46+37vsAJ8BTlVT6iSUyt0/hD5mBBFhdqgMKg8S6hqIQiSloaKw
         XjI4yyfEm3LgoP0DlLDPTnwybSOOAFahFqsXwU4mOTTjDW5iDRBhI1T+lAqKBhrpg8gP
         N6BW9D0OWoThGZwjOp651ag5b/BFjcPfyrZZCza1SvHlKa59vsW0WQsN2ujD+7t3ETYa
         XslPDrhyoBh9A18bRdogilqtJh/w+Y6MhzczHvXaDOsmfwGEQ4LtxHfeWCZd0va3VkUR
         x4hQ==
X-Gm-Message-State: AOJu0YwnZCdR3TGRyaODApr9WD9UhKWRGKIg4kDLZUqbC29hnieeUJIG
	KmqRxtgq7FY2fdHgejS33OryQNbbyYNFOzYzDC/6hT0uDzV1wI5f8DoZk55cjNoO6OlVGJH0LD8
	0Sw7hlAA=
X-Gm-Gg: ASbGncvV3LEN0qfDLH6EL3/r15RXxSnmd1rDWizh9IPmGsd9MpN0CAkOO5rJUNqsgef
	SQIUiQ9wGWCFOuwitbWusANFrBJKkVogdVkd4ifv3EIBZUdf8/aIwa4AJRK9wg6nhR04FvWbxWK
	S6bdpOIkS52Z8l9Tw/FeVbxwghSp0yQeuPlBhSn/f3Wa1B9z4Oac+WpAfbnCCjzJSt9p0j+Vm6u
	QRf+JuM1i2f9HwClDLoFAwd59bsUUa6GjB/3fxPn8FhYLFk1JDMlKMOqZr1rclElyCQYvS1VWOm
	Qzkv7f8Jpq7bs3k9ET1hxQSwDWk/09KlaQM9NVehuUhGl4UA26KAQevk63pnMY0dql+4sNepGJW
	P7XB5tmrx1iowUHxGpLmFVCnawJYX06eting1atbQ4ZELzeSoTZMSYC+C89JoxnqtePNumAZovU
	/aBA0u
X-Google-Smtp-Source: AGHT+IGhWEPsaz3hgND4i0UF/wm80MW10guGlA3ugkhm2lGcHUeDGPLKmAftcTeSEKF5I6SJPj6Rng==
X-Received: by 2002:a05:7301:4291:b0:2ab:9418:977c with SMTP id 5a478bee46e88-2abc71f562dmr3392908eec.28.1765161003099;
        Sun, 07 Dec 2025 18:30:03 -0800 (PST)
Received: from 1ece3ece63ba ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba87aa5fcsm31861380eec.3.2025.12.07.18.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:30:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.1.y -
 50cbba13faa294918f0e1a9cb2b0aba19f4e6fba
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 08 Dec 2025 02:30:02 -0000
Message-ID: <176516100180.6076.946683599491537468@1ece3ece63ba>





Hello,

Status summary for stable/linux-6.1.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.1.y/50cbba13faa294918f0e1a9cb2b0aba19f4e6fba/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.1.y
commit hash: 50cbba13faa294918f0e1a9cb2b0aba19f4e6fba
origin: maestro
test start time: 2025-12-06 22:05:23.711000+00:00

Builds:	   35 ✅    4 ❌    0 ⚠️
Boots: 	   47 ✅    0 ❌    0 ⚠️
Tests: 	 2078 ✅  242 ❌ 1351 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:6934b8381ca5bf9d0fd66360
      history:  > ❌  > ❌  > ❌  > ✅  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.



This branch has 4 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

