Return-Path: <stable+bounces-272880-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4rUCLbCCT2q4iQIAu9opvQ
	(envelope-from <stable+bounces-272880-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 13:14:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C61277301B9
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 13:14:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=KeVOrZr9;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272880-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272880-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 171223010CCD
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2802740BCBB;
	Thu,  9 Jul 2026 11:04:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF2131ED83;
	Thu,  9 Jul 2026 11:04:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595047; cv=none; b=mS5AjW7thYvK8w4q/Dm6RAjqHbXznx5IernkDJypyePGd7OKwnhkS3bgRPdICAc6G/enzkiY+JrhFiHtk5EysDZM5srdZNHOQRott//Qzv2nZhva7TbusEXAGF4tpa511be/TeQoFVXIfpD57n4BnpHGJfOcJJURD1AhidPhAeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595047; c=relaxed/simple;
	bh=a0Siylbpou4kYnKcPL7wNvEXfvWgd5TCFMcUKiXyTl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqkHAEawIxdVqRUvW65J6nlZMyis9zbLiW8LV7APaN1ICBIZzAdDJYPCbvdrBcfNp+U9ZhtKKFKhpWo9+ZNymbzACeH0wxL8EZnQ6aaq21f/iMS1LjTir5pqmZ7f+v1+Qt2FwZP3jb0rJmCdUo0bgOb4WsEnPZHQ+8Soi39CK6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KeVOrZr9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EFF1F000E9;
	Thu,  9 Jul 2026 11:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783595046;
	bh=jaqLbl+X8iIgOO/YVJKeKF+iO97X7C5yc74usd3ZoMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KeVOrZr9G+Tl9U4Y53ZLTpbeQZr2VooekAi15A5lP9PRGFkCn5iXglCpjnjOQkvzd
	 N2/dCqdBLSwxZT3A0XyNGlUnWX2XamduTJBftZqFkm9OsCz9pSNQo88JCoGs5szn5V
	 r57H8f563WbujTtAC/TazuCLhV930BEbM33tq8Sk=
Date: Thu, 9 Jul 2026 13:04:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ujjal Roy <royujjal@gmail.com>
Cc: Linux Stable <stable@vger.kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>,
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
Message-ID: <2026070925-delay-gauntlet-bc7c@gregkh>
References: <20260709101327.9508-1-royujjal@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709101327.9508-1-royujjal@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:royujjal@gmail.com,m:stable@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:shuah@kernel.org,m:aroulin@nvidia.com,m:yongwang@nvidia.com,m:petrm@nvidia.com,m:ujjal@alumnux.com,m:bridge@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-272880-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gregkh:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C61277301B9

On Thu, Jul 09, 2026 at 10:13:27AM +0000, Ujjal Roy wrote:
> Hi Greg,
> 
> Please consider backporting the following bridge multicast fix series to 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.0.y.
> 
> 726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation")
> 12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()")
> 95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields")
> e51560f4220a ("ipv6: mld: encode multicast exponential fields")
> 529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field encoding tests")

Why is any of this needed in older kernels?

And 7.0.y is long end-of-life.

And why, if this does fix issues, was it not tagged for stable to start
with?

thanks,

greg k-h

