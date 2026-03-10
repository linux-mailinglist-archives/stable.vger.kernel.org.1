Return-Path: <stable+bounces-224549-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MN/5GS9qsGmNjAIAu9opvQ
	(envelope-from <stable+bounces-224549-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:59:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01361256C36
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00715306B5A4
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FCB2DEA6B;
	Tue, 10 Mar 2026 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy06u7wf"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6ED3164AA
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169184; cv=pass; b=Sar7yKRuL17gRX2Tp6wrP6xZcj4BFpawr7eMtAoJe/y5PaWjnDjucWQLF1fI20+0Vrn/CDGStBXFhthdH207MQ2kB6MEt5SChbxOqXErXIKcXBqYMsDPPYFLfPhxSp+buAcqg+YBxRvudDreTahtefFpfav0LcFsfqieVxFRtGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169184; c=relaxed/simple;
	bh=SVV5I0DCGb1WfqPEfMxm3ePeH5PlUcoDO7f1tguwqFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wc++5XUTdDCci59ERwVjSrUW0O01sDPveWuo3gbTsSMVZG9hUXDeW/o4L+b9NcfRLFOIE1slpuSer+h5U7z9mtjbzkc8c9GdnqXusaZyjPYPOtxHWsq00nGymC3Njlz7V25sUKDCxLzkqSHi+XygH1WoojPJdOntu1vb7Gv8y2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jy06u7wf; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64c9ebd1369so12323250d50.1
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 11:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773169182; cv=none;
        d=google.com; s=arc-20240605;
        b=iY4R0XY0M0mIcr8Kr04IhcwAwVWPCcjYkm4gPjJX9cCefApI2Z1I89kujKQ1iwe8AC
         KlydpAVXeimfSV9xgdLgGG02VUP4FKcE6Z2R4tpGq6I2ps9GYhXTGIYWoL8iWjztTU28
         ovbE2MdZIujaq4UnpOlZNInNgEznwfW4e+nn51G5tYWlPyVOLBbQv/+mw43iZZ3qtZKO
         m5FWNK274hYSJF8Pcg+Keu4tF8moAabd9BD8nadLl7Q4yTfhZsgmswynwZKhbFDZR1qg
         QDdxFot2Jgg4X8vQDdyWcgAM8RMr1SSig+OyzdT4CzNpxKis7l01OCXRffLyK9wXuRUE
         Xusg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yK2vgP2Ol2PbauKqyLE85mwxhK1bmGg6t2FLzw4aS4w=;
        fh=9Bi6aCmgG6K6oX4xV9XI5hdvwKJYIU9XsUc1hw9u0Iw=;
        b=jx5ioyAd4faAHZ6S/WG6dI04PvH7bxy9WnKPdX+hkHSW6AqOdr1AL3oz6tQwnJkO8L
         j94mM7shopVaZOQ5a+tctFX6/dzugqvqG9orY0yJ1vF4ZJJczAN2C6kWL1gc7xQWI53t
         zAB+xMy5zxrZcbVgDpoxhiFNP+uikR8e3r7dj0nI4XVTJdoU8+OTm/DlaDJD51VH+cV4
         zr1xaHU1jcX8Ehz5XuHYcKtvB+ag+thjG9dEFWKZoYVKKCSTCvB7RA5FDJI0F4kA9lEd
         GDVMhvODOl8mey08PwUFPnFTUoBxkUouzVl5o15OfCE79z5bYWls8/NElIyFdHiohLqR
         JeSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773169182; x=1773773982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yK2vgP2Ol2PbauKqyLE85mwxhK1bmGg6t2FLzw4aS4w=;
        b=Jy06u7wf060dinoEUlnXBAZKmjPzu9ZPi+OlaS00vqceGIPDgHan3vRqgTGJRbAUbV
         68Pqj0lSFx8ZahcdJ7IJNNDjEjoDaKaTPk3KhIB3gontcsmEBC3zFmC5lGl0a30LhUgE
         GnKURDgI6Vn+es0990jutAitI2Rarxm3bhDSehAjkbLSq6GROvqaoZVmyeQpAnwG2URf
         zEI3Pz6Qk1kvrKqhKkJQeRJG1FeFrGMdbT25qv1emIHFSiP7VmHUhq2v80EYFh2Cz3Ew
         y2q1H1JJQqviRMCbFNhvd9ySRaZ+TaCxWh4jpt7Hh7V/B8ZveIJZxyUXt6kxPttkFx58
         QtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773169182; x=1773773982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yK2vgP2Ol2PbauKqyLE85mwxhK1bmGg6t2FLzw4aS4w=;
        b=rpU9a4T6jy8f2ppiBz/4tlwyPRXc9H3GsJoZUXO5vcogmyoxdBYFd6dgBz7YaqLl1D
         tcxJ0GN7jsQl8sRghDZDxPN7QEd9h/4VsP2Dxpx0odTuWKtsEZ/4wz7aEinVquLPu1Gh
         ZqQhJgZhriVwSYmWVhMSkGTpTGr+bwrOMuZqbH9wvVPJlu9T19Ck35vkSMkdN8AvgF9V
         K5Va/6UGj9uLBogFrX76tl/OJ0/6DAstkeY1/GR4PTIf3NrrCfyOq90khIvPiAZSGIgT
         c4iijlTnRiHJd04Pqu2ry8/g8ZrF+W19HjIVDf6AgF+310KhJEpbMev5PKLLwscRMMUf
         f8Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUJDKtcOPkJP8i8/HcgpuTnkNwwriUhFU0pZY3VDdyYMji8rpnICeNNUPlO0Xqh30zuVXXGQ48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOMLDU2J3GFEam+8uCAMUQaZfhX6JrgmWaiR+YoPjB8XuRc5IO
	0b9/hyefPkX2acM53ndgYW7D2LUr15pQHhDl4wHcMADkJcl5sXXJ2g0D5/QU12mqseQm5/xICaA
	B/VJ2+ATq3oYhI57b6JotqdvFtyP9yuQ=
X-Gm-Gg: ATEYQzwNsZqyILTuPySwWxsHBU3hl9nqNoyCm8Q8gekjKHwtdlzcIE6bYrXr/EQYxiB
	OH7UyITgOB5u755fqlaYbiCwJl35WhiHbcNdWoBjKjTFOF/3Z1GZmuUEflE02ew/XLHZ9zBhVCc
	lzcCNQNP0wd0rDQT4fJko6jd7UDjHGsyroKxE5VzGrYXHoaj+nAjoXZQwyBcSsKYBTj6Nw/P0Pi
	60KeAFTzvaS358Wxzm7hLrmpOdyZBVa78qpDzRpl5Iy+lmAV2PWKCu30PPBUoWOkqMcOH6hca3i
	CiJ9RjxgQWsoq5arVfkdfeExGStxdI3/DsobKEGt5FvIMBL7hkK/GpQzkvOif6o1n7c=
X-Received: by 2002:a53:acc8:0:20b0:64a:e7e0:a717 with SMTP id
 956f58d0204a3-64d1418526amr11769742d50.37.1773169182504; Tue, 10 Mar 2026
 11:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abBJTIQolY8l0fxW@1wt.eu> <20260310182831.131781-1-research@johannes-moeller.dev>
In-Reply-To: <20260310182831.131781-1-research@johannes-moeller.dev>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 10 Mar 2026 14:59:30 -0400
X-Gm-Features: AaiRm50oEJkN_1L843cRuDr7Id81RZuUVBTnz8FWkgYB5JId6eUfvRUmuT_6n0M
Message-ID: <CABBYNZ+qqAD-Xgh=_NrpXj8DsmP3fc2Nf8oJWqc+U3db=j_ETQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix stack buffer overflow in deferred
 ECRED connection response
To: =?UTF-8?Q?Lukas_Johannes_M=C3=B6ller?= <research@johannes-moeller.dev>
Cc: security@kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com, 
	w@1wt.eu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 01361256C36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224549-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,johannes-moeller.dev:email]
