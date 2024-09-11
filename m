Return-Path: <stable+bounces-75874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 533C097586E
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 18:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091331F22CCB
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 16:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60951AED3A;
	Wed, 11 Sep 2024 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkmpUIDa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1581AED29;
	Wed, 11 Sep 2024 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726072121; cv=none; b=oRPGvQLXOqGJzo/eFTokU1CuAuRnPWTIc+DpygpgSA+AwTDnEw9nrO7Pd+atp1RTcRCyU8ZlAr6FGER4mUhheiqrep2qoPmGmk8n9WqPw2/Mo0Pc9oTIILPOF6mlehQhmJ1iAbqQdEE93G6AxphNkOugzpo0F280Njjtw2SnTUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726072121; c=relaxed/simple;
	bh=bpv0cZO1H01FLRKK6XkCQGP7v6iRaBUIkZLQX/hE1HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feQPbiLcDrhrZsTFEWVJAM+5mquYEm616/mLDQswezk6a8uKN6s+4/+BmILV6fqUdA08mPu+iz/1VUxzt9pQQA4tzyt8q2q1mTpIyIGi13c90Ky1w30lriRIoR71o7+uC/ZP/VwhHtbtPNcUi2+yZAcJM7tsQTA3p6o5cdEAxs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkmpUIDa; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374c4ea1d75so4648f8f.3;
        Wed, 11 Sep 2024 09:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726072118; x=1726676918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SBRntL2qZjX1pezRLXgvdWdeOJxSKF6+u8ZhrjEVTrk=;
        b=KkmpUIDa5NHZGZ6Uq4I7yTAdijqXwA5x+Dk4ZBbe7SYCUrascotE4WGiRKBTVsJoZQ
         l5V7ITyGszXkpTfmnQuMghmWS5WTpd+jWwqS+P/fDWRi7NqkbX/k85UlOFtnCtOwXLNd
         BENoFaRcAfLnV6R7omWEY/OGvonK1hU6oPpRrN9YTNIzzPQdjoTK2kImXqBLivCU2g+J
         fkPaG8CL/Yx2ko1tvKeQFmpTHSPf0BVO6qXIdnuOVauhI8Hnm4do6MRgu8Uaurm2sdxP
         3j6WQcMh+TY750AYU0t+RqdUOVc41BHKOu3C1Ck78Tru312cfP31oy9A7pJs9eiR3hLt
         4btQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726072118; x=1726676918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBRntL2qZjX1pezRLXgvdWdeOJxSKF6+u8ZhrjEVTrk=;
        b=gIhwXzbxczut+2k4JaQAY/UmAdKR6f/fZk1nfF/Lt4+jhs1f7gCQ+ysoz/TeaOkgZr
         EBGsOiXiN/EopRgT2h2wWleSapTkJjvzrV+7mKpm7JUwkN6GM25nCVkRD9x2iTGC0ZUr
         mUXUBXW8aZM3GtI4SUFZQjnnrn4aUKlzXzK+H3AgLGZZaMsncAqRau+7Zpt1+gCIgbF9
         ebs9i1/pm7ZkretczJsuqoxmwNgd6LNgr/xf9p3tCR47PoGVU0J2wTrTa68BcfxFMd+F
         ObZY3PjTXq3q85UNOU2rq5/VNLb9eWFYkbiWN5d4SL3MyzI3O5QTM7KXddnGw8xB6v4q
         mWZg==
X-Forwarded-Encrypted: i=1; AJvYcCXIPldmzj71tN+u+KKO84+eg6ber+p9YRM/x7QfHsgR+dNx8uB15wmdK/JE2xbRIUHAGrkYcn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx/qInAa11qvdDaeOKtT1RfxueP8W/dSUm1lEzrZ0dWpC6skjK
	VM0Yz9wOSnar91WuFwHFrYWRM3dqcE8ZglDKSn3CrrC5shmqxLnehQ1uCaaj
X-Google-Smtp-Source: AGHT+IEM9pkqgiU3YhDYqbn9k/7XRJ955GGHsKbDTDwZP5J+21i5JUmQxTpU5GTGdqCrBg4I8YTU9w==
X-Received: by 2002:a5d:648b:0:b0:374:d124:2ab2 with SMTP id ffacd0b85a97d-378896b5db7mr6723228f8f.6.1726072117547;
        Wed, 11 Sep 2024 09:28:37 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665ba0sm12047866f8f.48.2024.09.11.09.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 09:28:36 -0700 (PDT)
Date: Wed, 11 Sep 2024 19:28:34 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: lan9303: avoid dsa_switch_shutdown()
Message-ID: <20240911162834.6ta45exyhbggujwl@skbuf>
References: <20240911144006.48481-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911144006.48481-1-alexander.sverdlin@siemens.com>

Hi Alexander,

On Wed, Sep 11, 2024 at 04:40:03PM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> dsa_switch_shutdown() doesn't bring down any ports, but only disconnects
> slaves from master. Packets still come afterwards into master port and the
> ports are being polled for link status. This leads to crashes:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> CPU: 0 PID: 442 Comm: kworker/0:3 Tainted: G O 6.1.99+ #1
> Workqueue: events_power_efficient phy_state_machine
> pc : lan9303_mdio_phy_read
> lr : lan9303_phy_read
> Call trace:
>  lan9303_mdio_phy_read
>  lan9303_phy_read
>  dsa_slave_phy_read
>  __mdiobus_read
>  mdiobus_read
>  genphy_update_link
>  genphy_read_status
>  phy_check_link_status
>  phy_state_machine
>  process_one_work
>  worker_thread
> 
> Call lan9303_remove() instead to really unregister all ports before zeroing
> drvdata and dsa_ptr.
> 
> Fixes: 0650bf52b31f ("net: dsa: be compatible with masters which unregister on shutdown")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  drivers/net/dsa/lan9303-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
> index 268949939636..ecd507355f51 100644
> --- a/drivers/net/dsa/lan9303-core.c
> +++ b/drivers/net/dsa/lan9303-core.c
> @@ -1477,7 +1477,7 @@ EXPORT_SYMBOL(lan9303_remove);
>  
>  void lan9303_shutdown(struct lan9303 *chip)
>  {
> -	dsa_switch_shutdown(chip->ds);
> +	lan9303_remove(chip);
>  }
>  EXPORT_SYMBOL(lan9303_shutdown);
>  
> -- 
> 2.46.0
> 

You've said here that a similar change still does not protect against
packets received after shutdown:
https://lore.kernel.org/netdev/c5e0e67400816d68e6bf90b4a999bfa28c59043b.camel@siemens.com/

The difference between that and this is the extra lan9303_disable_processing_port()
calls here. But while that does disable RX on switch ports, it still doesn't wait
for pending RX frames to be processed. So the race is still open. No?

