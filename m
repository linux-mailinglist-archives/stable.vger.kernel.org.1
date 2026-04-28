Return-Path: <stable+bounces-241713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKD8N6vk8GmoagEAu9opvQ
	(envelope-from <stable+bounces-241713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:47:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A025489480
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B480359B62C
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751B247276C;
	Tue, 28 Apr 2026 16:12:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A13D46AEF6;
	Tue, 28 Apr 2026 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392763; cv=none; b=bQXyxvCinQqbmN4T5GOuAnvAmiRsmva6Plyv1qLDvNkUmd1k72pFEI6n0Sqk10u8eNLpTtGlkTYS2mHjwpq2flbUrPVSM0Tu/3Zm6nZC6wtNMlgbHZqTpc/F3jYT6oPhqqxr1gcVoruC/LiJzXNQ0KuW7osMzjB2oQgo3vn1BZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392763; c=relaxed/simple;
	bh=Fx3PduBVSyLkVM8toEk1sldqWq7Omw64u3Nsk5oWdHY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F2+X5H6QQiBPHbC/hELsSr7kWbgfMGm9FMduCSzXRD9Vn5I4F+zAKkutAUNYfmeDSMOcwkOfIDqmKDu2i0ptg144i2zWEz0fmPwCWKo2q/1ACVwiHrTOyacCGRvlut5C7O/YVapgUMQv9Y28L/UgPQiQ0dCufZH855f9cDqOOJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.122])
	by APP-05 (Coremail) with SMTP id zQCowAAHlQhs3PBp9wbXDg--.40385S2;
	Wed, 29 Apr 2026 00:12:28 +0800 (CST)
Message-ID: <d349eb9a8632d847eca48ece1e6c88b717dddde1.camel@iscas.ac.cn>
Subject: Re: [PATCH] drm/panel: himax-hx83102: restore MODE_LPM after
 sending disable cmds
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Doug Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang	
 <jesszhan0024@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Cong Yang	
 <yangcong5@huaqin.corp-partner.google.com>, David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 29 Apr 2026 00:12:28 +0800
In-Reply-To: <CAD=FV=XPAWEiN4EFvY0sA7uEBqxpc0iiD28Y9BmpguoerG1hpg@mail.gmail.com>
References: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
	 <CAD=FV=VXD34ZZTH4MJUtZ6xifbbjp1cLRBd_xvz=3T12G4tKYw@mail.gmail.com>
	 <d9faab05aab120fee367394edcb35bd131c97646.camel@iscas.ac.cn>
	 <CAD=FV=X-FUw_MqE2ufv=ngBS3ho4vg-QKokav+MeP7XAAjXUbg@mail.gmail.com>
	 <151c1c1d52fce8c3b1dac3a919be3086ce3426df.camel@iscas.ac.cn>
	 <CAD=FV=XPAWEiN4EFvY0sA7uEBqxpc0iiD28Y9BmpguoerG1hpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:zQCowAAHlQhs3PBp9wbXDg--.40385S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4xAr15AF4xCryxZr1DKFg_yoW5trykpa
	yUtFy2yFWDJr4Iywn2vw4rZFWUtr4ftryjgrn8K348Zr909F18C3yxKrn8ua4DWr1kGw42
	qF40qFy3Wa1DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUqiFxDUUUU
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
X-Rspamd-Queue-Id: 0A025489480
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241713-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,linux.intel.com,kernel.org,suse.de,huaqin.corp-partner.google.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhengxingda@iscas.ac.cn,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.706];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iscas.ac.cn:mid,iscas.ac.cn:email]

