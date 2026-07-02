Return-Path: <stable+bounces-270530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zQdUL3JwRmpnVAsAu9opvQ
	(envelope-from <stable+bounces-270530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 16:06:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 594A76F8AFC
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 16:06:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=aRebAApF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270530-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270530-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9F4D300AC8A
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 14:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC354C0427;
	Thu,  2 Jul 2026 14:06:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C78D4ADD9D
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 14:06:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001199; cv=none; b=e69FXrp7JLBlS8PwkYzbkeF7oJaEDCPzmBSc10lfsurw7SI2bA9ZfRL6asqsauJNImsoxyb1+aQap+s4JteQRmYLymL1R0JhBe1Qg6w9HtnmFoWqcBNnPlkzZcPMRRRVr3L4v2yuEv94e/qy5MYLw393j7A1ddZEPdLARmF/aTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001199; c=relaxed/simple;
	bh=QBvbOqincIxXhJ4V+ybUttC3yJEWzPT9MEGVDUtBfj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJDf9/zl/wd6Pdn3MLI4r9kdAsKy0bk83mbfMQpgt6kFks4pOp2fr43MEXIV53I2YkHhv2Xy4WDyLyFfbZM0TL41sFugrQt1e2pMuNg/GxLO911SWAvYy3XZnrqurJQ1yAHSNossQsvutVuNfarAA0g+DDnWeQg3/ti2td2uyt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aRebAApF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CFC1F000E9;
	Thu,  2 Jul 2026 14:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783001197;
	bh=9+PRrGX0q7rIZhmQvZ2SqH5QvL4xftI6TYnwQruRhDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aRebAApFUlly9YzQTPtaRrC1dJfKMHZNG1sPngDX/kRaDiriY3Zu0ybMSnWC6JNQV
	 vxHLUQI+87HZHLRpm0WzhjlA0drxrVGgArknipnfenULFak7658yaa7Vr6JacC/CM0
	 FeLoJls4ScUshFWPESidd4cf+u92SNRVcCpVIzgc=
Date: Thu, 2 Jul 2026 16:06:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
	Jon Humphreys <j-humphreys@ti.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v6.18 0/3] ARM: PREEMPT_RT backports
Message-ID: <2026070229-rendering-plus-be9d@gregkh>
References: <20260629144131.788576-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629144131.788576-1-bigeasy@linutronix.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270530-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:stable@vger.kernel.org,m:jan.kiszka@siemens.com,m:j-humphreys@ti.com,m:rmk+kernel@armlinux.org.uk,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 594A76F8AFC

On Mon, Jun 29, 2026 at 04:41:28PM +0200, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> ARM missed the PREEMPT_RT window for v6.18. The following three patches
> have been merged as of v7.1-rc1 and are the missing pieces.
> 
> I've been asked by people if it would be possible to include them in the
> stable tree as it would make their life easier.

Why can't the -rt patchset just include these?  Why put the burden on
us?

thanks,

greg k-h

