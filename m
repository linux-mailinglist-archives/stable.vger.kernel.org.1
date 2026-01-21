Return-Path: <stable+bounces-210770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PR3BxwMcWmPcQAAu9opvQ
	(envelope-from <stable+bounces-210770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:25:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE155A7CB
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7442F764BBA
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D52149253B;
	Wed, 21 Jan 2026 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LHSQhmKI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0240492539
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007232; cv=none; b=G/9w9q7Bdm7aFdigL7nA+HaL1f1IhGDv3DtsqPSJ4yxssshRWdVs7B4W2IpyeYr0CRRb0DifdJ0yu0zC7RqBIYORDOKiYf89VqnKktXJcuwiUYJjjxE1JdzvHVuOEwW4aJRxxBVD0Jk9RhbpVh5jLgZ4m/1Nrt9mDNnfzzGLh9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007232; c=relaxed/simple;
	bh=UM1OOg1U0/E601hoEGKdsDgk6hPSNzV/NgGStICXMdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEJnmAbV9MTgOC+/FZzgQ+bUwju3Nxy6wdylJlcmvGmIOes3PPGfA90Y8FsgrG1eCObFCGnTlwimhYeTCamj8931zl/QD9TA1Dz7u+GUaH8IK/aWbGBa4KGezq7X+F4tCGMnQ1Sf4i9ay4ILblYV47DkrdbGRESL5gKdje2yj30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LHSQhmKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EBCC4CEF1;
	Wed, 21 Jan 2026 14:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769007232;
	bh=UM1OOg1U0/E601hoEGKdsDgk6hPSNzV/NgGStICXMdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LHSQhmKIq3b+pw2OrTP2pgpdCi76MdWn9nblyI4T5GmEEc0Y3Ob6MA0ZZZXgGjYZ+
	 5/YdUqNHWdVFyT8l4Zxhyez4hrT5tVVygd/Ok/1IINlOGXbwgtH+eDFGhrZOu+dB3c
	 jew++J7WDxMnOAhfjLLzs3IBg8bVX7u5RehdFyVk=
Date: Wed, 21 Jan 2026 15:53:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yasushi SHOJI <yashi@spacecubics.com>
Cc: stable@vger.kernel.org
Subject: Re: SPI NOR: Request for Inclusion in v6.12
Message-ID: <2026012153-await-skinhead-786c@gregkh>
References: <CAGLTpnJhAgNThT=gWcpLEEFvNBwav+N=4Kf1yQK2O7T823MzEw@mail.gmail.com>
 <2026012000-sulphuric-carton-2253@gregkh>
 <CAGLTpnKv6SCs2v=ZPJ6AuQh5uWMw3JnuKP210N2jCa6NND-2tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGLTpnKv6SCs2v=ZPJ6AuQh5uWMw3JnuKP210N2jCa6NND-2tA@mail.gmail.com>
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210770-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: BCE155A7CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 03:06:01AM +0900, Yasushi SHOJI wrote:
> Hi Greg,
> 
> On Tue, Jan 20, 2026 at 8:00 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > That seems like a "new feature", why not just use the 6.18.y kernel tree
> > instead?  It is the next LTS release.
> 
> I understand the policy against new features in LTS. These fixes are for the
> S25FS-S family, which is an older part, and the original driver does not
> handle the SMPT and dummy-cycle behavior correctly for this family.

So it is not a regression where older kernels worked for this hardware,
good.

> I don’t have any issues using a newer kernel with the fix, but I thought
> it could be beneficial to others using this device.

Normally "simple" device ids are allowed, but not generally adding new
infrastructure just for new device enablement.

Please take a look at:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for the full rules.

thanks,

greg k-h

