Return-Path: <stable+bounces-262873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1UhYB0C4K2qvCwQAu9opvQ
	(envelope-from <stable+bounces-262873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 09:41:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F145677562
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 09:41:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=aksgN5F2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262873-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262873-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09DD03015794
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83053E16B7;
	Fri, 12 Jun 2026 07:39:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE63E171F
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 07:39:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249962; cv=none; b=hmYtUzwK7b/nL1hGTacmu3c092k4QoFYig3egI0TQcbz0AS6yQWRrZaOc9W7+/SE85ws8+kD/yEuUEDgP4WDiiH4A58oQ+l8f90Hwgk5V2idU7EPscuOJRnIYBEhpbO3A5bk4ypw0OzTt8rKMNqFDlW83c+c9f29xVZM76plKrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249962; c=relaxed/simple;
	bh=2rgUav12Rj9lvJhtrsfA/UmwOZaNrAeAdtJ+A3GSaCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVGTfutSdO7ntxfSESc9HjGG77dBZyu4QCTKaSMPErpleXB6cR/aDxpPxXMoGplK2mIjj5Lwr6aoSKFq+9t870B1o98LZXaAcWeXs0doaXrghHZPR6rOIl8zgAM3ojSwgHoh4oLOGspzzu7j1s71uP8iMrmtukSh5YYdXemlhgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aksgN5F2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F831F000E9;
	Fri, 12 Jun 2026 07:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781249958;
	bh=WbdSxAPr7LvFZGaMW88nAvqMlgGrpjatoEXO8sux2To=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aksgN5F25pWWHrrDWL8v3Cl24ZXsqtba1+1WhhOtcsiBqIKuYPqTTrXBxO+kqX5tV
	 /4UUGgOA2UgfSAAbud9q9Dlw1u8+h2f3yQl2FbCbh37qHUlPdIgjopTfuP3ztpjgIr
	 DxfQO4Xl6TDuoKh1Ktnu941iUlU8zCTTXhx+J3v0=
Date: Fri, 12 Jun 2026 09:38:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Zhenpeng (Leo) Lin" <leo@depthfirst.com>
Cc: security@kernel.org, stable@vger.kernel.org,
	disclosures <disclosures@depthfirst.com>
Subject: Re: Exploitable reuseport cBPF UAF fixed in mainline but not
 backported to any stable/LTS
Message-ID: <2026061225-brisket-quickly-94b2@gregkh>
References: <CALPOzVk0gD2GnBjiPDQBfjsrf4b0hY3++KcOiaTV8gSFEifV6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALPOzVk0gD2GnBjiPDQBfjsrf4b0hY3++KcOiaTV8gSFEifV6g@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262873-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leo@depthfirst.com,m:security@kernel.org,m:stable@vger.kernel.org,m:disclosures@depthfirst.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F145677562

On Thu, Jun 11, 2026 at 03:01:15PM -0700, Zhenpeng (Leo) Lin wrote:
> Hello Linux kernel security team,

You also sent this to a public mailing list for some reason...

> Fix
> ---
> - Mainline commit 18fc650ccd7f ("bpf: Free reuseport cBPF prog after
>   RCU grace period.", Kuniyuki Iwashima), first released in v7.1-rc3.
>   It defers the cBPF free with call_rcu().

That commit has been queued up already for the next round of stable
kernel releases.

Next time, if you wish to have a commit applied to older kernels, please
take a look at:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

thanks,

greg k-h

