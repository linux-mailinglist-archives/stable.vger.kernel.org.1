Return-Path: <stable+bounces-227761-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PDTNCF7vmnpQgMAu9opvQ
	(envelope-from <stable+bounces-227761-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 12:04:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DB82E4E82
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 12:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55DFE30142B4
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026F03009D6;
	Sat, 21 Mar 2026 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HLONG1UC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A6248873;
	Sat, 21 Mar 2026 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774091021; cv=none; b=FOJU9X4k9W4Bo9tBNny7CjwpY71Mhtuc9u90HSy1dG4fGBt9uOSQ23dInJLpT9zbg002iKUbGLe8suBUDIWhzzD+zemRLM/ECG8fPprnCL59AWzoJzjtIlsD3EJ1PtdHuAk+bUpqs+/Y59AGXg6pbm1ohnefT/iGwoNrpNkKeqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774091021; c=relaxed/simple;
	bh=6kVNx+dmhdA0XwggHUyGvys0BRv5ebJBpSOk+XGn//4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toOmi6jxSEWCKP3geb2cwTR12AtdgDeRCja0udsFpEtp78t8f+nBgx1TGf124E+lDdXDonOcC1RepAO/XOHCYNqvhji0pSMU+aIS3Gr2CDaool38Wuz7cYgqdCtL3DZ5cPh+42hrQCigRgLgh074QMD/kSFZw0wUZDY/iOx+7EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HLONG1UC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D72C19421;
	Sat, 21 Mar 2026 11:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774091021;
	bh=6kVNx+dmhdA0XwggHUyGvys0BRv5ebJBpSOk+XGn//4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLONG1UCfHPh3TqeeEkqowiNxHe7oAMisx95+D2FngVS5bAkOwSddVeIBAHzDrlWl
	 0/gPle5Tvt5a4/bewPW/EHSi4QrIDx7gQwZP4h69pEbl7eexovf3uwRvv1p1uPgq/5
	 KbTAFfrHIMT1kl2fqJ3CbmqvAwTC7OVUsOnPhGyI=
Date: Sat, 21 Mar 2026 12:03:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: stable@vger.kernel.org, frederic@kernel.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, rdunlap@infradead.org,
	ptesarik@suse.com, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 6.12.y 2/7] timers/migration: Annotate accesses to
 ignore flag
Message-ID: <2026032135-statute-factor-34cc@gregkh>
References: <20260321102440.27782-1-ionut.nechita@windriver.com>
 <20260321102440.27782-3-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321102440.27782-3-ionut.nechita@windriver.com>
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-227761-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,windriver.com:email]
X-Rspamd-Queue-Id: 38DB82E4E82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 12:24:35PM +0200, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>

Why is this here?

And again, you did not send this properly, work with your kernel team to
learn the proper process, I've been over this multiple times with them
in the past...

greg k-h