X-Rspamd-Action: no action

Hi Lukas,

On Tue, Mar 10, 2026 at 2:29=E2=80=AFPM Lukas Johannes M=C3=B6ller
<research@johannes-moeller.dev> wrote:
>
> l2cap_ecred_rsp_defer() appends channel SCIDs to
> rsp_flex->dcid[rsp->count++] without checking rsp->count against
> L2CAP_ECRED_MAX_CID.  The dcid[] flexible array member is backed by a
> stack-allocated structure with room for only L2CAP_ECRED_MAX_CID (5)
> entries.
>
> Per-request validation in l2cap_ecred_conn_req() limits a single
> L2CAP_ECRED_CONN_REQ to at most 5 SCIDs, but multiple requests can
> reuse the same attacker-controlled signaling identifier.  When
> __l2cap_ecred_conn_rsp_defer() later walks all channels with that
> ident, the callback writes past the fixed backing array.  For LE links
> (SCIDs 0x0040..0x007f) the maximum overwrite is 118 bytes past the end
> of the buffer.
>
> Add a bounds check in l2cap_ecred_rsp_defer() that cleans up excess
> channels, and reject incoming requests in l2cap_ecred_conn_req() when
> channels are already pending for the same ident.
>
> Fixes: da49b602f7f7 ("Bluetooth: L2CAP: Use DEFER_SETUP to group ECRED co=
nnections")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lukas Johannes M=C3=B6ller <research@johannes-moeller.dev>
> ---
>  net/bluetooth/l2cap_core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ad98db9632fd..a0b56fb0afb0 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3833,6 +3833,12 @@ static void l2cap_ecred_rsp_defer(struct l2cap_cha=
n *chan, void *data)
>             !test_and_clear_bit(FLAG_DEFER_SETUP, &chan->flags))
>                 return;
>
> +       if (rsp->count >=3D L2CAP_ECRED_MAX_CID) {
> +               chan->ident =3D 0;
> +               l2cap_chan_del(chan, ECONNRESET);
> +               return;
> +       }
> +
>         /* Reset ident so only one response is sent */
>         chan->ident =3D 0;
>
> @@ -5132,6 +5138,15 @@ static inline int l2cap_ecred_conn_req(struct l2ca=
p_conn *conn,
>                 goto unlock;
>         }
>
> +       /* Check if incoming channels are already pending for this ident =
*/
> +       list_for_each_entry(chan, &conn->chan_l, list) {
> +               if (chan->ident =3D=3D cmd->ident &&
> +                   !test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags)) {
> +                       result =3D L2CAP_CR_LE_INVALID_PARAMS;
> +                       goto unlock;
> +               }
> +       }
> +
>         result =3D L2CAP_CR_LE_SUCCESS;
>
>         for (i =3D 0; i < num_scid; i++) {
>
> base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
> --
> 2.43.0

This is already a similar change under review:

https://patchwork.kernel.org/project/bluetooth/patch/20260309220343.190372-=
1-luiz.dentz@gmail.com/

--=20
Luiz Augusto von Dentz

