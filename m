Return-Path: <stable+bounces-215788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPv7IchpjGkMnQAAu9opvQ
	(envelope-from <stable+bounces-215788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:36:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECFF123E7C
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6152C3004F2E
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 11:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEA3313E3F;
	Wed, 11 Feb 2026 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0u8pwUwt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AA830C619;
	Wed, 11 Feb 2026 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770809797; cv=none; b=NKhhFZJaQWo7pr6KXvUPOXPJpEhQld0VNT9sdZ56EcA+91qUpUeJ8EGDJaJNhlWXRWB7zF31iGu9I0F6bwthjwmyU1ekxq0MkkhhQDiCBimVXUSXSu722+RxKp9ymNsiLnhE59zzeR0f/TtJgrRqKv3oYfy9jl6kwFjFUSitg/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770809797; c=relaxed/simple;
	bh=c4EqE2T5SQrK01U31W3LSH6KAjqHP9jpEV6DCU/uYIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0vqN4b4B6eo84AujszmWoUNGlHO+3njJOCdotuVtvgyKONd+y1BCcTz2uIDDBQSUt+zhQkFbzozfDZY7od8Q/PBw14VVx6e0J8GZ7jEZDbYU8l2D15Xqa9untFn9RDQtgb9x2Dd8OPwgmNXrQNRE1qe3NlQ9D/ua1kw0GL1w9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0u8pwUwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E56C4CEF7;
	Wed, 11 Feb 2026 11:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770809797;
	bh=c4EqE2T5SQrK01U31W3LSH6KAjqHP9jpEV6DCU/uYIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0u8pwUwtV2RVOhchGo5NjWhS6x7CSlCpXlK8PKNPotI3A66CHc4buWTlXPd/RGdgh
	 eZMCP6NonX9OMZrFG87ALH8T4+oYEaEvZ6lMX+RSO7naxiPuLSwjjbmNSj3KxWhH66
	 YFvCTZ8Jbx02no3cEDVnBII2Qmh3qEUfECCKMJK4=
Date: Wed, 11 Feb 2026 12:36:33 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 519/567] gpiolib: acpi: Move quirks to a separate
 file
Message-ID: <2026021110-delivery-coke-4bf1@gregkh>
References: <20260106170451.332875001@linuxfoundation.org>
 <20260106170510.584316139@linuxfoundation.org>
 <94cad986396d5a231a60d41cb6f86da146a6b435.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94cad986396d5a231a60d41cb6f86da146a6b435.camel@decadent.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215788-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2ECFF123E7C
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 05:06:50PM +0100, Ben Hutchings wrote:
> On Tue, 2026-01-06 at 18:05 +0100, Greg Kroah-Hartman wrote:
> > 6.12-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > [ Upstream commit 92dc572852ddcae687590cb159189004d58e382e ]
> > 
> > The gpiolib-acpi.c is huge enough even without DMI quirks.
> > Move them to a separate file for a better maintenance.
> > 
> > No functional change intended.
> [...]
> 
> However, this did cause some documentation breakage.  Please cherry-pick
> commit ec0c0aab1524 ("gpiolib-acpi: Update file references in the
> Documentation and MAINTAINERS") to fix that.

Thanks, the Fixes: tag in that commit is invalid, which is why I didn't
see it to pick this up, nice catch!

greg k-h

