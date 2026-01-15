Return-Path: <stable+bounces-208420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A752ED228C8
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 07:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 953B0301F8F2
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 06:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAADD22CBC0;
	Thu, 15 Jan 2026 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KliSw+WN"
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A547381C4;
	Thu, 15 Jan 2026 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768458381; cv=none; b=EFlwtLcb8VkPbZ0L1JCCw5vgH9TkeN5uNhtBde87Qd/HKKX3/LrkqaEtev/vbumF+es1/UNH6mdK2A/xVnU1bq3bVuXC1PgtZa1+kMRqhJ7BDX8M2z36sEnIqHvUY7tQ/L1j6ungwnsQXhptVuwG6nGPF6nGihgYpeFGrntJNOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768458381; c=relaxed/simple;
	bh=4bWaNRd/9pK5d27UNaSsZ81eikp4OQNqsVqc86VgXeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJThfjTdwo83UONGptvpCsYNlHr/xDsiIKAjZgP9vYeU6KSsV7nH45g6FRkg1jyzZxNXe0sHb5xIx7lMJqYU5VEBqsSiG5a94f8klsgqATezEJtpVEU0hO8n6C+6aKI3f3Y9bEfngD0SAaFicZ+cq4ypg/M5D6YdAh7v2EpnDUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KliSw+WN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=rd4uquxchhYlI1uf+9FDWEl0NlqA5AmaEDZzEOPLiMs=; b=KliSw+WNr29bncz8c4BN7tP94e
	2jVB66hArpDHpsoMiE3XPFnrZjihb97/qrgTSQ0aDRTlRCAVno7g6IIR1g6uKMt6j6gYhYG5fK3zM
	gcoTrHfbKLrMmjWpd2CxkXAK9bPzYQB/kG+u1x2lqJEJPZ+I4Tpezici40KLfQbHl0DJKBx13Yg8p
	XF147lRY7Owy9KCFFtiiiouWBhEIczOZ1XSMbA87VgjzCclQvbuCOvBsHUReLQan1/yEyEtgo7gYU
	lRP72zjfMIztgfYPwofHlYWXHexwNV4VOo84UwrlVRK8bWWs+wSDM65c+xG1FleXTMimpP/Ghuu2+
	L8nFzDhA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgGoC-0000000BqpL-44N7;
	Thu, 15 Jan 2026 06:26:17 +0000
Message-ID: <e08ada29-556e-4251-b4bb-c122ca3ec3e0@infradead.org>
Date: Wed, 14 Jan 2026 22:26:16 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: errata: Workaround for SI L1 downstream
 coherency issue
To: Lucas Wei <lucaswei@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, sjadavani@google.com,
 stable@vger.kernel.org, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, robin.murphy@arm.com, maz@kernel.org
References: <20260114145243.3458315-1-lucaswei@google.com>
 <d10116ae-fc21-42e3-8ee0-a68d3bb72425@infradead.org>
 <CAPTxkvRXmVB9MbPX2vkyhAnLDyJX7YviekOH=y3EcS_1e796Zg@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAPTxkvRXmVB9MbPX2vkyhAnLDyJX7YviekOH=y3EcS_1e796Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 6:11 PM, Lucas Wei wrote:
> Hi Randy,
> 

>>> +/*
>>> + * We have some earlier use cases to call cache maintenance operation functions, for example,
>>> + * dcache_inval_poc() and dcache_clean_poc() in head.S, before making decision to turn on this
>>> + * workaround. Since the scope of this workaround is limited to non-coherent DMA agents, its
>>> + * safe to have the workaround off by default.
>>
>> But it's not off by default...
> 
> I think it's off by default.
> Would you point me to where the workaround was enabled without cmdline?

I'm probably confused by the Kconfig option defaulting to 'y' but the run-time option
itself is still off by default.  Sorry for the noise.

+config ARM64_ERRATUM_4311569
+	bool "SI L1: 4311569: workaround for premature CMO completion erratum"
+	default y
+	help
+	  This option adds the workaround for ARM SI L1 erratum 4311569.

-- 
~Randy


