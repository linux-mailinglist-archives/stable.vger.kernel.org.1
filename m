Return-Path: <stable+bounces-187707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E05EBEBD81
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 23:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99D5E4E6D9E
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 21:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D380319ABC6;
	Fri, 17 Oct 2025 21:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JOJ7bFCO"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CDE25CC74;
	Fri, 17 Oct 2025 21:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760737679; cv=none; b=tuptPjCOUGyQByJ/vCYPONjl3GLGErToGIGJQz0nk4/ekgFT91SiYN0ecxz6c9RMd3vBwyCo8it4lDV40nfS0aOzII2MfgLg8QI6nfY9Me2U5dI+9RcLPDwXnGERjtT7w67FM5R3dexGJtgvXGsdIxd/dx9O7HSU4gFYnQnx3fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760737679; c=relaxed/simple;
	bh=C65zj9xzwCRGEGnsFfBo/tryb7Obv9lC0VUGebxJY9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mIjeXtK4RlNmemBv8Uz9EZPXWRGgqCc4DSiJ6/vJUO8ovP+yDLDgkg23Ez4k6carLsx2/QOVl4NXUHb25Et+yYHv9DDKBEgwPFOgQuArWZE09NC2kjHtEhPHJgpGOQrtDFFom0jQD2vgzrkbnfZRlQ+UB2wtb5ZF6kAADfmCt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JOJ7bFCO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 2F694201726F; Fri, 17 Oct 2025 14:47:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2F694201726F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760737678;
	bh=C65zj9xzwCRGEGnsFfBo/tryb7Obv9lC0VUGebxJY9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JOJ7bFCOBatSnEn/o/H8VUUSlzu6TGLBmfqH9N3CxN83rOWFVdbvRjiieHa8prg7+
	 2N+wxp6MGcHGXEjc246nAwRM3B5F+tZHFwUREecd8VLRdqyeHlBRNP8JA+HQojdRx5
	 +PKPcV8eQ2ESxYQvlZiHyQtWG84i79TedA/42t9c=
From: Hardik Garg <hargar@linux.microsoft.com>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
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
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6.17 000/371] 6.17.4-rc1 review
Date: Fri, 17 Oct 2025 14:47:58 -0700
Message-Id: <1760737678-29126-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.17.4-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

