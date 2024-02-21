Return-Path: <stable+bounces-21775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 533BD85CE28
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 03:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C1A1F23A3C
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 02:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0477928370;
	Wed, 21 Feb 2024 02:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="by0Ly4w+"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A77125632
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 02:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483281; cv=none; b=oNybBeAwdIMXkzdoG99bDsx+rvklGWhhaUmlScO50vsVzFjcpeDS+aFrsVAQFfc6lOz0NzLU+bZ/iiMF4rFvt+h0pu0tgL/g+b+MnC/jE6gebntueeSe9TqLlUJ5y+sJ67seV9JdyMxIRPNDJIqJ9tnoz9qirEVz+rDwXLVOrGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483281; c=relaxed/simple;
	bh=yLvENca37koqXHk4DDkN36MXxCa5K53ryrsPH9SnC/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBE/8gEb/QOqdSqCpHtjXOKjbYva5idyheh2JhFqw02sOpTzOqMcY4c7LEgmXQydbeHorMgqS1F+xowvbdmXiSnEIzBBbV+nFdirkTlNhu8dtRGgHh6YM/lc4rwGAAqRYEo2vo6BTemSKAWsYkdqq9+vD1NUn9j8NzJ0Y+A9DrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=by0Ly4w+; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42db1baff53so95021cf.0
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 18:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708483278; x=1709088078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIFksRQNrLKsi4orC6zr7YrZCHRKvKULKcRY+vVqW6k=;
        b=by0Ly4w+55d8tT2uUPVeAvIyth4mfXuh3IMiWsIpA4ciU6ZWuHDyN+AY+Dj/OSdbAz
         TYt4f923UnWaTh/dvx2W4oINnG3YhWrDDkonYTDOhvLfsptPzrDS0ts0UQMOKEF8R9hK
         B9cZZvq/H2VT66VsF4kL/YUiqg90Nu8Ha4JDKuR1Xl1FPMoOHiZQ+INQ3m6L7VgQA9wy
         486B3uXRP/sIBLhg//90jTq2L1w76v/c6LlPJa9JNBv8M89H5eeTUv0GZ2KTPOqpUiGJ
         rD1SDpM31CgyoMP7xbVPOACNJ9/ZUBhhLKYxKh20lMyRBgmjFKHkcdZv8UaC4+FRXnju
         cbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708483278; x=1709088078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIFksRQNrLKsi4orC6zr7YrZCHRKvKULKcRY+vVqW6k=;
        b=OWxywnc3JrBZBtwDRVSsA9dzvrYY7nhOQpZlnHuwebMCn/S9wB3wrCUVPZTnXDKhCZ
         J3FYJfWHAH7fJjfQX6nBSHkmFJZAllIAnqsgOHqygCFQj+EB6PnVjy/R9F8yGygFVvUY
         v8eFhUqeqIK9jXs6n+AURFqxpk52HwzC4PijlRciEBkeatqf25Jb9VCGx9/Wpsx/wS8e
         BlTuYyfvKZwbCWDqzdBJjwqPiiNbJwhgDP2cGvmMd9dbMCK7jnKTRzvzHmUD9G1lY4NN
         eMU7WKiAi5x/h1G2ptewiOVr2/Zsc14U1+rXnlBiI8c4KattRJFPfwPv8sbzuToyr6YV
         O99g==
X-Forwarded-Encrypted: i=1; AJvYcCVVV7KV5HPOWYWQ92hcezzW7ptftJlstwoiKWLKsPXJXM4F6FqdWkPq9+aPgReNs8jVy+8vRuieO8Bj5sI68EXIVO8KI5aZ
X-Gm-Message-State: AOJu0YxxUOIkwH68fh4iphyN3F7AcXFglqun3UTh+0DZAOUh9XcMV6bq
	ZuK44CrqVCdMcv3HxNDk0gJkagKEmmuS0Sao2EhHaPNm0RqubR1JllUmBeH1KEpmeCRVvhUiyqM
	bYrbTZhu+rlxbOWtg7SNEWq/0FtMD0X1y2Ltp
