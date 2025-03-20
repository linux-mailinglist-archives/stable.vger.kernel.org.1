Return-Path: <stable+bounces-125675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4138DA6AB02
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 17:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D190F7A5A3F
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 16:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0FD219A67;
	Thu, 20 Mar 2025 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DjPOXP8K"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671941EB1A8;
	Thu, 20 Mar 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488043; cv=none; b=CmQoHPi2zXCsrtGapYU+f2r0AYhKwPYA2Ky3s6qQGeV6afySLg0lT/oAhW528b0M8uIbHa8Jsk+ltd8TTl1tFbMKitqT/6262Z0dSRFFPzgg61d90sCwQvk4a4DvdE2BddvjFuHvAynmZlUtr6lVvhbVnH2LmAl1AGMIUkUY/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488043; c=relaxed/simple;
	bh=bfhieFFF5xFk6YbXZg31H+sZx2cavKu2QXKL1UtFJM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jnx0X+pHVE9wIbg2XpnPH1ZMzBvCe7fhv+F3S1sid7bWCT16wO53RUFNVoKRLERYiQR4JGrPuKQh1o/P1vQ5CDLN0tVspHqVp281qVddxqcuOuCBNYUmr0Oiv8Bv93EKeedjrH7b00lEA6qfS79eyHZ9RfH7ZdF8RQJn8T/27P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DjPOXP8K; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id D85A32116B4D; Thu, 20 Mar 2025 09:27:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D85A32116B4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742488041;
	bh=k46qvSEd0Lp8ccJUs1FV6dMFtYIyo56KkHz/uKLy7zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DjPOXP8KQjLGpzJ9B3DVK53xn4qiuw4bJbB2jEyNo/j7MG8m+UfSV4o2v/fv+9Ud8
	 VYbl/N+WMcHL5Y6NaoH58Tjnf2jlOWMeALo1Cm4C9QusiROL6I/OVtrwBM9LMGw5QA
	 GSZDfxIfuabgVRp8X+9ee0RF9OfEv1ihjqf+pJgY=
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
Subject: Re: [PATCH 6.6 000/166] 6.6.84-rc1 review
Date: Thu, 20 Mar 2025 09:27:21 -0700
Message-Id: <1742488041-4614-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250319143019.983527953@linuxfoundation.org>
References: <20250319143019.983527953@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.6.84-rc1 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
27318662  16715490  4640768  48674920  2e6b868  vmlinux

Kernel binary size for arm64 build:
text      data      bss      dec       hex      filename
34684949  13845466  970368   49500783  2f3526f  vmlinux


Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

