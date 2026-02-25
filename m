Return-Path: <stable+bounces-219722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPWZAYhzn2mScAQAu9opvQ
	(envelope-from <stable+bounces-219722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 23:11:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B1119E318
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 23:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3785F303C818
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0BA2D595B;
	Wed, 25 Feb 2026 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUlp/MGS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FDF21B192
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772057475; cv=none; b=eQ0g3T8+xeYvUSrj3PAMRYw/GpecNEQcrwsdhjaHI7DqtZYKhr1U3vX229bjJaFMyej6dSXl7evs8KchqViCtGwkYzGOSKnOrNkQXzoG2HaOCe/DtTvBDw8ZBpOPPF8IGB/hlCu6AuXGmQuY5j7KLXJBbHpW7WzVuh2xAEz0Fgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772057475; c=relaxed/simple;
	bh=040+chYFRp8ObmlQdUo/liyivcE3aF9Yn4UUZV31FOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsyUlnsfU6QK5DrdhVsdQgPvtm8ltnyAi0vRYNNaCZ0nzYDYBpF7kjSR3F/xp4WbsxkZWptqAZBl8YLQH4wOcSUl6bJ2GQOxTIOYpqboWx1YVnzzON5fjDCqobgroz9JTwb/zVgDyN97XJ7qIbN4yUO4PqI8JHIEVBkA7ix7470=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUlp/MGS; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d195166b2cso72368a34.3
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 14:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772057473; x=1772662273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vU6GlShc4/RKkhIbjvbyyJHXZFOxo4/Rb7lB1rnFGYI=;
        b=mUlp/MGScVtmUbojGpeaUU3GpbLwIObMShELoJslnzOrkreMSU9nuicZnHRHkAVzOI
         Vfnr94l2weHgrfrweoM6D6/liREfGgPYsnCg08PvHrdhhTuHanW5wg6xshkjC9nojsV+
         U/iIqrM+Zf80muNq+k6TKN5YuOfnJjWDPfp8D2ECr6/MDreRnJ+U5fKuvUXrRXjXIluW
         z0DMsHVERrsR74ulSia1Jua/Nq7J2y+MCwN522g/XXD7gMHQtqryGLiObC4fC8upwiLV
         cw2HCHfBf/Yy4t9Q73CdLfyHCmbzZCY33sixp8yc6XvHYD5In7mdIujDc4AkqR84/o1R
         YI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772057473; x=1772662273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vU6GlShc4/RKkhIbjvbyyJHXZFOxo4/Rb7lB1rnFGYI=;
        b=Er4PiYhEEgvM9mzn3CsTkylg2N8TAUZ7ppCjKgHbJilaQeLqoOljq4ufklts/nUcN5
         jTebH2qSRkmVNTXqEiHog3qfdo5R9FIRUB0B7y2vDOV0plf3jDNFRJRqPWHG3fAq5xoI
         /QcsUYVWmD7TEQq5nZ9bD+yYGFU0zkRQ8NqKD/CwxGVsES2cv1VtrDsAoAS6077b6qPc
         YWrmeDSzwUo9mngcxeVXK5ju352V7w5QcTduVS4kUEE0780LYyzyxr4OT74gGTMLpPaO
         3DtT1U9raxKyxwPX8M2D6nX40Mnnll0b+i1mSwtxbFJpDyDS1QPDrZFwdDjomjiy8odY
         wnAA==
X-Forwarded-Encrypted: i=1; AJvYcCUszEj8PlP8g9XHabHTy2l5wjS1kQkWv5kXI1hvM1YeBosB82eH47CNg9Z4MX+sDILOE53elXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFbQkoQUSoICfGKjdMq65VZH+BjOzLBvADURfcl7tP/cBMYiIM
	PTCKMLk3fvy7r/ZtmorzVrPPTlNWSU1qpOT1UrbCwU84MkOvIw8cepCT
X-Gm-Gg: ATEYQzw5HdYbsnv/f9yHpd1XR65xAWcEFfCj6I2QOC7MutD5pnpwUEBOyIcd/TS9zfX
	tPqwJocPN1wIGg6zD76p3DjiPnkpovJMhpXqDnAHqIckJiXoMlaant9OxmUdepxpiB7yW2hTpBC
	u23MLJZuxa0FSN1C6g+nHyVr46jIqbwLpGZNminjPdHWHbkDvngYdII9VKh3xJp2zXGI3OcMrvm
	PfV7w7JyZKrbLPL7yw+Bmo9tgAXx8qHdEt+X2JnwqrP3EXQJ6i9bKj5023GbBshjsfH48H6YGUe
	IUPglsmSe2Ede3aUuSqJTaLcowWTDk8z2PvY8grItU/lQK6sUArQS91CdXu8e+FA2JgkmaJqQvy
	179L6sP5YtWosD2PjCt04pPccDbEU6/uJiN+PsSk+gjHjeKO0CY1p2RBVdTJhpzvBUZCPOCCfmM
	FzHy9rKoEmiDw3iPr0AUOZol+b2S/Fe0BkFW788w==
X-Received: by 2002:a05:6830:1b78:b0:7d5:2c30:9fba with SMTP id 46e09a7af769-7d52c30a246mr8551076a34.24.1772057472770;
        Wed, 25 Feb 2026 14:11:12 -0800 (PST)
Received: from fedora ([2603:8080:10f0:ab80::1382])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58666f30esm175108a34.26.2026.02.25.14.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 14:11:12 -0800 (PST)
Date: Wed, 25 Feb 2026 14:11:09 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "ptdesc: remove references to folios from
 __pagetable_ctor() and pagetable_dtor()"
Message-ID: <aZ9zfQU6xeTQyt2T@fedora>
References: <20260225002434.2953895-1-axelrasmussen@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225002434.2953895-1-axelrasmussen@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219722-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishalmoola@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72B1119E318
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 04:24:34PM -0800, Axel Rasmussen wrote:
> This change swapped out mod_node_page_state for lruvec_stat_add_folio.
> But, these two APIs are not interchangeable: the lruvec version also
> increments memcg stats, in addition to "global" pgdat stats.
> 
> So after this change, the "pagetables" memcg stat in memory.stat always
> yields "0", which is a userspace visible regression.
> 
> I tried to look for a refactor where we add a variant of
> lruvec_stat_mod_folio which takes a pgdat and a memcg instead of a
> folio, to try to adhere to the spirit of the original patch. But at the
> end of the day this just means we have to call
> folio_memcg(ptdesc_folio(ptdesc)) anyway, which doesn't really
> accomplish much.

I recall making sure we had a memcg_data member in ptdesc so that ptdesc
could directly reference it. Until we have a generic version, reverting
this patch should be the right way to go.

> This regression is visible in master as well as 6.18 stable, so CC
> stable too.
> 
> Fixes: f0c92726e89f ("ptdesc: remove references to folios from __pagetable_ctor() and pagetable_dtor()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

