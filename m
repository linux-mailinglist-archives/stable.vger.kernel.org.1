Return-Path: <stable+bounces-267461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W6TINWn3NWoZ6gYAu9opvQ
	(envelope-from <stable+bounces-267461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 04:14:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F13D6A8317
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 04:14:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ch3pIZ0J;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267461-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267461-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB0EB300A4BD
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 02:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6C61C84CB;
	Sat, 20 Jun 2026 02:13:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E554F40D57C
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 02:13:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781921639; cv=none; b=EvHVEF1eFVwHh0vq3UrbXSuF+C9NnNArf8/nMFYsqnn6AkjS2P5nbf7Ho5zAHFJ15ZyaJ4eLiIaSMecNAJq8hyDr0uxqCQ5GJtpF6RMmID40L9ODoeJfVWEH9jhj95xVORAsOwDGxqv5W+w1zQO0EP9NFLL2HI5sp40Vdbc3K4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781921639; c=relaxed/simple;
	bh=Ywws/c6lGmoKUtLrCQAYhmxYgLwGGot56t7huhzXZgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Piu+tJGx9SuGq0AcuTx3qsm9ALIJumnhDro5rPPf+l36h5oVbR3YzdI4QqNEL3kHnh1QeUXYTffuysbArRuZ9DrNUJmy0FJJsXKAe+SCFW97E1YAcMyW1gsQ3PUcXvRtlr6Dhzsx97THRH9AVMtmgIhjVzMlsXYLTA+dlp95pNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ch3pIZ0J; arc=none smtp.client-ip=209.85.208.52
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-691c5776f35so3885203a12.3
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 19:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781921636; x=1782526436; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzIFxEJgw7O2jE+Y6+ZWgYeDKhaH241gll1Dl1i0MD0=;
        b=ch3pIZ0JX0AW2oMiU7lIioxIO1l3synsJi1YYh1QbClfzqCM6dHuaJO5a2RIZqvkf6
         zEBvKKSQ0ZzHl0p4VfEB0Zkud8LmTi+wqd44orVFbW/OWGLlcDaTdWRCaxX99LdQuw6o
         W7avGJJKtte1G6VeDgo1GMoQJ8y2XBaHzL4xyjtzzAjkkpbZdKRoYbMFcA8dPqNtuxut
         w8WA5rDNrT3OH24L7D56NZYRik5VeAGtyjJD8X2xUTv8IIHV8+5U6zj7eyZHhSo46HhC
         obkk8Cd0PqMdb4irM+qJblRrvm9pMYftYWJYWsM3pm6b3qRrRpQnd6BmnhBRWyHjPotQ
         XN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781921636; x=1782526436;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzIFxEJgw7O2jE+Y6+ZWgYeDKhaH241gll1Dl1i0MD0=;
        b=SBHNe6eXO/SA5ancEl4GIrlKjYuz8NzplCRQb3R53t08QKgrtXverKF2uN66VktgAw
         p8QmEBtPgtyIicy7M5mETQukZcPN4PlDfzcAVvQkM3+11j7NFkPwa4WPi0GiyrshWp0I
         5QyRRe+EMoQzMHqLAcTM9wcHzeCEXxDwVfIvnd1h6BRT7BT5ieZ2DGKM4NHQEtdY21N4
         bEjGusS1IQxk4fAOMTU34mEqBemvxDyMEWyHOi/5A/SR6MB7KaRgq+iOGCU3DzBesEW/
         B3jWB3V3iTYimldFJ/ksLjGXtW41ckbYaXLp9NnW3wLnt04P1e5vsmQ+hFzlZszvXvSq
         E6VA==
X-Forwarded-Encrypted: i=1; AFNElJ/aE1j1J5Ju6SWC+H6tiF2FGPLBV+5h1rohkboQmGZ0BDUxUqqs6WNkPvgC1NkKREMi9h1uKWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjo7Xb2NO/rtzp9ayRGHv8/zaH8Yk+SvuRGAZeOfMTBXHXv9zR
	z0ANeW7w/dhA4gCvK16dOt2Mc5zAgAuQF/kpx+Z0ZNL7QL07nGYaZU0z
X-Gm-Gg: AfdE7cmUWWluM2xjDd0b7ntBF4lVMjlQ1pLsUhjKbLzWWGCpIaAZsh8JCpcXIz1JBGx
	IT3GYAsw1izuJryHZlmV3mh4g401i4R6lhrjhrqfhTGzavX+bBDBhpQEUsSOtG7zf3eKihWC3ge
	2VqkfA0uRSvP9uR8vmxfq/bWP06InbdbdViDCe1xmN0PXsud9Qb50zFW7sUr8RYw8CGAwOWNfTj
	QWr8Xor60DqYvN8d+WS2w7j4QPhTNZ7KRHbuEuF5RDfUx1Ah3tdVY31mv0u8NFY2acTdotBatCu
	pmLfUh62+h/rb+5DHAookbe3NneJcKSvL+TS0KRlJ/I6HDH/e2hvtlOsHBUbNU1s1XDkoudoy5k
	lV2l/1OaHUYtlXBfZUdOeRvAwsO7dDRN45Zt38DmJLnIEH1f25P9XQrrGVt8eR/mhoIkU3yHHbH
	s4wJLPhZEMxNs=
X-Received: by 2002:a17:907:9411:b0:bef:89d9:9f08 with SMTP id a640c23a62f3a-c097ae38023mr306303966b.19.1781921635995;
        Fri, 19 Jun 2026 19:13:55 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e49aa07sm47766966b.10.2026.06.19.19.13.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jun 2026 19:13:54 -0700 (PDT)
Date: Sat, 20 Jun 2026 02:13:53 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Wei Yang <richard.weiyang@gmail.com>,
	akpm@linux-foundation.org, riel@surriel.com, liam@infradead.org,
	vbabka@kernel.org, harry@kernel.org, jannh@google.com,
	balbirs@nvidia.com, ziy@nvidia.com, sj@kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [Patch v2] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260620021353.nn7xp2ldqachq7gp@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260616063436.20455-1-richard.weiyang@gmail.com>
 <ajUXNjRMraKb6k2n@lucifer>
 <5e7f7fe5-221a-4fca-aa76-297ae19eb80d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e7f7fe5-221a-4fca-aa76-297ae19eb80d@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267461-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:ljs@kernel.org,m:richard.weiyang@gmail.com,m:akpm@linux-foundation.org,m:riel@surriel.com,m:liam@infradead.org,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:balbirs@nvidia.com,m:ziy@nvidia.com,m:sj@kernel.org,m:linux-mm@kvack.org,m:stable@vger.kernel.org,m:richardweiyang@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,master:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux-foundation.org,surriel.com,infradead.org,google.com,nvidia.com,kvack.org,vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F13D6A8317

On Fri, Jun 19, 2026 at 12:48:26PM +0200, David Hildenbrand (Arm) wrote:
>On 6/19/26 12:44, Lorenzo Stoakes wrote:
>> -cc wrong email
>> 
>> On Tue, Jun 16, 2026 at 06:34:36AM +0000, Wei Yang wrote:
>>> For pmd_trans_huge() and pmd_is_migration_entry(), we does following
>>> before return the pmd entry:
>>>
>>>   * re-validate pmd entry after PTL
>>>   * check PVMW_MIGRATION
>>>   * check_pmd()
>>>   * handle on pte level if split under us
>>>
>>> But for device-private pmd, we just return after pmd_lock().
>>>
>>> This may return improper entry, e.g. if we are looking for a migration
>>> entry, device-private entry could still be returned, which leads to data
>>> corruption.
>> 
>> I don't thik this is quite clear?
>> 
>> How about:
>> 
>> 	If a softleaf entry is present, the existing code simply acquires the
>> 	PMD lock and returns success even if PVMW_MIGRATION is set (indicating a
>> 	migration entry is sought), meaning that the caller can incorrectly
>> 	interpret the entry as something it is not, causing data corruption.
>> 
>>>
>>> This patch fixes commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration
>>> support device-private entries") by following the same pattern as
>>> pmd_trans_huge() and pmd_is_migration_entry() for device private entry.
>>>
>>> While at it, it cleanups the pmd entry handling in page_vma_mapped_walk().
>>>
>>>   * Instead of handling trans huge/migration entry/device private entry
>>>     in a mixed manner, we put each case into its own if condition and
>>>     handle with the same pattern.
>>>   * Also we grab PTL and make sure pmd is not changed under us after
>>>     above check instead of do the check with PTL hold.
>>>   * restart the process if pmd is changed under us
>> 
>> You're doing quite a bit for a fix and you're putting it all in one place.
>> 
>> How about do the fix as 1 patch, and then cleanups as other ones? It helps with
>> review too :)
>> 
>> It's a general rule of thumb that if you do more than one of moving, refactoring
>> or changing code, to do them as separate patches so a reviewer/somebody
>> bisecting can clearly separate each.
>> 
>> Also PLEASE do not add new functionality (this lock recheck) in a fixes
>> patch. We'll end up backporting new logic that way.
>> 
>> Make the fixes bit _minimal_.
>
>To be fair, I asked for this
>
>https://lore.kernel.org/all/2d48ef0d-1110-4a9d-adcb-f701a1ce2cfa@kernel.org/
>
>But given that Wei mostly used my quick draft without properly checking the
>implications, yeah, let's fix it first separately.

Sorry, if I misunderstand your point.

>
>I can then follow up with a proper cleanup.
>

I would like to do a followup cleanup for this, may I have this chance?

-- 
Wei Yang
Help you, Help me

