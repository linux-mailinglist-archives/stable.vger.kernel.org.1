Return-Path: <stable+bounces-214381-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCtKD+cIhGnhxAMAu9opvQ
	(envelope-from <stable+bounces-214381-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 04:05:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D22EE308
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 04:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 509243016516
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 03:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1040E189BB6;
	Thu,  5 Feb 2026 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REEeA3yr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113D23A562
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 03:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770260664; cv=none; b=GQNaVILcP9Z3dXQSdgpY5eNHYg6cPdrvUvC8+PidaP22aTimAb8PXt3iAJgPe1lipf+H5RSa5wZt18ooUo/UNm1dUtJUNJvetIPxmXUfjkr3gHr6hTwv/kiV5WYDsC2eI7OpE8OSjdpq4H902GKXUtXjtqjDznPxLS6iiEYBa78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770260664; c=relaxed/simple;
	bh=sR6r1mqhrvRwHH1sGDewU608fo8IXKukybhGbNSunrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5b3oeMpIRIQByRIBWG5FtbM0nFgPsac5eeTScJZYW9k/vkinxeieLkup5+GNCfLrJajwHQjNZZWpNhMv9PlO6DklHjnVfyz5sMkk2FAWBlnQkTbxmeWh1W5/hxLqB7l/mQguuiIDtWIx6drihCbWjHjk2t3/GrE4b+kei7/J3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REEeA3yr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-480142406b3so3291095e9.1
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 19:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770260663; x=1770865463; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fo9LPvZFNEthcZXdHyGBx02jqzq0dJGk/n7BbP/MU4=;
        b=REEeA3yrdyqg211Kp8M2+hmAuNBYsj/RoocnSv1EOxDBNZL3uYjNkZI2bBrQNCC6lm
         LIjbire+AM9yPdcKpYsQ53bRKJEz/NowrtcaR4h41IK4axDR/pLEGXSYUAZG0jYr9k6C
         QZjgRyqySHrg8Ea9J9K4BY4rUXDLPxKJSan3IAGI3Jt5On8y5rhiSwg8gcSLh4oJtYla
         gfOiFaOGRQAo6rwKdcSJ1o1MLbsAS43rm6hmCsca4IgudU9fZXl4A0Ima/ngxwvcG5iB
         w4d08iGgnbwAuCIzWxJIqJS8pIRlbLoSZFBgQphWKJ5TVE4EONq05YWNbihR5TpUA1ZE
         reQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770260663; x=1770865463;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fo9LPvZFNEthcZXdHyGBx02jqzq0dJGk/n7BbP/MU4=;
        b=iXQJFfkDwNIfrHpCGmrk7n38vW6tjioMzUy8L8FfwPmXvN7o11QHHI4UheoqASKgZk
         E2Hx1FQPDhd+OmDfMZpfByegZ+BogrBDdCPC/DJXD8ZYvs0kvUgxgRkyQYdUq6Q+8xno
         TQNoV6KKcHS0O5t8Pp2JSNDfJxQTU60gy7vbunXB8wu8L1WoWYDpKuYf7f1BFafDQ2/F
         8MSXRx8AqksImAgfTzQufBRtAxX3vy963DjagI6CZvla715dQPhkjFsLvxvRL9iYEuJC
         FjAwKtW6tVTHLF+lFXYBnc1eMS2ojVzUDCxQ98jV7gdUqAN6DafSVohtvA1XAkmcpycB
         L86w==
X-Forwarded-Encrypted: i=1; AJvYcCUqDggVl3JZ4xqsUq6KnrWgMhKnlb+REyiIUkOy6PojaJjkW7MKJQdZNCv+3URNMf1JFZInh34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYFA6lzIZDmLGlZOlVs/uz9G4cbo1hEPgPkbEr1NWUdgJJh1oX
	8czJ381UFTtqiC7WBD/BGzFb5KBePhZ0UM8jhr/Ja5/uNqYUN2pnJk4p
X-Gm-Gg: AZuq6aLfqlAD7tiOcFkaTquCf8OzW/DDff/nes6RtHVKxJEvGf3driPgNI2rGGGv3E0
	52/73ZzM/XU24S7F0FeM/EmcdYEiZrS6ieX06bt0Q1F2N9d7YNdh9vZLMEtdU+MmuPEXNxQXJ2q
	Ya75M4g/45TV6NTIWrOEeZwgh/09wr/+7hJxIvz/zyUjagTRYUWpZXvbdh7GZvTFM9L5zKmLtmV
	Az4VNu6uOVJUO6ylkNHzaAgTlH8V3kuaGspFMaei7brkU3r1ePqRplnxQMrvFffHfmqdnSynJYN
	jwpPzK4WYndf3R9SAEgSNk55IcnNvuGN9QDNDRqGUpNYgdY/l8xQmGOmwxML+9kuiTyhZHAvUQ5
	yrxQfEdpFPkMFU0azC+9qFMDZrb3NSrCE9TQlvNORZhukmT075+K9ci625Qq/+1MMuai+5S5fo4
	GIF80qhAkRmA==
X-Received: by 2002:a05:600c:4fcc:b0:480:1d0b:2d15 with SMTP id 5b1f17b1804b1-4830e9926c0mr73610275e9.27.1770260662635;
        Wed, 04 Feb 2026 19:04:22 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d4b2a6sm21300975e9.12.2026.02.04.19.04.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Feb 2026 19:04:22 -0800 (PST)
Date: Thu, 5 Feb 2026 03:04:21 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, david@kernel.org,
	lorenzo.stoakes@oracle.com, riel@surriel.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
	jannh@google.com, ziy@nvidia.com, gavinguo@igalia.com,
	baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	Lance Yang <lance.yang@linux.dev>, stable@vger.kernel.org
Subject: Re: [Patch v2] mm/huge_memory: fix early failure try_to_migrate()
 when split huge pmd for shared thp
Message-ID: <20260205030421.zz72iie5bwvgxlsj@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260204004219.6524-1-richard.weiyang@gmail.com>
 <20260204114217.6da3e05ee5fbfac3a5f4c16a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204114217.6da3e05ee5fbfac3a5f4c16a@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-214381-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,igalia.com:email];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,oracle.com,surriel.com,suse.cz,google.com,nvidia.com,igalia.com,linux.alibaba.com,kvack.org,linux.dev,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.958];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 95D22EE308
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 11:42:17AM -0800, Andrew Morton wrote:
>On Wed,  4 Feb 2026 00:42:19 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and
>> split_huge_pmd_locked()") return false unconditionally after
>> split_huge_pmd_locked() which may fail early during try_to_migrate() for
>> shared thp. This will lead to unexpected folio split failure.
>> 
>> One way to reproduce:
>> 
>>     Create an anonymous thp range and fork 512 children, so we have a
>>     thp shared mapped in 513 processes. Then trigger folio split with
>>     /sys/kernel/debug/split_huge_pages debugfs to split the thp folio to
>>     order 0.
>> 
>> Without the above commit, we can successfully split to order 0.
>> With the above commit, the folio is still a large folio.
>> 
>> The reason is the above commit return false after split pmd
>> unconditionally in the first process and break try_to_migrate().
>> 
>> The tricky thing in above reproduce method is current debugfs interface
>> leverage function split_huge_pages_pid(), which will iterate the whole
>> pmd range and do folio split on each base page address. This means it
>> will try 512 times, and each time split one pmd from pmd mapped to pte
>> mapped thp. If there are less than 512 shared mapped process,
>> the folio is still split successfully at last. But in real world, we
>> usually try it for once.
>> 
>> This patch fixes this by restart page_vma_mapped_walk() after
>> split_huge_pmd_locked(). Because split_huge_pmd_locked() may fall back to
>> (freeze = false) if folio_try_share_anon_rmap_pmd() fails and the PMD is
>> just split instead of split to migration entry. Restart
>> page_vma_mapped_walk() and let try_to_migrate_one() try on each PTE
>> again and fail try_to_migrate() early if it fails.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
>
>Cool, thanks.
>
>> Cc: Gavin Guo <gavinguo@igalia.com>
>> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Lance Yang <lance.yang@linux.dev>
>> Cc: <stable@vger.kernel.org>
>
>Why cc:stable?  In other words, what is the userspace-visible runtime
>effect of this bug?

On memory pressure or failure, we would try to split folio to reclaim or limit
bad memory. If failed to split it, we will leave some memory unusable.

I would put this in change log, if it looks good to you.

As David mentioned some change in comment and change log, do you prefer a v3?

-- 
Wei Yang
Help you, Help me

