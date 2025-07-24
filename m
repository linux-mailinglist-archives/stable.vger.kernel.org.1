Return-Path: <stable+bounces-164549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E53B0FF32
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 05:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8DF1CC7900
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 03:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DEE1E1E16;
	Thu, 24 Jul 2025 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HOtmont3"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1B51DF24F;
	Thu, 24 Jul 2025 03:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753328430; cv=none; b=kW7k04X+S+b2aTLvbTCni/KF2x0UWuioGV4PIi8S+86Lb1uUIaI14JjqFQujRlhpTXPDdHD9YmgKkJdi0N7ugKPHIdTBtXd8x8AnQtH4U6Ki05LBwhPJ+6lpdRDZtxUv5itXYzb9dBB49BiIxXLPuf+X+omDrwxVW9SjfD0wsn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753328430; c=relaxed/simple;
	bh=Ti89NfXW5ceLJwEwTq+SB4qWkVwDTjoSNvmEQ+wWMF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=O1GR608oK3f0yccbcbYcPGpqwG2n1wtj3yjWKSA4+Jm7jrqlL0+CeTvrqpsqvtheaO7h7C9mYhaFsgb3FKN4WkPNzZ69MGd6LAYRyfvQfLqrm5jmafQsBq0YIawkEHGe51jQmPE4XqPovG4r75CyJ3noAYT+s2b0CYH1ZjXiN0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HOtmont3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 066AB2120398; Wed, 23 Jul 2025 20:40:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 066AB2120398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753328429;
	bh=ODgHEBDsxjvu/jObWI0VErMe7aqUCsGUIxr9XUhPiwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HOtmont3mD60H7wxQGcQ6B2PYhgzucD3HukLg1E5ou9hYsgShAA0gk3aGCk6POOtv
	 J1XoikXFP/hL47jLCmu6VkWklkBD1nspT4MIZiRWxfvRV97jcWVqCrmQhJI+FYcyuY
	 YXDO+bQYB6Y8fYF4OIktPLonB7B1bVzuPSpHIGyk=
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
Subject: Re: [PATCH 6.1 00/79] 6.1.147-rc1 review
Date: Wed, 23 Jul 2025 20:40:28 -0700
Message-Id: <1753328428-16014-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250722134328.384139905@linuxfoundation.org>
References: <20250722134328.384139905@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, and perf tool builds fine for v6.1.147-rc1 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
25849666  11309394  16613376 53772436  3348094  vmlinux

Kernel binary size for arm64 build:
text      data      bss      dec       hex      filename
31289540  12552036  831088   44672664  2a9a698  vmlinux


Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

