Return-Path: <stable+bounces-98880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 524109E61BD
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EEB0164F12
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8B5819;
	Fri,  6 Dec 2024 00:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="srGA819H"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28D510E0
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 00:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443705; cv=none; b=X1vMmON0l/UIOsAV7I2lthy+cMF+y882CuSLChNoTBZLKmboMAsTNsIWkGyEbxEyjG5dAnB1rkuffwlceRg5xFZc+Dk/DEa9xKW3vKTtjau9eirTMpFLoxaGmmpf7m+dWtqShcKpvXZyV1qzitqID9TO53in4eG8ZdPCTHDsHvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443705; c=relaxed/simple;
	bh=wFPdTgfOGWkAoy97xgGZ2d/4NUke3YVxo76cMUT9rOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mibl0KK4ENX92k8Vl8qVSQ+50vEXtFsw7dMKPtFl4piTQWoh1dO1zLmAWAWQ0VF3FFG1t38e5f1pj0rlQ/xkv1GLnMPR4IcTU3XdRvgOCS5zmOogpJsYL8IwNCmaMegWBB1rvnZi6TzdZVCwI8FbePcE9lIVNbmatj0s/H5OrG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=srGA819H; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53e29c00ff2so540980e87.2
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 16:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443702; x=1734048502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyWqX2zoZLFRt3ry2g2R9lR3izotXfaeTSy8KYkYq3A=;
        b=srGA819HN7daNwFw0P3ts+YefkxcY825IpcrPQj7GRZZh7WXCvO0DAvp1w0mtDqv9y
         cNJCfSrSp55zxhmmIvgewpSkurpRQCB70TCi+a2LSHNpd8/uame75Kc1qDkOh4rIBLsf
         iLAALvllWUUF7/jW16+452IrjnGfB5AeepkIeGHACMNrjoS+3Sh53u1SDE6tuHuUgZHT
         MEZHT0OupOIqwDQacjqo0GoeSS5wbxplxiCNNrNPRLqFeKRmYk1v6W2qZBqTPdVbgTL6
         svcncYbb+0Wdylmj/XZKhZ9rNWRdNT9JonHztaUvKx385GoKJe5jXdjXc2aTMPUMcXJx
         BvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443702; x=1734048502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyWqX2zoZLFRt3ry2g2R9lR3izotXfaeTSy8KYkYq3A=;
        b=IVUInbxNyUeIfmM3JHT5C94BUVGPqyreyH85sVK3cT1RySgXZ8BmPMIk5p6EkVVJ7U
         //Nd4oZouyT4t+aUbVAhQvey+ulZuHBjFr9OKfhAVta6AjPIGyqHnAUs2GzET06hIHpS
         oaviB8kcQhdLFHMLgsLAwYOcQ4MqIC32XQDUSsT4kIFyX15C9xH2kwNeWNDyWVlVjRTR
         ujrhPSs7vJy6gDF92FkZfv9ggrqjrsu9eeR99k9eJ9lKaKaaP+ywy0Dn90SX2i+tKlKD
         IxZVMRoi1ntSEChZR7snp7/nWO4fkXbAX88hpiHaFAXemxlInQxkDNzgdB3u4LxAzytD
         neVg==
X-Forwarded-Encrypted: i=1; AJvYcCXGHReuESWRYFgHgV5g2C1y48tuAjyUzhFCTMoXQ9/GCLmxEiEFpoyl0aZDOcCzxZl9nyt1eIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzaszhlDwDrJ3O1bHNe0HnK5Cnx/dmTdxvFYykduRrVknakL9E
	Oaa2xj29ugagAZT7/0eiCdTijIyry1Bxu9EhlSym45uBGK0YFf+nn47MDbDv0VZl3IDQSSVuQt1
	A9w7pqau40sOWUu1HSAVg0COIM6tthPzicuxBOnUQzgFqz3lv8A==
