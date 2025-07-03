Return-Path: <stable+bounces-160121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2700AF81C4
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 22:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FACA5650C8
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 20:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405E929B782;
	Thu,  3 Jul 2025 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ls7eTFKZ"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0787629AB05;
	Thu,  3 Jul 2025 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751573553; cv=none; b=P0wexDCyTlmCsNVri5aldfDHDwQY4Fw2UF9MeJt3D1cJUgAqwbfx1CIxdLfMsWSJ69bXXcgPyVDn0hwz02ZRYQ1WpxCFiBRg/gEqB8/32pB8mAfeflGzI3D9sPgSFDE+p/fHdR5LYU6oGPED6zOPiQg0qvzQUgHixlqu+/Fsne0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751573553; c=relaxed/simple;
	bh=gmh5ZoAgGsJKG8haTIpWu74Cwifbp8iS4hmC9GfBIAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hNiYP+Z0bYITDSaVM0bmIN+m/GZiZGXw1ifpeqxxM6R9A8Pg3rciVnIul/Tv+Y9LgE78xIpq3JYNeRXbACg7Vmp8EOWHuPdSwTcu81AjYTh3tOtuNQHiH1Dzh3YKZtoFjqE7/rH+3qX+kKAMEtEhEqGmMlvLXuwBQ1kF8UtOaeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ls7eTFKZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 8D6F3201B1B1; Thu,  3 Jul 2025 13:12:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D6F3201B1B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751573550;
	bh=fXBcnpF5wIVxCrRcCZEh0GIQXdpGV1Dnj7t4XrnX4c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ls7eTFKZsvKQoWNUQapIL/zkupcDpzjxGfr7c1sN7smhoClWtQu99/wGy7wBisfWu
	 rozp01tvzgZmxExhvPH5k532LdMzj8zUf7+pC0KrohrXMBy+gHbU5aB1GKuhxJi+Od
	 6QepbLaA+tnxDTYTSLGBBj84EBkFbnTaNH1KvgXU=
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
Subject: Re: [PATCH 6.15 000/263] 6.15.5-rc1 review
Date: Thu,  3 Jul 2025 13:12:30 -0700
Message-Id: <1751573550-30344-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, and perf tool builds fine for v6.15.5-rc1 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
31999332  14279706  6250496  52529534  321897e  vmlinux

Kernel binary size for arm64 build:
text      data      bss      dec       hex      filename
37335764  15435073  1038480  53809317  33510a5  vmlinux


Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

