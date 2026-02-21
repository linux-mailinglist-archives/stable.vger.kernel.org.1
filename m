Return-Path: <stable+bounces-217628-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL3tI6lRmWn2SgMAu9opvQ
	(envelope-from <stable+bounces-217628-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 07:33:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E9216C469
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 07:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C8973021705
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 06:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDCD279DB4;
	Sat, 21 Feb 2026 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yg7fznlM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E321684B0;
	Sat, 21 Feb 2026 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771655586; cv=none; b=F0TUyFZwUg5B9HGnefKXkDKeJ4czJcjLOOpfx2U7iWl2g5Cr421MPrmIUoKfELVSda/ipjNACDDqnNJKe7QU5Qnhz10DTgleFsZ0zyX5NpaG/zlAdKhCcnxhqS4y98EptI+oUy2JzP2yvUVfojm5yQ4PMXII9TUb+1ten9tNlYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771655586; c=relaxed/simple;
	bh=caYN/1ZHoXnmBXJ/pT/J0UP8KCsi4oMgXHnH+pcWTj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTb1YABitGV2sVoGt+2BP1wJ8nws8WZqXquE3a7pJAWXMkFMPR0Mq0IN/gE6KUJPBEN/NRddrTyptfxQbBXeTlwRJLfZYPWkptsyXNaZZEICS946V8+WKMJ52o5cDYHdmDr4u2kxbTQPmS/Xg1z8emcpfEONcRSdZtIlUyytN3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yg7fznlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C86C4CEF7;
	Sat, 21 Feb 2026 06:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771655585;
	bh=caYN/1ZHoXnmBXJ/pT/J0UP8KCsi4oMgXHnH+pcWTj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yg7fznlMJoEOg8cCoqbUhIB+kzehIXTov2fnMzlbPNC5Pok2m4eLQTPV7i7db1N1o
	 C7ntz/7MKNOEWf+ECYr6Z2YWLlNISV03vyU8wEsF2h4am12nzET+5f2O0fP2hM9o06
	 FOjnPl7QcVW2fieCnnfFzBgqwYosLsbyVMiwMS1w=
Date: Sat, 21 Feb 2026 07:33:02 +0100
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
Subject: Re: [PATCH 1/2] Revert "drm/amd/pm: Disable MCLK switching on SI at
 high pixel clocks"
Message-ID: <2026022124-creature-extenuate-34da@gregkh>
References: <20260221034402.69537-1-rosenp@gmail.com>
 <20260221034402.69537-2-rosenp@gmail.com>
 <2026022132-gem-stylishly-2c49@gregkh>
 <CAKxU2N8g+BRzyZ=5dWjrL3Eb4zRz-_yfv29tfJL2uvJpZWZUcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N8g+BRzyZ=5dWjrL3Eb4zRz-_yfv29tfJL2uvJpZWZUcw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217628-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5E9216C469
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 09:54:02PM -0800, Rosen Penev wrote:
> On Fri, Feb 20, 2026 at 9:40 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Feb 20, 2026 at 07:44:01PM -0800, Rosen Penev wrote:
> > > This reverts commit d033e8cf4e8f6395102cdbc3cb00dc7cb9542f53.
> >
> > Why?  You need to explain why you do something, not just what you are
> > doing.
> Not sure how to specify that it's a requirement for the second patch
> so that git revert works without problems.

Just say so, nothing complex here, just describe the problem and what is
needed to resolve it.  This ends up in the changelog, your patch 0/2
does not.

thanks,

greg k-h

