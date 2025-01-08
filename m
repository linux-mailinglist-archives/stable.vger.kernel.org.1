Return-Path: <stable+bounces-107931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C95A04E87
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 02:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF4F16333F
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 01:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999BDDF5C;
	Wed,  8 Jan 2025 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EQrYpLQT"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258911F95A;
	Wed,  8 Jan 2025 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736297998; cv=none; b=FxECK92xv2c6cfF/Un1CdRAp6mnKck4mFVME6ZTASWu1onwI4sbLVzlAOjkG95DhMM1Lx0HphXItrnaIEPj23wccozX1HPzwIq5+1Ur7tAOtJVECkhpyH9cCHLsKVJe6SjyCP4LL5gnHowSLlOJqmgbBmisTSbAuHMn4hJt1RYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736297998; c=relaxed/simple;
	bh=bIvvVG3ShZS/tG2hBmy5mpMPWgMnhmzzHXkNDck6jCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gfpiqelVVGUHibghfJUgSskJ0WWb230cE0yBR6FneEoJre+zeAoQVruImJ+HCBSTLcB56EFF4EMzsDqw5E/D6VaaV9gyPaF39qXXGpEDi57vXAFVpM3/qn54XDRLfX2jnJVSrZ1qmWxUGzTt/ZiJJ9pK8iA7tnSkz4almbKqOqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EQrYpLQT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 9AA33203E381; Tue,  7 Jan 2025 16:59:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9AA33203E381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736297996;
	bh=bIvvVG3ShZS/tG2hBmy5mpMPWgMnhmzzHXkNDck6jCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQrYpLQT/eT99Te9X+/2wP5qk7R9QkJ5hjkL89747soAR6qt5Ld2geaofna0z+OuF
	 LxE2arNdm10KY2dZme1khk04eOPK9OkyIbNc+tTQliOHy6zvcM1fD2zvGLJWLp0m06
	 Driby97TkF5UVgg+6+QToDMo5RZiyCyTfpv0TQZ4=
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
Subject: Re: [PATCH 5.15] 5.15.176-rc1 review
Date: Tue,  7 Jan 2025 16:59:56 -0800
Message-Id: <1736297996-3202-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250106151138.451846855@linuxfoundation.org>
References: <20250106151138.451846855@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, and kselftest tool builds fine for v5.15.176-rc1 on x86 and arm64 Azure VM.

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

