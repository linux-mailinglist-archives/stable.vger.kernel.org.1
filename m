Return-Path: <stable+bounces-241325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMJDFBRh72mHAwEAu9opvQ
	(envelope-from <stable+bounces-241325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:13:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E36D5473383
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C80C3006B40
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43A83C3C16;
	Mon, 27 Apr 2026 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T/UkDcqa"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CDF3C277C
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295632; cv=pass; b=eelhYueaXbu6/grSRn5/TbAwvYmN/UGnaZHflIcul1hKoZ6fp4d5QCOqHlm3lOmO/7qkO3iGpR4H2ivkezxrIHvv3fsAsmrv3aujI4CWHZ/6hNRdi5+OGgKEqGIaVkCTT9uSIlN5+E3dYQUgO3FGhB3YZf+fWiKLQh8n8fe5QsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295632; c=relaxed/simple;
	bh=Bj5yC+8b46RDVgUptaLnu/xG3/FmzZC5vpJJyId/REg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FD/kJFSEfpeUcvPyPnkbzMq98uXsACVl8b3ytLrrf5zetI1CRQ9jLoh7ErvtqhOj+TF530U7G/9pLq5QtNLfImCvukB/oMu7f2pqun2RegtmY9PIOj6hAusxup/mrEeRoYfSlwWA9MXJDJyjQjxyh5UvAuo7ta6cLDYmcycfapk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T/UkDcqa; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a2b5ea59a1so15433547e87.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 06:13:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777295629; cv=none;
        d=google.com; s=arc-20240605;
        b=kglwQ3oEoAyRoR8hDWwIPQMR0uWzEuW8ADXBA6phBC5KDx9+xDIAVNoaR8vn/Kb5XB
         5C44gdJA+MKQjPwF7FFUbWJ2GQwciEmQ9b6gSKkWoOol7I4Ev2/rj6B/dw+Q/LzSK5X9
         ssWTwPZqO45W9li3xU/hB4kmYyLPAxGAhNWsTT9SeqKJ8EvMOIvl9n9X7olCGdggnRLa
         b+oMTLsw4Df4HQs0KUUSrurJJxN7ki65R3oUKt/LFo5WMgve4NToQ05ompVU0vAhR09k
         4D7/srWvdyYdsuXa80ZjNLqckdkyVsKLDyjLjY98rO64Y9OSALMN2ok3b6oFRsOQssUc
         KxgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L7//5ece1DlWDMT1aLpKgGFyRfsm8Y+IqHoNcwNLtWg=;
        fh=Bo965RiQ4+iVwq4WTZtxEoxlZlB0L15lvdeBuDBp5ow=;
        b=aBQ6XGgZJgtqnqn8yyMBac9vZBVdrhU2jr0ygGVOW3olnxkJOfhtpuCSUy6tkBAoMR
         c02Lf9h0CFjwYJz7NR7LXwGPB2epZHDCiZewBGzNTWoAArJZ7+l+jWK+5g3Cii1/w0Qu
         uAQ6oSVmTjI7EadwTytTS1HiUJQG4tMw9aaqa2y/BJT8VndUy5GyVNFV6K5xqYzAc3nF
         hikvAjHoweXtwHDdHc15Lw8aM+TyCcA8qIh+w399hxDzu7GdH5tuyW7aiL3cwgz60Znk
         kwQoQyYlyQ6MdMrMLMDRkqxNa+ksd7pctwpMzQWz7cDBuJpcgwupv58E5wqzJR7dUK1H
         RsBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777295629; x=1777900429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L7//5ece1DlWDMT1aLpKgGFyRfsm8Y+IqHoNcwNLtWg=;
        b=T/UkDcqaD+Vy7Lhtce4drzBtghuLePgTrncmXUFzJBpgX16jvusyijLVWq+AI4Qwm6
         A5oRJXe2HcYOWtJ6o4evB9QTNAeiA6wvU1Ip2ZlvBVm/vEZqSO+Ln79AQ0QZQx6HYeUC
         xNTxrj1MjBw+KK9aCxKPzCweXSmgnH2PcTtu7aGCJdPd+jGIRDcpTJLqTtuy8NVy2B2t
         EJc/EEyspzCiMo1MrFONYwojk2kr6UH5E079NtJ54t0XZUgrF7mdczu8pDddfwQISFYm
         T+/nwkzFI8BBkSuYse+ZhnK7kGtlkkBV72fIj6cF6V9aE/D0s7cknise5A5+UxFe6e7w
         0bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777295629; x=1777900429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7//5ece1DlWDMT1aLpKgGFyRfsm8Y+IqHoNcwNLtWg=;
        b=lGLOPV2aU/BNH/JsVgDQSaJVG7yv0FLHbHJRQ57+l+JcawbRVHLijZobYR+fgxCvQR
         0aHAq0kj0hvwPYWtt1/J9QwLedalxt6MVgHNSkuTU8uPeeLmRFbs7xRz5ceWNdc0+RBZ
         dZtq37o1S1XR6phbqwohKtTQTbOfklE0PfIJIEizOdyB0nQBjKg/xrp3lvGLAl+s0kJ1
         uXn3wEyY0fqcZsTMZyRoCOCrWIw9oWylE4plXb86Du1NCAsEvylB/Fd6ZTIzcaU1gl+s
         +MavhLstqXOwpz1pYXqv75JMcoGlvGHyKWjIHZBbH0/a9KJkZM1xkYLbKsdK2Lj7AekA
         g57w==
X-Forwarded-Encrypted: i=1; AFNElJ/tDgIGrgsXHIuGIYHwrX5VleYwDqDxVrbuEezkOgMNst8LYMgH1NcUZNfHYsKbp3VwzNIEIGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP4O/svp+y/rRNpzDX0fpR+ZU9lxhXIAZgc5SDmHfwzb3gFD4e
	64jW80AWNHxX9FgHgEPbiZtqmpxJkPdRFMG7N3lJ5vxXDIxPEYAN4pbM1eFxtnnlUsuzImuLwq0
	6brN7hzs7w+z497N0l80UvlPiBX9HdR4DW7z5ceBkvg==
X-Gm-Gg: AeBDiesTOJD3XVqy9VP6QstRgCTWvocRN/StO5UhAcVLVRRzHn6nQ8iES/qOOrNU1Mq
	loX3KCJJDmecU03+p2HxAJ45Y36OCIWcwedI8t3DKil9kCXKWq7AKGwonC+ZEXHqCLKQzfe9QH2
	cYuJoFJnFSl9iYaycnAHiOFtOtxz/DEj6jD3ItpYIADjoz+oaCN0rnWhpOkAngn08IcoduUYYeX
	yqG5HmOGU/bEAsNY+z18Np71ANSDhIJDtB1kt8f6nPY4SEvXQ2wNWteIh0h5TeKgvt16RaS4s2h
	egZkpx763f3vkiIkWW0=
X-Received: by 2002:a05:6512:3193:b0:5a4:1672:59e0 with SMTP id
 2adb3069b0e04-5a4172cd574mr14121153e87.19.1777295629037; Mon, 27 Apr 2026
 06:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408141121.386522-1-vulab@iscas.ac.cn>
In-Reply-To: <20260408141121.386522-1-vulab@iscas.ac.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 27 Apr 2026 15:13:12 +0200
X-Gm-Features: AVHnY4KIw0y71PHOTou49MhZ1vsAm_GUfrl6yfolmci7Zff-_TktbzdbSpL-x1c
Message-ID: <CAPDyKFrTG6tp9XbuiUYjgMYkHYQwVsyXBuggCc3Lp=J_NcKTyA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: fix use-after-free in scpsys_get_bus_protection_legacy()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, nfraprado@collabora.com, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Adam Ford <aford173@gmail.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E36D5473383
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241325-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,collabora.com,mediatek.com,chromium.org,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linaro.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Wed, 8 Apr 2026 at 16:11, Wentao Liang <vulab@iscas.ac.cn> wrote:
>
> In scpsys_get_bus_protection_legacy(), of_find_node_with_property()
> returns a device node with its reference count incremented. The function
> then calls of_node_put(node) before checking whether
> syscon_regmap_lookup_by_phandle() returns an error. If an error occurs,
> dev_err_probe() dereferences the node pointer to print diagnostic
> information, but the node memory may have already been freed due to the
> earlier of_node_put(), leading to a use-after-free vulnerability.
>
> Fix this by moving the of_node_put() call after the error check, ensuring
> the node is still valid when accessed in the error path.
>
> Fixes: c29345fa5f66 ("pmdomain: mediatek: Refactor bus protection regmaps retrieval")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/mediatek/mtk-pm-domains.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index e2800aa1bc59..d3b36f32417c 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -993,6 +993,7 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
>         struct device_node *node, *smi_np;
>         int num_regmaps = 0, i, j;
>         struct regmap *regmap[3];
> +       int ret = 0;
>
>         /*
>          * Legacy code retrieves a maximum of three bus protection handles:
> @@ -1043,11 +1044,14 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
>         if (node) {
>                 regmap[2] = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg-nao");
>                 num_regmaps++;
> -               of_node_put(node);
> -               if (IS_ERR(regmap[2]))
> -                       return dev_err_probe(dev, PTR_ERR(regmap[2]),
> +               if (IS_ERR(regmap[2])) {
> +                       ret = dev_err_probe(dev, PTR_ERR(regmap[2]),
>                                              "%pOF: failed to get infracfg regmap\n",
>                                              node);
> +                       of_node_put(node);
> +                       return ret;
> +               }
> +               of_node_put(node);
>         } else {
>                 regmap[2] = NULL;
>         }
> --
> 2.34.1
>

