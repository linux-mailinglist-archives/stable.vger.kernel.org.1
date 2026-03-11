Return-Path: <stable+bounces-224714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBL4Ar+VsWnkDAAAu9opvQ
	(envelope-from <stable+bounces-224714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:18:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7632A267321
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AB2B306BE04
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9893DE421;
	Wed, 11 Mar 2026 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O09NTyG0"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFB133ADB3
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245704; cv=pass; b=VFLoVtTHZwGkhTi6+sAoI40RvjEL+LfTB13e1fvVm5aRvodI78494KU0bKQij5uQwjQa3O2I1xaAjXF9zcnvtgy9L32Hoz/i/DmDd5TrbgoL+oydBj62wkdasPB33LU5fq0Wsfwm4+V18925mZ3rws6kOjlSMTnAzZCmKyEU4ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245704; c=relaxed/simple;
	bh=f5SMFqWfUYTCaiNaIPiZttlPh5sNP5Z5fPIqBYGPN1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mc0MktHEDECQmYJSRTtQxmmtSfP/Onn2vtJ3QUsZEPsiR5U/m6dofBuMmWg4FlGsSIVj6WaTSkbVJiSzc5XgErA8FrA3FoH4K5U7wz6pxAWTVh1W7/Ur5dwS90Ba5WqYSuNJpY1e0YXSKgV9UzBp3Gov1h+gZQ/3Zy6FnUaEuyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O09NTyG0; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-509061dab77so122761cf.2
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 09:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773245702; cv=none;
        d=google.com; s=arc-20240605;
        b=SM7U4OinV352BiDszf2QL3epu2/aqICwVLwkGCWWEqYXo6SeBblGhKJ3295b96Y77O
         5ImMXhjBfeXgiOcDrnSUTMePKURRAzv15StxPlBBPQAvROJjdc0v4cVpBBN1OPecJrNA
         MuyNmAgeMVw536hdhlSeW3mEtI/c61f2QBiaZ/Nr43lA+zKCOw2tmQikcdSDsyUWiQkP
         6RtjUajPlstWRLmL/aHf5QyZjmH/ol4ofKnpJwriePHTfXkAFXzodvCoPZHiNCrHzMgO
         gVtFVmHE13EjWjGyEqbnrblp2yXk0KxDnBTh8iyES4+wvgbnzdYN+Hq0RyidUpM8AhxJ
         tm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7N2W7yYjM2zRG3DC8FowUvkEvnAbADu41ZCuJNvKKrY=;
        fh=FNIhcXtgqNv0fk8uEPGIWQYMjiPquDMOYnhLipr3ATw=;
        b=Q0U1bNMEDsryS8WGXHMPZGJ3EoYtx2uesmlPBCIBM3tEleNxT1MC64RNNGyz2HSRTZ
         FNmouE8e/clYt75ahD6wl9o5wJkFRvefECiYYVup4uZm8vnd2r0Q0KERMPXGxSVmAq7h
         DlmNIamT6aVGyN0Kw44eH63diUyaiaN4bgZZv0i9zEQL8kygaGa+al98eLf6R3avKIin
         H3p7Fn1oLqviLNArB2EvmkJ2BFZDsFvBYNqUF5omYRx8UsB5+3/7MF5Ylx+/E4o78OR+
         EBew6QrN14TXoHK67Yh7hfnh+MbsvZub634GdDeVKMAwWEavWXZXa/wccIUvtPurCI8+
         Cp9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773245702; x=1773850502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7N2W7yYjM2zRG3DC8FowUvkEvnAbADu41ZCuJNvKKrY=;
        b=O09NTyG0pRzC+S+XbQe+Ztt5cCKq7905HbRZj6Z2kvtw+QVLPcF3s90KN2nAvwOtpn
         pYwKmiM0CCDtZl9nJsjQB5+FIbzalxS58XEHywN4YyfqFW1trRuc4K2O/HLSouWB0eMQ
         DOfqn3KepbALMayJPgbBUBGKNrRdoX6FRbHhml3SGDeDynUW0Hx3p3Zk1gtlrSNNRqrG
         HJkIHzcZJNTWQT4ivx5D9gBBqeUHX7Pfa/KHkG7RxcsG8I+bHzkp/ej/5i9kPHHeuHZv
         QLOIZyzd06ACdIT6qe3VtVP/E/H7VFynIvKRGe3SfbgoZ7Tce1weNgVTjKI1BiLms33e
         JnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245702; x=1773850502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7N2W7yYjM2zRG3DC8FowUvkEvnAbADu41ZCuJNvKKrY=;
        b=EStqesOXp/eaGGuMAjARkct5IaGpxUslPjI3qaRC/E+2d2JvTxA7fWm0Gz70wauM/U
         752unXUgyO9wq7VOcnUX91cI29nsvr/Cyp1rBrxY3cjqpGg65Uy6rvXPRrHaBvlrlRk2
         9O1flJG4o/3eAyhHwedtytGpL0di3Tpt6ayaiTXxrgKo+22gtQvR3RG/MoWdUFxqcTUN
         fBu+7bbjFg8638pyG5u3xFKy9vFFhWdsyGecLpUSzv/KvRYHMUzPn8o13zzJWt2mWoJ/
         DNmH9JYH8pyA6s7CrV6CsTLTQehdGZP/5AkWU6pjBM0LMr2pz1B5Alb7y+4Ge+NZVkRj
         D/5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9n2sXqccPCeJG2ufEvShigyH9J8KPjewrVk3rbiIp1BorYeBR1qX0FT2TWDuOBSOXUOHaVXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2/MY+lalDMm4TS0+wSFmUtgYEGn3sRFFuHc1ql078pPvcA1B4
	emzgzZdP1LaBCQP6X67d7HllkoPDieExwHx5j1yubcYwM30742tQpIAhgddihDp1z1Da84RlDtj
	yoK2B9mbS2iW86ArBaEAqw2E85NCzPg==
X-Gm-Gg: ATEYQzwSlTbQ7lErUi0JNAEzBjXZPGEDBIAGY1pA+7d46gOcsTckgYX97U/BkAZB5cr
	uvmfaJSuqMs0qKjUZsmUs6aj6yZN4cYy9BdOtMMHC6USmB9rM/KIS+wSv6l8tYG/OUjzSosXT3o
	UR7e+euAEhBkTk7td20MSuM9aLBLuHjSaiw52zDhH9f6glXg6lEV0ahbRc+2sP/plsL+UQf+SZS
	RyLrp2FWpjSu5NTVqlGeJf8bEhEl/yOXm7qVQ3PE/HHkCl0AYvgtYTKjhZkwIL6EmaBr34FaURg
	0vQRwmvrGTKzveFeIw==
X-Received: by 2002:ac8:5f8f:0:b0:509:2222:4201 with SMTP id
 d75a77b69052e-5093a1c2b09mr36139601cf.69.1773245701913; Wed, 11 Mar 2026
 09:15:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311002825.15502-1-sean.wang@kernel.org> <20260311002825.15502-2-sean.wang@kernel.org>
In-Reply-To: <20260311002825.15502-2-sean.wang@kernel.org>
From: Nick <morrownr@gmail.com>
Date: Wed, 11 Mar 2026 11:14:35 -0500
X-Gm-Features: AaiRm50riU_uOb2IzOgK4aB6NSrm2_y0b6pNwKh9O2M9Qcys0qvy4wS0pXJ7QU8
Message-ID: <CAFktD2cbFJrLS4ggc+yf582BYmw=jJsntfbDR65ssMpVGM2BKA@mail.gmail.com>
Subject: Re: [PATCH 2/2] wifi: mt76: mt792x: fix mt7925u USB WFSYS reset handling
To: Sean Wang <sean.wang@kernel.org>
Cc: nbd@nbd.name, lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, Sean Wang <sean.wang@mediatek.com>, 
	stable@vger.kernel.org, Satadru Pramanik <satadru@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224714-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[nbd.name,redhat.com,vger.kernel.org,lists.infradead.org,mediatek.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[morrownr@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7632A267321
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Sean Wang <sean.wang@mediatek.com>
>
> mt7925u uses different reset/status registers from mt7921u. Reusing the
> mt7921u register set causes the WFSYS reset to fail.
>
> Add a chip-specific descriptor in mt792xu_wfsys_reset() to select the
> correct registers and fix mt7925u failing to initialize after a warm
> reboot.
>
> Fixes: d28e1a48952e ("wifi: mt76: mt792x: introduce mt792x-usb module")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt792x_regs.h |  4 ++++
>  drivers/net/wireless/mediatek/mt76/mt792x_usb.c  | 13 ++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
> index 7ddde9286861..d2a8b2b0df32 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
> @@ -392,6 +392,10 @@
>  #define MT_CBTOP_RGU_WF_SUBSYS_RST     MT_CBTOP_RGU(0x600)
>  #define MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH BIT(0)
>
> +#define MT7925_CBTOP_RGU_WF_SUBSYS_RST 0x70028600
> +#define MT7925_WFSYS_INIT_DONE_ADDR    0x184c1604
> +#define MT7925_WFSYS_INIT_DONE         0x00001d1e
> +
>  #define MT_HW_BOUND                    0x70010020
>  #define MT_HW_CHIPID                   0x70010200
>  #define MT_HW_REV                      0x70010204
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
> index a92e872226cf..47827d1c5ccb 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
> @@ -224,6 +224,15 @@ static const struct mt792xu_wfsys_desc mt7921_wfsys_desc = {
>         .need_status_sel = true,
>  };
>
> +static const struct mt792xu_wfsys_desc mt7925_wfsys_desc = {
> +       .rst_reg = MT7925_CBTOP_RGU_WF_SUBSYS_RST,
> +       .done_reg = MT7925_WFSYS_INIT_DONE_ADDR,
> +       .done_mask = U32_MAX,
> +       .done_val = MT7925_WFSYS_INIT_DONE,
> +       .delay_ms = 20,
> +       .need_status_sel = false,
> +};
> +
>  int mt792xu_dma_init(struct mt792x_dev *dev, bool resume)
>  {
>         int err;
> @@ -254,7 +263,9 @@ EXPORT_SYMBOL_GPL(mt792xu_dma_init);
>
>  int mt792xu_wfsys_reset(struct mt792x_dev *dev)
>  {
> -       const struct mt792xu_wfsys_desc *desc = &mt7921_wfsys_desc;
> +       const struct mt792xu_wfsys_desc *desc = is_mt7925(&dev->mt76) ?
> +                                               &mt7925_wfsys_desc :
> +                                               &mt7921_wfsys_desc;
>         u32 val;
>         int i;
>
> --
> 2.43.0
>

Sean, testing results from: Satadru Pramanik <satadru@gmail.com>

"The updated patches from
https://patchwork.kernel.org/project/linux-wireless/list/?series=1064695
do NOT work. I get the -110 error with them on a warm reboot.
Reverting to the kernel with the older patch restores my adapter
connection on a warm reboot."

You are welcome to stop by the Github issue where this issue is being discussed:

https://github.com/morrownr/USB-WiFi/issues/688#

Nick

