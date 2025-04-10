Return-Path: <stable+bounces-132173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F455A84934
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 18:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C4C3A92F7
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43671E5B62;
	Thu, 10 Apr 2025 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s9hwh82a"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F8B1E98E7;
	Thu, 10 Apr 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744301088; cv=none; b=mTRZU+YTCWJoOmGwpGFg4pi4uHUF4xlfJ4HaLrOmHElSLvkk7/i4QszKXGXXIN0IFN7raArs4d6sv9h80bZ+Y3ylU+H/eehezUKvjGMjlphlc9tyKw5GS+9wDydeRydLQxm4LUM+s64q1brdbarc4Z5ER/dd2Vl+ALj035mcDCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744301088; c=relaxed/simple;
	bh=Ldkshp3qHqZUpjJXn5OV5qGrTgV/cfu+Yf9jACfiSYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Kr+lhvFEDjF8VSNJaFj5mhzabzYEMJjrB+RPdLuIpPC2D7/t399Z4h9MDJvsZgCfN0UIY70ds/XCTcF7pr2JSPszb3PfAVjAB40q7gdf+Yrow2TkrCT2DR2C2YaRK0R1CveiMb+JfaLfq5XXxSGwNKZV2OCYAsUk+FMc5HQgoWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s9hwh82a; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id AC2BB21165B1; Thu, 10 Apr 2025 09:04:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AC2BB21165B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744301086;
	bh=2NiEa9beOAZxtn1XHcoAVYmj6lVuKUzGXzW/0nksqCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s9hwh82a5mglj/KK5dX3BT/3MGb05LHh2Q02Yd7CY365wzd3/kRQjysJI/oH2gdo4
	 nK3u30cFr7NwR1lUxa9w4b/EHmPAxcg42uSIrHenVO+5y5SJt+/qk8fd9DESD2wcwa
	 K2IyT72loenhWYmXI+PXxk1Bby5P92MuJ4YmXLAE=
From: Hardik Garg <hargar@linux.microsoft.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org
Subject: [PATCH 6.12 000/426] 6.12.23-rc3 review
Date: Thu, 10 Apr 2025 09:04:46 -0700
Message-Id: <1744301086-13603-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250409115859.721906906@linuxfoundation.org>
References: <20250409115859.721906906@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.12.23-rc3 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
27757853  17715822  6393856  51867531  3176f8b  vmlinux

Kernel binary size for arm64 build:
text      data      bss      dec       hex      filename
36408685  14997213  1052816  52458714  32074da  vmlinux


Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

