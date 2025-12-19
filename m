Return-Path: <stable+bounces-203044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CACCCCE6E1
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 05:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51D043015A88
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 04:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB8524677B;
	Fri, 19 Dec 2025 04:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MADK7HD9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B937405A
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 04:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766118416; cv=none; b=a4hXku2RdLh2BijP3PHAnpbQUXw7XRH3QdIZxV3LYAKnKA2G2NKWuCSaiytSkTP9f6MBCX/qfDJgyahyOL+TFUtlHJrIO2UWtuvYci6l2EdTo+HbQgoQh/s1ogwyU58E5PiCJM6au6XrjKEg+2+JUoAW+vpR+xZhKXOrZH5JzLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766118416; c=relaxed/simple;
	bh=ovP8gtD5+BQjcK3f08wnRmMgzhRYiUcGHCdTgxzmvAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D24d0tDXhfE1KNLwJZZcgTwspYz4ZGkeA053ZrxZD+u6cay4LseWlKb9lCnJ33OyplxLxSGY0UQLFs7ep/5G0YWEJJ/KdEOEtPg97/IUD0wW1jW4dpYnuS8CpQmdVYcaqDjrTz1yQyuqJjZHNKAqg37gMONdvA3IsZlgQOabf8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MADK7HD9; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso1218433b3a.2
        for <stable@vger.kernel.org>; Thu, 18 Dec 2025 20:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766118414; x=1766723214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fBG9PpPme/oEFkesYFx2PkIuis/93o74SUhSLz5uG+w=;
        b=MADK7HD9jWbaLvs5WaZboSCVA6Xwl/HoEXjbpRhPQedDRv4trBHEdBf+gpVk8gNSYP
         D0C/5UAuSz61NW7UhOsedindvjCREV/YvSTV3BwJBhj5lMdwIvHwELtpJuEUjmxSc3Q3
         t3eKWIV9zmPdcGJResKhAkncXQ7ig2N177dlVgotc1SnlaQVNPu2ASv1UT7li6ngjayq
         YBdR1dUEmQqGqL+Un5mFj0miDdIu/UgashsObNL5wYHQCx9kEF0166dt589rAaKihuDw
         C1PM3b3yyra0W6Vy7LV1x7fNNcduT1Ib/I+BcIwyVM0QXQff0v07xOkCovCcmLImHTMB
         eibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766118414; x=1766723214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBG9PpPme/oEFkesYFx2PkIuis/93o74SUhSLz5uG+w=;
        b=g/qCKH4MBkQYK9T1qjLeZQuKgeEYjHEkJ5dLJtXfS4+iDoJWIjE9ojBr1uNQQnZuZe
         PIEyLK8ymHg6MQqyYzaGUq9FjoX6gDHahk1K4UXKb84ZjrCrp7gV3MsDNA+PKDPg1CbL
         LB+2aWR/rNCor5TQze84yy8TbF7DORureua8tKc8nJTM9PeYcppK5PRMW/7XpqU2e0aK
         fCnB/yjMpAcBnwYxzUMGQjZ8rqdSt08J7tTkXZaH+ug+Q6PGBuNEVcYCp8QXEh9/8TUy
         iqQNtoYoXiSYa+3xGziATy+4GEPuyS/5vxQNyZM+Fqd5t5C9UdH3JmHvoDjXRjT9+jg/
         kSxA==
X-Gm-Message-State: AOJu0YwXlhoswgfDQQdVT3uHK04PbYR2WFyEI1sV+kjMorva2zn2h03s
	q6mjelk48cT5Mmy5tPH440A3lZUVO47L9CGtRloBvom0d1rSeQhYI13q
X-Gm-Gg: AY/fxX5LQPgTT9TIErR3fd31hDtpHgnUAgqOcNn//O0jOxRPYzqtHoJekttChPbXjFT
	1gNbXzyD65SxBuBR+fVq+Rpn/k9Mpxf6WOG11jxriAZdwYblirFoVHI8HFG4sIEO6N3Z0SQkh6a
	zn6N7ajid+Ax7td94clieYvg9xvFdTTIcMNMBQn5yKBEvqw0tOQusEAphgigSGxD2b8fbO24YPz
	bpW/5JpCfnB0fGUvkmkygs/NgBMA3qiXcLqlCln9DF1TwXKz8RCsPADlWbicP6OIkxmdW4ow/4M
	ZVFGxXnlm0aNghBeUqsGusUlc/xCtgi5A8XdN72rMR/T10o+dq53BmNyGzg0HOGSSTPtEu6kxWv
	0xEQ/C53qDMIXlyPvph2h3b7C8zXuTdjqAOJ5DI6LAW4T737COLEPPdibPLV1/ryhdSv/5wIXTd
	WGFPnVW3QeAa0IgmU=
X-Google-Smtp-Source: AGHT+IHCiMv56rKEQaRTYYMRQhUob5RGCnNu96JLoZnHitHxGiAJLdrqCrchzotqvv2BNLNQm8bFOg==
X-Received: by 2002:a05:6a21:3282:b0:366:14b0:4b05 with SMTP id adf61e73a8af0-376aa500900mr1760867637.65.1766118413985;
        Thu, 18 Dec 2025 20:26:53 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dbc9d6sm3833090a91.10.2025.12.18.20.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 20:26:53 -0800 (PST)
Date: Fri, 19 Dec 2025 04:26:48 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH 6.12.y] hsr: hold rcu and dev lock for hsr_get_port_ndev
Message-ID: <aUTUCAdm92qjaXqt@fedora>
References: <2025121829-aloof-cresting-f057@gregkh>
 <20251218153736.3435271-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218153736.3435271-1-sashal@kernel.org>

On Thu, Dec 18, 2025 at 10:37:36AM -0500, Sasha Levin wrote:
> From: Hangbin Liu <liuhangbin@gmail.com>
> 
> [ Upstream commit 847748fc66d08a89135a74e29362a66ba4e3ab15 ]
> 
> hsr_get_port_ndev calls hsr_for_each_port, which need to hold rcu lock.
> On the other hand, before return the port device, we need to hold the
> device reference to avoid UaF in the caller function.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Fixes: 9c10dd8eed74 ("net: hsr: Create and export hsr_get_port_ndev()")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Link: https://patch.msgid.link/20250905091533.377443-4-liuhangbin@gmail.com
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> [ Drop multicast filtering changes ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/hsr/hsr_device.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 386aba50930a3..acbd77ce6afce 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -682,9 +682,14 @@ struct net_device *hsr_get_port_ndev(struct net_device *ndev,
>  	struct hsr_priv *hsr = netdev_priv(ndev);
>  	struct hsr_port *port;
>  
> +	rcu_read_lock();
>  	hsr_for_each_port(hsr, port)
> -		if (port->type == pt)
> +		if (port->type == pt) {
> +			dev_hold(port->dev);
> +			rcu_read_unlock();
>  			return port->dev;
> +		}
> +	rcu_read_unlock();
>  	return NULL;
>  }
>  EXPORT_SYMBOL(hsr_get_port_ndev);
> -- 
> 2.51.0
> 

Thanks for the fix. This looks good to me since we are missing commit
161087db66d6 ("net: ti: icssg-prueth: Add Support for Multicast filtering with VLAN in HSR mode")
on 6.12.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

