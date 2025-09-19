Return-Path: <stable+bounces-180615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE05B88653
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 10:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E14B7AB61E
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 08:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE502ECE85;
	Fri, 19 Sep 2025 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="pXc5EYRb"
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C72EC574;
	Fri, 19 Sep 2025 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270243; cv=none; b=l5lMtPmf7zYe/HFoj96xLEftYPV8Gl9ZoIvj7cq9U5wU/ii+wj3w8yJ9COppvMyh74tr87rSwu+ktrzkUASL4bzHuACKrd/v/BYxX7YQPnOIF8/sJkR3zm4wBNIUlSruKTaFpUsA7a2DrZLizqHPmryHHrLkk3MOaYkMf9FSKgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270243; c=relaxed/simple;
	bh=4W0g0d8sehQkpcgyGuZelCdtbmRc9cMqDZxPkYTObhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJZzi6POk8Y2Gp6pAnxWw8I4RATvuzC2UbSrTVGSFcBnxYSKticbqXBODXj9epeMBsLSxlt8b8H49wvnDLoZWQ/SRi3MhgOYJ5KOWLkc82WTXUipVxrSuOG4RvLvja4ZGnHJllyEpfrS5T8VJUAhTcchdAR9OGAgJWfZOeD/kPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=pXc5EYRb; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1758270232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fzQKh4eKK9BcMpr+vn4JCd8LIXiTtFPuKXSXEWunzk=;
	b=pXc5EYRbRYW11axFrlqzYgy3rmLPm7wJiQp2uAz1ybCghCGC5x67IuLUEdBMjq7EJTJ1Zy
	aogtkvS0F+OLvSDA==
Message-ID: <a9283590-1e44-483d-9a5a-b82de8bf91c3@hardfalcon.net>
Date: Fri, 19 Sep 2025 10:23:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.16 000/189] 6.16.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250917123351.839989757@linuxfoundation.org>
 <8296d8e5-bc76-4ce9-847d-4eedec16b5f4@hardfalcon.net>
Content-Language: en-US, de-DE, en-US-large
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <8296d8e5-bc76-4ce9-847d-4eedec16b5f4@hardfalcon.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[2025-09-17 22:51] Pascal Ernster:
> Hi Greg,
> 
> both vanilla 6.16.8-rc1 and 6.16.8-rc1 with the additional patch "netfilter: nft_set_pipapo: fix null deref for empty set" from the stable queue (https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.16/netfilter-nft_set_pipapo-fix-null-deref-for-empty-set.patch?id=0c6237e517860496c3dece455ec705bbcc9a0d79) compile fine for x86_64 using GCC 15.2.1+r22+gc4e96a094636 and binutils 2.45+r29+g2b2e51a31ec7, and the resulting kernels booted and ran/runs without any discernible issues on various physical machines of mine (Ivy Bridge, Haswell, Kaby Lake, Coffee Lake) and on a Zen 2 VM and a bunch of Kaby Lake VMs.

Tested-by: Pascal Ernster <git@hardfalcon.net>

