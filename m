Return-Path: <stable+bounces-238383-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJkROnKM4WnXugAAu9opvQ
	(envelope-from <stable+bounces-238383-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 03:27:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 537DD415FCB
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 03:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66F9730A5402
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 01:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37912517A5;
	Fri, 17 Apr 2026 01:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4ZKHWdD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CA5194AE6
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 01:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776389066; cv=none; b=RHt5XdC6cd5bpXVVAXm3dwtKPw/qMBL/4jnGyhyfLVvvu6pLSKP/j/2ZJ+R9dFa7tJsz3LDqadE++jE0bLlg78obppoByYMG4BGIz7XEtY7b9x/cIpJ9HLOQMLQi224GsMWeptdhN1I34Kic2Z6WsTsTe1rkZP7PE0HenKKuqQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776389066; c=relaxed/simple;
	bh=Tw/UOvoceKE5QujmyaO+aYDZQJfXIPjW1vWdAuK5CJY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=QH7GQxZ9vt+V38fZ/u1L9vvt9yBI2IqRhoyDRe9Uy2xurneNGeMMy8BRNyYcIvGUYxsWpkXeNrdetiikN5cti5JazN2kM3C3C4AY+GXVcTKdP61rY9kiGxTEFXhc3zpV3F24UY3OBRrHfeZ/83AEfbvb2wxXMsdiNZzxGMw/fzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4ZKHWdD; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35fc258aaa4so109018a91.2
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 18:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776389065; x=1776993865; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cpOJeXbfkQGfp2oJxb2u3PSnQNyOEp2e2c25qGS5Duw=;
        b=r4ZKHWdDGZarPAient8RdIqeZHFIyyeLztwzfm9mgWYxQanoy7gvEscGAUfkCXJaLM
         KBzM/2oySD+RYhjpNkpzg0bRDOWF0LRsL1d4OnsD98L1kZErgEeex5HOluoXemHZ3FSg
         0CTzISE8DOvbJeWFldlyGuqemcgYGClczucGH3sxISikMEx1/9HSD7XGRJi/5zOK3Oyq
         8P2OT35I4uWdJi0tIWH+8HJSx3QY/L6I5sunN/T63KjLZ1ffA8L+NUrL+tlSxfJDFlIG
         8Vk67M7DYDoLnbJ0YiI1kKN3g9SGfkGdWmCa9Kg94k6xtcd98cjWqoC+SHyzVPZ+zxW4
         tGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776389065; x=1776993865;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cpOJeXbfkQGfp2oJxb2u3PSnQNyOEp2e2c25qGS5Duw=;
        b=SAyFw7toiTywvcvGBV1aRxJGWru3Xl/3SduZupcSAI7fBw2HJqe9wkllGX/x9rgc7i
         l+aRpsa1euuHIVKBAiwz4Ctab8HhqjJJV5e4W3FdbQxVjLs2PHTYmsPImise2297Gj4h
         GADGWEyAA5k3p16NhWAVypf0zpbs96QRVuTApGhAXAB365iGq3b3fr4aRPsMtP3OXUCA
         jPWwKXCPjOUSRH9XBVPkoKgqF5cgHFAkXQBuL3lYlLMF+flCwAqSmIKo8Oqrw8odzfB1
         baTfsqAXqk4sw7z0Vc89enj9DoVvw2vQmFYuQ3LFQEM1nI4yjFQlQdULGnewpSe1YRAq
         JlJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CxP1WxmH5Y5FfMH71aL9chMaeogD+TUPTYvkSRXfquUfZAm0nlTiF1pWAMQG+NMIneFg7LtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw19hlFBC1/RcEluq7LF99S/UxgFO/Her6gU3RcnbqgIuFj8oux
	ShsngSumTMeO6qfNfZdLmfIH2GQR/hGssb4Xz/c2cEQe78Sx6X5iC4XI
X-Gm-Gg: AeBDieswO6ZVeYz6lQhenVuIsagFIf8GTW+xm9phgvYcGD7fFwormWdp+DrF8Y86hiV
	9bdjmI95r0VVCjFNZsRkpnzK+XPhe1AxdW6V+jKYGnX0YbPniTchAD0GP8mffXCHxr7onEmW1jZ
	8ATK18W3P13hUiJQdxERPaH1EyGoQiUoSFQy2SxWqK6kDEJ5h2UEKGyohOE1QzzEd90JNRAf/Ib
	CxfTAs+dIIY5Glwk9N7UB9OxMcV1kKkQt+0ztwnCCV52PDgQ/Hj4XzegJaxDwp/LyXOwPkU3EF9
	18r1cZ25+c7S4WmIvGKt/PNSLb1gTz1UN/IUiwddpUcQiYmSjxIRLeMcfsDAt0cGzh5UY9ICjuD
	ddzGy0iK1ITgDokRP7L4JrMXSJ9lD6+Wk0wGBZrkjBllC0BB7eTiLb3dXnokImCTh9La0n5QT35
	RFqpIYp1jIfUBSQpLAAw37dbFwo4efpUjFOdHbUkFqSec=
X-Received: by 2002:a17:90b:2fc8:b0:35e:5a4c:9069 with SMTP id 98e67ed59e1d1-3614048a431mr688213a91.14.1776389064664;
        Thu, 16 Apr 2026 18:24:24 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20c6asm1525035ad.58.2026.04.16.18.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 18:24:23 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Matthew Wilcox <willy@infradead.org>, Salvatore Dipietro <dipiets@amazon.it>
Cc: linux-kernel@vger.kernel.org, alisaidi@amazon.com, blakgeof@amazon.com, abuehaze@amazon.de, dipietro.salvatore@gmail.com, stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order allocation
In-Reply-To: <5x66n04a.ritesh.list@gmail.com>
Date: Thu, 16 Apr 2026 20:44:05 +0530
Message-ID: <ldenszsy.ritesh.list@gmail.com>
References: <20260403193535.9970-1-dipiets@amazon.it> <20260403193535.9970-2-dipiets@amazon.it> <adCQTF1PQnlbNMO8@casper.infradead.org> <5x66n04a.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,amazon.com,amazon.de,gmail.com,kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238383-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 537DD415FCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Matthew Wilcox <willy@infradead.org> writes:
>
>> On Fri, Apr 03, 2026 at 07:35:34PM +0000, Salvatore Dipietro wrote:
>>> Commit 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
>>> introduced high-order folio allocations in the buffered write
>>> path. When memory is fragmented, each failed allocation triggers
>>> compaction and drain_all_pages() via __alloc_pages_slowpath(),
>>> causing a 0.75x throughput drop on pgbench (simple-update) with 
>>> 1024 clients on a 96-vCPU arm64 system.
>>> 
>>> Strip __GFP_DIRECT_RECLAIM from folio allocations in
>>> iomap_get_folio() when the order exceeds PAGE_ALLOC_COSTLY_ORDER,
>>> making them purely opportunistic.
>>
>> If you look at __filemap_get_folio_mpol(), that's kind of being tried
>> already:
>>
>>                         if (order > min_order)
>>                                 alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
>>
>>  * %__GFP_NORETRY: The VM implementation will try only very lightweight
>>  * memory direct reclaim to get some memory under memory pressure (thus
>>  * it can sleep). It will avoid disruptive actions like OOM killer. The
>>  * caller must handle the failure which is quite likely to happen under
>>  * heavy memory pressure. The flag is suitable when failure can easily be
>>  * handled at small cost, such as reduced throughput.
>>
>> which, from the description, seemed like the right approach.  So either
>> the description or the implementation should be updated, I suppose?
>>
>> Now, what happens if you change those two lines to:
>>
>> 			if (order > min_order) {
>> 				alloc_gfp &= ~__GFP_DIRECT_RECLAIM;
>> 				alloc_gfp |= __GFP_NOWARN;
>> 			}
>
> Hi Matthew,
>
> Shouldn't we try this instead? This would still allows us to keep
> __GFP_NORETRY and hence light weight direct reclaim/compaction for
> atleast the non-costly order allocations, right?
>
>  			if (order > min_order) {
> 				alloc_gfp |= __GFP_NOWARN;
> 				if (order > PAGE_ALLOC_COSTLY_ORDER)
> 					alloc_gfp &= ~__GFP_DIRECT_RECLAIM;
> 				else
> 					alloc_gfp |= __GFP_NORETRY;
> 			}
>

Hi Salvatore,

Did you get a chance to test the above two options (shared by Matthew
and me)? And were you able to recover the performance back with those?

So, in a longer run, as Dave suggested, we might need to fix this by
maybe considering removing compaction in the direct reclaim path. But I
guess for fixing it in older kernel releases, we might need a quick fix
,so maybe worth trying the above suggested changes, perhaps.

Also, I am somehow not able to hit this problem at my end (even after
creating a bit of memory fragmentation). So please also feel free to
share the steps, if you have a setup to re-create it easily.

-ritesh

