Return-Path: <stable+bounces-253577-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFywLjQkD2paGgYAu9opvQ
	(envelope-from <stable+bounces-253577-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:26:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E4D5A84D9
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB41F33239ED
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4473B961E;
	Thu, 21 May 2026 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="AGU+P38N"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012783D3CED
	for <stable@vger.kernel.org>; Thu, 21 May 2026 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373379; cv=none; b=JsPrfR0rMqtyttkJW/i3zS21SomntOYke/9h+vpLYQX9h/F2FnuZ9Fke+IV7L+UTC1m4Qx4TwEwual0BfUlpe37Qhp+VXXA0cetaA+tk//zwUPPB0p5Hj38HtdYc5Inmr+WlsDjMhuUGQVyA07SBhQuixmuRfBGpaeWVxUPu9xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373379; c=relaxed/simple;
	bh=+40JEsgt67rp27HbIogbVE1VNZy4G6PmSZ759DTxeSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y61YH6xZLtTECJvA9bv1VNz7/36jANqxBZ5MoW60KlH8MIStYO+fCOJAjfx4gLFF0z85PhO9GZOOf7la3HPm/QvvP2mdReJFpiHAlzVMFH47yctmAqiMJGpg1ZS+m4ijph30uDc8sp7CZAujhoGghYStzy/o8Cx90PEhAzVRdY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=AGU+P38N; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65c396d3b36so6288990d50.0
        for <stable@vger.kernel.org>; Thu, 21 May 2026 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1779373377; x=1779978177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAuZxHOOVqtbe7EvwIW4p7uGjThIX0WoLkEbWijMiq0=;
        b=AGU+P38N9k015k5sOn8myxZX6ke0r5KbLpHNS+rR9xlH4yKXcTYQrKcBZYPhOw5tPC
         NSC5fp53w8TU3NXtg+sF+hSvg8bCLKCh79GmaH6HiPxrfruKQqfqXvlwjSuhuHYwUC+4
         XhybcR03uTPZsFuJbX982qDna7k7dsSd8g59df92KU3HynL/y2feuWfgi7TL4K/7Sp0M
         f4j62qrmqg/kMzFrAHtIbq61HX1pAjPoruEtsqoAXMIe7XiazlynsHCT0Xm1FuInADVu
         04+zY7tBwEHoK4m9QABG9tex96OvRImCLD9/wcKgnu+gZloMKNmfdJNhgWC2+ld9GJj2
         +c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373377; x=1779978177;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mAuZxHOOVqtbe7EvwIW4p7uGjThIX0WoLkEbWijMiq0=;
        b=lGxJbaOl2dZqnDL00+5VhoOqL3xMEWL5V9Nkun4trz6mauI6pJ6+LjuJ2h/ZMSTl36
         zJO3jtcwmx8IHtNerEVkn4mDlrBy5r4xiR/xOQ5HP4fidF2AQA0PWrYSIj2806iw/a4N
         q7N88JrdsR33U1ra3dgu4e1P6R2OolzhQwRbnAE+3oLXrrHzDnOjCGIraDiqW4HptOwx
         UTrHAm6KEuKB0Oy5c2jq+AKajYWP8TXNuNuJTtZxxi7nI/JJ3GAyiCCr14MLcgulWJLI
         68hWFZZVSKElzK2muZfX0vJFote3SoGSg2I07wQOSjt6VsexbTBxRc5uS4U4TjRLklDP
         9SDA==
X-Forwarded-Encrypted: i=1; AFNElJ8b7z7jQP4Sjc2zt72zlGHY4wX7Q7iMfmYoMhThbkaVO/l3IdLqh65Xg5le5yohhM69nQvAJFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXeePauKm6hcNp/66xHxoBdwlGYDSLxW2cOadfalTeZIKje5n3
	bpBQXcA6Nah1BJ90IfR7mrY7f0H9Jzq3ahBPTBNn6dNpuRO6g93f3MXt9iw5m5g2TCevKXWAfbg
	KGx+Z
X-Gm-Gg: Acq92OGZIxkUJHiKrczp73yIP/WL4YgPmbyNR1zriSnGmz5YMc3dp1rBdd9byLIKJby
	BtlYn1NXBy3uOE/frZPPl0SRgTiuDOTrJ3A9rst7A0cGku1OSS2R72fRULYKIZuaAVoWKwRi+es
	u4J7gv7P+rsqE97s3/ClVsS5Y3MaRL830RUUigG82KB/N3Bjn6jzsHEKhzCP25ZBrBPtyHPlNwU
	zBlqxRyf86fzcyH2vxJzmGfspCAfOu0osCtGo98dWVPCIrUO+GbDhRd/NqbjMzJP1w0AnU5Y8l7
	Aqmdjv9dVNFoBjiw7lIasKh5Jm5YuaYoRDcRop3ojuMCW2sVwXGXbGs0SGf/LPfwDIRMV5doHD5
	N++pkaDR+AxjSPsoFE+mi2neutWiPitQMMCzHXUSBXFZ7VUmaKNNGWh2lYNtv6AglESlFknlS+y
	pzmF4ySDnusL1Fl41Fh+aGsqKZYRGjgojK/E+cILI87MbSe9i2erUu7R4BAjU5CLNC2feriSG0q
	q+hQMz17jwnOuVaE0jojTT7X16eESKOV9F5
X-Received: by 2002:a05:690e:205e:b0:64e:d610:71cf with SMTP id 956f58d0204a3-65eae48a32emr2078881d50.58.1779373376711;
        Thu, 21 May 2026 07:22:56 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:6b36:97e1:3f54:e933])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65ec2009b8dsm222944d50.14.2026.05.21.07.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:22:56 -0700 (PDT)
