Return-Path: <stable+bounces-244927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI3+KKPq/mkdzgAAu9opvQ
	(envelope-from <stable+bounces-244927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 10:04:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EED384FEA40
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 10:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8102B3010387
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 08:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A0623ED5B;
	Sat,  9 May 2026 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ON2qCe95"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C072B1A262A
	for <stable@vger.kernel.org>; Sat,  9 May 2026 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778313888; cv=none; b=olDjZu3r8T/c19yXddzLLJZDcrFRF09QzzGXFv7odBkdYYMTiourc805fbhKUkJ9+B5kCTJFoQHgnZVYyiSGHxYE9tR1kVItVEoBcobWsR0rJX3WvG+LkoX8TVB5vThA/Bli2fuaoqo2HTEMCudxFmKPbyT9e0/8s6sO/MYDV6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778313888; c=relaxed/simple;
	bh=Rg0j8qmJab2j+Cvmz+FIG4CEUBPQbIr842hn6uYFVtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9x/5gi2Mpqt71EAz534vPCiimyC5BbWKiQxTjFB6dkVhxWn4L8Tsugr0KBzO7Gz6DGrL0dLkLbrV5ZfzNzVeiNu1IXVJV6qDeNlh7hqTGFS+yemEqeG8LHz5zKVilUmy56hFLA7JpFWpxEaQOmfrHSddrB1QJRiUdHWeFMPoNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ON2qCe95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5EAC2BCB2;
	Sat,  9 May 2026 08:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778313887;
	bh=Rg0j8qmJab2j+Cvmz+FIG4CEUBPQbIr842hn6uYFVtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ON2qCe95Ejxg3G+jCMfmiWxihs+1qzvWXe99oiPB+x173dKt8BhuyLjH8eHlGVq4v
	 I9hQJK0DNbKiayGTQlwpGo+BzMgACiURDS6ID9fPtrIiVVd2whCD/SrDmgEI2idpcu
	 Euw/AWeX/u9peYB7XrdBj9TmDdW7/4/GctED9SQQ=
Date: Sat, 9 May 2026 10:04:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rion Kiguchi <kiguchi.r.sec@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] staging: vme_user: validate slave window size against
 buffer size
Message-ID: <2026050935-designing-glancing-2e16@gregkh>
References: <20260509075318.640383-1-kiguchi.r.sec@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509075318.640383-1-kiguchi.r.sec@gmail.com>
X-Rspamd-Queue-Id: EED384FEA40
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-244927-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 04:53:18PM +0900, Rion Kiguchi wrote:
> The VME_SET_SLAVE ioctl in drivers/staging/vme_user/vme_user.c accepts
> a user-controlled slave.size and forwards it to vme_slave_set() without
> comparing it against image[minor].size_buf. The slave-image kernel
> buffer is allocated at probe time with a fixed size of PCI_BUF_SIZE
> (0x20000 / 128 KiB), but the configured VME window size can be made
> much larger via the ioctl.
> 
> The subsequent read() / write() handlers (vme_user_read /
> vme_user_write) clamp the I/O range against vme_get_size() (the
> configured window size, attacker-controlled) but never consult
> size_buf. The slave I/O paths buffer_to_user() and buffer_from_user()
> then index image[minor].kern_buf with *ppos values up to
> image_size - 1, well beyond the actual allocation.
> 
> Result: a local user with read/write access to /dev/bus/vme/s* can
> trigger out-of-bounds read and write of the kernel slab adjacent to
> the slave-image buffer.
> 
> Fix: reject slave.size > size_buf in the VME_SET_SLAVE handler. Also
> add defensive bounds checks against size_buf in buffer_to_user() and
> buffer_from_user() so that the I/O paths cannot exceed the
> allocation even if a future ioctl path forgets to validate.
> 
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Rion Kiguchi <kiguchi.r.sec@gmail.com>
> ---
>  drivers/staging/vme_user/vme_user.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_user/vme_user.c
> index 11e25c2f6..41b8d5b51 100644
> --- a/drivers/staging/vme_user/vme_user.c
> +++ b/drivers/staging/vme_user/vme_user.c
> @@ -156,6 +156,11 @@ static ssize_t buffer_to_user(unsigned int minor, char __user *buf,
>  {
>  	void *image_ptr;
>  
> +	if (*ppos < 0 || (u64)*ppos >= image[minor].size_buf ||
> +	    count > image[minor].size_buf - (u64)*ppos) {
> +		pr_warn_ratelimited("%s: out-of-bounds access\n", __func__);
> +		return -EINVAL;
> +	}

Why doesn't the check in vme_user_read() already catch this?  You are
duplicating much of the same logic again, are you _SURE_ the
LLM-generated report here is actually correct?

And don't spam the kernel log for when a user sends invalid data, that
would just be a mess.  But if you do want to, use the proper device
information, not just a static function name, which is very generic and
impossible to determine what went wrong (i.e. use the correct logging
functions like dev_err() and the like).

And you need an extra blank line after the check here, your LLM should
know better :)

>  	image_ptr = image[minor].kern_buf + *ppos;
>  	if (copy_to_user(buf, image_ptr, (unsigned long)count))
>  		return -EFAULT;
> @@ -168,6 +173,11 @@ static ssize_t buffer_from_user(unsigned int minor, const char __user *buf,
>  {
>  	void *image_ptr;
>  
> +	if (*ppos < 0 || (u64)*ppos >= image[minor].size_buf ||
> +	    count > image[minor].size_buf - (u64)*ppos) {
> +		pr_warn_ratelimited("%s: out-of-bounds access\n", __func__);
> +		return -EINVAL;
> +	}

Same as above.

thanks,

greg k-h

