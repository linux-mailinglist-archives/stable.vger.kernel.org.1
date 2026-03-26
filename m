Return-Path: <stable+bounces-230533-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEw6HcWuxWlrAwUAu9opvQ
	(envelope-from <stable+bounces-230533-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:10:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD2233C388
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5689F304C11A
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 22:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641813368A0;
	Thu, 26 Mar 2026 22:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GZeqvDR6"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DC333509B
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774562716; cv=none; b=olwmBzK9jfZmr3RvrdSFcqafKTVRj0N7O4PDNNAFT3T3n9IbMZ6KxpMIOVYPeZjIG7QIDVBY0TMrGhHzWh4vGXm4HH1hTrd/eWkE6H3c0GWrKFEPxwhws4pEMq9D3pRrwzFHhy/FUExljk50LHxqeyV8OcdemUsTsjgtdYG4lGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774562716; c=relaxed/simple;
	bh=u684RyFUCmg8ujTk2N6tNVsPJBod1PTom9yEeQrkutU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErcmjVh3WfeDIR+auzipUoEHNtWYRJfwdTjltkXnmS4+98iFs4bXQ1xFxmxEwNN2yZdU8p0Lvx+QOGQ/IqNRe/eaBGe1GmxjgTgq0H5jQVDbjQu1YZZaVHZPNbITp4mlt253E99ZD4j20fQWPxAYZ8JGLQWNy05k4aK6cPAJ5ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GZeqvDR6; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50b713d6baeso15069111cf.2
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 15:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774562713; x=1775167513; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qt4Bouy7zFS2Ghg5Ne8+cryR/mFwEWJzdsa/JCE70NE=;
        b=GZeqvDR6Qc4E+MKIm1scFgkfl1AM6grkxsny0TaEwgdWxcDxdpgATf20Ac0z64cClX
         cM7ecqCBzBiAOn4a0yJqCms9RM1y6c+FxdeRfOj+Uf9fsQs0gsi1gATgsTgt13AJaYOu
         TAMKktvEDTxeULEz9m+TM9B4ctvLq/suYrgtYpx22f1tXsci1F0+QAAG/S8KJ/ojhuJD
         ObuCRluT7zbYnqg8henrloFcDfiREwIMoJlLAuzhSsWZdQNQCFDbMjk0L3uDSPj0FI3y
         hNSgP0vwOqQmgpsv0GcIL4QT5mFS2VCF3AZgTRsM6HoLKgn4D+mHz61htEIcfTyYhxAS
         /qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774562713; x=1775167513;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qt4Bouy7zFS2Ghg5Ne8+cryR/mFwEWJzdsa/JCE70NE=;
        b=Zd9Ky5ha6s/mobWqvPwfeU/TwdbJxUbUgk0tF8vBLJplNTh0Ge8XFtA521Nqp5PYbk
         OUm4V6hNzbkouxwM0Vt/uKrz0zkEl7cC6kGEYHOBEWhNQFhDf0QSCzt1WkrC6ZXhJzEN
         qLyNJNIsCFOxjSOvblSWZoE/kCxxfTxyLuqcMCrLmcUpLGa8rELHGHX2QbIiJlbRhnrd
         66mpzpm1N6+kWKpIPDFc36rI1RLnMy9O+8qtuU2V4jLJYLLYVpCJOWLXJG3iPHtG1jzl
         9WRXvZNMFZiu13pxMX7yNfUap1K5jzqFe2T+r4Aosss/cLbAfVO4GVbWzpVv6C/HMxfJ
         z4sQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5AvEBHuZ+SL73og0tR4IKyZe7lXYx3YZ3JiLBLDo7kdnXLeFn3HfVi1boAs9GJgtDhN0lVnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXxpa845Wr/pnpsFBut3WpLEFB8cZeUM1lnmLaWZGVUu2Bjtrb
	dizt9tS924gO1R2aKi5VAbBNnX5dj+Up3gDa/9w1XBwxiXIuBHQPSHaec0fzOGj5l1k=
X-Gm-Gg: ATEYQzxFgKoTv6+Jgm4aKZihE832Lv3mngniDYAOSbjexU58zj2faigc7L9nJjwpm+R
	5x5UCa7MPOgcEG3TgdKSqFH4+T+cdpfw7eCmYmbfs3PEhujOTUvKd9lHM658BstQGdxiE/BjqqS
	VEw/3EKGUSaKI4xGn236gi0N/B/71374mshxSRvfHNaw2whvbMqiY5jheAeELq+aDDLuWM55LRz
	VVrMMOx/rjQesG0Ln2KDv1va/Ut14TesEQncMBljtT1XnfWOLR71PpG3ebUHrf3vUPsRBmsgdr+
	i/QUZn6hrO0P25IYVhhgPJCXA7mBqys0TNgWVWytRrzVzpkIrjE3F12glkVtuL/OKENg838jSg0
	EpUQaNH6YWkIgvWPVO4o6Ax0lK3sZPrK4FV+vEC7C1xCPfJmgqvZLKA0pAXbOsHPYSjrbt298ug
	L4TDyc1UYyu0SHkwvsjQJpkUiLsb/gjH6YmhHZukhpHf5fJ7Nb62yn9Djcng9viainHsjCiA==
X-Received: by 2002:a05:622a:112:b0:509:348f:bc1a with SMTP id d75a77b69052e-50ba380a83cmr3922441cf.26.1774562713431;
        Thu, 26 Mar 2026 15:05:13 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd58d3756sm33752176d6.22.2026.03.26.15.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 15:05:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w5spE-0000000120i-0TvX;
	Thu, 26 Mar 2026 19:05:12 -0300
Date: Thu, 26 Mar 2026 19:05:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Josef Bacik <josef@toxicpanda.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] amd/iommu: do not split domain flushes when flushing the
 entire range
