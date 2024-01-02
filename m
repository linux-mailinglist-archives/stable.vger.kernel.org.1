Return-Path: <stable+bounces-9222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DC582247E
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 23:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3221C22D2E
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 22:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A28168DE;
	Tue,  2 Jan 2024 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="Y/R2foUS"
X-Original-To: stable@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38900171C1;
	Tue,  2 Jan 2024 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1PgZFrMBASg1AS22jMwhLvG35lZ6LMB42bW4jc0bFuI=; b=Y/R2foUSDf9jPhP+OFiswdELaW
	7ch2N5BKZWnEipbEVLWOqtrEdp7ZyH1YtOvX9ZlVBHYoICqdHOld/0jrKLJsJ14Spcsr4oSqPMS+r
	JzjpXKoH4VqXQZOZgY4U6Oj4JNvELhjVN6zsY7Zsz1TmJEOe84uTurvyIQPwAHYp7PhzPPzGLo3KE
	FEpwZwKfBrhbFrq98U85c1upXTsJTZS3C0IBv9bSgiKihReqKj5Pu9xL03gSvwUx2ODqublSQrzyf
	9ttjowmk/RrgKhehZY/7hYjYH3AzmRw0MWQAB97gvJwJCtZI9X2g+9RKATsMAOeqWvlz3K9iqSxVz
	Kq4pqZTg==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97)
	(envelope-from <phil@nwl.cc>)
	id 1rKmqm-000000001Af-3vqt;
	Tue, 02 Jan 2024 23:03:04 +0100
Date: Tue, 2 Jan 2024 23:03:04 +0100
From: Phil Sutter <phil@nwl.cc>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] rtnetlink: allow to set iface down before enslaving
 it
Message-ID: <ZZSIGBWSaK2-sqoI@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	stable@vger.kernel.org
References: <20231229100835.3996906-1-nicolas.dichtel@6wind.com>
 <ZZM4Pa3KuD0uaTkx@orbyte.nwl.cc>
 <a5282f4c-21e5-4c1e-b0bb-10f222453099@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5282f4c-21e5-4c1e-b0bb-10f222453099@6wind.com>

On Tue, Jan 02, 2024 at 01:14:21PM +0100, Nicolas Dichtel wrote:
> Le 01/01/2024 à 23:10, Phil Sutter a écrit :
> > On Fri, Dec 29, 2023 at 11:08:35AM +0100, Nicolas Dichtel wrote:
> >> The below commit adds support for:
> >>> ip link set dummy0 down
> >>> ip link set dummy0 master bond0 up
> >>
> >> but breaks the opposite:
> >>> ip link set dummy0 up
> >>> ip link set dummy0 master bond0 down
> >>
> >> Let's add a workaround to have both commands working.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: a4abfa627c38 ("net: rtnetlink: Enslave device before bringing it up")
> >> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> >> ---
> >>  net/core/rtnetlink.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> >> index e8431c6c8490..dd79693c2d91 100644
> >> --- a/net/core/rtnetlink.c
> >> +++ b/net/core/rtnetlink.c
> >> @@ -2905,6 +2905,14 @@ static int do_setlink(const struct sk_buff *skb,
> >>  		call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
> >>  	}
> >>  
> >> +	/* Backward compat: enable to set interface down before enslaving it */
> >> +	if (!(ifm->ifi_flags & IFF_UP) && ifm->ifi_change & IFF_UP) {
> >> +		err = dev_change_flags(dev, rtnl_dev_combine_flags(dev, ifm),
> >> +				       extack);
> >> +		if (err < 0)
> >> +			goto errout;
> >> +	}
> >> +
> >>  	if (tb[IFLA_MASTER]) {
> >>  		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
> >>  		if (err)
> > 
> > Doesn't this merely revert to the old behaviour of setting the interface
> > up before enslaving if both IFF_UP and IFLA_MASTER are present? Did you
> > test this with a bond-type master?
> Yes, both command sequences (cf commit log) work after the patch.
> dev_change_flags() is called before do_set_master() only if the user asks to
> remove the flag IFF_UP.

Ah, indeed! I should have looked at rtnl_dev_combine_flags() before
commenting. When submitting v2, feel free to add my:

Acked-by: Phil Sutter <phil@nwl.cc>

Thanks, Phil

