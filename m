Return-Path: <stable+bounces-242058-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCmKOmsb82kLxQEAu9opvQ
	(envelope-from <stable+bounces-242058-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:05:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C58849F993
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E48630086D0
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A621C2609DC;
	Thu, 30 Apr 2026 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UxvRzmOD"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80915853B;
	Thu, 30 Apr 2026 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777539941; cv=none; b=RvrD+g2R5g3RxY6p9jpftIcYtvwylDBrxKYrsz71w7HvYCNnMMgf3p8vK8GOm0ymKCa8dOYDIM/J9L0QhzFcNEsv94p9LwKG18TYkeNSRyJ7/2RwaamrdNxHvxghKVPrsBx8N3Cj5meaOe5XtzorZgBdkWBg5QMqFKWuIX7zv1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777539941; c=relaxed/simple;
	bh=PD/RBvG0tika4WQOlK7lbn7RBjWTyLutXnF4l1j9Jzo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=tec2hIqre5Q75H3LI057m83PrcodPU4MBHQocSCBpK51YqytAAeqXrtGpIjtKReyCoTG8oPJL/rac3vRTc2/hcZCa9qITscTIEak308rvicHvLy2BE7APy0rk6LMD7cKe872k8lH/krgst0wxmHWTD+401jK37fGBQd0x/5kYwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UxvRzmOD; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BA943C5EF3A;
	Thu, 30 Apr 2026 09:06:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3BF9660495;
	Thu, 30 Apr 2026 09:05:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95AA710729FBD;
	Thu, 30 Apr 2026 11:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777539936; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PD/RBvG0tika4WQOlK7lbn7RBjWTyLutXnF4l1j9Jzo=;
	b=UxvRzmODfHMo12B0XNI9V/YNYvaJ2APi/IS+VypBrK1o2YYm6ZFeM+ylGBSh9PuYRtwJCZ
	XrTcbdErN1ec2QNmnQ+Ww2PtqdkwpY+aJFeUv5wow8sTV8Y4m2K0S1NWZHHx8JR+YXYrZ9
	UCkKQbdIwmb4s8C5GU5Pg8gG5kaokfPZC55i9wcQ8auyGaOeRnEQJH4TM9k3+DAFwW1tMx
	WnZws7T+iby3lYJW0KytEiR4mntj7K1ykbSZwMRcxOYYbUr4Ii/gTTt2/bI20e1s4X7FMd
	p0Jw/kjLJ5crw829mIECy5orWM+17rThwhC6jOsG2fvG8dRJb/boLa/fvQvKww==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 11:05:30 +0200
Message-Id: <DI6DBEZ98XQD.53GKJABIWR3G@bootlin.com>
To: "Vitor Soares" <ivitro@gmail.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v4] drm/bridge: cdns-dsi: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
Cc: "Vitor Soares" <vitor.soares@toradex.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>
X-Mailer: aerc 0.20.1
References: <20260407144142.1420354-2-ivitro@gmail.com>
 <DI6C5A83IG4B.1UV6WJMFQ9AA7@bootlin.com>
 <19d0a0b1d33061a0421edf883acaaa7e366646c2.camel@gmail.com>
In-Reply-To: <19d0a0b1d33061a0421edf883acaaa7e366646c2.camel@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 3C58849F993
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242058-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,linux.intel.com,suse.de,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,bootlin.com:dkim,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello Vitor,

On Thu Apr 30, 2026 at 10:52 AM CEST, Vitor Soares wrote:

>> > -static UNIVERSAL_DEV_PM_OPS(cdns_dsi_pm_ops, cdns_dsi_suspend,
>> > cdns_dsi_resume,
>> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 NULL);
>> > +static const struct dev_pm_ops cdns_dsi_pm_ops =3D {
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0RUNTIME_PM_OPS(cdns_dsi_sus=
pend, cdns_dsi_resume, NULL)
>> > +};
>>
>> Not an expert here, but the docs [0] suggest using
>> DEFINE_RUNTIME_DEV_PM_OPS(). Is there a good reason to not do so?
>>
>> [0]
>> https://elixir.bootlin.com/linux/v7.0.1/source/include/linux/pm.h#L455-L=
456
>>
>> Luca
>>
>
> In an earlier discussion [0], we concluded that bridges/panels should onl=
y deal
> with runtime PM:

Ah, good. Then please mention this in the commit message in v5. It can help
others doing the right thing in future similar cases.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

