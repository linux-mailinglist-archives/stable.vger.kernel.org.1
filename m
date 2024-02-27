Return-Path: <stable+bounces-23929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D50F8691E3
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD12C1F23CB0
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E07C13B2B3;
	Tue, 27 Feb 2024 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RulxtCmi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RulxtCmi"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532B813B78A
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040557; cv=none; b=Vk2WtiY4XyA28whufvmvJu0+ybsS8rwjqi8w6I9t3Hh/KvyvoZkQgJBxpOMOmG6Gl2MARnPwJVP03Vq9CIPogfCmYuLntqh6RcyqFSSeduN/qhodVkubgZXYwXjc5aFL3PzoXBCIk/3WdPZqV0LI3JQYx57tMhesbX06xSWJ11I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040557; c=relaxed/simple;
	bh=RZHDU43rIhCcKRJScasPkPxqNO3aKdil5iGVBuxpx34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ze8qTSvPvFweK1fLKkeWjJFzCojophduuWGhI75Gck2qdFTyFoxm2Cke7thrwVZyuV5kt7yWszDDT2Wt0RK6qv8yE0cRYVTjwQ3cQ3qJd22QJt/ZwqMkDTcPbDfU4nrY7ouzp8N6h5FnG0TQC2qIKWiRuTepOcDic1JlHbOmlcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RulxtCmi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RulxtCmi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 751422248B;
	Tue, 27 Feb 2024 13:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709040552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hphB8WYyZqKKtNl1lOeGs+aUFWQOqOxwRRfvlbGw7po=;
	b=RulxtCmi4+PesRbRXndI9mUN2KNaTBHX+rBIh5lx8zRwjcIyRIlUAh1ed/YKJHWnrKBOXR
	beRAxlzHSa+eqrZS8insZLHfXmn+NJDq/ZBYxYmonMIpE2iDOlAHhbJl4iNX5kS/yU98N/
	k/W+cBd1bsxRlCAq3hPeM6NvgCP2bO0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709040552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hphB8WYyZqKKtNl1lOeGs+aUFWQOqOxwRRfvlbGw7po=;
	b=RulxtCmi4+PesRbRXndI9mUN2KNaTBHX+rBIh5lx8zRwjcIyRIlUAh1ed/YKJHWnrKBOXR
	beRAxlzHSa+eqrZS8insZLHfXmn+NJDq/ZBYxYmonMIpE2iDOlAHhbJl4iNX5kS/yU98N/
	k/W+cBd1bsxRlCAq3hPeM6NvgCP2bO0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C10B13A58;
	Tue, 27 Feb 2024 13:29:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LgRcGqjj3WVALwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 27 Feb 2024 13:29:12 +0000
Date: Tue, 27 Feb 2024 14:29:12 +0100
From: Michal Hocko <mhocko@suse.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, guro@fb.com, hannes@cmpxchg.org,
	hughd@google.com, shakeelb@google.com,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] memcg: fix use-after-free in
 uncharge_batch" failed to apply to 5.4-stable tree
Message-ID: <Zd3jqLMSktEpZPM4@tiehlicka>
References: <2024022759-crave-busily-bef7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022759-crave-busily-bef7@gregkh>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=RulxtCmi
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.52 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.51)[80.05%]
X-Spam-Score: -3.52
X-Rspamd-Queue-Id: 751422248B
X-Spam-Flag: NO

Why is this applied to 5.4?
$ git describe-ver 1a3e1f40962c
v5.9-rc1~97^2~97

I do not see 1a3e1f40962c in 5.4 stable tree. What am I missing?

On Tue 27-02-24 14:12:00, Greg KH wrote:
[...]
> Fixes: 1a3e1f40962c ("mm: memcontrol: decouple reference counting from page accounting")
> Reported-by: syzbot+b305848212deec86eabe@syzkaller.appspotmail.com
> Reported-by: syzbot+b5ea6fb6f139c8b9482b@syzkaller.appspotmail.com
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Hugh Dickins <hughd@google.com>
> Link: https://lkml.kernel.org/r/20200820090341.GC5033@dhcp22.suse.cz
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b807952b4d43..cfa6cbad21d5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6774,6 +6774,9 @@ static void uncharge_batch(const struct uncharge_gather *ug)
>  	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_pages);
>  	memcg_check_events(ug->memcg, ug->dummy_page);
>  	local_irq_restore(flags);
> +
> +	/* drop reference from uncharge_page */
> +	css_put(&ug->memcg->css);
>  }
>  
>  static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> @@ -6797,6 +6800,9 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  			uncharge_gather_clear(ug);
>  		}
>  		ug->memcg = page->mem_cgroup;
> +
> +		/* pairs with css_put in uncharge_batch */
> +		css_get(&ug->memcg->css);
>  	}
>  
>  	nr_pages = compound_nr(page);

-- 
Michal Hocko
SUSE Labs

