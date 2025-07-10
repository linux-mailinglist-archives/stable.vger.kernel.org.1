Return-Path: <stable+bounces-161583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9274B004E9
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 16:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF9D1C40C31
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 14:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D4C2727E9;
	Thu, 10 Jul 2025 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7mz2C55"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBAA18E750;
	Thu, 10 Jul 2025 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157026; cv=none; b=cSk3sFfBtkcItkDSYIsvTbESBu2Qk5kdnmv3PUXHRT4f+VSviczKNAu7X61Vq4/D3Zm+DwNNJETmMgR6EtxvGhW87ebtxYj8+x78vwT9Pgv3VjRd40PljXzKtm10t6wKweuG7y2bLj0VYhv3iwO397EnahXKLbvj1+oz1JMfq3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157026; c=relaxed/simple;
	bh=cH0XWF4BIOD4tAIb15pLfn9fM2ClrDO4rTeFXsuzzK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYECfUJxeIPinLIm6YPnr4i8fff44JsITmYpMPWtr9BPZ51EhQfILmAl7cN7xm9WLINUqY97NRjghE9iQYNq06Xg0lIGk9seEKLrOTwtFiad+0UEnng+jQPS4GfeLB+XONIdG1ZMuylfOUFkPBbYc+n9jj37yaSFFj5vr2xsVis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7mz2C55; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450cfb79177so5679755e9.0;
        Thu, 10 Jul 2025 07:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752157023; x=1752761823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X6NQWnLkUsU4IbrEIKvkyte6IAfv41gNTZEjbgwjMjg=;
        b=j7mz2C55Yn0wCCTYLGknSaS51U/3FNC4K0K7ue6l6PpocT1CI+nkL6obIm+xOevnkM
         l63VqbvCdOEBOOtoIrcZqCW6t9+ye0AX37i/1IHfavcAy4NJc9NIt1KsmtmtXDD1xwNF
         6W81yNG+wqo/dUd6YhjDLxIjAdJb/gq6GoKMSvJH4qMyIpNzmUdl9kWqn4vUNchS+Gwu
         g19122BJuRnksMCQkQ5R2b3k/FFcr44GH5qaoySKqVqUTZVZYInf3Cral3wUZSwr8zfP
         CE553P6nYAOp2pKOA3MKfRC+SNmzwCpSz6GwokoRJbbgEha9QqUTcRJ9zf6jXnYznxP/
         tHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752157023; x=1752761823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6NQWnLkUsU4IbrEIKvkyte6IAfv41gNTZEjbgwjMjg=;
        b=SkYo3h7Qqv3sood39hZ1BhV2DRknw1iLcu5odVc2IvnCK7py2a1YCtGXxVkkpKlhnd
         Oxq4lTQ8cLDGXIFXK2h6zPC92aBm7QGvP2K0wgh4E/OtkOHcSVhrXMqNhEJtQWP9epEX
         PLWq5t3UFAWUWHMNF5tPnGyLfYEdR7NcwYQEh2Ep3wzajdqa4zuV3KmXhmP/7A6l9G88
         HU3svz0wCUFEcHXWRf1ihSW975RSVbpvrnRgtFI7fXamDVrok6zzQxLkeif9dvh9jubs
         k9dwfs8KqQyQMw++131KJqvXlr2WUl7ntmTChsi69rhybf9bZ6JAyBcymAYg5TzO39Zx
         KNeg==
X-Forwarded-Encrypted: i=1; AJvYcCUrQhh4ayMyaKyEzeBHyu01FWVpytPaAXzCjjl+p+KdW+IbGnrhfAsjkzTz7JukRQMtPP8TtqVJ@vger.kernel.org, AJvYcCVV4VeXAbbnYmFzmCjsufxk3J6nn86BCz+hMy7Q1NZCXTZG6qbFj2sWc+yhEFrdncRFAboJiGkoYyXIJjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWBicky05QZHGczIisqJ0QzHR/QeXvmf552HTzINSopv2M+Zf4
	OrJpaFqKptfm93fFirym4ql6FJbWy653ud9YB4+nSLuQKC6CGxoVEAyj
X-Gm-Gg: ASbGnct+Ue8aJ9RzKr2EFqnSey8ZRA14TpnvJhjL7mg1nFqtS4EKsJOXL7BKKB3DFUT
	4LR4woJTW0lgPzGl4jKtDIwXIqjwxDpskd/bA267KWqVjk6jFAppO8iIX7I7DyStwCUPM8igOyw
	mHeup90PczfBZ/u+6j+AmOOlDivzVLbSGzL8bmu8FXhSqDPxH7LBfTyzqGMTqXj6nXCroohHWr/
	YW7dPgjmr6FsjvMrdviaWV5SqQodM1v5yG/CnUBFgj5lwfjtRcOla2ZgI+fdfdYF5A8EFOJvWl6
	Ygycnx9I0D3Qr9kytsXCEnoYOB7yZWF8mIA1GeOqwsGiSdrgazyJXW9FEgxrVlBtdPW2n9pfPoU
	=
X-Google-Smtp-Source: AGHT+IGlGSMIN0Z2uimGznfKX4FTEu7U4tYvxhLK7Fd9GfFLljkOaCUfaX3W2X7dXjvzvPzvhqq93g==
X-Received: by 2002:a05:600c:8b63:b0:43c:fffc:7886 with SMTP id 5b1f17b1804b1-454dd404f37mr28160105e9.8.1752157021984;
        Thu, 10 Jul 2025 07:17:01 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5133183sm60150125e9.40.2025.07.10.07.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 07:17:01 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:16:48 +0200
From: Oscar Maes <oscmaes92@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: ipv4: fix incorrect MTU in broadcast
 routes
Message-ID: <20250710141648-oscmaes92@gmail.com>
References: <20250703152838.2993-1-oscmaes92@gmail.com>
 <20250708185430.68f143a2@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708185430.68f143a2@kernel.org>

On Tue, Jul 08, 2025 at 06:54:30PM -0700, Jakub Kicinski wrote:
> On Thu,  3 Jul 2025 17:28:37 +0200 Oscar Maes wrote:
> >  	if (type == RTN_BROADCAST) {
> >  		flags |= RTCF_BROADCAST | RTCF_LOCAL;
> > -		fi = NULL;
> >  	} else if (type == RTN_MULTICAST) {
> >  		flags |= RTCF_MULTICAST | RTCF_LOCAL;
> >  		if (!ip_check_mc_rcu(in_dev, fl4->daddr, fl4->saddr,
> 
> Not super familiar with this code, but do we not need to set 
> do_cache = false; ? I'm guessing cache interactions may have
> been the reason fib_info was originally cleared, not sure if
> that's still relevant..
> 
> I'd also target this at net-next, unless you can pinpoint
> some kernel version where MTU on bcast routes worked..
> -- 
> pw-bot: cr

The caching mechanism was introduced after this line, back when nhc was embedded in fib_info.
(see https://lore.kernel.org/netdev/20120720.142612.691540831359186107.davem@davemloft.net/)

I'll resend to net-next.

