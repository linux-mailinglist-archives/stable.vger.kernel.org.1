Return-Path: <stable+bounces-109321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D98A1483B
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 03:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538AF16B302
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 02:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABADA1F560F;
	Fri, 17 Jan 2025 02:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j4zXEgyy"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB351096F;
	Fri, 17 Jan 2025 02:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737080777; cv=none; b=MWpm10ImnC4nR+vPS2MZVC1AjgP6sZT5QfLTVL+XCQ1k2iXRmajrlybzSMWvSmHSyhxKOgM0C3EDAzXWbn+CoWYXV+MHV/h+M/B8zZ8iugnkVpTTS4DJ9PQdxIJsWylPP9IBi5QkYLKJqdZC49nMd+Zfww4Ukm+JGuvqH7rmseY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737080777; c=relaxed/simple;
	bh=KuohAN5yww51P25HvlNwxeVvJmAKy6nFysml2x+JO/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=brZ8bn5Zy5w6qDwCjssJK6TmsbaJU+1IyR8TkLOFLUXx1YRQpmbj38QEO13TMD7Fne6NQ/WA4TrAUXQ2WExegfh+JvvYPn8WG3O3bsmnH9voe5uc/Gh2AD1xGXzV615CGsamgPeYeltd4HFaulW3+QzQgLHbnA5r2KkL80vGr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j4zXEgyy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id DB90D20BEBE1; Thu, 16 Jan 2025 18:26:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB90D20BEBE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737080775;
	bh=KuohAN5yww51P25HvlNwxeVvJmAKy6nFysml2x+JO/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j4zXEgyyEs6xkNmJDVD5s+cyQh8oEwUW4b3KwIlGlfiFmYWQDSyv/TuQngfE2hYgm
	 aFmvnFzAh4XxDn2h3mAjViAlKhn7NmIC4MPuzXwSy09p3NSu8gSdp0BRmL+DZFnzx+
	 phaDWRZxKtMKjGnR/9tc9ypVVMHRWMY8X6fGssvw=
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
Subject: Re: [PATCH 6.6] 6.6.72-rc1 review
Date: Thu, 16 Jan 2025 18:26:15 -0800
Message-Id: <1737080775-23716-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250115103554.357917208@linuxfoundation.org>
References: <20250115103554.357917208@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, amd kselftest tool builds fine for v6.6.72-rc1 on x86 and arm64 Azure VM.

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

