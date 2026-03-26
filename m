Return-Path: <stable+bounces-230526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CixA/GOxWlG/QQAu9opvQ
	(envelope-from <stable+bounces-230526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 20:54:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9B833B286
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 20:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A50230B6A2A
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5639634E754;
	Thu, 26 Mar 2026 19:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lB1140pd"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A298F34CFDA
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554532; cv=none; b=QzDYX/au2Ux7rfeaHvsAu5LT6eWZCaHMS2yf2IIjSxqySLzeZP+2k2cLqN8ymA2x8Lbh5fd7/kVQLyP5Mjwbm/Mfrl24RT2gxrdJ01B3rtpe/XEWjp4h8l97XeLi6wGq1obIilHzf6+eXorUCZlfzV3vLczwRISSb8UtH0VH8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554532; c=relaxed/simple;
	bh=wyI53cHLh4BIgCM0ffLwIHRJXy0SO5cJeVuYYiW1xi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOhLNcJov4GuXmhZe/U8r5QXM8kji77+xyMwFVypydAl41+NbLxdqOaffhuZdRqbBM7u5SlTGqhI5BJOLjrdMzrLcFsK0wSpHkBHUCXxu1Rpptm6eODa+4twYTGnmDuUeOCPWHKo0yYQABICuDorFyYFa5zIfsuRpE83z6himFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lB1140pd; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cfbbf35354so189165785a.0
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 12:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774554529; x=1775159329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Y8SN5o1ZkvY84l2Y0g1HhDr11A0odVfZb13rFexrew=;
        b=lB1140pd9C7fcVB6f8UW1kmkie4YkVH5vVzTfkBMF4x6qSZL06WeD3xVeoD4brSiP4
         enVx0pk90r0h5reiiEu3jlt2q2ATMPre5jUEvB58hsDilQCsm6SuYz9aX1V8uRF1msxV
         2zR/yjDQVwnD2JFvM1T6megsC3IXxY3eCufUTlespF1CR2kedV+kjME/hHA+oG3GDl7M
         NMXcGXyrpj0MEbFKTxmlHxYgFgXsfW/pqEH9ds4QH1HxmpIVhtPrbNNaPP9KWoGSnkRM
         c4r5ByDYmCaFpUKw/x8THFQH9scAgx+rN/FAjlLHwxKUnie62ZLjgxSteJhlnh2sAiII
         PBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774554529; x=1775159329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Y8SN5o1ZkvY84l2Y0g1HhDr11A0odVfZb13rFexrew=;
        b=l64sYPt3ztSMvNk2X0bd/JxvUuZ+kqi6S7ZrjqG7sdfvLozXkvu32vY08Mib/bjjiV
         HKSgPYtO8uqcPxwgGNXch+sJn/rrhuy0ifbVdWXDXO5wyzyWpQ2ua5LPt6IzWyGheQC5
         MmsLA75wtEv8FZD1rZCx1Lb2w9XuWu1Gb7aEmDsG7IUMV/DmEEpbo3WGR2qbV2zOnsgW
         9R8PkV4l5QXExfqyAiA2Q9t21ltT62mjDjiXGq4+ezndaNlTiv7QvF9KPJnVPlg9pvNs
         kr0pV47bkp2KWvfj4AoJyKtMAJdfMlv8+VLP5d3AE5lyr4Xo5Itg+jvTMr9xSnb7WBBq
         QZpw==
X-Forwarded-Encrypted: i=1; AJvYcCXbpG+pMKF4RtutFaZuYh78J9QqZBFiVlWFPDElHG/kUJDWwis7c7ia1+RyS61mt/7L2TC7jzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBRbASsiyvLg3NesJ4KTH08lMp4fWApiYUAKD/x5Ibuxg8RYf
	/kj4at2gCqvkJeJuFcZwcwnewjUMncrpR/oDnWFWsDFG9dV4VlwERjt4aMbkhNgH6TM=
X-Gm-Gg: ATEYQzwG7fEwV+da3RgkgQCDB4KjmqeFJe73tjSrRo/httvTcQpSPfxPVG/069qQ0A7
	B/530ji5kk/WKQ4cyI5gdjpl2qGA0kmu3gS7Lm3qjZsUL+ta/iNyY671xqyp1g5DGb3DxwOR/Sy
	Bp7fK9at3TBZy1XmnEM3FVdOUiPR1gsF38H5Y50Z8x8u6zLWRW6A8EffDKSO6KvoZzc2WBbYA1C
	44hq1h3pPvug+VVp7XQx3TvAfS9YUJJPaYWPxtAJ/iBplyjCITMdKBf/XkqW6KekVJxzgeYQu+5
	4K6TR2mCq/ye7Bc8BbjNp5RSiAPgVIAMZ1F2rk03OGeoEJgdaZQwHY79w+2HohdaloB0l18giIZ
	XQdrVypzjYEsx0QbhXmHMw8Q7wd8H862CX5Y69261wCeANcUq+Fy8SXNWTBQu624kUNF+A8z+EQ
	EcZxBzvr3BR7aCQFuUnoeQ
X-Received: by 2002:a05:620a:46a5:b0:8b6:1877:3689 with SMTP id af79cd13be357-8d00101300amr1194245185a.35.1774554529547;
        Thu, 26 Mar 2026 12:48:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::2:e5e8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e39fbb0sm305859085a.8.2026.03.26.12.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 12:48:49 -0700 (PDT)
Date: Thu, 26 Mar 2026 14:48:47 -0500
From: Gregory Price <gourry@gourry.net>
To: Pedro Falcato <pfalcato@suse.de>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hughd@google.com,
	david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: use invalidate_lock to fix hole-punch race
Message-ID: <acWNn1sewTJhnA2f@gourry-fedora-PF4VCD3F>
References: <20260326162611.693539-1-gourry@gourry.net>
 <jm5rmcwiauy2fn6fvj6cjowiu2dudjndhhlcd2tm275ibmos5i@dwxwchbs24ko>
 <acV83cdc9ZfNk8Xh@gourry-fedora-PF4VCD3F>
 <bnukmnuxxuhdfeasjz33miemgr7w35c4aa6pqdmgupx7oxmeeb@gozgc3yxhcdd>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bnukmnuxxuhdfeasjz33miemgr7w35c4aa6pqdmgupx7oxmeeb@gozgc3yxhcdd>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230526-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C9B833B286
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 07:16:05PM +0000, Pedro Falcato wrote:
> 
> Sure, but can child - parent happen when traversing the i_mmap tree? I don't
> think so? (in mm/mmap.c)
> 	/* insert tmp into the share list, just after mpnt */
> 	vma_interval_tree_insert_after(tmp, mpnt,
> 			&mapping->i_mmap);
> 
> The function itself is somewhat straightforward - find the leftmost node at the
> right of 'prev' (our parent) and link ourselves. So an in-order traversal should
> always go parent - child. Unless there's some awful tree rotation that can
> happen and screw us in the meanwhile.
> 

hm, i think you're right, i have this inverted.

But this patch objectively fixed my issue, I no longer see this BUG(),
I don't get softlocks, and I don't get the guest corruption I was seeing
previously. It could simply be that the contention added makes the race
less likely.

Let me dig into this and just smoke test your suggestion - but I think
your patch would cause some contention issues on unmaps.

It's been difficult to generate a reproducer for this without running
hundreds of VMs, whatever race is going on here is extremely narrow.

> 
> If this is broken, then every filesystem out there using filemap_fault() and
> filemap_fault_around() has to be broken, and I hope that's not true :p
> 

Me too, but i never rule anything out.

~Gregory

