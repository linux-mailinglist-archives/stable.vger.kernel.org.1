Return-Path: <stable+bounces-35880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 735D2897BFD
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 01:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F161F27EE4
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 23:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8641E156C50;
	Wed,  3 Apr 2024 23:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xQ0RU73w"
X-Original-To: stable@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF3115699F;
	Wed,  3 Apr 2024 23:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712186685; cv=none; b=Sv4YekEj1lJsptjPmebZ0WZR8UqjAhoorxoohxuhtqDBqRAMU0tQzdZKOEEsnWqnAk6Hw/IMN2ryJLTnQQGR1Vcup21mXq0VIEsN0Qh3qJ9l9TCiEjaCIF6GeMOzAPRg9G6yCtAFWLC9oDsb+2mLnwU8VpGIyzQ5FkgukQfbWgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712186685; c=relaxed/simple;
	bh=pM9/ZTgzDuoqN/5Yhyq+wRZbOGlNKVeDvrBFQoAeICU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6vxe1MRS4PAUcgky/ZVePxNV/DkLsIgGgeCR9FSMK+NV1R2SMGJ5OXhEZlN7wabFBy7ve4a9I36BXNOU1L2rQLUlIAVtOYFXgceFJ0gFzw4YwgCY/s+SkOPdxQRI7Yy7p7hFU+eiMbdSgbrXZdSbUiIad000KJ2+gqFOahPlTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xQ0RU73w; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V916s06JBz6Cnk90;
	Wed,  3 Apr 2024 23:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712186674; x=1714778675; bh=GaQ3wPBf1YSzPwOXZZP9FBPm
	vGGpXPI+orClqrHPrcc=; b=xQ0RU73w4BqPafKh/fPsEu8hQffToqmiLfI21YNR
	+Lsa0TPbjLGMNhhWLaGRtEsILMNnlBeS/jpfJT9USwAiD8sTllzpxCM7pPhEi8Us
	meXxi3CXg5IvPAb1bVh2jqy+aeJhNmdYTcRhQ7g8JsnXmpvuMrKfKaGgl33e6bp6
	32MPgxBqYz4GNrLrIW2f1nNxrtQAk/AlMvqf1blRY0Ls4uWBePPzt8MYFCWcu23e
	rjD4ZtMiH+Ex6Bbl4B2BQtOhZjNbmZaaMlShoDwQYBqw3RC7Hpi72/9d3QpXrO5n
	hTtFsytDveFU7cxZXQgPk2L1RLMg2YlmhCj0FZOkvzxZMA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id KA4xZDbc_6iY; Wed,  3 Apr 2024 23:24:34 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V916m20SRz6Cnk8y;
	Wed,  3 Apr 2024 23:24:31 +0000 (UTC)
Message-ID: <bc800bdd-6563-40ba-bc8d-e98b87748c15@acm.org>
Date: Wed, 3 Apr 2024 16:24:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] scsi: sg: Avoid race in error handling & drop bogus
 warn
To: Alexander Wetzel <Alexander@wetzel-home.de>, dgilbert@interlog.com
Cc: gregkh@linuxfoundation.org, sachinp@linux.ibm.com,
 linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 martin.petersen@oracle.com, stable@vger.kernel.org
References: <81266270-42F4-48F9-9139-8F0C3F0A6553@linux.ibm.com>
 <20240401191038.18359-1-Alexander@wetzel-home.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240401191038.18359-1-Alexander@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/24 12:10 PM, Alexander Wetzel wrote:
> @@ -301,11 +302,12 @@ sg_open(struct inode *inode, struct file *filp)
>   
>   	/* This driver's module count bumped by fops_get in <linux/fs.h> */
>   	/* Prevent the device driver from vanishing while we sleep */
> -	retval = scsi_device_get(sdp->device);
> +	device = sdp->device;
> +	retval = scsi_device_get(device);
>   	if (retval)
>   		goto sg_put;

Are all the sdp->device -> device changes essential? Isn't there a
preference to minimize patches that will end up in the stable trees?

Thanks,

Bart.

