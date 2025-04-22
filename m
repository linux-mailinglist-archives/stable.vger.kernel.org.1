Return-Path: <stable+bounces-135170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF117A97538
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3817717EC1B
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD8A29898B;
	Tue, 22 Apr 2025 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ysk1dMhY"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F171ACEBB
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745349358; cv=none; b=FaqRylJqzpu6fbOiz95rFtOGE+1Ik9uvZ3+T4J56lGwQBrcYlTa/BWxeOX0+hxznLGDyfGcGOqFSlGJ3mRCapQ5aDePEFjBvGTgOIIIE1SJE7ztG2RcFbNz8WVN6uxYJgfpfy/+IC5wXEjvgeQuxNPj20kueiRWMzlegZPW7dbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745349358; c=relaxed/simple;
	bh=jB3to8XLVxQJ5LgCGbXnmbBfUdZvBo80bwAjGWX1FM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4O5xXM4C2BaBU6swK6AuIOtpcYzYGmlvYnDGiN93vi7Qop8bN7Sn1aAP1ON3YSSw3/g1FWIR+wfD7KFzDelOvtiMrXzmOtbzTE08TiwtO+JAvS9HiWUN8NBI1WNzIVIicIisSmqo/DiKn+Ha/AX+5M+0g/wZ0TH2/V6AdX1aHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ysk1dMhY; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8f8657f29so51783686d6.3
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745349355; x=1745954155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7d1mGroBPaOn9o0uqCQCDJCnumJpud9iMfGSCI94QIs=;
        b=Ysk1dMhYPUGZqQcPAZ/D8UqOUMiRpD3LIgqYyCP/LEHR+9GGF8UuQQrWKyAGcrUE4J
         ZVJsI/nh3Ndh28xLyk/sG41nCvIOPrC1gAZlELPzargtPenhGx/K6zFIVN4OMLNdrtW2
         tSpR6A30ST/O3rLOExRoRsgAjd5XJqvV8SmGoosl9XTm4bmaKRN41Yua/ZO4yEblHlCy
         khOcUR7LgpZWrUUfhiZC3Z983AYDLQqDUJj1rV+9GmoQa6lUVEErjjmxTanUeXTl5k69
         MYsx7pMnduU1+wqFHJHrfzwB62pCweHAMuAJ0NTjDJs9AHrB0+asA+LfcwPoZYk9Xyyn
         Q5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745349355; x=1745954155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7d1mGroBPaOn9o0uqCQCDJCnumJpud9iMfGSCI94QIs=;
        b=jz6NOqmwmu7DF8X2pIu2v5zwjNWV6PZnbG2zILctFWmDp2eSSIN3kH5rLV/ozM2qoK
         CoVu7z1efSM/dpVCvrrrBremdLDQL+Ft8uztgsc0nI4aQDsYh7iG8HbpKQp2cwMFIFEU
         CdrYW0W59dTpyA2a7T6LzmX0VLbo9jnx6GVM4PjJnWH2dV9YpDd7FJdP7/gm4Ii88z+f
         bol3JB8C3Ti9x6JklhkmSWCAUu3GcCMZCAqhOpbJ03jGF8O4UyQpl3dBppP58xWolroU
         HCN8FgzI4RtrcOwPwenKCNW1T02mGwQLurcuLeLFhzTQka5NPOm/n3D5AuOwt7/pjZ+i
         Ymhg==
X-Forwarded-Encrypted: i=1; AJvYcCUWZAH/xA16Syhxv+JFbucibVbf7LBzK7tiOOHLA3mzQrYtiMOjKufPP0RoTyUO5jnXLvK1yiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzycaJJ3mHbkqIkpuQ6sjGHK6iXL3sZADhfWLShGND1haAr6ocA
	OwsOqkaeMEfKh7/ZzynmiZ6oBVqNbnUOJPP7a3L7C3cnsLiYxAPF+L7CJ4jiNyH/YQ4A0ia6+jw
	a
X-Gm-Gg: ASbGncswb4JgQSUxDBQZMK+iN32JLIIV+VTFMBFUmxvxl7hDqEC/a1G6YuaN3kVYnqT
	FILnsdU5jAQ/7KmwnpW3gL+AVTlw5X9z8jeZfloRDshsdk47TZVJM/PyEfpPRL3o4kf+cdw5HuD
	cMq4m0I2SjEhMVhRn1eOK+H5UUh2YqL120/e2MVuBI9pHxcC17wseXcqKEJsRcAetIkcjYfYyWl
	1id4KaMCFtxJ6pO0uJ40nNoAUUX+1QPC75vZpA4uZrWF0fzuAzOtHWApLcOCpdoeI63Uc7Hp7F5
	2RnPXBy5c1P1fSbSJkqSnKs2MkLYuRTq2pfkPPTtz5AtAmyV1CnsaO5Jrquhdq367ttf/1QGu1c
	zK6ucIqdsxV13sYWmyRQ=
X-Google-Smtp-Source: AGHT+IG42qweyJjGbw7NVAt4l3iMAAjkcjftIU8iawlPjM1u7hmAqwA2QfyxHlkDQd215RnDOqjHbQ==
X-Received: by 2002:ad4:5f07:0:b0:6e8:f464:c9a9 with SMTP id 6a1803df08f44-6f2c44ee6femr255140626d6.2.1745349355218;
        Tue, 22 Apr 2025 12:15:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b775c1sm588323385a.97.2025.04.22.12.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 12:15:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7J62-00000006vnm-1E8m;
	Tue, 22 Apr 2025 16:15:54 -0300
Date: Tue, 22 Apr 2025 16:15:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, shangsong2@lenovo.com,
	Dave Jiang <dave.jiang@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Assign owner to the static identity
 domain
Message-ID: <20250422191554.GC1213339@ziepe.ca>
References: <20250422075422.2084548-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422075422.2084548-1-baolu.lu@linux.intel.com>

On Tue, Apr 22, 2025 at 03:54:22PM +0800, Lu Baolu wrote:

> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cb0b993bebb4..63c9c97ccf69 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4385,6 +4385,7 @@ static struct iommu_domain identity_domain = {
>  		.attach_dev	= identity_domain_attach_dev,
>  		.set_dev_pasid	= identity_domain_set_dev_pasid,
>  	},
> +	.owner = &intel_iommu_ops,
>  };

Is this a systemic mistake in all the static domains in all the
drivers?

Maybe a bigger check is a more complete fix:

static bool iommu_domain_compatible(struct device *dev,
				    struct iommu_domain *domain)
{
	const struct iommu_ops *ops = dev_iommu_ops(dev);

	if (domain->owner == ops)
		return true;

	/* For static domains owner isn't set */
	if (ops->blocked_domain == domain || ops->identity_domain == domain)
		return true;
	return false;
}

Jason

