Return-Path: <stable+bounces-111865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E661CA247A7
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 09:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE1D3A83FA
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 08:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B54C13DBB1;
	Sat,  1 Feb 2025 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="F0FpWNEC"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FBE5336D;
	Sat,  1 Feb 2025 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738397661; cv=none; b=cvNualeZeBvGNJ2Obtz8w/TxJk+OUxjalEWAQJe8Lobzkp6QWrUNV/N2TPo62c35xY8Hgj8e+4AcWUhsupt5i+UYeAmZo0vYNhEm3pJZVAWyMl1QuE8dvxUbtcu4iIRMmSf00kSKTNaoJfqogz5Su+KT6ntkLnVVuU6p13C6oJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738397661; c=relaxed/simple;
	bh=hKT5i4V1rD8KTYmymsV+r9iPWQFXehkupzM1h59SsVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XnTwwPxwcPH++RCnFGXotSw+A2OyYnE6oASqH7qBJgEhEGmBKsfpZQcvgSVAPAryfhXaqkkORFNyhEzymeBVCpXLzm8RKNT+B09/4+PVxnUeW46Nzdwt1kA0iI2kcyW4qPmc60Wh/Uz30FVIL2lzmPUTIULTiV9J+koiKevGLyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=F0FpWNEC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 63578210C332; Sat,  1 Feb 2025 00:14:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63578210C332
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738397659;
	bh=hKT5i4V1rD8KTYmymsV+r9iPWQFXehkupzM1h59SsVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F0FpWNEC9nvqCqhWRVG6HlhUrrH6hczXwGiVgWc6qRjVsBbRn3gUSbSk0t5QcDvTP
	 KHCftjB6XnjQXfOJrokiF5IZln5fIv5uLd7AK2VnmHPirvUoMbmxpqkZ4dTOTjAf18
	 w8OjeQs38g4DTRUaB5ffWzZyzNeFbX+aEgqPEXl4=
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
Subject: Re: [PATCH 5.15] 5.15.178-rc1 review
Date: Sat,  1 Feb 2025 00:14:19 -0800
Message-Id: <1738397659-6940-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250130140127.295114276@linuxfoundation.org>
References: <20250130140127.295114276@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v5.15.178-rc1 on x86 and arm64 Azure VM.

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

