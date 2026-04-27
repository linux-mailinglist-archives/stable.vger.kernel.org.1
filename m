Return-Path: <stable+bounces-241245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N8THqIQ72mU5QAAu9opvQ
	(envelope-from <stable+bounces-241245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:30:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F2746E5E6
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 819B3301C166
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D764E391855;
	Mon, 27 Apr 2026 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpS3UF/O"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F3E391831
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 07:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274825; cv=pass; b=s3hzBYr3mysUfidjUZiIcQiMFXeRy3W0S06bmDS0hz2TQ654z9JrbcXu6z5W6tX6pIRRc41uCq1dnACfpSjyrbgx3Uyd9iuX5Icy/LB5+CJ1zOJwF4G+Urnm8bEb99/5ATg3ZF8oy0B13RVXOEuxrHAqT8/i7OjRIyBajk1BGMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274825; c=relaxed/simple;
	bh=wWnvxXUL3hfoN7ZWDBViCdW/iRUK+CGFaWMBri4GAOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwGXbyJzKITb69iCPjyOh0Vp2x05JYYdRLZrlyx/uXiJtcYNU0L/1cL36Zbhsbaol+v22D9jc6MRHfK+xRDwg3hIxDzoCxS1u/QpSuBiV5C3qKW8boHzk7nVYvZyUs0sEVuurFbHoA372zWmBRMjPSf2xbFjBXsfXQBpIX6VV7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpS3UF/O; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-651bf695701so8292180d50.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 00:27:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777274823; cv=none;
        d=google.com; s=arc-20240605;
        b=If5kKrvflNapHJYzJlfb2Ym1UKb84YQ1H9sT69HmAIT/cZXZ/gb3dmmDBTQav16K8J
         j0xUxjeypN0hJquiri7WxmdmtOisZBaj9HEtpM04+f/2dY3FjmUGfpOFmiKk8xZuV39V
         0XqtJqt7cMYUN2Pu6nYxwy+2H6r+AQiLMWlSf6Im/y5awa+UKBXLZoqjBokdgMreYJoQ
         YjEoBEMCS+oCiZSi1pE01PoxfSsTjl28uCNNkZ5miXVZy/QJ24Eftths3v7jRSnLQODe
         NeZtDnZSULvbyQz7yU2nJ0PFtyonfHLMj8QRMIwFfU1f8IdQYWGpBLPYIRtk9+7X7Fxt
         ZXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7kUhTkdHvc3oY/y/iSAnX1xxIUfgWoxWMmlhyEq3JBw=;
        fh=mS3IjmeM/UoHN1KVwPlKwbgu3jCJpIMd4UqBq4TZVMI=;
        b=cqjpJS0Xkh8I+IgViiTNVGeXkZpGWzRZA4mxgSqm/cB+BmDIlkBZHpN+xson3rldH7
         B5lQ0WUWdAIAp0GoMIN7ppMoN+K0fmZi+gJnN+wX9lx5F4OkED6HlbqEvHyl3gOLQoq4
         atDEjWptty75txOxXPwNp7HJV0W4WPn1reMqllKoE2TgeK9PA0cgSl7FzADsPScE5f8P
         2s2v0Li3Zx+7pjz2zbm4lpod31EVuASw3W3Tp7l/t70qrYEiaUL2Uzj478RZvqPEE08q
         lIcXvzeN57X0LX7y/fVcpndngwW9DxEVGxoZNTNc9BcxnF//BuSZkdVY/BmG2881XT4a
         Bkcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777274823; x=1777879623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kUhTkdHvc3oY/y/iSAnX1xxIUfgWoxWMmlhyEq3JBw=;
        b=mpS3UF/OUdOAAb8FECauqUgzH9WGqJ+0ouXzyn3L5yT30wG6O5f237e6IglGAV/bmx
         Of2U28lLBFVT+UlsDFt3zy1fGfFElgNCiomyhcKxNlyjymaJZO3yq/pQWcKd0Coyblal
         vaL/Thz6ihHKTIDxZlTVzkTU/6JL0kFx9xJ8tSbPaUJFXuWPNZ6WVWXm/0Q7yxOjeAG/
         ZWjqsJXcuQ+4lZ3eL3OMW+69tc7AtEuWjadWP8/wt1PkUwCEwQcWvIw/YDZcGQ1A1Ua4
         NLwwol83/3oSBzbpsDjr0OZ5Z6J0vIpb7rmSrz5VrJsjs3iwSCr9lE3DH4tcFfDyCgLq
         3H2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777274823; x=1777879623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7kUhTkdHvc3oY/y/iSAnX1xxIUfgWoxWMmlhyEq3JBw=;
        b=SbRS/mpAWF8Igqkq7tym/P+hOQoT79Usblgmh5rUq1tYYSDu+GURI8OiwS8wLTyIvw
         Artz+oVU20Se4CTIIZPIFFCeKjzK0lIu9u+aYjzVDCq7N9I1qlfn0OxfvM5Xi+9TqEEU
         hmH5WpmXSnr3oViFZj9IfY3RLscZdXJ/1KQ4Uo5P3+9A58lg6RSpNKhT6ogRV7n7EX5L
         GwP/fombP3Q5g94Jd2UojK29w6r3sOxrXGJGfroS9LxoKVExRFQOb11tVMPV6DZJc9/c
         ceym9yD8rKs1624CQE6+LD92iTwAaZhBeQXVS6g6GfYVVFwH9DSU39ogO9y3gdohmCHU
         8S7A==
X-Forwarded-Encrypted: i=1; AFNElJ/ik1+I+S2N2XzPBX9Njk3fOsTDvtOoYBNPcCCAammKFxutOxqtOvIvEnlhXgqHa14yifxiDgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEVP7X7+I7YwXim3EdNxi4jnb66aejlIOqKTdisKzgOWlJ/8vG
	hnvtqVaTrrJa+8wesL3hW8eG2YFnIPlgNYeEJQOfie2LYbn+WUmcomXh2rYQJSMqsDl6tzp6Axo
	WNR7mLsLDEoc6P46zhHqbGbx/volJwVY=
X-Gm-Gg: AeBDieuBgr3Kw24+3eZP/BqjwrhoJG+nYKSbexOwFG3hc8ekM12NBWn8UxhFhrRgZcg
	GElD8XTuloIzcFAIbMK1bHUtBk591EUPuFVIWENADbBieRAHDifxmVQQVK3TLFkRmxXG3slVUD6
	W5IuiJR4qsa10D8hjrOnmPspnd+pEBA4n0uRA0I362FNepIQxVKpJ8Mn2MhmBQG7lLTjpkIIHbs
	/HzzcbEb66QswESRLBEd73jJf1K6ibWCPpTMSVkTAqGt+xiMt0UNdtBICNtGQ/3jHp4DOjVDGjs
	gmv2yOASkEyFsOIoFW4=
X-Received: by 2002:a05:690e:13ca:b0:64a:d479:bfbe with SMTP id
 956f58d0204a3-653107e1fffmr37750335d50.11.1777274823339; Mon, 27 Apr 2026
 00:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310024305.555408-1-james010kim@gmail.com>
In-Reply-To: <20260310024305.555408-1-james010kim@gmail.com>
From: James Kim <james010kim@gmail.com>
Date: Mon, 27 Apr 2026 16:26:51 +0900
X-Gm-Features: AVHnY4LqeV0YZVawJX8Lx_yiM8UhsDDdpU6nTKCbtsDJT8mHu5loXzktWCz1VJE
Message-ID: <CAPdMtfesMMAjZ5gRoOomPepmn=V86NoiFYVuiRaEXhxwzNSx_w@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath12k: fix use-after-free of arvif in assign_vif_chanctx()
To: jjohnson@kernel.org
Cc: quic_srirrama@quicinc.com, quic_ramess@quicinc.com, kvalo@kernel.org, 
	stable@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F3F2746E5E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241245-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[james010kim@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi,

Just a gentle ping on this patch =E2=80=9Cwifi: ath12k: fix use-after-free =
of
arvif in assign_vif_chanctx()=E2=80=9D (submitted on March 10, 2026).
It is a small, self-contained bug fix with a Fixes: tag, and the patch
still shows up as =E2=80=9CNew=E2=80=9D in linux-wireless patchwork.
Please let me know if any changes are needed or if there is a better
way to route this fix.

Thanks,
James

On Tue, Mar 10, 2026 at 11:45=E2=80=AFAM James Kim <james010kim@gmail.com> =
wrote:
>
> In ath12k_mac_op_assign_vif_chanctx(), arvif is obtained from
> ath12k_mac_assign_link_vif() and then passed to
> ath12k_mac_assign_vif_to_vdev(). Inside that function, when the
> target radio (ar) differs from arvif->ar (multi-radio configuration),
> the old arvif is freed via ath12k_mac_unassign_link_vif() -> kfree()
> and a new one is allocated internally. However, only the ar pointer
> is returned to the caller =E2=80=94 the caller's arvif still points to th=
e
> freed memory.
>
> The caller then continues to dereference this stale arvif pointer
> at multiple locations (arvif->vdev_id, arvif->punct_bitmap,
> arvif->is_started, etc.), resulting in a use-after-free.
>
> Fix this by re-fetching arvif from ahvif->link[link_id] after
> ath12k_mac_assign_vif_to_vdev() returns, since the link pointer
> is always updated when a new arvif is assigned.
>
> Fixes: 477cabfdb776 ("wifi: ath12k: modify link arvif creation and remova=
l for MLO")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Kim <james010kim@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless=
/ath/ath12k/mac.c
> index b253d1e3f405..ee44a8b59e9b 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -12069,6 +12069,17 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee8021=
1_hw *hw,
>                 return -EINVAL;
>         }
>
> +       /* ath12k_mac_assign_vif_to_vdev() may free and reassign arvif
> +        * internally when switching radios (ar !=3D arvif->ar). Refresh
> +        * arvif from ahvif->link[].
> +        */
> +       arvif =3D wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
> +       if (!arvif) {
> +               ath12k_hw_warn(ah, "failed to get arvif for link %u after=
 vdev assignment",
> +                              link_id);
> +               return -ENOENT;
> +       }
> +
>         ab =3D ar->ab;
>
>         ath12k_dbg(ab, ATH12K_DBG_MAC,
> --
> 2.43.0
>

