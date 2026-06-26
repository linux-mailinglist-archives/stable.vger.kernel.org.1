Return-Path: <stable+bounces-269097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xlQIBTmmPmqTJgkAu9opvQ
	(envelope-from <stable+bounces-269097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:18:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AE16CEE86
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:18:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=Yn4oRXpK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269097-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269097-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40DA33103811
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1781F3FC5D8;
	Fri, 26 Jun 2026 16:11:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999B3FB7E7;
	Fri, 26 Jun 2026 16:11:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490305; cv=none; b=Cuakw14ZMjABHhWEIdGsmrY7TAp15TxuarxVnVEYx+Fc/ZLeAjYyooogheQNhkpsSdGqVBkkJNxgAU+rLQtQ1vurHV+Z0v5nMIu/DE05v9UDjbp0GHSeX5lBjIxzlhZEkKd6IFlARPcJGVJoXlYCD7OY/I63CVjVjiVIZ8IsscY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490305; c=relaxed/simple;
	bh=YnZKaj/D6xVa2eujjfkHOSF27gC5cJLnFQ9E+pFtgcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UG/YnLMsZdmx1LDO4anwQ85E6CqEoqWuEY+rPH+cTrisTTU0EFofj5dUqmPcwSB4TtHP8Jw0F55fYpnU11Z66n3Xq41jCYW+OyasF/6zy8EjNXDZtF8zuLXMbCemiP1OFvFeOCxDxgYK2Ar5mZLIPsoMesLTYNhz5sKwVd1Wxkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Yn4oRXpK; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9gOPXWRomD/FZK60G4OxsHyJyeEtdOeZ7ufT5+pyHYE=; b=Yn4oRXpK66sgvD6/shL26HPCDy
	vfAVP3xtpBl1RSZN2AxH72Ft9Wf1LIHMbd4bofsKb/086TQsUp18Bj63o3FSkFYs6Ze8EVmdbSFf+
	xLygXFc9Nl25qtgUVSb+BS6u+YiFf+NMqrrZ/RbsOsx9/VDQ+DDK9yWnQ1CGNzn2QWC4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wd99V-009OFo-GN; Fri, 26 Jun 2026 18:11:37 +0200
Date: Fri, 26 Jun 2026 18:11:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix: net: mdio: of_phy_register_fixed_link: fix
 phy_device reference leak   via discarded pointer
Message-ID: <b46b4c79-36bc-4aaa-8708-d5939ab84e68@lunn.ch>
References: <20260626153330.52741-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626153330.52741-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269097-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81AE16CEE86

On Fri, Jun 26, 2026 at 11:33:30PM +0800, WenTao Liang wrote:
> fixed_phy_register returns a struct phy_device pointer with a held
>   reference on success. However, the register_phy label discards the
>   pointer via PTR_ERR_OR_ZERO, and the phy_device's fwnode is not set, so
>   of_phy_deregister_fixed_link cannot find the device via
>   bus_find_device_by_fwnode to clean it up. This permanently leaks the
>   phy_device and its device_node reference.
> 
> Store the returned phy_device pointer and set dev->fwnode so the
>   deregister path can properly locate and clean it up.
> 
> Cc: stable@vger.kernel.org
> Fixes: 24c30dbbcdda ("of/mdio: Add support function for Ethernet fixed-link property")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>


    Andrew

---
pw-bot: cr

