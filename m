Return-Path: <stable+bounces-188887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6A6BFA0B5
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 07:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE121896209
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 05:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A342E88A7;
	Wed, 22 Oct 2025 05:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LzVVTDBZ"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA99F2E7BDD;
	Wed, 22 Oct 2025 05:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761110511; cv=none; b=ULmI5NNthhcSJkfvvbum73gXI1PlypJWHxjrCNkuelahZC/gk/9LY0eL3+pv18n8x5oJHpxSORbdkWEJwOjYm/AurposygE9QHTwcS8yu2YAXpnCrEvB2UjCL0EAUiYDCgW0eloWzPI4hfgFGUv4SBPnAK5HDtvXj7WIYdTXaOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761110511; c=relaxed/simple;
	bh=Hbdjo5anlP4pxWMDK2Rv0ky3pCNOEjcoiePYV7ol/7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fqb2d0b2D+ettThgEj5QgbhPEktdgJ5AvvN8NH7nltsA0KzX3v3pvgkm5/xEgP5+y/CzJuTQuiqrUmbELJxEu5V5o7SNqbevPUuWOg3+IrzT0heMuevHmPCF/y1c9y3vBMN40Riy7cSIpX5GXpjhthF2COuHT8TvBywrKzj6q70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LzVVTDBZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 9BB2F201DAF2; Tue, 21 Oct 2025 22:21:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9BB2F201DAF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761110509;
	bh=Hbdjo5anlP4pxWMDK2Rv0ky3pCNOEjcoiePYV7ol/7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LzVVTDBZ5gqnaN1QyFQj12dsih5VhWgSZPXRfrc0TN/GjlhgewG5AsVtX/FHPQxnY
	 a0NmDQ4ZLQQ0ttfvURFxGdS7LyB8ASoZiW5wMyBmq+ZahawWF+dzSl4GgKv8NCWcoJ
	 N2ON7zBCcAXHZbGfLto6ofB9rvoCMZEsPi/abmcA=
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
Subject: Re: [PATCH 6.17 000/159] 6.17.5-rc1 review
Date: Tue, 21 Oct 2025 22:21:49 -0700
Message-Id: <1761110509-25984-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20251021195043.182511864@linuxfoundation.org>
References: <20251021195043.182511864@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.17.5-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

