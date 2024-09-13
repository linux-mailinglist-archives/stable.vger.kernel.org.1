Return-Path: <stable+bounces-76105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0413978848
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 20:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E630F1C21EC6
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 18:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FB813B59E;
	Fri, 13 Sep 2024 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUkhnOtW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BEF7B3FE;
	Fri, 13 Sep 2024 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726253837; cv=none; b=Ra37TEW/SGetyAnxLJk49feOPVAAx2Fhr70MnytZqqN3zZr8f0AQRhtQfoo0lL9hqeaswpw7QBsUcjEZl7Ku9Oxyfygf4ezP5Eh9hxKd6S91eVQNveLPLJpmyKvpuM+6kO35/+TuNpg7Ipd5XeC2YAUuGhPoUtPBMdc3s63I6TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726253837; c=relaxed/simple;
	bh=hJCTc/6yHUDiq+TBBk5Sp8setNzjVIzn21aRuMamIfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOYO8fOTQV1j9eBhdXtUiwSz9pQjgJiopznrSO7OOWwiZgrWw4f9+GOA4GV1NavSgP1ufYJniwjCyhBcR+jVNV7YrmRkYkCfzyhz/VNn/URc062RcvqD9IO1yR0mYxge/eVYv0ewDihKJDH9by1H/0D7PuWK/uDwrtaP3rFCRzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUkhnOtW; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8a91c8cdd5so24641266b.0;
        Fri, 13 Sep 2024 11:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726253834; x=1726858634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9KT7wTlkKWAPIvLq2FwcNHktlSLs65MPKXB4TMfQmcA=;
        b=XUkhnOtWBiI9/kj6VY1ug1ZuJUDi04JJbyELUbiq5C+xW6JMFEl9sk3LcC7p2qsjU0
         3vSIyorBkKR6R2pabMaqHrJllQ9KKFuJyJKDuDKm/zGRQa+2DbNVbe3so6R7zALhKfGt
         /xjDwzR/uDCkqlK0AXOUHYLYhQ28Vox3Vq08vwEvcaufBTHp4cQfqJGzHl77h7Js9esA
         2Hx7tbJ6WYr7VofElpLpcIfRLNhD0gKOoC4rFgYU6ggpOhQiwpxYLuVNL4vACpCRFNll
         G8ynCpnaVDYSPKe8AjlBYelfrQ8+4OseDJUnTLRucXGuGCCe58TqaoU2yGob00uu9YTW
         WO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726253834; x=1726858634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KT7wTlkKWAPIvLq2FwcNHktlSLs65MPKXB4TMfQmcA=;
        b=hsSq1QJqojPFcjU2NYUwLU6YMuC7PU7nxRYQrhZMCj0nZ59dQWcOZQfBCNffL50r2D
         0Ug6m87CaXaE7ItDBAuWk/Sij3ATHBa6SylG8XMPEUCu8VcwaLheEij7BA5HkvgDNUg8
         T24bDHwDfPiVnQ/SmsP+GMKjfHZnlQD3L0j8H1eLjvlioZarzZyEsIRiLa0wCuGPRdId
         OdZLoRmPNEdviuPr6v/5m/tt84DNw2XUequGxkz9SItVL1EYDACyZKOUIXsIrJY3vZHS
         iWJgaqoNxp6N40vJOnHv1qjKqeUoBXkc5SY/1v9F4NSUi7mxpfwGtmebhD7WBJkPH5sH
         xIcg==
X-Forwarded-Encrypted: i=1; AJvYcCUDQZUi9fhn0DWbl7RyywczI7oI+i9QgsH1E0QhxjBv06LN71o0rartIWiAez/Uot9Z9/UDezk=@vger.kernel.org, AJvYcCUxdlthxDKwegFQu7X/W+3OdXakquQ9BgjtRyej5Z/gDIavW97NnGzFBSr/xb8RMI+2DTCied75@vger.kernel.org
X-Gm-Message-State: AOJu0YxlTTxzE7kJP7KLtNW/hA85I6b2ThtvEEdf8/SBm+a2F5z2uM+C
	mLmZ3PoOqG6VNfUZSHbLtpT1Sf/KSHOzjwoS3tO3Tef/qongHeqW8xYjF43V
X-Google-Smtp-Source: AGHT+IFbActLfWh0JQuS9i+kFBb15J/wpQaWel27SEDeC5pzYsdKrSUVbCQSNwLtzSMuskdWM4XVfA==
X-Received: by 2002:a17:907:7d87:b0:a8a:9054:83b5 with SMTP id a640c23a62f3a-a90293fc43fmr309031666b.3.1726253833015;
        Fri, 13 Sep 2024 11:57:13 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d258339dasm902858366b.38.2024.09.13.11.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 11:57:12 -0700 (PDT)
Date: Fri, 13 Sep 2024 21:57:09 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: dsa: lan9303: avoid dsa_switch_shutdown()
Message-ID: <20240913185709.uchyicqqcuwyya5u@skbuf>
References: <20240911144006.48481-1-alexander.sverdlin@siemens.com>
 <20240912101556.tvlvf2rq5nmxz7ui@skbuf>
 <ae8d43993c2195925c9cbb4a9db565985709eaf8.camel@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae8d43993c2195925c9cbb4a9db565985709eaf8.camel@siemens.com>

Hi Alexander,

On Fri, Sep 13, 2024 at 04:16:57PM +0000, Sverdlin, Alexander wrote:
> > > Fixes: 0650bf52b31f ("net: dsa: be compatible with masters which unregister on shutdown")
> 
> Do you think it would make sense to add the same Fixes: tag as above?
> (That's the earlier one of the two)
> 
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > > ---
> > 
> > Could you please test this alternative solution (patch attached) for both reported problems?
> 
> We had two LAN9303-equipped systems running overnight with PROVE_LOCKING+PROVE_RCU and without,
> and I also ran couple of reboots with PROVE_LOCKING on a Marvell mv6xxx equipped HW.
> All of the above for a backport to v6.1, but this part should be OK, I believe.
> 
> Overall looks very good, you can add my
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com> 
> when you officially publish the patch.

Thanks for testing, I really appreciate it.

I will add all the required tags for the formal patch submission.

