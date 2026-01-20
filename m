Return-Path: <stable+bounces-210539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCVsI5oxcGkSXAAAu9opvQ
	(envelope-from <stable+bounces-210539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:53:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0839A4F61C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7875274CAFF
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65724279F2;
	Tue, 20 Jan 2026 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MUSNSA5R"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5519141B35E
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914715; cv=none; b=MXXkqv4xB5Dg6sEuxN586gZn0c14KXFOC+ObtzB8aWd4P4IlEe69AXj0/uJK7GVVzmrrLRZyKOzLGuSR3KM+1dw1N4zT3mQRLp/pWFA65mNQ5V0nczkJHXIR9qwxlDnxkLk56HH7cvME8XWhqn5FkbtGTq+B9XkynNms2JPb0k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914715; c=relaxed/simple;
	bh=oWxRqXkSIAdlpRXurKw8PqWkt7+sbNg3g3rpNYKoLZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iN2bwvfW94PnleYGnQqF+ygKhfmbyx3QsdtcFoZbKUT3XsToWDaoy1uWmynYfWtaUWApIFzk6n2EkY4pSWn1/i4JaacoBTmyLyqH4geNLi1is/a6Doy7bwTNSGN1KBc1aLKSZ+MeCiTJgszrRLoyYumBtbQxuAqWypz622VJPCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MUSNSA5R; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88a3bba9fd4so56352826d6.2
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 05:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768914712; x=1769519512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AFD8dduxHdXARbhmuw3nGz+HS5/qU93piZU3w6MAoZk=;
        b=MUSNSA5RUbC88BDrCXhLaUUsBlajOLVElMVHGXO4nqlWoSEAUrFdDQHF4AUdz2QlGv
         IaHtT8OAuIO11l9UasTtiyO2vkiDOtiPfhWM72lEGzX8i11o2GVpTO2FfR/eVi/EZrHM
         mW1iJaFlCMjeVCeOFcMn6uy93emB8h8ckI0iYMHUMaPzNhmK/KWKdvGJ8IB3Rs+9JQ2n
         bfE+auGVh2LHZTA0QXX7IKARGuwLZSMZqa+XQarK28J3w78+YuYMmcYtY2uFDypLpVzG
         mi5RtTIZcymL/NFfBfDEFHJdOf1tndHVBRoqXKfSer5cJL+W00ArCyIxXx7A5pusw/3C
         +DHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768914712; x=1769519512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFD8dduxHdXARbhmuw3nGz+HS5/qU93piZU3w6MAoZk=;
        b=uJBG9B3CmmnmfB+B0Kd8E6VtGp4YECWKxZnX4kaBB8uK2CoUGwsy4chy0V1iF1ROL7
         NfQXGS4Uv8E/sY4Eu2rw4BnINP/CEtc0v4VdxycYlrnKhEL/6Wz6hGlaoTNbCxXawTtw
         6P4VlmEvLTCpdIWIAJKQIlwu+Hk1ZmcxaY7JN3oLlt6Rkn86LxT/TmnyNelOJqwcXDb1
         y4wbw0mjFo+adxotBo1TgfHtanpxJyzRAv/GCi7d0kZ+5zU4bNiTxS6Np6tpfHUl9dx4
         cCwPbCOJNENtA/ozakEG4nMsuIzHmHxbGnzx5H+CSuAHtQKnTusTWCKcvs6wA7BJvzBX
         wY8A==
X-Forwarded-Encrypted: i=1; AJvYcCXk+tVrj169fmX+Ngv04Q3byi82NsK5xFMOX2Xr+VSpTnUDA7mD+OqJcZdZuWe3DiJO7yFDhN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBUpmfErnigtzsARhYhc1CZ6sR9ZoOnR7XGmS9DPJNycIg9RSH
	cUek3VKbgXBMwBKlBCVQqDaAwzouIxBfi85m6dz3Ko3il6E5Mp+4CXyj+e80c7s67y0=
X-Gm-Gg: AZuq6aKkgi3d4wPY4QKbRSOUDuCvWwIZHtWeREl4fz6ELevpNaDEGBfrXZ85YUHNN+O
	4NdOWelu2PI8zHzsUvDG+LR3iFTIfpvUa+0DdemPJJbZ+1smKB4Rq4Tr7cWtr1FHTBnJ9GVfDWI
	ntcv0432++dKRJ9/h4K45fpaqPnK7FQeFBH6hOG42TEHJSspYiVwvqxVbrvFaMutPsTdUVoNe1O
	n+iNsrfCWdUqFa+wcwiJO0zisl5Xg2rncZiPHGRLdZcPvNHG0s6GQHMRN7LEdMUXEN2NmuNKQiG
	iBfTyz6IJk1FDierd49lGD5rVralYxHZQQ0Xfzad6cqMVn2KLZrgjklFJKz5B9CSYh4aAZbxJ7g
	Mm6ICmzLRumlKD2pBgvhurj3U2T97KEXUDz5UEO/HmcgttowgZ06E2Xw7fjYry/0u2Ca/cTyH4Y
	ZpMHHFaTuJAq2RWPd8VKlstetA2m47pqJAS6mwYE9sXQPYL0sT/jDunRzNUzUwKzhSO0k=
X-Received: by 2002:a05:6214:21e2:b0:78d:be82:fffa with SMTP id 6a1803df08f44-89463e12ecbmr22544176d6.33.1768914711953;
        Tue, 20 Jan 2026 05:11:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e5e5307sm104190186d6.9.2026.01.20.05.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:11:51 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viBWQ-00000005W5W-3jR2;
	Tue, 20 Jan 2026 09:11:50 -0400
Date: Tue, 20 Jan 2026 09:11:50 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Dawei Li <dawei.li@linux.dev>,
	joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Maintain valid access attributes for
 non-coherent SMMU
Message-ID: <20260120131150.GM961572@ziepe.ca>
References: <20251229002354.162872-1-dawei.li@linux.dev>
 <c25309d1-0424-495e-82af-d025b3e6d8c8@arm.com>
 <20260105145321.GD125261@ziepe.ca>
 <f253d6aa-1dc2-4b1a-85df-f43b06719c04@arm.com>
 <20260105185423.GI125261@ziepe.ca>
 <aW9xs1ko3nWq5VbS@willie-the-truck>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW9xs1ko3nWq5VbS@willie-the-truck>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,linux.dev,8bytes.org,lists.infradead.org,lists.linux.dev,vger.kernel.org,outlook.com];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-210539-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,stable@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 0839A4F61C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 12:14:43PM +0000, Will Deacon wrote:
