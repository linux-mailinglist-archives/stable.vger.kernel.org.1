Return-Path: <stable+bounces-144863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00D1ABBFA5
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05157ACB43
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2EB280CE3;
	Mon, 19 May 2025 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="WLR4iUFW"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF928000C
	for <stable@vger.kernel.org>; Mon, 19 May 2025 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662391; cv=none; b=b8y7WuW2U3Y8VVB//T1wWXqglA+6SeCWqgQ+fLtMEp09a73xcbHUk57jpQYSAuJxJ+y7s3G9GN8UpIyYguTrsPB4WpGbgYWNOQjzPk6SodW05d2q+4rqHmUkgFmEsv7jsqHJVVrglPsLm4IlR2CaYH4/ps2Vh45Cv6kZJSesvS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662391; c=relaxed/simple;
	bh=4JHlbJffv+4mNNCLT/9/i5HIt+X1wJcN8eLmEPy9Gks=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=auj7TlnpqJ0TFx2YvFE6PNny/gShvkkKDmZQBnmUQ6Pq2VupBEXht3urB20NE5zhEY2FtgA49Yv6nGPQTWwUtDcNN60E32HAqpf7cuFJ0K3FYEhJ33RTZLX1yrrMxOlhLsg6AV9nHNXPNv+SZczHLIDLFcQcdZ88G3HhXh11uyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=WLR4iUFW; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id E484C1039728C;
	Mon, 19 May 2025 15:38:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747661904; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=N1/hqvFMciSOi5HeuuAMzlViYvSbLPpgL4twkOL0a78=;
	b=WLR4iUFWsTi766GhQbhQhzgpwoTr3SxUab5Ow2+9dP6uGLIz4weFFu/FrMsSUdR6YLraDv
	9KkMLWR+Oly+3Xe1tnZvvDAgtUJCh+bUVGoTowg3fLQVMvnU40rY+++cPYHhnCy9gJBqbZ
	52juUvSRC0wwNsdFkgYUNJW3qNoj0lEFgBnt77aPEY5PKZEK3UBcnwr+Iof1cVI649mt7j
	mgFQzteQxVLK/s07+4NdvQrGLithRF5SrrgZ90o5tywAkNfnQu4wT5/9InxUDdGCltKUmJ
	J85IGhZCvoJlhaFBPeD0buTmtZrGHFK+DDHtijQlwyf2mwHYShLSzM7yeRJomA==
From: "Fabio Estevam" <festevam@denx.de>
In-Reply-To: <2025051936-qualify-waged-4677@gregkh>
Content-Type: text/plain; charset="utf-8"
References: <2025051936-qualify-waged-4677@gregkh>
Date: Mon, 19 May 2025 15:38:23 +0200
Cc: javierm@redhat.com, tzimmermann@suse.de, stable@vger.kernel.org, festevam@gmail.com
To: gregkh@linuxfoundation.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <136-682b3480-1-3097af80@2841359>
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_FAILED=3A?= patch =?utf-8?q?=22[PATCH]?=
 =?utf-8?q?_drm/tiny=3A?==?utf-8?q?_panel-mipi-dbi=3A?= Use 
 =?utf-8?q?drm=5Fclient=5Fsetup=5Fwith=5Ffourcc()=22?= failed to apply to 
 =?utf-8?q?6=2E12-stable?= tree
User-Agent: SOGoMail 5.12.0
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hi Greg and Thomas,

On Monday, May 19, 2025 09:00 -03, <gregkh@linuxfoundation.org> wrote:

>=20
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git comm=
it
> id to <stable@vger.kernel.org>.
>=20
> To reproduce the conflict and resubmit, you may use the following com=
mands:
>=20
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x.git/ linux-6.12.y
> git checkout FETCH=5FHEAD
> git cherry-pick -x 9c1798259b9420f38f1fa1b83e3d864c3eb1a83e
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051=
936-qualify-waged-4677@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Locally,  I am running 6.12 with these two extra dependencies applied:

commit 8998eedda2539d2528cfebdc7c17eed0ad35b714
Author: Thomas Zimmermann <tzimmermann@suse.de>
Date:   Tue Sep 24 09:12:03 2024 +0200

    drm/fbdev-dma: Support struct drm=5Fdriver.fbdev=5Fprobe
   =20
    Rework fbdev probing to support fbdev=5Fprobe in struct drm=5Fdrive=
r
    and reimplement the old fb=5Fprobe callback on top of it. Provide a=
n
    initializer macro for struct drm=5Fdriver that sets the callback
    according to the kernel configuration.
   =20
    This change allows the common fbdev client to run on top of DMA-
    based DRM drivers.
   =20
    Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
    Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
    Link: https://patchwork.freedesktop.org/patch/msgid/20240924071734.=
98201-6-tzimmermann@suse.de


commit 1b0caa5f5ac20bcaf82fc89a5c849b21ce3bfdf6
Author: Thomas Zimmermann <tzimmermann@suse.de>
Date:   Tue Sep 24 09:12:29 2024 +0200

    drm/panel-mipi-dbi: Run DRM default client setup
   =20
    Call drm=5Fclient=5Fsetup() to run the kernel's default client setu=
p
    for DRM. Set fbdev=5Fprobe in struct drm=5Fdriver, so that the clie=
nt
    setup can start the common fbdev client.
   =20
    v5:
    - select DRM=5FCLIENT=5FSELECTION
   =20
    Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
    Cc: "Noralf Tr=C3=B8nnes" <noralf@tronnes.org>
    Acked-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
    Link: https://patchwork.freedesktop.org/patch/msgid/20240924071734.=
98201-32-tzimmermann@suse.de

I have only tested panel-mipi-dbi (the only display available on the bo=
ard I use). I am unsure if applying these extra patches to linux-6.12 s=
table is safe or if they could cause issues with other fbdev drivers.

Regards,

Fabio Estevam


