Return-Path: <stable+bounces-188885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC96BFA09C
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 07:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE4A84F88FB
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 05:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A4D2E7624;
	Wed, 22 Oct 2025 05:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pRrGvP3B"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EE521B191;
	Wed, 22 Oct 2025 05:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761110324; cv=none; b=TmtpOmqLFMgummM7W49uST9YLEvQKONpEz+KMW1M+M7GY0KIJAuPRc4ypq3m0M+NA0q2p3z4Bls+OM3Q2q2GWEnE/8w2M971lRsu2mmT/K5CdLvgqqghr11KATAX5T9cfXgwLOBvjcUkoXGhgVuQONAwiVFsKg5kdKPcdGGtDOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761110324; c=relaxed/simple;
	bh=GFrpW2dy+w/py2zGxbu0iJ4pUjfgjuKFg0bx6eOUyq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=n4FM1iHzKZaVNkNtO9NwHwLFXWstWiRyLbDQxQxdMS8fLLYD3X7Ty87JoKKUkrASp/s+GzjGLxgRxB9Ylax0rZrznBD+LA2MUVPi7MM8b1u2wDBQraMp/83Bsyqv49Q39virUmq1UlFsbVdX7LkzWt2PUpAFiZ+zB6l98Yhgxik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pRrGvP3B; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id D299D201DAEA; Tue, 21 Oct 2025 22:18:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D299D201DAEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761110322;
	bh=GFrpW2dy+w/py2zGxbu0iJ4pUjfgjuKFg0bx6eOUyq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRrGvP3Bqjb7Gj61ehSUiwBfxpsf83tcqYBLkTdqEEjmJ08ocJB4wmCUdDXOTTmoX
	 cBSGBEw3AgpPIMHlnbEbp7UEFuNl7gxtlJ5mpDiY2ugbde3t9MiEHKWSfnEYH3Huv/
	 xLyrnZLy2iR7p4kfM/B6NfC0o1huJuqVtesfH/o8=
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
Subject: Re: [PATCH 6.6 000/105] 6.6.114-rc1 review
Date: Tue, 21 Oct 2025 22:18:42 -0700
Message-Id: <1761110322-25322-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20251021195021.492915002@linuxfoundation.org>
References: <20251021195021.492915002@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.6.114-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

