Return-Path: <stable+bounces-217919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK0NEeu8nWklRgQAu9opvQ
	(envelope-from <stable+bounces-217919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 15:59:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B123188C3C
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 15:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11B92318D210
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 14:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8A43A0B1C;
	Tue, 24 Feb 2026 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBy9G2n/"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265DC39E6FB
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944977; cv=pass; b=guwKd6T81JM04Syj0hIdNtQSpN2kqLgGoEoVCWWc2AQ1bRyEZz0ULf+Efsu52SmLWe2qqbrbG/XXBfDZE6VBQz5XN2n4dKQnkImmKID/466E9LSihtDkVDfLbmIrnNbswBTCN5RVeAoD77JjU+Ypjz+ns5p/HB1phuwV2cFnjrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944977; c=relaxed/simple;
	bh=BE/IjM2ls0lxtxJPoirvwOpq2YNARq/aUgRkcKRROhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdsXV1LsbpVVlM7hR25qF3RL2dj8i2nVTwvKZwVvHALGi86ubF8+yHYaVb1SUiVRpU4IZKvsCQkzuJWfnEF1HFUQ7SbFcc+2awNrpOUzyNkimud/RqW+5oSGXEHIA/OsTFueAjEnXmkTz8GIbhfzheRGA3vP8jzQ4FuqprH4xOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBy9G2n/; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1277863a912so86396c88.0
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 06:56:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771944975; cv=none;
        d=google.com; s=arc-20240605;
        b=MRwRz3JrwzvPWTA63kyPN7DgOQ1bfHWcTzgHaY6BfeC359PpdNB7JMPzx781SuoF4w
         8wYdegztB97jkvFXMnprs1sMiva7ct99j+kefQMqrJA8e4MrPOcduUQmZsZOwCpBtJ4A
         auKZ4gYpYIOc9oxitNNZ7ytblm4L/1mB63F2wKmrelbm8O74yqeOT6Wphl36dCEMnZXJ
         eDW3xN4aTbbsrG3VLV1GqnLP3/eVX9bosdnjaiDDpl2l/K3DSw1XD0OptEO3ZC0U31ZW
         g94K9TWXYnvRtx8Bn+DJJ97mNXAczoFJPqWFc795X2GHmpkHB4NgDIWQE95iPM8QDutl
         OeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i+aUfl6j0iyUdg8FHTmaS7+nE4Zhy7tH6M8xZwgvbTs=;
        fh=4hPtVEpS3o27bWnphTL+fh9psg7YLbhAw4ofRXzvViQ=;
        b=DPikZmybUjcTHueNq+ipaM73A1E0wt05dP5uDyHjbUwFDdzxYcgRyEYjXoycw+Jc/j
         rpln3R08HNkpgG7X0KFwLioUyHo/Yz/mzJkBNLcJN3f3oAeq8C4aTAXlHN7Lm7+8tEYi
         JiPveZDxomDgQT0dgQ1CrFyp8wVNQ76F6bhjNXRH4EMPxvc/5mxUuyOGL7PLHTfXnptt
         oBWgQ+pv+MBrPzEYa2BWR3qdQA5JgHNLWOGp5pKxuf+BeTPaBozT1tfQc6w9iBJZ2EMt
         a7QGanVq8b0pkrNKYgZ11TXGKrA1sjiBY7oP2PMvehn0moM7LCoMvz1YYcqQKBzXrT+x
         NYpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771944975; x=1772549775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+aUfl6j0iyUdg8FHTmaS7+nE4Zhy7tH6M8xZwgvbTs=;
        b=MBy9G2n//W6Dxxy8aGroAv8QBW9mf3zOdgnRk+23mGwzrSzEHTgrfqumGF3Kq9S/TO
         OHNeZ2328Ck485Vz9ua+uIlbLu11MAb8ml6NX55t+N4YmrI8y3oMLUsFTURzzd6HzhAB
         rKWvs/bfoUK+Mrw4qkMtr8uOwRojk/u+U4ugIWtlgvE5ZAdHGlXoYmfQM/2vK0lERIIM
         0xKh1o5pa86AvYgNpTt5hm/G5HZWPIuOMpbD9IFvjtpakNUU+3XyUvxdADLIHSOnCvF+
         K+CTQDM8VjcQJUl5oT2571jeHz+odwt1dsb/U3ae01kkdZ9Q1/9LYGY0EVT0w3/bYsAS
         ZzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771944975; x=1772549775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i+aUfl6j0iyUdg8FHTmaS7+nE4Zhy7tH6M8xZwgvbTs=;
        b=BcMwDB4w2WGDFkjFf7KfgQ7B35CBKzu+/z3F59Sr5JPYDMA0fFVdBchiJl7v9pr4QU
         CjMpTyEu73+Tmn1yKiF2En1pbQ6BrVM1UWb1H/IC2ewXU4w3gXdgpCPQ1gQQkfGrW0lV
         ShPNELNXXtdNZ1vgvV7hv08gwjq6WmZd5wD3VqUH62sSjlWH2MRv47/FPbLhf3VJU/TS
         qpBXZ9EF3i6EsAbKEay4SK+Qy0dsf24X4f1LzMq8gJx9uiSIr8jkJVUSZxlbt3bDAyiP
         wr7iywz7xVoU8g/MoXSzcoqUYqWD3vsUpSCJmVCgZbvIuS0zNIsBqZtPJa7YY9yJg3E3
         boew==
X-Forwarded-Encrypted: i=1; AJvYcCXiStqURcTAUtA3oUj2E5s+1W/OG/MPXpTOy4okH9wMIJAJnYzjdLDB+Ebp8gY8ChV/ije4Cgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH07G0WMIWPa+knTQY1IesyenZonksjXzenYYAMEtAHfvVhy0Y
	yS//9XbEPzVag6HVSjJ9O+A7STFut4VM/QxYfEJAR1gSDYwOrcI92Zd9Z1L28CDe4K5ZK8Mi1sh
	UyekQkPrAsPHhHUyo+Ti6nAfq0koYc+3tCw==
X-Gm-Gg: AZuq6aLG4vwEszJmlkwzVN5vi7P/sbJaBfefYRcnB3bdWTNJKoGw6TqLb2at6twhQRW
	z8c4YR+GF4h0r0l4NkVR9vSkdlnk6TicAy8h8ySwwRfVsld9tlUuf0xQqjEZqQA19We8P/4lt8f
	FEVBkFpUqgQxxyRwA+M0T5Di+b0MSpDJ3qLNXdY8orCeA+2UFWs8LJSyPBEpVrxjJHmQBrZ8sq0
	/38xG0a242BJBsHtAKjzY5u3hC1R0yIoSK9gqMdILiiykAKtXA+NFQgV6oN34H51/d4uol3yuAu
	PlKWejZKWywPRKX/aiMX4nIFJ6GvgPx8gIsEf5pv+qxYx68Qlonj8e/CtG1PWo6GVv1ZAg==
X-Received: by 2002:a05:7022:2383:b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-1276acad3efmr2638142c88.1.1771944975132; Tue, 24 Feb 2026
 06:56:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223114537.38145-1-natalie.vock@gmx.de>
In-Reply-To: <20260223114537.38145-1-natalie.vock@gmx.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Feb 2026 09:56:03 -0500
X-Gm-Features: AaiRm51cXcZtY95BR3KKsGNKEGAquNMI1RXUNYCMVFCpARLt8EwnLScoCBKOJGQ
Message-ID: <CADnq5_PYyDxySN+FjqDd5LXMrYz2VYEhG_R6gY1gSXjYD6dk1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use GFP_ATOMIC in dc_create_stream_for_sink
To: Natalie Vock <natalie.vock@gmx.de>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217919-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmx.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexdeucher@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,gmx.de:email]
X-Rspamd-Queue-Id: 9B123188C3C
X-Rspamd-Action: no action

