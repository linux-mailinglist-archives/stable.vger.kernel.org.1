Return-Path: <stable+bounces-214473-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHjmN4uphGk14QMAu9opvQ
	(envelope-from <stable+bounces-214473-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:30:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5307AF3FA0
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB41B3012C7F
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 14:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C26221F24;
	Thu,  5 Feb 2026 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SZQTdAUj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F7FEACD;
	Thu,  5 Feb 2026 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301817; cv=none; b=Ndl3Fk7tys0IaRQ3pYmdjQ6wOrYGdTS4SJtUeSPR8osfEFKlZSH+TZuLPfUeV4ksIBmw3or5Bj0oy+tvJPLbTqE46cvCLuXCDcCccY8Y/0hQFRY9e8l/WG79LKJKHfxbJXPw3fCaT3taQmb+aKBDLB+RS/gJUtwNnok860tKmuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301817; c=relaxed/simple;
	bh=HWwUmvsakuIbr283ynIn8TSpX0eLq6bewdUN5tqaKcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLUdXt820KOfAynaiYRQLlya2L5dEpNqopxn+2BXuBlmYVFelneKUIInHRDGDvDzvTMMNQk7NwXX3dIvH+COm7pnHX9gYykZ0H4ar8R1Ypm8C4vhyaNDqbyRxFusoxEQ1Sl1WG8d3CPXwsKv+2isq0VgMLLCpyUBDVDAKsWrI9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SZQTdAUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651A1C4CEF7;
	Thu,  5 Feb 2026 14:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770301816;
	bh=HWwUmvsakuIbr283ynIn8TSpX0eLq6bewdUN5tqaKcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZQTdAUjVDPKD0vVjoJyLnkZzFKiiDF9Vuoo+PPSpI2TUjdsfYhEk72bcRuMC+XiV
	 QgkEElqz1cpKv4eU503+AxsrMs1UKULNcwZfw4DerEINQA24OAQzs0OtcghvDUJN2r
	 Lw6h6g+YNYiXdTbBtD8/A7gqNJQUCmzMXm2oLijY=
Date: Thu, 5 Feb 2026 15:30:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	John Ogness <john.ogness@linutronix.de>,
	Daniel Palmer <daniel@thingy.jp>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 6.12 75/87] Revert "drm/nouveau/disp: Set
 drm_mode_config_funcs.atomic_(check|commit)"
Message-ID: <2026020544-deluxe-caucasian-66df@gregkh>
References: <20260204143846.906385641@linuxfoundation.org>
 <20260204143849.619741696@linuxfoundation.org>
 <5951f289-a7ef-43b1-badf-f1e7cd04c02d@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5951f289-a7ef-43b1-badf-f1e7cd04c02d@roeck-us.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214473-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linutronix.de:email]
X-Rspamd-Queue-Id: 5307AF3FA0
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 06:28:22AM -0800, Guenter Roeck wrote:
> On Wed, Feb 04, 2026 at 03:41:13PM +0100, Greg Kroah-Hartman wrote:
> > 6.12-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: John Ogness <john.ogness@linutronix.de>
> > 
> > commit 6c65db809796717f0a96cf22f80405dbc1a31a4b upstream.
> 
> Not questioning the need for it, but this revert does not exist
> in the upstream kernel ???
> 
> $ git describe
> v6.19-rc8-45-gf14faaf3a1fb
> $ git show 6c65db809796717f0a96cf22f80405dbc1a31a4b
> fatal: bad object 6c65db809796717f0a96cf22f80405dbc1a31a4b

It is in linux-next and I was told it would be in 6.19-final, which is
why I took it here.

thanks,

greg k-h

