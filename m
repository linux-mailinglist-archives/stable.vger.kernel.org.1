Return-Path: <stable+bounces-124177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E86FA5E2D2
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 18:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43493A659B
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 17:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACA21CF96;
	Wed, 12 Mar 2025 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UG2Yvg3x"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A391D9A54;
	Wed, 12 Mar 2025 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800529; cv=none; b=HtIXP/uiOpdEUy4y/MzJqhbsA0xv/ohFd01KMxyMxmSjBn6K66YdKmRB9fVgsUleP0D/P0l5mxvzAxgt01XlJdkhDqlEcZje17alKJOoz54sYVMdj9LhEPNNehSHfp2ENZWd/hUFJP678u9z4BJXDJXgFjYTQFppS2tvgQhuOKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800529; c=relaxed/simple;
	bh=V52VOIG+AN8GNl0MT+KjeTlqmFc1TeXWtkQxXGBTtdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=b9Wl8kpq4Dc6t/YXCKEP/NVCGS939rL2dI019frzOg51VFiLFlwnWa+4w32Zc5o/HX4uG3qgP8WW09zZczz7WZfXMEo7yAiTTTVPlnoTJpor7ekY0DjhXg0/A+jBSAtvSGwi8iy7txIl78hRPCtWjID3D6wDmOj3yzb7CDzWiXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UG2Yvg3x; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 7FED5210B151; Wed, 12 Mar 2025 10:28:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7FED5210B151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741800527;
	bh=uouLbv7KI5UpdtrF4kAaKELsEwGPcWJyJ3L5pY9vXBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UG2Yvg3xl4eOJxBz53EICZ1jssHBLgDOJ9IYMl2MP54YxOXFYoqU22/qRtbsk708s
	 fSc6vinjv2hl0OlSFTVIX506w+aJbDt/KKTNY7MijSxrUh4JrbuKSCEhG7VNmdlbJ+
	 SF007T5Vl7Mx0w1tUGhVpqBLHXiyMr+k+dsnPlbY=
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
Subject: Re: [PATCH 6.13 000/197] 6.13.7-rc2 review
Date: Wed, 12 Mar 2025 10:28:47 -0700
Message-Id: <1741800527-19107-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250311144241.070217339@linuxfoundation.org>
References: <20250311144241.070217339@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.13.7-rc2 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
29937477  17837074  6320128  54094679  3396b57  vmlinux

Kernel binary size for arm64 build:
text      data      bss      dec       hex      filename
36684481  15081117  1054416  52820014  325f82e  vmlinux



Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

