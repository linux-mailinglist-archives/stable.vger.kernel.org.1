Return-Path: <stable+bounces-241516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM8mHl2E8GlwUQEAu9opvQ
	(envelope-from <stable+bounces-241516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:56:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B933481FE5
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D7C73179CC9
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 09:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD70F2EDD7D;
	Tue, 28 Apr 2026 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kUgg7TRV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PvulbjN4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kUgg7TRV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PvulbjN4"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328452E2852
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367843; cv=none; b=Cs+E56dS1aUdIntRVU4m52gRDsnxyb+NFvzSJHRZGMbO3EFc/xiZ/F7WLNIse3/ba13Us2xcVf8jb/hYEaWQc+cAqIbx0M93UgIoE42DD/4UfGdy/vBGdWUd/VEdYfKRvtxwEiewOodw2agUFaG4UNfIBllaor9bVHVKhRYFkPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367843; c=relaxed/simple;
	bh=PA9fxKq7lxNskoryAjYyd3PLmeRKDI8bkansAKhg+Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/mDuqjxREMNaod1fFV4ruQ59gmzQ5MAncErsvAo/zvq2lWg3qhR4t67BcWaNdP79N6UkK06Mk57/warqCm5yu28lCHfDwVGbf9DXb/XBlNvxNaOaKBcOn9lQILSdEtYB6UaWbNVe0mqAyA8fBL9bCDGW/PRH4zKVjunQ6z74o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kUgg7TRV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PvulbjN4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kUgg7TRV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PvulbjN4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7AD8F5BCD7;
	Tue, 28 Apr 2026 09:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777367840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adxW3bE/UIQhlebHqAzO4xAfXbzuOewNVGi1LVMnILU=;
	b=kUgg7TRVOIvhvznpuoMH3QRC5b4qXvdbH9zq8EU0zh9DZEZ3iHH48TrwTops0UY3vsC9jK
	CJs/XrSVUW2pRq0/HnB8oe30+REtCMWFyBNoNp+tMdC/Y9qPhHJ3JgmrDPTkX7Jt4BQOAw
	bASmqtJMW6jff733Qv/IU29/QQ05ddE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777367840;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adxW3bE/UIQhlebHqAzO4xAfXbzuOewNVGi1LVMnILU=;
	b=PvulbjN4QowOK2dqawYsA6yf4ixa0za3ASQd7XJZ9vDerVbkUEn3HuEc+x1VaKyjN/Sx7G
	pyNk9z8KSSM0kCCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777367840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adxW3bE/UIQhlebHqAzO4xAfXbzuOewNVGi1LVMnILU=;
	b=kUgg7TRVOIvhvznpuoMH3QRC5b4qXvdbH9zq8EU0zh9DZEZ3iHH48TrwTops0UY3vsC9jK
	CJs/XrSVUW2pRq0/HnB8oe30+REtCMWFyBNoNp+tMdC/Y9qPhHJ3JgmrDPTkX7Jt4BQOAw
	bASmqtJMW6jff733Qv/IU29/QQ05ddE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777367840;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adxW3bE/UIQhlebHqAzO4xAfXbzuOewNVGi1LVMnILU=;
	b=PvulbjN4QowOK2dqawYsA6yf4ixa0za3ASQd7XJZ9vDerVbkUEn3HuEc+x1VaKyjN/Sx7G
	pyNk9z8KSSM0kCCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6FA7593B0;
	Tue, 28 Apr 2026 09:17:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YkB4Lh978Gl1ZwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 28 Apr 2026 09:17:19 +0000
Date: Tue, 28 Apr 2026 11:17:14 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Dan Williams <djbw@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [PATCH v2 3/3] drivers/base/memory: fix locking for poison
 accounting lookup
Message-ID: <afB7Go7JqhIpjU5J@localhost.localdomain>
References: <20260428085219.1316047-1-songmuchun@bytedance.com>
 <20260428085219.1316047-4-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428085219.1316047-4-songmuchun@bytedance.com>
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8B933481FE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241516-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,linux-foundation.org,intel.com,gmail.com,huawei.com,kvack.org,vger.kernel.org,lists.linux.dev,linux.dev];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,localhost.localdomain:mid,bytedance.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 04:52:19PM +0800, Muchun Song wrote:
> memblk_nr_poison_inc() and memblk_nr_poison_sub() call
> find_memory_block_by_id(), which requires device_hotplug_lock to
> serialize the xarray lookup against memory block removal.
> 
> Take device_hotplug_lock around the lookup and nr_hwpoison update so
> the memory block cannot disappear between xa_load() and get_device().
> 
> Fixes: 5033091de814 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

It might have made sense to join both patches? Anyway:

Acked-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

