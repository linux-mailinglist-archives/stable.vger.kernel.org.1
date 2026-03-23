Return-Path: <stable+bounces-228077-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK8uLBtGwWnpRwQAu9opvQ
	(envelope-from <stable+bounces-228077-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:54:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 474442F3662
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6794330172EC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41E23AD534;
	Mon, 23 Mar 2026 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="T2i+g0/a"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F0A3AE1AA
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274058; cv=none; b=n07IBrImNN0jDgnBrh1cQDNcvJRMvRsg65l7CJBLuI/MlhXHZdeNuTSz5IYvOCfy729RJILfBdK0o9V0XPfXAp/Zxw8hTtAoMQj80VM8V6GZMRaMpX2UNRYfjZ2gTgY5cN7LHV+Qs6gaNSvvKWd2kgZ74Aqd1zKw7jFi0TvfHzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274058; c=relaxed/simple;
	bh=j8+NLnpYEVro6v3X3zB3ByVB1aVEdc+kKTmLiXnpYfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEPKX/4X+Ls3LKyByiK76Z72XPBet3/1rrC6g/2PpQTY+NlFnD4uJBN2vAmseUZp9MY7pasbQpy/ohjyiz47LUwNtH2x6wGOZhIGI5hxsGIHrOhK1k+YTV7aEXrE34xcCToA8QzJY2yCWVvVEle0Sdp2a7u87qnl2VZfakufJrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=T2i+g0/a; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-509134ab2d2so1530731cf.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 06:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774274056; x=1774878856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp9nHZf7NvuTaD3ZnAARZsLypmpLx61M2YmeLJUPLk8=;
        b=T2i+g0/aNgWQCVOsRZQ/DBkuKhoOKS436F4MvDxebY12UgTnqFobiBK4kpzqn2vAGB
         q5M7WIWu34f92xrOPgbzbcC0CSO1+EEZlLdvdGRJ4j8cyhab8zfo0YftVnywr/ANX4xU
         gg6Z02dhC5ZqDjOEyuJlrPGxa98Td3sfTV3pHTDBX0tl4IoKB6X/+FhLgzAyzo6rw/7L
         GtfNUdPRZOe9vGu2njbyFeFDd2TwPLbhQ/QxoUeODrZ1FAiArtyY7tTk/F/JDItUUXTX
         B8v2lxFplBDGap/+BEdG3cPBHLgmymK43GsmlyjruFXDbmiyIUXHbgwrMnunGD0SZeJu
         AeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774274056; x=1774878856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cp9nHZf7NvuTaD3ZnAARZsLypmpLx61M2YmeLJUPLk8=;
        b=cYGf+wchjvb3H/Qb3MvzDdhgfD25ZwDBoAmsnVtlQ/s3vijCjpLXcPs3lyqTr94tLH
         CMW7I/Cde9y2AwhdXHGDT95e05SXMZcFa4sOrSeNjspVKNCoS5sZRtiUw3abpVQt/bS1
         C0kbMK46rUBBACqyRD3RudilVKmTqr2b/h3D7D2Nt35ORUsUrJgaplnRArx1cuKGl9Ly
         P5Xtin8rApzPhTz/dp4MeIO+aS911I1EAzDU+TtjZntbiPtWL7sJJEqc9Rjuwlv04U7K
         cD8JgOmBAhJFZmhuwouRfzp3fiVZ80t0TGRsnLxvaP8139u7lIilNs6tA/YYjyTwui10
         oxYw==
X-Forwarded-Encrypted: i=1; AJvYcCV2TN/YUYa9MyI77yY90R3+4HknywgSvbkdrA8/miCAikESvLG3CrSUQHiqxcWa6aDd87NyzA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+SaBVaW0ozO3G2ux/NPqXJKm/bG+szPkbwR9/AtSOqUSUvO2e
	Ia7jICS579GHqO3UzBoIiZt7jxiJa7ouN63LTk+ycVHmoSlYuKKwreXqQPNu7kPIMeo=
X-Gm-Gg: ATEYQzwzQB5AgLo70de8KMQV7Y0yXoodHrVOVT1kP1uc1A7IQz5LAJkhTRjzW+5j7+S
	YSEBVhOJ2gXvsEwpFIO5seVAFI1FuhH5sM5XOEN01koBgOAgVY1QNvOCFLD9psnqqk7qWDShxsH
	wlKQUtWdDP8Y8BZWheJik3zuQYaefp+774Assu3nsPGuaSsFXyJnRn0/vTFmzY6+SlN0O80+Dl4
	eY9SMC/ZrZkHtARvKmbJYjnguSE9tJ+ZaXyVom2kW+YzpZbBps6xmgeZxmOSlv7+xKUjkCqY+qw
	9hgXPtUnLt6I0DCRUPhB4WS545fj2yWVFLKPfOG77gCI97h9VpitXiWeuD86S89N7qvXV9AvQUU
	eR40cjsxvjCqIy/cKBSOXrSbKNnmiXpWqiNHNxj7yqfyQgag7awT5IoSQDEN8zFSdxUvdnGcgna
	l0QO+1yXkcDsPJv5MYBLY6WLmnDee9lSqtMwnrOQmMPiwhSvaxgWB6QqGngIJrhyqADY454Q==
X-Received: by 2002:ac8:5cc7:0:b0:509:2ef7:704c with SMTP id d75a77b69052e-50b375d5d24mr169439891cf.72.1774274055870;
        Mon, 23 Mar 2026 06:54:15 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c8534f9ccsm89564136d6.39.2026.03.23.06.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 06:54:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w4fjS-000000004Z9-0f4n;
	Mon, 23 Mar 2026 10:54:14 -0300
Date: Mon, 23 Mar 2026 10:54:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Joerg Roedel <jroedel@suse.de>, Bjorn Helgaas <bhelgaas@google.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	peter.griffin@linaro.org, andre.draszik@linaro.org,
	willmcvicker@google.com, jyescas@google.com,
	kernel-team@android.com, stable@vger.kernel.org
Subject: Re: [PATCH] iommu: Fix bypass of IOMMU readiness check for
 multi-IOMMU devices
Message-ID: <20260323135414.GA8437@ziepe.ca>
References: <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228077-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 474442F3662
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 01:09:27PM +0000, Tudor Ambarus wrote:
> Commit da33e87bd2bf ("iommu: Handle yet another race around
> registration") introduced a readiness check in `iommu_fwspec_init()` to
> prevent client drivers from configuring their IOMMUs before
> `bus_iommu_probe()` has completed.
> 
> To optimize the replay path, the readiness check was conditionally
> gated behind `!dev->iommu`:
>     if (!dev->iommu && !READ_ONCE(iommu->ready))
>         return -EPROBE_DEFER;
> 
> However, this assumption breaks down for devices that map to multiple
> IOMMU instances.

?? We don't directly support "multiple IOMMU instances". There is only
one dev->iommu.

AFAIK if some drivers need to support multiple different instances of
the same IOMMU driver they must deal with this fully internally and
present to the core a "single instance" view.

So, your explanation doesn't make sense to me. If dev->iommu is set
then the driver must be ready, including any multi-instances it has.

If it is not ready then this is really an iommu driver bug, not a core
bug?

Jason

