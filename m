Return-Path: <stable+bounces-247019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKSYIqfHBGrdNwIAu9opvQ
	(envelope-from <stable+bounces-247019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:49:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A4053944D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87F3A30143C8
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2783A9DA3;
	Wed, 13 May 2026 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tm+7e4Ap"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2005346AD4
	for <stable@vger.kernel.org>; Wed, 13 May 2026 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698113; cv=none; b=q1ReD4jzrwdba74azzm/11/mc1OsUJEOhEJAk/PqOsuUkll9z24pE+0dt3l3Qxxd92UPs7LgpWeJiuCms0+DXKzHodq+e/iw47Q2XH/bpijGaKcDmV6IZu2ony06UzyhPFhen/AvIeNb18G7ubHvGbJ8ZtiwWPyqARUm6kctl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698113; c=relaxed/simple;
	bh=aL2zYD6QLERED7wzbI8gk+iTUinoqfJpuO7sHvvFO88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRsmQvN4+wNjYl59xjKOrWxui2tKZrLa2PSefdCamMCB1ZfUFSJoJEgvVQ0vjhl7Uju4nvFiQ7ATSFVm7dT8KZ/GelF2JbS9RZwDppAeHk+SRt913lSQ5TKD0hHDg1lMZLXoiaAg5gE7GWLJZ5AWVbIWsq9mzcGmNXS+ZYMuq/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tm+7e4Ap; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1336742714fso154c88.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778698111; x=1779302911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWJJS5PcKWqo9rQpzbwkNgjxbs/zQ0FlBBDO0W0FHcE=;
        b=tm+7e4ApvnIn+QdqfCFG4JmHQKFuIgbn5R/30Kw+QeFhP63ThROKAf5Rne3fJcNt/D
         0Fjsi/+8uJXojgyYsnM5DIXjBPdTN9Fw9w2Z/VFZli0q53Rxd3WoSO5Nw+YqdB+JyMY4
         nfCynAAE98MqnYN5GNvHyrFDAc7+HUvKxBKIzAmpHwR7eVoiyixU9IZb68umsoZrEIUI
         veBhhgBuf3yzEqlzxAe/fNPxGvkVtZHNC+/6JenrzsnsbSSCkr9lHE+m6TF+EBP9uDWH
         qXg/A1OdZ+0CCg3GY3ZjqiaJr4aEFNgR1Tb92LvJ48gEAqZ8WihlifyXVA+IivVD5+oD
         t6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778698111; x=1779302911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWJJS5PcKWqo9rQpzbwkNgjxbs/zQ0FlBBDO0W0FHcE=;
        b=OZ73YWBmFIILcin9RRhHpxbjVgGXjimlE2tHbmF+TVWOPO/Gi/hqhSSXeEFfVlztGg
         8XmS2hPMdXbQXjG7U1Q/b5PUdfyolPne8fbZ9vC1cIiSRMfwi1np8rdZLNyk85NhduUi
         Q2XHAmbtuOeNKNq4RkwgXdlfL0Xf7RRygPogqy1weQ61YTXVCRxIQGEb39yFyw9Jo8uy
         AObLSTo3y5zUYuJRlMLMuQKxKKI2OAtzrmzV1Pc0ajZjQ2BIm/fTxMyf/R196sbNexdv
         kujYLVckzwzHDFnuMnlHRauyPPbIFaY52JNyStoM/Y6DULnpgx2Ul484swLsn3NjBP6K
         r6zQ==
X-Forwarded-Encrypted: i=1; AFNElJ9p3ktRctVNn1oVd4DqKZwpJy3sOG035s6xAs1NH83Lft173J+Ru7RLbxEX9AO66PizoBBKQ6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIsmS8591wmRwQxKUBhPWyqUct/q84lz4hG5ytiK4CoJYa4jA9
	udJwub64tl9MDQWumBBadtSGTrcmuglAPIAdKVMlxED40lWKmNUmXsDVPUD4Y/Na/Q==
X-Gm-Gg: Acq92OGPjQsGeN4e2p2hY+4P8/vTveCKhIPxObqxWbOWXXQ7NMjl0bg+eGPKBy9Io7R
	5GuiiTo68EPfPkGUdOE7P9IW8QnKq+i16ljx5vk0XIWr1f4TBRk8VuHNuLAz9TlKkX7+O3uxV/N
	l3eS4l0SPCYHcfCih2Hg+d4C/mVojgf06BMJJQHfpw6nXu2nl5ie9vBx0cinu+tCGdXow01gN0z
	OQRsyYtIvdp++QEiXy0VFRcjlHX0PJK4NAuGGeEWlZ2/QzyC8pfQNPMboYncWNd+OscOxRBArvh
	PIKMwPG3Lo/D6kriD0Ztc4Lmn3I5CAEtg8lqy4A6HTjXUBCh7kGMOcrDV7wbJPDKoV5iEDpQTYi
	MTtyidSZkax21i50MR/3kh16EumhKGzxYKQe89IVjHrWhyNY9eSFkAj9GycQrxeDlbLSTMQHBgK
	izQFGPL01q5IW+7i45YKRNXlYXbbNfzCKSQzr3fU0t0Dd7I9Fw2oxpdOKBoFG5BI8LNZu8jw==
X-Received: by 2002:a05:7023:b8a:b0:12a:8cf4:6506 with SMTP id a92af1059eb24-134cb45845fmr51331c88.4.1778698110450;
        Wed, 13 May 2026 11:48:30 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847502fsm28400768eec.14.2026.05.13.11.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:48:30 -0700 (PDT)
Date: Wed, 13 May 2026 18:48:26 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joerg.roedel@amd.com>, Josua Mayer <josua@solid-run.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	patches@lists.linux.dev, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 4/5] iommupt: Check for missing PAGE_SIZE in the
 pgsize_bitmap
