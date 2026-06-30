Return-Path: <stable+bounces-270046-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CJ75ItMtRGpWqAoAu9opvQ
	(envelope-from <stable+bounces-270046-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 22:57:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AA26E7F5E
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 22:57:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=UwaKNwoT;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270046-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270046-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFBA83037171
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 20:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5738647B431;
	Tue, 30 Jun 2026 20:57:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B972944B693
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 20:57:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853071; cv=none; b=ZbHJB/QETUlQW625WFRVT4hvaGKSMm2SUEolAYxcQb8s7pARBL191P6oDQYFOkDHkig9Fz7+orJAmyAononkCl16QCA5FY6xLCOXAIz3Jy/vDtJnxc3D76LqUuVtiHs43tWW34ofZkk9OqKCO4+xfaymyuG04pQIYzKgR+CLJpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853071; c=relaxed/simple;
	bh=tki8VYOorrL7Vh2P/GhEe6UqvDv1psdAe9UhD9ggn0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKktuyBvzcJIw7G1xSdV8w+e0WUp+vGyv+0E44uk6OaCGKLM75+NHoCB+sw3BlPB4KTbO4+Jp0uzRVkajv3bB+N1cWGF1e/0FiaZnwqB8VB5NON2/G0qxFIgkuJuZWS8VFscxOCFHFTI1DBSiXgxACk0T0dz1cq3E5SGQZWe7v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UwaKNwoT; arc=none smtp.client-ip=209.85.222.181
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e51d3d83cso205347485a.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 13:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782853069; x=1783457869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P+IJodXzk6nIKTwEHgsn4EfzwEPSclnTV/6cyemr0hQ=;
        b=UwaKNwoTNQ4yh1q4/sOwnEh8nbMAnQuRNK5UaNzfkulZ+TQWZRtoYR6IbpzBkxVl1Y
         R8xaphWVkot1fA01WHVK1RYNVip1jzzLv73dwVgWQwu5zyHgYTG/7ySxc4l3V8dS+IGq
         e1mLfvmX2JGyxlzmzLMnqv2LkO9MGUlwoHW1Fa5IL/Yl+74j2bFipkwcrw5rL8Q4rJYk
         gtLaW0HEQXgjpUkO+3AXrefKDeJH6AoF9ScZ8HBH40Lv2ZWETLLxO/Cux6oPs9ZDR5xI
         hqhQM1UDvWNBbl3cuJALJd3dCxmtTXdPAbDzV5Ijy6Jh9BVFsu3MQ239zlePeozDpxp0
         r4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782853069; x=1783457869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+IJodXzk6nIKTwEHgsn4EfzwEPSclnTV/6cyemr0hQ=;
        b=fR22DvZAcBkD7J1BKEHv6G4AZg0u73gl+1+gnPT0qaqNXbH243PVwZzKADM2cS+C4N
         XGDgTEo1aodSLpPTMjYcedCcyMGwdS6i8W6J39Q4uXVLZaIe+lI3OBSvmB4NV4LY2Exa
         ARi40T7p/jRb4fDYBgcL+d89yTPiEY0e9Kc7tYo4L441A4ZdHcat5SU3fJU3saUK61S7
         elot4x0AG2dfJbGUqLPV246RtaNQ9dz2Q7D9+W8EaK903QhNUDm1IE6kDZOfGGf7TA1T
         3Ybnu/7igFJLl02tTANhczn+HXz6+C3sC8aQzgue6ugOHTKCrtfvk2Qv/M4quaF1+/Uf
         5YiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cw4LLuRxY+FEyWcmeu4/lBkqytlLFttyEJF0mmdpaqeOvQE2euemwryWqXwAcW8whhcFKaWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc9tG0dEMG0yxe3bOG3qIyVPflOrlterW+tvRD5sEL3loPm0I9
	ZJtDuUJxEsaqGN10DtvrcdJyYZIJS8G8dRykjRQFl4b23TRcN66RvSEwHS3DBpRcXBw=
X-Gm-Gg: AfdE7cl0N39ARjNGfqOzZ+4ueAg+dM5xDndrPzCG9ttnldudtZwmYz3bqzUAaTJE67o
	Ep/FcSY/ooLEJbqVdaSJFU/O3JvCMr2wRBs8wXxfOHg0Gr/Obttlyr0NE0mayPl3XRggcMHnzMf
	UJegqDORoEqgaCqpcBeQ0fPvQ8j5Yda74YaJ1u6h7YYG4B70OrqpbxVj4sAgJtj1eHRFeqce46U
	EVrQM2pWjaRRayN7nmM/8NcoGjED+53ijfFM03Ilc02HBI4P2rYXWYwa0qQodEm5UyRJYSsHOZJ
	aVPKqH1Mb/nHQjWsC2tDjEHueAwShRuaG6ZLBpOas7cffC5pwVfW4oH8nLiMoJBWKSfr7lPnCb5
	Sucfzw3GIV/edbguYu5crlVkXAkhCTwKYl81dCH9Jf+ctpwut2iDVganyT1BxtNpUkSUVmdUPKN
	BXsbR1f8u7KjPJcnR4dPS75PYoiMOs9176tvzQHlQj035O8JOTG90Zd8Jw3xbxreS6NG/4
X-Received: by 2002:a05:620a:40d3:b0:92e:4a4a:4478 with SMTP id af79cd13be357-92e6d840616mr373996485a.31.1782853068602;
        Tue, 30 Jun 2026 13:57:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e622e7473sm348604085a.25.2026.06.30.13.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:57:48 -0700 (PDT)
Date: Tue, 30 Jun 2026 16:57:43 -0400
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rppt@kernel.org, vbabka@kernel.org, mgorman@techsingularity.net,
	hannes@cmpxchg.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/vmstat: fold stranded per-cpu node stats when a
 node comes online
Message-ID: <akQtx7zhP7pxNCiy@gourry-fedora-PF4VCD3F>
References: <20260627202243.758289-1-gourry@gourry.net>
 <20260627161007.81e4533ce561c2951a69f927@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627161007.81e4533ce561c2951a69f927@linux-foundation.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270046-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:rppt@kernel.org,m:vbabka@kernel.org,m:mgorman@techsingularity.net,m:hannes@cmpxchg.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gourry@gourry.net,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gourry.net:dkim,gourry.net:email,gourry.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5AA26E7F5E

On Sat, Jun 27, 2026 at 04:10:07PM -0700, Andrew Morton wrote:
> On Sat, 27 Jun 2026 16:22:43 -0400 Gregory Price <gourry@gourry.net> wrote:
> 
> > +		struct per_cpu_nodestat *p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> >  
> > -		p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> > +		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> 
> and that's a lot of items.
> 
> I guess the overall loop count won't be large enough to cause issues,
> but it's large!
> 
> Perhaps there's some simple test we can do on the per_cpu_nodestat to
> avoid the inner loop?  Perhaps might need to add a field for this?
>

I took a look, but that would involve adding another per-cpu field and
then making sure all the races on that field are respected as well.

Not sure it's worth it for such an extremely rare event.

I can try to get clever on the folding logic if you'd like, let me know.

> btw, "for(int i..." is allowed nowadays.  It'll make this code nicer, IMO.
> 

Otherwise i can send you a respin for this.

> And... Sashiko seems to have found a pre-existing issue:
> 	https://sashiko.dev/#/patchset/20260627202243.758289-1-gourry@gourry.net
> 

Incoming patch for this shortly.  Pretty trivial.

~Gregory

