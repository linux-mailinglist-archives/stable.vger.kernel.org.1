Return-Path: <stable+bounces-217650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNu6AZkLmmlmYAMAu9opvQ
	(envelope-from <stable+bounces-217650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 20:46:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B5F16DB6E
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 20:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 555033025F66
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 19:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BC1308F26;
	Sat, 21 Feb 2026 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRavfNFo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95989CA6F;
	Sat, 21 Feb 2026 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771703189; cv=none; b=TZ0/wail5fBURj9zq8uL8c75FZniG9ikNHoag2eJbn9SZK+j/H7Bja5D30l7R1fXJ74GWAbuOg8cg+IzI+JZS043pVnJEfAc24NZ1m/72jAxJxRiOp7+z+y6sh4V7CQjv2mZdT2UI3O2y7P1CT+HVm0TTV8raSerSfK6DmKbZ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771703189; c=relaxed/simple;
	bh=1FDwAsvp9YVgjzhyL/oJX8kk/GEGNxZtKFH4L7LAkT8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Etp9Fl0EibtTjUQbJtDk/yvD5jq4HrOw81uDKw3rPptev3h+fCuHF2jPMeS/u8CLj8yqxhnScixjVh9VVZsaLO9T/z8YkeM1ASsY5Tq0x9sq1PuIjmMbUxXuGwJ69HHgMvMtTB+BlTzsqk/y8Ys6BWgys6PtAhBTHWCTZNDyvxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRavfNFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EFAC4CEF7;
	Sat, 21 Feb 2026 19:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771703189;
	bh=1FDwAsvp9YVgjzhyL/oJX8kk/GEGNxZtKFH4L7LAkT8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KRavfNFo55hbqluDAKIezEaPoKJ+67IdVr0l/I7zD7XXEMHbZxmJUZuHC3oGhUtNU
	 hCUB/3H8RP+gSXNW6M36rCbGneZSiUOI6V59CFTeWQoqBaOxQrzXPhuMMRb6jUX9t4
	 R48Gz7V426TBuB6BOKZ8wgiq6zSQCUNEZBeTAHOgBbCwiX8UMIGtt8OJG4ytvsljGl
	 stqg+DQnSXxMw2p4RXvF5wCPCcHYXZAgCHXxcKblCTSCoTxYCKNyJP42KtETg7HZLb
	 4uzH2fOj+VwJXWHcVLntuvhhFJJeexOoPqRAB79RVZUS/qWBoLVcgMX8VLZ7XcrKhf
	 8oY0zXx0rCv6w==
Date: Sat, 21 Feb 2026 20:46:26 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: Lee Jones <lee@kernel.org>, David Rheinsberg <david@readahead.eu>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: uhid: Fix out-of-bounds write caused by raw
 events mismanagement
In-Reply-To: <aZmsTQeeGf26FqvY@plouf>
Message-ID: <172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet>
References: <20260211164025.171242-1-lee@kernel.org> <aZmsTQeeGf26FqvY@plouf>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217650-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 68B5F16DB6E
X-Rspamd-Action: no action

On Sat, 21 Feb 2026, Benjamin Tissoires wrote:

> > Since the report ID is located within the data buffer, overwriting it
> > would mean that any subsequent matching could cause a disparity in
> > assumed allocated buffer size.  This in turn could trivially result in
> > an out-of-bounds condition.  To mitigate this issue, let's refuse to
> > overwrite a given report's data area if the ID in get_report_reply
> > doesn't match.
> 
> That's a strong assumption and a breakage of the userspace FWIW. The CI
> is now full of errors:
> https://gitlab.freedesktop.org/bentiss/hid/-/commits/for-7.0/upstream-fixes
> 
> It is pretty common to allocate the buffer and not initialize it in
> get_report operations.
> 
> It was a bad API choice to have rnum and data[0] for all HID requests
> (internally, externally), but we should stick to it. The CI breakage in
> itself is not a big issue TBH, but if it breaks here, it will probably
> break existing users.

Lee,

was this found via code inspection, fuzzing, or is there some real-world 
report behind it?

Thanks,

-- 
Jiri Kosina
SUSE Labs


