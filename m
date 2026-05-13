Return-Path: <stable+bounces-246894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFONDqaSBGoVLgIAu9opvQ
	(envelope-from <stable+bounces-246894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:03:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B016535A90
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A22130934D9
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4DC38E120;
	Wed, 13 May 2026 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PJrsebHJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E3A40B6DD
	for <stable@vger.kernel.org>; Wed, 13 May 2026 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684247; cv=none; b=CPBP3d1dRoEs8UmMjDVP9i3oHzQhNDyBRonXruK6m9nSwxczt7W7IS+QtpHQb8VycUVvfMiVn3xxVYVInYbA9RimjSgO0saYo3ekNSQEFi50G79dszGyV/QDqHB6qCGEB+bXE5HJ4ZlX/oKRbziox7stYtuebJHTK5/S5IloKqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684247; c=relaxed/simple;
	bh=h9bAwQMPen4e2kR3BQjshOf6XOKV0LRZUx+Q+Yhg74M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqG5L9oE+/1kC+P5WNxfxxq82R4qHOCxsc4KxAooWhRkXlZVVsWy/eQfAxzsGawjRALisqyMru4j1ihDG+cgwTVeBDroemPGR4VUK4AL0FPA5mQ3pjtAnr9FJfiro+zJ3Ab1zM262VkwLX28SKa+hXiVFl3BFTMsLsWDaxPylX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PJrsebHJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so1125e9.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778684245; x=1779289045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7HJ+58x1aDhyagRTCbZYUW45HaOqv0hJBTleCF7fG8M=;
        b=PJrsebHJiKf+1tOltL9MLkTSWyMtJaT6JJtTwL0sSDEkNki71amZWhjTfy44PVBTLr
         UspXQruQX3E6WnhdOG3yOdx9a8alwdc0RI8OSu8fRjOAa0NesMPeGXSLi4LgbNIZ1Hnq
         ST8VEOLV/XKVl9OBBtZMXe41koavp0seVZw9n4Y/bO7qDYAo8WajZLojFk11qz6ryxUd
         Dq+Xv+L15UlpMYoVa0Tcad56lNthl8wEtHDyc9e50ujHi/5nwPDIdk2JlIbtwkBfYMVb
         ds6grpGJ+zlFxpZ8+UF7qIp/eZyiOZ8vZyS5ilSvRNWfOXPiMDQT1f7WaLBvTabJG8/u
         Irqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778684245; x=1779289045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HJ+58x1aDhyagRTCbZYUW45HaOqv0hJBTleCF7fG8M=;
        b=XCYDaTPXXpsH1ggFq09fl5QP0P620+tC0uSY9OQVw5rKcADaXFLCUkjfbDsQZ+zUkk
         ZKxwKWeY5OLggnSXTcwNevhxsLOnxt/MGvRosYIHki9S/TXVHR/lTAyzjuY/td2sJdl3
         1TSphWqqXrCSlrg+XTjtj8xA2OwwtX7zyDaXNoVjkOVSLDWd19azsI6H7XZh93QvlBi1
         lgSINc5zTXYp8rSIq1fqtd1DL8QngsRtstAT07bsW0AfRHGOB8mvlfAUBQkYvlcnQ2YJ
         +qQA6wprPKGK8NR1Wi9moxM7KbMkaDqBGC2VuZ7oVzJ5MF3ukoI/WTqhXSM/yfgTsHWT
         5thQ==
X-Forwarded-Encrypted: i=1; AFNElJ/n4JA9l1S4I6VvPXGh5U7AG02YomI0R2uGeJO+hh2WZxEJNtR66NJsg9F7P6JH4MzSkcFmgGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe43r/vHWqNip4prvvJghKw4lfVMLPV6beBjTA0cnmKVIJxBzy
	96Wo4gx+UV3NoHdZR3P0TJQIaKgyvWdkxn/o5v9n2x3TrnK5ERlHEcN57o+nuSQWNg==
X-Gm-Gg: Acq92OHv4Cwc/+AtJnm5cKscdzS/eu8pb8R++BdK/ZE3oibkUmmmo16oeYG7u9NNdHh
	45pQ0mJCjn1ed12zyqGmAjB1A7SsMXi/wM/1zvrI5yqHKpitPYkCU8ZfbU746fyMZq/UNWBFPz0
	cleVN7Bmo0p8QpHgadBbhrDBtqwy+a/IXjd54hNUDS+x/AW6xJP9qvUAjd5guab74vMB6F3IuaK
	nfu320ODheAf3oLawhkltEFKCgxWMXL473nDjbGEuHKkTq0onc7xSM0XriaWHkAAq295to0qEJd
	iNUgIh4JoYcfnuOFMXkNuW/kiwv/Kxm6k82zVKl21w3nllksddmCJzy+V7HvNhtNAqJVJPxDfv8
	D/3+n9la4BZGSk/9/T7/fMyIMBi/COJh/5S4lVmNAyKskhY5NnWWSRrZdpNU3oz/MsDdXi8xrXK
	qylSVDOxLzi0WiAVfmvoavZUy+H+8oDj5PWSwXCEG9XEgfHlLE3KpWOlgRk8f0qlCaYbU=
X-Received: by 2002:a05:600d:8486:20b0:477:86fd:fb49 with SMTP id 5b1f17b1804b1-48fc919a43dmr860735e9.10.1778684244549;
        Wed, 13 May 2026 07:57:24 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d27d31sm128460865e9.8.2026.05.13.07.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 07:57:23 -0700 (PDT)
Date: Wed, 13 May 2026 14:57:17 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Josua Mayer <josua@solid-run.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Pranjal Shrivastava <praan@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 1/5] iommu: Fix loss of errno on map failure for
 classic ops
Message-ID: <agSRTQFAhiRQ6DYQ@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <1-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
X-Rspamd-Queue-Id: 0B016535A90
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246894-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:email,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 01:46:13PM -0300, Jason Gunthorpe wrote:
> A typo, likely from a rebase, inverted the condition and caused
> errors to be lost. Fix it to be "if (ret)".
> 
> This was breaking iommu_create_device_direct_mappings() on drivers
> that don't use iommupt and don't fully set up their domain in
> alloc_pages() (i.e., SMMUv2). In this case the first call of
> iommu_create_device_direct_mappings() should fail due to the
> incompletely initialized domain. Since it wrongly returns success,
> the second call to iommu_create_device_direct_mappings() doesn't
> happen and IOMMU_RESV_DIRECT is never set up.
> 
> Cc: stable@vger.kernel.org
> Fixes: d6c65b0fd621 ("iommupt: Avoid rewalking during map")
> Reported-by: Josua Mayer <josua@solid-run.com>
> Closes: https://lore.kernel.org/all/321c2e57-6a17-4aef-ba42-d2ebd577e472@solid-run.com/
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  drivers/iommu/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 61c12ba782066a..6e53cfad5dc001 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2669,7 +2669,7 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
>  		return 0;
>  	}
>  	ret = __iommu_map_domain_pgtbl(domain, iova, paddr, size, prot, gfp);
> -	if (!ret)
> +	if (ret)
>  		return ret;
>  
>  	trace_map(iova, paddr, size);
> -- 
> 2.43.0
> 

