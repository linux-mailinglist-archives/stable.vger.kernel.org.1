Return-Path: <stable+bounces-146161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E457FAC1BDA
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 07:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8A81BA7397
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 05:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB72218E02A;
	Fri, 23 May 2025 05:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EYpysIYY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pdWkQdAl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EYpysIYY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pdWkQdAl"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DC42DCBF6
	for <stable@vger.kernel.org>; Fri, 23 May 2025 05:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747978236; cv=none; b=A8EBpi0ZaIIbrcap5eQwXrwKpJ6ChzM21QhpUOh0bJQMPaQOvfMP4pw3loF8dTCtj49VoPar6H4klfk21Q0Ur3FZdUVYA1YQUW2weEhWCMsP9jqScSL0DccyS5Hc+oR2lescBafvW8Pgj+efvCBXCVwmqmVrIQlwvMRrQxBErkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747978236; c=relaxed/simple;
	bh=tzr1bN8lxnYyPZLjxelQ9v+WLhRicw0PA7d/BeZlYnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+U6f3wwbHK8zgtRf/cLh0p/kD8hqcebC1+ONEXajYEbsjRsXMg2+5FjrXqgZjGqCHGrUOcQr93Qw5OPwuxz/8ENiCVdKecPpEwshOVauz4Mmu04Qp7q9JG3MFt1QmwlNu8il5+XSNRe/eBqtYJmUBRfSb2Wt9zaotXLuReO4TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EYpysIYY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pdWkQdAl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EYpysIYY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pdWkQdAl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6D5FF1F453;
	Fri, 23 May 2025 05:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747978232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+zdohR9pkpuw32Z26HDZF6h+Z7FMzq1QFEgW1OfhB6Y=;
	b=EYpysIYYr3A+uz2pamcWcFC3MZvZXrvSu5vhphRjv+xRB9rqHrMAvwV1Gbw8iv880gy/L7
	qALd3xZZmfD6yDvquSJ3QT2oY0PEEgMCbAaBwgdDNZMllmlAbBE8rTBT4plNKU2KhORoX1
	yrIvOPNZe/ae60h8Zo8Nuz+fSOCrBcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747978232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+zdohR9pkpuw32Z26HDZF6h+Z7FMzq1QFEgW1OfhB6Y=;
	b=pdWkQdAlQ0POeFGMaEt4UsyVuING4gSVFB4WFsoWzNUgFoKPjVCw8o0OUZjRqh8Onx78if
	uJQk69nfnkEYtVAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EYpysIYY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pdWkQdAl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747978232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+zdohR9pkpuw32Z26HDZF6h+Z7FMzq1QFEgW1OfhB6Y=;
	b=EYpysIYYr3A+uz2pamcWcFC3MZvZXrvSu5vhphRjv+xRB9rqHrMAvwV1Gbw8iv880gy/L7
	qALd3xZZmfD6yDvquSJ3QT2oY0PEEgMCbAaBwgdDNZMllmlAbBE8rTBT4plNKU2KhORoX1
	yrIvOPNZe/ae60h8Zo8Nuz+fSOCrBcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747978232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+zdohR9pkpuw32Z26HDZF6h+Z7FMzq1QFEgW1OfhB6Y=;
	b=pdWkQdAlQ0POeFGMaEt4UsyVuING4gSVFB4WFsoWzNUgFoKPjVCw8o0OUZjRqh8Onx78if
	uJQk69nfnkEYtVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2CC213A3F;
	Fri, 23 May 2025 05:30:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WC6yMPcHMGh2eQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 23 May 2025 05:30:31 +0000
Date: Fri, 23 May 2025 07:30:22 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Ge Yang <yangge1116@126.com>
Cc: Muchun Song <muchun.song@linux.dev>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, 21cnbao@gmail.com, david@redhat.com,
	baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
Subject: Re: [PATCH] mm/hugetlb: fix kernel NULL pointer dereference when
 replacing free hugetlb folios
Message-ID: <aDAH7nI8H_JfGExm@localhost.localdomain>
References: <1747884137-26685-1-git-send-email-yangge1116@126.com>
 <644FF836-9DC7-42B4-BACE-C433E637B885@linux.dev>
 <aC63fmFKK84K7YiZ@localhost.localdomain>
 <ff6bd560-d249-418f-81f4-7cbe055a25ec@126.com>
 <aC8PRkyd3y74Ph5R@localhost.localdomain>
 <3B8641A1-5345-44A5-B610-9BCBC980493D@linux.dev>
 <aC974OtOuj9Tqzsa@localhost.localdomain>
 <DF103E57-601C-4CBB-99CA-088E1C29F517@linux.dev>
 <4e408146-7c77-4f6d-90e8-bb311d7ab53d@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e408146-7c77-4f6d-90e8-bb311d7ab53d@126.com>
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Queue-Id: 6D5FF1F453
X-Spam-Score: -1.51
X-Spam-Flag: NO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[126.com];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[126.com,gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,kvack.org,vger.kernel.org,gmail.com,redhat.com,linux.alibaba.com,hygon.cn];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]

On Fri, May 23, 2025 at 11:46:51AM +0800, Ge Yang wrote:
> The implementation of alloc_and_dissolve_hugetlb_folio differs between
> kernel 6.6 and kernel 6.15. To facilitate backporting, I'm planning to
> submit another patch based on Oscar Salvador's suggestion.

If the code differs a lot between a stable version and upstream, the way
to go is to submit a specific patch for the stable one that applies
to that tree, e.g: [PATCH 6.6]...


-- 
Oscar Salvador
SUSE Labs

