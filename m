Return-Path: <stable+bounces-119591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9258AA452C3
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 03:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC773ABB62
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 02:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B960E1FFC44;
	Wed, 26 Feb 2025 02:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="NOSD3O5r"
X-Original-To: stable@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED7C1624C5;
	Wed, 26 Feb 2025 02:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535398; cv=none; b=pnbDY2zFv41qFfa2s8YA2y5PZx5os+d8rCOUsG9UpLZsYUxuuYHhfP9ah16WYisAJgkdFdmZglIBBN6e+cefcxTl85TX4FgKtu6QG0+p6kMJH112Cyuk47c1A2CUYLWwEj+U6iiYWk0EvDApwbV68yxHOTdme1ZMxFecJXveHCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535398; c=relaxed/simple;
	bh=7ZTH7oq2IoiaqJT7Ob6dFeLdBZygCMDgXFWf8c//0eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeIwzBti19vj1t2pQO2HhlyUoPHCYJq/AlO6ApE67vhf4iUJ5x40ixNX+WLwB7k1VZVv/JbnHYh4mkyoMqHZWG+iOZfKhZWskpAQWpos6V7nPo5hUoF678ZGEdaj01KsEZ9fn6JLmO2KH2+hKn8hmZfFcMWiaP0GmykpAExfiG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=NOSD3O5r; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.154])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id D6EC4200C0;
	Wed, 26 Feb 2025 02:03:14 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay4.mymailcheap.com (Postfix) with ESMTPS id 9418F20317;
	Wed, 26 Feb 2025 02:03:06 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id A1AA74002D;
	Wed, 26 Feb 2025 02:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1740535384; bh=7ZTH7oq2IoiaqJT7Ob6dFeLdBZygCMDgXFWf8c//0eI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NOSD3O5rqygmeAV52Pgnu6LRV7B9Crhqlq6Ew0ZFI0CLtJiSW08xb6Es8CMUKuML0
	 86XEA+du+VikmuZG3H4ObrxzAuBRIhRtye7x+/3ezEIQSdGHvPBQBRn9M5oXZqVq2m
	 Soa9XdrcgtZm2RMBjT6+w99uQLNteAnZB6BORPFQ=
Received: from [198.18.0.1] (unknown [58.32.35.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 63A2E4151A;
	Wed, 26 Feb 2025 02:03:02 +0000 (UTC)
Message-ID: <26fc7fdb-fa43-451b-8ad9-29298e354dc5@aosc.io>
Date: Wed, 26 Feb 2025 10:02:58 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH 0/5] drm/xe: enable driver usage on non-4KiB kernels
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Mingcong Bai <jeffbai@aosc.io>
References: <20250226-xe-non-4k-fix-v1-0-e61660b93cc3@aosc.io>
Content-Language: en-US
From: Kexy Biscuit <kexybiscuit@aosc.io>
In-Reply-To: <20250226-xe-non-4k-fix-v1-0-e61660b93cc3@aosc.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A1AA74002D
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [-0.09 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	URIBL_BLOCKED(0.00)[mail20.mymailcheap.com:helo,mail20.mymailcheap.com:rdns];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

Superseded by 
https://lore.kernel.org/all/20250226-xe-non-4k-fix-v1-0-80f23b5ee40e@aosc.io/.

-- 
Best Regards,
Kexy Biscuit

