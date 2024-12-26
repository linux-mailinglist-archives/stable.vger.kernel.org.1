Return-Path: <stable+bounces-106161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C74179FCD5D
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 20:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA8716223F
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 19:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294351482E7;
	Thu, 26 Dec 2024 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QUXMJmfF"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE7B1EEF9;
	Thu, 26 Dec 2024 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735241743; cv=none; b=AXsroZxBfjDamhMp6XXcH5xwBPtiPopF81yPKotwAH894GezUdKmuq47KolisMiR5BeWxYk98W/Ri2HaM4Ve3qIyEr3zqa3SjirlFALKavVGM8smCUYix/EI9sGb5+G61mjp2hoADs8rtNZjhXngysqtteHMBnpHyD6xtP+DSVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735241743; c=relaxed/simple;
	bh=GRtnfnVOWPEn+zvANjj0DKcMAHdGvqC7AcyopvVipwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=djyeVutaECyVEl2IZRXdC58fqGyIQ8z5ViOGwpp864s7guqJAPlSNSOaFvzq3OGj/UYRocUGBn7PTbaZ+mG9+/2g+RaqYCTH3GdIhkoP27CZpMpCQ+Nwynr7NhOesJrRlMtNVX8WsSep18ue7RjaXuODP3bSZt/rhVHhMZx0mVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QUXMJmfF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 862D8203EC21; Thu, 26 Dec 2024 11:35:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 862D8203EC21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735241741;
	bh=GRtnfnVOWPEn+zvANjj0DKcMAHdGvqC7AcyopvVipwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUXMJmfFNZ0HQWQLgKvL/pIHqZnicJ+KGXX10Xr2PC+VLhamOz2A3QIkxIecp7Rpv
	 4jQBuS8t4KqicvoKL3zCpFyl89X5RZfQvHjrsn4VhpUZpF61anuX3fq8jAHnJyFpYH
	 CXw7wFR2TUbtFU1Fgk69SastNn6BTm77wA31JY64=
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
Subject: Re: [PATCH 6.12] 6.12.7-rc1 review
Date: Thu, 26 Dec 2024 11:35:41 -0800
Message-Id: <1735241741-22403-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20241223155408.598780301@linuxfoundation.org>
References: <20241223155408.598780301@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel builds fine for v6.12.7-rc1 on x86 and arm64 Azure VM.

Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

