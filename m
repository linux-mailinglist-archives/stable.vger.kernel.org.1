Return-Path: <stable+bounces-253401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP4VMeg2DmpN8QUAu9opvQ
	(envelope-from <stable+bounces-253401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:34:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D8B59C1A6
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9472D310DBF6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59343B2FD6;
	Wed, 20 May 2026 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUqESv+n"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB3F2C11CF
	for <stable@vger.kernel.org>; Wed, 20 May 2026 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314604; cv=pass; b=fmoz+WinTwvS6F2R41E+9VTSQ8Dj5PQfhUaEkUqUuRI9kuw3W/57OHcLVuAsD7hWxtiOPrsl70MIeANuNcVwMzXuIBJjp6M/HKm+HLlJvmfoLwjsbdzI+L5PSrekQg0+GmKxC4WWeTbuwmt0CjTVnOZ/PSOjfV4CGXgpsExskRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314604; c=relaxed/simple;
	bh=hYyAEWQeadvM6XovVkhdPt+HnOAggUi3yfPoxwF/oQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkiFp7szDOhoasLRzG4pHXWmTfw7Re3l3KMIiNnl6dUf3b0s/fknrXyufXM8f7WcELmnIpqk/rk+QoinKgRfhTCZTcgKKrdo7cJI/CCYOdODJLDO4+xRTeRqGA6ts7jHEotp1DKdxGFOFxpGNLf1flZc1f0E2ZOwzBSIsPEDqP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUqESv+n; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65d071aac6eso4565326d50.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 15:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779314602; cv=none;
        d=google.com; s=arc-20240605;
        b=ULGx/m/18NCpXCIUOmoyDjtDZPxLfK6Dpvz3Jm7rf4BvDdmBVvYqQHxzT1YXlAyvi/
         YpcUIUasiRONSWlLNGSpYGiMeuqu3Xyn5wKbr0Asi8iGiv9T2eVk+Wlg5RDYmvoQKEFG
         aiJdTjlc2LUnzTioWSSqEddkC6Xjc3QhLcKoTnXc+jykwKQWN3qpuVZ+PDMHTLZ8IJE7
         XUB4BOAa1kEtKsNewlKcfu0YT3PaH8/LGltwbFjcdv/7+FAqlbIj68kgEBu6B/ImQlu9
         fZGWteSf31gXz4ocu+ejhpypDM0sCzmEa0RON6iTxCpIwYT3MyoKinDz2ykNMT/TrZRw
         x8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A/jMvDfBLv4FeAIfLBUVwZHVmH8wDPOnohCdxyOjuvM=;
        fh=Hv5J6hJVp+gsTSH6onRw3RPwl3Ny9sorDNYFzJZtUAA=;
        b=Kc86EmwafLU2FjRoOwiJM4mN9kW6MWW0wTEIRNJMcUOM5GCGh9yk7Wte3QkcktuqVD
         1gsjml3oRyo1n6ZHUQmKZYowsFM5JBgaJFcsnBw5N+eXIbMlYsrs5b5oUork+kAJvDbG
         wRUgb3vzF0zzKWSgY7fXx038IuaMdJYVDr4emVo+w5PbmwkG5PljQs9RhOiHm8ZDjVMO
         +EXaCRTKNXbYS9Anm/GSZGNN7NW/Ro6dhn2GWBbRhx8cJ/gOx9GTUE7lMyz2+cdhzbDI
         W3bHoWnSCLUQn4j86rQ4LMPYPoY5w5ifPnbVKF5tMpVYGhDKQkoWkcPE4BJkCIM6YP0B
         RsAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779314602; x=1779919402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/jMvDfBLv4FeAIfLBUVwZHVmH8wDPOnohCdxyOjuvM=;
        b=UUqESv+nXUISgVCqSMfa9UqsRkBH5PX0oV4c/9FRh1T1AEjVZfE2oRXrs0y1GQEmhE
         /FNjV3+21ZEn7nRmZqRerGjRUPrtkAGVCHXynCKw3sUs1Q6ekGkEshJ/mGWMdX5/GFeW
         D+LggCBADNckBTRnCF0R9wbFOGFjPPnckFvsbkMF25thj6ut7HK4DkIvN/uz+cAgYEWO
         r7ExIrRx0SrsvZk59EiHrXpUEPvHGwxLfCruroZ1mQBaJihoIJoVlA1+o8cVBCir2ti3
         0TA/q+HYrSU+nIDaujLlE1WxK1ESYr+yRWljkGcmdxHnm9flNoaFjwXetwVljTTWD2qn
         QHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779314602; x=1779919402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/jMvDfBLv4FeAIfLBUVwZHVmH8wDPOnohCdxyOjuvM=;
        b=Lbzdo+Zzg3VgQc+/X37erfeRks9nU1OIIWgF9bEpao+hC7SNXcmKe9vlWk89me6XXV
         AA++GujZ45jjOJ7eRHhUYgM631jWZUesyIGReHmSuWNED5gANViLYovYyVXvsmDQpHg0
         gJrfTLf8z7PX96fRgWj4GegnLjq+pBlR/DaHM4kiEE1GNcd8ozbu6pnYXVBaEa8Szt2Z
         c5M5eRkFz/egvgytkjLsmJL71Udsp3hgVRL75gejhd3cJybK3Va/w9dWrXpiIAW4fad/
         N0xRhTYyAnnoFLZLquRw2afaIEzDx49VRWCckbyysqmXlpSp8RZFuq2KwxDzUIjLDgy2
         bTIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+TR6hiQAPWJQmrOgufRWq7+2Cd0Ex35rd1V00mLGEkPETkx+d8UbP7PQMC/rufiHTz0E2ftSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXUimKp/VSzOw5DbBEEjohqsUHFxPF2O1k9P2uamNVoNMfiEYe
	f+QcxnNBYJ3H1NeyK9Kwl7a2rFK+hYHcuhjNJRfAKfOv2BGXDX4XugMsQsYw0Wg2tmu2SROEgRo
	fwF0W1eDwgjxkIdeMwR4l+zRpp8aQdmY=
X-Gm-Gg: Acq92OFY1wV1Hr1KGuCJ9dyf20yt4jQ2AJBSI2rdGo/7NkqsoIkRLvIgKxWGFBsTxw1
	bpEChs4zxKB2oUrYRAITwCEIDdz/e6CNygMEQwYwT9ka2rwfJx22xVsBIbxqHwK7Qpb32UZWoeJ
	GJ+T5NkMBOxttJKw2BMMQDhGWtlGyuyn3bmnB5tuc/rvwJiTuaaLsO/562UfyEL0QEF8v7meWuN
	120GciArsiaSvK/PberYIoYg+WXjJnzukm9cSl0BDugeP0cjahWtR7ciGPqPqz6hjqLJ+g/tb+c
	sO2gsEZdRHNDNF93JBrKbdQgz3JrkKshk1GxWrfK09WX0N//qU3Zn39ENcIDFfRQmwA6Wd/M8pf
	LrEJS
X-Received: by 2002:a05:690e:1582:10b0:651:c268:479 with SMTP id
 956f58d0204a3-65eae320374mr31086d50.57.1779314602147; Wed, 20 May 2026
 15:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517234805.116570-1-meatuni001@gmail.com> <20260520214133.27746-1-meatuni001@gmail.com>
In-Reply-To: <20260520214133.27746-1-meatuni001@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 18:03:10 -0400
X-Gm-Features: AVHnY4IDP4f3fU1q7OQm9ioU-LLNyCU5B45JUnyoa8UjzoNYgEKkpFTZQWC-6-4
Message-ID: <CABBYNZ+Oc=LU6d8_xK9_a9yk-TFyaE=0KsNvAwKbNZVs1EJpWg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: HIDP: fix missing length checks in hidp_input_report()
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marcel@holtmann.org, johan.hedberg@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-253401-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 05D8B59C1A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Muhammad,

On Wed, May 20, 2026 at 5:41=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.co=
m> wrote:
>
> hidp_input_report() reads keyboard and mouse payload data from an skb
> without first verifying that skb->len contains enough data.
>
> hidp_recv_intr_frame() pulls the 1-byte HIDP header before dispatching
> to hidp_input_report(). If a paired device sends a truncated packet,
> the handler reads beyond the valid skb data, resulting in an
> out-of-bounds read of skb data. The OOB bytes may be interpreted as
> phantom key presses or spurious mouse movement.
>
> Add a check that skb->len is non-zero before the type switch, and
> per-report-type minimum length checks before accessing the payload.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  net/bluetooth/hidp/core.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index 976f91eeb..03838a6ff 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -179,12 +179,22 @@ static void hidp_input_report(struct hidp_session *=
session, struct sk_buff *skb)
>  {
>         struct input_dev *dev =3D session->input;
>         unsigned char *keys =3D session->keys;
> -       unsigned char *udata =3D skb->data + 1;
> -       signed char *sdata =3D skb->data + 1;
> -       int i, size =3D skb->len - 1;
> +       unsigned char *udata;
> +       signed char *sdata;
> +       int i, size;
> +
> +       if (!skb->len)
> +               return;
> +
> +       udata =3D skb->data + 1;
> +       sdata =3D skb->data + 1;
> +       size =3D skb->len - 1;

If you use skb_pull_data, you won't need to use pointer arithmetic, or
store the actual size.

>
>         switch (skb->data[0]) {
>         case 0x01:      /* Keyboard report */
> +               if (size < 8)
> +                       break;
> +
>                 for (i =3D 0; i < 8; i++)
>                         input_report_key(dev, hidp_keycode[i + 224], (uda=
ta[0] >> i) & 1);
>
> @@ -213,6 +223,9 @@ static void hidp_input_report(struct hidp_session *se=
ssion, struct sk_buff *skb)
>                 break;
>
>         case 0x02:      /* Mouse report */
> +               if (size < 3)
> +                       break;
> +
>                 input_report_key(dev, BTN_LEFT,   sdata[0] & 0x01);
>                 input_report_key(dev, BTN_RIGHT,  sdata[0] & 0x02);
>                 input_report_key(dev, BTN_MIDDLE, sdata[0] & 0x04);
> --
> 2.54.0
>


--=20
Luiz Augusto von Dentz

