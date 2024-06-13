Return-Path: <stable+bounces-50381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DF890604C
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 03:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC37C1F22093
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 01:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981E8944E;
	Thu, 13 Jun 2024 01:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bPYS9CqA"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2887D2119
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 01:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718241249; cv=none; b=ucQ5Fd29re+7Vw997BWUwSkU6T3XBVkYgR7yH7E/Yx1GQZ7o1UY4886KMjIX3NTwhRp9uf8UHu/wSpjRvZuYqeSa0xSdGUospTb+jGqCqQ4vePvGF97FXh1hv54jpDTLy1e47UzJdb/hXoNbOfkDtlLkYRd4X5SjJFPIwavkDaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718241249; c=relaxed/simple;
	bh=gxKbH9FKhtFnEz6x7ssuMAzRqBaQGcnaNGGIgyVwdmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QparsHskt5+6FmQ2M6hUoGDCcYyexbQpTp14p2MPfASf4mS6eCNvrPgAqKTd8ZPuUoI0sF2V9U1/v6QvhtPt0TF8ERVO6nQxmnOIWKIElE7yXq/RxXf+b2qUE0S7CvUS6qOuc4YM1GwWTEVUpwYMT4yHxGZKl+WAlPQJ2n/islM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bPYS9CqA; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso4387071fa.0
        for <stable@vger.kernel.org>; Wed, 12 Jun 2024 18:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718241245; x=1718846045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/f6A4FkXL/wAAUf4pCQGWv8NCQTP6EaG2oynfaeXBY=;
        b=bPYS9CqAhGDEymrryadSK/98J0YsRoRqpzwtFXecQ9H+4IXNAXOtWGIvVfIz2C8f1z
         +aVbezcdG2q0U8uwJElEBqeZrk9/7GJxU//+4hhID9QPWcNjyMMesULHFGa8IVMhan/w
         ylxs5l2Pxl8++uJz7aHTS6NCh5UfbRktTyvD43Dh9DUEjFdAF3k18goWnVO+ggVYwlI8
         FdunMzPpC2bylsQW9qJ26GJyDwuaw/DFvd01NQ4xco1tJqifaYIntKKqZuc64CMDy9tK
         c1EoHQo6aYJn32yVcvMafu1STGAQmg7NfYKfpLpJdsQurALuw/hld1pGdfTfVZuKoPuK
         kD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718241245; x=1718846045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/f6A4FkXL/wAAUf4pCQGWv8NCQTP6EaG2oynfaeXBY=;
        b=BgfzjitSReDVVNE29Dl9dOo0OT58vEdzM59LSwP7BvOUW3bMSSQeInCEyt1MUcLJYq
         eGeJ3GKLWdGNmIqypYEK6Zt9gRXVtDZY2IN04zjxNZ3OLjKIRMlgbdYeCDi+/3eivnR7
         Mw1AEQTrdG/W3R6G89Z11bv6Pcvp6OfMug4qtXPulnT9LxzsyEc+5IbBRRWWzZE7n5Ch
         991wa/eieYvjdDwKFExtqE+4B5/XF56S1PX+wtw8cVE40GxvUMdZ2BHqdb4Tzpgf+DE5
         Ax7X/J9Ej8kQSQdqZtOTUcxrivrCm52vWmn6sV7q1aTXaMOyQw/pd5VbEBYweDIrtz06
         Mhvw==
X-Gm-Message-State: AOJu0YyznR1ZaYCBS6obJUVjE8VGELQzM1ujaUC75qjitw8Lrlb1HDXx
	ErHG+X9MxnH5jIlbknYAmD5KdgF9r2TblDIB9tgv6jBlU4mj9oO0UPEJSK+GNsPINYPCOl0FEhy
	M
X-Google-Smtp-Source: AGHT+IGqj8ClQu+AYNyP9psqmEDZxa3xg4aPzzhlNPEHCMPZxnEQkIIZyA/La0Z9d2zf4gLC2V5XjA==
X-Received: by 2002:a05:651c:2113:b0:2eb:f8ae:1cb0 with SMTP id 38308e7fff4ca-2ebfc99f52fmr25492151fa.37.1718241245183;
        Wed, 12 Jun 2024 18:14:05 -0700 (PDT)
Received: from u94a ([2401:e180:8892:62b9:e94a:bca5:ace5:a3e8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1ad05sm1054875ad.242.2024.06.12.18.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 18:14:04 -0700 (PDT)
Date: Thu, 13 Jun 2024 09:13:57 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>, 
	Eric Dumazet <edumazet@google.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Jonathan Lemon <jonathan.lemon@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH stable 4.19] xsk: validate user input for
 XDP_{UMEM|COMPLETION}_FILL_RING
Message-ID: <hxq6nby44qaaddymt6s4ucnaq2oeuulir5z2zzjwvvj3sevt2n@zdfubulurdue>
References: <20240606034835.19936-1-shung-hsi.yu@suse.com>
 <2024061258-research-tractor-159b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061258-research-tractor-159b@gregkh>

On Wed, Jun 12, 2024 at 04:40:33PM GMT, Greg KH wrote:
> On Thu, Jun 06, 2024 at 11:48:33AM +0800, Shung-Hsi Yu wrote:
> > Two additional changes not present in the original patch:
> > 1. Check optlen in the XDP_UMEM_REG case as well. It was added in commit
> >    c05cd36458147 ("xsk: add support to allow unaligned chunk placement")
> >    but seems like too big of a change for stable
> > 2. copy_from_sockptr() in the context was replace copy_from_usr()
> >    because commit a7b75c5a8c414 ("net: pass a sockptr_t into
> >    ->setsockopt") was not present
> > 
> > [ Upstream commit 237f3cf13b20db183d3706d997eedc3c49eacd44 ]
> 
> What about 5.4.y?  We can't take a patch in an older stable tree and
> have a regression when someone moves to a new one, right?
> 
> I'll drop this for now and wait for a backport for both trees before
> applying it.

I somehow though I've checked that 5.4 contains the fix, but apparently
not. Will send backoprt for 5.4 as well.

Shung-Hsi Yu

