Return-Path: <stable+bounces-246919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ4NJxWnBGogMQIAu9opvQ
	(envelope-from <stable+bounces-246919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:30:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F8D537120
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59076334E0AC
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2A84968F7;
	Wed, 13 May 2026 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efYO46KO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1088438C2D1
	for <stable@vger.kernel.org>; Wed, 13 May 2026 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687294; cv=pass; b=cL8Z2mzlkcG6Quu2uRGovXPi877KfZAJ+lQ/eOx7UZCvuq6kOuujHIgn9QIs22mpNW96n9u7XEr8fiTnRudRB6Xh6wfwOxW3wEd9DUEjCrtni0SV70WvWPX8QxgdNOz2JuGc44xlARGlD6zDYq2VllcY4fV5uhpfbfvkA/ivqic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687294; c=relaxed/simple;
	bh=Qbd60J64k003Aq/VrcEF9ItxsZ2cCsDjKfneevCT3yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BiiTqCzsfODaehaHcEeST7MOW5MpKv2saBuBXjEI9YwnCNzRrkgfXw33ht0WaFEzieNRFWhdT7GapMj0rIx6AN3qg/Whn9PgcZk33c80W8kKdN7Vn2LinTcrPGY+4hgh/jn2SqT04Pz5ePbOppW2OlQ9PevvZA4KMdw7vONx6eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efYO46KO; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bd4d7f4fa02so45558466b.3
        for <stable@vger.kernel.org>; Wed, 13 May 2026 08:48:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778687290; cv=none;
        d=google.com; s=arc-20240605;
        b=XJJgXd4pOR4BLx8QEHS3HB3ft/xXfsgyZWIgkdFlm0Ka/5THRK7Y1gWINFLS2B/tGQ
         4HqqqtOmuWKFox8mvtJUkXC42AX/F9tMC8bRjbwAhJ3y1SEScs/lP5Ageiuz4CdjfgYx
         BgdaYuZUv+0cBLqSyjKtHsfnJPDIICr6Lkmb1YdAx93+MxUuz3lMWXk3sUApXLleaAF2
         drl/0jKucWNKnUfvSnY0nVjPktMyAayuIfVQEJTrqWkqbWCb5KceuJPjg0GgK3xe5Qqj
         6gt51P0jFSgkhmq/CBERIAv6Us4pgYjN5MVN0Xp/rIyAg8rCodMxxypc9rGhHraHDJWh
         5HjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8dkachk0WX3eaVF7WmKsff8zgWZXq5GvXzSGAILyzQU=;
        fh=B/sxH5wVDo464It3tdY63tAh+r2cHP3HpI1HYjqQ4qs=;
        b=H3Uk1BfXGjG1fl1taynEpi3ODYIUVSx1GDjMIN3OYzQb3X49mninmGlUwaksz+MQt1
         aSHLIVSGD8y9H7zmLN+b0BPSbl+8nukvLO6FhUY+rAjRiBG9Toe4PkxXjxzBs2Mz1WEL
         g+E1bCNAcMH+uXl5n5lW622sdEcAD5+Z/n2C/LXv7wPZUsEx5YzYPX+O4Ly3uw9tnsy4
         b/C5qnVoxthh+CzfcP2AaKBuL4ORcDNzmcmTXcFgVIP24Oj0d26e0qkGo69KCzHAYqxT
         OcL/rfydr3VA59ANgd1OrQiIydL51HR4rnamCujYYS8K2hS4VLBN3ockBulrl/X/z/MK
         9htQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778687290; x=1779292090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dkachk0WX3eaVF7WmKsff8zgWZXq5GvXzSGAILyzQU=;
        b=efYO46KO3K8jARZvNf4heKuBwa18OQ4Oajxi3Vnei3usHeb9kCsp/9PWPRWP45D35C
         enjnsldlU7P0NOFXfqaCu/jU6rsJoXyhJxDa3E8AsazkJY0AMxRmGNJS689dTTbmx8iV
         qL5LxmJbfDJRsRbLHZ4UMLNc8dZTtPcWeQHAPJ/h5yTmEhMEcKl1d5UN6ZCOAJMFM6J2
         uY2ov3hK92nrPuQT3TD5VawndlBK/edo236Z/zdJU7RsXCPPj+y6O4Y8/a65IKiEx36O
         0Z0GTYceZ2XFlzjWd0Y5BTcNtQXoIkOIX1cC22bE4Jja89e95Hh/3trujJC7TyoUGXeL
         zzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778687290; x=1779292090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8dkachk0WX3eaVF7WmKsff8zgWZXq5GvXzSGAILyzQU=;
        b=qI2mValON+KxBhWxOEY9vTDD0P94S5gyv7Xcobu0jt2C4BMzrngDoTFDi/mM5XV61p
         OLnW/AtXYYlXahjDqkOrx7mZJWTiwhrh5MKcG1P8I9SN+nB/yS7t+9E9wXvSq//t9M+d
         +wAXq+QXrr/kjSC8zqZSr8kWMGDGMRm/FNPuICw2PK6kLonJzCBa1MiFpjMjTOQeL42c
         OxBMwDwyMgN8rIz0t/wPxQ2cJ+NkERhpvsZZBojSM1tHRHlMf/uEpfrgix+m8l5F/8v1
         MYz+rkP6cE5vdT3Z6c73iG43xv5LjP2SpnT/HQcIbRk+6+97mrbIsgw/QrNdnbzfVJUd
         CYlw==
X-Forwarded-Encrypted: i=1; AFNElJ/Ie6R5rxvCK3OHMfY2DdvQYv++A1KLIAdNEXXp6/HcHChrXsyJKlpuqNJelaUJLvCuQ+YXgz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd8g5XInBSKVz75vFfijYoZHvGYiqIMA6zKVSCHeSBvfiVFqN7
	v3Bd6tUm3mIkNT7BMTkixL8+b5ZX4IoB/e29hN57gWlHUS5gr4xN3KhpaCJo9YmboHinjJ7wOqO
	pn9Nps+XErOvaRlBLp/xwVfdW0CynQst/DA==
X-Gm-Gg: Acq92OFJ7dwQ6+WDHtAkGNSLfXxsIn8pT6LIEQkSNqQaXGzAdolaSljNMMPXhSdMCaa
	RLKC43dDr5uoCYZV0rEaWlPvpKvirobMfzv98zhMaopKSnGVjRKyH9n3KcWgdfXEzf9Jy16BJX+
	SzTYvUn/mMUIZ1FcxDECmhSYLhrz2LB9yJtfWRt47pRsatuyqpQPZrZT17Fv7eeoqzbmrFZHPuL
	0omaUeCc6CyM+LYu47XX2Eem0t1gmTgURHES4lP2pg02uRjrylYy8HKAnd13Cv49pDYPgdWUPS4
	YcWjLX3RbdNt8RuVVgxwFwj+ufy+AZhK/AnbVzgdXg==
X-Received: by 2002:a17:907:744:b0:bcd:c899:904e with SMTP id
 a640c23a62f3a-bd3bf484874mr249895566b.7.1778687290382; Wed, 13 May 2026
 08:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513075935.1715836-1-lee@kernel.org>
In-Reply-To: <20260513075935.1715836-1-lee@kernel.org>
From: Ping Cheng <pinglinux@gmail.com>
Date: Wed, 13 May 2026 08:47:58 -0700
X-Gm-Features: AVHnY4KZLSY3dQ15iDGEZ94SB3Zn1wsXCLnliS34n_SJKMblVlqjWzaTPYwzNV4
Message-ID: <CAF8JNhKTMpT3CGq_oDqaGVygqXK0jjvrvjxbAWUerqtWzdB9+Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] HID: wacom: Fix OOB write in wacom_hid_set_device_mode()
To: Lee Jones <lee@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 42F8D537120
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-246919-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pinglinux@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wacom.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 1:05=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> wacom_hid_set_device_mode() currently assumes that the HID_DG_INPUTMODE
> usage is always located in the first field (field[0]) of the feature repo=
rt.
> However, a device can specify HID_DG_INPUTMODE in a different field.
>
> If HID_DG_INPUTMODE is in a field other than the first one and the first
> field has a report_count smaller than the usage_index of HID_DG_INPUTMODE=
,
> this leads to an out-of-bounds write to r->field[0]->value.
>
> Fix this by storing the field index of HID_DG_INPUTMODE in 'struct
> hid_data' during feature mapping.  In wacom_hid_set_device_mode(), use
> this stored field index to access the correct field and add bounds
> checks to ensure both the field index and the value index are within
> valid ranges before writing.
>
> Cc: stable@vger.kernel.org
> Fixes: 5ae6e89f7409 ("HID: wacom: implement the finger part of the HID ge=
neric handling")
> Signed-off-by: Lee Jones <lee@kernel.org>

Patch looks sensible to me. Thank you for your effort, Lee!

Tested-by: Ping Cheng <ping.cheng@wacom.com>
Reviewed-by: Ping Cheng <ping.cheng@wacom.com>

Cheers,
Ping

> ---
>  drivers/hid/wacom_sys.c | 13 ++++++++++---
>  drivers/hid/wacom_wac.h |  1 +
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 1b1112772777..a6c5281afa06 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -341,6 +341,7 @@ static void wacom_feature_mapping(struct hid_device *=
hdev,
>
>                 hid_data->inputmode =3D field->report->id;
>                 hid_data->inputmode_index =3D usage->usage_index;
> +               hid_data->inputmode_field_index =3D field->index;
>                 break;
>
>         case HID_UP_DIGITIZER:
> @@ -556,9 +557,14 @@ static int wacom_hid_set_device_mode(struct hid_devi=
ce *hdev)
>
>         re =3D &(hdev->report_enum[HID_FEATURE_REPORT]);
>         r =3D re->report_id_hash[hid_data->inputmode];
> -       if (r) {
> -               r->field[0]->value[hid_data->inputmode_index] =3D 2;
> -               hid_hw_request(hdev, r, HID_REQ_SET_REPORT);
> +       if (r && hid_data->inputmode_field_index >=3D 0 &&
> +           hid_data->inputmode_field_index < r->maxfield) {
> +               struct hid_field *field =3D r->field[hid_data->inputmode_=
field_index];
> +
> +               if (field && hid_data->inputmode_index < field->report_co=
unt) {
> +                       field->value[hid_data->inputmode_index] =3D 2;
> +                       hid_hw_request(hdev, r, HID_REQ_SET_REPORT);
> +               }
>         }
>         return 0;
>  }
> @@ -2819,6 +2825,7 @@ static int wacom_probe(struct hid_device *hdev,
>                 return error;
>
>         wacom_wac->hid_data.inputmode =3D -1;
> +       wacom_wac->hid_data.inputmode_field_index =3D -1;
>         wacom_wac->mode_report =3D -1;
>
>         if (hid_is_usb(hdev)) {
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index c8803d5c6a71..b2e74d7ab3c4 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -298,6 +298,7 @@ struct wacom_shared {
>  struct hid_data {
>         __s16 inputmode;        /* InputMode HID feature, -1 if non-exist=
ent */
>         __s16 inputmode_index;  /* InputMode HID feature index in the rep=
ort */
> +       __s16 inputmode_field_index; /* InputMode HID feature field index=
 in the report */
>         bool sense_state;
>         bool inrange_state;
>         bool invert_state;
> --
> 2.54.0.563.g4f69b47b94-goog
>
>

