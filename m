Return-Path: <stable+bounces-224583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKPbFkiPsGkukgIAu9opvQ
	(envelope-from <stable+bounces-224583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:38:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F07F825863F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 660733014FFA
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D214E3DD522;
	Tue, 10 Mar 2026 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/slvI3K"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503013E0235
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 21:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178693; cv=pass; b=GI0VoLOP80/olkOLvt20Ug0soTKkDVzBhuUQqCQ28deOQjer7CdCSdvm8TYjiJf7Vij2Uzdx/B7A54tI8swNFLrrMY0mij63eR/pnJl9IFSjoZwkexssGMekuPpcJGupyZ2jWXdz+MO2qycskx1VnH/JwITvc8UJKgjFGFatSm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178693; c=relaxed/simple;
	bh=ZPwcQ2r1NA3+uZe3Qm2FZaVeuwbnwlqTqvDNIrs7NkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrL2ADg5IfLZvUYbzfcB/gzFggtEWxcuVwP4DqJOq98QvJwfetTiCSOUz8rBRlZu+CWLUt6pdjWrpubP8KDnQEIq8KLfnAONwSQ7qGp0xGcsqMQpCmr0XDRYvSVOtGrVYWW/siycnF4+38Y8TZDOxNg7SGfyhxNqRrgLRniXGCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/slvI3K; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ae222d978so13278274d50.1
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 14:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773178691; cv=none;
        d=google.com; s=arc-20240605;
        b=gXHkmui+BFTSBsNuW8V5AZX17mUxen030GLN4Sg31nFtMrCJ3MZiKZibqO0xNmrICV
         Wqdhl22LIuSZE2Btu1Ha4cuXeAXc3yHfc4q5Jw9EbJViqZE55ii0VhaesP7W+kdNVL4j
         OMP2zOEkBHRvZx68zEbGG+T1LN9FaL58G4u41MjQpfyNzTJF46Z2gbEqgdwm4fBwsg+s
         dV9HCztBrTHwffmgC1Qw4xF4HQjyz5d7MGnE+gNjmhkJR9wFSHEBuQaaBxtDanW1eHzb
         5nRUfID1NQFNfRa1LAO9qZNj/OWdk0zWbBT6T7RJ7++sDtJHIPCpnYZ6bwYp3DeV9YCO
         kcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hveQy5NQ41c3CMqNE96UtONH6cbf9Yvx1Ya2d6ApTtU=;
        fh=5VoiPLkHQuiNiJ4EaBrJ+fIWuJd7kaLOZhs8wOgG98E=;
        b=SrSIxowVBNj655pVFZl1hCexotcp2o56yY1beAM0Q7AWWMQTQ4nljBYUtusyzTAmMQ
         qFZZmWy4/eh+IpYk/kA+agcBtYGHAccLexQW9XIdRs0pdI+yIEvlpIGOMYAQEG3ereTi
         8/XXk1Lk9NjJVQ3HTm+JUsIk++vM2JE8x6f+7b1QOCfdWn4ZRqLZKzNXwd/V7hXlN68y
         rt6cGHPOge2krB4HqJIsUw6fTkdYz/aeOSWUIPGeVYfijYchD+ClZ6Y+bkwwgaO5IpTB
         iX9drG68M5wkB71AvQK5+/ASbAYvIk6sHdbCkOH+h1pbbWOGrOUbJvzVhQeCeaGSjaeF
         PulA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773178691; x=1773783491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hveQy5NQ41c3CMqNE96UtONH6cbf9Yvx1Ya2d6ApTtU=;
        b=I/slvI3KbW3cL4q4+cgb7QF5nBq10QpKDYUgwWMffLQiIKzdaU73AaPNpdqibtfRVI
         qgbKfjb4ToPGW8Coct9VV8trCRKsWZFjQhpQbvzv8/rZ9Q6ElwNHCBvgCX9S97cVAcd6
         Z8NTZsuRmrVcLb5hyUy0Ec3K5Ouok8aDgL7p2ZXL/fX1Pq4C+m9woJlPOQizhWEpw5PE
         hICll5HXmMEsoTL8CFt3PVvLmm846JZw/jtKXjXEVRbvbw709v1gWdsi2o2gPY+qu7TR
         naaCYPm49knD7Yx/OZT6VNoY8tGRjyKKy+Ie0cW1XlPf6240Lb2agIMlwEvlpLgvBoUY
         m3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773178691; x=1773783491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hveQy5NQ41c3CMqNE96UtONH6cbf9Yvx1Ya2d6ApTtU=;
        b=HWMmBTKqMGMSpnaUkTjx1xsPF2kh/4v7WAhtlVwjWR1J7aGtXZMTliLl0fz58T304q
         p1vC/SAQGpGLnf3WCoMIBDd0TMMkI3pMdTeKh7nNo0jJwYBMSOB60cjBH8G/FcyBtT+I
         4a/CZ+BQsvGWMrwTjjVp2vWAULqpYSUAZNGE+HFlG+YV/9LFlzv5Dv+DIHB3VMLePVO0
         oaR9fdgIw5u02Zj2F0P1+I66t9oHabcjMP+S79udFtI/W8IbUPEkNSx06P2wVhzI0zUT
         qN7GCSiEd81qcmTzPlfURv//D1CVEvva66Vk22salWUBkACUQtnPV3DKdvOXHiAW3Guh
         Kxyg==
X-Forwarded-Encrypted: i=1; AJvYcCU8WIkBQp+U6xa9Ffz7E+oWm4wfWufjT9QWZzXcSDHsjAJAiw697HiWshMJb3rlfsAGZaOJU80=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBr+XW6ipJIvjTo/n04EqjMK9wKB08LzeDEpwISi2D1fIo79T/
	e4HPmpekve2NptR+7kwbrm8Uu/+cnq7x9nJMBU6oYUPI+obrCQCnrBST7aZwrdzbOrRFMdQrnNp
	/+NfSOC1+XrJHtPHYEmA4PPYCLzVWzBQ=
X-Gm-Gg: ATEYQzz8hsv0xdNJ1UiqLYT+3GYX5T4tFKeFxnRVohLnO7aE8t96UYipPonaLvuCUjn
	jHIucnOYI4u1ly+PDlg6A6I/8oPbFWEJQu7YwROtimQ6LQYntDWaNLyhOVoIvfhkhhnrDHC7BkW
	oxmYsbb1uLOg6dXVjxl6Sh+K5k3AzhC66lwFtQ+5l0hryKqqRXnj+HQl7sGixIEsNRxMh1igtNQ
	VcvyQ6ypFQVnwLtiuDFs4uSA2jHswJzzn9ViAO/zhnppV9wMq6fPzTEYGFBfHTctUmxIGwa3YXC
	hud/DX8/tPylO5UWVf/vcEb+9qvt5qu15s2B3IJopBu9S6TsA+F7LJYyQRGLM2fRgwfllA==
X-Received: by 2002:a53:ea47:0:b0:64c:bae1:2168 with SMTP id
 956f58d0204a3-64d6569d107mr167282d50.12.1773178691339; Tue, 10 Mar 2026
 14:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abBJh7sJ11RKVGhd@1wt.eu> <20260310212949.74577-1-research@johannes-moeller.dev>
In-Reply-To: <20260310212949.74577-1-research@johannes-moeller.dev>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 10 Mar 2026 17:38:00 -0400
X-Gm-Features: AaiRm53xz9dxt3JPEvkeUJ8tCDsdQcU_Aebq03uBnJBN2lF3yWrHb5b0HIBdwOo
Message-ID: <CABBYNZLMBkBREoqmBpjwnTedhAQoHiFqN2wO-QCvpnMp+Bsfcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: L2CAP: Fix type confusion in l2cap_ecred_reconf_rsp()
To: =?UTF-8?Q?Lukas_Johannes_M=C3=B6ller?= <research@johannes-moeller.dev>
Cc: security@kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Willy Tarreau <w@1wt.eu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F07F825863F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224583-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,holtmann.org,gmail.com,1wt.eu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,johannes-moeller.dev:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Lukas,

On Tue, Mar 10, 2026 at 5:30=E2=80=AFPM Lukas Johannes M=C3=B6ller
<research@johannes-moeller.dev> wrote:
>
> l2cap_ecred_reconf_rsp() casts the incoming data to struct
> l2cap_ecred_conn_rsp (the ECRED *connection* response, 8 bytes with
> result at offset 6) instead of struct l2cap_ecred_reconf_rsp (2 bytes
> with result at offset 0).
>
> This causes two problems:
>
>  - The sizeof(*rsp) length check requires 8 bytes instead of the
>    correct 2, so valid L2CAP_ECRED_RECONF_RSP packets are rejected
>    with -EPROTO.
>
>  - rsp->result reads from offset 6 instead of offset 0, returning
>    wrong data when the packet is large enough to pass the check.
>
> Fix by using the correct type.  Also pass the already byte-swapped
> result variable to BT_DBG instead of the raw __le16 field.
>
> Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Cre=
dit Based Mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lukas Johannes M=C3=B6ller <research@johannes-moeller.dev>
> ---
>  net/bluetooth/l2cap_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ad98db9632fd..f8ed03095592 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5424,7 +5424,7 @@ static inline int l2cap_ecred_reconf_rsp(struct l2c=
ap_conn *conn,
>                                          u8 *data)
>  {
>         struct l2cap_chan *chan, *tmp;
> -       struct l2cap_ecred_conn_rsp *rsp =3D (void *) data;
> +       struct l2cap_ecred_reconf_rsp *rsp =3D (void *) data;
>         u16 result;
>
>         if (cmd_len < sizeof(*rsp))
> @@ -5432,7 +5432,7 @@ static inline int l2cap_ecred_reconf_rsp(struct l2c=
ap_conn *conn,
>
>         result =3D __le16_to_cpu(rsp->result);
>
> -       BT_DBG("result 0x%4.4x", rsp->result);
> +       BT_DBG("result 0x%4.4x", result);
>
>         if (!result)
>                 return 0;
> --
> 2.43.0

Looks good, but need to include linux-bluetooth so CI can pickup and
check if there are any regressions caused by this change.

--=20
Luiz Augusto von Dentz