X-Google-Smtp-Source: AGHT+IFOcuDVp/F/WYtSc5/xEn9ksomEmtwYk1VlCy3rZMnYA0KETmu6Zt2Q8sCPoT4/nV09I0zmKNOAzKhBzQM7CoE=
X-Received: by 2002:ac8:744e:0:b0:42e:3233:4924 with SMTP id
 h14-20020ac8744e000000b0042e32334924mr121412qtr.26.1708483278081; Tue, 20 Feb
 2024 18:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220111044.133776-1-herve.codina@bootlin.com> <20240220111044.133776-3-herve.codina@bootlin.com>
In-Reply-To: <20240220111044.133776-3-herve.codina@bootlin.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 20 Feb 2024 18:40:40 -0800
Message-ID: <CAGETcx_xkVJn1NvCmztAv13N-7ZGqZ+KfkFg-Xn__skEBiYtHw@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: property: fw_devlink: Fix links to supplier when
 created from phandles
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 3:10=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> Since commit 1a50d9403fb9 ("treewide: Fix probing of devices in DT
> overlays"), when using device-tree overlays, the FWNODE_FLAG_NOT_DEVICE
> is set on each overlay nodes. This flag is cleared when a struct device
> is actually created for the DT node.
> Also, when a device is created, the device DT node is parsed for known
> phandle and devlinks consumer/supplier links are created between the
> device (consumer) and the devices referenced by phandles (suppliers).
> As these supplier device can have a struct device not already created,
> the FWNODE_FLAG_NOT_DEVICE can be set for suppliers and leads the
> devlink supplier point to the device's parent instead of the device
> itself.
>
> Avoid this situation clearing the supplier FWNODE_FLAG_NOT_DEVICE just
> before the devlink creation if a device is supposed to be created and
> handled later in the process.
>
> Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/of/property.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 641a40cf5cf3..ff5cac477dbe 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1097,6 +1097,7 @@ static void of_link_to_phandle(struct device_node *=
con_np,
>                               struct device_node *sup_np)
>  {
>         struct device_node *tmp_np =3D of_node_get(sup_np);
> +       struct fwnode_handle *sup_fwnode;
>
>         /* Check that sup_np and its ancestors are available. */
>         while (tmp_np) {
> @@ -1113,7 +1114,20 @@ static void of_link_to_phandle(struct device_node =
*con_np,
>                 tmp_np =3D of_get_next_parent(tmp_np);
>         }
>
> -       fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np=
));
> +       /*
> +        * In case of overlays, the fwnode are added with FWNODE_FLAG_NOT=
_DEVICE
> +        * flag set. A node can have a phandle that references an other n=
ode
> +        * added by the overlay.
> +        * Clear the supplier's FWNODE_FLAG_NOT_DEVICE so that fw_devlink=
 links
> +        * to this supplier instead of linking to its parent.
> +        */
> +       sup_fwnode =3D of_fwnode_handle(sup_np);
> +       if (sup_fwnode->flags & FWNODE_FLAG_NOT_DEVICE) {
> +               if (of_property_present(sup_np, "compatible") &&
> +                   of_device_is_available(sup_np))
> +                       sup_fwnode->flags &=3D ~FWNODE_FLAG_NOT_DEVICE;
> +       }
> +       fwnode_link_add(of_fwnode_handle(con_np), sup_fwnode);

Nack.

of_link_to_phandle() doesn't care about any of the fwnode flags. It
just creates links between the consumer and supplier nodes. Don't add
more intelligence into it please. Also, "compatible" doesn't really
guarantee device creation and you can have devices created out of
nodes with no compatible property. I finally managed to get away from
looking for the "compatible" property. So, let's not add back a
dependency on that property please.

Can you please give a real example where you are hitting this? I have
some thoughts on solutions, but I want to understand the issue fully
before I make suggestions.

Thanks,
Saravana

