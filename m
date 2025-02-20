Return-Path: <stable+bounces-118500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C86A3E365
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 19:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45D019C1E1F
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 18:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D6321420A;
	Thu, 20 Feb 2025 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hzXw3EJX"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4B020485B;
	Thu, 20 Feb 2025 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074905; cv=none; b=bw6AQ+BP4JilsrKqime3sNIPEYKIKXOmRJqBNzXMfsoqa1SrH31uJssIyzKtGaL/apJd+qlPM18ecKYy42mLHc2qbx4eOH6j2lL9sa6mLV/jntMagXAfFvxUfgsPYpdpQEsUe8CSWGgXzmCBmnShFAV/GOIkL3W5YhTSYow6jB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074905; c=relaxed/simple;
	bh=1oD9gNCN/8cXivznEO/Chq/I0p5i5xWNJWJUYshrNa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UALfwclna8LUeg+dyrKqtKr9TcuFzRz0d+DaFGnWyMk0Rhg4xpAJeiQ7GCCLnPswlrmB7F9+Oj2qZqTmp8x3n+lGBbfXsW+vFSuaHgKXR/w8qJlLN3rj3Ah7DEBX0DCAS8ePjn2EpRZvoyuVsTdXQQdPNbMXb6Lnt/ZaZwatvM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hzXw3EJX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id DEEE5203E3A2; Thu, 20 Feb 2025 10:08:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DEEE5203E3A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740074903;
	bh=33h/M801Cj9+m8m8KYQr/9iEIX4iO3QlDg5Q76+UQOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzXw3EJXpD+YV3rkjHinUxjxDshEBF2ToDmZrm8ir00+Oz+HtxCM1UncSic18eWZZ
	 9qmdfnr1CIqxxuxNPnhdp6KUfcnnnplTUS51bAoD+8rRA78cJwXzTB0aKWe5iA5jFr
	 VjyUCZG9oGtg3xWAhHYR8HBBFTObLOUGD/TDMHfY=
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
Subject: Re: [PATCH 6.13 000/258] 6.13.4-rc2 review
Date: Thu, 20 Feb 2025 10:08:23 -0800
Message-Id: <1740074903-7950-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250220104500.178420129@linuxfoundation.org>
References: <20250220104500.178420129@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.13.4-rc2 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
29935838  17832642  6320128  54088608  33953a0  vmlinux

Kernel binary size for arm64 build:
text      data      bss     dec       hex      filename
36652968  15080469  1054416 52787853  3257a8d  vmlinux

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

