Return-Path: <stable+bounces-231395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGdbJKuqy2kpKAYAu9opvQ
	(envelope-from <stable+bounces-231395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:06:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0863836880A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6F143016267
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE9D3A7F54;
	Tue, 31 Mar 2026 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KigaQzFR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830703A6B6F;
	Tue, 31 Mar 2026 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955017; cv=none; b=qbkmG1l2TrhDNG9bQudYpVxQ2aI9D4lg34plrArkOe5dSEAZ/ZiTO3kwOTYJCzSdeEbqM23h995mhLeY5WS/ah1m30zNhtDaSWkC5JjpZDjmz8U9QV3VnFwSmb/DuhAqA0H1Im7aOtyUQQuSzIM3ukMbCOiEmmj8QLT5oitgKmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955017; c=relaxed/simple;
	bh=ki8n3fWjJ0uDLFj/cJjwAfUHSi8/QbPmwfna1VWmJpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2qwJBG1DxPli0RdS/TfnN2Lgft9Dbm52fYscugbI4neysm9hWDTcrCfuqxlc6wc0Z5Aio4mTRhCnlYjKyvtBxWCJqCDiAqLErXXPUYrw7VYKBj5ZOpka28UzVwj0M1wK1swBqGSQuOesP07aFIY7PVjtTc4b4tifKYIDZzpHFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KigaQzFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7123FC19423;
	Tue, 31 Mar 2026 11:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774955017;
	bh=ki8n3fWjJ0uDLFj/cJjwAfUHSi8/QbPmwfna1VWmJpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KigaQzFRq2BwuyGeaF4v7+e+qDvQNCTfHCJOLYHznpfQXn8fDrFu+rMX4zjSX6ur8
	 INwAPokWjXvuUaS44mCmKq6efIjjqm2ZMjC63Le1YoKE0ZUQZcp9Zea/DyeL+MB29y
	 Nwn9PxeHLMdIOKO5YCCJLY1E0G0YiD/epwQ3mTLw=
Date: Tue, 31 Mar 2026 13:03:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
	stable@vger.kernel.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>, Bin Lan <bin.lan.cn@windriver.com>,
	He Zhe <zhe.he@windriver.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	Ray Wu <ray.wu@amd.com>, Wayne Lin <wayne.lin@amd.com>,
	Roman Li <Roman.Li@amd.com>, Eric Yang <Eric.Yang2@amd.com>,
	Tony Cheng <Tony.Cheng@amd.com>,
	Mauro Rossi <issor.oruam@gmail.com>,
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for 6.12 3/9] drm/amd/display: Disable fastboot on DCE 6
 too
Message-ID: <2026033157-trifocals-swerve-d18f@gregkh>
References: <20260326234716.16723-1-rosenp@gmail.com>
 <2312151.9o76ZdvQCi@timur-hyperion>
 <6b15401c-1fdf-4d3b-84aa-dfc47f430895@amd.com>
 <7351746.9J7NaK4W3v@timur-hyperion>
 <CAKxU2N-CRua=kMVm8gdf2AnbCFyLsLTbf=-9NZHAkhL3sJC-tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N-CRua=kMVm8gdf2AnbCFyLsLTbf=-9NZHAkhL3sJC-tw@mail.gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231395-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.686];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,amd.com,linux.ie,ffwll.ch,windriver.com,igalia.com,lists.freedesktop.org];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.freedesktop.org:url,amd.com:email]
X-Rspamd-Queue-Id: 0863836880A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 02:38:35PM -0700, Rosen Penev wrote:
> On Mon, Mar 30, 2026 at 7:21 AM Timur Kristóf <timur.kristof@gmail.com> wrote:
> >
> > On Monday, March 30, 2026 3:55:55 PM Central European Summer Time Christian
> > König wrote:
> > > On 3/30/26 15:16, Timur Kristóf wrote:
> > > > On Friday, March 27, 2026 12:47:10 AM Central European Summer Time Rosen
> > > > Penev>
> > > > wrote:
> > > >> From: Timur Kristóf <timur.kristof@gmail.com>
> > > >>
> > > >> [ Upstream commit 7495962cbceb967e095233a5673ea71f3bcdee7e ]
> > > >>
> > > >> It already didn't work on DCE 8,
> > > >> so there is no reason to assume it would on DCE 6.
> > > >>
> > > >> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> > > >> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
> > > >> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > > >> Reviewed-by: Alex Hung <alex.hung@amd.com>
> > > >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > >> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > >
> > > > This patch is incorrect and should not be backported.
> > > >
> > > > (Note that the error is already fixed upstream. For stable kernels IMO
> > > > it's
> > > > best to drop this one.)
> > >
> > > Is there some alternative which needs to be backported or should the old
> > > kernel just work out of the box because we never enabled some feature
> > > there?
> > >
> > > Apart from that the patch set looks good to me.
> > >
> >
> > This patch had a typo and does the opposite of what it should, ie. it disables
> > eDP fastboot on DCE10 and newer instead of disabling it on DCE8 and older.
> >
> > The upstream fix is here:
> > https://lists.freedesktop.org/archives/amd-gfx/2026-February/138577.html
> > which disables eDP fastboot on DCE10 and older.
> Not sure what the process is here. I make sure everything can be git
> cherry-pick ed. In that case, both should be present.

I agree, I don't understand the problem here.  Just take the commits
that are upstream including "fixes for the fixes".

Timur, what specifically do you want to see happen here?

thanks,

greg k-h