Date: Thu, 21 May 2026 09:22:51 -0500
From: Corey Minyard <corey@minyard.net>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Gilles BULOZ <gilles.buloz@kontron.com>, kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>, stable@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: Fix user refcount underflow in event delivery
Message-ID: <ag8VOyAuhf6M_0NW@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20260521130628.3641050-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521130628.3641050-1-matt@readmodwrite.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253577-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[corey@minyard.net];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,minyard.net:replyto,minyard.net:dkim,cloudflare.com:email,mail.minyard.net:mid]
X-Rspamd-Queue-Id: 35E4D5A84D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 02:06:27PM +0100, Matt Fleming wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> ipmi_alloc_recv_msg(user) takes the temporary user reference owned by the
> receive message, and ipmi_free_recv_msg() drops it again. If event delivery
> fails after allocating receive messages for earlier users,
> handle_read_event_rsp() rolls those messages back with
> ipmi_free_recv_msg().
> 
> That rollback path still drops user->refcount explicitly after freeing each
> message. The extra put can free a user that remains linked on intf->users,
> so later event delivery may dereference a freed user or trip refcount_t's
> addition-on-zero warning when ipmi_alloc_recv_msg() tries to acquire
> another reference.
> 
> Remove the stale explicit put and the now-dead user assignment. Keep the
> list_del() and ipmi_free_recv_msg() calls; they are the required rollback
> operations.

Yes, this is correct.  Queued in the ipmi next tree for next release.

Thanks,

-corey

> 
> Fixes: b52da4054ee0 ("ipmi: Rework user message limit handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 869ac87a4b6a..52561a880e54 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -4477,10 +4477,8 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
>  			mutex_unlock(&intf->users_mutex);
>  			list_for_each_entry_safe(recv_msg, recv_msg2, &msgs,
>  						 link) {
> -				user = recv_msg->user;
>  				list_del(&recv_msg->link);
>  				ipmi_free_recv_msg(recv_msg);
> -				kref_put(&user->refcount, free_ipmi_user);
>  			}
>  			/*
>  			 * We couldn't allocate memory for the
> -- 
> 2.43.0
> 

