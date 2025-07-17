Return-Path: <stable+bounces-163231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CD3B087C3
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 10:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335221A6405D
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 08:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EE627A11E;
	Thu, 17 Jul 2025 08:15:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E3213C695;
	Thu, 17 Jul 2025 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752740139; cv=none; b=uWeCkQpLFE6d9YwsvrO7bg+XBMQ6XG2hVCSHlxZZfQIMRGYIc0PEzqc4tpOSFQSnfWrqIAXnpLq13Kup3P9YsttJTnK3dQQ9Wu+C4goHT2d/sGq1M0t3zs61rzkicBAC4dUkauM0zzza5sqI5G8TvovZM8sSLAoC6TTxFYmGQjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752740139; c=relaxed/simple;
	bh=i7+7ujREzGUYNViy6IJDktzLo3hqmWJ4+/UZA18Lx/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0du4MKJ3iFQ5Fm1GKrbHhSFtpqAU78klt9zrbroNr7/9YbRA+qQt8fg2kvNtpZSLT5UhhsJysIXrkRSyMX/ooWmwmcJIB3I0x0r5cXwkRfCxYgtraeFdqpXkxlYhhm0wAVPWpafdeVhffsKF4zSiYzvSkk3ISYyreKcNe87Wfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Received: from [2a0c:e303:0:7000:443b:adff:fe61:e05d] (port=57564 helo=auntie.gladserv.com)
	by bregans-0.gladserv.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(envelope-from <bacs@librecast.net>)
	id 1ucJlu-0098Jm-04;
	Thu, 17 Jul 2025 08:15:18 +0000
From: Brett A C Sheffield <bacs@librecast.net>
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
	torvalds@linux-foundation.org,
	Brett A C Sheffield <bacs@librecast.net>
Subject: Re: [PATCH 6.15 000/192] 6.15.7-rc1 review
Date: Thu, 17 Jul 2025 08:14:47 +0000
Message-ID: <20250717081446.9785-2-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
References: <20250715130814.854109770@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

# Librecast Test Results

010/010 [ OK ] libmld
120/120 [ OK ] liblibrecast

CPU/kernel: Linux auntie 6.15.7-rc1-ge6001d5f7944 #14 SMP PREEMPT_DYNAMIC Thu Jul 17 07:41:45 -00 2025 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

Tested-by: Brett A C Sheffield <bacs@librecast.net>

