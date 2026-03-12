Return-Path: <stable+bounces-224862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JzSHeHCsmmvPAAAu9opvQ
	(envelope-from <stable+bounces-224862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 14:42:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E98D5272CAF
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 14:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07407318FDF8
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AF13C2794;
	Thu, 12 Mar 2026 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="X899G301"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2DD3B776A
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322829; cv=none; b=dctF7DHE7/RqHbuJeP/E+pRcLhje99DbFwGM50JYMWf9D5T1ugPIOAj49DgtPf6rDYznQHE/vakwNHbrwhWMPo0eAvrfSr62Ym3KvNrt0UXFH/zwshVB8R5e7N9yS9rxWrc78xruqgckwCBHtCNUS8FVe8Zc4tMUDdTc+uUyxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322829; c=relaxed/simple;
	bh=rAsG53T7VzeVL8MPN/j4EPmItrg7aAE61kEiWgrhL/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu2WXfn3+wUItKfj2BPKKFHW9CADB51jmFruH+Gwdh4qL+MMtCqs9ktvBDeDX2MehVTtXIG80xok4pIIbFsGKww6JWqYD1c2dantRYBZCPi1nnxaVu2RPsHvuTDMEh0ZG7iUeYEw+CJGl8aSzX5Q8qK6j/J0/YjX5YQEwVyeYdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=X899G301; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-89a0ece9f14so11927766d6.3
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773322827; x=1773927627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WYBFQ99Inco1AF/xc7g0EJHr1Nl8OM4ewTd8eM5kz8A=;
        b=X899G301L0wDKc7JaG+sR67CjJIRM4FkdzbEfi0+4Rq79t7Ld/vGoOoaMI0K9nGj1E
         PVz25daU36xXdkPxa+So+zkv2Bnw4RqoFWI8Dyvpqq/6GiFIlDzY8QGyI2NfL1icGeOK
         sDxks6d6ZvrXhcRlJ1zxGBaNkrDqs/M+qmDVTl5BC8FKD3TPvBJgCZOQNN4XCTp2jl56
         jaLwVxX+nkQ+QAoJi99VQRHV/mT4gQ45X0gNB7MXtk9EdFIbTQSs0OIxVNZx0RshuxKs
         e2rQcSiUw5O4RCv5ewlVAvcRpnK0X7g99tIpi3HiexJ2ApMaF1aVv5uWeMG9rQbRxGIa
         Jj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773322827; x=1773927627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYBFQ99Inco1AF/xc7g0EJHr1Nl8OM4ewTd8eM5kz8A=;
        b=RoRdIU2fNt7bG+bTFxB1OXdFKwmapEwnUZ+h0FsZK385G3iBsShbt0aEXlDgOnRXF1
         O7NSpjbFbfX2FB0UUJGshL7AsTtYrPdu7C6AsS9WBIaA3eL/S+nqIG/EDuNVv0HTW3aI
         7x1UEuwGJbb0erSiLCLjpDKyt0l44R+Edo1p592uADjjkRDjvPegXh3DaA8MbLwfhXaL
         iKEaTLVRCTs0s9Hk08Yuwj+/ghLakokhdBTu78aLHv8gVZD2BJU5deV2NCTL2Qlzw8oA
         PUom/1ETlXddbfY0gXHoNOe9dCbItrvk7qawp50+XpcWlq3hIbMbw1VCeeBxD8hG7g8i
         WGaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXemMKdP7lhyDRVX/5ck7bzbQTGICcsiIPTk0QTIntfxrFcdNUPnAeZybLdTFrP0LrKzsD5g0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfMnzFcicKgG0uxS9lJnhoOXNuNe8bVKRll8NpMoavunVxJqpg
	DyhgLUES0yEjUAhQLVUVJ0/KEp94Th+oEBWdXMs/RjBdI0W8DVAvAAV6MTPOb47NdxA=
X-Gm-Gg: ATEYQzyaOAqpZC82o2DDVyg+sRD0Vby6Iz/g6xlQ8tzBWLFvGfHUDQJDTuhZjpD8VPD
	M1iCLv6X4F2ajoh0xDDInVp92ybvpw1uH+TSI+cU9KeZ6mluFG/FDunYjZwYD/9Fk25RsxEZ9fJ
	cz6s1ZaAt5/c7KZGZanaNYUs/UXv8j0UfLhZNErLvt1FcfBqledBviMKOM95EEPFqK30JJ2wQWA
	hNynk1lBYtl7NAOBOcS3//bcmhFjVdG47EegYLY0JwTi+XDOa5OuiE/+HoUK5mn+W7qwcYD/3As
	H9UGDfPbkc6VPdml7mcU2BxQxn6b7M4dlzUlVhksBAQSx8Klsfch4XnrBhVO+Id3fDwpRX83ytj
	3zEpNsPnTx5fyVHRoKlWIyCh1oslB3mUicxOkK75qmHEIjmlaZYVt5Pd+Wfos3tuuuDkALdIk7J
	USYMRlNWv54PgPASGIkSpRFCZj3bDsSkY4r1rh1iS+ik4d1y6zMEU4dXu4SJjYqUiWrONyI8oMA
	8TnqVd9B2O5Z/DFoD4=
X-Received: by 2002:a05:6214:258a:b0:899:f741:5aea with SMTP id 6a1803df08f44-89a669c0189mr90996506d6.8.1773322826949;
        Thu, 12 Mar 2026 06:40:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65bed85bsm34252386d6.17.2026.03.12.06.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:40:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0gH3-00000006fil-1PUY;
	Thu, 12 Mar 2026 10:40:25 -0300
Date: Thu, 12 Mar 2026 10:40:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Josef Bacik <josef@toxicpanda.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] amd/iommu: do not split domain flushes when flushing the
 entire range
