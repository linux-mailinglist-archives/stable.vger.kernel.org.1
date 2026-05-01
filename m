Return-Path: <stable+bounces-242533-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG9VDkge9WlqIgIAu9opvQ
	(envelope-from <stable+bounces-242533-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:42:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6BF4AFD75
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58F80300DF50
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 21:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC7135A933;
	Fri,  1 May 2026 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="XDMnYD2A"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C51B352F95
	for <stable@vger.kernel.org>; Fri,  1 May 2026 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777671729; cv=none; b=dnRJLzC+acr9EEABKeBXs9Z/72G7qdSEz+ZoQYNfdEiL00EpEPrWlLedyYYBySUt/p/w4pz0bhrJ0cttY4hmpIueZc/piLgLH2K3HkPGmGZ86abLkzdKDXOBVCgGB05JLitF1srbHCydSzuLZm1oX9EAgiNuCDq7uMXoQWmHFUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777671729; c=relaxed/simple;
	bh=lDM13he57cwPmcmYjRqkKJTWL/Cw4cBje7jFzjK14fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IO3zadhKxwXR5OqOgg8k/2D6avj+m2ObkYeNkFFMN3qYE/N5fO/04LGVGYnn6UeDu65I3j/weemJdEMgfpRuyc65vAJvY2Phi62NP+fn3oeY96TsmO8cbwWWqX9SfMI8rdUZ/IlDGnmbAiZrHLnVdBAGBqhlGNP03l4KevwM8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=XDMnYD2A; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-47c3b830c99so1517462b6e.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 14:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777671727; x=1778276527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hgj3oDBUCHFsd236n2RzKySxztc4GxMy6oFSyuV6Qw=;
        b=XDMnYD2AU2gFABwan0P4O7piomMuVweunfIJWvWgKLnMKFfdhrV+xeo6bGJe/dm/eN
         vYz33NX05UXtJh6Wm2G+3Y5/kKYuuFo3Geg4BV0JhwwYur+HTkxwWz87fRQIBl/gucID
         vzXZhOWbBYmTKQHKHpLW/q8sPlOJRALHCOoEpTLTLZ1SsJH9GyYWCeIhwzht9IHIReNA
         yARjkZhjj8Bypu+KLCVTCJhUaVmidHNLZDCxyMcDh/7R9QkpCJZfe0MzEMYJXFX7gThS
         qrT9223p9r0b+lMPXCfOJcjD+1ikQUHuTTbTvRjVc1v4Yt3v6nQJ3yUKaERolZUzSChR
         UaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777671727; x=1778276527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hgj3oDBUCHFsd236n2RzKySxztc4GxMy6oFSyuV6Qw=;
        b=Cvfgj/q4wxysXu5yG/HB6eVP2y8cLMzCIuxjoS04YPnt6a/nk1iY4eDBgNUi0hy3tv
         KJ0/gneNnaq3UxJn9Rz0BAHZvvZW+XytHxyj/NaDis4UYDZjKSVFe5mXUPhHzxgOMhpZ
         HeaM+HNTDeaF8Imi7Ou60uR2Nd5jFX2TmWywfTKaqVJJ5MXxVToYUr4U5eSWspoO8qxs
         Tw8Tv3SFqZPH90iJSPySCZ+i4TOReFNnFRVaI74rnKIjDtrruORKMF1RYovgKgpHIxUL
         E1W0CVyE9O2wpdT1UE+KAMNITR6Yt44B/8gtT3i9o5T1v12SvT4Ta6l50HZTD/MW/pYY
         fv0w==
X-Forwarded-Encrypted: i=1; AFNElJ+hX3ehY1IoCO1Wd2ZGeLydhYwiWz6mu/o9PU7n5BlVDk8sX/dRulYIRFKwUqGv1vpZE1lKc08=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn8aWOcC42Rb6/zW2hIFKCDIMXbIa27rBHXZWpy0OD4Bt4ks0d
	hPY0jqOO3KeNYxERBIBszVwcc1ei17Ba2Uj4iXkq0DevbreOoUGStbXvHfNlhr8bzFA=
X-Gm-Gg: AeBDietp8OuULzcqzvPzjTHgqmT034B5cntbw10X+DNa82EH4jspNJ+ocaitMlL+p5a
	kl1EWqBFe3OEg9ojbMW3N5MsPKF74edXPSxWritDdZWrt7BxBrLpCQeGx+6mnetN+1ApbPEowgR
	mfpJFb6bZDp8vIVI+H6W3eya9C30zySp3UV8P7vBKP2/XNQR1WtS5nBgW9JAvi9C7sq66hdycK4
	kMeoJb0L5Xg6Y54fFNQM/peoc/a0milJlAjuauj5zoakk7VtfX0wZva1SG4VJLPrSXLwiXgEdYT
	1QidhHvr9JWvOLNG4/TGT9sIjmA4DhHUpFo6QDvfVR1nVEzWRBDQzpccHeVXLinSoLJa+3gAUma
	pE9QXxDEhkIDC3/JcKNOL9yf8y+FvyP0x0RjJ5bsKzMqxKXE+9UefDAfrjRmE5ODDSshPY15ooP
	cBJwWibCzp9HeH4B4EMdOyfM+WOFZ+S0YVIRz4XODslqHw8WmEBH30cdaYlpbi0hKZyIZ9B/iRn
	Wtr8M3qrrVfX/uRe0gD
X-Received: by 2002:a05:6808:2217:b0:479:3a08:b50f with SMTP id 5614622812f47-47c88fb61bcmr762983b6e.4.1777671727140;
        Fri, 01 May 2026 14:42:07 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76400690sm2066165b6e.7.2026.05.01.14.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 14:42:06 -0700 (PDT)
Message-ID: <74e3db05-780a-4a2d-9e54-63a4f00decca@kernel.dk>
Date: Fri, 1 May 2026 15:42:05 -0600
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
 <6eb47d20-ed49-45f6-90f1-41c15fa99896@kernel.dk> <afUdfo_lfJJX_2pG@laps>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <afUdfo_lfJJX_2pG@laps>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8D6BF4AFD75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	TAGGED_FROM(0.00)[bounces-242533-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

On 5/1/26 3:39 PM, Sasha Levin wrote:
> On Fri, May 01, 2026 at 03:23:33PM -0600, Jens Axboe wrote:
>> On 5/1/26 3:11 PM, Sasha Levin wrote:
>>> On Fri, 01 May 2026 11:54:18 +0300, Fedor Pchelkin wrote:
>>>> The Fixes: tag of upstream 84230ad2d2afb points to 97b388d70b53
>>>> ("io_uring: handle completions in the core", v5.19), which is NOT
>>>> present in 5.10 or 5.15. Additionally, in 5.10/5.15 'preq->result'
>>>> is unsigned so the 'if (preq->result < 0)' check is a no-op, and
>>>> __io_poll_add() already completes the request when it returns
>>>> non-zero, leading to a potential double-completion.
>>>>
>>>> I would suggest to revert the patch from these trees because there
>>>> appears to be no real bug to fix.
>>>
>>> Agreed. I've reverted both the original backport and the followup
>>> "fix backport" commit on 5.10 and 5.15.
>>
>> Please hold off, I have fully tested these. It's quite possible they are
>> wonky in certain ways, but they currently fix a livelock as well that
>> you can hit on 5.10/15 which is arguably worse. Double claim + complete
>> should be handled by the poll grab side, I'm _assuming_ more cosmetic
>> than anything else.
>>
>> Please refrain from dropping patches until they have been confirmed by
>> someone that actually knows the code. I've been busy today and haven't
>> had time to look into this one just yet. You're just making more work
>> for me by dropping this you have little insight into.
> 
> I haven't realized that this was a custom backport - I thought that they were
> pulled in without the Fixes commit being present.
> 
> I'll drop the revert, luckily this wasn't pushed to stable-queue yet.

Please just add the fixup, which should go into 5.15-stable as well
of course. Both of those have been notified about previously.

-- 
Jens Axboe


