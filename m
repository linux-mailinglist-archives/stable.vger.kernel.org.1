Return-Path: <stable+bounces-217623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NtOEplFmWnNSQMAu9opvQ
	(envelope-from <stable+bounces-217623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 06:41:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E1316C337
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 06:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91EEC3008C3E
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 05:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE23313298;
	Sat, 21 Feb 2026 05:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jiY6AZ35"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D354414;
	Sat, 21 Feb 2026 05:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771652501; cv=none; b=sCYErEYThjvDeCDMY3a3/GF879Y3pCTVvmknxnE+C6jRGJ1s6ZpF5+bC7SFh28udwJ90w0bpkPOmpO7wxtfWluyg7saTURoz1PE7vWuS7KONGxY4y440yI0n0FhbFSpTQaYlriru//cECIL887ZP1ySfWTuLeWptSrMVKQdbahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771652501; c=relaxed/simple;
	bh=dILJaJLWNaymGhs7gSN08DU8nY4kViwy9GwyMBXqpl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwZ+tktygvvhJN9f7/Gfb8cAekuGkDnljy7P/ZN3uDjoq7/2/7htbi5UAa7enExTU0LGf106uuUVqBWFH1Bvg6XeyiXeL8iK9pG6ZTFT0LRpDTQ0sT6TyvS8fPo4Ivgv+ppbvRZB1i2zoPzo0l/8+6+5m6cGDlt0yPJynhONHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jiY6AZ35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68461C4CEF7;
	Sat, 21 Feb 2026 05:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771652500;
	bh=dILJaJLWNaymGhs7gSN08DU8nY4kViwy9GwyMBXqpl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jiY6AZ35TrJOFjA1SxH9rqIxI/9lg0sGDlmZm4m0KItyXLqq+68cSfrFgFjKVITcq
	 ZZccWg8G7+I79sWX/wGnmMyCbKuUXT3k0pckiYC4UCTzEtXnKB2iFiou75i6IDzYGD
	 j90LzJWXFruCYdx0DAIk4Y63nBRMxqvFEmHfrGhI=
Date: Sat, 21 Feb 2026 06:41:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: stable@vger.kernel.org, Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	"open list:AMD POWERPLAY AND SWSMU" <amd-gfx@lists.freedesktop.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] 6.12 and below: amdgpu: fix panic with SI and DC
Message-ID: <2026022126-calculate-matador-e7bd@gregkh>
References: <20260221034402.69537-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221034402.69537-1-rosenp@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217623-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,gmail.com,ffwll.ch,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 01E1316C337
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 07:44:00PM -0800, Rosen Penev wrote:
> The first commit is needed for the second one to be reverted cleanly.
> 
> The second breaks DC support on my AMD 7750. Kernel panics and I get a
> black screen on boot. With these two reverted, 6.12 is usable again.
> 
> Tried to git cherry-pick the fixes but that proved to be difficult to
> do cleanly.
> 
> I see 6.6 also has these two commits.
> 
> Not sure what the proper procedure is to request reverts on stable
> kernels.

Close, see my comments on the first patch.

thanks,

greg k-h

