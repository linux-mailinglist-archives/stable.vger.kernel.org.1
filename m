Return-Path: <stable+bounces-230935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id q+BLA1IuyWm9vgUAu9opvQ
	(envelope-from <stable+bounces-230935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:51:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DBB3524CD
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17396300DD60
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF774314B6B;
	Sun, 29 Mar 2026 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e0EJq7J1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC92D2FFFA4
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774792266; cv=none; b=dxwscswvUpDphOyUgefeq1bb4SaIqPKj8+ktJDKpU5w8ws39j2ZfH2Kn/5tQg9No+jWkJ4XxFYp6nHx1iMehSjo8itM8eNjx0lAlpzxPKYRI5zIEa44rMcHUZWFMoCuMV4ikQxxI/8mrd9yhlAxxwhufHIoVll4wWOOnMRc4oj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774792266; c=relaxed/simple;
	bh=7oKY6ASZoRe4FMwiLkco8J8xWjsQos4VFMQCtabZups=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjsBZUs44Gx3R8qg93oa214R3dxhJJ1CdyNidNX53G54u6xQkbmzn7OAoD0rUTgM17bWjal8yrNqWUJFj/YtrFPNFeEJNY5Wt8i4co1clxylnZEaoj3/zXqpN6lTWLTkHll7cmG9yQKbfx3YLl/3NrBUqO7Ik3ECiRPwicL+yy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e0EJq7J1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F7FC116C6;
	Sun, 29 Mar 2026 13:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774792266;
	bh=7oKY6ASZoRe4FMwiLkco8J8xWjsQos4VFMQCtabZups=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0EJq7J1v7Trg4lvvitxmUknOo4LEqa5MoEUoL52RVk1cEeoqoV0mfFmqiIgdFEcb
	 IObb6Xf5kCNkV5+CcOyHI0kyknGs5gq6a+FWlpzWerD5QAjC/FezQdMdmLHkLmAGoE
	 eOu50zghBHT+xpj9siCeZLSFurN76j9xNdJw+vfk=
Date: Sun, 29 Mar 2026 15:50:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Sebasti=E1n?= Alba <sebasjosue84@gmail.com>
Cc: security@kernel.org, shuah@kernel.org, stable@vger.kernel.org
Subject: Re: [SECURITY] usbip: vhci: heap buffer overflow via crafted
 number_of_packets in RET_SUBMIT
Message-ID: <2026032911-unison-dehydrate-9c62@gregkh>
References: <20260329125437.517980-1-sebasjosue84@gmail.com>
 <2026032939-salt-cod-3bc2@gregkh>
 <CAJD=UNf9Ax4oZ9YTj8rr3jDWaGsXr4bX8uh2A-EE+w49QwSUaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD=UNf9Ax4oZ9YTj8rr3jDWaGsXr4bX8uh2A-EE+w49QwSUaQ@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230935-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61DBB3524CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 07:34:22AM -0600, Sebastián Alba wrote:
> Hi Greg, You're right...I see the patches from Kelvin and Nathan on
> linux-usb now. I should have checked lore before sending. No AI
> prompt, just manual auditing starting from CVE-2016-3955, but clearly
> others had the same idea this week.  Sorry for the noise, and thanks
> for pointing me in the right direction. I'll check linux-usb first
> next time.

Curious as to _why_ 3 different people all independantly decided to look
at CVE-2016-3955, a 10 year old CVE entry, and decide this week to poke
at this on their own and come up with almost the same exact issues.

What made that specific CVE stand out in the see of tens of thousands of
other kernel CVEs out there?

thanks,

greg k-h

