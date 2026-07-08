Return-Path: <stable+bounces-272663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CNdLIylkTmpDLwIAu9opvQ
	(envelope-from <stable+bounces-272663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 16:52:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A737279D5
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 16:52:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=x6mCiXdN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8N9SpLHj;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=x6mCiXdN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8N9SpLHj;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272663-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272663-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34C38305205A
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 14:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81843A5423;
	Wed,  8 Jul 2026 14:40:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E70345725
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 14:40:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521615; cv=none; b=VRWFAAO3qpIBTbijhwHkc+1n+b/ain3mGGfE/JiKukM7hKkKz1DuSA1T6fMxDcq8leuZE8PLYBYhb4T/3yr3ltIbsPJWAVzraxc2w+x+LZks/91kwKDXfvKe0pEWhrWcvq0KT9sDrzgNtiZtYXCz1D8Ki8hCo5LUVNpOOIx9X0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521615; c=relaxed/simple;
	bh=yuUVo46TPY5851lOHKupGp3FOepxlvwfEUBm91MEh4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3LOdpUHp5MRqcFKh6Ol4K3Xlu6d/TUdh1EF34YgiN8cTGsukQ9tRYrFo2cSfJ9IMuIhUXYfxkcHumeXBTbzAjXZB0YbisBdxXvIw2cfXuiKfr+APjcVHfn5qdGRqrNpi1gMilBU5V3l2lxXfosYx8KQggolLcDg4gY93z7MnMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x6mCiXdN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8N9SpLHj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x6mCiXdN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8N9SpLHj; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A2157590D;
	Wed,  8 Jul 2026 14:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783521612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IT6R9JdS1qWXaSJz8T2OAGJP2kCrD5Fj7NESw4gwF7U=;
	b=x6mCiXdNKicWFg2CWsB0PFahRQukGvEJqVl0pHyQO8vxsIq4rWrrJ0uTtGc3978stNW/tD
	QBGGLFNiFo+QM2KbLpRE2FjKeyWqKBIiXRa1qlnbqSDjGv7/YoP9m0ooYH8RZEu4nSIndW
	x6fDIgJoc+sEt7PKUCOrW1uQaZLASew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783521612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IT6R9JdS1qWXaSJz8T2OAGJP2kCrD5Fj7NESw4gwF7U=;
	b=8N9SpLHjhnDgpzT3KIggZCKa66Eeff4e1lNIH0LMvT/rVyhaaL6FBbW68MUOHw6ju+8Su6
	JMfdF9zbYgVyJeDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783521612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IT6R9JdS1qWXaSJz8T2OAGJP2kCrD5Fj7NESw4gwF7U=;
	b=x6mCiXdNKicWFg2CWsB0PFahRQukGvEJqVl0pHyQO8vxsIq4rWrrJ0uTtGc3978stNW/tD
	QBGGLFNiFo+QM2KbLpRE2FjKeyWqKBIiXRa1qlnbqSDjGv7/YoP9m0ooYH8RZEu4nSIndW
	x6fDIgJoc+sEt7PKUCOrW1uQaZLASew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783521612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IT6R9JdS1qWXaSJz8T2OAGJP2kCrD5Fj7NESw4gwF7U=;
	b=8N9SpLHjhnDgpzT3KIggZCKa66Eeff4e1lNIH0LMvT/rVyhaaL6FBbW68MUOHw6ju+8Su6
	JMfdF9zbYgVyJeDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A099D779AE;
	Wed,  8 Jul 2026 14:40:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9OPdI0phTmqNDAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 08 Jul 2026 14:40:10 +0000
Date: Wed, 8 Jul 2026 15:40:08 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Gregg Leventhal <gleventhal@janestreet.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>, 
	Eric Hagberg <ehagberg@janestreet.com>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH stable] mm/khugepaged: write all dirty file folios when
 collapsing
Message-ID: <ak5g9h3FuVn3bZ1G@pedro-suse>
References: <20260702165409.164568-1-pfalcato@suse.de>
 <akhYu66GmjyM8l6a@casper.infradead.org>
 <CAFN_u7HkJry=iFLbZ2vjzv5C=HnrptHfFJBLOqRq2m4LyhqV_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFN_u7HkJry=iFLbZ2vjzv5C=HnrptHfFJBLOqRq2m4LyhqV_w@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272663-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pfalcato@suse.de,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:gleventhal@janestreet.com,m:willy@infradead.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:baolin.wang@linux.alibaba.com,m:liam@infradead.org,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:stable@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:song@kernel.org,m:ehagberg@janestreet.com,m:ziy@nvidia.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.de:from_mime,suse.de:dkim,pedro-suse:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8A737279D5

On Wed, Jul 08, 2026 at 10:05:43AM -0400, Gregg Leventhal wrote:
> Hi there, just checking on the next steps here.
> 
> @Pedro Falcato Are you currently working on this patch (mentioned
> above, re: holding invalidate lock), or are we perhaps stalled on
> something?

I was waiting for some actual tags from people, but given the comments and
no tags, I'll respin a v2 before sending to Greg KH.

-- 
Pedro

