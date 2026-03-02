Return-Path: <stable+bounces-222714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGLnKi0Apml5IwAAu9opvQ
	(envelope-from <stable+bounces-222714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 22:25:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 275A91E2C17
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 22:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AD0931311DE
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 21:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF651A6823;
	Mon,  2 Mar 2026 20:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NQq5OgWx"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082001A681E
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 20:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483928; cv=none; b=jqruaPB7s9Pmc7SR8aFgdzu6fW+L2osPlgqAmzqfXA9j0duCkEAkuPFUL0i6ErO/hxbrX8m7lHvhUWtBig4AUsWcusJ1xTklY1Vghf7ysoRjwqhvGyZ7+3FsNjU0IcLeRTXZ8BgYavx3ui1g9vII5Pa1e9WeY1cMYm1+Donda6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483928; c=relaxed/simple;
	bh=LXcLtM/kx7LU+eZlrjtF73nwVPSE1zWdexmOQkeMCho=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=n/OmR7sA3kpONNjY2v2ZvldVfS9WHKGFbsmS3EM0NEXkSFYpb5pVZnJpU+gocHF7gi83tksb46dYauLYArUTEWZq7Vq+2ooq4FUM2MUa0p9CANVf8yThFvZFwt6EusG6/Vx0DLCI5TQxo/tkAkaV3Si/4CLNL3J2F0HbgEb1uWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NQq5OgWx; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6775a46c6dfso1969571eaf.2
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 12:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772483926; x=1773088726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4cKiqpuNfqgg10fw7W0nzEjdq3eU52N2TAy+H6AH4n8=;
        b=NQq5OgWxEM7hGOsbZzwJG0wmEinJUC40nP1NvDddqc+HpPuKP/x1oBBR88lvAFTLcQ
         aFZ0ycwKjJLkr582aFXTBAds/KugiOQ8EAT4XZtc+jmxdKetBK7IlHODpOZrC9ke+gKm
         deKRK/Eh/NihzOrm5lSz4JIkc+mNE7ogXsSV2bJ0JJopKP/j6ewtQZdTRwsfJGsK1YNs
         VcYN8zHekdfRphcYZyAo4SBkDQuIIm5QqhzKjlrsJLA+FhosHUrFr4gkiEFnxdxfP/y9
         Nqqm2atB/bbwuQesRaB2kdDsi4CV+mU6IyrgJiUnHjqXxZmpAxnZe0vh7GhekVLcOgf6
         BOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772483926; x=1773088726;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cKiqpuNfqgg10fw7W0nzEjdq3eU52N2TAy+H6AH4n8=;
        b=HTYyRbkuX/Nm+CTGNccekEPewM1h6RmOYTjuDe+RS8sRX1QYuxQH95mvEOV5gVFNC1
         ndRPKR9oDbXEj0fldBB3yVP23M57ND6AgOqOM6sR8RmOKcKdHv6LT4y6hr3ee8TNh9q3
         DMTkZ/X25s46RvW0SLwt4e/dLCMJpc0T5xIOrlQH+BqSYxVkZVk35G+P9cmpii3P7uqg
         SYCQJiIDgR57AqAylMPa8/WVlbyIHiX304/cRsXVSoidZo3wq7NMkXw7Z4uAxDnE9KOO
         FCU+JF8CVdpN8pdi598bNGxaSo1BYOwbZ9KWDoYNvSUoncS+LmiZRfLBe9VJIoO2Pzu3
         yCsg==
X-Forwarded-Encrypted: i=1; AJvYcCVHm52m3rd0+KAHQ5vcCA9v54ejcT7CvJlqAnRLlUJ74kUlutXHn8qgaatpIGzN8l7emBvt8hE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqfICjJfuT4SGJB4CgSWsnSgewZ5F5iAQS6pSS71en0srjDFsX
	lqIVveXxTo0Fb92reTEorchqT9ver9tw2/pdNj9itvxUV+VHNygy8wz+6w5KQC2dysA=
X-Gm-Gg: ATEYQzxN50aE3EAWOx2LqfjzITKSkG7JIgmvinpyoS/pgYSyc62Qs1cc6vOlqAd2L4i
	r/ipFZ8ftbQG2nT8gisa4t81BFofY78+eNUQ85vn6gsTddOAsQ0Nx0zDCifvd7bhoaffTQL4zFl
	7wpQ655iIPyaIIT63hYv3rVAHBExLQsz39CUayHY+XsPkH0ku2jQPwaHl/Odt/6xDdNx/P6QaZR
	s3k/J9YWD7wy4rs0iBjDeXrhnFmnjImDxwsgrlZo94YNNqiIl2ktujrE5M1DjyEY4ZDhxbbVCOC
	Vr4Cp0xs3w5vLWFGwrSLBrb4MlsKVN0/CuwQJhW8hOZMOx3o+lmw6RbG7Egi2NsH9X8WmkJRIBX
	SxSkm2UW8qhcnxmVCHNeBVPU6u+fkmPSslt/WbehRsIYiDr3fCx3ljhHFtUmRK0NWgwyAl0eu8Y
	XtZD39wFQtkBjpdMVJfFZyYlJVOAqqHMr31lJ7FZY0x8wh5J0rMRjLXq4hbMmyqMDjv21pwomdr
	vqJwDxn5w==
X-Received: by 2002:a05:6820:1794:b0:679:a650:cc0b with SMTP id 006d021491bc7-679faf3393amr7841867eaf.51.1772483925842;
        Mon, 02 Mar 2026 12:38:45 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2be9b8bsm9798153eaf.5.2026.03.02.12.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 12:38:44 -0800 (PST)
Message-ID: <8e84b6c3-e62d-4aef-90b7-a7a0e63d8a17@kernel.dk>
Date: Mon, 2 Mar 2026 13:38:37 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: Patch "io_uring/filetable: clamp alloc_hint to the
 configured alloc range" failed to apply to 6.1-stable tree
From: Jens Axboe <axboe@kernel.dk>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: io-uring@vger.kernel.org
References: <20260301014717.1711200-1-sashal@kernel.org>
 <eb41b6f9-08f4-4972-99d4-3340571830bc@kernel.dk>
Content-Language: en-US
In-Reply-To: <eb41b6f9-08f4-4972-99d4-3340571830bc@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 275A91E2C17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-222714-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kernel.dk:mid]
X-Rspamd-Action: no action

On 3/1/26 6:15 AM, Jens Axboe wrote:
> On 2/28/26 6:47 PM, Sasha Levin wrote:
>> The patch below does not apply to the 6.1-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
> 
> And this one also picks cleanly into 6.1-stable. Not sure what is
> going on at your end?

Are these and the other "FAILED" false positives getting applied or
not? I didn't hear anything back on any of them.

-- 
Jens Axboe


