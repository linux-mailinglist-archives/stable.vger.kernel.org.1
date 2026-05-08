Return-Path: <stable+bounces-244784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBcQIhn//WkTlwAAu9opvQ
	(envelope-from <stable+bounces-244784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 17:19:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCE04F898A
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 17:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 648CA30429BB
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653EC3FBED8;
	Fri,  8 May 2026 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FfqN3Fgt"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847F33FBEDF
	for <stable@vger.kernel.org>; Fri,  8 May 2026 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778253548; cv=none; b=HYBiHpGvNqO/jOr1vV0/EmByyv7MDxxpEEbsJLLtVRNchNeqN2p9uF+1DTYBnGbwNusuv57OCNMmL1PzhzWIDTSYg+jZW/wN6t6YAAp+ohgywECLPY81x+hXsypRCxEfPAkjfkLhnQ3hNPmU8Ez8x0oASCtqqMsjmPa5d/jTFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778253548; c=relaxed/simple;
	bh=LON1iquaiFHI7bg0xydIs2bUhPqLAJ5Vqe7yyQhb+/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiVag74ymq+41M4ZOYdRLKaZL7EPZRxyduc39cMp+NyJpOlz31X47uFRJMNmcSVAflO+e54Dscf1ZPk5b0TWaOS+AiPdBa6ddCIzyAJswujM5nawTWtVm9pmpKvYlMz+e/yqMk4EjuvhmPm8WrMibXpCpFjfmZOetT15BjcqDeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FfqN3Fgt; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8eb5ad01402so209877685a.2
        for <stable@vger.kernel.org>; Fri, 08 May 2026 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778253544; x=1778858344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTG/PpueXCgEiXRYtBi+EBDI0e9SJXMCHTk8qLEhxGk=;
        b=FfqN3Fgt+LqhbuvOqCvZscZLVYpAQ3yglTDZ+icbkwA5OIDAf4m/iuezVsrsLCBjoP
         12CnYAY1O5SIid3KqJxLJgn9eTz/6iUMIjxw4WMjkt3p/QfMZ8lRfmvrmZAYWjpooJJ0
         lnlgmNVpz/QSPYh9tw41Jma+V7oWU63eG1hW34p+5A1rkxLwcs8sWj9dRczmgbwwdz49
         tPccun5WG+nFykqVjc6oXiytSeNhmsaIZyEsFrrrwPDxlkG33QwTwYN2YuJS/Zvpfirc
         aVfz31fD4CLI9OVFR5jtgS0vLpsaXYKOx9ihP2DGVX/dfEBG54Jiq7vY6wYb7/BJWAjY
         VBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778253544; x=1778858344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTG/PpueXCgEiXRYtBi+EBDI0e9SJXMCHTk8qLEhxGk=;
        b=PTAaMF6OCmnqTOt55O4ijRhNx1XiGeeMMbY/sGVbCSiQwRPBSWcIvT3Nh5lF3zEjg4
         Jh4yTULFsHiU0lUdhJzPgbGmfG9/JkgKAxhzpdU2q4CgNXEDlcCJvUKw+c+pT2q0Q/AF
         633Od8qYteMnjaMsCl4PMhgcnL2PGt5GqGbjb9Ussv6wP77STI/nli1JNBDn7821IpUR
         LquAxhVI1w+ULHRSL0hecM83TabiDEIdZQk8vKUvTaShABtSvMoEkbzoUhbA/pnIRoDK
         HWRWQbaMCRRZsafYRHkMua45hKcC1ve8G8bOe156WmJi7fyUUhCxsKjJujlBJCnXBPeL
         l4iA==
X-Forwarded-Encrypted: i=1; AFNElJ/w9kom8VTgCwLqtKjqI0m9VBlCkBwvqFtbrBDOG1Ga+IORuwEGG+1ijaCYztVmW5q/IUR2v+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaM/ZLH6x+jhtHjKWMSR2iRp0okdq5kCcy52NeMG120S2zNMTw
	lg7rQ/FHpY9a5VNdPKhp83yMPrGELqpNzSp8ACXE6BvQyyOY4Z/SH+F1wu4XFo7jUyM=
X-Gm-Gg: AeBDievJnNPOhW4QXWYkyS+K8hfOXQNJbscWsEQG85Z8FZd2p1aDTiLnuK/qu/xBSUX
	tSw1fNrscvjbwamZ+2RA2gxhsUMHnLZF4C5rni2ktVSUudhPQlWgS5dNVMWww7ylPBB0VK4rSrI
	1x79dku+abwrldPlUArfFO/YAy/2yL0DUGP9IVPN1jMjWfSb4WVChjtaLR8cigqRb8KD84g7BqX
	K6fPHqs287/La1LSA5rexk0GZauc01GBKFvYnSBzfUZ3RYYgexVx9+icfu0P7IHAVhmxSOwUBXO
	gJnrc8PZX/XAxywqBmKBiCx9yMsaXDl/cnPgQKvk004aIEBrQAlgItsBg6G9S1YntiTdYpVCDep
	bL/yOSXP1feMwZKVRMa0JOrirncnYsvlr7aftkgrNKpzCWJ1k7I+Ee+yBms6rgS0/pDcsxjE3IY
	5aTK2O3Un9/+U1qYtbDjjHXLEiqWEBtyRjyelSCYmoqXFP/sOv1Y2LNjkptmdEkFroutvyhu+D+
	FOHCA==
X-Received: by 2002:a05:620a:7017:b0:8cf:d6f8:599f with SMTP id af79cd13be357-904d6fcd75bmr1893999785a.57.1778253539091;
        Fri, 08 May 2026 08:18:59 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91dd48sm2251446985a.38.2026.05.08.08.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:18:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wLMyf-00000000Afi-40Nx;
	Fri, 08 May 2026 12:18:57 -0300
Date: Fri, 8 May 2026 12:18:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jianpeng Chang <jianpeng.chang.cn@windriver.com>,
	m.szyprowski@samsung.com, leon@kernel.org, kbusch@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: remove bogus test for pfn_valid from
 dma_map_resource
Message-ID: <20260508151857.GB9285@ziepe.ca>
References: <20260507032120.4072283-1-jianpeng.chang.cn@windriver.com>
 <2dcc29d6-a4a9-4fdf-861d-312941ab0f07@arm.com>
 <89094011-fe78-40f9-9695-d50ee19167c5@windriver.com>
 <20260508113100.GA9285@ziepe.ca>
 <662fdf07-6475-4807-94b0-54b3b439ae1c@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662fdf07-6475-4807-94b0-54b3b439ae1c@arm.com>
X-Rspamd-Queue-Id: 3FCE04F898A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-244784-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 01:16:25PM +0100, Robin Murphy wrote:
> On 2026-05-08 12:31 pm, Jason Gunthorpe wrote:
> > On Fri, May 08, 2026 at 06:01:01PM +0800, Jianpeng Chang wrote:
> > > > As I said last time, I think pfn_valid() && !PageReserved(pfn_to_page())
> > > > would be enough for what we want here, although now it's strictly under
> > > > CONFIG_DMA_API_DEBUG, perhaps the overhead of memblock_is_map_memory()
> > > > might be less of an issue. Either way though, now that it's all
> > > > channelled through the single dma_map_phys() path, it would probably
> > > > make sense to consolidate any MMIO sanity-checking into
> > > > dma_debug_map_phys() anyway :/
> > 
> > > Thanks for the suggestion. Move the check into debug_dma_map_phys() is
> > > indeed better, and I will replace pfn_valid() with pfn_valid() &&
> > > !PageReserved() as you suggested.
> > 
> > I'm not sure that is right. IIRC pfn_valid() is true for ZONE_DEVICE
> > P2P pages that are used with map_phys but never with map_resource.
> > 
> > PageReserved isn't enough to fix it.
> 
> It fixes the false-positive on non-reserved pages, which is the important
> thing. Yes, we'll get false-negatives on reserved ZONE_DEVICE pages and
> similar, but that's still an improvement over getting false-negatives on
> _everything_ by not checking at all. Realistically, dma-debug can never be
> exhaustive and 100% accurate, but there's still value in catching as much
> obvious misuse as is straightforward to do.

I'm saying I think the new expression still has a false positive for
the common case of map_phys with ZONE_DEVICE P2P, and I don't want to
see debugging logging for normal as-designed scenarios in map_phys.

So we either need to narrow the expression further somehow, or leave
it in map_resource which has fewer users and doesn't accept
ZONE_DEVICE anyhow.

Jason

