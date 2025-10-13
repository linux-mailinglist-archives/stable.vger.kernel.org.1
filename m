Return-Path: <stable+bounces-185483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6434BD57C2
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 19:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7830F4E2CF7
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8C1302759;
	Mon, 13 Oct 2025 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="all1xLsw"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E0427055F
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760376339; cv=none; b=J6Gd++i2XjbLbqYs948IjRcsWVqUV6GfEEquC1RWqUjg7uRhQttXGycW9UfOQuHk0jvev2BGMQsvF+F0pIeGXWeq0XyLreD9+ZZm96xxjmYtgMcRnCkJIj1G6Xvph3NZuzG/A39CIIskTZCzNnoAddhM0YGUJP4LK/1aslEj7Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760376339; c=relaxed/simple;
	bh=ZEA6rYeR4lkZSXHd7mmsLSm511INpr8RKZX37WK0S8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4ejplU5Uuy/hGPjGfUdrIZ3M2awb3DpdRf/JkFI6vNf1wYZwgWAW3VW6JD3DH5MZ3VCjNueDA7hjOX6yfM2LsvwE+pbzq6BJ6C6YK3PxGCwXBBwM/DQdMdHmisQpQ0tYY0ZG/Behliper1Rtfuf8sCaQbAhYTSWr0AOgbSeoHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=all1xLsw; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3652d7800a8so32996231fa.0
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 10:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760376335; x=1760981135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRwYTXjoxqZ2EJL/erceADAy/EsJNIvDopSca1hjqQw=;
        b=all1xLswa1n0JODPBjj7pDEOOa9cjSdZ2MZHWQz9FC1XFanHzMZZhZOKus59dvFPFu
         3+DBLomsAe4/Ho+bL0T+7NX5dl49OXxJm24y8JwFnjFpAIATmKi22MvmbeHQPLymkddw
         zbjNptrrg/vnphghCBwV2Kr2o8y3752/H1CJme6BZbnS36kB5h7iLGt0WhdPDG9FMXPE
         pTE+HrL3Q3cGqZ6vC1yv3dYUdtDqt8qqb1T08osSITpzFebb+ZnfxytUtDIDbka0JrRM
         1Af3yTeV/kdmqzwxpMHXobSAxLQjH7bQmrUXjpR169YDDfjlNoiaguoxQ4ZNj0yjhUP9
         vtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760376335; x=1760981135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRwYTXjoxqZ2EJL/erceADAy/EsJNIvDopSca1hjqQw=;
        b=snw6LPYdh+0ogjqiOfy1vePKarNUlEpUpiYhVCii56VRALANb0M8CoxGKt5JXogxBB
         UJVSJyYbwva+IPzul6doYxBlZKE0qf9hGyZfUPZUI1gIsVkx7t0JR4fciVQ9qQJLz5S9
         TMKsP7ooiE9gQKbd/gBAaUBpQj5F3puvBgxmXWP52Eo2+FvcVufYGzQqtTpFcXYfKrKl
         aIOKh/epDqnkw0wAxcTA1WRDn0JlzZ8UCKfhtkLY6EximiSX6kRZIRjUBgypaY5XR/u1
         lnI5QQ3S6pas5yMByMvsTwe88wvkdf34c/Yy4Nu9IL4izfLAinFUKBHVc1JyNuMRanJ/
         T22A==
X-Forwarded-Encrypted: i=1; AJvYcCUCfFN9aRs5ygZAHDCRFFo9AnrayeRGtT321DNcDdWZRVcyFve1qdJbpqrqaarbtkFW5Aj7uww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTklVTUFukPuctpjwGwcHy5wp88IVoW3aJWHezIZXCXbadN+Bx
	mmYLV2lVTde1jv4TMHtyu7KYlkG5skQ+4Z1ccycdg28JcOXO0gQwrG6eIbmHgGZ/4fa3LgzaxGd
	QQhy7kxAYd0bzP77JVVXbnhKSgOzMHrrqV2m8h/HQ
