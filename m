Return-Path: <stable+bounces-268556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YDeRB3c0PWryywgAu9opvQ
	(envelope-from <stable+bounces-268556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:00:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2476C6567
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:00:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=mXQzo0Ci;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268556-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268556-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D7B2304DE86
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5D4349CC4;
	Thu, 25 Jun 2026 13:59:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE707347533;
	Thu, 25 Jun 2026 13:58:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395940; cv=none; b=ehCym39iedtXFbAtl+XwCOJ+qRzXDbBkqWloCE+n8FRsOb0nR4DfusV1yyK506LIAfdRtyREyT8PQKhj/xxmqzk/PVZqLfUKh8SOLtP1V94R+TkCOqJ/DFcK33RAbVwhx12HrgfVG6Lz3KshnKAkDlMiizG+ZcO8NsNwl9NvCTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395940; c=relaxed/simple;
	bh=arpdqMBK1DxE/UaBLFUczloVuJe10Z7gXUNKH0YnAWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXqH4dWtUbivzEY/0uyijcUhI6uKXD03o+zfu+GSJZKhlWJxXISiXP5yGMwNeRe7zjlIXWQZiLErC6Jv5HIWid4ngFjnS36iikD2V6uGNRfJXR7B/+rz2mlt9R3Q94cyCIV5fn3GRMI/Y+9znevOVPJ835qBiLKTKNB3FkNfJJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mXQzo0Ci; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DB01F00A3A;
	Thu, 25 Jun 2026 13:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782395939;
	bh=arpdqMBK1DxE/UaBLFUczloVuJe10Z7gXUNKH0YnAWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mXQzo0Ci6B+5FklRLX6RHmJ3tGv70wTykauTZlTM26stpjQXIaUvACeAeACufGn0j
	 7smCtpVWQTvrCyIU9KEvRxndZGhjNLpbnT9xMUpGXa5XB/e7HC+rDqkEqeqCK1WC9j
	 QKlz9wFjqbnB0Tzguxd4k80V+Bnsv76hBk7I5sMU=
Date: Thu, 25 Jun 2026 14:57:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Adrian Korwel <adriank20047@gmail.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_uac1_legacy: fix use-after-free in
 gaudio_open_snd_dev()
Message-ID: <2026062524-puritan-satin-f415@gregkh>
References: <CADgB2mFBdTbad5+W=bDOMO+fe1S4jg+aCNjkgd3B3Guq0WFQdw@mail.gmail.com>
 <2026052528-resupply-fanatic-496a@gregkh>
 <CADgB2mH8VayssgQmuyfMJn8Vv-o8_udfL6msVGrHrL1hO9nd4g@mail.gmail.com>
 <CADgB2mHJG5dJwzjBML08C4yDUqLHJY=Vmv6yffiiczc98hqnNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADgB2mHJG5dJwzjBML08C4yDUqLHJY=Vmv6yffiiczc98hqnNA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-268556-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:adriank20047@gmail.com,m:linux-usb@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D2476C6567

On Mon, May 25, 2026 at 09:33:12AM -0500, Adrian Korwel wrote:
> [PATCH v3 1/4] usb: gadget: f_uac1_legacy: fix file handle leaks in
> gaudio_open_snd_dev()

This should be in the subject line, not in the body of the emails.

Please resend a new version of all of these in the correct format.

thanks,

greg k-h

