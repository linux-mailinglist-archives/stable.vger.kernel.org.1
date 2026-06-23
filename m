Return-Path: <stable+bounces-268033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FGEYENvyOmqnMggAu9opvQ
	(envelope-from <stable+bounces-268033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 22:55:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CD96BA28B
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 22:55:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=NsPpU1cH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268033-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-268033-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADC4D3006D7E
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 20:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180003ACA7E;
	Tue, 23 Jun 2026 20:55:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82DF3ACA74
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 20:55:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782248148; cv=none; b=rNnpWnhcMbJEA26Q8UbmLvxItcljgUPNi7iK7kfVLFmRObBHbtHg/bKNuCLb3WzcKkr/PHh9xKLG8CkdR9l1tDAe8c4nuMQFYYntxg1Rja7iAAYTbSUWf/mm3zHAiQgLX+s35HbF6e7NVWsVPoNig7IB4qofD0LZMZ3Fi7uliKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782248148; c=relaxed/simple;
	bh=G82PIGobVIM5hrjzCuF1CpVGWo8L2z/ATglE9QG7wqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hx8SRGFAUlc3RQ0bFZCTcUTLUwvOMpP74MqOR3q0kfWAFDdETFc47EZVEB8zqrcPWJkJj3nKKhaFYGfixKvX5EP1I+Cl7Iq8Mjh3l7qJ2YZqUOnyvg+P1yFmHpCqlh5jHjbF+dv8YfN6o6T/EE+ymVFjozZxV0Nk0EyxDpPft34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NsPpU1cH; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c6a4eccab1so4355ad.1
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 13:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782248147; x=1782852947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tDNBIwJuw+D53Ki5EAv9tDfTFhNZX4Fj7K/EJveLoSA=;
        b=NsPpU1cH2Q/1+1ZJHqJO2QcG6Dx8bwCZtj+It7X1yp4Ft0Kuo8ggVrirWWMttxWb6S
         Qe5BuVi8ZkFsbIqWKTNHaCp7e2YoYmHFAFWrNkqY15LQaOrBJ78eTBz5ok43UDKY5F2p
         yK51VcNFImvkoFgdVRLRAb5VvpWi7auGxe0vQ2VnLeV6qys7O3hgTbMYq7h2FqmgFGv6
         OaquTPN+F4kcy8uOfI8FlTT83SQ5tOi9U/1+c4i8Bc0G80+seSX1F4OTo22ZreqR61DZ
         kPj13j+KY9/YhH1sup5cAkKoLpZC6Iq/jkCuUgRaxV9eQvYaW0x6bvwh4XSqr12wfvDq
         UcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782248147; x=1782852947;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDNBIwJuw+D53Ki5EAv9tDfTFhNZX4Fj7K/EJveLoSA=;
        b=kM+BHDgVwaLQwUrc3jNSstQ5Dcq4fPa1+GwlRO6SYM40I97ufia3SursqQvnrplptW
         K61qbio+Gf1Fbcy7MR4a1I8hLqjJHano4mbl/gln1mYyheDfaUKbmIdjMgf8VFbkInga
         +RZRIOZ/rTu+5yq97Ib7sIbLr5nJxEcNoi6Fs0JPOWNaDnlyRlXLsNb7JNqb7vXjnDoH
         lfNPqj8KqsfUU/GNkj08OgM5WOCphAiBOHcNrahwSC3fob8vpTAeKd9GO7QlKFnvxkuu
         LXa3H1I4CZFqubDqfvEGhN+iARv4aZ/fB+kaLyW5g/r1eNx1ztsjog8YfgshQNKjDXKE
         Du0g==
X-Forwarded-Encrypted: i=1; AHgh+RqAyswEDt1jRJ50CPBkgehMdfk3RbK8qaG7Agn1mhThYwgms7N/slYos/aISh4qOP33XB1+/IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO54OrOOFspaCnoKnbKxEyjcS8bE6/uGuM/SkG1hSzSKrn43AC
	IcS/hlMzlIWvgT4JSihjtY8Op0gcSzVm/38k7pWJQQzfDstR9e1/Q8BbiriR768sFA==
X-Gm-Gg: AfdE7clUGIZBCnHyGOU/fJh3piPr4bgsZ+PAeNFjskef1Xl93wCs5pAMEaHdERAib5u
	5ZvwRHW7bLYNm5Z+aebf+KfBZttuueBkWAVE8F/yAZHOhZHut6NUhWUQElDX7pvR6nusHMt6sa3
	UOo5VUFsfDfoynP0gpjXTm0KXbcs0hdH3PBXiQpB+kIbcRRSghVFneDoeZMYJz4QrfDDawQ+pQO
	R4ipMe1rA9uX7c0kJxey/90G9eBACEUq/iBRRf21GITpbQioC8MzXcW7HavCU9V1cMihAAPOMuL
	Shda3A9XRLyx9JGNujumvusP8JlCVRGk40qyt71G4VXW8tK8knRRma1q8xMxMA3k1+lbKhoQyyz
	Htklb05SaSvI0wrMw8V0rzY5CoHk+Ai5NRrmy6E83yLS3tQyudGsNRR8ekt06W5FUpbGaoPWLcA
	QNrwy/8QjAO542HlhOCmjijLfqKLqefesH9YDmL+n6hfgoHv5kCg==
X-Received: by 2002:a17:902:f689:b0:2bf:3741:5b76 with SMTP id d9443c01a7336-2c7e26b7724mr203255ad.3.1782248140960;
        Tue, 23 Jun 2026 13:55:40 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40d1b0fsm54433b3a.28.2026.06.23.13.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:55:40 -0700 (PDT)
Date: Tue, 23 Jun 2026 20:55:32 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: David Hu <xuehaohu@google.com>, Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	jmoroni@google.com, kpberry@google.com, chriscli@google.com,
	sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
Message-ID: <ajryxMaT5evDUxaq@google.com>
References: <20260621222130.1667453-1-xuehaohu@google.com>
 <20260623015459.1153884-1-xuehaohu@google.com>
 <20260623094446.4a8fc2ed@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623094446.4a8fc2ed@pumpkin>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268033-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[praan@google.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:xuehaohu@google.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:jgg@ziepe.ca,m:nicolinc@nvidia.com,m:leon@kernel.org,m:kevin.tian@intel.com,m:ankita@nvidia.com,m:alex@shazbot.org,m:linux-media@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linaro-mm-sig@lists.linaro.org,m:linux-kernel@vger.kernel.org,m:iommu@lists.linux.dev,m:jmoroni@google.com,m:kpberry@google.com,m:chriscli@google.com,m:sashiko-bot@kernel.org,m:stable@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,vger.kernel.org:from_smtp,widen.net:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33CD96BA28B

On Tue, Jun 23, 2026 at 09:44:46AM +0100, David Laight wrote:

Hi David,

> On Tue, 23 Jun 2026 01:54:59 +0000
> David Hu <xuehaohu@google.com> wrote:
> 
> > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> > first entry, resulting in non-page-aligned DMA addresses for all
> > subsequent entries.
> 
> There is a separate issue of whether this code is even needed at all.
> Where can transfers over 2G (never mind 4G) actually come from.
> 
> The read, write and similar system calls limit transfers to INT_MAX
> (even on 64bit) and a lot of driver code will need fixing it longer
> lengths are allowed though.
> io_uring better enforce the same limits.
> So the transfers can come directly from userspace.
> 
> Not only that but you also need a single physically contiguous buffer.
> Good luck allocating that!
> 
> Now maybe there are some peer-to-peer places where the large buffer
> is device memory, but they will be unusual and probably need
> special treatment anyway.
> 

I agree that traditional VFS read/write face the MAX_RW_COUNT limit 
(~2GB), and io_uring has its limits, but I'm a little confused by the
push to enforce these limits here in the SGL code?

File I/O seems to be only one side of the picture. In my view, this fix
is necessary and certainly has a use-case:

For example, the RDMA subsystem has the capability to import dmabufs [1],
which gives rise to use cases for dmabuf beyond standard file ops 
(via VFS/io_uring). 

In these scenarios, GPU HBM can be exported as dmabufs. With recent GPUs,
HBM capacity can be in the order of hundreds of GBs [2]. RDMA can employ
infrastructure like the vfio-dmabuf-exporter [3] or similar dmabuf 
exporters to frequently move huge blocks of data via P2PDMA.

If we restrict incoming dmabuf transfers to fit within VFS-centric 
limits (2GB), we impose unnecessary overhead on the RDMA stack, forcing
it to manage a significantly higher number of memory registrations. By 
cleanly splitting these massive contiguous device buffers into 
page-aligned SGL entries, we directly improve the efficiency of P2P 
transfers and memory registration.

Since this change doesn't seem to have a negative impact on standard file
I/O or break existing VFS constraints, I'm curious why we shouldn't 
support splitting these >4GB P2P transfers? Am I missing something?

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.1.1/source/drivers/infiniband/core/umem_dmabuf.c#L174 
[2] https://nvdam.widen.net/s/fdvdqvfvj2/hopper-h200-nvl-product-brief (Table 2-2)
[3] https://elixir.bootlin.com/linux/v7.1.1/source/drivers/vfio/pci/vfio_pci_dmabuf.c#L297

