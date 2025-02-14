Return-Path: <stable+bounces-116353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A50A35351
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 01:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2411886A1E
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 00:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3206E53BE;
	Fri, 14 Feb 2025 00:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Fq6ZrS0c"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F52BA38;
	Fri, 14 Feb 2025 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494730; cv=none; b=SosE3qrfIBE5S/YNdSNLxk+CZsbGXqATCrpl8j/A7CGMrocPaX47/4me+eRiBIFv87vKtY/7RgTRAhYX5+8TpvSPZZAOhk6cW2oW7OO0Fu3THGSEBDK7wOZaNz1HasTSC/3Dz7ej4uK5hgSbpjYNoUUc+hapEkvw20+Ivbmcxfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494730; c=relaxed/simple;
	bh=sES3N0KOCj95wUW1kpcBsWvzb0jA4oJ+pPvo/7OVEpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aIJO9VyzTnjKSRMGe0zGGQzyEIIvNLKUCOgIAQkGW9fCS0/PRNaXSxagxZTgyp5CsZzu4KwrAUNB2o2BOGTqkkiZ4aRjmfL71nB3O7n5vS/nKxc3qmZo0DgT5JcVghg3JKE75jqLpsANpr6TW7wXmIN5cnVh5gyNe4nk9X9NK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Fq6ZrS0c; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 42C56203F3CB; Thu, 13 Feb 2025 16:58:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42C56203F3CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739494728;
	bh=lw5OAMpvD91SmqoTd0RZGp90OwCZ6vSzyyb/Cz5IKPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fq6ZrS0cZ8JOLt9tvxxFYN2gEj0veSvJPxmRtcnMfkGl0BEEK6E6lNQ89mkDnADb9
	 R4byienxSrMKZ8qJial4iCYtlFDY7dX5Eb0IP3tXnA/CEjK9NR/2/c9jOr2yKBSfHi
	 5Tfxins3IkKcPuKO13pdUemxV0ANX5etgYv+/obE=
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
Subject: Re: [PATCH 6.13 000/619] 6.13.3-rc1 review
Date: Thu, 13 Feb 2025 16:58:48 -0800
Message-Id: <1739494728-25049-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.13.3-rc1 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
29934888  17832018  6320128  54087034  3394d7a  vmlinux

Kernel binary size for arm64 build:
text      data      bss     dec       hex      filename
36672710  15080089  1054416 52807215  325c62f  vmlinux

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

