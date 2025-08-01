Return-Path: <stable+bounces-165706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AA3B17AD4
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 03:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE5D7A9E05
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 01:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DF4151991;
	Fri,  1 Aug 2025 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZrvNC6Gy"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F273143748;
	Fri,  1 Aug 2025 01:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754011798; cv=none; b=C4EFGmYIDz2w4hs7eWgzlV/VvY7EeZZeULwaDvn//d5VXdt/EwlW9IL4voD/XpaWijgSqE3aHAWr3sLh/xY6igL4w0xe6RuAt2ceGPEgtWaEqjAgS8DRLRnGgJv+JL/eSxcub+H8X7KOZ+K1VKV/fK3EqXoMrveRcRZb2Sycv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754011798; c=relaxed/simple;
	bh=fpitKmcCNonqrgDa6ogqIXTsC5u62fxygC5JgaSu9Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cm8Tb0c+w6F73Qz+wk1kY3R8Z3JitwkZNXNmTb1DG6GlOxdUJHwzzFEiMjlKhnhNTJn5MhQhkv8YwAxEux6uILOCOPcQp1qP70VPi7S0qF+KT8Bo+3YwidO3vDsdfoZGL4ps/gft8sUB2I9yQq+Xa9nRNiM86VYSH5sOTPmDfak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZrvNC6Gy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 1B68921176F5; Thu, 31 Jul 2025 18:29:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B68921176F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1754011796;
	bh=fpitKmcCNonqrgDa6ogqIXTsC5u62fxygC5JgaSu9Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrvNC6Gy04EPu43guW7m6VJ3i59QxLapkr8l84skHVaZmy+0SZls1y6Gm3q3fOe+D
	 WcbC87l9bijr/k9dFsjCFNKzSpdno7y6fKQC0Md2Ee0Z+dPtG4TKlMwE+W3dTs/3ui
	 WBeNcXNCJMzmIS4k+zSzMURXVDRvDPqkzVccddYs=
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
Subject: Re: [PATCH 6.12 000/117] 6.12.41-rc1 review
Date: Thu, 31 Jul 2025 18:29:56 -0700
Message-Id: <1754011796-27079-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250730093233.592541778@linuxfoundation.org>
References: <20250730093233.592541778@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, and perf tool builds fine for v6.12.41-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

