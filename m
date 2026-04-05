Return-Path: <stable+bounces-233314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOuqAxH00WlYRgcAu9opvQ
	(envelope-from <stable+bounces-233314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 07:33:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F86939D693
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 07:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B516C300A4E2
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 05:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA72256C61;
	Sun,  5 Apr 2026 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PThPNvLY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE914884C;
	Sun,  5 Apr 2026 05:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775367180; cv=none; b=XrxEbWjzAr9HkKcPNaElEHaOeW+u0fN3q6XUyL5aY4d7ndpVRHTBVVbF5KM3JQsJywv3jyZvCFpzymjdSzGwO9owBz4/31/oqr5g6q9ElPFidHZKDyekI4jUPpxvCYc7zSDqmUcjPPpT3+sbuHAa54l05ukuxSpoIftUpA/GWnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775367180; c=relaxed/simple;
	bh=sw/+m29S9rvyEZVP8yBapjFvZSpbgIUMlpVQEegRUQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyagA5ESWJXJwG/0a4efyrke07y6354d8K0rOUT5wObOkMZqQ9wUan6fMWfb1OG5tw4umuV0Td3zJKlPDeoEJ+KKRU+L9gLpqcPkIancLKClSS0fzgBA7k0FtF/oq3V/berFK0E1/RSpeimZDnZ694dnFG7ZLlTovlbkFn3/Uj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PThPNvLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B348C116C6;
	Sun,  5 Apr 2026 05:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775367179;
	bh=sw/+m29S9rvyEZVP8yBapjFvZSpbgIUMlpVQEegRUQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PThPNvLYkfzEYJNwOzTzaZRKYoYmiqYAXDyLJDqkvU8flJKztPDxUmmxm0oRCR367
	 9zeC+6tYmVHU9cG0NQUYNK02oJLRkXujWM1XQIuseSz/LLBSE4LJaI4ONoJ8a1U4QO
	 pfz/+jEjNW05GpRsd3qJumHSvo6S1t/d9SQ0d36c=
Date: Sun, 5 Apr 2026 07:32:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tomasz Kramkowski <tomasz@kramkow.ski>
Cc: stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Brad Spengler <spender@grsecurity.net>,
	Alva Lan <alvalan9@foxmail.com>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] Revert "xattr: switch to CLASS(fd)"
Message-ID: <2026040502-remedy-absinthe-a571@gregkh>
References: <20260404112219.389495-1-tomasz@kramkow.ski>
 <DHKD00A8F4MN.3394SJ86VMD72@kramkow.ski>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHKD00A8F4MN.3394SJ86VMD72@kramkow.ski>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233314-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,grsecurity.net,foxmail.com,zeniv.linux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 5F86939D693
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 01:11:57PM +0100, Tomasz Kramkowski wrote:
> On Sat Apr 4, 2026 at 12:22 PM BST, Tomasz Kramkowski wrote:
> > Was asked to send a revert instead of a fix. Previous patch was here:
> > https://lore.kernel.org/stable/20260403230636.344097-1-tomasz@kramkow.ski/
> >
> > Tested via qemu to verify the fix and ensure there were no unexpected
> > consequences.
> 
> I should note, however, the backport was intended to fix a specific bug
> in `fremovexattr`, and now that bug is there after the revert.
> 
> Shall I just submit a v2 of this with the revert _and_ a new backport?
> Or would you still prefer to just revert and then have attempt #2 at the
> backport separately?

A new backport would be great, as the original was broken, and this
makes it more obvious where things were actually fixed.

thanks,

greg k-h

