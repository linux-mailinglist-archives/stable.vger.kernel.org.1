Return-Path: <stable+bounces-274440-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nyJgExZnVmqa4wAAu9opvQ
	(envelope-from <stable+bounces-274440-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:43:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D8E75706B
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:43:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Z9UaWKmX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274440-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274440-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 845133058527
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5614D90CF;
	Tue, 14 Jul 2026 16:42:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAAF4D90A6;
	Tue, 14 Jul 2026 16:42:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047331; cv=none; b=QiNL/c6fDsDFPoPYjgWClGDOut7crq6ntP137PO+FhQ4Kh4P9Lf/Xs7pVI5G+aGuTKIfPYxcStXOzVkXbN2grg4o62SCvyIM3mT/qzyMbU5U0tDdshOXF2MggO3c979p+TEMbfuhVvWHbEbzwuDMRAQFmdzjIBz3d3atJk/VQ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047331; c=relaxed/simple;
	bh=IVZqqqbKk3Pvs7pPmAHOufutOPK/M9DAVp2gqk9ibac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHESFaGKi3vrgQDe0rC3OtxohtylufHaXpIJrGUqmvk82JKURactl7mQ92HWwP7lDDLomj5pvq2kbVNJGoLZSKbl0uc6Oq6mEHhRzzMbfSWsOvFCvF/8LzBSnsuY/D0iHDHPGVi8zNeIXGWk1CjuuUJ6EgAu1qZHg6eG/4UFqXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9UaWKmX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 91E3D1F000E9;
	Tue, 14 Jul 2026 16:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784047329;
	bh=7fK8AmZdS3XkyteViA4pHtIvyKygfQDkI+Fj0vrrJXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z9UaWKmXiYj6t5ehRiVCvD2lUuesMoriCvADbxDZX63HQtTakZp8PfaA5cTOrj675
	 Y1V9FlJDXUxZS+A8hZKlKL+6g0J/YVSGtxIaMIkgRtSowv00FfMcnLirOBVwm9uuuj
	 dB/3F3dKat24yOPabiQ2xpDy1VqfnySXptVFpaMvGHJ7288osw7sH9JyHJg8e904iY
	 LV/0VNYSaiznBUPsP1gdilp2IfXYw+1EQLTuAPI+x/sV0Ex/Ex1JFc5aDUdO4yzLlN
	 7RUqtcbiytbir9OalU2R5pjaSVrvgtGdfU4zKthY5Inm+JSWR9Jn07HvxHcAANbr1f
	 LgfCQQJO7fmuQ==
Date: Tue, 14 Jul 2026 09:42:09 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, stable@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/6] xfs: set xfarray killable sort correctly
Message-ID: <20260714164209.GF7398@frogsfrogsfrogs>
References: <178400716782.268162.4846177784022689546.stgit@frogsfrogsfrogs>
 <178400716837.268162.4871292933498780753.stgit@frogsfrogsfrogs>
 <20260714061134.GB1072@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714061134.GB1072@lst.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:cem@kernel.org,m:stable@vger.kernel.org,m:linux-xfs@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274440-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,frogsfrogsfrogs:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7D8E75706B

On Tue, Jul 14, 2026 at 08:11:34AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 13, 2026 at 11:06:12PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > LOLLM noticed that we *disable* interruptible sorts when the KILLABLE
> > flag is set.  This is backwards.  Fix the incorrect logic, and rename
> > the variable to make the connection more obvious.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Can we come up with a test that actually kills a sort somewhat reliably?

Userspace doesn't have good visibility into when a sort is running, and
I don't think we want to add XFS_TEST_ERROR() chunks where we inject a
SIGKILL into current... however that might be done.

--D

