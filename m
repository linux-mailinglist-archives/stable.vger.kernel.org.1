Return-Path: <stable+bounces-220033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNJ5Hb1Eomnd1QQAu9opvQ
	(envelope-from <stable+bounces-220033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 02:28:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A48B31BFB94
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 02:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4ED6E302CE23
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 01:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E5B2571D7;
	Sat, 28 Feb 2026 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e/abKRFI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF067E54B;
	Sat, 28 Feb 2026 01:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772242102; cv=none; b=Qb/CW2GRAsSG51OekKsfIL0IJan6R6N8HhiL8brAXFhNwP8GQCC4E1E49moMYIAJTGCm3zPU1/U6PFZsQWLH2LHZ/qB+tgcBpP9CZibaF5Rpvuwmr4ObjtjOqpwbHlgdo0UX8EGSWeNTQzqjYKuvpxKOMaO+J2kzSBZgnd8bmTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772242102; c=relaxed/simple;
	bh=QVTdJpksh0R6F5V/824NY/+c7ANoYX1Yr9+hZikFsN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7P+DQzUpja0PVlgRaPCb3QTPhVhjVDB14haErbNhr/Cj5DohMunysMDadBC0E6CXuyoX5VYCUJJB51Nz6vys1KUUaIv3OB9xYZ8Bf10U3hYjb97VJpPsjQvQipagbi+GyMLaikb/qw1+q0ysg1q74/BziHP8ifVBZry3owDUrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e/abKRFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4101C116C6;
	Sat, 28 Feb 2026 01:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772242102;
	bh=QVTdJpksh0R6F5V/824NY/+c7ANoYX1Yr9+hZikFsN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/abKRFIhVVasV6wH/QrhcfHlEjash7A1FDlpXfrOzXnL0oV3NpNcaKnoO0OVpiO/
	 eTXMOOeh3i1JNd5X9fsOznNZ3+P/YxKO3q1fRRYMVf2olpG4ZsAHhHZ7hXcdueTP1+
	 gz4AeEEPvNTtO8wrepZWhYHeZZ2CyzpNI3Bvofpk=
Date: Fri, 27 Feb 2026 20:28:11 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Evan Quan <evan.quan@amd.com>, Sasha Levin <sashal@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Eliav Farber <farbere@amazon.com>, Lijo Lazar <lijo.lazar@amd.com>,
	Ma Jun <Jun.Ma2@amd.com>, Zhigang Luo <Zhigang.Luo@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Bert Karwatzki <spasswolf@web.de>, Ray Wu <ray.wu@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>, Roman Li <Roman.Li@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>, Wentao Liang <vulab@iscas.ac.cn>,
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for 6.1 0/2] prepare to fix panic on old GPUs
Message-ID: <2026022733-backhand-acquaint-233a@gregkh>
References: <20260228011213.423524-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228011213.423524-1-rosenp@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220033-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,gmail.com,ffwll.ch,kernel.org,amazon.com,web.de,iscas.ac.cn,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: A48B31BFB94
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 05:12:11PM -0800, Rosen Penev wrote:
> In order to backport upstream fixes for black screen on boot with DC
> and old GPUs, These two commits need backporting for 6.1.

What fixes exactly?  Please make them part of the series, otherwise it
makes no sense for us to take them.

Also, you forgot to sign off on these patches, so we couldn't take them
even if we wanted to :(

thanks,

greg k-h

