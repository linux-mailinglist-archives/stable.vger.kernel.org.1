Return-Path: <stable+bounces-118497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CC4A3E335
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 19:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C68317D381
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 18:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F416C212B0A;
	Thu, 20 Feb 2025 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SLYgCNlt"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B581EA80;
	Thu, 20 Feb 2025 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074479; cv=none; b=eZy0BsD/NqFgKUt9nzIH4mtf2a/HnG2hmpTufqoe/cHFnVadvfp6SfzBOa94nRmw5QVDV1gq8qheYiNHad9MHvbfm5krlAEaXqZhHUuO0kpeiGUhLzZPmd6rp7ULIQuuYdwo5AQcYulTf0i6lRn/V95LhDzPCZqvhe/gwrb5dz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074479; c=relaxed/simple;
	bh=/jmXV4SyRpu0lSRPgMrnRzCMFDkIPJq/IBBKNDrNN1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ox7uOdfrXcmoNpfbPrOKGt/7ypfi6coe7bf28m5qmOB/t+8ziTh0+7OiTtcH4vvATqc6y4Av7VWhrb/nFs0KI5DfhqjtijXaIRJsAz+AjNai63I7Qjotvie2XoELulp7utl1VOTHBV0vFUONqag8lDTEb1GNNwoqXGpriCvzm4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SLYgCNlt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id EF65A20376CF; Thu, 20 Feb 2025 10:01:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF65A20376CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740074477;
	bh=1re4gfVQ61sJgkbmewyGkYPaNJhubYAdIhx7a4UYXIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SLYgCNltAEY95GI5mxEjRJBQa1u7LldPMv1u9HX8EgtulKWbsWssw4vL6AAUCR5Ce
	 /1k9LnYvPPKDL71Yk/BuA39iZBdgjJRpUMF6WBav9h4pRJCqobkdNYChwKOBEtguKJ
	 BQiOkYCBUJtyZOV/Rw/2JsZe67YBqu0w4OOM4N2w=
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
Subject: Re: [PATCH 6.1 000/569] 6.1.129-rc2 review
Date: Thu, 20 Feb 2025 10:01:17 -0800
Message-Id: <1740074477-27449-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250220104545.805660879@linuxfoundation.org>
References: <20250220104545.805660879@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.1.129-rc2 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
25841866  11293522  16617472 53752860  334341c  vmlinux

Kernel binary size for arm64 build:
text      data      bss     dec       hex      filename
31262891  12537932  831144  44631967  2a9079f  vmlinux

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