X-Gm-Gg: ASbGnctcQTsN34cASC9rQW5VkhJG9y8uBosW35vvjQEhoqTQYOZWRb/Mdq1d9oK+oeQ
	2WuEA1TvhFTXqxxkQ16xBqSx8ZpDx0g==
X-Google-Smtp-Source: AGHT+IEl7P8g4C6biT8pMmR7TEmB0gJQnY7JWx1axpsFaCZBcd/5qdwTwlQeic62GJWu2sWz95sDRQrA+1CjugfgIXQ=
X-Received: by 2002:a05:6512:3993:b0:53d:ed68:3cfa with SMTP id
 2adb3069b0e04-53e2c504c30mr241237e87.55.1733443701768; Thu, 05 Dec 2024
 16:08:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204221726.2247988-1-sashal@kernel.org> <20241204221726.2247988-8-sashal@kernel.org>
 <CAGETcx8bhzGZKge4qfpNR8FaTWqbo0-5J9c7whc3pn-RECJs3Q@mail.gmail.com>
In-Reply-To: <CAGETcx8bhzGZKge4qfpNR8FaTWqbo0-5J9c7whc3pn-RECJs3Q@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 16:07:45 -0800
Message-ID: <CAGETcx-6yHV5xr1j7krY8LShCF5JATX0NSwjeRUL9+3TLCMq9w@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.11 08/15] drm: display: Set fwnode for aux bus devices
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Thierry Reding <treding@nvidia.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	matthias.bgg@gmail.com, elder@kernel.org, ricardo@marliere.net, 
	sumit.garg@linaro.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 4:06=E2=80=AFPM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> On Wed, Dec 4, 2024 at 3:29=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
> >
> > From: Saravana Kannan <saravanak@google.com>
> >
> > [ Upstream commit fe2e59aa5d7077c5c564d55b7e2997e83710c314 ]
> >
> > fwnode needs to be set for a device for fw_devlink to be able to
> > track/enforce its dependencies correctly. Without this, you'll see erro=
r
> > messages like this when the supplier has probed and tries to make sure
> > all its fwnode consumers are linked to it using device links:
> >
> > mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) w=
ith backlight-lcd0
> >
> > Reported-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > Closes: https://lore.kernel.org/all/7b995947-4540-4b17-872e-e107adca459=
8@notapiano/
> > Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Reviewed-by: Thierry Reding <treding@nvidia.com>
> > Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> > Link: https://lore.kernel.org/r/20241024061347.1771063-2-saravanak@goog=
le.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> As mentioned in the original cover letter:
>
> PSA: Do not pull any of these patches into stable kernels. fw_devlink
> had a lot of changes that landed in the last year. It's hard to ensure
> cherry-picks have picked up all the dependencies correctly. If any of
> these really need to get cherry-picked into stable kernels, cc me and
> wait for my explicit Ack.
>
> Is there a pressing need for this in 4.19?

I copy pasted this into several replies. In all those cases I meant
the kernel version mentioned in the subject.

-Saravana

>
> -Saravana
>
> > ---
> >  drivers/gpu/drm/display/drm_dp_aux_bus.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c b/drivers/gpu/drm=
/display/drm_dp_aux_bus.c
> > index d810529ebfb6e..ec7eac6b595f7 100644
> > --- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
> > +++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
> > @@ -292,7 +292,7 @@ int of_dp_aux_populate_bus(struct drm_dp_aux *aux,
> >         aux_ep->dev.parent =3D aux->dev;
> >         aux_ep->dev.bus =3D &dp_aux_bus_type;
> >         aux_ep->dev.type =3D &dp_aux_device_type_type;
> > -       aux_ep->dev.of_node =3D of_node_get(np);
> > +       device_set_node(&aux_ep->dev, of_fwnode_handle(of_node_get(np))=
);
> >         dev_set_name(&aux_ep->dev, "aux-%s", dev_name(aux->dev));
> >
> >         ret =3D device_register(&aux_ep->dev);
> > --
> > 2.43.0
> >

