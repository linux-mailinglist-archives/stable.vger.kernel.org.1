Return-Path: <stable+bounces-242585-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB2YDkSZ9Wm1MwIAu9opvQ
	(envelope-from <stable+bounces-242585-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 08:27:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A74A54B1252
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 08:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0B7D3012CB4
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 06:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF7026AA91;
	Sat,  2 May 2026 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yySXWndv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227151A9B24
	for <stable@vger.kernel.org>; Sat,  2 May 2026 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777703233; cv=none; b=CdRXMurOjeyOeM3v18CeP8aaIvKQM+D3VrATEKBeE+KqUDlJe2gwX+sb0QHCWaHJlt0QYq9yKtvcRB+DHtZgX4+rTTDwQZj4dcgyt0Dg3sqL1/XIv9fpWNPPZN916sXFvlffzB/UziOL14r7jUSWEJ+3iT0t8jFQUShUvGdSqA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777703233; c=relaxed/simple;
	bh=tYzrtD7JIRyRx7PRZc1IYGnBdbB5H2fuCO19D9T44sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWz9Ws08xAPA+kpWXIHENs1/JqUiaHZq7Hn4qjbHpgTbcGUBnMu74wyhPiZZVMMTTMEKourZkuwiut3jEuT5xAbKo70MmIUazxPfjCGBFHUwuBmZT9f3aCP4qH9wtp6syWLFT2fJ/+dhJzogI/4phRRCLDFA6rQoD+j+rnHhm1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yySXWndv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7E7C19425;
	Sat,  2 May 2026 06:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777703232;
	bh=tYzrtD7JIRyRx7PRZc1IYGnBdbB5H2fuCO19D9T44sE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yySXWndviDylj6ItfZpzAZ+dwNoVMyUvXfucyLLi8jO4weYYd35onBanjAVQ97Grx
	 LJ6fCalXk7WKBrF57Z4fXaX+HB6gL0BELHrTQUugy6soszInVtthNg3oWBWWPeYfPb
	 A0qGHGoBVUCJZuWYdtz3VofrsnYPar9FTDq4gObk=
Date: Sat, 2 May 2026 08:27:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: azizcan.d@mileniumsec.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/poll: ensure EPOLL_ONESHOT is
 propagated for" failed to apply to 5.15-stable tree
Message-ID: <2026050207-dirtiness-reapply-f841@gregkh>
References: <2026050100-washday-snowdrift-2968@gregkh>
 <a1b41674-0593-422b-93bb-edc3993d829c@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1b41674-0593-422b-93bb-edc3993d829c@kernel.dk>
X-Rspamd-Queue-Id: A74A54B1252
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242585-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Fri, May 01, 2026 at 08:40:31PM -0600, Jens Axboe wrote:
> On 5/1/26 5:09 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 1967f0b1cafdde37aa9e08e6021c14bcc484b7a5
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050100-washday-snowdrift-2968@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Not needed.

Note that the Fixes: line implies that it is needed:
	Fixes: 4464853277d0 ("io_uring: pass in EPOLL_URING_WAKE for eventfd signaling and wakeups")
as that has been in the following releases:
	5.10.162 5.15.90 6.1.3 6.2

which is why this, and the 5.10.y FAILED email was sent out.  Is that
marking incorrect?

thanks,

greg k-h

