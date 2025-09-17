Return-Path: <stable+bounces-180431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF4DB814D1
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 20:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2ED52707C
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 18:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9382FF155;
	Wed, 17 Sep 2025 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IqCj4hCk"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5279B33EC;
	Wed, 17 Sep 2025 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132420; cv=none; b=G1fBQvNwO1Abihd3kTJfwsGEEZ9VMs7AqrnnbrqNbFrgXhBCEBKcAMQgSRr5KxiChj7uz+GSfLEZoLpITpgipueKySsmZVAY/e9xUlJMRRrLzmB8TRo5aegnNPkDpGZelCWFtGJL6O2z9E19swgF+gL/Np34W7ovo85ILq51r48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132420; c=relaxed/simple;
	bh=OPABu7qcZppEqKfafJHtVz1qXb5LAWPoGq1RV19jKUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nPP71huD6ZEzOeO1WTDYIwJR2wLfDXMESIMv4utTD0h3UxQkaFjjsZeCwgmz6KtO2gJPvwA3sa87T/gUcP/oS/zG/2/Us9VVz1w/JDpoYB5s8RCeSRqj1RcNbJbzg/9ysEGIKqD73XLBiw+a741lkp9gcfpcGa/1rN93JdOoh20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IqCj4hCk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 0DE33211AF1C; Wed, 17 Sep 2025 11:06:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0DE33211AF1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758132419;
	bh=OPABu7qcZppEqKfafJHtVz1qXb5LAWPoGq1RV19jKUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IqCj4hCkfPIw657lum0omsGmrKOLkUYYSzpdYjfK4n5/5b4PxvbQjXZ1on6m/CceD
	 SE9VcbQdgaiH4H09ofzhXup3Ah4A1Mv3GZPqz1nfIT50ufBodY64duyapN7MIlyka3
	 hYK0mcnDDKqbTMnLxga5E2MIdO7kPz29tyboC6RY=
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
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6.12 000/140] 6.12.48-rc1 review
Date: Wed, 17 Sep 2025 11:06:59 -0700
Message-Id: <1758132419-17961-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
References: <20250917123344.315037637@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.12.48-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

