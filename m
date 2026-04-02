Return-Path: <stable+bounces-233000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKaPFglbzmmgnAYAu9opvQ
	(envelope-from <stable+bounces-233000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 14:03:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA7A388BF8
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 14:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4D973049062
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 12:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1F23D1CA8;
	Thu,  2 Apr 2026 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RL5RBUkZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D793CA4A6
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131209; cv=none; b=RmEHlJY8KXdT20knmESjFj0r7zZ48jnOesKwHVrSZ7xJUnrdVQ8K9LU06NjET2o6VqElAEA481dlvvPGqZ5xTgljTEgVtqf85SnAAq06fHW3XR6M08qISTolLga7aCxfEz3ECSbdxYDJsNLV6qmY4CGDLgpkLRYC6JCq/0j4mAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131209; c=relaxed/simple;
	bh=D8lrxleNO/ZsZ60xggEtDnqZrsg4llp225/xd/hr+rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBcURc/P2I4pbPviObBC5ULRH4QifubuZJMsJQQBNw2fDb+Bot4a+a7GU1pPCQ/qXUB0BExml+wq77zHIPKAl3OAGgQ2QWIQUxZvGXbDPjusNA0SgGyAxndOoaVqA2+dOVk4heBqgXLXe8pQ1sDo7EFX2rydGMVQ/O6u/tUCMFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RL5RBUkZ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50bc115f206so8077561cf.3
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 05:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775131200; x=1775736000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8lrxleNO/ZsZ60xggEtDnqZrsg4llp225/xd/hr+rs=;
        b=RL5RBUkZa9Xg4xqhpwHOH0r1sGq7TPlpCsMOXqnFkvTwTm6buGFMyQCmuLFDsyTkKI
         DBcazVbQdZ6sCod7dGuMHfUn3smtlLdpkjzefcfhithZQx7iOpmXQ0tQ0swneMQz29Ar
         4ypYZvdgRTVNUnQlzYUN9HoenDO1R7ocqSWcKFWzoWKBsQH29lzhe6whbGIJxRlqD9FV
         RWz0uON73Q/n+lArazvuKFVE14IdNguq5f8v3yrWPYO/p/Q5vxclBv6JxqGIkqERZWFv
         KAfNpuw8NlQBnRw/SeUkw3/WwdsdF9fTKzCTYGTdBnktqHAOBH+D4XgHXmlhkrejpPql
         MQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775131200; x=1775736000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8lrxleNO/ZsZ60xggEtDnqZrsg4llp225/xd/hr+rs=;
        b=hSeHx7praASHhNdhe03Rk9K8AHBxL3SRzrQHtRIqCPvuCBCEZJnF+zaCuerL/+UaGC
         XUI7MNfzh5J60jEvjjaOtPAc0wFX7yg9P6lM2CVDfDbrkW4HEBXhDzIzaMAA3rN1khJX
         uI+09tYrTL/ECQtGWLDPGUH9kSTIMHeE22iWiZeLphFXzik83xTIa7moe48C3o7GqPsg
         50aP0TsNWOnQXufE4mV8H5kSA2WTNyS6VDwzKYpn9n/R/cqqwllhWm5qCC1FTeGNYaaG
         HBZfD1Tc43Q6gk77rsAmCmZ4g7S4FE8GOdLkMFmBZU9+89lkKuZZqjS1hPuQck8Kmz1J
         ZWyw==
X-Forwarded-Encrypted: i=1; AJvYcCVI5GWo4lIMg+x13TjkgMonJK+SGEL2Uqmhsbn30Bt4zvEODbiNGxvcK8Pb8xa/2GR/4jJl1RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKtaXs77qr2cw0XDlLJj6KtuWCUJDmRg9THFSqbVAeQIz1P9Qv
	JshgehshmkYXCjsKUPRcSaJ6z4X5DGQs+F30idRQaRNbXRqONzoChwrZj7SYAoAm8Ws=
X-Gm-Gg: ATEYQzxgBCyH4lBtSP9A8ycu6Y3eQ2oiLPHyKR78TEsamomAIUD7rrUHPuTsVZ8uVWM
	7BKRal6hlHLgK3rA4EhpkArSJscFjaVcvoRPZSvYFcBTU2ygga4LQHBb7/ZwYW39XlM/IwNmcKg
	AzbsbXO3XLmwwRC7MIf8qdmhiHAhmLbkfaxNA1cAGHSV1saVbmjXT5C6J7D6I4BgAw0zoIlexcU
	jAXB7hvaQpJ9XP7RxAaaQGiu5IfKIuYzSx735ir6wW5XzTzu09B8fozI8tmHYTJTmPKC2iWEgFI
	z9Bl1oi2c+7KfxdcYBbn756Q4rCwV4jYFMiKgur0YtKFAEB2D1ap7EAeBWjVSS0zrHfjiUI8iHB
	hPAbnccKuUOll6Zg5kpfmnKOkhtxpvCqxxBrnMlAbi8E+aLAHDcvm6HFDkRorA7Al6xhe+jIzyC
	LSNIPbkvxDTYe5eiEmQ7dRUh4yk9+bXIfdQiYl9HyNUCoEdafS+2NU9RrWU9viHRCTFTWRsA==
X-Received: by 2002:a05:622a:1e09:b0:509:1f91:dc2a with SMTP id d75a77b69052e-50d3bd08c56mr95496201cf.36.1775131200416;
        Thu, 02 Apr 2026 05:00:00 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b8d9f7bsm21034241cf.30.2026.04.02.04.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 04:59:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w8GiM-0000000Blwf-23a0;
	Thu, 02 Apr 2026 08:59:58 -0300
Date: Thu, 2 Apr 2026 08:59:58 -0300
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
Message-ID: <20260402115958.GA2551565@ziepe.ca>
References: <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>
 <20260323135414.GA8437@ziepe.ca>
 <1062b66d-e4d0-4eee-8fc2-dbb65491a01b@linaro.org>
 <20260323173138.GB8437@ziepe.ca>
 <9892a17b-022e-41df-af1c-a2d684aa8db1@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9892a17b-022e-41df-af1c-a2d684aa8db1@linaro.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-233000-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EDA7A388BF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 02:25:54PM +0300, Tudor Ambarus wrote:

> I can probably track whether all instances are ready, and defer if any
> is not ready, but then I'll force the iommu clients to use the sketchy
> replay path, which seems like a bad idea, according to Robin's feedback.

I didn't think that was sketchy, it is part of the boot ordering
system to ensure that the iommu driver(s) is probed before the client
devices.

Half operating a device is definately going to get things into trouble
with broken/incomplete domain attachments at least.

Jason

