Return-Path: <stable+bounces-107905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE6CA04B80
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 22:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDF1166969
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 21:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB91D1F4E47;
	Tue,  7 Jan 2025 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="orFJLXBF"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E78B1D63EB;
	Tue,  7 Jan 2025 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736285086; cv=none; b=RVdn/PPFQ7IQelYajHk9lf/qIcXZTJ0p1ch98AV8IuTdMpPbYVXH1+dWyCoHvX/TImX0CTrxPQIjJ5K5sqkAujpfxfMGGfAKrOv0Njnq1RYR0GrLZGX9s8F9/B0BR0bhYSdRApJ2vjUJ/xHsw0X0NAAnQN6op0orpDZB0PYLiAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736285086; c=relaxed/simple;
	bh=R8PNhqdWQyLLebFXfea0+122PVwzULancPTYcFx9LII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=q1Y1bDhxbjcWqRC+6P60DyH8jdvAw3o59ye5a6KjSPXb5Ru8TPJJnnXtSWD/mB9WhDcErgKx+xozljXQOEG5gihaCoO9E90tohaGZS+YTCHyFFSrAz5cl2gXda+733Sss8YmkrWab0izmM2x6XwvbXoDaGdTpugzGUmMQn1g2g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=orFJLXBF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id E5FDC206ADF6; Tue,  7 Jan 2025 13:24:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E5FDC206ADF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736285084;
	bh=R8PNhqdWQyLLebFXfea0+122PVwzULancPTYcFx9LII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=orFJLXBF03ljmUGpTYa+XSQs/EQGR2jDn0sRx7c1UhoJNxgg/I0PKC9KjCwIpZa+3
	 NjwMsn2Ly80hQSkcGx3XUabUOzhuB1pZtSLJrn8+B1Wdcb7flbRBGifleBfYXSIN2e
	 XYy4qrpALsYso5eVfJ25wMPlTIvNayYb2EkZFLDI=
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
Subject: Re: [PATCH 6.12] 6.12.9-rc1 review
Date: Tue,  7 Jan 2025 13:24:44 -0800
Message-Id: <1736285084-7927-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250106151141.738050441@linuxfoundation.org>
References: <20250106151141.738050441@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel builds fine for v6.12.9-rc1 on x86 and arm64 Azure VM.

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

