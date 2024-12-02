Return-Path: <stable+bounces-95916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AFA9DF9B4
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 04:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB923162772
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 03:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64271F8AD3;
	Mon,  2 Dec 2024 03:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="NvaMaGS7"
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2147A1D88A4
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733111833; cv=none; b=cvHPP+11VsduHxD7DSQdsWX0hNoW/J19v3bi1p/fz03BSgO4m/G0Tcyx3OUAJjDjTtc/R47UzWWxk6OIficxKwgfO9eYGpBECwTqoxs+vnJZlUG1j9o5TQqORbfufoCmwBCGBP45THJFP+wMXxibehchQCrdMvg/MGPSzZnOpSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733111833; c=relaxed/simple;
	bh=lvRgxLkC9lDXJdMG2vSTeFG6EcXZW70sZ7LUOmHlaPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbHY1zDtEHS2kBxSTXCEb/bGdnK5iY0GQx2fBEhRN7tIwg56k9W/2Q+PSX5mGUm9+3Sm/VwFpkSBS0KR0pEN5kNA5ZK/P4pBJ/cQhAwaRZST6PObMAObgGBX7l1iiZPO4lxFMY0NOGEXMf1NU68G9Un+lUPEUfGc1TgSziq9Md4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=NvaMaGS7; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=NvaMaGS7;
	dkim-atps=neutral
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id B45C089A
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 12:50:29 +0900 (JST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee36569f4cso2949981a91.2
        for <stable@vger.kernel.org>; Sun, 01 Dec 2024 19:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1733111429; x=1733716229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4HQEXIyZsrJ4f5Rfkkqm9DWJBB35YS/0AB032iPU8C8=;
        b=NvaMaGS7Lhs6gOfneg6q/yuMW0oKGkzAIEDbu9Iari/2K3IaYGExy6Ew6a1HpQBVJh
         KFzrlrRh7N92+5iigaCtT+BWiFN0CHcRGOOA8rpQbJF2eOMAbwnjtydtzja5mjxwRtk7
         hu2uAkufheMT5jFv/l2eWxWs3A6NFSiFjstPO+CRubRDL8eRoeqQ2SvYi4fS35FK5Sx7
         ZK3DuLNqLU1LkuqTFnSQrtzQ9BGjQWsL2AswSMs6Dzv7+yx+P/8a++gJlHUdcM5WQz7M
         JkY3VcrG+6GfvqsucIy2CO9GW6lzcC2YflQvr4WuThooB0tFiWfO5ye01+0RLrz3F0Pt
         puvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733111429; x=1733716229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HQEXIyZsrJ4f5Rfkkqm9DWJBB35YS/0AB032iPU8C8=;
        b=mhCV/MmyZ+Aa4Zi5Kx4bgku12n6QVle5BfJa+fDW47UbHWxQZNas1vkam54vWeX+L6
         ZsO+KVQB1Cxd4F6Nhdb3EoREucl54B0NkekV5vKsmOrU3zstfvn+2IkKgkqP21Cv0/dt
         coove8T93+iXhclq5Ry/5McNGns4hTWpcF4Oju7hycbfP2LXcyXcNER/FzFbwOOkkOPr
         tYUQcoi2yZtmBgt5CpPZ1f7Ot4DLJFRJgbSV6l0JoZ4fRQ9ED3KH3h1qBai7qTeDu1gk
         MJms8HP1wZ2836Lfm0CdHvjKFdzAPp9FYOfWpyjJjhXOWW9CBwpRtreBYE1WUB23ANZo
         dWzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7neDbE1AtsdWzHcO7qxTVRJ1fL5CCX7tGms7ISZCFbQWtVVdX77yTtCm16PAIQj6KzfideBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJVfgwWc9+7wv6U2jMdAaUmP2/QOm3TI1JGHZqtxzIkduQgur9
	vg99TVEhD48y3euR9lAmyW18nsfI0lvse4SHvZ47jGSqJ+5JrveEt1P8MbN9Yyn4DkgpTF7mqz3
	o1JBW4B6UZiG+ApUfNbA9NTl/uD+k7UyDQKPtlayPRkI0iCrwZEnvbgY=
X-Gm-Gg: ASbGncsD9FwM4AtzjemToF23dbdVgzTsIWYyiowNW/XjmLMAATnVQ2msa7AFzLqOMhT
	3TTm/vtcWT/PBXiRHlFy31f8r/Yp5VCTwb8WHY26CrKVYI98Ya8ZtcE3Epk6eWE+xRsY76qEZW6
	fYuK+wwYXLP9enwJeswV2zfWC7jgw127Cfdd8iUDTXoKpbz6z1uCFnLqIYlaRs5w9Y2Z8P9igfz
	6P1t4oDWztK9KwUdnIl+5f6cpvznAribgAZnX3Ao8JRGhCRquo/h49ccssAzf2+lW8k7zLBdo3y
	YvUhln6Eie20zT05CgsizJbUn6ieI5UuXQ==
X-Received: by 2002:a17:90b:4c0a:b0:2ee:9d57:243 with SMTP id 98e67ed59e1d1-2ee9d570daamr7510203a91.1.1733111428762;
        Sun, 01 Dec 2024 19:50:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGrUfdYidb3+4gC1zE+19HgdSQ327HlbWrWwlG5RjKT0brQPVbmrEquIDL+z2sNxk15FEVzg==
X-Received: by 2002:a17:90b:4c0a:b0:2ee:9d57:243 with SMTP id 98e67ed59e1d1-2ee9d570daamr7510191a91.1.1733111428381;
        Sun, 01 Dec 2024 19:50:28 -0800 (PST)
Received: from localhost (35.112.198.104.bc.googleusercontent.com. [104.198.112.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eec5eabec6sm963644a91.34.2024.12.01.19.50.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Dec 2024 19:50:27 -0800 (PST)
Date: Mon, 2 Dec 2024 12:50:15 +0900
From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Greg Thelen <gthelen@google.com>,
	John Sperbeck <jsperbeck@google.com>, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net] net: usb: usbnet: fix name regression
Message-ID: <Z00udyMgW6XnAw6h@atmark-techno.com>
References: <20241017071849.389636-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017071849.389636-1-oneukum@suse.com>

Hi,

Oliver Neukum wrote on Thu, Oct 17, 2024 at 09:18:37AM +0200:
> The fix for MAC addresses broke detection of the naming convention
> because it gave network devices no random MAC before bind()
> was called. This means that the check for the local assignment bit
> was always negative as the address was zeroed from allocation,
> instead of from overwriting the MAC with a unique hardware address.

So we hit the exact inverse problem with this patch: our device ships an
LTE modem which exposes a cdc-ethernet interface that had always been
named usb0, and with this patch it started being named eth1, breaking
too many hardcoded things expecting the name to be usb0 and making our
devices unable to connect to the internet after updating the kernel.


Long term we'll probably add an udev rule or something to make the name
explicit in userspace and not risk this happening again, but perhaps
there's a better way to keep the old behavior?

(In particular this hit all stable kernels last month so I'm sure we
won't be the only ones getting annoyed with this... Perhaps reverting
both patches for stable branches might make sense if no better way
forward is found -- I've added stable@ in cc for heads up/opinions)


> +++ b/drivers/net/usb/usbnet.c
> @@ -1767,7 +1767,8 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
>  		// can rename the link if it knows better.
>  		if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
>  		    ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
> -		     (net->dev_addr [0] & 0x02) == 0))
> +		     /* somebody touched it*/
> +		     !is_zero_ether_addr(net->dev_addr)))

... or actually now I'm looking at it again, perhaps is the check just
backwards, or am I getting this wrong?
previous check was rename if (mac[0] & 0x2 == 0), which reads to me as
"nobody set the 2nd bit"
new check now renames if !is_zero, so renames if it was set, which is
the opposite?...

>  			strscpy(net->name, "eth%d", sizeof(net->name));
>  		/* WLAN devices should always be named "wlan%d" */

Thanks,
-- 
Dominique Martinet

