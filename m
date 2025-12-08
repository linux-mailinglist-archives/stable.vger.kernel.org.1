Return-Path: <stable+bounces-200310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF74CABD97
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 03:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E65E300D49B
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 02:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB5D27380A;
	Mon,  8 Dec 2025 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="BJXriwMS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A22B21CFFD
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765161029; cv=none; b=dELMYNPehF3aAom6rqIHli0w97KZhXhxRlVA0kSIO16nSlfejrVlZnIY9murqDOD0SuOMKaydjNrprWbsHnsitsdf7wkpn6bmjSryrfZ88gJXBpg8xj97IA0VTQgqF+KkH2Ou62MM3BMxG13kT+jjQUCIx09sVX5YZFUQRKQzKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765161029; c=relaxed/simple;
	bh=4q+3O9YuYXADXgg09xjghLn3wr5Jfare1ulu6VIfhtk=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=PrdWba8p1dBOnbSdnCEldJJ3Jxp9JQFk09WWZJTxsYXYHM8Ni6WLR02jg1b/2MgT9syfy4zo9y/KvZTLmjWslVmFMSNbG6BELUteBKTPQlgaJk3rCsQEkn72qQdN580arjVkx3ieaZDp7qC6eDYg8x3slH/mzG0i32s0IjBHDPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=BJXriwMS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-299d40b0845so66185515ad.3
        for <stable@vger.kernel.org>; Sun, 07 Dec 2025 18:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1765161025; x=1765765825; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRt5hi3k0inBD9ORNRVV8yMHiYEW5i4LJS24UVYzMnA=;
        b=BJXriwMSxJzrykyTSPpLL+VMAtJaBUQO0Nr22fa9rDXO/N8fge1ZQJEg07b9aiuXPH
         vu3KMWBSWAHdY7o4KhsuhWCFnQ8+AJkzGEx+XNcYCrCFeQYW/oESJj74rN5lhw+/lLtd
         kJr4OAonjcGDMjN4Rl4RlazF+Pe5ExBfXzlQ13TqPGUVASaJblrehcP/+RPWDO6HMnJU
         wY1xSDahb2mCH9mh3QWJQf3Ui2EXPlLNRIXU71lQvGDUdZ1vNsPxsVNtY/dh3wL2GIzG
         obPDwyICKTPpIVgu78NdBjMooiZroMy18ehYL4TshFBZ1bpDJOwVvFHJXHinUo5Wk7MF
         kttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765161025; x=1765765825;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRt5hi3k0inBD9ORNRVV8yMHiYEW5i4LJS24UVYzMnA=;
        b=CBEsCV1o2emJF6BwIKFNYAdDN90EJMikO752CooKfMprRJrlji27z0COHJVk6bZaCm
         BVOeo4rRaU2TDfAsZsZAchTz+I+DLS25dQ2w8+J2g6Tjvr0FG3YDUVyCfqmJ/6JD3Hik
         OKeUSo595qdF5GNSdrr0J+S08QQBQff6bGlc3EV7xpUCCNCqY3KaJVb/ttJ2BYwKm3gm
         +to7YYZ+NA0FQto2nLH9AEvH2DCNzN7UTja3734xvtouMgeMEEUvceFfJwDJjZmlz3sm
         qBSvIiozBquIKK+9eYlgcFfMeyzGyA14J02GYhi04WIf2PCcUh6/J5NAKFfF1QEnzGdx
         IdEA==
X-Gm-Message-State: AOJu0Yz4Gec7uzCrNeDyuzYT5Pl0DhSkjKw7ddxa9/BXMEKKqxK2kTe8
	1qIixOH/sLfR6+BY75B3fBNQ4HEpJizQRc7rOqubCSLF5G6eEmrZVk8omcyPy3/ebAI=
X-Gm-Gg: ASbGncsCBZlnvYu3TjsYG0C+EQb0jFeY9gj9oU1nHDemtuyFflRHLXAABYJ0rKeFKq9
	lHs0aUXsZ6dMOCtC22ZZlk1nAoT8XfwxOHvx2BL1niHw01xlFtagQgPCGOFbOYaL7OHNqJOGcs2
	/LbDqlva3UQ5EOKzP+COxpymXmH9aPuRNPq7NEUM+Ix9URxFo486A7FSxH5HGywnv7UHtw/2UYo
	JMGLBg2dWA+TmI38hvPaSAMpAH8flQSHFWSfiXSqaDaU1D9+7jbhEWCtlFfpHcqEK4dvBvJRyFJ
	NTMCQo7N+r71u7KmtBPa1JX1c0dpsqqX/l/O1enfUi1dlPD/0TReisfSdbod2NVkk7MBY/nAgUy
	cdBVQl4HAqCmt2XCHqTeNlJnex6bScaJdHRQt6bDqeoUzI6oVKKPG3kTKz9d6Z1ZhG8ZkeLWoun
	StB8WIq0nc4P8nhQA=
X-Google-Smtp-Source: AGHT+IF0oXM6fDvv0GeSF+7te2CtGLDBtF+7HzDIaYaBfMqH4uY0HkQEG4646ily/PWY62gulFYaAg==
X-Received: by 2002:a05:7022:ba3:b0:11e:353:57af with SMTP id a92af1059eb24-11e03535865mr5950962c88.49.1765161024940;
        Sun, 07 Dec 2025 18:30:24 -0800 (PST)
Received: from 1ece3ece63ba ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2f3csm45817863c88.5.2025.12.07.18.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:30:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.10.y -
 f964b940099f9982d723d4c77988d4b0dda9c165
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 08 Dec 2025 02:30:24 -0000
Message-ID: <176516102395.6076.7454026932218814624@1ece3ece63ba>





Hello,

Status summary for stable/linux-5.10.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.10.y/f964b940099f9982d723d4c77988d4b0dda9c165/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.10.y
commit hash: f964b940099f9982d723d4c77988d4b0dda9c165
origin: maestro
test start time: 2025-12-06 22:05:22.856000+00:00

Builds:	   38 ✅    0 ❌    0 ⚠️
Boots: 	   69 ✅    0 ❌    0 ⚠️
Tests: 	  972 ✅  267 ❌  200 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:6934ce3b1ca5bf9d0fd6c4d7
      history:  > ❌  > ❌  > ✅  > ✅  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

