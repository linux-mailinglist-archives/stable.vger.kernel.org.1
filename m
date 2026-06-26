Return-Path: <stable+bounces-269226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 17nFOUOoPmonJwkAu9opvQ
	(envelope-from <stable+bounces-269226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:26:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8456CF061
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:26:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=lRXeUkqi;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269226-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269226-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EC5830E4D3E
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557B1403EBD;
	Fri, 26 Jun 2026 16:13:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB93FCB1C;
	Fri, 26 Jun 2026 16:12:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490381; cv=none; b=AGqdN3aZ+4RUhAMaZgTnDaPJe8AVr/6YTFf16sZbcHSp7+THzHDSk3LmWx5EESNy+6Na9cbFTKUgXhNY9RMoxnYo2KRaIPlN79yszlCUE/9PdDXjqQVjKO+KQtwOdyUm/WvqMLbzKaXZRZdRLCNoGkJbIOfleXzOuCWlCOB4e3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490381; c=relaxed/simple;
	bh=xF3HrPGp083qdUeM2OV7hUzimRdrJZF7dHbq8z77FXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuWNY7xGwjGNgx9r6VwaiEnelFm+lXOCIEaRnQ6FQlduWx5TOveKESTu5se47y+0J0qJsR7xtSbWRmjb8EWl7qm3QcQtesm0ofSAJJWUg4bdAoZdafQkHUN+TAhFRVcI7j76Tt4HHN+nYzkSAxeUgycB44uULQ6nrPC9ryZfQX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lRXeUkqi; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nGwr4lXo5Wqpnzr+aOKYM/r+chKEzwjv6CwiudH1p4c=; b=lRXeUkqivNlZY17nLYk69L4/Lu
	8ksK7vXiChUEftTGQYw6AWXgV2EQMCJk5b3dUs7VKPwbSVzqpZxCUP2VhHtUPDPHG8LBbLZSdDpXi
	YqtuoTbhpzkPI5mIeZYxnyLn3hvc9LHhSIVLPG7tHE1UQ16dd9/p+DVA+fPDPeaN6BNw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wd9Ad-009OI3-Bh; Fri, 26 Jun 2026 18:12:47 +0200
Date: Fri, 26 Jun 2026 18:12:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix: net: mediatek: mtk_star_mdio_init: fix double
 of_node_put after   devm_of_mdiobus_register
Message-ID: <1d62a7bc-d0e9-4b76-9e7c-3fd01647d854@lunn.ch>
References: <20260626152009.51599-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626152009.51599-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269226-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:daniel@iogearbox.net,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A8456CF061

On Fri, Jun 26, 2026 at 11:20:09PM +0800, WenTao Liang wrote:
> After devm_of_mdiobus_register succeeds, the mdio_node reference
>   ownership is transferred to the mii_bus device (released via
>   mdiobus_release on device teardown). However, the function
>   unconditionally calls of_node_put(mdio_node) after registration, causing
>   a double put.
> 
> Only call of_node_put when devm_of_mdiobus_register fails (i.e., when
>   ownership was not transferred). On success, the bus driver manages the
>   reference lifecycle.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9ed0a3fac08b ("net: ethernet: mtk-star-emac: use devm_of_mdiobus_register()")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>


    Andrew

---
pw-bot: cr

