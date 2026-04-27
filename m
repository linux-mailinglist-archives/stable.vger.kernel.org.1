Return-Path: <stable+bounces-241261-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNtVD/sa72lx6gAAu9opvQ
	(envelope-from <stable+bounces-241261-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:14:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1BC46EE6B
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3613B301877F
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3071139A06D;
	Mon, 27 Apr 2026 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0z0jaFwz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1mckzUnH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0z0jaFwz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1mckzUnH"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9593A274B2B
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277634; cv=none; b=LljthPUeifAGm8k3HVeQdvyveI6mAn14iJSvB45of1WZDfeeefaeQblx4OYcA0cxIYPGMcJezQFAXKgftgoNU42ot5ZVx9ccCKNH6X7EFRhQN7QE5GMbpXLC999CErPLF8cQ0ZWg7km0GC/UdnOUlKRtiipF9n657dWJMwfmJOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277634; c=relaxed/simple;
	bh=kyja/qOn+Gep0NNihkLykCIrfJKYmPZmQ+16pvFk/g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uflfTviY3bTquqnURBSDXQICkecvRdCN1/4CggiPjW16bOu9GzS98ufsEk30uMKJYq1O3WDZn7D7mw1230UsG6CwVydgLcGXNE9fE4I1TtY7jsy/bvO7N3iZAnXcJEQHfXGFValniu7VdG2oBo6bwOegIr5NK57l4rICF/PqpdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0z0jaFwz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1mckzUnH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0z0jaFwz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1mckzUnH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D30B65BCF0;
	Mon, 27 Apr 2026 08:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777277630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuQV9jJyH30aDM2Bz1IuN9VTNix0UN5WEuQpT3Fpupc=;
	b=0z0jaFwzAjjEyKQxnVCt3DilS1qh8AVcUTdjyNX9unVq71cORSUkjbaygEJPik9LIzf4bc
	Z8SuT053SuJrTslUBIKlc/x+7oM3wj0eXJKPhEN3JNP6wTyYIWhvCfw0Ddfw41EHJHuAif
	jEHll/97pqpvBeKOeMxbUae/Tdvx3eM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777277630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuQV9jJyH30aDM2Bz1IuN9VTNix0UN5WEuQpT3Fpupc=;
	b=1mckzUnHukCKa96Ks+LmlW+gcWarB1YUDjcdhkHHVovufNMZltT1GNl9/Yv2OiTSp4b2em
	cmpT65Wlnu6oQTBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0z0jaFwz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1mckzUnH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777277630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuQV9jJyH30aDM2Bz1IuN9VTNix0UN5WEuQpT3Fpupc=;
	b=0z0jaFwzAjjEyKQxnVCt3DilS1qh8AVcUTdjyNX9unVq71cORSUkjbaygEJPik9LIzf4bc
	Z8SuT053SuJrTslUBIKlc/x+7oM3wj0eXJKPhEN3JNP6wTyYIWhvCfw0Ddfw41EHJHuAif
	jEHll/97pqpvBeKOeMxbUae/Tdvx3eM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777277630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuQV9jJyH30aDM2Bz1IuN9VTNix0UN5WEuQpT3Fpupc=;
	b=1mckzUnHukCKa96Ks+LmlW+gcWarB1YUDjcdhkHHVovufNMZltT1GNl9/Yv2OiTSp4b2em
	cmpT65Wlnu6oQTBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25062593B0;
	Mon, 27 Apr 2026 08:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LtDpBr4a72nSCAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 27 Apr 2026 08:13:50 +0000
Date: Mon, 27 Apr 2026 10:13:48 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/memory_hotplug: fix memory block reference leak
 on remove
Message-ID: <ae8avFsiMx-45ZOW@localhost.localdomain>
References: <20260426144447.817722-1-songmuchun@bytedance.com>
 <ae8U73RyTE2a6bdp@localhost.localdomain>
 <7887915D-E598-42B3-9AFE-BFFBACE8DE2D@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7887915D-E598-42B3-9AFE-BFFBACE8DE2D@linux.dev>
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 8E1BC46EE6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241261-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[bytedance.com,kernel.org,linux-foundation.org,linuxfoundation.org,gmail.com,intel.com,huawei.com,kvack.org,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[osalvador@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:email]

On Mon, Apr 27, 2026 at 04:02:17PM +0800, Muchun Song wrote:
> 
> 
> > On Apr 27, 2026, at 15:49, Oscar Salvador <osalvador@suse.de> wrote:
> > 2) I kind of dislike having an internal put_device() lingering here in
> >   memory-hotplug code, it feels like it does not really belong here.
> >   Ideally we should have a high-level function in drivers/base/memory.c
> >   that calls put_device itself.
> >   Something like "put_memblock_dev", dunno, names are hard.
> > 
> 
> I share your perspective. The current naming of find_memory_block_by_id
> is ambiguous as it fails to signal the internal 'get' operation. To improve
> clarity and reduce errors, it should be renamed to memory_block_get_by_id.
> Pairing this with a new memory_block_put function to wrap put_device
> would ensure a more robust and intuitive API.

Even better, yes.

Thanks!


-- 
Oscar Salvador
SUSE Labs

