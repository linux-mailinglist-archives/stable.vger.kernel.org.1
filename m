Return-Path: <stable+bounces-114349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B972FA2D15A
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 00:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D05916A931
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C41D1B6CEC;
	Fri,  7 Feb 2025 23:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UUGVnvYl"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED3618FDAE;
	Fri,  7 Feb 2025 23:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738970251; cv=none; b=qyECiUSsMqTDUEZu2r+fiVaOPeerFJ27VxgRBfNFeQz3FznqEEFZNwCFzr3D2mbScryLXygNxTstEB+f3LyhjextZITMrhElbzK2tgZ62mzjGLCa0DGGmK6vorRlWPoPOjHDXMGWMxD0lL1q1kGrxWTV6S5u57PtuO0DJFkci6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738970251; c=relaxed/simple;
	bh=z0Yows61LcluSW+PhJokkXelMQQXDWkijFKjNrQ66wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WCi5wB7FoM9DnkjI6fCR3gKgfnMZry03p/rS3Qlw/msvux8MUSyisR4wTsgNin3ZdJPBNwQA1uEmK9HIvPHxc5SXP7cUb93rx4Pvjlgwr12Uv0GtGTCfgVoFbVBNkiTLsnG85m5Ucg6O4iAUVZTFydGfI9PmFirpcRvViacK8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UUGVnvYl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 597E52107303; Fri,  7 Feb 2025 15:17:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 597E52107303
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738970249;
	bh=hM2MvHW1MIsziHJfvv/wt0JERZC+9c6EyBUj8UIUTSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UUGVnvYlZrGHzBt42lG23KiQ8C+QjjIowLsxAJKbGDwvcww/QeIx30K1emUUk6hix
	 SaJWcsN2j8LXvhrwSeS7AIzmlKYrUseu/CMB1YucpGSjRpEDBcE5cFLbsi2zUYeyU5
	 TFqkQ6FpakUIzEqkG6elgE7VvJdz00lbwJ64W7Sc=
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
Subject: Re: [PATCH 6.6] 6.6.76-rc2 review
Date: Fri,  7 Feb 2025 15:17:29 -0800
Message-Id: <1738970249-6852-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250206155234.095034647@linuxfoundation.org>
References: <20250206155234.095034647@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.6.76-rc2 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
27313145  16699374  4653056  48665575  2e693e7  vmlinux

Kernel binary size for arm64 build:
text      data      bss     dec       hex      filename
34662746  13840386  970368  49473500  2f2e7dc  vmlinux

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

