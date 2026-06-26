Return-Path: <stable+bounces-269084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ddpNKsulPmpnJgkAu9opvQ
	(envelope-from <stable+bounces-269084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:16:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0F26CEE05
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:16:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=Sio4tBw2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269084-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269084-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5595630E255D
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3093FA5E6;
	Fri, 26 Jun 2026 16:11:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD5F3F99E5;
	Fri, 26 Jun 2026 16:11:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490297; cv=none; b=ReSD/xsm46pV9ByRQMA5gyn2CCIZaQGXijHdlBMvfRQ5H8tQnmAJJQZaI+ZUEL4iVY00CrgamkKuBkUvr/HkItKYOQPNSWyVOPY1l3pkUQbHmF0qUxySu1qD6fszwxxoyULyqfaeUHTfKo2LU/30o/R3/26+C+2HlYRNE2DirGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490297; c=relaxed/simple;
	bh=v/xtA6lKsmOo4sGuIQCBILfM1fTqp2X4TK4qOq1hJYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncqk/feD/ey7vVX+PeS/g0YJCsHiNlIGHbiqIVRpLew//8Mt3K7pryv2w8Eric/0rJvtQ/JEVFhcuUc+PRYO6KdD++w861EG/rw26ldnsrwAJDr9d65DTPxZQCPxtUqIKuTGKBcSxgu69fZsWJaJII4Kvs+ns6Y/mCnvcCxOX6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Sio4tBw2; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KvTW42MNJMvmiaxA36D15Hj/y7V1IlN7NJdDL8uPPds=; b=Sio4tBw2XzlIAwKnA2dOP+7mXy
	bxIcI+UhhGjLIkLPxWk7S0zy84J/XyffKZ38xEcWXmsog4gBB4Vejx8OFutdRINaKEVt5F3y3ruli
	25lu+yUqUUzGTI1NAq+3uNQsQCu1q3qgp0915Iqkm0SOXVnW20PpHG44qJZcZ+YTh3lw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wd99K-009OFF-Lj; Fri, 26 Jun 2026 18:11:26 +0200
Date: Fri, 26 Jun 2026 18:11:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix: net: phy: phy_sfp_probe: fix kref leak when
 phy_setup_sfp_port fails   after sfp_bus_add_upstream
Message-ID: <e8f1d4b5-ddf3-43ab-a324-8325582b2d20@lunn.ch>
References: <20260626153443.52842-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626153443.52842-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269084-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,vger.kernel.org,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C0F26CEE05

On Fri, Jun 26, 2026 at 11:34:43PM +0800, WenTao Liang wrote:
> sfp_bus_add_upstream unconditionally acquires a kref on the SFP bus. When
>   this call succeeds but the subsequent phy_setup_sfp_port fails, the error
>   path returns without releasing the upstream reference. Since probe fails,
>   the device's remove function (which would normally clean this up) will
>   never be called, permanently leaking the kref.
> 
> Call sfp_bus_del_upstream on the error path after a successful
>   sfp_bus_add_upstream to properly release the upstream reference.
> 
> Cc: stable@vger.kernel.org
> Fixes: 298e54fa810e ("net: phy: add core phylib sfp support")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>


    Andrew

---
pw-bot: cr

