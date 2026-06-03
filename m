Return-Path: <stable+bounces-260066-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id adG1IAMfIGq7wAAAu9opvQ
	(envelope-from <stable+bounces-260066-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 14:33:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ECF6378B4
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 14:33:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=DPIN9cwY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260066-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260066-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29B22319804F
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 12:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D67947AF5F;
	Wed,  3 Jun 2026 12:14:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E992047A0C7;
	Wed,  3 Jun 2026 12:14:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488863; cv=none; b=P0pDdK4sEOC5jD7x0EVY0vXx8avdzSt5gvTB3QXnvWdFPVUtnF9tJJY/YcoUA2f1239+SNhxN6nMiQJfe3W2k6sj6Wut6+PMMaQr/FZVOTB3RSsO1+1mY7556+cdhJIsGgrnUvxhHWzR3JZpqesYb11Ljf5aoiuPI0ilP6jeJLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488863; c=relaxed/simple;
	bh=ecp/lSbBDLWot9cxl9gNP/hXGTWFwfWuFwwAIeisLPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfxGZ/vPjY2dZyJDjpSjkltVsZiQIDSZdzzt6795g8/vubD2LLoiRsZmCXRMSPFK+DEjS1EVjvo+443CLl+CKSQ3VttppSEs0dHj6Pr8eXns1thIHkH9qwv3ankNB3ziyNDW4Ah2qjhQExeQ/tp0Q0I6M/CGtZfbqdVzqLT5UBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DPIN9cwY; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=21k+Y4n0piSLPt2fCRUxvVVuj01IyABSXwVXelb/CIg=; b=DPIN9cwYJAYCpoxxuIM8bv9UFV
	bZO34l8lrFJpcxvapKHJ/9Dlt9yBurMjPrX9/xjSdZbUP8lfU6WlQ6Og/t29p8kmDH58QWf4KFY6K
	0HX6SxHNrDL+Tt9A2b//Ota5Jpn6ZVmq08L0RaNzGdchH9dlA2gQ7jN/eCuA/HlgfLhQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUkUA-005sAm-DI; Wed, 03 Jun 2026 14:14:14 +0200
Date: Wed, 3 Jun 2026 14:14:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>
Cc: stable <stable@vger.kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Friend <netdev@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: The backport of upstream ea5df88aeca1 introduces a regression on
 6.6.y stable
Message-ID: <57e60037-cce3-4f90-98e6-e8198518d59e@lunn.ch>
References: <CO6PR11MB55865EADC225FA57A8473BD4CD132@CO6PR11MB5586.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO6PR11MB55865EADC225FA57A8473BD4CD132@CO6PR11MB5586.namprd11.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260066-lists,stable=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Guocai.He.CN@windriver.com,m:stable@vger.kernel.org,m:horatiu.vultur@microchip.com,m:netdev@vger.kernel.org,m:sashal@kernel.org,m:kuba@kernel.org,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lunn.ch:mid,lunn.ch:from_mime,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9ECF6378B4

> On mainline, this check was removed by commit 1bc80d673087 ("phy: mscc:
> Use PHY_ID_MATCH_EXACT for VSC8584, VSC8582, VSC8575, VSC856X"), which
> was patch 1/2 of the same series. However, only patch 2/2 (ea5df88aeca1)
> was backported to 6.6.y, without its prerequisite.
> 
> Who know why? 

1bc80d673087 does not have a Fixes: tag. It is not supper clear it is
a dependency for the next patch.

GregKH, Sasha: Please add:

Fixes: 1bc80d673087 ("phy: mscc: Use PHY_ID_MATCH_EXACT for VSC8584, VSC8582, VSC8575, VSC856X")

to stable.

Thanks
	Andrew

