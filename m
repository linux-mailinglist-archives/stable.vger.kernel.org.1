Return-Path: <stable+bounces-273481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2YnrLEt3U2rPbAMAu9opvQ
	(envelope-from <stable+bounces-273481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 13:15:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E494174479A
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 13:15:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=nNp3n2hP;
	dmarc=pass (policy=none) header.from=arm.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273481-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273481-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2A47300F535
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 11:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34346399013;
	Sun, 12 Jul 2026 11:15:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3033C54723;
	Sun, 12 Jul 2026 11:15:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783854918; cv=none; b=VusMU+yvvnsrVDNMQjAXFVF8m22HroTYeWdMb4+O3JvH7NWYVZ01YvKD4TRJNjT3vo7d4I112E0EjKqVgNTIpbBqaw+qp5NsFm1Alwz05bP+OmLdTgPeY5r5OQJJ4ALwusWlLBrkXtDg4Fmp5WsmsG6r94TW+WKldlZSN8o+oro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783854918; c=relaxed/simple;
	bh=Vcd4S0/n1YBbjJkz56jbHGzwyr7k7DTjasJ05V+hMWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F41P6AQbK/Tqd4kkLHeqka49gi3DJxCWEepz2aleb0EOEt2d6T0R4Ex/rDsgrdPYU8aU5bPpj1UeXVAUFwBbrl4IfUI7EgOKJSlPr3pw2y5P3ePO4ECHhZy1ZpDCsp6/h9xmsUOPX9HkY/YVymTbwh+JOcZa2ti8L6RXTtXtU+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nNp3n2hP; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEBC31682;
	Sun, 12 Jul 2026 04:15:10 -0700 (PDT)
Received: from [10.163.128.224] (unknown [10.163.128.224])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C6C83F85F;
	Sun, 12 Jul 2026 04:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783854915; bh=Vcd4S0/n1YBbjJkz56jbHGzwyr7k7DTjasJ05V+hMWw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nNp3n2hPRF8jFhWCZX6wCuIbywwiB3hYynuZDcOYT44BI3Z4iB+WamOKaMhu7Ztkm
	 aoEdfHGxwxX+AoMnBbwN1J2wesaWqnIwAMByMteWUpiVRBSOApwddXXMZIzJyah/iQ
	 jM7CyliCS7kY/pAOTFvQv0J3UCJFdtZjR+aYOmNU=
Message-ID: <91dbf255-a549-42e1-846a-a9c4d290fa2c@arm.com>
Date: Sun, 12 Jul 2026 16:45:06 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/vmalloc: acquire init_mm read lock on huge vmap
 promotion
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 David Carlier <devnexen@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
 syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
References: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
 <20260710-series-vmap-race-fix-v1-1-5b3794c113fe@kernel.org>
 <d47ac961-4767-4ce4-9c75-f281beb24e42@arm.com>
 <2026071252-sweep-quirk-a068@gregkh>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <2026071252-sweep-quirk-a068@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-273481-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:ljs@kernel.org,m:akpm@linux-foundation.org,m:surenb@google.com,m:liam@infradead.org,m:vbabka@kernel.org,m:shakeel.butt@linux.dev,m:david@kernel.org,m:rppt@kernel.org,m:mhocko@suse.com,m:urezki@gmail.com,m:toshi.kani@hpe.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:devnexen@gmail.com,m:ryan.roberts@arm.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,m:syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,google.com,infradead.org,linux.dev,suse.com,gmail.com,hpe.com,arm.com,kvack.org,vger.kernel.org,lists.infradead.org,syzkaller.appspotmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,fd95a72470f5a44e464c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:from_mime,arm.com:dkim,arm.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E494174479A



On 12/07/26 1:31 pm, Greg KH wrote:
> On Sun, Jul 12, 2026 at 01:13:12PM +0530, Dev Jain wrote:
>>
>>
>> [-----]
>>
>>> We also define a guard class for mmap_read_trylock() so we can use
>>> cleanup.h to make the scope handling cleaner in the implementation.
>>>
>>
>> Will this cause backport problems, I think this scoped guard thingy is
>> not that old?
> 
> Don't worry about stable issues until after the fact.  Fix things
> properly in Linus's tree first.
> 
> And scoped guard has been backported to many of the LTS branches
> already.

Nice, thanks.


> 
> thanks,
> 
> greg k-h


