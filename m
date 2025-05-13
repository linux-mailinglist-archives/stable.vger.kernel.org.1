Return-Path: <stable+bounces-144136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 843D5AB4E57
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 10:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 693BC7A4D84
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF4F20E318;
	Tue, 13 May 2025 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXSSj85Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7105F1E9B0B;
	Tue, 13 May 2025 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747125810; cv=none; b=Z8OFUDcIQtAWlUyZL7IFuUpSf0g97Xjn/ApQMlCeBTn7lErytoDCF6KuLrus1HnNQjg8mBm4i9vlKvB4oXyJtohme2OOja0bPs+qz0C4vrsBYi7AN4WCP1DcHtChoj94BjDtVoYuJU3pY62B7ZGqelk4REEafGJ9cJKxvzNsM5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747125810; c=relaxed/simple;
	bh=QjT3YOsUMwygWaYoCbEkSvebHiZ4cTlT+R0vDMfY58s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUIU8rbqcxuF1feSd4aUdt0GfDXK8AD7cI6XsbOAk4KPfutQA7BV4v1O+kxj5gXK0O08/omkpLAU9AF86BrsVBCfB8jWcScLsZx8rH9JUq/n/s4W7ghcX64nZWElnwSEnEmxvvJs/RZZY+KQ1WcEB1oPvUAezpW9SZZuZQd+G7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXSSj85Z; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad241d7680eso14942266b.3;
        Tue, 13 May 2025 01:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747125807; x=1747730607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0r9SjPagfNFQkslyQTfGS9Ycm3AlorAARH6C/r+EchE=;
        b=WXSSj85ZjFYe47O3KMZnEr3YNBpFhCC3p4nbjrRnA5MafbthTig/RLQo4gSe5JJ377
         stq/u6/ESf4kDvaQfoSuZrAUeVtMVOUjZMcfESV0DIwIWOKe7rbpzT4PzICTXNXv732n
         i7kmZvSS8mkpFj8amrE1szaXeGAe73TqQjCeQZh2/YcWmMi6maPjpFnnIWmr44Pr5+nn
         I0ADB2oVd+wLTcVdGJueLfYyTpLEjriUlAdM5TVr8diPMxow4YRh3R9QZpe/eBaG4jcd
         REZk4bS82b3zKQLHnBJuFxRpHF5GIstJevtlKiFRmsUUKtXqtjs5lf6MYjBu3Ptg6Ssi
         EDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747125807; x=1747730607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0r9SjPagfNFQkslyQTfGS9Ycm3AlorAARH6C/r+EchE=;
        b=rVj/AD/Gipi0zIgHvXp/VLTSBNxIC6Y7H2o+xY+kxuT4Rta229BywvULL/EnMSH2v9
         0GixuKIaCWDI1ASXpJRt3uN1T+91aoSkWnh4+Pq5Z8PWGvN0Ucn+mHlh3RlA4I6+vXtS
         fxFxBWBy1j3WoDRfNPG3sm6X8RVe+W1EWth3QlNKcaUr0IdkD517HIGn7cgDymOuesag
         gV1lr0ZDcvehUNqmlA/Ble5re286HjZHdFHtmn+xwqrwPKumFPialCK9FznwUASVTAem
         MJEFhX6YLmNjMdkGiMiqb9NpcqWuzvMs8qNSfS82WfdIxtOeKkUtnMEU9tryYV2C1Cx0
         2EEg==
X-Forwarded-Encrypted: i=1; AJvYcCVkWqu1SZr/l5GZ1pdc6sI7IFROvHBSc7ynuTtnTO+lBAXwA5cesJGfUOjlHY+vF0ENSVOsBM0b@vger.kernel.org, AJvYcCW6NhZeNby8b/YaeEmBWiLA2DCLXyy3/xxWtnWAECRBt1DyWCUm62Bb6YMGJwhcYS7eCpn5ayFx8wKk+A4=@vger.kernel.org, AJvYcCXnABmTK0gB8qUg5u6ap90dtfpvvGqDKcZwbG0KJqs4eukXx1+aVYYtJ4C64xjkdviDQa0rLoNZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxAOWvMO1tiV9Un8YoHBo9+yKHewRQlogNZcZ0QxRQb/eNmI+GZ
	+nqSaZO8zDji8RKBRm76WUtWBhGYzrBoFO1IGqPZ2paArydHg7al
