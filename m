Return-Path: <stable+bounces-267354-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iJFtG7EPNWoSmgYAu9opvQ
	(envelope-from <stable+bounces-267354-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 11:45:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD13F6A5067
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 11:45:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=NWSvqS5p;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267354-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267354-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD32A3037460
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 09:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296AA357A3E;
	Fri, 19 Jun 2026 09:45:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E961366822;
	Fri, 19 Jun 2026 09:45:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862318; cv=none; b=MwLJBM7EyVOD09oEsVWqcDcgyvyvidLjhPO9zxyi6foqLJBkeMGfZIIpsr/sfl54HR791KnpCIKGZCruPxLdQ9JzTlyK5v+AQatNnEiEZ103i2lZGWJsBL0zgrZwy2Bh0IvMPmYDySD8T8BZt8RLUo6VZyFfdXNr2gVOGYmx8qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862318; c=relaxed/simple;
	bh=obdpRo0ogAjWXFAkqOFEE8mCJ1sCj0yKT/AlIb8xq2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0xi9NctIVOhfoRLBaTDVgTzNXLuoTW6toveaRwp/WmBFrdB8IKyhKS0lVLnNx7JH7uRSFTCH8MlFRpBQq4RyUU2hna70ZoNb2XnpExgwxF6T59pLjyN/GlwbKtkmsfpZWdcm3di1GEsXzYoJqDHUu0ixq1Vz2aaZk0BMcdX7Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NWSvqS5p; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFEC1F000E9;
	Fri, 19 Jun 2026 09:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781862316;
	bh=8+Sa/N67cJo001PZ8IqzIcW5H7n609g+rImu0Ta51p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NWSvqS5pVnS4Mc2V10iBOCjrW1uWCuGSZvvXnlLN7DgIwFjZzSlusbmhiKlSAIICY
	 +Uo/N1t0ZQaGyG4Vb76W9IikBSDj/GyMMysGkvxQnCS0hIo5G4aKRwqJZ/OV0OFpeL
	 hisC18hsu7memuyph6zBCUj9uPLlShODDroinjHM=
Date: Fri, 19 Jun 2026 11:44:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	Grant Grundler <grundler@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 249/522] r8152: Block future register access if
 register access fails
Message-ID: <2026061958-bonding-sullen-424d@gregkh>
References: <20260616145125.307082728@linuxfoundation.org>
 <20260616145137.622836614@linuxfoundation.org>
 <afe207eb91522718cfae8b77310999ca397c81bf.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afe207eb91522718cfae8b77310999ca397c81bf.camel@decadent.org.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267354-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ben@decadent.org.uk,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:dianders@chromium.org,m:grundler@chromium.org,m:davem@davemloft.net,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,chromium.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD13F6A5067

On Thu, Jun 18, 2026 at 07:25:39PM +0200, Ben Hutchings wrote:
> On Tue, 2026-06-16 at 20:26 +0530, Greg Kroah-Hartman wrote:
> > 6.1-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Douglas Anderson <dianders@chromium.org>
> > 
> > [ Upstream commit d9962b0d42029bcb40fe3c38bce06d1870fa4df4 ]
> [...]
> 
> This needs a further fix on top: commit e62adaeecdc6 "r8152: Hold the
> rtnl_lock for all of reset".

Already queued up in this tree.

thanks,

greg k-h

