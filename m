Return-Path: <stable+bounces-231269-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KO7Mj3UymkOAgYAu9opvQ
	(envelope-from <stable+bounces-231269-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 21:51:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D45D360A59
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 21:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E68013012524
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 19:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD27239A7EA;
	Mon, 30 Mar 2026 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7EKWLRB"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0A8334C1B
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774900281; cv=pass; b=e18ru5rDsBZNlNY8hIewK0gHfNgx0bv3SkiWyFzdXqQWQ1vz4mTqWC5QpDDefjfSWDiZ7WpS6ZFpd06TzLW36aGgv5jKCw6mQ8ndWnM296gFZjcjd1UbNYMrGMrIji5v4/FV0r03ueX6slGcda7krlOnpE9SqqgP06onBzbMOo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774900281; c=relaxed/simple;
	bh=XFJO2FiqDjQ+65cMKQQnolCljbLx8VyXTGABvPVGFgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWHQsijnpI1sKPBBuqUvxGdWFLD49a1XN/vKdOmt5/6CCsFLs99gd+Lj0K337l3Ml4uybTohOoTyVNfBghIYX6ym7CvZDv8Kd6BXR5R1O9pe+YM4nEWaxtUVgFnLCQDpldOzCEIFVIPvO2+KO4xxVG2a6Ae9hx+f2z6O7kpfKYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7EKWLRB; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6501547d7edso4049329d50.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 12:51:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774900278; cv=none;
        d=google.com; s=arc-20240605;
        b=NhnOMymjYWpv5J2CoG99KXG9qlgvDOU6r6CJzLdEa3JX+xh/8bvrV2offqT63LDU8L
         tctyTjRwykib/Ke6ibNTtF3LLilevr8PRqixwq0E3BpwH2HEDuskBRQHBdE59F6hoxfW
         j2HYNHCSvUoP01vjymeQMhVHOLSbWUFnJLvcWjWDka8evoxD2p0AN/muzA9Cu7UxWjGa
         G2dEyiV5xISyvqX5GC9labaaeUTqZeQ3n1+oxmdIQgAYbm2iRa/qR+VtC4ZRVTai5PeI
         1CxkV4TA3XzfHfDgUXFP1mSlNDe5gre6oZ7mOD3IDOXl8ktdWw8YMU+f64uODy8GM+R3
         xeJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XfKNvyS7K49qe0UCAo+yyDfQl89msPOaI9UN+hDNaDA=;
        fh=6KIyFaCuoQ4UthQFlHtA6mwlmQNVb38Wf/tJuqdBYAU=;
        b=M8SsEUQlQEJDTAj8vHhdeVrornqHRn1iH9hvmJJ17qh03AfKOdOFBw7Ig7l8oweEuw
         7A8lIOPOOOA0lPGi5abxNsVrviKI9c4QuEyqEyOhtGZvk12Ni8QzAtO0UU/jG8bxdDwg
         2TSLSIK6OWvrTxZiiWnq8mKHwZQWw3dK+ZH45XD9uI57r//EhH6nYMTyQeCtLMMXGbQo
         w9KuIixItYMTeVEv3RUzV3RLm8XGw14wTIrattPvBtbWKhAl1yGp19UlPvskFfzNKnrw
         G+ojHDo3OWDzL/XT+t9j0OogcqI2zxvAAqacjP5z6JrjbhUH8Y+S8Okly7mB6R4cEZgq
         6rTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774900278; x=1775505078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfKNvyS7K49qe0UCAo+yyDfQl89msPOaI9UN+hDNaDA=;
        b=a7EKWLRBIAw3fGpKr+Y6KyKnN7LUnrkwd+9qSnFeNMIXvuGb2dFxPGmzk9RT0lcECx
         TjN42CWu6LjwAD6hlpsS4ZrOvDGQZghIZtWilo317SrMB40fdcR4lxvBLbuwwpW5nH6N
         IJ3y+GY74HWXg4NNCsI7PTg4cD3WVYy73MHtdVHLFoR/3TiIQbbYnpH1HDg4ZOIxQ21d
         L90QzudmnOUuLbwgaXzmvt5muVvSEDT/+Myjs/0HH3oaKQCDtxAFjH7EEygdeEOW7NI9
         BtWKjimARjDKYPVvPVYdpZ9noDNyZYhkK3tNhU0B6jEYEeXfUWu+3uhDxnbDAmqtIns6
         65dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774900278; x=1775505078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XfKNvyS7K49qe0UCAo+yyDfQl89msPOaI9UN+hDNaDA=;
        b=P4nQAmr5tTYzhwn3MGjnzkmrvpP0GcrOpscL6Mg2UReMvtDNb7mKwXJAOcpQ8WAFve
         b7S301Uoa6rJOnJDsfP69dz+5r1+V55NRJoXMRrDSGUp0egUeyy1KgBmCWvryF2chEKZ
         1rXx25HcgZqAFLRcH0OL5BE8pqJQk7umDHfhxMVbF1/fw6xPRexJxPWbcQHvUpbwxxze
         bHTp9mWVVxuuokRcX9AcV7eea7GC9hqHHqVKFEm8Q9wD1OVDxEhcpgy9TpXp66sJ8zvc
         RQzckYCdFgAujWa5ZJZvhYOxypqVVBC5nEEd3lxQ0IjulLz60oWg1ztD56XCidcPVo+X
         MRcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3hznrLslzBLOfXpa5tlT9gXbTT25VN3ur+98JCG76L8GF++mbO4R1i0mjsgQ5oJEfBNi5LiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvDWxAfnB9avJn9Bn8hPf2JQcPQsbjgGPrPGriFr6xInaKW5Xe
	VzkuSDNEUvQr95MKP84gJB3o/4uVp3RkUDz6JDeqHQ6hSoUochilmmUTArmaRENiN6FVQZurdf/
	5en+aDeYgjLrJ9QP9zzyLGUYFLmPSRAI=
X-Gm-Gg: ATEYQzxclD+CJmHwdfOOYTh5IPVdda17bg4ks2Z2B8SusXFo/XIe4TkG05VR7AyZYly
	bQX/fUHeZXtRhcYPtToz3bhRGiRv/XNkwXY6Sd/TGGB/ztJ+3e5IeCTewB/E1QlKwpxSw+zbjQv
	ITtU15/8QoAwQwPbudelyWkdMVk0nXApM9Npy0y01jHwamdYu6IakhKqW3llmNNFbltcS2ife26
	nCbO/hRLkd6fwQFZCB3d9yfMcvtGWl6r23EpODMsiZWlxpwO+v/hqbZv2+ax/2FHUWKVDR62t+0
	UTkgbLkTuYKN99r0CQ3e1er9D9KVVr5hAzXcKppQaGXp2epK0X3JS12P5UCiwY/loto=
X-Received: by 2002:a05:690e:1c08:b0:64c:a894:f723 with SMTP id
 956f58d0204a3-64ff7027e97mr14084881d50.0.1774900276530; Mon, 30 Mar 2026
 12:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKvcANPiqdO_Re3+06DWhb7uyKP+gCODJpo35sq5-x62gYJUPw@mail.gmail.com>
 <20260328200938.140528-1-xiaoguai0992@gmail.com>
In-Reply-To: <20260328200938.140528-1-xiaoguai0992@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Mar 2026 15:51:04 -0400
X-Gm-Features: AQROBzA6KBl4EzkRU6poaG_SGJBRNepQU1Vk92F_42K5UY1gfxCQ9I_0GrAfF_I
Message-ID: <CABBYNZ+8UW62Qot6=ev2Mf-Kc6JgJYtxh0B3OdV2zXJx=N0m1Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: ISO: validate ISO_END fragments
To: Kangzheng Gu <xiaoguai0992@gmail.com>
Cc: gregkh@linuxfoundation.org, marcel@holtmann.org, luiz.von.dentz@intel.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-231269-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 5D45D360A59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kangzheng,

On Sat, Mar 28, 2026 at 4:09=E2=80=AFPM Kangzheng Gu <xiaoguai0992@gmail.co=
m> wrote:
>
> A malformed ISO_END fragment can trigger a NULL pointer dereference
> due to missing validation before processing. An oversized end fragment
> should also be rejected.
>
> Add the same validation for ISO_END as for ISO_CONT, and reset the
> in-progress reassembly state when malformed input is detected.
>
> Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kangzheng Gu <xiaoguai0992@gmail.com>
> ---
>  net/bluetooth/iso.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index be145e2736b7..8707f3c4b103 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2587,6 +2587,27 @@ int iso_recv(struct hci_dev *hdev, u16 handle, str=
uct sk_buff *skb, u16 flags)
>                 break;
>
>         case ISO_END:
> +               BT_DBG("End: frag len %d (expecting %d)", skb->len,
> +                      conn->rx_len);
> +
> +               if (!conn->rx_len) {
> +                       BT_ERR("Unexpected end frame (len %d)",
> +                              skb->len);
> +                       kfree_skb(conn->rx_skb);
> +                       conn->rx_skb =3D NULL;
> +                       conn->rx_len =3D 0;
> +                       goto drop;
> +               }

I suspect this was not quite right:

https://sashiko.dev/#/patchset/20260328200938.140528-1-xiaoguai0992%40gmail=
.com

Have you actually validated this changes against any hardware?

> +               if (skb->len > conn->rx_len) {
> +                       BT_ERR("Fragment is too long (len %d, expected %d=
)",
> +                              skb->len, conn->rx_len);
> +                       kfree_skb(conn->rx_skb);
> +                       conn->rx_skb =3D NULL;
> +                       conn->rx_len =3D 0;
> +                       goto drop;
> +               }

Hmm, this is the end fragment so anything other than skb->len =3D=3D
conn->rx_len is unexpected.

>                 skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb-=
>len),
>                                           skb->len);
>                 conn->rx_len -=3D skb->len;
> --
> 2.50.1
>


--=20
Luiz Augusto von Dentz

