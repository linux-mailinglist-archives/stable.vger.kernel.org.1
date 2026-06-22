Return-Path: <stable+bounces-267697-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZHAZOiswOWqxoAcAu9opvQ
	(envelope-from <stable+bounces-267697-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 14:52:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4870F6AF93B
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 14:52:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ULbo00M0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267697-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267697-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8D713012264
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 12:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7AC3ACF06;
	Mon, 22 Jun 2026 12:52:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DCB3546C9
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 12:52:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132761; cv=none; b=nxrXXdHOXjyTPSiHrFgzurimnTWOGYTz559rg2IO0VjFeb/jh0QB+kSeD17G47WPne/8ZhAc2VxnJSufzWVo6x23W/WUqzsqxQcaC+km3f+O8tercEwdJlMb7IeIXnIopNAIRez5JxHnr2pBkg9X6O1Po4jgkafYYkZj5n3HHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132761; c=relaxed/simple;
	bh=MBz+h47MmTD70ZaqGtUgz/W/wnaBNDcGNSbdyOAgvGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntppV05JJb6JzWgbv/CAjdy6mBHEbYRMMI+nluG/6nfU4RLL1jZZIcr5Po0/gjip8FzfDuzfq35IdgH0p/+w8p+QPAAA2WzmV39fGpjNXuA+CxM1Xckrd352AX1A8kgH8un9mlDk+KlZsYhRW+kpcoDJoL4yCnexr+xYK+BNrk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULbo00M0; arc=none smtp.client-ip=209.85.218.50
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c029505b389so907815666b.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 05:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782132758; x=1782737558; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TkQhP0uWUVoXEcgVjZA91Kv5N2KnxefpO2wbntWaF0=;
        b=ULbo00M0y70sujRnudTfMn+YxkfzM6OVON5tNBoVS7+aBcgTdRGVojhLWoTTE1C5au
         C/A/CrYpr7Cy48qcX740gy7GEpyoIreBYKfDynLFqs7sL9YnuiDbw5bRvtYGl+tLUKcr
         1pTeEmWxyKRxqQc3OgzVfcxy8/KXwl8bVyM3/Y2N5i4n8MdVrZNV16nxEHGUDChr0udB
         FbXna+vTp6lXpCqQTYoJ8l4QMcLSDOFymw+8rucnmmnudqR3YFrXg0XYJ6rIfeMkNrT9
         dbsRrtum2bq+uFjp1Choa2TSFAh5FCkF4CEZALLMz4rsgR2Y46wnvm508y6oAZij30Ua
         oLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782132758; x=1782737558;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TkQhP0uWUVoXEcgVjZA91Kv5N2KnxefpO2wbntWaF0=;
        b=TsiFed/4/BoGfh7qq8n/TscrQpDDaALfXDw8QN1VU8rH5zkenImQDuJiiEPgpeI0Iv
         SXOzJA0fVY6crQwdVdPYYywcIbXyACaa73mUC+375dctwJVoH6u8LtG0HxbbHOmnk8Iu
         mUlOqqnhT4a2tuMclzTYrqV7KdI6NC+0hkHMCfPtfBRRC0N0p5cEK51hbcsF9Fm4LN6V
         IkbqeLE/KVezPC/suPVPO7wKIDAqdlTF0EFSrrlcmt0ttUeCx/3guLXpi9EmY5RYBAz7
         XvIr6wcdeG7vJ93RadZVncFFGmYw5BI0g1JuXgKJDvaWtDhFDgR6VCc4v1rJOB1lDnpL
         QUyg==
X-Forwarded-Encrypted: i=1; AFNElJ+E/vY0fLetx5FimlZxLQ5sWWQyqiTOFu9GRCaCTRHo1xrlVkkOTOR62zHZGgZBcxC7vHv196k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qzBOm1Ru4ZFS8vLFuwXKEHKuTC+FtP99EXfrQxVhhrjyGItG
	wjxmOZB72Gsh21lTnyr9Lowi4itZUKd9CT/AD+fEiaYTPDCkKaDR+m/k
X-Gm-Gg: AfdE7cmu98b+Lsucd0Qc85+F3XaHEcUQu5JsInDfs5w30pLWlN8InXUEalnn8uT3AwU
	r7RwDUGDsl8mYy4tBALx312H1+ibU8o0bf0GzLajst8CaQLgEFDw9mpyepBC8TeZRp+1fl5Z7/W
	pPn0xYC5ZRZixV0JQuXSdUYtVmjlyXbLuJckcJJOtb4XuhVqqp01kpDobtQaJPHEU/IDTJEd/3F
	VaXy7FB07F6cvFVatBMxw3Y4GJdP64Q19f3Os3q6xNrRJnro5YY9FDKUm26B8JqXwCcFMWoBU6b
	xgvABdfXOFDkl1EjXEDSDTIxqQON1myZFlNg3dVcDnnnRJlk2bGJNuSjThz1zcBPXhnc9kHbN8Z
	A38nug5QA5Fj+VaR/BS0vUDx64s8G5nbis4XxculKISMIQQfz/xOrzkm9XDPUsL3cedZtbYkjD8
	DDE228biNlHSE=
X-Received: by 2002:a17:907:940e:b0:c08:580e:899a with SMTP id a640c23a62f3a-c09b7b99854mr653419266b.10.1782132758077;
        Mon, 22 Jun 2026 05:52:38 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e49a9fbsm354825066b.12.2026.06.22.05.52.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2026 05:52:37 -0700 (PDT)
Date: Mon, 22 Jun 2026 12:52:36 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>,
	akpm@linux-foundation.org, riel@surriel.com, liam@infradead.org,
	vbabka@kernel.org, harry@kernel.org, jannh@google.com,
	balbirs@nvidia.com, ziy@nvidia.com, sj@kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [Patch v2] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260622125236.c7uqapdqn4bybvvp@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260616063436.20455-1-richard.weiyang@gmail.com>
 <ajUXNjRMraKb6k2n@lucifer>
 <5e7f7fe5-221a-4fca-aa76-297ae19eb80d@kernel.org>
 <20260620021353.nn7xp2ldqachq7gp@master>
 <35b8dea6-3f0e-4e95-bbcc-bb778e567d20@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35b8dea6-3f0e-4e95-bbcc-bb778e567d20@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:richard.weiyang@gmail.com,m:ljs@kernel.org,m:akpm@linux-foundation.org,m:riel@surriel.com,m:liam@infradead.org,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:balbirs@nvidia.com,m:ziy@nvidia.com,m:sj@kernel.org,m:linux-mm@kvack.org,m:stable@vger.kernel.org,m:richardweiyang@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267697-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,master:mid];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux-foundation.org,surriel.com,infradead.org,google.com,nvidia.com,kvack.org,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4870F6AF93B

On Mon, Jun 22, 2026 at 01:33:28PM +0200, David Hildenbrand (Arm) wrote:
>> 
>>>
>>> I can then follow up with a proper cleanup.
>>>
>> 
>> I would like to do a followup cleanup for this, may I have this chance?
>
>Let's fix it first and then decide how to proceed with this code here. I get the
>feeling that some more of this code might deserve a cleanup.
>

Sure, I will prepare the fix first.

-- 
Wei Yang
Help you, Help me

