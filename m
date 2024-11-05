Return-Path: <stable+bounces-89840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 791A39BCED2
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 15:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317681F23A68
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 14:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBDD1D88D5;
	Tue,  5 Nov 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="BY8VnCCf"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72C51D88D0
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816027; cv=none; b=KYQux+/k2QeFsQ4c7CCD/Eutw1LKsJrRYwKVbH7xDvMzWMDeWg1g57UNVPLosg6PBU7lkRzsprr0K8KwQcQDNWGT7w8BZPFkFce8FYT4nMo5oJDhoaowUvTrPodrTyigeUfkTUow9bxYKmtX0sePH5RxOVd0HiOmDvNaJaDRq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816027; c=relaxed/simple;
	bh=tounGA2esR/I0Qx0gP0xNm3ep/qLgCuQd4RYHr4tj0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk6D5tJl8ol54XvSc5Mst6nkz67c9EwThxjoH40bG9HLWcVGvEMp5397hhD5jcd+O8yE20lj4nIu8z5D2zAj1r0CmGr0rDaJAkOMghveX2R2bAhgzRkZ4CCTGjus3aEUWSlOEF1qysHOhcW2kZ7lmF66A0kychBtUVK+2cnNXrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=BY8VnCCf; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b14554468fso404450285a.1
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 06:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1730816025; x=1731420825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KDvNb87s9KcM7r3rmGm02Lgs00JVk1L5xBACfLVxSx8=;
        b=BY8VnCCfAjHP0hMi+ft8oXBHiepkJcbfP8SYTvdbatCSpi1at4Oogk8jv78XkWASNR
         QfzLhTLf7sY1W9bJSi49bbl+kEDFCKSJryIYZQjQnoeB+yJT379sKd2Wvmym9Cg+1x6j
         L/7XXAaH/A/Ra5gnc3QLAkF/vRDMZWbJEmBHCSr2F0OgZg3y4rcTTy1Dvw1KXBHbdGKH
         VH79ngMFUZA9g6WV4RfUmWM3tmcogsS7T1ellQ7n2qPVZd1pe39ZRpv5xQP4X09vB1GB
         h+A8HIHjCcVb0EaR4+Oj35i1W2jW7bjEzr4xlFgjc7m6GV2lLiCEoWod+ckI68P0eyrB
         bnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730816025; x=1731420825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDvNb87s9KcM7r3rmGm02Lgs00JVk1L5xBACfLVxSx8=;
        b=pV4KmFGrGAawZuqFFMjWS7WcdBAXjx6S8jRXJDUQ6Lgossc6t8WZNHYLQdN7jKbQuN
         VjU9CxQEKVzGSKdUvQMJAqlcPf4laFmQnYHxxV348N36G1aitloEPTBlfBvBUfGTq+xG
         g7gn2hz3SME/l6W8o6QI1L5bt3cr2wBPbEPbrGENxBu3edSBqo2NHHPD62tP0JaDQ/Ok
         FovqvA39BcqRimCk90s+jU5BMCSbg5PzB29Cp1O4Bsj2zfqh8red17UqVGwH9GV9Mv3h
         X947w/TUc1DbhUS7EX0zWQ9N5ATS6dgUGF/Oohm1XKeveutiCQQRmBJV/wcbh2LgP4d4
         nIdA==
X-Forwarded-Encrypted: i=1; AJvYcCWc95cdinFc85abj/f2Xo4SEQudniqQHRo8gq4CGjak2wBkU0RnVv8Fv9QHi2ZvakhkUDU1aOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDXYAxKYs2SXt2MhRH4SuCd2lbbuNYisTcLHAPtDnkobVxMr5G
	q44SDb9Y5sCkQDZ/Htgux06oe5+6Ow3HoZJW4oxFLHZ3BGZSGwg/xN56UHZbRQ==
X-Google-Smtp-Source: AGHT+IEeS3YQUgZzUmSS5oJ/G5Rru+wFnAHqViIxjS3AoWTOSVHCZQPx2yiQXOuxQ7lVPzKmAArePw==
X-Received: by 2002:a05:620a:1908:b0:7b1:5f49:6bf7 with SMTP id af79cd13be357-7b193f5bd5fmr4527852385a.56.1730816024762;
        Tue, 05 Nov 2024 06:13:44 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::dc3c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39eb799sm522324485a.15.2024.11.05.06.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 06:13:44 -0800 (PST)
Date: Tue, 5 Nov 2024 09:13:41 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-usb@vger.kernel.org, mathias.nyman@intel.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: quirk for data loss in ISOC transfers
Message-ID: <9265b40f-b803-4dd7-b6df-3e8cb510b07b@rowland.harvard.edu>
References: <20241105091850.3094-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105091850.3094-1-Raju.Rangoju@amd.com>

On Tue, Nov 05, 2024 at 02:48:50PM +0530, Raju Rangoju wrote:
> During the High-Speed Isochronous Audio transfers, xHCI
> controller on certain AMD platforms experiences momentary data
> loss. This results in Missed Service Errors (MSE) being
> generated by the xHCI.
> 
> The root cause of the MSE is attributed to the ISOC OUT endpoint
> being omitted from scheduling. This can happen either when an IN
> endpoint with a 64ms service interval is pre-scheduled prior to
> the ISOC OUT endpoint or when the interval of the ISOC OUT
> endpoint is shorter than that of the IN endpoint. Consequently,
> the OUT service is neglected when an IN endpoint with a service
> interval exceeding 32ms is scheduled concurrently (every 64ms in
> this scenario).
> 
> This issue is particularly seen on certain older AMD platforms.
> To mitigate this problem, it is recommended to adjust the service
> interval of the IN endpoint to exceed 32ms (interval 8). This

Do you mean "not to exceed 32 ms"?

> adjustment ensures that the OUT endpoint will not be bypassed,
> even if a smaller interval value is utilized.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>  drivers/usb/host/xhci-mem.c |  5 +++++
>  drivers/usb/host/xhci-pci.c | 14 ++++++++++++++
>  drivers/usb/host/xhci.h     |  1 +
>  3 files changed, 20 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index d2900197a49e..4892bb9afa6e 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -1426,6 +1426,11 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
>  	/* Periodic endpoint bInterval limit quirk */
>  	if (usb_endpoint_xfer_int(&ep->desc) ||
>  	    usb_endpoint_xfer_isoc(&ep->desc)) {
> +		if ((xhci->quirks & XHCI_LIMIT_ENDPOINT_INTERVAL_9) &&
> +		    usb_endpoint_xfer_int(&ep->desc) &&
> +		    interval >= 9) {
> +			interval = 8;
> +		}

This change ensures that the interval is <= 32 ms.

Alan Stern

