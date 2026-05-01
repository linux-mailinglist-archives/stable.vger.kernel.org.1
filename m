Return-Path: <stable+bounces-242527-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ob6CKOAZ9Wn3IQIAu9opvQ
	(envelope-from <stable+bounces-242527-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:23:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 927364AFCB2
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF3933007298
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 21:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D3D314A6B;
	Fri,  1 May 2026 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Z6bs7YYA"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFED33F588
	for <stable@vger.kernel.org>; Fri,  1 May 2026 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777670618; cv=none; b=k89WBGHLTiF+fpMvzNJNArCO3L/5dOjnnN42tgaLbMR7Gt7UBI4LmJI6rz5E6OK97idI8qlffFbOVLkHz3Thwa7huA5QuJ8yPtU5BWSGEIiPKCjNfLEEmFTx5zNL0p8qmehL6S6Vvy+czTtE5R/79Ha9WZIC9XQWTthUkfv+SIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777670618; c=relaxed/simple;
	bh=MgTVqLPxCJQPdt66ehbgtEHxmumVG1Y1HmC9LFQlnZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4T4GozWKG1+ahKEI7QAarrM9qCg77I008+tqFVmxRpUqZ62xzAL1jWhIwi96cYjrvC9bi++jF7R0fon4MHiiHXn9lqpv62o81oGpa/QWv2NDf/TeWoM4zpJSHdKXCJ2pTtu87w+x1PLCUAcwXzbRrHbJLank9LehlSariFbwZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Z6bs7YYA; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-463a0e14abfso1248988b6e.2
        for <stable@vger.kernel.org>; Fri, 01 May 2026 14:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777670616; x=1778275416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ilfsX95hfqRZhGvVYVhyOiHry5JNrhME4LdqlZnPG9M=;
        b=Z6bs7YYA/7R7oVrdRCIEYpfXecEHFQfUpr7E7tx1lMRV9tjRq/POnt5Kmn/ZT9HsOy
         4LV1OVkYOe+mrQJuJSMiw2RSUQF5B9hPM6dIuNxCwfW4H4lFrFGja9mB/ZxxCS8FpcbZ
         azPoPiKPxJz+psiGborD3LSZ321MfFHQO5Cho58pqqP5hUQStTIiiZjwCuvt35PfnSak
         YVatCPu7khkYJfpaBM/599thqX2fB/TKjZKfJYTFEYIrpzVQHLU1YrwzuAa1tdhSvnqj
         FFiGM0j6T5QYerf141GTVqdRW7WyON9f2dmAoIIJcTA7YK+kZTD9rz7k8hIrQGdTXHvY
         izmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777670616; x=1778275416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilfsX95hfqRZhGvVYVhyOiHry5JNrhME4LdqlZnPG9M=;
        b=YncLtJhwoOvnXId/GZQNGIIwTuU36c6DXN2ugzt7irG5jEuEUN/8q9OLFpOjvPBRyz
         uwAOZKTlivG8XQACjkZNhqmow2+IKkg8pf2Tz2t/tL36blkRMkYfe25wLFRghEM62vZ0
         rQ/yRz/yPmTbpxXN8/sL8/39EWecba4ZdSubfUloNV8KAVoezD/nNxLfatEypmQC7Fvq
         tTdB/MnEeC+hni5WY9ptnXayycUpElespG8lyDk7wJKwzgcbGYCtsewsIFLTVxWVESHc
         3lLhYHaBq8DLWXZX9hV6SCTurXMl6SxfxQPZvuZ/9x41cBiC0ee05+vDXf7HmMDTS4Ob
         QK7A==
X-Forwarded-Encrypted: i=1; AFNElJ/zUSqs2HahYYm/CJ8QYfLNSNwyiaYw26QZeRDYwo4sCORiJYgmkesBCuW0VpZ9gwGQy7WYFys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTODXV1RkR4cD1OndTQbzCOAjqf7ijQGrt5K76YxTs76RGutFY
	zqXFnjEz1b6reMjvoSJoRVBHFg3TyrzG2vmPrBX1QI0pVP5mf4N71TDZK7KIZAwzQHbznT7F0+u
	b6H8A
X-Gm-Gg: AeBDievF3HbkjbIpwVhtuK1XpNVnXie3n7TwufWkEN9DiOYF8GrBaGql7UEq+bEjK3Z
	WDFUKhMJZKmmJqZmOROVqJ2QpiMrVanP2GaHQZasyJ5XvSs6vmZwjX2kU8435zUcJddhtCLkFcN
	SoyvqszF4LUuWCamCffqin0dHBOcaiFoibY1eNmpmmvKnYX2IIpMNrfBV8B8LyD+5gM8vz+lhKW
	xnzni1oXcmlPNeM+uSmkk1HZyPDI+5FWFHrvIuTAMwWzY8fvJTTbv9daqIhBGrBTdZapYvcLtSf
	4xQ/t5YN+cOsAM6zATqYQq4f2Mhe6UCXeQEDXsJOGEei+T/UX3Cb7pQGkBsagZAog9rCfCW9Mfx
	NlamBCjt6smK4MVjnDZunV3MPoXoMeBEslS+dGXAufLmJ7Xb0qWto57V+2brshH0g6GVK70Sgp6
	pB0jjA1JUkiuh+qMsFsjRVoLLQpHBAC4ixq+lMZsLPNxLzCxL8uuR8q60Dpex4U6TMM7Bg+0zL1
	gLGHCO0s5m8Ejv4I/rK
X-Received: by 2002:a05:6808:2391:b0:47a:421:c342 with SMTP id 5614622812f47-47c8924a440mr666735b6e.31.1777670615817;
        Fri, 01 May 2026 14:23:35 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454d35e5bsm3588214fac.15.2026.05.01.14.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 14:23:34 -0700 (PDT)
Message-ID: <6eb47d20-ed49-45f6-90f1-41c15fa99896@kernel.dk>
Date: Fri, 1 May 2026 15:23:33 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 491/491] io_uring/poll: correctly handle
 io_poll_add() return value on update
