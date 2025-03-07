Return-Path: <stable+bounces-121444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB97A57184
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 20:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D46F188A6C3
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 19:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E75423C8A9;
	Fri,  7 Mar 2025 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BP2ffmOp"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5584250BFC;
	Fri,  7 Mar 2025 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375254; cv=none; b=O+B206bPNjPYYmGxSSuI7i638uQEorSPrUeFzOMTlpZKBcY2vczKv2jzWdTr85jmF/wGLCcyn7GVjvKd8lLZVpDUnqkTvCWptQC3at7+Qjhpw5knxVe3erKCjrKDYRxMGMyqDXOWa2cKLVS1+Dyb+uMOyj/NSuG2p3X1zlSznME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375254; c=relaxed/simple;
	bh=mrwA3MchNOiGOSKKxYhSgWwnZE3DHu10Nho7EFmjeh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OsDrfQ8Ls1+BVNN/7c3SkrrR1xKZr+uOPgvb4uogEnELywsrVpuijtYensMWwz8nXDDH9oM9BjQ3AJaQJQnGWZmzaj+83DJhFLCLCXjhy7kiD9WUUmNkuiuUrm+RAxtt3+cBRbnNlSANLCgmovH8FFoRIPM3DKGG+u0HgerQ3Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BP2ffmOp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 52BDE2038F2A; Fri,  7 Mar 2025 11:20:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 52BDE2038F2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741375252;
	bh=efpgAcHYSxMm2kTMhAh4r++DjgoVnpV1ObJDIFr2jzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BP2ffmOptyS40LI5vnl16v0zgeLhiGGFZ8GeO5qWi2LAP5Wkki5Qw6vFbrFtgzIil
	 S5uuB4XRhh2XTcAjOKvYAWMMkG/yF9uYS19r9rqR1I9VewFH6EcKdH8F7eYSwT/l1S
	 9WL+83U7CHwzkR3CI8urCF/fHL4S/UHDOBUZG1u4=
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
Subject: Re: [PATCH 6.6 000/147] 6.6.81-rc2 review
Date: Fri,  7 Mar 2025 11:20:52 -0800
Message-Id: <1741375252-20613-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250306151412.957725234@linuxfoundation.org>
References: <20250306151412.957725234@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.6.81-rc2 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
27318071  16713718  4644864  48676653  2e6bf2d  vmlinux

Kernel binary size for arm64 build:
text      data      bss     dec       hex      filename
34688815  13844910  970368  49504093  2f35f5d  vmlinux

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

