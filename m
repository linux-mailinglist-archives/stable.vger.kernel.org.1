Return-Path: <stable+bounces-229984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCPSAmp7wWknTgQAu9opvQ
	(envelope-from <stable+bounces-229984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:42:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EA42FA3C9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91CDE303918C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB653C8731;
	Mon, 23 Mar 2026 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jXjZaRId"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF4F3C7DF4
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287104; cv=none; b=C2lm3GqPj5hrMWoRXh412krIjtxWSZGbRzp4T9wR6bboNcjmBG6X0uOHOak2TXd/G3kR7eM3lNwzYTdV8ipb8MrLOq30zwcvsnquYo1IkPBAmL8wSpYDiC0+oNzrNUSZKLkJiS++MJKcDUMoilw6WEtoaIbuuxNE1EL8H56GsbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287104; c=relaxed/simple;
	bh=mBhx/iGMR6MnTH62/x8K0OvjgYxObT0PTNXZZqCOHkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/pH2uY2nOVgpZm2ze/uRNGV72TOpktaz6QTOpopfvJGORvn9UoxbWHEusuCwNN6eX4ONspElSoLVtNV/0F1gzoc5qHv1CYzfvwIDlMY8Aco+ty0wBlF4bdQwubMxUa5clumKZf+N/Ty6fr6AYy/7/iYJ4q7Xbn7aEPvOFmuJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jXjZaRId; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64acd19e1dfso3699545d50.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774287102; x=1774891902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7FawmBPSYeihgLrf84TswLXrZodyF3L+TdguCBeUDA=;
        b=jXjZaRIdu22bGrftrd+cAzDRaHm3ZYhEcNyTmCeQbkAFpqxBn89Tc2Mvh5TScyrQnx
         g/wOwYTP3gy2UMR09ci8EtsdwNPK8qVtQ73Er/IGi/UVkCQzCavdEhiTnIzKuYo6ARyx
         88WI6ftq5ZlrljHVPXdJ3PTUWAqlBqxAR51/QCFFjBGs99KUKxzV+tt/tnp2xDMrMcd+
         EFn9tGStZztHiMAiqbzabwAJb+uignTqRxmuFRq3tPX4pbpjjAftuKeo3x1Jd4mb6mea
         /IhcTsD7oKmE/tkpN6mkRTtW7yMkdbjhbgFtkRzpT76hKFLvjPdJ1cguLtyVzQThccoG
         WRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774287102; x=1774891902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7FawmBPSYeihgLrf84TswLXrZodyF3L+TdguCBeUDA=;
        b=qJjdA/gMGqpw8+9oxjrXGKFqCvYAhXQhqacA54fU9Q/2cFmb8OITrsWqNxjC78WUXe
         vkeqteH6m7S3WrRTj9fGu04zZPd6CMhSvdY6QFlaKssw32gm9wVzMyk0kpnOSby9LEwV
         Xu3cGxAazDcsWowNdjR8Uw/XGVFY3lAVokzxF9zsXf8GORvqQSFU2pmYSKrn2lcIsNgC
         B1Nm6AMn2aXjMdESezyDeI5hn9iUbl1y8+MvnmM0boSAt6HPDY6tt38jdayWySGwlM6O
         ofzmq+DeUMgxe+YB6FJ9WAn9ubzZd9ljViMddaIUG76wDByKa7xhguq0ADhpmhT2VFUE
         QwZw==
X-Forwarded-Encrypted: i=1; AJvYcCXsO7rxyUYsO3Tc4V+qm6vwJmCUoFQP3Q11NtvR1W/3v99CPKcNTO9AoatoqErZZr3vEMPB2r8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8cSSoYM3ZjBKFDgCemMHx0DVyESRg1wHrLgbRe9ag9G7sTZnP
	3oEpZijvpLZGD4idC08TPIZFj5gjF9zqNPGEVfHPC9UBCn3Elnz2yXFk/wtofb/A1AQ=
X-Gm-Gg: ATEYQzwHbCEDi4BZ2oBgVDrLeTQk5MwYZfZz2OthiefAZWEtZI7U9TyuUrqjQxFg1vS
	bnNFJLl9ekSvp2bv0cuH4KKLh46iY2FQxBv5uewEMwdFGniucqGInmGIiAizLNskIam1K8cWiU0
	yD8wnxLC3tH+1PIpbNFqBXa9DdXpqTXiwUuD9OaLxGxleN4/wmMKmZ3oISvPJSD2iLHBYypYrtP
	HDwnwWr/CKOqVsc0z+1VCwsroYz7JtpDM4Y+5GzGtZuBFoKuUEGM66rz9S6ZstY/J/aIugS+wnJ
	ZQiLoZGm97X0Q5mbhS7pgP8jat1I8ZrF4M1ZWbA+3WLBBwJaQyvZE0AMqjm+wi5+oRZpNoSqmXW
	O+/XKrzLNHz3YcfVWA6+7rvrJqcIB01KbO1hpgEbRMBwM3oxYcS7y15amEWcjUTH+waHBpTI0Ba
	XFBwVsWzs3fEF5l4+Z/THtRdvJIeIw7fjZ9bIjOYwdb7du0O6FAQUxJXAfHLOtD9Zkbx4a2Q==
X-Received: by 2002:a53:eccf:0:b0:64c:9a6d:66bd with SMTP id 956f58d0204a3-64eaa6a2105mr10583694d50.8.1774287100249;
        Mon, 23 Mar 2026 10:31:40 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36d071aasm88833571cf.11.2026.03.23.10.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 10:31:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w4j7q-000000006of-48OA;
	Mon, 23 Mar 2026 14:31:38 -0300
Date: Mon, 23 Mar 2026 14:31:38 -0300
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
Message-ID: <20260323173138.GB8437@ziepe.ca>
References: <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>
 <20260323135414.GA8437@ziepe.ca>
 <1062b66d-e4d0-4eee-8fc2-dbb65491a01b@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062b66d-e4d0-4eee-8fc2-dbb65491a01b@linaro.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229984-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Queue-Id: A1EA42FA3C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 06:46:39PM +0200, Tudor Ambarus wrote:

> Downstream we have a display controller that's using:
> 	iommus = <&sysmmu_19840000>, <&sysmmu_19c40000>;
> 
> These are 2 distinct platform devices, they probe independently, they
> each call iommu_device_register() independently.

Sure, I guessed that is what you ment..

Do you have an example of this in an upstream DTS file?
 
> If I understood you correctly, the downstream driver shall model its
> architecture and call iommu_device_register() only once after both
> devices are configured.

No.. I'm not being so perscriptive, I'm just saying that once
iommu->ops->probe_device() returns then the device is fully setup and
dev->iommu will operate all of the iommus described in iommus=<..>

probe_device() cannot return some half setup device with only some of
the iommu instances working.

We don't have any core idea of a half setup result from
probe_device() today.

> If the core's intent is to strictly enforce a single IOMMU instance,
> shouldn't iommu_fwspec_init() be checking
> 	fwspec->iommu_fwnode == iommu_fwnode
> instead of matching the ops? Because the core currently matches on
> ops, it permits aggregating multiple physical instances with the
> same ops into one fwspec.

The driver is responsible to handle this, not the core. It has to hide
this mess under its covers, not rely on multiple calls to of_xlate or
however it has been hacked up.

Probably it means something like of_xlate/probe_device has to
EPROBE_DEFER if all the instances listed in iommus don't exist.

Jason

