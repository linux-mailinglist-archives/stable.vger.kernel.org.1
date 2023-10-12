Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37E87C77E5
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 22:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344046AbjJLU2d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 16:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344157AbjJLU2c (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 16:28:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2587C9D
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 13:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697142469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h7MhDUaGiq9G+tWNP9KfebmzehEOtMMS/KoW8Kay4rM=;
        b=QNbsvZ8MWUywCkgbVC/z3FIIRIcdufibpNRS4hicmzY91FFgp2Xr5O1TKadN89wiKRltSO
        xgMX/FkU1659ZJxSv5ByDlq3AIS+nbb9scUKXOilRIQWo7ycPa101pBc4TWc7TdYkSuRyv
        qKhspXcusTVDgwV3Pc/xnGgRwy4g0Co=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-MvExrK4jMC-hUMayM5mcNQ-1; Thu, 12 Oct 2023 16:27:48 -0400
X-MC-Unique: MvExrK4jMC-hUMayM5mcNQ-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-d86766bba9fso1800857276.1
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 13:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697142467; x=1697747267;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7MhDUaGiq9G+tWNP9KfebmzehEOtMMS/KoW8Kay4rM=;
        b=aWUFL4e+K9/FuVBkSOOiPKRY/POCcBGqxopiQWBPgLFEJ/01QjBZkdU1xLyWpBf5O/
         Zla4KSuKbK1xk7j0wmr9cYScT+dAFiAGvhpW5qfDnEn9xU/+JPehBA/vossFdg5Na/xF
         vpuytLTdaQsZiPkU9/gbgnomxqZi/jJumV4MRFMxVutvjRQqHzqhNxPnc6j+fyq4rsnQ
         lROvCYq/+NMNrggoqIDUcY/qv6o9+Gs5fb/XXa3HzlzSNldEujzhRElNKA1uWoHFzy96
         Np5kSXz9Sn5Q7zNRP+s67pd4NsBsKEOmE1I+sG5c1WshkB7x1KZO7GQXXH8Yh6gerQhP
         +AMA==
X-Gm-Message-State: AOJu0Yz3moD1XB/KBaeIxu44idhyMUF5h4Gpt9Gz5nN4v5nvM+SLZV8Z
        FGIhqJ05nfWHdgVo92c2xpg8DEBAK1Zz2m5rR71Cltu2gewYK9p7tXWbgSX/IYmmUUoPbwpBnbG
        h2M8q+r6ca32I+JDo
X-Received: by 2002:a25:2109:0:b0:d90:a7a4:7093 with SMTP id h9-20020a252109000000b00d90a7a47093mr22970359ybh.55.1697142466873;
        Thu, 12 Oct 2023 13:27:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVZ5AlehRoD4uy/fEcf9fxDTMrdIb0t8hzbkAHLfVUYwOfQMOlVAmfNUNBfHCGsp/kHBKgMA==
X-Received: by 2002:a25:2109:0:b0:d90:a7a4:7093 with SMTP id h9-20020a252109000000b00d90a7a47093mr22970345ybh.55.1697142466567;
        Thu, 12 Oct 2023 13:27:46 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id dl15-20020ad44e0f000000b0066d1540f9ecsm69669qvb.77.2023.10.12.13.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:27:45 -0700 (PDT)
Message-ID: <bd20306461d67f1c6aaadb3fe6a3d596fc70e13e.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/disp: fix DP capable DSM connectors
From:   Lyude Paul <lyude@redhat.com>
To:     Karol Herbst <kherbst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        stable@vger.kernel.org
Date:   Thu, 12 Oct 2023 16:27:38 -0400
In-Reply-To: <20231011114134.861818-1-kherbst@redhat.com>
References: <20231011114134.861818-1-kherbst@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2023-10-11 at 13:41 +0200, Karol Herbst wrote:
> Just special case DP DSM connectors until we properly figure out how to
> deal with this.
>=20
> This resolves user regressions on GPUs with such connectors without
> reverting the original fix.
>=20
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org # 6.4+
> Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/255
> Fixes: 2b5d1c29f6c4 ("drm/nouveau/disp: PIOR DP uses GPIO for HPD, not PM=
GR AUX interrupts")
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c b/drivers/g=
pu/drm/nouveau/nvkm/engine/disp/uconn.c
> index 46b057fe1412e..3249e5c1c8930 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c
> @@ -62,6 +62,18 @@ nvkm_uconn_uevent_gpio(struct nvkm_object *object, u64=
 token, u32 bits)
>  	return object->client->event(token, &args, sizeof(args.v0));
>  }
> =20
> +static bool
> +nvkm_connector_is_dp_dms(u8 type)
> +{
> +	switch (type) {
> +	case DCB_CONNECTOR_DMS59_DP0:
> +	case DCB_CONNECTOR_DMS59_DP1:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static int
>  nvkm_uconn_uevent(struct nvkm_object *object, void *argv, u32 argc, stru=
ct nvkm_uevent *uevent)
>  {
> @@ -101,7 +113,7 @@ nvkm_uconn_uevent(struct nvkm_object *object, void *a=
rgv, u32 argc, struct nvkm_
>  	if (args->v0.types & NVIF_CONN_EVENT_V0_UNPLUG) bits |=3D NVKM_GPIO_LO;
>  	if (args->v0.types & NVIF_CONN_EVENT_V0_IRQ) {
>  		/* TODO: support DP IRQ on ANX9805 and remove this hack. */
> -		if (!outp->info.location)
> +		if (!outp->info.location && !nvkm_connector_is_dp_dms(conn->info.type)=
)
>  			return -EINVAL;
>  	}
> =20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

