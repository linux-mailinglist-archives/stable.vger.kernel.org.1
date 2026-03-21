Return-Path: <stable+bounces-227675-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPYaBYc4vmlGJwMAu9opvQ
	(envelope-from <stable+bounces-227675-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:19:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FCE2E395D
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4080F3040191
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0043E362149;
	Sat, 21 Mar 2026 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NX/33QIs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92B1343D8A
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774073951; cv=none; b=XQLVtOrITyAJtL7eX9YqPZabepem5h4FzNuN8IWyQ+8MKhrCOtbiGyz9j9QAn+Vl/O4esoOkKrdOE1CsJLckvycJ9MIQemWMHK0hbvBpYMJrAk89JoQ15Mskm6riPDacGTBEyCyXFSXCCQ7lPdJDIlTnNzEwplQC2XWOcZy4FKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774073951; c=relaxed/simple;
	bh=4CZwcsNBMK561lizDhxzRP2Gf/ggRNaaRoBI3K5dM0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQUbwMhA8hdIdRulXfFh6/O516HKQDetJPkOnJ0+Y4wWrrbgTSToZ1WKrVHWgPzv5nwYelNVN/hEwscLJLYXZsD34c27lStwAMEbz3AbICFKOumZQHmlYpInJkwjygvbipxgVymru+rvlPphCavbGzmvu4nXWaTh+Bk7ukFMbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NX/33QIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395F6C2BCB2;
	Sat, 21 Mar 2026 06:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774073951;
	bh=4CZwcsNBMK561lizDhxzRP2Gf/ggRNaaRoBI3K5dM0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NX/33QIsIsP6H5jPcIKk2iHNnNtTE1Ot3I1jZVt+6RUaZrPP2vmQTS/RpCZXWzyyh
	 u2qXgWxNS9zZfZDAmonpydURGu/BgEfm9x264M1vgRcSAgfZgIpilbRGKqlj+1cfA3
	 TeJVc0gWIiMOlaKKYQfiFkCDX7rBmZMk/K3so4eo=
Date: Sat, 21 Mar 2026 07:11:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: code@mgjm.de, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: propagate BUF_MORE through
 early buffer commit" failed to apply to 6.12-stable tree
Message-ID: <2026032123-slug-anthology-f473@gregkh>
References: <2026032021-amused-playable-2e81@gregkh>
 <c6099d0e-3f0b-4b25-9366-f258445a8e99@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6099d0e-3f0b-4b25-9366-f258445a8e99@kernel.dk>
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
	TAGGED_FROM(0.00)[bounces-227675-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: C0FCE2E395D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 12:28:58PM -0600, Jens Axboe wrote:
> On 3/20/26 11:34 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Here's a tested version for 6.12-stable.

Now queued up, thanks.

greg k-h