X-Gm-Gg: ASbGncs7FnGaQXH/eRlj0SQlfwFLN8RDU7w70D3iJn9ovVLWPXqUwHrRyiyW3oWOThW
	lI2XFxTxn5NRvDpu2dlucpz5mueF0NKOCAu/3AXwHJQrBRozlrnC4Xm41pEp2s7oxryucPNYFWR
	/B9PnYWT40PiPwece+7YXkHkkdNNcNQPIX1Yl6/8qoayIZxcfpUMa3m7PpK9A7L4cylMwFtkUyM
	JhfF3bkDDb1RmxxHhO9MZpyBebMd/sXyOnlFasWYet9sfO+33dAkhoEQXlZNUS+WU2UzpwWTnPW
	lc8r3/D38WEEgWl9RGbq8kU4t49lbil8QIaS528=
X-Google-Smtp-Source: AGHT+IGz63edBcJSmVH/MThA6NK/9To5w0eIvCMwZd+GCqoH9p60yoVQwuovufFZ7fYnUk7yseI/0g==
X-Received: by 2002:a17:907:2e19:b0:acb:1d24:a9e0 with SMTP id a640c23a62f3a-ad219ac5111mr476045366b.11.1747125806328;
        Tue, 13 May 2025 01:43:26 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21985127bsm737855066b.163.2025.05.13.01.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 01:43:25 -0700 (PDT)
Date: Tue, 13 May 2025 11:43:22 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Marek Vasut <marex@denx.de>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	jakob.unterwurzacher@cherry.de, stable@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: microchip: linearize skb for
 tail-tagging switches
Message-ID: <20250513084322.22354mkqmwxtlpy7@skbuf>
References: <20250512144416.3697054-1-jakob.unterwurzacher@cherry.de>
 <20250512144416.3697054-1-jakob.unterwurzacher@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512144416.3697054-1-jakob.unterwurzacher@cherry.de>
 <20250512144416.3697054-1-jakob.unterwurzacher@cherry.de>

On Mon, May 12, 2025 at 04:44:18PM +0200, Jakob Unterwurzacher wrote:
> The pointer arithmentic for accessing the tail tag only works
> for linear skbs.
> 
> For nonlinear skbs, it reads uninitialized memory inside the
> skb headroom, essentially randomizing the tag. I have observed
> it gets set to 6 most of the time.
> 
> Example where ksz9477_rcv thinks that the packet from port 1 comes from port 6
> (which does not exist for the ksz9896 that's in use), dropping the packet.
> Debug prints added by me (not included in this patch):
> 
> 	[  256.645337] ksz9477_rcv:323 tag0=6
> 	[  256.645349] skb len=47 headroom=78 headlen=0 tailroom=0
> 	               mac=(64,14) mac_len=14 net=(78,0) trans=78
> 	               shinfo(txflags=0 nr_frags=1 gso(size=0 type=0 segs=0))
> 	               csum(0x0 start=0 offset=0 ip_summed=0 complete_sw=0 valid=0 level=0)
> 	               hash(0x0 sw=0 l4=0) proto=0x00f8 pkttype=1 iif=3
> 	               priority=0x0 mark=0x0 alloc_cpu=0 vlan_all=0x0
> 	               encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
> 	[  256.645377] dev name=end1 feat=0x0002e10200114bb3
> 	[  256.645386] skb headroom: 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 	[  256.645395] skb headroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 	[  256.645403] skb headroom: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 	[  256.645411] skb headroom: 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 	[  256.645420] skb headroom: 00000040: ff ff ff ff ff ff 00 1c 19 f2 e2 db 08 06
> 	[  256.645428] skb frag:     00000000: 00 01 08 00 06 04 00 01 00 1c 19 f2 e2 db 0a 02
> 	[  256.645436] skb frag:     00000010: 00 83 00 00 00 00 00 00 0a 02 a0 2f 00 00 00 00
> 	[  256.645444] skb frag:     00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
> 	[  256.645452] ksz_common_rcv:92 dsa_conduit_find_user returned NULL
> 
> Call skb_linearize before trying to access the tag.
> 
> This patch fixes ksz9477_rcv which is used by the ksz9896 I have at
> hand, and also applies the same fix to ksz8795_rcv which seems to have
> the same problem.
> 
> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
> Cc: stable@vger.kernel.org
> Fixes: 016e43a26bab ("net: dsa: ksz: Add KSZ8795 tag code")
> Fixes: 8b8010fb7876 ("dsa: add support for Microchip KSZ tail tagging)
> ---

One of the blamed commits appeared in v4.13 and the other in v5.4.
I wondered whether separate patches should have been written, so that the
bug fix for the older commit could be independently backported further.
But then I looked at https://www.kernel.org/ and it seems that the
oldest supported LTS branch is 5.4, so that's irrelevant.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

