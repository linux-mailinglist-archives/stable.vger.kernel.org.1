Return-Path: <stable+bounces-223173-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dJEGCqgsqWlN2wAAu9opvQ
	(envelope-from <stable+bounces-223173-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 08:11:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7D620C393
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 08:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FA11302A065
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 07:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAAD31355D;
	Thu,  5 Mar 2026 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXv8zOpV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAB630FF1C
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694673; cv=none; b=ZxsEtXbRwEvzDhY7zJ2XRnuZ351dUM/+KUpDsz5xW2I8HMR0wPOKaH91FCocg6UxH6h2yhs3KmMEOhF2rM2c9PB1IDdacJb0mwj11//nSOc0WtBRRGMraJ57J18gQirdfSLqtjD8U2bVuNOcAoke27jU3B+j1+r7Dh9yA+QXYyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694673; c=relaxed/simple;
	bh=mXFSWInmvF0MbvYWew7YaaBznDQE9EjRqSSCjHVWM0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWUg2zlayRUNhj+SJQ+5YMZqqCFIVuDF5AfLwHTG9io5CrevP+T/+p6KYos+1EXrFgJ0Q1pZvxKYYdKlJR95MxPMv1umwYUtKUYLnehzHJpFBc77/FWSiWwFd6HF0dE4y7WAlsvyr79IqSMkkv40o7gOaAdzqOkb1zwtPx1bRMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXv8zOpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD994C19425
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 07:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772694672;
	bh=mXFSWInmvF0MbvYWew7YaaBznDQE9EjRqSSCjHVWM0E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tXv8zOpVXN9YPp1+Gnn+Uur5+wyjQlYkb1dKDhvI7Nr3rLIP3Rb1tn1ogaoWE7ZFa
	 ovWQ9PQ+YMcp+jZ5/IREtjGw2ROJMI4cegJoLwhy5gZLd2aLRAj0MVZoHapHxEfnGa
	 jlF3FWe05UfLZt7EGUmD5HxmFgGI2wpEuiUnvnHXhbw3Z0b5HOrTofwpg26FBlUWlt
	 s6pkADTZ9ISNRsk3ImAl6tAVpRGfGIjqvy18Sdw2ds+JysYqJWk9p8wsP7+p/bmVId
	 D+Q5SlSjvFEBrvZoYy2V151KtyUApglmvyMguSQrYjcgBnG6Da3dLUpxwbI+3FQTvX
	 4JzsksjB+msNA==
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ae3a2f6007so36155735ad.2
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 23:11:12 -0800 (PST)
X-Gm-Message-State: AOJu0YyLEutcClkjfVE4PlctYHOmRFc6gRLm5QoDQCv6dfZ5VTl0ToRt
	AW+93ONVSsZ+IC65bzRsA1tZEG0jbNvIdkMTZCrlbuPg0AKpk9+ZVTaItu1h+bXw3YaQ1Bq5o00
	TzlCSzJt2iFus1WLYWanQkXKveo/NX84=
X-Received: by 2002:a17:903:2283:b0:2a9:5f11:3a26 with SMTP id
 d9443c01a7336-2ae6aa05619mr41094335ad.7.1772694672274; Wed, 04 Mar 2026
 23:11:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226152924.38790-1-evg28bur@yandex.ru>
In-Reply-To: <20260226152924.38790-1-evg28bur@yandex.ru>
From: Zhu Lingshan <lingshan.zhu@kernel.org>
Date: Thu, 5 Mar 2026 15:11:00 +0800
X-Gmail-Original-Message-ID: <CAL=tH4Z2Ajz5C4p2WzwxHWKyHtuhqh-jSiJHuP_p430wLZBtxQ@mail.gmail.com>
X-Gm-Features: AaiRm51ucb-BYa-reeQ0TL8MIdBV9RzONVdvI-jo2XUM7rl_PIiph6_qNJcQ1Pc
Message-ID: <CAL=tH4Z2Ajz5C4p2WzwxHWKyHtuhqh-jSiJHuP_p430wLZBtxQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa/ifcvf: handle dev_set_name() failure in ifcvf_vdpa_dev_add()
To: Evgenii Burenchev <evg28bur@yandex.ru>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7A7D620C393
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223173-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yandex.ru];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lingshan.zhu@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:31=E2=80=AFPM Evgenii Burenchev <evg28bur@yandex=
.ru> wrote:
>
> dev_set_name() may fail and return an error, but its return value
> is currently ignored and overwritten by _vdpa_register_device().
>
> Abort device creation if dev_set_name() fails and release the
> device reference to avoid continuing with an improperly initialized
> struct device.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_m=
ain.c
> index d46c1606c97a..ab6d6ab3b3d8 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -734,15 +734,22 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev =
*mdev, const char *name,
>                 ret =3D dev_set_name(&vdpa_dev->dev, "%s", name);
>         else
>                 ret =3D dev_set_name(&vdpa_dev->dev, "vdpa%u", vdpa_dev->=
index);
> +       if (ret) {
> +               IFCVF_ERR(pdev, "Failed to set device name");
> +               goto err;
> +       }
>
>         ret =3D _vdpa_register_device(&adapter->vdpa, vf->nr_vring);
>         if (ret) {
> -               put_device(&adapter->vdpa.dev);
>                 IFCVF_ERR(pdev, "Failed to register to vDPA bus");
> -               return ret;
> +               goto err;
>         }
>
>         return 0;
> +
> +err:
> +       put_device(&adapter->vdpa.dev);
> +       return ret;
>  }
>
>  static void ifcvf_vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_d=
evice *dev)
> --
> 2.43.0
>

Acked-by: Zhu Lingshan <lingshan.zhu@kernel.org>

