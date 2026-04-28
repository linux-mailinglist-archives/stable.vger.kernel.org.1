Return-Path: <stable+bounces-241514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMKfM/B98GlSUAEAu9opvQ
	(envelope-from <stable+bounces-241514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:29:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1264816C4
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E04A3138921
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 09:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F043D904F;
	Tue, 28 Apr 2026 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SfSXql6/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="63pBZFqr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hhYoRYt0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o8agQQ+W"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB683D811C
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367645; cv=none; b=B8aO91uqQXROdwcquK4rCZcj0aRmX3OrT1bgx54lAaWgch/Lq1YjurVVxD7DdHUDhPTYD+nMzXGGdqw9dBEbJlfYyN5OnAAMytOwrllxSGtcHg0UsaAbANYcRkOv3sug+VN5FjvphpAdI/ZMntAXmo9QItI3HpPPNKUj+gKAviE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367645; c=relaxed/simple;
	bh=Dlefgr4rBy85PIs12XDa/VfFOMyPLFHn68qTeJ1N6Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G05zI2FmHM4tNJWKGz62p9t+S1bvHhUiTh3W6FB2ns/n3zK86C42Nr6h3wi7besgwz6mWESw5rIzC669OSfQ7+QytcCJtG/xxf2uIbvub6fauPh3ewr5XPitgO3d4wbjr3dAfSMjB+/oqpDIiVo9PLwmFKJ5ng3Rpmr2n9X2Vfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SfSXql6/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=63pBZFqr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hhYoRYt0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o8agQQ+W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0DF286A7E7;
	Tue, 28 Apr 2026 09:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777367642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oa54dygvQ7e1WMzBvT0E6vQ7uFcWNMOK0rSl80PUuQ4=;
	b=SfSXql6/ADqv1mmrAcvNAD2fVa/7oNjp5KqdI0gurwAhE655uJA/ACz6h8PkXmB+Qz2pss
	DkJQe1O3wstOno4e/pTYxj0egdoQvBqWXgj4sTTORzMgME515sMG7mA3B9maWgF47BmdVq
	fjBez3/Ky2HJWa07E9EZFtTOZSpytdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777367642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oa54dygvQ7e1WMzBvT0E6vQ7uFcWNMOK0rSl80PUuQ4=;
	b=63pBZFqru3aPfGK4CMZNXrthBm5ESnZqWt2FXDgufav1luqClxSnCPXdr7nxd+1EtyXO8s
	d7itJdzH0EJ2LfBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777367641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oa54dygvQ7e1WMzBvT0E6vQ7uFcWNMOK0rSl80PUuQ4=;
	b=hhYoRYt0FdBOl15l/k6ZYXGkFGP1iiCETZvpRPatgdFGu+MzVu+BAu03SM5Yzeo6TtT0xN
	3vDC0MoXOMmdbtLp8cJBHIkbXdimTbs2+BEFvC7bPbF96SlVkqRlhRrmud5x8ZY/BYY0U8
	ry4Y5vddJ1Oo/Sh5RlR0FsY1msxsq00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777367641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oa54dygvQ7e1WMzBvT0E6vQ7uFcWNMOK0rSl80PUuQ4=;
	b=o8agQQ+WsbKPzMbJZEsSG9vfXU8liYCM1F3jCjGCfKXBPmj0Yk510OWOnEIKJh0HPs0His
	VgoDB+99ImRVu9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34833593B0;
	Tue, 28 Apr 2026 09:14:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xl1PCVh68GkSZAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 28 Apr 2026 09:14:00 +0000
Date: Tue, 28 Apr 2026 11:13:58 +0200
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
Subject: Re: [PATCH v2 2/3] drivers/base/memory: fix memory block reference
 leak in poison accounting
Message-ID: <afB6VueAvlhMSb7Z@localhost.localdomain>
References: <20260428085219.1316047-1-songmuchun@bytedance.com>
 <20260428085219.1316047-3-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428085219.1316047-3-songmuchun@bytedance.com>
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CA1264816C4
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
	TAGGED_FROM(0.00)[bounces-241514-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,suse.de:dkim,suse.de:email,huawei.com:email,localhost.localdomain:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 04:52:18PM +0800, Muchun Song wrote:
> memblk_nr_poison_inc() and memblk_nr_poison_sub() look up a memory
> block via find_memory_block_by_id(), which acquires a reference to the
> memory block device.
> 
> Both helpers use the returned memory block without dropping that
> reference, leaking the device reference on each successful lookup. Drop
> the reference after updating nr_hwpoison.
> 
> Fixes: 5033091de814 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

