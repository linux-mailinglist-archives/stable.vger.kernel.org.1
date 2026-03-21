Return-Path: <stable+bounces-227710-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOtiNAA5vmlQJwMAu9opvQ
	(envelope-from <stable+bounces-227710-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:21:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADAE2E3A18
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3242B305ED3C
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7492336EAA8;
	Sat, 21 Mar 2026 06:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nSx6oyG2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37148346E67
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 06:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774073957; cv=none; b=jChHEoWZYJmubdLA+IAtghGxaQeXtIVfNtCRWNl5j7pXZDreNXDHufPVTmUZnkRr6KhoENN9wnoCiKznxM7aOr2xZoi/pGhaK0kUNPUoXtCWNBQKm1Qe3h2C5cqdSf0Z2cNdIc21PWmLjOgqgzj8JtL69i7M7SfTp43dxYQ2bH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774073957; c=relaxed/simple;
	bh=X71ADP0/DusaTMDtog/eJbWmX8FOQ7pzH3Y1fE638is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evb9xhZtMniyEvG2gpC2+keXKk03OLmUYdc6+mYsojOBKmXIZZ4mapszMb27DtMCk3Prr/UHAV1/JF5cwAX92EfqkmsbBctZKC0S0aRvm3NbG7rOUtdn+VE97WdszrpHmTDOG1lKoX92pglTBLeUPTBrKHR+58nLEZt8FY9YMc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nSx6oyG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12E9C2BCB1;
	Sat, 21 Mar 2026 06:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774073957;
	bh=X71ADP0/DusaTMDtog/eJbWmX8FOQ7pzH3Y1fE638is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSx6oyG2eJuqVuG5ITHOT/AUdEC/VmTb5f17hPVNAbatArI5pzKee8LKEDXpJ7gZX
	 Osx6H7eHRP38W0ZP7hx39j1ldg+FoVSb7EzxCImLLe6t+UnZ8V2UzdYZ8fZH8qjRl1
	 lcKhxp3gGzSeNczWzdWMytsQeVVFvcusSvXGlKBY=
Date: Sat, 21 Mar 2026 07:11:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: francis@malagauche.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/poll: fix multishot recv missing
 EOF on wakeup race" failed to apply to 6.1-stable tree
Message-ID: <2026032137-unstuffed-opium-cfa6@gregkh>
References: <2026032057-septic-boogeyman-daef@gregkh>
 <376a35ee-6a9d-47ef-b4f2-d1e6af5f830d@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <376a35ee-6a9d-47ef-b4f2-d1e6af5f830d@kernel.dk>
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
	TAGGED_FROM(0.00)[bounces-227710-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6ADAE2E3A18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 12:10:43PM -0600, Jens Axboe wrote:
> On 3/20/26 11:33 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Since this only triggers after the AF_UNIX inq addition in 6.17,
> we can drop it for 6.1/6/12. I should've done a better job with
> the Fixes tag.

Not a problem, thanks for letting us know for this, and the other FAILED
patch.

greg k-h

