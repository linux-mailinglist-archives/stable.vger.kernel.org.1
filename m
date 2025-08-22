Return-Path: <stable+bounces-172344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BEBB312F2
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 11:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8FBF5C0A05
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58442E8B61;
	Fri, 22 Aug 2025 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="khDL7oO4"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085329ACF0;
	Fri, 22 Aug 2025 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854685; cv=none; b=GYskt8txPs/Eld27hwZiJiM/wC98VA9VLN0zsC+9jFBmFT22A6HEYEzNKcSwuLzLw+Sghps1CvPViMZkVBSMb6GRT+ZBRArSkn39eRkhyiQF9/dV0sjR+8q9urDbqqk+IWv5XH6s8MsQx7++hqnAx2o12s2DQYPlImjBPgAE0kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854685; c=relaxed/simple;
	bh=4H3CSlZbt2YKASmV8QNlaFgG034FjBGOLnkZFuH48iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtcTxBg5ffY6TS/8iABtAxBLw72iR3TqfotX7k2zzctmRGqSGxrQS5SUqgFkL3ze6K2Grretv6GTccs6QFE2U0x/V6jRD/X56bnVAYtGsTcwOPMo1jJEFFgCivWgKnPYKnkZmK1RJAznnsrZwdlZ/Pm1zC4ZnluArCIxMnHi/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=khDL7oO4; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id 6111940643C9;
	Fri, 22 Aug 2025 09:24:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6111940643C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1755854672;
	bh=NC0e5OuHN3V1zBWdiEUAkeRkuP4dlYl3iTTfrLZTkNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khDL7oO4F+OfTZzrlYicYCN/ZsdoG2y7hhoOiy28YZ30Dpx/i7+4nqMivO/0/68RE
	 nOLywZ+1VBoOuDvXS9GCNi9mIADMevCvx3oUGYshacu6g3rLrC5TlT5xqk58L+1+/M
	 5xWMCETTac1UVRJ4fHOrHTI3GswaQZGuwk3/8/F8=
Date: Fri, 22 Aug 2025 12:24:32 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Melissa Wen <mwen@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Hans de Goede <hansg@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/amd/display: fix leak of probed modes
Message-ID: <20250822113609-348b2697616f3b82d6768feb-pchelkin@ispras>
References: <20250819184636.232641-1-pchelkin@ispras.ru>
 <20250819184636.232641-3-pchelkin@ispras.ru>
 <e3b1f1bb-eeee-4887-a0f9-d6aa1f725ff4@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3b1f1bb-eeee-4887-a0f9-d6aa1f725ff4@igalia.com>

Hi,

On Wed, 20. Aug 13:00, Melissa Wen wrote:
> On 19/08/2025 15:46, Fedor Pchelkin wrote:
> > amdgpu_dm_connector_ddc_get_modes() reinitializes a connector's probed
> > modes list without cleaning it up. First time it is called during the
> > driver's initialization phase, then via drm_mode_getconnector() ioctl.
> > The leaks observed with Kmemleak are as following:
> > 
> > unreferenced object 0xffff88812f91b200 (size 128):
> >    comm "(udev-worker)", pid 388, jiffies 4294695475
> >    hex dump (first 32 bytes):
> >      ac dd 07 00 80 02 70 0b 90 0b e0 0b 00 00 e0 01  ......p.........
> >      0b 07 10 07 5c 07 00 00 0a 00 00 00 00 00 00 00  ....\...........
> >    backtrace (crc 89db554f):
> >      __kmalloc_cache_noprof+0x3a3/0x490
> >      drm_mode_duplicate+0x8e/0x2b0
> >      amdgpu_dm_create_common_mode+0x40/0x150 [amdgpu]
> >      amdgpu_dm_connector_add_common_modes+0x336/0x488 [amdgpu]
> >      amdgpu_dm_connector_get_modes+0x428/0x8a0 [amdgpu]
> >      amdgpu_dm_initialize_drm_device+0x1389/0x17b4 [amdgpu]
> >      amdgpu_dm_init.cold+0x157b/0x1a1e [amdgpu]
> >      dm_hw_init+0x3f/0x110 [amdgpu]
> >      amdgpu_device_ip_init+0xcf4/0x1180 [amdgpu]
> >      amdgpu_device_init.cold+0xb84/0x1863 [amdgpu]
> >      amdgpu_driver_load_kms+0x15/0x90 [amdgpu]
> >      amdgpu_pci_probe+0x391/0xce0 [amdgpu]
> >      local_pci_probe+0xd9/0x190
> >      pci_call_probe+0x183/0x540
> >      pci_device_probe+0x171/0x2c0
> >      really_probe+0x1e1/0x890
> > 
> > Found by Linux Verification Center (linuxtesting.org).
> > 
> > Fixes: acc96ae0d127 ("drm/amd/display: set panel orientation before drm_dev_register")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index cd0e2976e268..7ec1f9afc081 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -8227,9 +8227,12 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
> >   {
> >   	struct amdgpu_dm_connector *amdgpu_dm_connector =
> >   			to_amdgpu_dm_connector(connector);
> > +	struct drm_display_mode *mode, *t;
> >   	if (drm_edid) {
> >   		/* empty probed_modes */
> > +		list_for_each_entry_safe(mode, t, &connector->probed_modes, head)
> > +			drm_mode_remove(connector, mode);
> >   		INIT_LIST_HEAD(&connector->probed_modes);
> >   		amdgpu_dm_connector->num_modes =
> >   				drm_edid_connector_add_modes(connector);
> 
> What if you update the connector with the drm_edid data and skip the
> INIT_LIST_HEAD instead?

Yep, getting rid of INIT_LIST_HEAD eliminates the leak, too.
drm_edid_connector_add_modes() comments do also strongly recommend calling
drm_edid_connector_update() before the function.

One thing remaining strange is that there'd be several different objects
in the probed_modes list describing the same things I guess.

> 
> Something like:
> 
> if (drm_edid) {

At this point we already have the modes in the list added with the
previous call to amdgpu_dm_connector_get_modes() from
amdgpu_set_panel_orientation() - during the driver initialization phase.

>    drm_edid_connector_update(connector, drm_edid);
>    amdgpu_drm_connector->num_modes =
> drm_edid_connector_add_modes(connector);

Here we add them again (as new objects) to the list.  By the way it leads
to amdgpu_drm_connector->num_modes be less than the actual number of
elements present in probed_modes list.

As far as I understand, *_get_modes() are supposed to be called only via
drm_mode_get_connector ioctl, and not all things go as expected if they're
firstly called in another path, as e.g. in amdgpu case through
amdgpu_set_panel_orientation().

But it seems commit acc96ae0d127 ("drm/amd/display: set panel orientation
before drm_dev_register") added that call deliberately.

I think we may update the connector with the drm_edid data and skip the
INIT_LIST_HEAD part as you've suggested, but also need to flush the list -
it might contain something left from the first amdgpu_dm_connector_get_modes()
call.

If no objections, I'll send it out as v3 soon.

> [...]
> }
> 
> Isn't it enough?


