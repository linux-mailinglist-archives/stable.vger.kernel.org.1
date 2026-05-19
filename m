Return-Path: <stable+bounces-249613-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEr0CoV3DGqihwUAu9opvQ
	(envelope-from <stable+bounces-249613-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:45:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28051580C45
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04518309A53F
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E3C32571D;
	Tue, 19 May 2026 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iIAJb4aL"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19EB280331
	for <stable@vger.kernel.org>; Tue, 19 May 2026 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201029; cv=none; b=Ea/hI0zWCWYEL1sV64TLsF0DvBMYFS1cyaW7+CBKxMSlsOqxBJqE1jAGKgLoJh6qlX/GLCqS+DlHKnypdRtE0P1P+JF6FCcHaen8wJ+TXe9Dny+CMXXrSQ3VV82ZqRhsn8DVXL/j0S6Sbe8d+MierCK/YY4h3YezqZF4+0Nu2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201029; c=relaxed/simple;
	bh=xVlYxYIeHhvu7QE0wN2skagDW3LUz6aqOlnUqRxJNac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYZL59ChExr1TUqRrq7EXV71qy/UHXZMKBhCrhl9853BjB1l3GektauTczdXj8hJFsobmm4uZY58Z5EGD6JajdxePNaXfacJ+8dJUKfXiMj3Xkv7WfC3AY9UbvdGAwcr9nV/d4cPPb9Sjn4AbZPzikMjxkSZ5WH6NrDJEY7KoTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iIAJb4aL; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8b821f39a12so38846826d6.2
        for <stable@vger.kernel.org>; Tue, 19 May 2026 07:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779201027; x=1779805827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kaAsMUfND4CCo/Yp/chnDoXFX+KRgMMX2KDfI9OYfN4=;
        b=iIAJb4aLT5ZKY1jGe1Vf6EZpPanjedpi+yi73vDR2yTRkM/MG2S0WOo4FTbevkvG6D
         kYGV4e9H7Wo93jnTj5C8I2mY4d35jLRisujo/nn2DGnF/FdxgRE/smwC6F0eYpO9vOwt
         CH11U2FHxa5rTEsXEdkKlbThln3/ApnMd+OGZcEu1jVwhOuxITVZoVbdrbwdQWa3Q+8/
         OYbJov7oDc2GeUtcosGG8Zy/T+Bpum2sRjD5aZUnA+Sndr0qO1Ekrrz3xcXKOA4N1jqO
         MYznOjjILm2J1tfFSRVP9dUej5eWj+4i4akF3o+hljs4tRttZPPXTKXULwMiuSA/6jng
         tyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201027; x=1779805827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaAsMUfND4CCo/Yp/chnDoXFX+KRgMMX2KDfI9OYfN4=;
        b=pWivNGESDBQVBHiFz1KJWPNRVEvLVNwdHIKl5pMBjCWKRLF9Yq0tNtejgOZqCZOsJZ
         6dFQqOAvIlgGTWb7EiH4u2DCA40VKX48b4jiu/uArYjUSH1C9TiM89PZ4UyIjoRFPF+Y
         lunaShB1Qvc/bTR/RgbDj6c0S8EpFhPiq5K+VDXLWtbhTARx2sinqEQmjD2xb3AsxzF/
         tDfysSSxqLLlfeg32CDZ0G4OqV8dsws4Urjm1QwJoPeCarbtf022gbA85HVtBN8dWdSU
         dh/l1X6CCThWEZqAq6GbJioT4acWTn8rj2ihr/qYAWiWGJxazAs5h7m3RvMLK2do3zFw
         iJGQ==
X-Forwarded-Encrypted: i=1; AFNElJ+WyxGazauwx1aslrkQRpeZfKyEXRWhcQ4N4yyLPdqvyGdr+6jhyyTvypRAkXaPQrToVeYWgcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHvCvbPf09fEIZ0wqauY3obvo5pyJEgttG5/yuBftdxeeNSOID
	MeNvS2GaE2OTWMTF+sj5IaEqZA3ooOE080//guzjnI5b0eotYbvDu/l4KReDon7DeTs=
X-Gm-Gg: Acq92OG48OOwd8s63DpkTA1omTN+5SH1cZrPZ5yCFberlxaAPjZD9gZ8A0fj143qfnQ
	9Wy9tivtECLKdSj7Vddkz3nCBEObqldfx7IX7spui1IAJ3sb+SkRDg0Q6/0pSmr9gJ0otoUwFr5
	dEDWGVnCndjF8yqJM96+m2V+CrwzQszZ7HB/hPUGyZD1jgAvfMXjEiHonT6UKffiVWj9uEFYtGG
	v+q1ncnVzhcX93qg3OfBi8eHh0vwUmmY1FpxRbAtZ+zRoQdk0xtozqUu2sT2Xs6epB0uE1/I9mB
	Xf6YAYocVPe+VGXv0Riuw5tDSMLmNEB7K8lU9uZaX9ovN7yNcm+NO6a+HLchiA9VCFieKhJsWyj
	C3pMrfxjAjYuWD9qm2MjRhLytyZGgOTaN82hv9HNi5eoSzW6oitYDrMAks/7hDrYwsZGAXCt5IQ
	fdYTWtDWYvUJTDyLoBXHrqovEj2vu9nQK/Jdtz8nfZvhA5r+4wDyTqa2vWAwZQ7nLDwMF+cK1ak
	QeWm+PyT5hbP0g7
X-Received: by 2002:a05:6214:46a0:b0:8a5:104b:e361 with SMTP id 6a1803df08f44-8ca0f6f3944mr322587386d6.50.1779201026652;
        Tue, 19 May 2026 07:30:26 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3608c1desm91696546d6.2.2026.05.19.07.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:30:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLSj-0000000F7UP-2wvG;
	Tue, 19 May 2026 11:30:25 -0300
Date: Tue, 19 May 2026 11:30:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Heechan Kang <gganji11@naver.com>
Cc: Brett Creeley <brett.creeley@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fwctl: pds: Validate RPC input size before parsing
Message-ID: <20260519143025.GC7702@ziepe.ca>
References: <20260517062232.1858747-1-gganji11@naver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517062232.1858747-1-gganji11@naver.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249613-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FREEMAIL_TO(0.00)[naver.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,naver.com:email]
X-Rspamd-Queue-Id: 28051580C45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 03:22:32PM +0900, Heechan Kang wrote:
> The fwctl core allocates the device-specific RPC input buffer with
> fwctl_rpc.in_len and passes that buffer to the driver callback.
> 
> pdsfc_fw_rpc() casts the buffer to struct fwctl_rpc_pds and then calls
> pdsfc_validate_rpc(), which reads fields from that structure before
> checking that the input buffer is large enough to contain it. A short
> in_len can make pds_fwctl read beyond the allocation.
> 
> Reject pds RPC buffers that are smaller than struct fwctl_rpc_pds before
> parsing any pds-specific fields.
> 
> Fixes: 92c66ee829b9 ("pds_fwctl: add rpc and query support")
> Cc: stable@vger.kernel.org # v6.15+
> Signed-off-by: Heechan Kang <gganji11@naver.com>
> ---
>  drivers/fwctl/pds/main.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to for-rc, thanks

Jason

