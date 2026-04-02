Return-Path: <stable+bounces-232998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P9nBsVbzmmgnAYAu9opvQ
	(envelope-from <stable+bounces-232998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 14:06:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E53E388CAD
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 14:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C358307CD21
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 11:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EAD3B47D4;
	Thu,  2 Apr 2026 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1xd7w09"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A179364927
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131004; cv=none; b=NaVaxO2FFCMkiDCA+SbRlAXmpkjyzKteVQ/AV8aTcSt4oT32anr6uG+RQxN8zeyfqK5B5D6uCkpBBzgH7IcO1vk/9IrEaoMMM0tyA3SDXKGl8RNb+/QE3ukVV2vlyK3XRy8VSKjWoL+xwX9pvEh8q0DbMERkF9DYq6a47FDDOI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131004; c=relaxed/simple;
	bh=+1U/9un6I61t5dD/kNO8gzYZEr/Ve56w9Pu2h1LkEjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HB9Z4IhMDSAfL0JHIE/js+MytomuEFeIvv7Lpo392I4oSpb2Inq6YTtddND5jEnV45FiAIAIpH7B8r2iV9wKnNZpNWPLVij/ON6OoK3ITeKhi9tYSeWDS8fpoDXktpkT6zwM57PFGOsg/1yrCyfl2uWlztWt0oJA7S8InHZiZd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1xd7w09; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso6853565e9.3
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 04:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775131000; x=1775735800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YctibcwBaos343EPy20tcq2y4ZWpcBKe/QemXdR+Sw=;
        b=G1xd7w09k3Fal3tPYCJzqBnUi+C5kEuXFJBVwKHLshMVj97S6bgVQNFnvjx7lDUCnU
         J5LUBTzXkt8QAUTOnn30pxmzt3yHuqAZIOaWTf4mFJuo12SYEK8Cb44orkQLw/asIqdY
         eB8Zmct7qnEYjoFIwXz+vVaH0N6AkgxMq1ScZk+WgQDehgZ9AFjJzRvtNGUSDXK9uZCq
         YxROTz4Ire1WHVgSjLXNe42piDuNlmSYcwB1p2xCgICdExoUJ2R7tANJz4aoPVrt2ofH
         cUqtCN20+wze8qECY32mhEuZzwwOBB45SRY+YwMUgNg+wl5oI6R3bkuwAOp4XBDHxk/1
         BAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775131000; x=1775735800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8YctibcwBaos343EPy20tcq2y4ZWpcBKe/QemXdR+Sw=;
        b=PI7X2puyEEmd7hLH1RgrELs9MCo0dvrVQ2j/HvEA4OY3PKO9e6DRqpEH7y78nFWEO1
         3MYBFMcHpB6KvJKqE8mycX57lpZLwuYWbFH4pfSPbqtHLRaqQShOZ5EvR3fhIzVufYJM
         3dka4tWtG2D3CX2BRpZ/QN3ntbK7mRnbaP5hQ1GL/IU5RBc8XYY1rkABWGGux4inswRU
         G+78t7XUhLUDAAEGxPIkx3XuCwQawoULjaLCss0WWfbIEHba1wvzJN1RIaZ9C1XWYTta
         9Sg9igkSWEWHS56Z/BH0iR6tw7NWYa67ADlduiJlI2J/cfTZBk8GLiC6HaiVR5gKfGX2
         p9Lw==
X-Gm-Message-State: AOJu0Yzl7tmv8Ghu+kLJUYX140RDRYmC/+GAFcl+q0luBeH4XcSwaCdk
	wBh+xNERMz4em2hzG8Qv3OzieMQ08Li7Dc2EU2+WJP8k/05dUzYImp1R
X-Gm-Gg: ATEYQzzP/dvzIAc8qIgh3Qz/LgP9CVdNPTMzJUt7/OmqRfkn5bDg6S77EnYUUMCT05+
	MX5H0g5dbrKgypctvyKra4u/cxEkTXHmS/R/j3FRP/89PJCwBf2xosoQjGzPqcG5Rmv74xntN8B
	eczB5ngxBQBH76cPnnhn3/zlz1tUGMqBvWio1ZJ4GIutQwqmLXrD1SZlkUH4yLz77/gO8wAdwUi
	ZUz8tfjBav+QHH3vP/+u32Y/Dtiyyld6skUwBJUV4e9N5rUfEPuj9dr5j4zrI4VWCzLUe85rT65
	bFGKYrg5Ht7saLMMFvtPH4xfeD6Pv/IU7IItRf6RJC0fVGITIxNH4Pz/7fFiplfnoukB5dlMz7/
	VqE55+YVb1Wo4XPaay6IZRtRZUoY2C8kBdPFgvrzjsyjwMUJI4kdk20XjYsKfW1+8vs1sDSomay
	OaI5f8amr38GGa5xolXC5GYcs1Do2LF6eI1UZ+LXeTjSKOY8ljNE6W4otNh7hSEvssfmbnWxTQ
X-Received: by 2002:a05:600c:8209:b0:485:5c6e:8a38 with SMTP id 5b1f17b1804b1-48883591d6amr141270405e9.17.1775130999396;
        Thu, 02 Apr 2026 04:56:39 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1BC26F.dsl.pool.telekom.hu. [94.27.194.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a65635fsm65554775e9.6.2026.04.02.04.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 04:56:38 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Rosen Penev <rosenp@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
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
Date: Thu, 02 Apr 2026 13:56:35 +0200
Message-ID: <2257770.9o76ZdvQCi@timur-hyperion>
In-Reply-To: <2026033157-trifocals-swerve-d18f@gregkh>
References:
 <20260326234716.16723-1-rosenp@gmail.com>
 <CAKxU2N-CRua=kMVm8gdf2AnbCFyLsLTbf=-9NZHAkhL3sJC-tw@mail.gmail.com>
 <2026033157-trifocals-swerve-d18f@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232998-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,linux.ie,ffwll.ch,windriver.com,igalia.com,gmail.com,lists.freedesktop.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[timurkristof@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1E53E388CAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tuesday, March 31, 2026 1:03:34=E2=80=AFPM Central European Summer Time =
Greg Kroah-
Hartman wrote:
> On Mon, Mar 30, 2026 at 02:38:35PM -0700, Rosen Penev wrote:
> > On Mon, Mar 30, 2026 at 7:21=E2=80=AFAM Timur Krist=C3=B3f <timur.krist=
of@gmail.com>=20
wrote:
> > > On Monday, March 30, 2026 3:55:55=E2=80=AFPM Central European Summer =
Time
> > > Christian
> > >=20
> > > K=C3=B6nig wrote:
> > > > On 3/30/26 15:16, Timur Krist=C3=B3f wrote:
> > > > > On Friday, March 27, 2026 12:47:10=E2=80=AFAM Central European Su=
mmer Time
> > > > > Rosen
> > > > > Penev>
> > > > >=20
> > > > > wrote:
> > > > >> From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > >>=20
> > > > >> [ Upstream commit 7495962cbceb967e095233a5673ea71f3bcdee7e ]
> > > > >>=20
> > > > >> It already didn't work on DCE 8,
> > > > >> so there is no reason to assume it would on DCE 6.
> > > > >>=20
> > > > >> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > >> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
> > > > >> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > > > >> Reviewed-by: Alex Hung <alex.hung@amd.com>
> > > > >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > >> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > > >=20
> > > > > This patch is incorrect and should not be backported.
> > > > >=20
> > > > > (Note that the error is already fixed upstream. For stable kernels
> > > > > IMO
> > > > > it's
> > > > > best to drop this one.)
> > > >=20
> > > > Is there some alternative which needs to be backported or should the
> > > > old
> > > > kernel just work out of the box because we never enabled some featu=
re
> > > > there?
> > > >=20
> > > > Apart from that the patch set looks good to me.
> > >=20
> > > This patch had a typo and does the opposite of what it should, ie. it
> > > disables eDP fastboot on DCE10 and newer instead of disabling it on
> > > DCE8 and older.
> > >=20
> > > The upstream fix is here:
> > > https://lists.freedesktop.org/archives/amd-gfx/2026-February/138577.h=
tml
> > > which disables eDP fastboot on DCE10 and older.
> >=20
> > Not sure what the process is here. I make sure everything can be git
> > cherry-pick ed. In that case, both should be present.
>=20
> I agree, I don't understand the problem here.  Just take the commits
> that are upstream including "fixes for the fixes".
>=20
> Timur, what specifically do you want to see happen here?

Hi Greg,

It's up to you how you prefer to address this. I just wanted to call Rosen'=
s=20
attention to the above issue to avoid regressing the stable kernels.
I'm happy with either dropping the patch or backporting the patch together=
=20
with its fix.

Thanks,
Timur



