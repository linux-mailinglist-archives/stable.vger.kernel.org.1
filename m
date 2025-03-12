Return-Path: <stable+bounces-124171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65510A5E256
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 18:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B218C7A2EE1
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF75624EAAE;
	Wed, 12 Mar 2025 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DLFXCAPu"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1D01D5CD4;
	Wed, 12 Mar 2025 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741799541; cv=none; b=I4ztHvkRkLQMyUSdOUFFsi8yaNpxdP/v/ePMO66h93Hx0Dkr06a5I89GqYNZodQvAkRlF5aXINAr6HVGg5Ckcnn1qNUb2hU0Jw4X4IogCagP2AhvmpHGew36gu8Rauk0Ev6BN0dJP/FOiTBeUzNyxPtflCqY7aoixcUpOlfix3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741799541; c=relaxed/simple;
	bh=EQx4l0eKrvYMHLDu8wi+jHEJQR2ghRI/jchw4ZNVe84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=b7zKLMjUXOCe8g26BPZMP30ZtJmbzHGPnAtEBzfvYMG4amihYMuinhkobZ7D/YvTywIEBYEXtsMRiaJd79f/7MviPv4/2aQ6bnlkqOfZ94RbRRi8EA6aY7NBb8bsuqZGORhuXBvEG5H7cItqbHHc39+799NTU5LmqOWFmTkpCAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DLFXCAPu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 105BE210B152; Wed, 12 Mar 2025 10:12:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 105BE210B152
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741799540;
	bh=frH46tTfpQZS4kolQ8MKAL3pomG+/c1d4lygbCZRq24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DLFXCAPu+uTMxOurHBHHlR07RqZx4iHz/Nx1qRDd/nsJNDCSIq1I1vHYnaGS2vhTJ
	 z8CRC5p7b6b5c9m4yK0eVQpIVTCW9+KdKNRH1FMe4QpVvMaeZuG35mwtabzGag1V3f
	 8Bf57WhVLe59XQ3cleONzapvo17S6nTHIUoVCYCo=
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
Subject: Re: [PATCH 6.1 000/109] 6.1.131-rc1 review
Date: Wed, 12 Mar 2025 10:12:20 -0700
Message-Id: <1741799540-15792-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250310170427.529761261@linuxfoundation.org>
References: <20250310170427.529761261@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.1.131-rc1 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
25843392  11301066  16613376 53757834  334478a  vmlinux

Kernel binary size for arm64 build:
text      data      bss      dec       hex      filename
31262050  12542632  831080   44635762  2a91672  vmlinux


Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

