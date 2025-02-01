Return-Path: <stable+bounces-111867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F6EA247B1
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 09:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30573A8483
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 08:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B78A13BAD5;
	Sat,  1 Feb 2025 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dkEgSx4L"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EAD25A621;
	Sat,  1 Feb 2025 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738397769; cv=none; b=fO0DnGtM54NuzAz+YMcxV8B2Kxp9MjVFvNSru91etLDqjTm+NPlajctcrRTo7sY2JSpP710W4ExyYH4PuN305JGoHpreZaRxGGvJqkuSNTrg0y5CrVg0sP+ErR+etV5FtAb85EjbeKTSsbE5m6RYEnfWtkIxXkp7JesPd/RwHTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738397769; c=relaxed/simple;
	bh=/VC/a+P6iCP2pEIsW9gY3qE7RSxAWZO7XlMdDqa8eYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=A3U3J7QzmYweQxcpHQPyV/WMIqOG4ZLwW0B/dypAXJyKmiECZqSGGQDrOO2biZuS+GoGaLZNyZjn5SdpsjJ/5mtTUMjuH/kR74srgpFweph+KkqxtL/c9yPgHYI5/mfATJ1qygKAfF16IvS3DZvhelXfxfxGYfIZwvloffMCUSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dkEgSx4L; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 88A2A210C333; Sat,  1 Feb 2025 00:16:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88A2A210C333
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738397768;
	bh=/VC/a+P6iCP2pEIsW9gY3qE7RSxAWZO7XlMdDqa8eYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dkEgSx4Lq6y5BW1v/A3BAXlAVQQ/tymp3MioQ47HZLjnW5+Y5G80M4qgf236iKDWw
	 +efsK6QQYp4a/39CI1EcGayDkkEwo/6oAn+ZpaYrePxYhbsbyXrpvy7PWBMY0Xu1zf
	 n2YEmUR/A38ntPTkZgYZ0C1VvF9p8a02Jpcyhoyc=
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
Subject: Re: [PATCH 6.6] 6.6.75-rc1 review
Date: Sat,  1 Feb 2025 00:16:08 -0800
Message-Id: <1738397768-7556-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250130133458.903274626@linuxfoundation.org>
References: <20250130133458.903274626@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.6.75-rc1 on x86 and arm64 Azure VM.

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

