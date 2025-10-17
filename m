Return-Path: <stable+bounces-187706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3891BEBD7B
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 23:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C09427CAA
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 21:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D181F2D3A60;
	Fri, 17 Oct 2025 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oaIP6AID"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A60519ABC6;
	Fri, 17 Oct 2025 21:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760737599; cv=none; b=Bt5PyF+1ZinDQMNE6J4hud7Oek6wwrkqHAxmoU1yfdMS1j6zaJQ6uL+Yisu2o3+xDVQ+5uIaNTquhIZeVjutFqTOr3mVRmvjrvbRvHbH2LfWLzYON+hgxrvbpNKr61fYHjDbBsJZvBLlEdkHLbCencLEP8vf0qmaju3/P3MRZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760737599; c=relaxed/simple;
	bh=oehj//6zdwqx6xk9ABhjyevuLYH8UY96MpEejM/bLVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=U69hGPUAkMJDSZssEbv4zBcBKU+KgYzSt6mtIxiwm+AlwnUCK5wrpSyv9RV5zugTdwdCvwt8hdFmbMNYimG2XxTg60uToi6mtN00KEm0v9Kju4gO9M0sGg61889bGhkX2nCd/mObE5GE8218pJQ2IeUqbrm3S+gcrBGVoulq6Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oaIP6AID; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 3333C201726F; Fri, 17 Oct 2025 14:46:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3333C201726F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760737598;
	bh=oehj//6zdwqx6xk9ABhjyevuLYH8UY96MpEejM/bLVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oaIP6AIDmpzaU/bP26cqBu2m+k9REr8Q9yNBg64AAHUx5z2yqKDsVDodpgaMuD0n/
	 bLF7nx3V8Ytmz3C8TNbGfKtjcO990BrseziU2XP7AxIxNiNryJ8mcRZeOG12scFknb
	 yqrZNu4sD9NP7AIRKNo9lxoy+CpNxhG+MdTYN/a4=
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
Subject: Re: [PATCH 6.12 000/277] 6.12.54-rc1 review
Date: Fri, 17 Oct 2025 14:46:38 -0700
Message-Id: <1760737598-28871-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
References: <20251017145147.138822285@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.12.54-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