Message-ID: <20260326220512.GA245789@ziepe.ca>
References: <ad8652c5e9f8aeee05e2103f4987589cdd4a3fd0.1772659768.git.josef@toxicpanda.com>
 <20260312134025.GJ1469476@ziepe.ca>
 <CAEzrpqeO68eg1dFr2fm8FNXSodJWSxT_9Gk0EHSK=hzRAQgJHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzrpqeO68eg1dFr2fm8FNXSodJWSxT_9Gk0EHSK=hzRAQgJHQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230533-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CD2233C388
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 02:24:11PM -0400, Josef Bacik wrote:
> On Thu, Mar 12, 2026 at 9:40 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Mar 04, 2026 at 04:30:03PM -0500, Josef Bacik wrote:
> > > We are hitting the following soft lockup in production on v6.6 and
> > > v6.12, but the bug exists in all versions
> > >
> > > watchdog: BUG: soft lockup - CPU#24 stuck for 31s! [tokio-runtime-w:1274919]
> > > CPU: 24 PID: 1274919 Comm: tokio-runtime-w Not tainted 6.6.105+ #1
> > > Hardware name: Google Google Compute Engine/Google Comput Engine, BIOS Google 10/25/2025
> > > RIP: 0010:__raw_spin_unlock_irqrestore+0x21/0x30
> > > Call Trace:
> > >  <TASK>
> > >  amd_iommu_attach_device+0x69/0x450
> > >  __iommu_device_set_domain+0x7b/0x190
> > >  __iommu_group_set_core_domain+0x61/0xd0
> > >  iommu_detatch_group+0x27/0x40
> > >  vfio_iommu_type1_detach_group+0x157/0x780 [vfio_iommu_type1]
> > >  vfio_group_detach_container+0x59/0x160 [vfio]
> > >  vfio_group_fops_release+0x4d/0x90 [vfio]
> > >  __fput+0x95/0x2a0
> > >  task_work_run+0x93/0xc0
> > >  do_exit+0x321/0x950
> > >  do_group_exit+0x7f/0xa0
> > >  get_signal_0x77d/0x780
> > >  </TASK>
> > >
> > > This occurs because we're a VM and we're splitting up the size
> > > CMD_INV_IOMMU_ALL_PAGES_ADDRESS we get from
> > > amd_iommu_domain_flush_tlb_pde() into a bunch of smaller flushes.
> >
> > This function doesn't exist in the upstream kernel anymore, and the
> > new code doesn't generate CMD_INV_IOMMU_ALL_PAGES_ADDRESS flushes at
> > all, AFAIK.
> 
> This was based on linus/master as of March 4th, and we get here via
> amd_iommu_flush_tlb_all, which definitely still exists, so what
> specifically are you talking about? Thanks,

$ git grep amd_iommu_domain_flush_tlb_pde | wc -l
0

The entire page table logic was rewritten. The stuff that caused these
issues is gone and the new stuff doesn't appear to have this bug of
passing size == CMD_INV_IOMMU_ALL_PAGES_ADDRESS.

If it does please explain it in terms of the new stuff without
referencing deleted functions.

I don't know how you get something like this into -stable.

Jason

