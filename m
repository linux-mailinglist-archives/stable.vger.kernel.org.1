Return-Path: <stable+bounces-244134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK6aO/Xm+Wl1FAMAu9opvQ
	(envelope-from <stable+bounces-244134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:47:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7324CDE1A
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC7A7301E82D
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 12:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C33436345;
	Tue,  5 May 2026 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="snKGYSSD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EC54279F5;
	Tue,  5 May 2026 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984927; cv=none; b=hDuVnWZAqJoBWRIKyEt2vr/koHHRzPYFcuV6afDOKPr8bi9jQEE2nsxzCLbR4rEX3sY7PRmgf+LvYIkaTWR4R3fXiaqWsKs7je0UPyG91AsRXzktKA2PjwL94CFgqIw8U8PTYlAeF3UsCY/gXisIkXL1/WI491vQUBDN5U3l8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984927; c=relaxed/simple;
	bh=JrLZSn5vRWKEC9FNR+33WRgCciMwXtUznnnP4e3V6/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCTs9kXErMWQSyKXo1Ydc6z8Gymy0ArNRzSRFMeZ11Bh+7uLG0AStoueWxO0yv/R9qChvDiC7TNtkYQjLVcJDSCA3hHj60FbqgjgqaIdRrC0WeI1gaf2EabegW/TdZ4dT35Eg2bh+a/nYoYaTSL8Ld/YcN2NWL1cgWVoRp8c7Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=snKGYSSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6340C2BCB4;
	Tue,  5 May 2026 12:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777984927;
	bh=JrLZSn5vRWKEC9FNR+33WRgCciMwXtUznnnP4e3V6/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snKGYSSDYKYPhysCQH/yspkwtz9VWwK6kO4l8PL3tHB+eiUDXSjvCo0tciCkUm6xr
	 /cPEua2dxsUCxnXO2FPHDA69IKvm3K8i61eco0rdeSedQcade+xyS9qKtN8vRwmmo2
	 xH+m8q5pV2wFSf6TVQu0ZC5a6vnUJXlCqM3StwTQ=
Date: Tue, 5 May 2026 14:42:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yunseong Kim <yunseong.kim@est.tech>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	sashal@kernel.org, Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <yunseong.kim@ericsson.com>,
	Yunseong Kim <ysk@kzalloc.com>, 42.4.sejin@gmail.com
Subject: Re: [PATCH RESEND] checkpatch: validate upstream commit tags for
 stable backports
Message-ID: <2026050554-afoot-bolt-9785@gregkh>
References: <20260505112320.362715-2-yunseong.kim@est.tech>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505112320.362715-2-yunseong.kim@est.tech>
X-Rspamd-Queue-Id: 9B7324CDE1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244134-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[canonical.com,perches.com,kernel.org,gmail.com,vger.kernel.org,ericsson.com,kzalloc.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,est.tech:email]

On Tue, May 05, 2026 at 01:23:21PM +0200, Yunseong Kim wrote:
> According to the stable kernel rules (Option 3), backported patches
> should include the upstream commit reference using the SHA1 in one of
> two specific formats:
> 
>   1. commit <40 length sha1> upstream.
>   2. [ Upstream commit <40 length sha1> ]
> 
> Currently, checkpatch.pl does not validate these stable-specific
> formats, allowing truncated SHA1 characters to pass without notice.
> 
> These tags often conflict with the standard GIT_COMMIT_ID rule, which
> expects a "12+ chars of sha1" followed by the commit subject in
> parentheses. This causes checkpatch to trigger false positive errors.
> 
>   ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")'
>   - ie: 'commit e9acda52fd2e ("bonding: fix use-after-free due to enslave fail after slave array update")
>   #9: 
>   [ Upstream commit e9acda52fd2ee0cdca332f996da7a95c5fd25294 ]
> 
> Add validation to ensure these tags use the required 40-hex-character
> SHA1 and provide a warning if the format is malformed. For example:
> 
>   WARNING: Malformed 'commit ... upstream.' line - expected 'commit <40 hex chars SHA1> upstream.'
>   #7:
>   commit e9acda5 upstream.
> 
>   WARNING: Malformed '[ Upstream commit ]' line - expected '[ Upstream commit <40 hex chars SHA1> ]'
>   #7:
>   [ Upstream commit e9acda5 ]
> 
> Link: https://docs.kernel.org/process/stable-kernel-rules.html#option-3
> Signed-off-by: Yunseong Kim <yunseong.kim@est.tech>
> ---
>  scripts/checkpatch.pl | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)

This should not be needed, you should not need to run checkpatch on a
stable backport, as you will get quickly confused by any issues that are
in the original patch.

We take many different styles of backports for stable kernels, but yours
was just wrong, with the incorrect authorship information, which
checkpatch would not have caught.  Otherwise it would have been accepted
as-is.

thanks,

greg k-h

