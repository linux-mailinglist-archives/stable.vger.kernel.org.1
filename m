Return-Path: <stable+bounces-272346-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V0CoL2KOTGq0mAEAu9opvQ
	(envelope-from <stable+bounces-272346-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 07:28:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B775D717752
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 07:28:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MwkFu9ym;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272346-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272346-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8669930158A1
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 05:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB983845B7;
	Tue,  7 Jul 2026 05:27:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4EE2BEC34
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 05:27:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783402079; cv=pass; b=OO7ocvfiM+lu800W+3SEO6sabiwAgrqEQDmXIIHMUM7dRoI4GP9c8Z/bZAkyBlBrALwUWZtTDhVQxbQyL05YBhaeqat1EmUkOAJuudEgT7htppEilzczDk+qEKVTp9Sl7GkEoFUOL4+QM5kKFBzxI8Jd/xAMr6uwOeOpJb6ats4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783402079; c=relaxed/simple;
	bh=xThja/YOLrs73p1GwKH8+OsxAlTGp4FlomletDBuHOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChUSrwjRmYFGiOlqifjP3dF4D6hKlB8yufmz61Js9VnBN5OB/mhuokdF413c3As0MtQ3vWKh/ctSL2XHIrkta4ykHFz18l7FvylLseNObUHe5LbH7CjVOyk0JpM34US+iMcOVjrUIqH/e8sSmGBbOzkhD1kaBaaikDIz7bqzJd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwkFu9ym; arc=pass smtp.client-ip=209.85.221.177
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5bd742e0c20so2715282e0c.3
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 22:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783402076; cv=none;
        d=google.com; s=arc-20260327;
        b=bhAVz+1DLwI5njZXPe4xWIgtk37u2eaypHATa92eEn9giPU7TZI3pZkGGr3avsl+4R
         1xN8DUBO4BbYSelDG/Y7qhTw3WcCuYRaPG0N7SGbOMvwpnKZ1xd3ogiVlg5rps9VpScE
         jyQn9Y7A8hAW2sAUc9ewG2gMtuhjrIaEhrRVxEtqyYulYuGsSDES2kP3coVjw6yB1M9d
         mH1jTqPA7xJzBoOz0d94Zleigx4aj0WYoe6uveifRs6YbxQ0jvrM6gDDBhZPWOmFXlnI
         fGZx4rUPZR94CStI0dHGgBNJslEBJim9YPm9p0u+xEXp/8LbKTGqH78FEDhvalaT+xNI
         BwVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ceiIrxAr70b69uYIUvEAod9HzClr5zoqxLtdkcPctn0=;
        fh=h8pmcGECZZJgzfiF5oEdTOgA6MWRguz1XVA/ZNRLt+I=;
        b=Op0AHk32WgSDgrbrius16CIqQWcTqXRSsQ3sMzMEGBDXCsZ0iwVNHAQBZy0M41mDZY
         jqenA094jejlnD3HW5FaOmDlIRpmwBaQY2kLkv+Ea/73OOezMvh2LgUZDyAybSxAv84f
         6eDThAuNAgLxyFq4vlka81mKPPbWbcjga+v9l+ZBoXGaPRAUctKwe2LalnVV+BsjIbmD
         pFHEuDNqjYMy/GP2Kblzus1XMj5qdrHeNWV1i2+UdteS5olDUL+fcwEJreynQWSUanJO
         9ZG0g6ZYhIce6bVdNxyXtWsDjINj3oaEIHgtDnGUW8La9PeFPn6JoMazF+NmRlwHsMzo
         SGMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783402076; x=1784006876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceiIrxAr70b69uYIUvEAod9HzClr5zoqxLtdkcPctn0=;
        b=MwkFu9ymsowW5S6hp2y3CCadPUB9KZ9RmSbCFRapoHq90aVM47QeQs6tKrj8GSiGZp
         Quv0UkiQo3OSiyBUjCMeBQmqKRHRwD2YjE7Rg/x7jZcDJWkhEjWZIEiKercr7DWCoKEi
         h48O5ZCiinKFSCk0PFsWbaxWlEKtWWZVU2K5ihGQaZAWOry3D7pho20xLTPoKOrkpS0t
         fnYZgjVdhRaO6HezRBSXE924r+CQBdJYVDoOWWO0G2RHdRUl5tBF4advSsbSG24f6PUe
         UYh4YAlgWZr6Hvml9z7sGEiO+ycnxuX0aH6WE478G92NxEAt4tknJZCP7HU1xins59qN
         8ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783402076; x=1784006876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ceiIrxAr70b69uYIUvEAod9HzClr5zoqxLtdkcPctn0=;
        b=L6EEGfZySmFa8T/PtkLaSVgoRdkHJgTDEyaXt3d/9Z4Pb3gFO4USEGKkJP4WcjNBXT
         AnXBaVMUQkov34112DF3bCjtp+sa3mpJnI7Qr6NAngcikgHamnEbaWGVyJBhTUYt8+yt
         AvzNLh9vCegVB9HDAa7rPZ9gl5YGtfqNE4oxBhJubJUMA8YrvbJpfJeFeK2bvIQ1LAX3
         +XME+cYHgnpc7bzCGm5qOQhq33/LlRIjz/i/fLJLKGhuuptW2gf2ehQyZIyv2x71eckG
         oTg8hUV+WI+Hi7pdW6iAl9/IlIPOmFWJwnF31Urqpw3X9H0EQHRgQ1e9TbYwO3GXRFxz
         WEDw==
X-Forwarded-Encrypted: i=1; AHgh+RoqaxsrZMENToWL1gANlbyPLnbA5g3yWsrTvFhQ6dLJunkeatUFwfxT281jPS3DPnKSunN+6M8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3+/1KT5rXeYbfaVnzMcU+F+QYBerIlbrISORQij0o6Dy8WGyY
	vkdQkcAPOsgQFO21wmi6+06wxb/fA96WOvJk5u63ppbEybGxG7P4ERI0bfrYpED2oMnz5hBa49Y
	LhDQfSE+UUkuxcVRWMPIOO6hSFsR7P7U6yF0G
X-Gm-Gg: AfdE7clmJVmqM4jHNWp9tvZ3M/tL//KZfklhSFW1gFefhrDyfzxliUMDzLJ9S6XdVnK
	jiipU5lboxi0oE+9EWEcyz0ghKYm6oasxE1IPkU0ezM4Nva3kw0WwxpmFau8y8fjKUvbaZg/J55
	AW8HUwc7CsSxVLzJeH3OggIY42AsQeE+2/M382DjvJuwVJUbZRtoQpK1H6cilv2k8iRsFdLuvTK
	wZrtc3J9hm5VL+oT10v5Nn8hMGkMreadYlcQKWs6sM08J2p6o0FNcvLMna39gq8Q92hxzuxsk/G
	v3c0kHpX2YpvbrOVLU2fh2FWqdx/RwT11wY=
X-Received: by 2002:a53:c087:0:b0:664:db84:ed31 with SMTP id
 956f58d0204a3-6677fa39c3amr2066648d50.2.1783401614068; Mon, 06 Jul 2026
 22:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706151049.63470-1-mhun512@gmail.com>
In-Reply-To: <20260706151049.63470-1-mhun512@gmail.com>
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Mon, 6 Jul 2026 23:19:00 -0600
X-Gm-Features: AVVi8Ceo1EWUz0X_LXzRXiGMHgFBV5_Dl7Ao-MwwAd5Q8AhFO_m3J-vqHF7_ihU
Message-ID: <CAMMLpeTdjtQQv2HuKMe+3WjaLKZZxPo5QywBA8_xd0c1Ta3KFQ@mail.gmail.com>
Subject: Re: [PATCH v2] USB: misc: uss720: unregister parport on probe failure
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Oliver Neukum <oneukum@suse.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272346-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mhun512@gmail.com,m:gregkh@linuxfoundation.org,m:oneukum@suse.com,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:ae878000@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,suse.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[alexhenrie24@gmail.com,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexhenrie24@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B775D717752

On Mon, Jul 6, 2026 at 9:11=E2=80=AFAM Myeonghun Pak <mhun512@gmail.com> wr=
ote:
>
> uss720_probe() registers a parport before reading the 1284 register used
> to detect unsupported Belkin F5U002 adapters. If get_1284_register()
> fails, the error path drops the driver private data and the USB device
> reference, but leaves the parport device registered.
>
> Leaving the port registered is more than a private allocation leak:
> parport_register_port() has already reserved a parport number and
> registered the parport bus device, while pp->private_data still points at
> the private data that the common error path is about to release.
>
> Undo the pre-announce registration in the get_1284_register() failure
> branch before jumping to the common private-data cleanup path. Clear
> priv->pp first, matching the disconnect path and avoiding a stale pointer
> in the private data.
>
> This issue was identified during our ongoing static-analysis research whi=
le
> reviewing kernel code.
>
> Fixes: 3295f1b866bf ("usb: misc: uss720: check for incompatible versions =
of the Belkin F5U002")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> Changes in v2:
> - Move the parport cleanup to the get_1284_register() failure branch,
>   as suggested by Alex.
> - Clarify the visible stale registered-port effect.
>
>  drivers/usb/misc/uss720.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
> index a8af7615b1..bd099cd8c5 100644
> --- a/drivers/usb/misc/uss720.c
> +++ b/drivers/usb/misc/uss720.c
> @@ -735,8 +735,11 @@ static int uss720_probe(struct usb_interface *intf,
>          * here. */
>         ret =3D get_1284_register(pp, 0, &reg, GFP_KERNEL);
>         dev_dbg(&intf->dev, "reg: %7ph\n", priv->reg);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               priv->pp =3D NULL;
> +               parport_del_port(pp);
>                 goto probe_abort;
> +       }
>
>         ret =3D usb_find_last_int_in_endpoint(interface, &epd);
>         if (!ret) {
> --
> 2.47.1

Reviewed-by: Alex Henrie <alexhenrie24@gmail.com>

