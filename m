Return-Path: <stable+bounces-220020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB28CCImommP0QQAu9opvQ
	(envelope-from <stable+bounces-220020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 00:17:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C231BEF61
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 00:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FC1F306BC2C
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 23:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF2E36D507;
	Fri, 27 Feb 2026 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uH2W4qb8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1AD372B51;
	Fri, 27 Feb 2026 23:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772234271; cv=none; b=i8OlYoyTBwXig4Cr8keRHACMGFWcU8usjIGcjrtLFVsFtYmL4kNFlC80sQbYTAW4UWeffbraYrIwvXnoXD9mnag4iHQz0svO3+qzgG+5BYEuLetr8TrLH1O9Pk2vFBeZbFDxBd8q0AcSeepdxaSF9gIHTxzLTn4HSjJIOmRXJhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772234271; c=relaxed/simple;
	bh=7uid9+rIYavideL2E1AJTnMG5FA/SHY6EUj9iPxChYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnWFGM462EZvrIN4/uLFYlsVoXdXqlKuN3Ws0+L/HKIKSJRg/77EQgm/+7M1ppKvyp04VvIyelyNShjNvz/wejtQrIqmI+UOotUIxfhU+tSUYuuWAXtnpayck4jN7q8Ga3bzhC7HontEI8JY4yfxjCxUcyoI4lmMdkxjnXV+54Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uH2W4qb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A627C116C6;
	Fri, 27 Feb 2026 23:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772234270;
	bh=7uid9+rIYavideL2E1AJTnMG5FA/SHY6EUj9iPxChYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uH2W4qb8cnD3GcVObmF7wMykRODxu8Mn9s+bBaL67vPpNmFMNkPcT3PEuWVLsXQ9L
	 jvhtQUwrxCgvOPj6lx6Yoe7WTUkVJK0kdE+jWuceb+GZgRIsT9OMuGujaCvgw/UHJP
	 cJ6V/+g3OCvbrs/7VuIfMYys6q97iyZ0bELDPwN8jtsRmbq4vhdEDBpB9aRFjCXRyx
	 b196a4wuwOHCjtD6nrWDl00n+m8qP0ohsgiCMRvC/mhuwV5RxXBbnJDLrOPj944h5V
	 yCbK69lgn+SGSHu4ZnA22SuYUkwUbD+kUkeXI7FdeckjjAMrBkhauc6Uux/gF4Sajr
	 PNHbH24adYxyA==
Date: Fri, 27 Feb 2026 16:17:46 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.19 215/781] ALSA: pcm: Relax __free() variable
 declarations
Message-ID: <20260227231746.GA1772942@ax162>
References: <20260225012359.695468795@linuxfoundation.org>
 <20260225012404.989195256@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225012404.989195256@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220020-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 71C231BEF61
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 05:15:24PM -0800, Greg Kroah-Hartman wrote:
> 6.19-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Takashi Iwai <tiwai@suse.de>
> 
> [ Upstream commit f3d233daf011abbad2f6ebd0e545b42d2f378a4f ]
> 
> We used to have a variable declaration with __free() initialized with
> NULL.  This was to keep the old coding style rule, but recently it's
> relaxed and rather recommends to follow the new rule to declare in
> place of use for __free() -- which avoids potential deadlocks or UAFs
> with nested cleanups.
> 
> Although the current code has no bug, per se, let's follow the new
> standard and move the declaration to the place of assignment (or
> directly assign the allocated result) instead of NULL initializations.
> 
> Fixes: ae9213984864 ("ALSA: pcm: Use automatic cleanup of kfree()")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Link: https://patch.msgid.link/20251216140634.171890-4-tiwai@suse.de
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Please apply commit 0585c53b2154 ("ALSA: pcm: Revert bufs move in
snd_pcm_xfern_frames_ioctl()") to all branches that took this change to
fix the build with older supported versions of clang.

  https://storage.tuxsuite.com/public/clangbuiltlinux/nathan/builds/3AEpAuS5jtheTnTL9iDLNAiYTw3/build.log

Cheers,
Nathan