=E5=9C=A8 2026-04-28=E4=BA=8C=E7=9A=84 08:56 -0700=EF=BC=8CDoug Anderson=E5=
=86=99=E9=81=93=EF=BC=9A
> Hi,
>=20
> On Tue, Apr 28, 2026 at 8:53=E2=80=AFAM Icenowy Zheng
> <zhengxingda@iscas.ac.cn> wrote:
> >=20
> > =E5=9C=A8 2026-04-28=E4=BA=8C=E7=9A=84 08:48 -0700=EF=BC=8CDoug Anderso=
n=E5=86=99=E9=81=93=EF=BC=9A
> > > Hi,
> > >=20
> > > On Mon, Apr 27, 2026 at 10:49=E2=80=AFPM Icenowy Zheng
> > > <zhengxingda@iscas.ac.cn> wrote:
> > > >=20
> > > > =E5=9C=A8 2026-04-27=E4=B8=80=E7=9A=84 11:24 -0700=EF=BC=8CDoug And=
erson=E5=86=99=E9=81=93=EF=BC=9A
> > > > > Hi,
> > > > >=20
> > > > > On Sat, Apr 25, 2026 at 9:58=E2=80=AFAM Icenowy Zheng
> > > > > <zhengxingda@iscas.ac.cn> wrote:
> > > > > >=20
> > > > > > When preparing the panel, it seems that it always expects
> > > > > > commands
> > > > > > to be
> > > > > > transferred in LP mode. However, the disable function
> > > > > > removes
> > > > > > the
> > > > > > MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
> > > > > >=20
> > > > > > As the unprepare function contains no DSI commands, re-
> > > > > > adding
> > > > > > the
> > > > > > flag
> > > > > > just after disabling the panel should be safe. Add the code
> > > > > > re-
> > > > > > adding
> > > > > > the flag after the two commands for disabling the panel are
> > > > > > sent.
> > > > > >=20
> > > > > > This fixes screen unblanking (after blanking once) on
> > > > > > mt8188-geralt-ciri-sku1 device.
> > > > > >=20
> > > > > > Cc: stable@vger.kernel.org=C2=A0# 6.11+
> > > > > > Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out
> > > > > > as
> > > > > > separate driver")
> > > > >=20
> > > > > This "Fixes" looks wrong. The bug was still there even before
> > > > > the
> > > > > driver was broken out. ...and it looks like the driver that
> > > > > this
> > > > > was
> > > > > broken out of (panel-boe-tv101wum-nl6.c) still has the same
> > > > > bug?
> > > >=20
> > > > Yes, but I think the fix shouldn't be propagated to the other
> > > > driver
> > > > because of the same reason with breaking out the original
> > > > driver.
> > >=20
> > > ...but doesn't all the same logic apply to the other driver?
> > > Nothing
> > > ever adds MIPI_DSI_MODE_LPM back in.
> > >=20
> > > Even if you don't fix the other driver yourself right now, the
> > > proper
> > > "Fixes" tag is when the problem was introduced, not when the
> > > driver
> > > forked out.
> >=20
> > I think the Fixes tag should point to where the driver is forked
> > out,
> > and if I'm going to send a patch for panel-boe-tv101wum-nl6, it
> > will
> > has a Fixes tag pointing to the further commit affecting that
> > driver.
>=20
> You're free to have your own opinion, but that doesn't match my
> understanding of the Fixes tag. If you can convince Neil or some
> other
> drm-misc committer to land your changes with the Fixes tag as you
> have
> it, then I won't object, but I won't land it. Best of luck!

I checked the forking commit, and the forking process doesn't involve
moving a `dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM` clause from the panel-
boe-tv101wum-nl6 driver to the panel-himax-hx83102 driver, which means
that this clause in the new driver is new, and shouldn't be trivially
backported to the old driver (because this process will affect other
non-hx83102 panels in that driver). Even if the unblanking issue exists
before the forking point, the specific code fixed by this commit is
created by the forking point (just by copying), instead of the previous
commit introducing the starry panel or the initial addition of the LPM
masking code to panel-boe-tv101wum-nl6 .

In addition, this isn't a regression fix, so Fixes tag is only
informative for backporting. The previous paragraph has already proved
that pointing it further isn't meaningful for backporting.

>=20
> -Doug


