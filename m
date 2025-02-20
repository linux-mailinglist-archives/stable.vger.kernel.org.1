Return-Path: <stable+bounces-118499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B13A3E35E
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 19:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467EE19C1E62
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0977C2139C9;
	Thu, 20 Feb 2025 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Zb3klLeJ"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614C7212D86;
	Thu, 20 Feb 2025 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074734; cv=none; b=I6pQ8D7C1WQ/yBQgLnGlVUBb9k8hXhNBlFCBCdT34sVZ9WIEUghGjAxVxHKMUofbhlExRdTPy4mcSoj3ey0rGfw928lqQSFJiHWzrWskZeG2ZV0mWfFB1+TK58OHsFdYiPuABL/pz9i9iIZ2TSIXwwba3Plrv5c6mzqTEVB/Tgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074734; c=relaxed/simple;
	bh=ew/cfQzxy9qChwfoPrcaAdxOf2SPrz2X9hV+HeK9zRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tGHgrwromp/RFL7X8rfS7kb2Mk0593zUQ1S7nTIlC665pUkfF8Ymbb06Cafy0L7ws/h54riT79V+qlUqfdsYrSSOlNVNzFekxfndzGLEAySGobhI8kMPdT0sqolptG+FwB/bB4o9CPPVA2hUrBgOogZCkIIpuy+qseYkJ2dVd3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Zb3klLeJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id B80C2203E3A2; Thu, 20 Feb 2025 10:05:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B80C2203E3A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740074732;
	bh=oRVqXVvX73/5Wovz1XEdfte9Epbb4Y7qASi4Wu034dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zb3klLeJoJEUkhZALvdNIBnmvOWWxW9BaoqI9tmDIYuAA5qv0FgQ6fW18UE+Gggpw
	 l8A9KK3w8AZJQnorS9hj67y1J2a+iUPIY3Dj/64CMHd9OOMSAtZlKWoLf181DeWOiO
	 V8r9QdIFUnx8DZaOZylt4lQxPjPkseXUQ7/gnWRM=
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
Subject: Re: [PATCH 6.12 000/225] 6.12.16-rc2 review
Date: Thu, 20 Feb 2025 10:05:32 -0800
Message-Id: <1740074732-6407-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250220104454.293283301@linuxfoundation.org>
References: <20250220104454.293283301@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.12.16-rc2 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
27754202  17709094  6397952  51861248  3175700  vmlinux

Kernel binary size for arm64 build:
text      data      bss     dec       hex      filename
36387790  14992393  1052816 52432999  3201067  vmlinux

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

