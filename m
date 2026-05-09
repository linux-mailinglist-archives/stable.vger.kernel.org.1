Return-Path: <stable+bounces-244934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB1RBWoF/2lC1QAAu9opvQ
	(envelope-from <stable+bounces-244934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 11:59:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 001A34FF124
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 11:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCA32300862F
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 09:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA4139F180;
	Sat,  9 May 2026 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KlpbDWCk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E859D39E194;
	Sat,  9 May 2026 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778320736; cv=none; b=ggoLn54wo5F8N5qmzc2ogTaEA/eGXl6qZMkn1aabZSh/n0ENo6e5lLI3x9vuKZ/F1fy5abkHUJghAjPaZBi3yjxWbFC1vRFXBnN9GcqVt2TL8tWVMxgYspf9nI4Lrr6FpmtxRYSBqZ/ELEUd/u3yLLEk/qQZB6Nbe7F+8e80n2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778320736; c=relaxed/simple;
	bh=tiqSnM6korHs3EDnJnx1HgCKzcElJB2f1dghfAUxP3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWZozXwVtCXTc4XxDilD6IdtpfKHv8NILpepuF19rAxyDwTHLxnLBDF5cSA0b/53jsFr/QFm4zD00toqh0lgHNG4+RwDy1NAx0NwsiQX+t/UvdtPskpAYVbGIB4S6HuAZ8etXhgGEdphfZkYYYgQJoqgRVeDfMpWp5ZdrB+ZSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KlpbDWCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B53C2BCB2;
	Sat,  9 May 2026 09:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778320735;
	bh=tiqSnM6korHs3EDnJnx1HgCKzcElJB2f1dghfAUxP3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KlpbDWCkmlTQOqW2WYYq66Klok+AyfDvNklUkbOO9zTWYf8/R5lifQPBPYj4tbKt2
	 3dZWowRRFLIf6/D+tBv4+9G6F8Zvha0ihmqA8NJQQHeSU/8hNyCNxj6StM6O+l/igM
	 IHO8ddRUFqNGl4S+4I5EWiSH7SPyRq3JOdOSuIcE=
Date: Sat, 9 May 2026 11:58:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rion Kiguchi <kiguchi.r.sec@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	security@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] staging: vme_user: validate slave window size against
 buffer size
Message-ID: <2026050947-easily-choosing-2f91@gregkh>
References: <2026050935-designing-glancing-2e16@gregkh>
 <20260509092627.1136357-1-kiguchi.r.sec@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509092627.1136357-1-kiguchi.r.sec@gmail.com>
X-Rspamd-Queue-Id: 001A34FF124
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244934-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 06:26:27PM +0900, Rion Kiguchi wrote:
> The VME_SET_SLAVE ioctl in drivers/staging/vme_user/vme_user.c accepts
> a user-controlled slave.size and forwards it to vme_slave_set() without
> comparing it against image[minor].size_buf. The slave-image kernel
> buffer is allocated at probe time with a fixed size of PCI_BUF_SIZE
> (0x20000 / 128 KiB), but the configured VME window size can be made
> much larger via the ioctl.
> 
> The subsequent read() / write() handlers (vme_user_read /
> vme_user_write) clamp the I/O range against vme_get_size(), which
> returns the size the bridge driver has programmed for the window
> (i.e. the attacker-supplied slave.size). vme_get_size() does not
> consult size_buf, so an oversized window passes the existing bounds
> checks, and buffer_to_user() / buffer_from_user() then index
> image[minor].kern_buf with offsets beyond the actual allocation.
> 
> Result: a local user with read/write access to /dev/bus/vme/s* can
> trigger out-of-bounds read and write of the kernel slab adjacent to
> the slave-image buffer.
> 
> Fix: reject slave.size > size_buf in the VME_SET_SLAVE handler.
> With this check in place, the existing bounds checks in
> vme_user_read() / vme_user_write() against vme_get_size() are
> sufficient to prevent OOB access; no additional checks in
> buffer_to_user() / buffer_from_user() are needed.
> 
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Rion Kiguchi <kiguchi.r.sec@gmail.com>
> ---
> Changes in v3:
>  - Drop redundant checks in buffer_to_user() / buffer_from_user();
>    the existing vme_get_size()-based bounds checks in vme_user_read()
>    / vme_user_write() are sufficient once VME_SET_SLAVE rejects
>    oversized windows (Greg's review feedback)
>  - Reword commit message to explain why vme_get_size() does not
>    already catch this

Please slow down.  Take some time (i.e. a few days) between versions and
read all of the review comments before sending a new one (you ignored my
past review).  Relax and wait a few days, do some testing, and actually
verify that your fix is correct (I don't think it is.)

And of course, actually use checkpatch.pl to verify that you are not
adding a new coding style issue to the file (which this patch does).

There is no rush here.  Take your time, this isn't a real problem that
must be solved immediately.

this also should have been v4, not v3 :(

And finally, no need to cc: security@k.o, that alias has nothing to do
with this issue as it is not a real security problem and is now public.

thanks,

greg k-h

