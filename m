Return-Path: <stable+bounces-116438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F10A3648B
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 18:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9BE3AE702
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C3B2686A6;
	Fri, 14 Feb 2025 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ueiW/ucT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A1A267F75
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553943; cv=none; b=d6W2qxmOLvzbnhF1zE9WOCqLA6qVCuK7CSrZPgJOCv8UqhzVWnJvWoESJIJ7p7jZ++fwpjFYfwe/1nHB8NIblwfoD0t8ty6FHTGCwb37rI08fVlU4gQtEzIhVNEd32bNNdOKV2tkfJpZz1wLzHdjbgimG7cgQHMo+wAfEusZxHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553943; c=relaxed/simple;
	bh=03iNdRn/em6uG2YPWo02GDuzrIUhH61RcLmXWAh+IJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyehBVgtVS6BNXiezcNb5b8MPpEta6XHWJThoeBwKhjEeDQPBEpfmNtc6TL/TfJy0oFqYPjtBTMl/pEHQhrdW9PzC4ALDfJC/6vgSX/UuhNAsKKsr12TPKrvfqANSgqUJEc/UeeNsC2r/9kL67LKIoTg+tBsZIDuySKWwVLV0JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ueiW/ucT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220e83d65e5so30626115ad.1
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 09:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739553939; x=1740158739; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PsirFScxxlndbt5JatVVlLCyI/9U7Qi8qRIjGd5HNUc=;
        b=ueiW/ucTQtgc4um94ARRu735GLAsAU0m5XzRxAtvHA0L0VdBCcqhgNHdVJUjUQfuhM
         xfa9LMf5t1ZAzQNH8A/2bxUi2qLlCRAt9jRH4xk0J3+wDRuICz+U9wjUvQXcalzwxmxw
         DZx4spOKOV3BNQ01KywGu0rhxSM8ARaVkX7VAkeSRJ9rdjUd8fNjbTUA7V+wu5yKm3mw
         2fuk+PxfpwHcw/Z7CGrf2+gLq+MbhwX6bjxp1uH3A/Qu4LKw9SMQex/WAOAHMOeVKRFW
         eh5gOca8kbCKZ93bTWGIsoA9SJN9EDL5gJs5xA4ti3aFVYio+3ofo0yveBm0K4LsTCJW
         z44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739553939; x=1740158739;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PsirFScxxlndbt5JatVVlLCyI/9U7Qi8qRIjGd5HNUc=;
        b=KAvykC0KwBaP3q2FLPi82AgclxHRVVvksyBKvkXNpiLOjebmOidoe2by8FyEId9JjL
         yNAQZX28eE5SOp0cQjaWqjtJCtmCAc8kPpEs9QvqW2VqE8VkU9tNLRQt6F/N7CNk8sYB
         1sQe2fFwm8/yquHScyDND8sGiGrDNEObzC6cha4aXfESalFKqYX3J0EO9xcbOUK3Y4ND
         6E/ti3y4ohIAZXPr+sQ41T3ux9MObDBmLdt7lZVlrUH2qMsttep/tiu1Z0yRj6Qy1kdJ
         8ESetyBEvhmQZQlVTjBd1CxJbYv8FvhFYIC5IL9IOOGz8oesadE3mNv+IDJ6qhJgIZrm
         eEFA==
X-Forwarded-Encrypted: i=1; AJvYcCUgW7iRBB3GNySPQ9wL2bZmjCHxIgwCFLBZxNASQtWMzHJXLz3iYUuRyROquEP4UZrPUMrdFUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJbabZ2l7lmjCvGAUXNW/zJ2RrOodIWVxv3OaetKDcegLhvqkM
	Kmx3dhr+OtVtLc15vR84Ht8OHor91GpXagI7m1Nb5CK/Z0rYJb3/5W5hkOoqvw==
X-Gm-Gg: ASbGncv6bdPbsRRE2v76KXnvYj998FHqXa2r2VCRkVRtkL8MbXDetdKGiam7Xkn/YDz
	+brdvFlAWHiV5+NPHzGzNLD1RGD7Pq89Us2JgFrMvmZZFmjayoyeVJ+PaTvn4B+sbg9DgSxO686
	kgpy6xuSIN+9KgsffkS4LKg2VlAcGBsjmq0CB9iMi+zUvqDT4lnQC9QWl6criV/9s4LyonSTKHP
	XS5AziPSednOeaf0FDW7PpxEh70J/1oNn5E7IQ0zuNJoWkO6uQrdIJqaL+URBEWep6+06O2ATgx
	hlKZVEeWSSjiDJZj2pxSxckzQyg=
X-Google-Smtp-Source: AGHT+IHzsapv0KPmsdonjwOxgJKB9jp9uj1Hj8zr7WwtL9knFoK7gwoAa5VsROZGsAdMi4C1EOACoQ==
X-Received: by 2002:a17:902:f984:b0:220:c34c:5760 with SMTP id d9443c01a7336-221040c0c61mr230215ad.51.1739553937978;
        Fri, 14 Feb 2025 09:25:37 -0800 (PST)
Received: from thinkpad ([120.60.134.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d0a9sm30993605ad.151.2025.02.14.09.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:25:37 -0800 (PST)
Date: Fri, 14 Feb 2025 22:55:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Krzysztof Wilczynski <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/5] misc: pci_endpoint_test: Fix irq_type to convey
 the correct type
Message-ID: <20250214172533.szrbreiv45c3g5lo@thinkpad>
References: <20250210075812.3900646-1-hayashi.kunihiko@socionext.com>
 <20250210075812.3900646-4-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210075812.3900646-4-hayashi.kunihiko@socionext.com>

On Mon, Feb 10, 2025 at 04:58:10PM +0900, Kunihiko Hayashi wrote:
> There are two variables that indicate the interrupt type to be used
> in the next test execution, "irq_type" as global and test->irq_type.
> 
> The global is referenced from pci_endpoint_test_get_irq() to preserve
> the current type for ioctl(PCITEST_GET_IRQTYPE).
> 
> The type set in this function isn't reflected in the global "irq_type",
> so ioctl(PCITEST_GET_IRQTYPE) returns the previous type.
> As a result, the wrong type will be displayed in "pcitest" as follows:
> 
>     # pcitest -i 0
>     SET IRQ TYPE TO LEGACY:         OKAY
>     # pcitest -I
>     GET IRQ TYPE:           MSI
> 

Could you please post the failure with kselftest that got merged into v6.14-rc1?

> Fix this issue by propagating the current type to the global "irq_type".
> 
> Cc: stable@vger.kernel.org
> Fixes: b2ba9225e031 ("misc: pci_endpoint_test: Avoid using module parameter to determine irqtype")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index f13fa32ef91a..6a0972e7674f 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -829,6 +829,7 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
>  		return ret;
>  	}
>  
> +	irq_type = test->irq_type;
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

