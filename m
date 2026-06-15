Return-Path: <stable+bounces-263178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qLMaE5LfL2o4IQUAu9opvQ
	(envelope-from <stable+bounces-263178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 13:18:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B59A685AC0
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 13:18:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RuSW9N7q;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263178-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263178-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EF1D3031CC4
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 11:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D278C3E2AD7;
	Mon, 15 Jun 2026 11:18:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1125145B3F;
	Mon, 15 Jun 2026 11:18:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522317; cv=none; b=mATRk1XJUGIjyM0TRdnkvXDPvroactHfT/dRWzDQfaAgXgkUgwHHyMrZ2of6da/HB2mZlKLDjQPhbTW0wLzzX5BwH8jIR11gjGnu2w2YU3RxVMUXa3QnRW504BDn21UHHLOIRiG2KTTX+zx8i2vBzb614K90WmuNBG3Bpqc5otQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522317; c=relaxed/simple;
	bh=0gwyROiMOHpdV2hu3dErFMBsHY+LszkmC9DeWK3L/yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A26xFVFBzJ0YPngLPd0fltQMeruhR9I5lUmQn0VW0ejLqMCr9U5IIPNtR1AyVNR0J6hloMK7DUdYT2WDjpr0IxzU2Zj5GQg5VLwcwiG7yLNGGKkdeoSeAGL/MrN1wA+05PHK+lQ3NJT0i/DWCI1jNJD20aqs5hBBgui3OrZiMRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuSW9N7q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206551F000E9;
	Mon, 15 Jun 2026 11:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781522316;
	bh=nlAdSspiA7Bhnac4eiBLskoKBbZVwpaObQnTtm83GQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RuSW9N7qBidJDiUteYXSIlCbwiCepLdxJpiPmiOtkdSBPqJY1xUbriVTtbYZCkHLi
	 1gohywC3PomqUI+T3gTvJ/+FpvnCQlTJpEijMmvWqs+is+WAOESNcSEDLV1Cs03Y0A
	 M+Wa834/pEMq5jlCBoHDlEPXIW93Z72kDiyZrIXhJdJBOvNmmSGDKryAjZ2T0SZ37M
	 GPzACIiBK2CqRIsCqDJmcTH9cG48yyTTPMpOdcxv13JjZbsK12qh0wWZjmWHDLMGE2
	 VjHTT7agteubUJPoLQ454uHikep72PR8XisfpGDzAW7KQyNyaxTdeQw6NlRB+hZ8IK
	 ckNyIpYvvvTUA==
Date: Mon, 15 Jun 2026 12:18:29 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Chun-Yi Lee <joeyli.kernel@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Chun-Yi Lee <jlee@suse.com>, 
	David Howells <dhowells@redhat.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] debugfs: Fix lockdown check for mmap_prepare
Message-ID: <ai_fWlr61AzrNrDz@lucifer>
References: <20260615104750.1000-1-jlee@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615104750.1000-1-jlee@suse.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:joeyli.kernel@gmail.com,m:rafael@kernel.org,m:jlee@suse.com,m:dhowells@redhat.com,m:andy.shevchenko@gmail.com,m:tglx@linutronix.de,m:mjg59@srcf.ucam.org,m:gregkh@linuxfoundation.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:joeylikernel@gmail.com,m:andyshevchenko@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263178-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,redhat.com,gmail.com,linutronix.de,srcf.ucam.org,linuxfoundation.org,lists.linux.dev,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ucam.org:email,vger.kernel.org:from_smtp,suse.com:email,linuxfoundation.org:email,linutronix.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lucifer:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B59A685AC0

On Mon, Jun 15, 2026 at 06:47:50PM +0800, Chun-Yi Lee wrote:
> From: Chun-Yi Lee <jlee@suse.com>
>
> Commit 651fdda8406d ("relay: update relay to use mmap_prepare")
> changed the `mmap` file operation to `mmap_prepare` for relayfs, but
> the lockdown check in debugfs was not updated accordingly.
>
> This prevents debugfs from being locked down when the kernel is in
> integrity mode if a file uses `mmap_prepare` but not `mmap`.
>
> Since the conversion to `mmap_prepare` across the kernel is not yet
> complete, update the lockdown check to look for both `mmap` and
> `mmap_prepare` to ensure comprehensive coverage.
>
> Fixes: 651fdda8406d ("relay: update relay to use mmap_prepare")
> Signed-off-by: Chun-Yi Lee <jlee@suse.com>

LGTM so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> Cc: David Howells <dhowells@redhat.com>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: driver-core@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
> v2:
> - Add explicit From tag to match Signed-off-by.
> - Fix Lorenzo's email address.
> - Add Cc stable for backporting.
> - Check both mmap and mmap_prepare as suggested by Lorenzo.
>
>  fs/debugfs/file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index edd6aafbfbaa..08de6652a4f3 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -273,7 +273,8 @@ static int debugfs_locked_down(struct inode *inode,
>  	    (!real_fops ||
>  	     (!real_fops->unlocked_ioctl &&
>  	      !real_fops->compat_ioctl &&
> -	      !real_fops->mmap)))
> +	      !real_fops->mmap &&
> +	      !real_fops->mmap_prepare)))
>  		return 0;
>
>  	if (security_locked_down(LOCKDOWN_DEBUGFS))
> --
> 2.43.0
>

Cheers, Lorenzo

