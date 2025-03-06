Return-Path: <stable+bounces-121282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 376B8A55234
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 18:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC2A163ACB
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 17:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7403025A625;
	Thu,  6 Mar 2025 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QZ2taD0F"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E172224EF89;
	Thu,  6 Mar 2025 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280700; cv=none; b=a/VUqMY4VUgzIIe3b9E6EUkq0LJjRxU5zZPMXu5gZO/5zUdPXyCltOePLXetSWfGnZSnIr7FOLmkqrZkwVTVFJwLg5xoYOPvAFscxsiiB7YM+Bs/19GDAPq7OGm/HV+9RnqL/edH7v8BnhJj8vMAgwmggzoSeMpbmWwafCQpRmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280700; c=relaxed/simple;
	bh=xT5fC436rlT5s9cECIzNlb+mxQkfxjrSoVh828pIQl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aX/093ApOmGuRXm5TvU1OlNr38I2bnUP2XLpmA+9hvVkl9zdBxPTuESAvCZ2KotMpfKR1ACvwqFEpZISL1D26ujaw7ZRLn8H9TZiTnNkXsax/tPUhmt3Qt+O8XFoisOiTOXdEPTYLugg7dBR5OBgq8AiutMLqE0aAsuVn+5A25c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QZ2taD0F; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 6A2C6208A7B8; Thu,  6 Mar 2025 09:04:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6A2C6208A7B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741280697;
	bh=Yl30IzYepq/NK4mikLSFBzxAFDxddkZkNEjc+Gr5dGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZ2taD0FlJQQjjH7uGB+Nl71b/TP4XJwD17ml2THeCivg92qXaC+bO1ig/a2LUoDE
	 zQQuJMFGtXnPN8Iy82Rv94/IwIM6TOAW984h6FoRSER7jJT+68166IQAIuwNm5r3bN
	 qFI5vONSpcyD0Us3nIJ0vc3ycGxhSxUaAuSwfCoo=
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
Subject: Re: [PATCH 6.6 000/142] 6.6.81-rc1 review
Date: Thu,  6 Mar 2025 09:04:57 -0800
Message-Id: <1741280697-6611-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250305174500.327985489@linuxfoundation.org>
References: <20250305174500.327985489@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.6.81-rc1 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
27318071  16713718  4644864  48676653  2e6bf2d  vmlinux

Kernel binary size for arm64 build:
text      data      bss     dec       hex      filename
34688815  13844910  970368  49504093  2f35f5d  vmlinux

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

