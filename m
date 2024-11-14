Return-Path: <stable+bounces-92975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95469C832D
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 07:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F831281070
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 06:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318C21E9061;
	Thu, 14 Nov 2024 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="Lf9RBAaB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.129.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1019A1632D9
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731565812; cv=none; b=Pop06CcW0X4bJIrkgd4D8o22GHiQrvFxIEQ+tjT9xFjs33AK4V5WscqJFlS0bGp53ON32Nd9VzCZpnrIrgLB0pvqR728MLkjpe0orkB22xM97rbqwpPy4Zr3h0XGP424chEHV6kkHYeSPP1Ga5Hg2CiCa/xWu56WYWlhSR2Zqng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731565812; c=relaxed/simple;
	bh=CsRf5xskqnnwINpwcylW+VBcW/qhSStwtZpmpiu+k+c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GhIFa/t/a/V95bjk17kLIVo2iarSfN4kK23N06mwUEnMGzw7bDWNB/VdYuB6Fvt7H2LFpjQRUCxfOrkHCMjbxMc5Um3W/FOn/iok3DBvsEiGrQLpinOy4IANiqInY1QcLNig1jjfmK4TaQWdDlUjUwtTM8lRY6A9s/2PDMlxOuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=Lf9RBAaB; arc=none smtp.client-ip=170.10.129.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1731565808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CsRf5xskqnnwINpwcylW+VBcW/qhSStwtZpmpiu+k+c=;
	b=Lf9RBAaBjFnfNc9GlNQ20/QjNb1la/0rRQhsa+DOcIYeOZIu1q5TGI0UNVAgOZdDP+1W5G
	Gm8esNsxVgVkNrzaAPmJ1Ddw+NEEl+SwcAXZhqosZW13QoF3bZAftTM3mc+Z8okzbGKfzo
	bErh8LKNpjQ3rSc4OFF4DzlPgYa+qwg=
Received: from g8t13016g.inc.hp.com (hpifallback.mail.core.hp.com
 [15.72.64.134]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-6rns3xBqMvuRn99G25z-8A-1; Thu, 14 Nov 2024 01:30:05 -0500
X-MC-Unique: 6rns3xBqMvuRn99G25z-8A-1
X-Mimecast-MFC-AGG-ID: 6rns3xBqMvuRn99G25z-8A
Received: from g8t13021g.inc.hpicorp.net (g8t13021g.inc.hpicorp.net [15.60.27.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by g8t13016g.inc.hp.com (Postfix) with ESMTPS id 905DC6000FD4;
	Thu, 14 Nov 2024 06:30:02 +0000 (UTC)
Received: from mail.hp.com (unknown [15.32.134.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by g8t13021g.inc.hpicorp.net (Postfix) with ESMTPS id 334F5600075A;
	Thu, 14 Nov 2024 06:26:14 +0000 (UTC)
Received: from cdc-linux-buildsrv17.. (localhost [127.0.0.1])
	by mail.hp.com (Postfix) with ESMTP id 6FE7CA4159F;
	Thu, 14 Nov 2024 14:15:59 +0800 (CST)
From: Wade Wang <wade.wang@hp.com>
To: perex@perex.cz,
	tiwai@suse.com,
	kl@kl.wtf,
	linuxhid@cosmicgizmosystems.com,
	wangdicheng@kylinos.cn,
	k.kosik@outlook.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	wade.wang@hp.com
Subject: [PATCH] ALSA: usb-audio: Fix control names for Plantronics/Poly Headsets
Date: Thu, 14 Nov 2024 14:15:53 +0800
Message-Id: <20241114061553.1699264-1-wade.wang@hp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1eugkbEqmUW75wHDTPOUL_NVT_aji2PXBJGWX6p4kpM_1731565804
X-Mimecast-Originator: hp.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true

Add a control name fixer for all headsets with VID 0x047F.

Signed-off-by: Terry Junge <linuxhid@cosmicgizmosystems.com>
Signed-off-by: Wade Wang <wade.wang@hp.com>
---
 sound/usb/mixer.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index bd67027c7677..110d43ace4d8 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1664,6 +1664,33 @@ static void check_no_speaker_on_headset(struct snd_k=
control *kctl,
 =09snd_ctl_rename(card, kctl, "Headphone");
 }
=20
+static void fix_plt_control_name(struct snd_kcontrol *kctl)
+{
+=09static const char * const names_to_remove[] =3D {
+=09=09"Earphone",
+=09=09"Microphone",
+=09=09"Receive",
+=09=09"Transmit",
+=09=09NULL
+=09};
+=09const char * const *n2r;
+=09char *dst, *src;
+=09size_t len;
+
+=09for (n2r =3D names_to_remove; *n2r; ++n2r) {
+=09=09dst =3D strstr(kctl->id.name, *n2r);
+=09=09if (dst !=3D NULL) {
+=09=09=09src =3D dst + strlen(*n2r);
+=09=09=09len =3D strlen(src) + 1;
+=09=09=09if ((char *)kctl->id.name !=3D dst && *(dst - 1) =3D=3D ' ')
+=09=09=09=09--dst;
+=09=09=09memmove(dst, src, len);
+=09=09}
+=09}
+=09if (kctl->id.name[0] =3D=3D '\0')
+=09=09strscpy(kctl->id.name, "Headset", SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+}
+
 static const struct usb_feature_control_info *get_feature_control_info(int=
 control)
 {
 =09int i;
@@ -1780,6 +1807,9 @@ static void __build_feature_ctl(struct usb_mixer_inte=
rface *mixer,
 =09=09if (!mapped_name)
 =09=09=09check_no_speaker_on_headset(kctl, mixer->chip->card);
=20
+=09=09if (USB_ID_VENDOR(mixer->chip->usb_id) =3D=3D 0x047f)
+=09=09=09fix_plt_control_name(kctl);
+
 =09=09/*
 =09=09 * determine the stream direction:
 =09=09 * if the connected output is USB stream, then it's likely a
--=20
2.43.0


