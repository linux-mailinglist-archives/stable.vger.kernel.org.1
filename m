Return-Path: <stable+bounces-231233-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KApIDWmIymn09gUAu9opvQ
	(envelope-from <stable+bounces-231233-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:27:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB6835CD24
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A82B306CF45
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208FA3D75DA;
	Mon, 30 Mar 2026 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1LGKUqJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680D93BED74
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880511; cv=none; b=sLrX7LwN4XMc3WupgyQu1QSs+2bPcAFftzHTtAEDdv+t+vPgj5CbK9O/YjelMGHD0mUYrf7NUN+sN4KHRhyoj39uJl0AUOYyrzO4DMeIeQ3WvMl0n0qnlXJLNIjHeBPDHJkJxaA7C0l+RxANS3ftgkVmW32Ewr3b4CZKLeuhIMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880511; c=relaxed/simple;
	bh=xPYYFffO2JvL6Gyrx07KGnUt/pBCCiZo+BiSrblUBW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLdgIJtQdkxH14kFGHZlufpBran4hWGiGNe4XtgF84hUQeoJ2cZqjI1oDevZTiM8p4ljHiCPSuoq5K55IkZ4vojwvNmvoQYuqsBTOJzWe022gwtexD1TjBS6tFpFg6b0P7Wv+wH1P0cxffA5E6XHETrAkSFvi0xyKo/XnfkveBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1LGKUqJ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b949bf4easo2639048f8f.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774880509; x=1775485309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gI1060qWAxguxfqLo7d74lXelCuf/bPUdPr59uzbe0=;
        b=Z1LGKUqJHhzZvm2vldcEXaFUSe10lyX1VDaRVravL1to6Szmr2dBa03ryCVXDXpmoL
         Rod4OWYGQceh1GUlrFS0NEB0iPuWkDsS4AdBkt+epjzZvXMbo4KDazavabvQXa/DIE3J
         x6fmSCm5eNT5kbYpPXaXApQQ3rCKGVyljwPE8yhaPt9jULFF0tD7puwyISa8iScpworF
         7JPf7l2Afl+nDatnqDNay558/f6UvwHgPU81UPdV4PTd2vJkWjQOpMcWONRkdyqAElO9
         Vi6XQC2knMK8bvdjn2ZjqWHcFmr4Ww44Unb70ys/y4IlLiSj4RuLQv1Ao90/4IQ5xOAf
         CMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774880509; x=1775485309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3gI1060qWAxguxfqLo7d74lXelCuf/bPUdPr59uzbe0=;
        b=SdysWryvbp0fR87R7rkWfD7RMz/vkS5hFCfswIrubft/6A3iGi3ghB7MZ8r4gRgj22
         N4OoW0NIIvo1cfUA/j6Bp8lLavBwom8GItto81ukPPftXOkUvCDmlw6uOKRIuWH7Sgo7
         7wI7b9yW/95nfHauFFiyM5o+gxyYcq5Gv0K1+XHK9xmZxGkEi5u1BwU6ooszA1zLQNvD
         6TXZ6CHNxBUNHKpQqWvkZ5aIQP3R7wcD/VN+MOKZRJ0vXMn6mxJBbGVPSepc1cmYXKI2
         SyPnp8Vm7Nc9YxDlATrFVz8iEJuEkaWHG6wt9nsCvcH+/St+uZe6zdR+ZSyBiXGbnsWC
         amgg==
X-Gm-Message-State: AOJu0YwRvPBZlBEcniSLRwC6iZd6XRQdjxEc0xtApdpL284bi45HsuFo
	isPmpyt+ksPAB/GoYd7U/1COraMDbXw5Twr3f7zI4dg/rGz0qIOtTsZEqs99K0jO
X-Gm-Gg: ATEYQzwEjgHFRgAOge/nMzV57Gd8B4Z88GzROlijKbQolU/CEB6lINvvyt5VLkPak0O
	RzhLGtJwRq7ovzqRei3ATbDwIY8d33+UT2O+bVCr21FnB7B8ra4znt8z6695co8pxbXoJe4BA4v
	1b7Ka1FruFJnCkNnHZLTGfod793sF9moVhzj+2AxnAcPCCL7I+E2b9k/6ob0Fo55kymjDqA0XqH
	ywc1WT16evDNfwDTcaT3GK81xa5EH6qUH3muS6k3MMQ97Kl7i44KNY/zhWBoVaN+c818lCOXZfv
	1ceGfeGvds1OBu2heNUhXG78YCdwWgqdVQ9hMbA3z/9uA8gw/CkKQ6Rb9xsV0BU02rE/6qlVgO3
	90mtPnVZIp6h40FXhIfRGpQioHS+Z9ksdIghQ222aIlUNbMvOcOQXn+k8frvp8uMErYeImSsjku
	BpPeKXq/D1t/6VEH+VCRyfiXE4q9WnluQTZo+dLMj/PB8FEWlYHvNLrLQBs31Xq16Z4VXGIkhy
X-Received: by 2002:a05:6000:22c9:b0:43c:f1da:487d with SMTP id ffacd0b85a97d-43cf1da48c5mr16375164f8f.2.1774880508452;
        Mon, 30 Mar 2026 07:21:48 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1BC26F.dsl.pool.telekom.hu. [94.27.194.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245ebafsm18062796f8f.21.2026.03.30.07.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:21:48 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: stable@vger.kernel.org, Rosen Penev <rosenp@gmail.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bin Lan <bin.lan.cn@windriver.com>, He Zhe <zhe.he@windriver.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH for 6.12 3/9] drm/amd/display: Disable fastboot on DCE 6 too
Date: Mon, 30 Mar 2026 16:21:46 +0200
Message-ID: <7351746.9J7NaK4W3v@timur-hyperion>
In-Reply-To: <6b15401c-1fdf-4d3b-84aa-dfc47f430895@amd.com>
References:
 <20260326234716.16723-1-rosenp@gmail.com> <2312151.9o76ZdvQCi@timur-hyperion>
 <6b15401c-1fdf-4d3b-84aa-dfc47f430895@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231233-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[amd.com,linux.ie,ffwll.ch,linuxfoundation.org,windriver.com,igalia.com,gmail.com,lists.freedesktop.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[timurkristof@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.982];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.freedesktop.org:url,igalia.com:email,amd.com:email]
X-Rspamd-Queue-Id: ACB6835CD24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Monday, March 30, 2026 3:55:55=E2=80=AFPM Central European Summer Time C=
hristian=20
K=C3=B6nig wrote:
> On 3/30/26 15:16, Timur Krist=C3=B3f wrote:
> > On Friday, March 27, 2026 12:47:10=E2=80=AFAM Central European Summer T=
ime Rosen
> > Penev>=20
> > wrote:
> >> From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >>=20
> >> [ Upstream commit 7495962cbceb967e095233a5673ea71f3bcdee7e ]
> >>=20
> >> It already didn't work on DCE 8,
> >> so there is no reason to assume it would on DCE 6.
> >>=20
> >> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
> >> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >> Reviewed-by: Alex Hung <alex.hung@amd.com>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >=20
> > This patch is incorrect and should not be backported.
> >=20
> > (Note that the error is already fixed upstream. For stable kernels IMO
> > it's
> > best to drop this one.)
>=20
> Is there some alternative which needs to be backported or should the old
> kernel just work out of the box because we never enabled some feature
> there?
>=20
> Apart from that the patch set looks good to me.
>=20

This patch had a typo and does the opposite of what it should, ie. it disab=
les=20
eDP fastboot on DCE10 and newer instead of disabling it on DCE8 and older.

The upstream fix is here:
https://lists.freedesktop.org/archives/amd-gfx/2026-February/138577.html
which disables eDP fastboot on DCE10 and older.

>=20
> >> ---
> >>=20
> >>  drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 6 ++----
> >>  1 file changed, 2 insertions(+), 4 deletions(-)
> >>=20
> >> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> >> b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c index
> >> df69e0cebf78..7dc99c85b8ea 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> >> @@ -1910,10 +1910,8 @@ void dce110_enable_accelerated_mode(struct dc *=
dc,
> >> struct dc_state *context)
> >>=20
> >>  	get_edp_streams(context, edp_streams, &edp_stream_num);
> >>=20
> >> -	// Check fastboot support, disable on DCE8 because of blank
> >=20
> > screens
> >=20
> >> -	if (edp_num && edp_stream_num && dc->ctx->dce_version !=3D
> >=20
> > DCE_VERSION_8_0
> >=20
> >> && -		    dc->ctx->dce_version !=3D DCE_VERSION_8_1 &&
> >> -		    dc->ctx->dce_version !=3D DCE_VERSION_8_3) {
> >> +	/* Check fastboot support, disable on DCE 6-8 because of blank
> >=20
> > screens */
> >=20
> >> +	if (edp_num && edp_stream_num && dc->ctx->dce_version <
> >=20
> > DCE_VERSION_10_0)
> >=20
> >> { for (i =3D 0; i < edp_num; i++) {
> >>=20
> >>  			edp_link =3D edp_links[i];
> >>  			if (edp_link !=3D edp_streams[0]->link)