Message-ID: <20260312134025.GJ1469476@ziepe.ca>
References: <ad8652c5e9f8aeee05e2103f4987589cdd4a3fd0.1772659768.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad8652c5e9f8aeee05e2103f4987589cdd4a3fd0.1772659768.git.josef@toxicpanda.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224862-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Queue-Id: E98D5272CAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 04, 2026 at 04:30:03PM -0500, Josef Bacik wrote:
> We are hitting the following soft lockup in production on v6.6 and
> v6.12, but the bug exists in all versions
> 
> watchdog: BUG: soft lockup - CPU#24 stuck for 31s! [tokio-runtime-w:1274919]
> CPU: 24 PID: 1274919 Comm: tokio-runtime-w Not tainted 6.6.105+ #1
> Hardware name: Google Google Compute Engine/Google Comput Engine, BIOS Google 10/25/2025
> RIP: 0010:__raw_spin_unlock_irqrestore+0x21/0x30
> Call Trace:
>  <TASK>
>  amd_iommu_attach_device+0x69/0x450
>  __iommu_device_set_domain+0x7b/0x190
>  __iommu_group_set_core_domain+0x61/0xd0
>  iommu_detatch_group+0x27/0x40
>  vfio_iommu_type1_detach_group+0x157/0x780 [vfio_iommu_type1]
>  vfio_group_detach_container+0x59/0x160 [vfio]
>  vfio_group_fops_release+0x4d/0x90 [vfio]
>  __fput+0x95/0x2a0
>  task_work_run+0x93/0xc0
>  do_exit+0x321/0x950
>  do_group_exit+0x7f/0xa0
>  get_signal_0x77d/0x780
>  </TASK>
> 
> This occurs because we're a VM and we're splitting up the size
> CMD_INV_IOMMU_ALL_PAGES_ADDRESS we get from
> amd_iommu_domain_flush_tlb_pde() into a bunch of smaller flushes. 

This function doesn't exist in the upstream kernel anymore, and the
new code doesn't generate CMD_INV_IOMMU_ALL_PAGES_ADDRESS flushes at
all, AFAIK.

Your patch makes sense, but it needs to go to stable only somehow.

Jason

