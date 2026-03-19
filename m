Return-Path: <stable+bounces-227253-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKlJMV7Hu2kooQIAu9opvQ
	(envelope-from <stable+bounces-227253-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:52:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA0B2C9106
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2C553006834
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8343806AB;
	Thu, 19 Mar 2026 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ouzsMYWN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA2A375F99;
	Thu, 19 Mar 2026 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913946; cv=none; b=rZQv4LJLJez7IlA8IjMOyYvuGjDi9MhGe4OhcJEVhSzgdL8EwavAnoBjlWWabREpv0k/mo5EAwe7tjruye61Wi6kz8SVxGUYuNyn7BgEvH5VuKTRWmrgi3Vad2XT1nSl52/0zqtn58b62TjTAYRvepkO6jHaf9xHWMFOPgUpGdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913946; c=relaxed/simple;
	bh=4Qfd1Q5XgYM+CK2s6vx5dou3qkEQsI9rw6/NNHD2vuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtBs6nHG/Zx6l+rsaSWghuj5GxTZsulWlDzdIQz4apf7jWbiFeHSSaJCCgvyWdAk4b7Gs3+OZEi+euttPcrTXKTK0vOI+CAaZXdsELG0e+NXztcAt0P4hDcM/YqJ7eRRIGvU1JfQjzzDaGBGql9XrhULPxZfJad77qJbQ7Lgerg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ouzsMYWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881C6C19424;
	Thu, 19 Mar 2026 09:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773913946;
	bh=4Qfd1Q5XgYM+CK2s6vx5dou3qkEQsI9rw6/NNHD2vuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ouzsMYWNJ9HrAyMGy0NtOANi0HtgPVd8y230ib3UhKeQEcjjhd1Sp4Q2g9FpDQ7j5
	 aROYaYqM9ZkZOxSbg4qjEA4/6Gmy6J4vVOkrRdK0ZTv/AbCT3+qmtQw9kSudoSf0Ur
	 KYOeef4Ga3GNYVsJ3/uZG93r5L1Bv3CTZsrYNlFU=
Date: Thu, 19 Mar 2026 10:52:22 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: stable@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
	Alex Hung <alex.hung@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
	"chr[]" <chris@rudorff.com>, Sasha Levin <sashal@kernel.org>,
	Wentao Liang <vulab@iscas.ac.cn>,
	"open list:AMD DISPLAY CORE" <amd-gfx@lists.freedesktop.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for 6.12 and 6.6 1/2] drm/amd/display: Add pixel_clock to
 amd_pp_display_configuration
Message-ID: <2026031910-improving-approval-9457@gregkh>
References: <20260225215804.11398-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225215804.11398-1-rosenp@gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227253-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.742];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,gmail.com,ffwll.ch,rudorff.com,kernel.org,iscas.ac.cn,lists.freedesktop.org];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 8AA0B2C9106
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Feb 25, 2026 at 01:58:03PM -0800, Rosen Penev wrote:
> From: Timur Kristóf <timur.kristof@gmail.com>
> 
> commit b515dcb0dc4e85d8254f5459cfb32fce88dacbfb upstream.
> 
> This commit adds the pixel_clock field to the display config
> struct so that power management (DPM) can use it.
> 
> We currently don't have a proper bandwidth calculation on old
> GPUs with DCE 6-10 because dce_calcs only supports DCE 11+.
> So the power management (DPM) on these GPUs may need to make
> ad-hoc decisions for display based on the pixel clock.
> 
> Also rename sym_clock to pixel_clock in dm_pp_single_disp_config
> to avoid confusion with other code where the sym_clock refers to
> the DisplayPort symbol clock.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c       | 1 +
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dm_services_types.h             | 2 +-
>  drivers/gpu/drm/amd/include/dm_pp_interface.h                  | 1 +
>  4 files changed, 4 insertions(+), 2 deletions(-)

You did not sign-off on these backports :(


