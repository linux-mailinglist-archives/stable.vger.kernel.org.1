Return-Path: <stable+bounces-9160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA4682158B
	for <lists+stable@lfdr.de>; Mon,  1 Jan 2024 23:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FD61C20F22
	for <lists+stable@lfdr.de>; Mon,  1 Jan 2024 22:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7CEE558;
	Mon,  1 Jan 2024 22:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="Bi+EMzJu"
X-Original-To: stable@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48054E54D;
	Mon,  1 Jan 2024 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WzE+7UWIzKuUxCweY/khq4/xWZsw/9PPWQykX2hyH6A=; b=Bi+EMzJur/rwE7Vl92/duaXADw
	hgi38A7FSUz4btk3VdXWnsCZGOTgTP4EEIFvmPLNLbtws8qqhaj1kpv+g+60MT5ODHJLdbi+eJ2VB
	jj2D669P+wutWsrKFKZ/jy4jeSKd54pNDWaL6AlHb+jVhTF9WATJwK+KW8UKYH8Y0f5de2wi55MEB
	28Y6gf7Yoz++wAa2sJmjI2QeT3UBYQ3Anxiv8Ec9axpeIIt8PQHc4+Svr9NdANmd59nqnW+ucliw2
	9SfRvWPZS+Gl6dU8nVPdQTSefkaruycpPTIG7r2mnYgbSIp3hMCmgqNoMrf0cCvgSTV9EdvqhO/r0
	1w7Gj5+w==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97)
	(envelope-from <phil@nwl.cc>)
	id 1rKQU1-000000007qB-3ZEJ;
	Mon, 01 Jan 2024 23:10:05 +0100
Date: Mon, 1 Jan 2024 23:10:05 +0100
From: Phil Sutter <phil@nwl.cc>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] rtnetlink: allow to set iface down before enslaving
 it
Message-ID: <ZZM4Pa3KuD0uaTkx@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	stable@vger.kernel.org
References: <20231229100835.3996906-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229100835.3996906-1-nicolas.dichtel@6wind.com>

On Fri, Dec 29, 2023 at 11:08:35AM +0100, Nicolas Dichtel wrote:
> The below commit adds support for:
> > ip link set dummy0 down
> > ip link set dummy0 master bond0 up
> 
> but breaks the opposite:
> > ip link set dummy0 up
> > ip link set dummy0 master bond0 down
> 
> Let's add a workaround to have both commands working.
> 
> Cc: stable@vger.kernel.org
> Fixes: a4abfa627c38 ("net: rtnetlink: Enslave device before bringing it up")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  net/core/rtnetlink.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index e8431c6c8490..dd79693c2d91 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -2905,6 +2905,14 @@ static int do_setlink(const struct sk_buff *skb,
>  		call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
>  	}
>  
> +	/* Backward compat: enable to set interface down before enslaving it */
> +	if (!(ifm->ifi_flags & IFF_UP) && ifm->ifi_change & IFF_UP) {
> +		err = dev_change_flags(dev, rtnl_dev_combine_flags(dev, ifm),
> +				       extack);
> +		if (err < 0)
> +			goto errout;
> +	}
> +
>  	if (tb[IFLA_MASTER]) {
>  		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
>  		if (err)

Doesn't this merely revert to the old behaviour of setting the interface
up before enslaving if both IFF_UP and IFLA_MASTER are present? Did you
test this with a bond-type master?

Cheers, Phil