> I'm not against being more careful about the memory attributes used by
> the non-coherent walker, but we shouldn't fool ourselves into thinking
> that Linux can treat coherent devices as non-coherent and expect things
> to work generally. 

Probably not generally, but we will need much more flexible
coherent/non-coherent choices for some upcoming HW that cannot support
cachable access for certain isochronous DMA flows.

The device driver will know this, and it will know the underlying HW
works properly, so it can safely opt in without worrying about
"generally".

PCIe defined no-snoop TLPs a long time ago for these isochronous cases
and we haven't done a great job supporting this feature in Linux so far.

> The use of non-cacheable mappings in
> dma_alloc_coherent() and cache invalidation in the streaming API when
> transferring buffer ownership back to the CPU can both lead to DMA
> corruption if the device can snoop the CPU caches.

That's a bit different situation, here we are talking about the SMMU
itself and things like the page table walker are fine if the HW does
cachable or non-cachable because we can flush the caches and the HW
never writes. The same argument works for the stream table and CD
tables, but they'd have to switch away from dma_alloc_coherent().

Certainly the end device driver doing DMA can't get off so easy, but
it is also not so unreasonable to think that the driver should know
that the SOC block it is driving has an appropriate HW implementation
for no-snoop.

> I think we're all agreed on that, but just wanted to make sure as this
> is something that has come up before when talking to hardware folks
> who seem to think that the "dma-coherent" property is a hint.

What I've been pushing for is that the SMMU architected cache
properties have to be followed. If the architecture says the
transaction must be cachable then the HW must actually cache snoop it.

However, this goes the other way too and if the architecture says the
transaction should be uncached the HW can bypass the cache.

Hence my interest in this series because HW that follows the
architected cache properties is going to be sad if Linux doesn't set
them right.

If the HW actually implements the cache properties then the SW needs
to select cached/non-cached on a (sub)stream basis to support
isochronous flows. If the SW doesn't do this and just selects the
deafult cachable then the DMAs will work and transfer the right data,
but the realtime guarantees will fail and other parts of the system
will have errors.

Jason

