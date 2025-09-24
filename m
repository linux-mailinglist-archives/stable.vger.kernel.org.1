Return-Path: <stable+bounces-181576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D68CB98758
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 09:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE71A16FB2F
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 07:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C999322541B;
	Wed, 24 Sep 2025 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d/T7jY1i"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A115425EFBF;
	Wed, 24 Sep 2025 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758697303; cv=none; b=YeGrkRwgNl/Nc1J3jatJBR5SKClgf0iadiCf1wVs5hPdcM+H15jt96Ew/2Fm6gmFl8VFTKMiC8bE1qJvX7ekH/mDRbvnr1cO3XDoJbFys2sBv9H+LuQHt6+Q7dxGBsHLNzMJiqjKS1iSNhtkyiWPxuldgVsE8w1EX/KRQkUXDgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758697303; c=relaxed/simple;
	bh=hcxKt38UwlxPp1CbO5CCTUdqoeHIX+/dj8wIo5uGxOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OwM9a5RrK0Or4uou6zbYanjuXm7T0R+n/xtR91AMWg8vRtsMgcaQVcMxii+0wNtJ7zcCx9lq2vFTbvruwbK4kvXzCa/KqEPRCrOMLXUlECGdv2shajscjYEkdWeNo0uJZhTNnBBGDrf1v7ne7JOUn0Fl56cgBSpU1w9HrZZ9Anc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=d/T7jY1i; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 6563B201C946; Wed, 24 Sep 2025 00:01:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6563B201C946
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758697301;
	bh=hcxKt38UwlxPp1CbO5CCTUdqoeHIX+/dj8wIo5uGxOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/T7jY1i1F7x4tP/xmHbKRXQKlnIN14iRtwD8pPIAw1YXWY071dAkUYMjOC2CCjXG
	 H7utHSJ7vRSRK7EML+kIV+DYJrK9LgxuPRxUQW9KUqtEwpN6xi57Nj/+Gabglieb8+
	 /eCBEmad2nW4uFTO4FWTYBPXAhKtTvgKj0SVRsUw=
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
Subject: Re: [PATCH 6.16 000/149] 6.16.9-rc1 review
Date: Wed, 24 Sep 2025 00:01:41 -0700
Message-Id: <1758697301-2036-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.16.9-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

