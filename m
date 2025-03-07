Return-Path: <stable+bounces-121441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCB3A5713B
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 20:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F8C1898C4C
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 19:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629DE2500C9;
	Fri,  7 Mar 2025 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MoW+4SGr"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D9924889A;
	Fri,  7 Mar 2025 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374884; cv=none; b=VMvMcK6KkIT88TxgefzzDP/qI0xz2UPunyHDoh3XjMyIC+QfFurtFDKa1wKhXDN+R9hANKhkQrpTLf/iEvmwOrmBDXvNFOYgvOIQAoPmu51v+F0drciDzMQskwJ7kXnY3/30dmtD3iO2HUHWJPIDSOBpHhwFgzS1Po+O3PaqpOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374884; c=relaxed/simple;
	bh=ut1jCbJ6TAMfhzfDmj7s2D6RvkNTw+JPeEdsVYj8q6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OaI+q7Rvrgk/SuVvSXSqt07D7+H+mreWvz3LprHOW+/KLNddPXTuAuigPPMdc/xoCEcSFaIjhwSEgOOw9rJ0Q4wF6WaYWMNfwO2luEqM5CulNGsq2WHahKEDvj0gjR5G4XjGsgXYrg452fdL/uhX8KHVdMAdnzmDH+rxF4paOq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MoW+4SGr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 90FA32038F37; Fri,  7 Mar 2025 11:14:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 90FA32038F37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741374881;
	bh=jT5flJtW+Sx+B3QqUFbgWhGSYtG6eziGnR2ghVcK3QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MoW+4SGr4qwDajmdbdybgWCY5GrtYkn4uB5w5pdBzdT3eFRDbayCGSeDBQ0yBbNVj
	 bVQo5fsp/EI5tkrgp4OhsCrKaJU9DD8s2OAuJgVqFc+h3CmZdXHFES7xuJbHcEzejX
	 LrWNI6zmYdv0UTYa3nKjqkFFdlBsEKFEv/q7J7So=
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
Subject: Re: [PATCH 6.12 000/148] 6.12.18-rc2 review
Date: Fri,  7 Mar 2025 11:14:41 -0800
Message-Id: <1741374881-19155-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250306151415.047855127@linuxfoundation.org>
References: <20250306151415.047855127@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.12.18-rc2 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
27755354  17713522  6397952  51866828  3176ccc  vmlinux

Kernel binary size for arm64 build:
text      data      bss      dec       hex      filename
36390288  14996757  1052816  52439861  3202b35  vmlinux


Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

