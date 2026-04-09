Return-Path: <stable+bounces-235411-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIlDLmCp12mxRAgAu9opvQ
	(envelope-from <stable+bounces-235411-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 15:28:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9403CB2D4
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 15:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD0633045AFE
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 13:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6A63D34B6;
	Thu,  9 Apr 2026 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nJoVDdUj"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AEE3B7B66
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740647; cv=none; b=l0m+UXi5Y5EHWGO/g7hB0FffEsh7ZaaIxdsZ5Q14qcsedOGgB8cylfklHlNbR0wtrVPy00ALGzHbLRQUb86fb85DFTmOYAWX41jmgX2HoSo9rnx4E9cfE2bB2A81WvFRnr2UXZt5IF45LBxXURZjDbPBew6GrYCuKRR2vYrcZQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740647; c=relaxed/simple;
	bh=b3ZQqWB4DIOdA8ELef1wmecmX41m8LiC52rMj6FfX6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=intFu/vcJONfmj3GYMMIY+ljXFDIsNpLegwDbBaWRXKWQv2leqfAANkqczF365gMOTMKcswgmeEXCH++IHvTTZox2ZO0KKz24Kqe9GAyTaM+bseRtpLkYJojTJEysF3vbFDPuQPWpRnNf22SYM81KEosDiCoaQfS0dHhsnkoN8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nJoVDdUj; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cfdac74050so85140685a.3
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775740643; x=1776345443; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C6vWnIbJNN7QWjov2VMlLT+LGdvblxosg4zhgXkV61E=;
        b=nJoVDdUjkC1b4Y12SI/Mr97yWm9V3ZVbVk59e41RardkU8TN4hdaqnqKqplPK+4psG
         3wv0nBLE/RspoRIpYSgYmhg4i9APmbc3VWVfa6ohZDTjw4YK5WoGXtPemjhe9Mt6Ovdm
         jN+qGNNc3lFleY6Gmw5rH5cUbRAsKBIPxN3pvpWOTfeuy6jzRAkX4FAwVzGKNAfugiLd
         HYCZZ1MMic/hVNYmvNenEOo/a9k7A9gAs05zUyuee3dbdKKWMXOWjXMaPm1SWt9EnYxj
         Ug6lKZu1PJa7MB98mq6y4470mStQJThNMNDjAYkR8kNJY4BEcZBE0dwI7p1cgiOUB6Vj
         YAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775740643; x=1776345443;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6vWnIbJNN7QWjov2VMlLT+LGdvblxosg4zhgXkV61E=;
        b=RMj4alfOsU34bCKgAXYGSjlODKO3gCWyi6vGBVXpX59FsJ8DDNC8FSCbjnTtLu18We
         kAK2dGuGUQHU8dyYxRjMyaaSbVrD9pN1p0X82uxJnr2Im1y7f9tuDynW9dSUrYdVxwz7
         PygzZCSaOjjsNDkFMForA9yVIK834ArlpP2Y0D5q0/DcpZDhyStc94rBCJ63g1FrRdzL
         Wj95HLvt9tcWa8XPCpjndx2Ta1zIzID/goSuU5WjbCWUfdiS27NX07icb7FdzCC684vM
         7on16FT3AQGh6BQXYg7dr0kYjd46KB+89My/kDKwCc+dIVF5kgk/KG8OFNX23nfj1VMc
         yGAA==
X-Forwarded-Encrypted: i=1; AJvYcCU6GCF8Wm+HJUW3cjU3DeR8skQCdjeBn8+HCdezGr1awpUjnlMHW4YwmadkFPKTqI8uj6Wp0hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkhRULVA/JQT1DUsThHrptpGN+zo6nr/YOhRgMC9yzY1DQuxjs
	4GGdhQqkPuQQRodDdzBF9YZ+W3HK3/hcnIxftAPJKGeCIcfi29V7s846Wn6WpXx8W4E=
X-Gm-Gg: AeBDiet/NtvCl9oFyK5FNFPaO8QL/wndZAdsQv+IEs/76SqLHItRYvOlAxHU1t8NS/j
	P2ZPrIl0RWjosTjY5AzKJd20/jcBqDg+ButsZYjCm2L/BnqCmgCFzQQ2AV+zA+VPCA+zhtIqpAu
	MdinO8Zqw4PYYJqHPvVmLYHwzls43zIF4GF/fe6pYtVd6SgW3uo7C/6LPsfWe/r5katcBldBI9X
	a8jvByiswPz6Q5MKQA41ERSfJivpcqGDAHzmkvsz89m2MhzKY/LCUdlkuqhIibjBuPw/I0AoqIa
	3QaQR/bgLZBuINxY4z6vgR50dKwGSOc2ENUuSF0jzmczJQrru/Zj/ppv5PYRrlKu80BqlAdIisI
	MlPHYR8JR3wmpjHt/Hof0yJ+7WlxMKHI1SEz6MSYSKGDIC5+r+X8WyaHO8hLxKj0Op9IuMYs358
	6ipWJFC+m521MUaYjvlpwzLkT8T2HVNnDihZ+8ZXMjucsFl0HwIMWn4Bez81+slO3XLjrqJw==
X-Received: by 2002:a05:6214:262f:b0:8a2:18b4:79ca with SMTP id 6a1803df08f44-8a703c26750mr415275106d6.34.1775740643189;
        Thu, 09 Apr 2026 06:17:23 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5977e00b4sm197193996d6.47.2026.04.09.06.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:17:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wApG5-00000007axo-2fVL;
	Thu, 09 Apr 2026 10:17:21 -0300
Date: Thu, 9 Apr 2026 10:17:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Weinan Liu <wnliu@google.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, josef@toxicpanda.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kpsingh@kernel.org
Subject: Re: [PATCH] amd/iommu: do not split domain flushes when flushing the
 entire range
Message-ID: <20260409131721.GQ2551565@ziepe.ca>
References: <20260326220512.GA245789@ziepe.ca>
 <20260409081227.2149181-1-wnliu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260409081227.2149181-1-wnliu@google.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	TAGGED_FROM(0.00)[bounces-235411-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8D9403CB2D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 08:12:25AM +0000, Weinan Liu wrote:
> > On Thu, Mar 26, 2026 19:05:12 -0300 Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > On Sat, Mar 14, 2026 at 02:24:11PM -0400, Josef Bacik wrote:
> > > On Thu, Mar 12, 2026 at 9:40 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Wed, Mar 04, 2026 at 04:30:03PM -0500, Josef Bacik wrote:
> > > > > We are hitting the following soft lockup in production on v6.6 and
> > > > > v6.12, but the bug exists in all versions
> > > > >
> > > > > watchdog: BUG: soft lockup - CPU#24 stuck for 31s! [tokio-runtime-w:1274919]
> > > > > CPU: 24 PID: 1274919 Comm: tokio-runtime-w Not tainted 6.6.105+ #1
> > > > > Hardware name: Google Google Compute Engine/Google Comput Engine, BIOS Google 10/25/2025
> > > > > RIP: 0010:__raw_spin_unlock_irqrestore+0x21/0x30
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  amd_iommu_attach_device+0x69/0x450
> > > > >  __iommu_device_set_domain+0x7b/0x190
> > > > >  __iommu_group_set_core_domain+0x61/0xd0
> > > > >  iommu_detatch_group+0x27/0x40
> > > > >  vfio_iommu_type1_detach_group+0x157/0x780 [vfio_iommu_type1]
> > > > >  vfio_group_detach_container+0x59/0x160 [vfio]
> > > > >  vfio_group_fops_release+0x4d/0x90 [vfio]
> > > > >  __fput+0x95/0x2a0
> > > > >  task_work_run+0x93/0xc0
> > > > >  do_exit+0x321/0x950
> > > > >  do_group_exit+0x7f/0xa0
> > > > >  get_signal_0x77d/0x780
> > > > >  </TASK>
> > > > >
> > > > > This occurs because we're a VM and we're splitting up the size
> > > > > CMD_INV_IOMMU_ALL_PAGES_ADDRESS we get from
> > > > > amd_iommu_domain_flush_tlb_pde() into a bunch of smaller flushes.
> > > >
> > > > This function doesn't exist in the upstream kernel anymore, and the
> > > > new code doesn't generate CMD_INV_IOMMU_ALL_PAGES_ADDRESS flushes at
> > > > all, AFAIK.
> > > 
> > > This was based on linus/master as of March 4th, and we get here via
> > > amd_iommu_flush_tlb_all, which definitely still exists, so what
> > > specifically are you talking about? Thanks,
> > 
> > $ git grep amd_iommu_domain_flush_tlb_pde | wc -l
> > 0
> > 
> > The entire page table logic was rewritten. The stuff that caused these
> > issues is gone and the new stuff doesn't appear to have this bug of
> > passing size == CMD_INV_IOMMU_ALL_PAGES_ADDRESS.
> > 
> > If it does please explain it in terms of the new stuff without
> > referencing deleted functions.
> > 
> > I don't know how you get something like this into -stable.
> 
> I believe the function Josef is referring to on linux/master is amd_iommu_domain_flush_all().
> https://elixir.bootlin.com/linux/v7.0-rc7/source/drivers/iommu/amd/iommu.c#L1820

That does seem to be an issue, but it is not going to be triggred by a
VFIO trace like Josef is showing. I've already fixed this properly in
my series:

https://lore.kernel.org/all/3-v2-90ddd19c0894+13561-iommupt_inv_amd_jgg@nvidia.com/

+	if (likely(!amd_iommu_np_cache) ||
+	    unlikely(address == 0 && last == U64_MAX)) {
+		__domain_flush_pages(domain, address, last);

By fully getting rid of the wrong use of
CMD_INV_IOMMU_ALL_PAGES_ADDRESS as a size in the callers.

So there is a small window when this patch could land with a commit
message to address amd_iommu_domain_flush_all() and be backported
before it all gets reworked and backporting will become hard. Respin
it quickly?

Jason