To: Sasha Levin <sashal@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev,
 syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com,
 lvc-project@linuxtesting.org, Fedor Pchelkin <pchelkin@ispras.ru>
References: <20260413155819.042779211@linuxfoundation.org>
 <20260501111233-b371eac52cd006bfddfbd9e5-pchelkin@ispras>
 <20260501200000.item005-revert@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260501200000.item005-revert@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 927364AFCB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	TAGGED_FROM(0.00)[bounces-242527-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,641eec6b7af1f62f2b99];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]

On 5/1/26 3:11 PM, Sasha Levin wrote:
> On Fri, 01 May 2026 11:54:18 +0300, Fedor Pchelkin wrote:
>> The Fixes: tag of upstream 84230ad2d2afb points to 97b388d70b53
>> ("io_uring: handle completions in the core", v5.19), which is NOT
>> present in 5.10 or 5.15. Additionally, in 5.10/5.15 'preq->result'
>> is unsigned so the 'if (preq->result < 0)' check is a no-op, and
>> __io_poll_add() already completes the request when it returns
>> non-zero, leading to a potential double-completion.
>>
>> I would suggest to revert the patch from these trees because there
>> appears to be no real bug to fix.
> 
> Agreed. I've reverted both the original backport and the followup
> "fix backport" commit on 5.10 and 5.15.

Please hold off, I have fully tested these. It's quite possible they are
wonky in certain ways, but they currently fix a livelock as well that
you can hit on 5.10/15 which is arguably worse. Double claim + complete
should be handled by the poll grab side, I'm _assuming_ more cosmetic
than anything else.

Please refrain from dropping patches until they have been confirmed by
someone that actually knows the code. I've been busy today and haven't
had time to look into this one just yet. You're just making more work
for me by dropping this you have little insight into.

-- 
Jens Axboe

