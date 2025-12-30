Return-Path: <stable+bounces-204249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E29C6CEA2A3
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9590C30198E2
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 16:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F873320A0C;
	Tue, 30 Dec 2025 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="qcZmRhKd"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E450C28727F
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767111827; cv=none; b=aVlSDTWTI2Jib+3cBR46Lwu9L96fADh1iG2AUv45b0oKf95Uj8AtEnebUoQ+rQdbN7DRdsOZi4H2lKbTsL8TkuSo9S9de/k66olDWWe34/8UzQXS4ZVMUmXgFmw73stYsgaMHNCWN/+9dQCTJFxdNC9/mg4z9DQsvZwPANJUbIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767111827; c=relaxed/simple;
	bh=w/UY/Tqc8nv76sUPAN4wSJGcnbTSXqungYAUKKX2WLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7P8ozsQy8Ylh7J8FuJd+rY3bnrIkBUt82iGCPxTpkUjjYFIlBAARH5mKTtFMb2J7SC+o0QFsVPcUjm5AzOGASQtwHNgi3M8++b5TbuIit5fpCi/ofi5NBJGAmRTr8UmgKWpsT5RYxdjLK7l9pB6HyQy30/Nu3IcHLO8x+aj3Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=qcZmRhKd; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4f8a6b37b2dso26453171cf.0
        for <stable@vger.kernel.org>; Tue, 30 Dec 2025 08:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1767111824; x=1767716624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L8ZJ6UdkcT8zvPOgleU/+NxmdakY1tW7lnTezQizIX0=;
        b=qcZmRhKdZ6mnfAJjB1e0ClRECcA7OcrxH30DlVqadsh83930xdAo4wda2YMJtYfH1X
         4jUM/eQKvSKSZ4AlEydCt4qDB0VWkNXWZxmYYUvGsTxzizY8lV9oEAvikFxd1O8aTgD8
         o9mL/riB1+zt2pc5VkHbruH9s9g7DYm0ApDUdrIOMgb7cuoeHdaNdHR3fZxATb8ZnUBc
         F2etNWkLXuUbLhxdNO3vGY2uRkazMaHlsgaudIfgAhiWvjJLVoAo0TfkuumHcQN2FeHa
         orXVH/HFjEH4G0vSFEnlPBVJMMYHo4mg+1vcqX1qsGYXvYznxRXocnUYJT0kMsZ0i58D
         MI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767111824; x=1767716624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8ZJ6UdkcT8zvPOgleU/+NxmdakY1tW7lnTezQizIX0=;
        b=VqkXKTkXjG0aBhrXWNCaIVHI+7h32dg8qfCqoORCkl7yhWNMji3Rx7dX2ONj/r/HLe
         ANUeWpWVybKlNjirmD00Uz5rLvc7Bjh1KkexMP94vTuYRiDz/6Htp5zuw6GWTuwzt1ec
         ZWIDpHQY6WK2kx3Hd0mJ2XIXCjNPD4BqkiiRoqosfmocedFeQ7ckzGyhfQqp6TbeV1YU
         7h+jaJ7gUAMwmop8EBpKC13pn35cOBaM3GJWC00vBIWte61Sp5wIJltK3LNqLnYjcH6C
         y3yCIfsZrCaLxLu+e6q0E++R9B9MLq7fJeDDc8Spb7pdZUsOAqzXG85RQWiPRJnktyJM
         kyRg==
X-Forwarded-Encrypted: i=1; AJvYcCVGpVhCFt3maIpiOryljMxcM3ZeVHe/vm50/piUJCqpWsNls9K9CsRVYEJR6wuUdMIoooAWcc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuJ4cHVpDoJyfwWEKTk5gzMe4UTw4K0gDT5WsGgvlP3J21EmUv
	6le5dCv3lVjg8mS0lv2dzH40pkqe8FQshGbphgj/KYslZpnfyYCEOeGVBEY5L7X+bg==