Message-ID: <agS-MDCnoofhsBEe@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <4-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <agS04F8UmZwWZNao@google.com>
 <agS6jQII_2PsAuZh@google.com>
 <20260513180607.GC787748@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260513180607.GC787748@nvidia.com>
X-Rspamd-Queue-Id: 06A4053944D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247019-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhawaja@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 03:06:07PM -0300, Jason Gunthorpe wrote:
>On Wed, May 13, 2026 at 05:57:13PM +0000, Samiullah Khawaja wrote:
>> On Wed, May 13, 2026 at 05:46:22PM +0000, Samiullah Khawaja wrote:
>> > On Tue, May 12, 2026 at 01:46:16PM -0300, Jason Gunthorpe wrote:
>> > > Sashiko pointed out that the driver could drop PAGE_SIZE from the
>> > > pgsize_bitmap. That is technically allowed but nothing does it, and
>> > > such an iommu_domain would not be used with the DMA API today.
>> > >
>> > > Still, it is against the design and it is trivial to fix up. Lift
>> > > the PT_WARN_ON to the if branch and just skip the fast path.
>> > >
>> > > Fixes: dcd6a011a8d5 ("iommupt: Add map_pages op")
>> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>> > > ---
>> > > drivers/iommu/generic_pt/iommu_pt.h | 4 ++--
>> > > 1 file changed, 2 insertions(+), 2 deletions(-)
>> > >
>> > > diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
>> > > index 19b6daf88f2ab1..4877b05291c9d4 100644
>> > > --- a/drivers/iommu/generic_pt/iommu_pt.h
>> > > +++ b/drivers/iommu/generic_pt/iommu_pt.h
>> > > @@ -920,8 +920,8 @@ static int NS(map_range)(struct pt_iommu *iommu_table, dma_addr_t iova,
>> > > 		return ret;
>> > >
>> > > 	/* Calculate target page size and level for the leaves */
>> > > -	if (pt_has_system_page_size(common) && len == PAGE_SIZE) {
>> > > -		PT_WARN_ON(!(pgsize_bitmap & PAGE_SIZE));
>> > > +	if (pt_has_system_page_size(common) && len == PAGE_SIZE &&
>> > > +		likely(pgsize_bitmap & PAGE_SIZE)) {
>> > > 		if (log2_mod(iova | paddr, PAGE_SHIFT))
>> > > 			return -ENXIO;
>>
>> After thought nit:
>>
>> I wonder if the error handling of iova and paddr alignment should also
>> be deferred to non-fast path? Basically lift the iova and paddr check
>> in the parent if?
>
>That would break support for < PAGE_SIZE tables which I've tried to

I was also thinking about support of < PAGE_SIZE tables and wondering
whether the < PAGE_SIZE tables support is already broken. For examples
consider following:

iova = 0x12341800
paddr = 0x56781800
len = PAGE_SIZE (4k)

But pt_has_system_page_size() will be false in such a system.
>keep generic support for. Similar checks already exist in the generic
>code in a more general way, probably the first is
>pt_compute_best_pgsize().

I was suggesting to rely on the already existing checks in
pt_compute_best_pgsize() to do error handling, by only entering fast
path if iova and paddr are also aligned.
>
>Thanks,
>Jason

No change needed. Putting this here again:

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

Thanks,
Sami

