Return-Path: <stable+bounces-189063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D547BFF59D
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 08:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AE414E439C
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 06:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28471B7F4;
	Thu, 23 Oct 2025 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="H+IyhEIY"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCBA2882CE;
	Thu, 23 Oct 2025 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201001; cv=none; b=H+59WFlNG+G0tyvsLg58LjKzS04ozIvsqIO2j+zlszrJ45eqsBCXI1gEvZQZLbAXkBKyWc8roHZJcyWF7hYekYKJVQiMJ88mipTE5GRF63cqN+KjEKD1pkxJfOnVZzOi3Lrv/Jh0sQVHkU0eiRno6Qtm76I0Imr7AW1M6xhK7dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201001; c=relaxed/simple;
	bh=uvynYbc3rVMnOA2HPC55o6O9nNWGfJS1PVTJ1QjD+J0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tYUt3cSYmamVTBce1d3QDI41wafFja7ZxlFFv2vcu6HViQSrCszLMQn5/MjkQ/AxRv215p32LaPSTLfouR5VwXmioEvLx3T6t9jGwWt6Oz//eeJxFJoNeUz44KNURWgW7LQ+MtNwaOd/YvP/k+2sODYT+Gnx4H5uYdguod383Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=H+IyhEIY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id D44A5206596C; Wed, 22 Oct 2025 23:29:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D44A5206596C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761200999;
	bh=uvynYbc3rVMnOA2HPC55o6O9nNWGfJS1PVTJ1QjD+J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H+IyhEIYm8qqJTAVZWXyj09YdgQYIqnnnHG/+JNvOQcq8kGagkV/zY4NTKusG2aeO
	 Sn2P2uqrC2N7B8aohMKI6SnVrP6U3F46JlqsrXpDN8v1jY7Ctm02mKmEBL8nR4zcc5
	 bdyJrVVAvcSY2d/4mXFwDo/hHsqpq1OGh//UlsqU=
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
Subject: Re: [PATCH 6.12 000/135] 6.12.55-rc2 review
Date: Wed, 22 Oct 2025 23:29:59 -0700
Message-Id: <1761200999-19255-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20251022060141.370358070@linuxfoundation.org>
References: <20251022060141.370358070@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.12.55-rc2 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

