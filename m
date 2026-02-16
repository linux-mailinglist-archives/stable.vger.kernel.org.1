Return-Path: <stable+bounces-216657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN5uM+CzkmmtwgEAu9opvQ
	(envelope-from <stable+bounces-216657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 07:06:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2F11410D7
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 07:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D37BA300B468
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 06:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECB12D4801;
	Mon, 16 Feb 2026 06:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOyCHyyi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA62882BB
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 06:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771221978; cv=none; b=tMRjtaKx/LTnmxbL3JBpUbUT4tX2Wu+BwmQ0cVtnG4IldOk0QdXHaCbxOylTsJM14dqGrh2hyUk6PSCEcryh22S7FzVgpPFB8MfdubXYUulkNtzfrmQktPG2iUGxCrNNeJM3+6PIguDasjZH+8c026Pvk2JqK0+CkVVbngBRnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771221978; c=relaxed/simple;
	bh=4YmefSX0GwRR0tYsar7+DiwN/P8tBU7V/nz8QCE6CBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUjmpqF0cokuK4a4GzEPZklwPCjgg+kwfA6l7k68KwqFKW8fWjDGT1OmG8nWXcyShJKDV5DIYyQEHXr6HOEp0kEIVksS4XSbnnKzs6K+shkjQ/EvuqsG6DewAbEPa8tu9PbiMqfNlx8huHvwkTGXjLVe3tvbXwN8gxR8NL3fIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOyCHyyi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a9296b3926so18633055ad.1
        for <stable@vger.kernel.org>; Sun, 15 Feb 2026 22:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771221976; x=1771826776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+1+2hICCHy9jpCc/dQXjjfX/dwmXFH+Uwwb20tfSQEQ=;
        b=WOyCHyyiuBQim8CjPJTuOULXbDHyKLR+v4PmezkoeeYzB4nYzJU4XthXIEnuVnV6YR
         2HMDk4fn5/GNiXoQDVdY+dsJR32T0tCd4nnRTUTZGapaj1Wbe6+5ujZkgnb96KtPead1
         5uSZuU5rJJ6PQIYqgIRwMSYGpflsE10LcIg/Wn8vvvgGFE8SsoMJiDI4aBibZYUup1Ju
         JEnBz82Bt9QYEZF+tE8csICogr6Mfe8zhFWDLiezBKdDVl/MHE6PPgs94KWs+lELuKrQ
         8mneu6JOqBiuu2rgevfBinzsCgKIFajpIRpYm3lQKGrPX91FAf3IKJW7fLKf1DXtAATH
         XJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771221976; x=1771826776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1+2hICCHy9jpCc/dQXjjfX/dwmXFH+Uwwb20tfSQEQ=;
        b=tT5iz4Tgs5Iq3SsPftOKocEfyPASnDJghRmuubG8/eSbSoBh0jUx7Id82o9mnr003Q
         /2ls158O1aDTqGZUYzfmwfZSRDLzzR8ZcsqnCqIu70rXGR4hvv+aZKETClPLtBa21Hld
         rtYwTH8e5+pcp5i5r+B5K5/ka7dGH82eyfjTC8VJUHO+IDCI+wmqflXzPE/rFjTMt/zs
         x1m90rZu/tlNoMTpRGbUSA54aFz0XmH7nYbhqQJL6Tfsg+ucZcTw4v193EfS7hY425M3
         2HGjqCC0cYDh9oUvA27ccJ9Wyn2RiDDr5IiTAL6DhihGLrQXAipEQnI8Mv7eKpWxXeC8
         3mmA==
X-Forwarded-Encrypted: i=1; AJvYcCWTOE3BWJT50krT9xoRNQJrf16z0G5Gd8ZFMJM1wR+RKj4AVNbAlUdVA4RabMm573GD4NKb6A0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ9KZ9XwozWb0yyh+VfHcjVxcnNVXxkOj7EiR7ueuhHbfvWfBE
	oireCN1BFOuahmSrEA/LbR8Dw4klHJA929sVJc+1RXJrit1sMLtlvPeZ
X-Gm-Gg: AZuq6aJ8JGqieJLQDYUCcEx0NYioC805tazQ8IMIZtgw02uut4lJIlW9kzvID0KHrUa
	BgWrdUrfHoszICQBLcfJKqKpDCjRy4uc1YnO376HA2PnV7s05+vluoDEHfZPKnGBNVGwJwhaQtT
	BxHsl1qzpKfPnXIK7Fe7VBvPqkevzgq55RlHCEz3GBUhU4D8tKgG3NyvQVWtduK632HsFlHAFaA
	7fRDfs4A7b0fZHK7BVqdh09LKZQ027845352ZZmsRyUptGjFrrG8snTO/IwjZbLecd2k6r8gHEq
	Wr8p27uUQ7S6lR+swdW2we8L66xJSsfVUrJoc63z18PHOL3fitNMKzcEXirhoQAjWZj3r76kR+7
	qxq/b4+3Q13LoLQDiyO04o8yUJt4//iMe2QgwKzwuMoD1wlo80Dc0xvSAXIPOwDP2eWujGSLlyR
	8Kf94aG3uoK6rl5x/Cjd+YoCDpuy2vTeAVU7nSPWwqoYQnxgW0NJlQg3AZUjnib5CTkTvhhQ==
X-Received: by 2002:a17:903:247:b0:2a9:634d:de98 with SMTP id d9443c01a7336-2ab5055e59dmr101213855ad.23.1771221976325;
        Sun, 15 Feb 2026 22:06:16 -0800 (PST)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aadd47csm57750265ad.65.2026.02.15.22.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 22:06:15 -0800 (PST)
Date: Mon, 16 Feb 2026 14:06:09 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Barry Song <21cnbao@gmail.com>
Cc: kasong@tencent.com, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Carsten Grohmann <mail@carstengrohmann.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, 
	Carsten Grohmann <carstengrohmann@gmx.de>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm, swap: speed up hibernation allocation and
 writeout
Message-ID: <aZKzUoZLp_3lK1s2@KASONG-MC4>
References: <20260216-hibernate-perf-v3-0-74e025091145@tencent.com>
 <20260216-hibernate-perf-v3-1-74e025091145@tencent.com>
 <CAGsJ_4zTCnL-bYN+nMXJEDPqHtF3hgiyHwyCoTc+nb-t6wouRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zTCnL-bYN+nMXJEDPqHtF3hgiyHwyCoTc+nb-t6wouRg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216657-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[tencent.com,kvack.org,linux-foundation.org,kernel.org,huaweicloud.com,gmail.com,redhat.com,carstengrohmann.de,vger.kernel.org,gmx.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1C2F11410D7
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 04:43:40AM +0800, Barry Song wrote:
> > @@ -1937,11 +1938,21 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
> >         if (get_swap_device_info(si)) {
> >                 if (si->flags & SWP_WRITEOK) {
> >                         /*
> > -                        * Grab the local lock to be compliant
> > -                        * with swap table allocation.
> > +                        * Try the local cluster first if it matches the device. If
> > +                        * not, try grab a new cluster and override local cluster.
> >                          */
> >                         local_lock(&percpu_swap_cluster.lock);
> > -                       offset = cluster_alloc_swap_entry(si, NULL);
> > +                       pcp_si = this_cpu_read(percpu_swap_cluster.si[0]);
> > +                       pcp_offset = this_cpu_read(percpu_swap_cluster.offset[0]);
> > +                       if (pcp_si == si && pcp_offset) {
> > +                               ci = swap_cluster_lock(si, pcp_offset);
> > +                               if (cluster_is_usable(ci, 0))
> > +                                       offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
> > +                               else
> > +                                       swap_cluster_unlock(ci);
> > +                       }
> > +                       if (!offset)
> 
> I assume you mean SWAP_ENTRY_INVALID? Would that be more readable?

Yes, it's very common in swapfile.c to check !offset since
SWAP_ENTRY_INVALID is zero. But I agree checking SWAP_ENTRY_INVALID
is more readable and maintainable, I'll change to SWAP_ENTRY_INVALID,
also use this macro more in further codes.

Thanks!

