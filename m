Return-Path: <stable+bounces-233479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDbDOvBZ1GlLtQcAu9opvQ
	(envelope-from <stable+bounces-233479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 03:12:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 773033A899D
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 03:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E8133016835
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 01:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435AD1E7C23;
	Tue,  7 Apr 2026 01:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="L+qU2ktr"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD82B1C8603
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 01:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524334; cv=none; b=EliOuxH0joM7bOWCi/I+lbRXtPbqLOqxsmyawz+bueU0hXE6VuhX4hQQD28BA2Vk4ZtuhKShS9Nxyv6NMjY4wiX/nN2+MdiqMC/fdXema4hvqpAC1CenMd8R1+U/V9ndiXJwa6FOHYTJyZzB2bDAb69gfyxn9Snd25PoMzkFYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524334; c=relaxed/simple;
	bh=T63k1uJxSq+Df7WJDfeXbmrwdzhkKi+FAbSdKxJ5VGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErOXofUdfj+p3SpBOlKYwV5lEPWX4rgkgr0gLT3G3nwDAt4I4zcyMDUC+pDRFDP+AxklRu1C3K2B893GKXjW6tkKFZLC2juqmph00qWBAvexBPYLgPCPGAb92pHCIvfiLZeqGNdEy3JI7wR1Y9bDH/VYYPH0yplcSfwI2L2qCnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=L+qU2ktr; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a4b8c3a30bso61446246d6.3
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 18:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775524331; x=1776129131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xaTS/cjbwD199MSee68/inAfCQq7y2tm4S22SDQ6gKc=;
        b=L+qU2ktrhBHZSnbRtcg7IO67KjbqSqTFBCxs0yVj0azEMmmCiTlBi2JVsuWIxvNku9
         Pqz72fFCpBbCHHa6WqqB5PUxBtwezunqd0D0EabEcZv1dTGid6F8ohvJu+CiFaAjqm+3
         xJ8vRIOFHyeWhmzlG0+dfjIt1U4N189+cBuQaNECSRUYdkeR+bOEyL67iiQEozNilPyY
         ktLHrzgnEJJT8qM7u+poY7LUPkdIPa7RNR8CPGVuCrOkfHcj6omOkAxpVpoewoe9YN4k
         DZNKR2q+j0pSpTHHvlFq6U600byFApCJ23OST8WE7QW4q7rVHOFqkSaPGAcVSkcL+f9F
         j4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775524331; x=1776129131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaTS/cjbwD199MSee68/inAfCQq7y2tm4S22SDQ6gKc=;
        b=n9coroVmJ968M92GmeBE/cG0bv8XGvC+Z9Lb0y2U6pCNedrZX4B41Z4Sj5mIZwIt/O
         LozOkHT9eatxVTB0cNoUolXy5kGtNpDxT1mOhqdQuFevYPaJ9+uJuUwA/bek6Cle5AZr
         kZyeVzVjMJUg4tUGvCxvhrymCt48M0hfM9L7EaWeFLjpptOz2NYOYSqp5dp/Pzlob036
         XqFCwIAE0ISkvUYI1dvTUYGTJld4bRJnd+x+SUg6+6exO0K1WmwOWD4dE/pv79xS8tXS
         XmX2vOvvk2zPN+Iz+W+sSqDMMw+1njlQ1zAnzuQqgqxZSdSgu3Yx0+VEdnZ6Ctyn/1MV
         yC2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaz40ZG+MQqQUgaGPVpyZqCbO7UtC5kesv0nFjDGVDkuuc/b/zJE8+V1VUQz0DM+kJYH8Cqzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNb/Dgi2K7ZZEKvdcGjUYgF4xAtGlCoJLWR3g+1ZRG5eKtx0v4
	xv/rRJkpQ5fvYFffCPbvEvwV9csc4A53jClAvTTj8MEd8tR6adJhucJMLKrZOiO5EnA=
X-Gm-Gg: AeBDies8uqp3qsmtIRSVeq+ELMInw2zW1c78UvwSRHrZndgXLZWwSn1eni1Uy5kdzKK
	NDkDMweM825v07aKOE0YspalHZ1U+KsbTY7AF61wFufBfGdObNoQA8XsYEAjuVxSRSn+ZWNxvfC
	BLsphIbTVIMHl1Dbj4o6d1bV4l8vzXJI8WSHi7kcNrHN6o32RfngGbuvxRaZFp73M5dlyVSTlgN
	OMPfTeCCscEAM/l3tEKQXVAFHnCXCrJ6YX00H+OcGzPL2XWGOwxql8CFYdLYcM1G2allv1O+7Vo
	loRuEBIrpSzeTKxBhFFk7c3ulfjL7viDA7UZN6EdfgCcZxorrcfw2USX+/UHuy3V9CmVJ+ooRK3
	YrVa0Y5Eun6vbziunpaBBW1nLmeg3IbnBSLi8C0ZOg9WHbSBWkTVgbb7+nGm9nRSZotg/SkJA7W
	oiQbgH43JuhjZSSbRDL3yC2ZQvpet+8oRH3wU9EsB0vZBqSbWqjJW8Tt/WVKJDk73iTZKSoaLvG
	oIMLFae
X-Received: by 2002:a05:6214:518e:b0:8aa:6dee:4b93 with SMTP id 6a1803df08f44-8aa6dee68e7mr101997526d6.16.1775524331555;
        Mon, 06 Apr 2026 18:12:11 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593908b47sm160088906d6.11.2026.04.06.18.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 18:12:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w9uzC-0000000EA12-1dZT;
	Mon, 06 Apr 2026 22:12:10 -0300
Date: Mon, 6 Apr 2026 22:12:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sina Hassani <sina@openai.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Aaron Wisner <awiz@openai.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Fixes a race in iopt_unmap_iova_range
Message-ID: <20260407011210.GM2551565@ziepe.ca>
References: <CAAJpGJTztK=BTvr6s_e4epJffKchmXmqba82wxE_SOXUN6FWYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAJpGJTztK=BTvr6s_e4epJffKchmXmqba82wxE_SOXUN6FWYg@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-233479-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Queue-Id: 773033A899D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 04:07:01PM -0700, Sina Hassani wrote:

> io_pagetable *iopt, unsigned long start,
>                 unmapped_bytes += area_last - area_first + 1;
> 
>                 down_write(&iopt->iova_rwsem);
> +
> +               /* Do not reconsider things already unmapped in case of
> +                * concurrent allocation */
> +               start = area_last + 1;

area_last can be ULONG_MAX so this literally overflows to 0. It is why
I formed the suggestion I gave as I did

Jason

