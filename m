Return-Path: <stable+bounces-21770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 507E385CCEA
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 01:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E651F23040
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 00:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D596F1876;
	Wed, 21 Feb 2024 00:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yojhpeu0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4CB468F
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 00:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476493; cv=none; b=sCneBoTXI3d2qH+U/duM70TLDRHbtra5C3UUlbRMlx/LyLB4CuZ/M83IeT//I6Z1LEr4kkHtGBTnS+GRdh1NBXkiCi+lo4qRX8pKku6Eq+O3DRPjKI4if/39rV4RCqns3ENmr0DY2jOAiqw3R8ML6eRLrJuDb1AeSQEtOYMLsSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476493; c=relaxed/simple;
	bh=TAyHqIh7nSfAdd9tVNUMVeUz7n0RsJ5mQARd3J5Z7o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpFrFUc8jtE+5WjzLCBobFXRa5XUanlhdLacgS5oscgAed7A6kxTZOWyHCiHJmYxLRqgnzWAj9TvV4fshjuiq5L0pSMigAHp9VvH98Q9bFA/C3AzU0j1a3Pcw/8WovabN2V6/1dSlv/U6Tp20Zu7meRcwjuVDail4PL/AUManms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yojhpeu0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dbe7e51f91so38525ad.1
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 16:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708476491; x=1709081291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ugbs7Jg6VHvaoDcjZWVoK1eM0qfrHvcJKgPX5ZJOhD4=;
        b=yojhpeu0pFuyYppauTLZdFtb8sig8N2k9kllzwMQEgYr8+tYpqK0w1f4mZSbmadL6J
         fSsYu2DF3duD39sfN3pWRn3QEuxpJN5mx6M8pFHmm4iCnzfCqoOibeZDBsdlsAJ21daF
         RBGvrF8EwmcDQH3/8Mi+IXjuWZ8W3W3Ld/CPa5V6Ge5FxUuV9MjS12HOl8mVlmiHKbRE
         7TvEzm+DBFazxRgoAnDa03eHXfEU0mhYE6jKxa/GIanmNYxWwVdD3oGj8s8wKj3lsE0d
         z0zrUFM1GIdNjWz3M1lDWaCkGjobIxf2emMFFK7seedyfhTw/SIMdAOOOPrdswXxNlDa
         vl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476491; x=1709081291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ugbs7Jg6VHvaoDcjZWVoK1eM0qfrHvcJKgPX5ZJOhD4=;
        b=aA8mZp2jFvrAaVVs9mnQA6vOpk7T5eYF+K25JZ3riGQRDwY6OzkpBqGd1cn192xZ7U
         XC93+ZoYGhAL2x5YhRJuvLbHAEnNFv0GDeazHX8iAGcmYo/tTdkKzdrLhzalHMuao5EY
         gSPG7wpZPUCKuaqXAOKkpbgAO6gNgz8qIpJxqf+dMsE67KxEWeaCCAD8kISLCw0Q0Se0
         dkp4zbeF2g2b7Usfrgsx4jc9W8W34OM+8evqbLdX/TNteQMySFZair4c7w81hpbklyot
         3uOAnj/n6ORbnsjMR8MPCcB9t2CGnWEqrJ/OQa8h2vWh5rsAKctDIFLTevZQ4sTi0IeX
         QtDw==
X-Forwarded-Encrypted: i=1; AJvYcCXZGFWojAKsUEnvT3FhBYQv2HqVgbj9g3ngi+VggX4ls0mWYY4hxm0FRuiu0jiGk6y6lR9TE9Lp+z7LPknFADwOwOzicT4y
X-Gm-Message-State: AOJu0YzLYdMj03gc4Wox2vEtsyXde3ezrZzCLYY1K4RF2RDbnwacyoDn
	WEltuwMfn1bm/1LN5gdciLnybIjgH7hr2y4I3ZSxGkTtgGtZAREapyVgqGON2ECPmmEhpReqTVN
	Im0estxvi0X6nApWxyBSz5zKMwvAS6w//xPId
X-Google-Smtp-Source: AGHT+IGmomN+J320UJO3BPdb9kM8qujnyRAtdlS/NC9QqErQiwpvTPMbYWYYmX0JdfQqBKahJXCssDuKBj64fFUkwww=
X-Received: by 2002:a17:902:7207:b0:1db:de7a:9122 with SMTP id
 ba7-20020a170902720700b001dbde7a9122mr104606plb.4.1708476491323; Tue, 20 Feb
 2024 16:48:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207011803.2637531-1-saravanak@google.com> <20240207011803.2637531-4-saravanak@google.com>
In-Reply-To: <20240207011803.2637531-4-saravanak@google.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 20 Feb 2024 16:47:35 -0800
Message-ID: <CAGETcx9eiLvRU6XXsyWWcm+eu+5-m2fQgkcs2t1Dq1vXQ1q7CQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] of: property: Add in-ports/out-ports support to of_graph_get_port_parent()
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>, 
	stable <stable@vger.kernel.org>
Cc: Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 5:18=E2=80=AFPM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> Similar to the existing "ports" node name, coresight device tree bindings
> have added "in-ports" and "out-ports" as standard node names for a
> collection of ports.
>
> Add support for these name to of_graph_get_port_parent() so that
> remote-endpoint parsing can find the correct parent node for these
> coresight ports too.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Greg,

I saw that you pulled the previous 2 patches in this series to 6.1,
6.6 and 6.7 kernel branches. I really should have added both of those
Fixes tag to this patch too.

Can you please pull in the patch to those stable branches too?

Thanks,
Saravana

> ---
>  drivers/of/property.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 7bb2d8e290de..39a3ee1dfb58 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -763,7 +763,9 @@ struct device_node *of_graph_get_port_parent(struct d=
evice_node *node)
>         /* Walk 3 levels up only if there is 'ports' node. */
>         for (depth =3D 3; depth && node; depth--) {
>                 node =3D of_get_next_parent(node);
> -               if (depth =3D=3D 2 && !of_node_name_eq(node, "ports"))
> +               if (depth =3D=3D 2 && !of_node_name_eq(node, "ports") &&
> +                   !of_node_name_eq(node, "in-ports") &&
> +                   !of_node_name_eq(node, "out-ports"))
>                         break;
>         }
>         return node;
> --
> 2.43.0.594.gd9cf4e227d-goog
>