X-Gm-Gg: ASbGncuWo6J4909+W6gpi4cpA1NUS3U4D2MrVuFU2mdnIRzRyShWs5q+zUGK3uu8//v
	A1+em9HtoakUk6aN6jqT1abujEUmVWy6dgJb6b0vazHyMvyEkpKziElJHMWLccUbPgYwDrZF/9Z
	sHka3hOFAMTqzj8uiYJQCtX32I9qPWb/tmDbuKw4uulG0bRVU4NKN8FQt688opbiuqB8PQO3Slq
	Q5eon7+uzAJCcALc9Nyh7MEREpA8JcwZf5mfSrOfxMLO32o6/6lvcLpnekqxwmtnD2on+uDpw==
X-Google-Smtp-Source: AGHT+IHepxhLhn9l925Vl8JJClATG9RgSEp0EWwky24jMVXCvwGtaN5iMmiyr5bdE2bETlV8IxWTOwQ2I1Gqe1OQRKY=
X-Received: by 2002:a05:651c:1504:b0:36d:501:76d5 with SMTP id
 38308e7fff4ca-37609e04b12mr54595741fa.26.1760376335223; Mon, 13 Oct 2025
 10:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-b4-ml-topic-tcpm-v2-1-63c9b2ab8a0b@pengutronix.de>
In-Reply-To: <20251013-b4-ml-topic-tcpm-v2-1-63c9b2ab8a0b@pengutronix.de>
From: Badhri Jagan Sridharan <badhri@google.com>
Date: Mon, 13 Oct 2025 10:24:57 -0700
X-Gm-Features: AS18NWBjMOJ6B2vTw7qkNIU1gCMuQD8AnUYjhkyTglgRIZitzY8883Iq0mSGLV8
Message-ID: <CAPTae5+sq5uFGpOoHziFoBKbhyzeJ_r6QmJA98wuQhFaTXKmug@mail.gmail.com>
Subject: Re: [PATCH v2] tcpm: switch check for role_sw device with fw_node
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 2:43=E2=80=AFAM Michael Grzeschik
<m.grzeschik@pengutronix.de> wrote:
>
> When there is no port entry in the tcpci entry itself, the driver will
> trigger an error message "OF: graph: no port node found in /...../typec" =
.
>
> It is documented that the dts node should contain an connector entry
> with ports and several port pointing to devices with usb-role-switch
> property set. Only when those connector entry is missing, it should
> check for port entries in the main node.
>
> We switch the search order for looking after ports, which will avoid the
> failure message while there are explicit connector entries.
>
> Fixes: d56de8c9a17d ("usb: typec: tcpm: try to get role switch from tcpc =
fwnode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>

> ---
> Changes in v2:
> - fixed typos in the description
> - added fixes tag
> - added Cc: stable@vger.kernel.org
> - Link to v1: https://lore.kernel.org/r/20251003-b4-ml-topic-tcpm-v1-1-3c=
dd05588acb@pengutronix.de
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.=
c
> index b2a568a5bc9b0ba5c50b7031d8e21ee09cefa349..cc78770509dbc6460d75816f5=
44173d6ab4ef873 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -7876,9 +7876,9 @@ struct tcpm_port *tcpm_register_port(struct device =
*dev, struct tcpc_dev *tcpc)
>
>         port->partner_desc.identity =3D &port->partner_ident;
>
> -       port->role_sw =3D usb_role_switch_get(port->dev);
> +       port->role_sw =3D fwnode_usb_role_switch_get(tcpc->fwnode);
>         if (!port->role_sw)
> -               port->role_sw =3D fwnode_usb_role_switch_get(tcpc->fwnode=
);
> +               port->role_sw =3D usb_role_switch_get(port->dev);
>         if (IS_ERR(port->role_sw)) {
>                 err =3D PTR_ERR(port->role_sw);
>                 goto out_destroy_wq;
>
> ---
> base-commit: e406d57be7bd2a4e73ea512c1ae36a40a44e499e
> change-id: 20251003-b4-ml-topic-tcpm-27146727d76a
>
> Best regards,
> --
> Michael Grzeschik <m.grzeschik@pengutronix.de>
>