Applied.  Thanks!

On Mon, Feb 23, 2026 at 9:34=E2=80=AFAM Natalie Vock <natalie.vock@gmx.de> =
wrote:
>
> This can be called while preemption is disabled, for example by
> dcn32_internal_validate_bw which is called with the FPU active.
>
> Fixes "BUG: scheduling while atomic" messages I encounter on my Navi31
> machine.
>
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_stream.c
> index 191f6435e7c64..87c0cf7e290ea 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -170,11 +170,11 @@ struct dc_stream_state *dc_create_stream_for_sink(
>         if (sink =3D=3D NULL)
>                 goto fail;
>
> -       stream =3D kzalloc(sizeof(struct dc_stream_state), GFP_KERNEL);
> +       stream =3D kzalloc(sizeof(struct dc_stream_state), GFP_ATOMIC);
>         if (stream =3D=3D NULL)
>                 goto fail;
>
> -       stream->update_scratch =3D kzalloc((int32_t) dc_update_scratch_sp=
ace_size(), GFP_KERNEL);
> +       stream->update_scratch =3D kzalloc((int32_t) dc_update_scratch_sp=
ace_size(), GFP_ATOMIC);
>         if (stream->update_scratch =3D=3D NULL)
>                 goto fail;
>
> --
> 2.53.0
>

