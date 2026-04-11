Return-Path: <stable+bounces-235728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGNkLgdI2mnWzggAu9opvQ
	(envelope-from <stable+bounces-235728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 15:09:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 101243E00F2
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 15:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BFA4300CE41
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 13:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE66921D00A;
	Sat, 11 Apr 2026 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SE9q9lXW"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF482147F9
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775912638; cv=none; b=gOmGpIK3EtcYFmqHQgHqWxprmOpptlKEvUc+TAmNDp0iEg6s1l0ejTmqsL0LG4hAa2cV6cf4adW6bWIcMpRzBgTY9xrfXF2ezR43Wx5yiwUPiKVRqrSziUIZKiJ9scHFoVFDVOE9NZ40ERZ/QmDEl5mbx1roN87RfvneSt60LYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775912638; c=relaxed/simple;
	bh=y/qt8MI2GKVfjtqin7pQ3eEBqNJwX/jBHf4zRPl0wBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuQ4cj08kivFCNPBhzhhzCAq3wO+5qmpjrjsiVjM0ufSPgqntNM3TOmfaTc0lkxjT3Dy+9f816srYMzn3cxujaQ+dcF6KHCp9zWd5tIbpuPENby2iB6kAwwlVeaBDEg1LWvb4rCEX9C/ISYk75sS2GOnW+HIsbum5lGYnHBdMoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SE9q9lXW; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-68397b9840cso1245361eaf.3
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 06:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775912636; x=1776517436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EY4fUTZIeXO1WyqRzqIOr8UDzbQvgioLsd0oMdufTzI=;
        b=SE9q9lXWWFE1d8BSYGVracLCvr98643tsgIENyoA4DLZZW8zljpalktkTvnSf2VzVn
         BJ+nag3SvoSZOEXf8otcN2xQNM2okkErd/IIStEJK32aJERMzmodz6/cU7d2Bw6Sp4hX
         CGmoGkRiqXyneKWY3f6p85jlji2sASCYFjXwczzwyE2WlDDgInjK2zE75uEFhRdWujgq
         FvfdDz6UYeVuHXntBkHRt9tEGkIByp0vR6bsipJhhd1vaoQDcoePaMCRMtrziRwYepZy
         Pp6NWg9Xg7Fn3u13fwaYCaczp+33Nlu3dkYjGa4xKNL8gdpOwD8kvR+tLR6d0vvVWtNl
         ixlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775912636; x=1776517436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EY4fUTZIeXO1WyqRzqIOr8UDzbQvgioLsd0oMdufTzI=;
        b=aGYwDrTvkdCWNau/gab5lbaxDSKz1n8JL76O28M9KTVxOb9V5yEmFHXAewElw2Lvp4
         KszZ+tpc6HDlpsYuZ1skSvUPUYjCMyc3OVQ1Y8HhSE6E8VXb4kp+4nFUSWshKCt5q7mk
         3GEZqewH5ajFuRBUXTMM35Vujb6X+sJ6DNEO98v16gnqR2lOMduAhoaWTmI8vIiUwO38
         2rAi7vvXlRL0lRFVFgAvcyLycg1CaoXOXVzUbmausNyoYEJ9/cE0RnlNkgVDYGbwc6cS
         TFJ66Azi9mGB/9m4zBb1RzGXxNDjbGbEmMI+8xFZHYUeuOXzt5Y+6O3vFZPOivzFP/vG
         ilQA==
X-Forwarded-Encrypted: i=1; AJvYcCVwwQ7VT3N7+qjAudvgE6AJ4vi3MAT06jKyw26VMzWNy3b2QwiGLxgcYr4XTUb72K6NxTI6AFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgQ/j9PJqCDDbqOyt6byGovaWABoJ499szDPPe4yV/+ODJECoH
	Gst9zwhK9EiRqmj1Acl9FY1GA4JZU0hLRnmky6xjkXKjrcAL8YPpCwlpWCLIp6hhymY=
X-Gm-Gg: AeBDiesUxQZHvaw4JggmuRqJl1SKD748xSoSFlSGRPv/mPJm2mK9ObLwTVXOvM3YgwS
	jUn3dL6QmDoX4SJKZissb/QEi66XJYPHsHNBHY7qPdp8tdR6dCnToXUoF260M96b1JSRDkLJx/F
	8h7FaBF3SHLBrNWWY/saj38krJKZDNPqaEY3QbCh65DEsF8seIMiuTzZOgR0W31kFxG3CChSy9G
	pVzMvRIuy++2Ijc8VRHkignqzId1n5/NrGW3thFcoY7c0JBP665Gg2RxqTi6d5oJFG/qT4gyGO2
	bMp/J2p5umLAqA9bnzGqcJZNDDhfAUnfIVZdzWU3siAi4UnY21NHXJqC/cTxQtVxtSHDbe5dC20
	fIbkpCWFX/7TsUe14dNEVJIIEszmnwehrSq465tsJGxd9aKfFPSUil+nGn4kZOaiwHT4MOgndZc
	5g23Mt14Vjc+MLu5nl8LCVP048NiO/9enD41R1+8HcjYf0lUMB7QbTq80yNqOgD7d8M6J3j27Bp
	2F38A==
X-Received: by 2002:a05:6820:611:b0:689:3c50:4952 with SMTP id 006d021491bc7-68be8fcb1d1mr3352283eaf.60.1775912635791;
        Sat, 11 Apr 2026 06:03:55 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd525fa23sm51017061cf.0.2026.04.11.06.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 06:03:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBY0A-00000002caD-2nEx;
	Sat, 11 Apr 2026 10:03:54 -0300
Date: Sat, 11 Apr 2026 10:03:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sina Hassani <sina@openai.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Aaron Wisner <awiz@openai.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] Fixes a race in iopt_unmap_iova_range
Message-ID: <20260411130354.GG3694781@ziepe.ca>
References: <CAAJpGJSR4r_ds1JOjmkqHtsBPyxu8GntoeW08Sk5RNQPmgi+tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAJpGJSR4r_ds1JOjmkqHtsBPyxu8GntoeW08Sk5RNQPmgi+tg@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-235728-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openai.com:email,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Queue-Id: 101243E00F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 11:32:44AM -0700, Sina Hassani wrote:
> Bug: iopt_unmap_iova_range releases the lock on iova_rwsem inside the loop
> body when getting to the more expensive unmap operations. This is fine on
> its own except the loop condition is based on the first area that matches
> the unmap address range. If a concurrent call to map picks an area that was
> unmapped in the previous iterations, this loop will try to mistakenly unmap
> them.
> 
> How to reproduce: I was able to reproduce this by having one userspace
> thread mapping buffers and passing them to another thread that unmaps
> them. The problem easily shows up as ebusy errors if you use single page
> mappings.
> 
> The fix: A simple fix that I implemented here is to advance the start
> pointer after we unmap an area. That way we are only looking at the
> IOVA range that is mapped and hence guaranteed to not have any overlaps
> in each iteration.
> 
> Test: I tested this against the repro mentioned above and it works fine.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Sina Hassani <sina@openai.com>
> ---
>  drivers/iommu/iommufd/io_pagetable.c | 6 ++++++
>  1 file changed, 6 insertions(+)

The patch is corrupted but I fixed it up by hand and applied it

Thanks,
Jason

