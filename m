Return-Path: <stable+bounces-254409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDyCJFPgFWq1dgcAu9opvQ
	(envelope-from <stable+bounces-254409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:02:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFC35DB209
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB7CE301903B
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1884421A17;
	Tue, 26 May 2026 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="uVUtwJ5c"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1789421EF3
	for <stable@vger.kernel.org>; Tue, 26 May 2026 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818432; cv=none; b=hRmLwSp+ELkfxuZ1qXlzIMX8p6jtE/CMl1YCqvwG1maOABzprGQs7jKTB/YSDuYWr2jurWxlj5PFQGODKPfrVve4X4dZA5Jasmsb9TkSzvA7bjN8+s5/uONZVgpwlMzlNSKsFFscKnxFDMQhKcWhMMIe90bgB6IFOAdThH+E7no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818432; c=relaxed/simple;
	bh=ENkQi6euUmUGVEXmwlJ89lIFxUgKslc0tIyvgXY3bNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCMzPFtkfozODhr2P1PkpB54L6EG8BCHkODWztN4vebB4XVq5abhVyG6uNyTEJNEi63B2zkMpwCL+HaDcYh3Ov9rr0mzA+1qTyHH5dZfVd6g3o9XIvKw8krLhMSZgDQ8+ydYHFM3OLbgmU3S1K22UuEyqzrHHXLqtNLs5+Pnvzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=uVUtwJ5c; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8b8e98fd885so136297746d6.0
        for <stable@vger.kernel.org>; Tue, 26 May 2026 11:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1779818430; x=1780423230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rSgt6MfvA+HgF23IzFWZTOY3R54ZXJy/qOp6XyOSvoM=;
        b=uVUtwJ5cdSnw48aY8xnuw5ymCEsh12i4bv8A9isCeQXvsEKGLibVn4A9MQW7DID0Bv
         jGFb6RCXObrjXUlXo7pfu0/pPwVuzDz/2gr2NMF/hTIKkOCCWEDASDVg+yPiYzNBp1zO
         IcdiYL0cxwSV5qEjc6WkJA4OfG04ZJkP26TskQMipfgGiB08iqEU6yqPfFfQ7W4XZuQC
         KyGCsoJdOZQJkpurvRVpu67RJ3mSEuXFS4b+lemD4Qyf0zRl2x2JkZmYfTiZkybuAmsi
         C4l2HrZgSGO2PtkQpE9RKQ1NU5FP7EkLMHCGy+ptwGJ8YoZteZ5wUsjSa/QcHPXKvk4E
         mrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818430; x=1780423230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSgt6MfvA+HgF23IzFWZTOY3R54ZXJy/qOp6XyOSvoM=;
        b=aK5Wmeq5PvBJAcaheAgNclDvOLBr3Cf5h5UGYJwwbZkGwikcMHa0wEoYBu+k6R5W2V
         yrsLdtdzdxZHHHqHEdvoiQ1D8pvmFIXKDdlgcmLRsmUyd6D/kJdhCP1nhEOSNXkWkryj
         RzbTVdu+W/F2s9+eEqsjHAZz+/JEpE0S6MeIdlyNjwBPUuOSo0JU5YI8LGzy+3ZR0MLK
         KRnWWh0VsyGd64JNRkEszl4Zyu5yVT0/rxNE5Kj3XvUzpQeZYcjHk5+z/ysduQtQGrhO
         GjcOabxyLTFulx+Q2yUE4VYgjKGdRHPWtGoSRgjs19uEp5MTbWotCr+OtFFklfi2R1nT
         +FMQ==
X-Forwarded-Encrypted: i=1; AFNElJ+2pymBTQcK34iJe+oXtqfKF26Ht6k9+hf3FVdm1hB8mGzYcmKJimOBq8+HKdxZsiNeHakGZSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtMO14gyO6Vg6V/rhLKgwI/AtdJ1GLf1/Nz1uwYGrt2uOkd7Ly
	S/J8Wz/5aW5wNJfIMVlohWQLMk+XgOp8SUYKQJW/6H3P3RwkUmX1DRw4Z5CamYUqi/Stiehv7Vr
	5dOc=
X-Gm-Gg: Acq92OF+VwbmcGYEzjDdbFsGYkHtn9DvLF+vE+BPLnpN7MsUPaio7r0x9/x5Zc9lVG7
	OW0PS9Sjnez7PHrUKlIb/CY9sPnJ5hwT8uZd8rfiIcANMVBITC6U4KUQzW0L50nX5gPW41qBNdH
	9tgBVI1MZMbi3sp9/1f8a//GG+ubxnGcOTlSgWYmFiIsj3X7CHoIzAea/2gc2nP4cDBC7PTNx5o
	DjlYSQHomcZTC2bZM3iKXlE1W3Jxnv5vG9XcWFTaoO9LAG6hXzCs4ani/iVoHhmbRbGRb+VP7Il
	AHFggqbZ6+0g4nmBmynQ/eJNbbvdkidBra7xVXNcld24WbAfVDYaVwUy6odepvkLz5iLOYYRpzU
	NMZP6XrXy2mBh8nf/CeN3uQNq/DMNQ4q8CpLKDAHV5UdDjGNBE3ZRtpZutpMiYi/+XsKWf4YGIE
	yD3Bq6TaeOr4c9M8cIqUTEyTpcsaklyc9oU/qq2EcfnbICLqLUbxM7AyZ/5X2Iuofv2yI=
X-Received: by 2002:a05:6214:53c1:b0:8ca:293b:bc3c with SMTP id 6a1803df08f44-8cc7b4f1f5amr342749866d6.3.1779818428972;
        Tue, 26 May 2026 11:00:28 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:349c:f507:d5eb:5d9e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80ded529sm147738236d6.16.2026.05.26.11.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 11:00:28 -0700 (PDT)
Date: Tue, 26 May 2026 14:00:25 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jimmy Hu <hhhuuu@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: udc: Fix NULL pointer dereference in
 gadget_match_driver
Message-ID: <1f7a7bf2-4d21-4944-9da0-36082d052b25@rowland.harvard.edu>
References: <20260526070635.839701-1-hhhuuu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526070635.839701-1-hhhuuu@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rowland.harvard.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[rowland.harvard.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[rowland.harvard.edu:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254409-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stern@rowland.harvard.edu,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2CFC35DB209
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 03:06:35PM +0800, Jimmy Hu wrote:
> A NULL pointer dereference occurs in gadget_match_driver() because a
> race condition exists between the DRD mode-switch work and the
> configfs UDC write path:
> 
> 1. The DRD mode-switch work invokes __dwc3_set_mode(), which calls
>    dwc3_gadget_exit() and subsequently frees the UDC device name via
>    device_unregister(&udc->dev).
> 2. The configfs UDC write path invokes gadget_dev_desc_UDC_store(),
>    which calls usb_gadget_register_driver() and subsequently
>    compares the UDC device name via gadget_match_driver().
> 
> If gadget_match_driver() runs concurrently during UDC unregistration, it
> may access the freed UDC device name. Once the freed memory is zeroed,
> dev_name(&udc->dev) returns NULL, causing a panic in strcmp().

I don't see how this can happen.  gadget_match_driver() runs during 
probing of a gadget, which takes place only while the gadget is 
registered in the device core.  But usb_del_gadget() calls 
device_del(&gadget->dev) before it calls device_unregister(&udc->dev).  
This means that at any time when gadget_match_driver() can run, the UDC 
device name must still be allocated.

You should run more tests.  Add debugging printk() calls just before and 
just after the device_del(&gadget->dev) and device_unregister(&udc->dev) 
lines, and inside gadget_match_driver(), so the tests will show 
unambiguously when these things happen with respect to each other.

> Fix this by checking dev_name(&udc->dev) before calling strcmp().

Adding a check like this will not fix a race; it will only make the race 
less likely to occur.  It won't prevent the name from being deallocated 
between the check and the strcmp() call.

Alan Stern

