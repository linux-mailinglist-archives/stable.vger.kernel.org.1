Return-Path: <stable+bounces-241477-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE0XJJVK8GlFRQEAu9opvQ
	(envelope-from <stable+bounces-241477-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 07:50:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9404547DC4D
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 07:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B033D300B8DB
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 05:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F69227B340;
	Tue, 28 Apr 2026 05:50:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FFE1A6816;
	Tue, 28 Apr 2026 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777355406; cv=none; b=GkAtf2/mzoPsxTz1OywZRvekcLZcEVYRVX5A6CmS3baOw8pRp7F0yruAdMnUEXvVtmtuJcplaQfDP2AY5r0PqblVGx6V6qqd6+ldSuRyK5uvAsjiwqY02pjqhIS/tjYPm1Y+1We+/nyafzNiAmXlqQNtdZMUIVnr/YJH3Lg/LXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777355406; c=relaxed/simple;
	bh=SolhQZYcDEW43TERJXKDjunTD4PVMs+EA+sD9J+ua/k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pDOBKDVJVxN8N8yhwaqglRx3OhnoXLUAySiTRmqSkAAZ61L2ildDY9U3zBO1m3VbNaIur3RtQY7R+ByOjyhciDQD9X+iOCTv65teJlQg8Ur1+HaFoOgT2BaqWt6ycKGmYuIS2FwJSS6gwfvXFWPgMUr1Rijw9Flno9LE7b0esmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.122])
	by APP-05 (Coremail) with SMTP id zQCowACHFgp+SvBpHObKDg--.35547S2;
	Tue, 28 Apr 2026 13:49:52 +0800 (CST)
Message-ID: <d9faab05aab120fee367394edcb35bd131c97646.camel@iscas.ac.cn>
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
Date: Tue, 28 Apr 2026 13:49:50 +0800
In-Reply-To: <CAD=FV=VXD34ZZTH4MJUtZ6xifbbjp1cLRBd_xvz=3T12G4tKYw@mail.gmail.com>
References: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
	 <CAD=FV=VXD34ZZTH4MJUtZ6xifbbjp1cLRBd_xvz=3T12G4tKYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:zQCowACHFgp+SvBpHObKDg--.35547S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy7GFWDCrW5Xw48JF1rtFb_yoW8XrWfpF
	WUta9Ika1kJr4IyFn7XrZYvFWxAr4fAFZ0krn5W34kA345WFyFvay8trWq93WUXr4kCa1a
	qFsFqFyqka95AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxU2wIDUUUUU
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
X-Rspamd-Queue-Id: 9404547DC4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241477-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.982];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:mid,iscas.ac.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

=E5=9C=A8 2026-04-27=E4=B8=80=E7=9A=84 11:24 -0700=EF=BC=8CDoug Anderson=E5=
=86=99=E9=81=93=EF=BC=9A
> Hi,
>=20
> On Sat, Apr 25, 2026 at 9:58=E2=80=AFAM Icenowy Zheng
> <zhengxingda@iscas.ac.cn> wrote:
> >=20
> > When preparing the panel, it seems that it always expects commands
> > to be
> > transferred in LP mode. However, the disable function removes the
> > MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
> >=20
> > As the unprepare function contains no DSI commands, re-adding the
> > flag
> > just after disabling the panel should be safe. Add the code re-
> > adding
> > the flag after the two commands for disabling the panel are sent.
> >=20
> > This fixes screen unblanking (after blanking once) on
> > mt8188-geralt-ciri-sku1 device.
> >=20
> > Cc: stable@vger.kernel.org=C2=A0# 6.11+
> > Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as
> > separate driver")
>=20
> This "Fixes" looks wrong. The bug was still there even before the
> driver was broken out. ...and it looks like the driver that this was
> broken out of (panel-boe-tv101wum-nl6.c) still has the same bug?

Yes, but I think the fix shouldn't be propagated to the other driver
because of the same reason with breaking out the original driver.

I have a device with a panel driven by the nl6 driver (device is
mt8183-kukui-kodama-sku32, panel is boe,tv101wum-n53), it shows the
same DSI timeout error message with ciri sku1, but the screen do come
back to life when unblanking. Maybe this fix should propagate there,
but I need more confirmation.

Thanks,
Icenowy

>=20
> -Doug