X-Gm-Gg: AY/fxX718p5OvSoViS7i8aQH1tmvg93HqGvVDvNLhfjOV694uG1XQNo6FxNUEqgyMH6
	360k5+luFojS+lqwFEFHOL+jPzgtg+mI7IieIrVNaINhj0YsoIGwhOq/m3h4BWQXPUx3O8F9wLt
	Ng1LDU0FRDgJYym5boLJ20JRzbJMaz9zp/S1xFyuzsDvz6ct7DSfzLUUqTut/Ozbv60VRH6sWRN
	8t4TkOS4kwk7wXCcQY938sWoiU8jqFG7vlQIf/ghFs0JIY94ozIwXMzHcBpxV4mOzfAoWa8VoSn
	Yt9ADgWE61Rkr7a+m0bnv8Bcvp/56bBpb26wli3+2hZd+v6JJxja9Yx7jV5NYFxt6t9svpCD7xI
	2WQBfzydxNPVx7GxqUuTpOr2YwJFn2HK03NUpw/cq3yWZz1iRGghianHOLG6uhdWJlgh8HX3gFC
	imFDHDugZhOlNV
X-Google-Smtp-Source: AGHT+IE4eYTdSnAyo5iG9/+4AqV9PlulJB/GwNSBfqZUk9N3H2dXBeYrhPObuREn/1kzzFbfj+tGkg==
X-Received: by 2002:a05:622a:1e92:b0:4f3:5827:c96d with SMTP id d75a77b69052e-4f4abd6e4a0mr583133491cf.46.1767111823755;
        Tue, 30 Dec 2025 08:23:43 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::7e72])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac531081sm254829061cf.7.2025.12.30.08.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 08:23:43 -0800 (PST)
Date: Tue, 30 Dec 2025 11:23:40 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Shengwen Xiao <atzlinux@sina.com>
Subject: Re: [PATCH] USB: OHCI/UHCI: Add soft dependencies on ehci_hcd
Message-ID: <af0e1bc5-d08d-4b66-9a0b-4c39f17a043b@rowland.harvard.edu>
References: <20251230080014.3934590-1-chenhuacai@loongson.cn>
 <2025123049-cadillac-straggler-d2fb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025123049-cadillac-straggler-d2fb@gregkh>

On Tue, Dec 30, 2025 at 09:15:36AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Dec 30, 2025 at 04:00:14PM +0800, Huacai Chen wrote:
> > Commit 9beeee6584b9aa4f ("USB: EHCI: log a warning if ehci-hcd is not
> > loaded first") said that ehci-hcd should be loaded before ohci-hcd and
> > uhci-hcd. However, commit 05c92da0c52494ca ("usb: ohci/uhci - add soft
> > dependencies on ehci_pci") only makes ohci-pci/uhci-pci depend on ehci-
> > pci, which is not enough and we may still see the warnings in boot log.
> > So fix it by also making ohci-hcd/uhci-hcd depend on ehci-hcd.
> > 
> > Cc: stable@vger.kernel.org
> > Reported-by: Shengwen Xiao <atzlinux@sina.com>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/usb/host/ohci-hcd.c | 1 +
> >  drivers/usb/host/uhci-hcd.c | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> > index 9c7f3008646e..549c965b7fbe 100644
> > --- a/drivers/usb/host/ohci-hcd.c
> > +++ b/drivers/usb/host/ohci-hcd.c
> > @@ -1355,4 +1355,5 @@ static void __exit ohci_hcd_mod_exit(void)
> >  	clear_bit(USB_OHCI_LOADED, &usb_hcds_loaded);
> >  }
> >  module_exit(ohci_hcd_mod_exit);
> > +MODULE_SOFTDEP("pre: ehci_hcd");
> 
> Ick, no, this way lies madness.  I hate the "softdep" stuff, it's
> usually a sign that something is wrong elsewhere.
> 
> And don't add this _just_ to fix a warning message in a boot log, if you
> don't like that message, then build the module into your kernel, right?
> 
> And I really should just go revert 05c92da0c524 ("usb: ohci/uhci - add
> soft dependencies on ehci_pci") as well, that feels wrong too.

This might also be a good time to revert 9beeee6584b9 ("USB: EHCI: log a 
warning if ehci-hcd is not loaded first").  Firstly, because it doesn't 
test the right condition; what matters is not whether ehci-hcd is loaded 
before uhci-hcd and ohci-hcd, but whether ehci-pci is loaded before 
uhci-pci and ohci-pci.

And secondly, because if the warning hasn't convinced people to fix the 
order of module loading after seventeen years, it's not likely to do so 
in the future.

Alan Stern

