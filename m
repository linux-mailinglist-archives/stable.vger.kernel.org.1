Return-Path: <stable+bounces-181573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 638AAB9871C
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 08:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA702A43CF
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 06:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D7C257854;
	Wed, 24 Sep 2025 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SFb6Ax6/"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1163248F66;
	Wed, 24 Sep 2025 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758696971; cv=none; b=r0yNr5Ux/irrLiGttNr09vg7Brzu/L9SdjrBMDCRSMCVflT+k6d8yqBX9/zyhti7xw7+lftUAfLYqjgwACiW8jYMZaQJlVxA3N5ZaVNubyhHxOYaPtlPmDMX3HgvAla2ZQx6D1ZBrxTpT9vOxp+x7cCb2xv6PWfWKawsvhZgyv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758696971; c=relaxed/simple;
	bh=YdiC0NnTJH90wSfoKsHuBlkJjdKj6ohgcA5y1sl2Rqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=X8viUcsuvxGBWzUSsgwly+DbbohRTDjpQeyHGUV1VJUurixLZq4c8L+kOG9BytgXnxIt2wUXPtrrjQ8pqTS7VUi4ZEWZP9Smw7dHwCglarH0/Y8tKFH8jPUn0gn6ko8s4rZhgRumMDNLHGSV3KWmRWsYhhPW/QNvJdvr/83jhTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SFb6Ax6/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 45325201C950; Tue, 23 Sep 2025 23:56:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 45325201C950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758696968;
	bh=YdiC0NnTJH90wSfoKsHuBlkJjdKj6ohgcA5y1sl2Rqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFb6Ax6/KpV3RN+eeTuYdEqhneif7a3BsOK1ZZsstxt+3TfJ6hH907snO5ow+vZ4z
	 Mrhb6KarxI4cS4jxqyfrNsrxnTiD9mK5yCjpFA+QcFN1OVeE0le4oIO770ImRtd6IT
	 8WCRYdshxu8/+B2Axp/8ZV6+manNItjaXCxShWqQ=
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
Subject: Re: [PATCH 6.1 00/61] 6.1.154-rc1 review
Date: Tue, 23 Sep 2025 23:56:08 -0700
Message-Id: <1758696968-610-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250922192403.524848428@linuxfoundation.org>
References: <20250922192403.524848428@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.1.154-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

