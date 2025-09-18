Return-Path: <stable+bounces-171873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D5EB2D4E4
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 09:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C6D724A25
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 07:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F592D375A;
	Wed, 20 Aug 2025 07:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rMcEbzf1"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC9D23F417;
	Wed, 20 Aug 2025 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755675119; cv=none; b=FLpAdHH0Z30oRlBGYbRmy/65EwCvgq1ii6baWGpLjk/7CqCeR0C/LAp1qT38GpbiChmts/Px/yodFMD2ZTJZGgqfyyLQdb3gn6LK0+2RC78BQVHgwm4GLSXBG0GpYK9IXn8gecI8A21JmCVp9QRPpGKcz+QCfnhTQ/Gl1NnhrL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755675119; c=relaxed/simple;
	bh=PuOyZ3QBiHlpKa6YkUM8YKgTR3Hya8VKuSNbEOQ+76M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=e9RXK1lEMjX+AocfJzuHln6E0FurcFL8kkMzA/1hNc0KLXoz6QUz1jV5Yog5MrOqknNVJc0y+QxL+ObeHtabDEi88XDvfCKI6sIVmE0X8ApUL4fk22sn2/8OhF5McjztKB/fuzsauURZMGN2CBf85rWgjLq7+zImpSibV+/dSHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rMcEbzf1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 659DE2115A5C; Wed, 20 Aug 2025 00:31:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 659DE2115A5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755675117;
	bh=PuOyZ3QBiHlpKa6YkUM8YKgTR3Hya8VKuSNbEOQ+76M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rMcEbzf1zzfHxwXTgL06v9Bx3bFvWwhiUCoVeW2+dpU45v8bOur71f4sxP0+TWeNl
	 EZdR2oRl11CNFq+8vqq5gBwrxX47xO1iUlz62zskq7fg85MfkIx4YTS12aIoAm7qtm
	 AuzzHv0Vs13H+I+zFE6IeI86zeUG2WQ7/zDTKCZM=
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
Subject: Re: [PATCH 6.16 000/564] 6.16.2-rc2 review
Date: Wed, 20 Aug 2025 00:31:57 -0700
Message-Id: <1755675117-31602-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250819122844.483737955@linuxfoundation.org>
References: <20250819122844.483737955@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.16.2-rc2 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

