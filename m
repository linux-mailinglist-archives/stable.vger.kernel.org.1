Return-Path: <stable+bounces-238746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHREKRAd5mlurwEAu9opvQ
	(envelope-from <stable+bounces-238746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:33:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 033DD42AC59
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 849CE301ECCB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 12:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1376E3264F1;
	Mon, 20 Apr 2026 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="M1N0OqMk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011321C5D7D
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688395; cv=none; b=FJVNkC8T8CGFVHlJvdXcGQTttyVGUjx5+sdmSobZcYKezaKCDJFPwI9pDd8eBVDi/BmUPf/OUmZP5x3VN9IKmK90luyG0zxW+5iprlrT1oQ86hebnb7ymOjCMLLnH+nEOSGVg7T5gkhYYkoomzSDZwZcHlqAs97nbKf7Pr+eenA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688395; c=relaxed/simple;
	bh=ouN2T9zodtnGRFKEDJT3a7cOKWhNDFwWELKSz0rhc0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8QlzDCyjrx1zkwLhNW+5snt3qSzr/E6/S3dDOMIfxySiMUDLV3jrMQ4W4QmzpXleQfQcrNalNyJXqSLBvK+Xkcdewe7YMMDyu/sz3l8JbRY90EgJKn5g7p0/u1P0Y8i4ZXc0/SH7jrpX8ocJ0nG+AzK9DgkVSZxH50RMrZVc+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=M1N0OqMk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso40411065e9.3
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 05:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1776688391; x=1777293191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vywUgRyvHiyb8Tcpyclkx71VYCcveacoMI82OHms9l8=;
        b=M1N0OqMk+uWjKQRIYI0OyaTX1K8F2HmFCZf0WT5zTHMJ9P4bOboGbYPJWlDshk26Aw
         s+F90I7mPz/s4+9m0EUo+2xz3iUHpFmVr2aim/zzgQl8qZCH3sV5IKBJzcChN9Hrj3Or
         sSwLuXJ2CarFRej+ezqVLRYDii8q9XfnKpFC7s5ejsqwwplFODD86mgY7jHoRIQ1eJmC
         P8tlxFSaoeyb0aK+5Ifl5uzyW9TN++KrwaXU2qgkRKjIKuQNeCjz6UKOv3CWnnKR7jtF
         F08kVcN87RJU5ensJMu12/D/krZQqcAgSgBGjLk5hrf41gfvAQ8EQY3emDgOjlI5OD34
         NbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776688391; x=1777293191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vywUgRyvHiyb8Tcpyclkx71VYCcveacoMI82OHms9l8=;
        b=bDAov1cY4N0zwhQsnwRi4Cltu7Sn9E5Aiet+WKGAR51GIx8OA4DXSj9piU8e8fbBT/
         rlca6PkGn6hJ0ue7dq7A6+ib0mttmo/H2xOjolorae/+OKr9bWM3b76W9fiRFFo4siui
         XRtBsPsYzqQsLWIFADLFe1rUMX3MJcKeMtNAmLGFKCtBkZxjZwd4ilhgcSydGzvPD7es
         1R/zx/cguy2exWnoyoE/gKy5v0pmky+qPTmKvhOb+A1w5UFughKMis6zGzGS7FvQgJY2
         425P6yxxTBUZ+rGiDfvn/U8eZKT3VfVJv3qsb4jEV1w17NiQp1Ui1heu9H1Lm7KpVo18
         J6Ug==
X-Forwarded-Encrypted: i=1; AFNElJ9vKWvULPWKmndwMYLdsA0ArkMrEjlQdNdyyl3yKuiJaxYog+quNxUg7TTHO/JOGFFa+IQVS/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3cVQkNcmp+033ZLUT3O91ivGUhZfGsgbJq+DLWg+dkO8kwPBt
	wRzlnOCi7KwI1/fvtuR1ayWnLZTXpdvb4o7yajRPXTBBk1pBK/JgJhALqqh6QpuioPA=
X-Gm-Gg: AeBDievhMxllIE8q7t9gIMDjzbkk/fhxIqqbX8+A6zdNJY0YzyD/U3b3kvDL92B5LeG
	3KrbK/Ip63RGAFDbAnUf8M2zjWXuDEwVdjpC0AddOtyZ+kdvT30GMs+99L61N3YgUBEKQ9tpcLv
	ZA+sF2lX/sbc8lkqI2Hp3uzCNwNJD2ewn4sQNXDw932xp1iH2mTw0CKuMkpB/hW9F6l2dvMNInK
	vnNGxEWycDKgm83TJ5TJxZRdQIvMG4kFWtw9gXEsORxhaqfEdlyB3KpWirk4MshoA3AO03AdE/E
	/80Re9aZX4T523z68RujFyrReXWz9uTJ9cceDsZYhKx5Ok7ONA2SfMndAuxxMgMGVX3Q4Y9ffT9
	15HlAU1wWrGajLE2j7OxscHVpn+jORP1Gk5MZC8OSMt3BlUaWL3GWV593VXMuOyaSbNiqaIgDqC
	f6Tykd3FmtaGDKl5wIax0rhKmfxTl5OGlmJudyyUPNVA==
X-Received: by 2002:a05:600c:8582:b0:486:fab9:a578 with SMTP id 5b1f17b1804b1-488fb7556b9mr147084635e9.11.1776688391119;
        Mon, 20 Apr 2026 05:33:11 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a52583fe7sm19933615e9.13.2026.04.20.05.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 05:33:10 -0700 (PDT)
Message-ID: <631893a8-d5de-49f8-9d7b-a20db4a8ed08@tuxon.dev>
Date: Mon, 20 Apr 2026 15:33:09 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: sashiko.dev review (Re: [PATCH v4 01/17] dmaengine: sh: rz-dmac: Move
 interrupt request after everything is set up)
To: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 p.zabel@pengutronix.de, geert+renesas@glider.be,
 fabrizio.castro.jz@renesas.com, long.luu.ur@renesas.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
References: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
 <20260411114303.2814115-2-claudiu.beznea.uj@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260411114303.2814115-2-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238746-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	URIBL_MULTI_FAIL(0.00)[tuxon.dev:server fail,sea.lore.kernel.org:server fail,renesas.com:server fail];
	RCPT_COUNT_TWELVE(0.00)[18];
	DMARC_NA(0.00)[tuxon.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tuxon.dev:dkim,tuxon.dev:mid]
X-Rspamd-Queue-Id: 033DD42AC59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 > commit b3dfdd5fbd2463db407b1396ee1ae79801cb96bf
 > Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
 > dmaengine: sh: rz-dmac: Move interrupt request after everything is set up
 > This patch moves the channel interrupt request to the end of the channel
 > probe function to prevent the IRQ handler from accessing uninitialized
 > data. It also replaces dma_alloc_coherent() with dmam_alloc_coherent()
 > to simplify the error path.
 > > diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
 > > index 625ff29024de0..9f206a33dcc6b 100644
 > > --- a/drivers/dma/sh/rz-dmac.c
 > > +++ b/drivers/dma/sh/rz-dmac.c
 > [ ... ]
 > > @@ -1210,16 +1207,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 > >  dma_register_err:
 > >     of_dma_controller_free(pdev->dev.of_node);
 > >  err:
 > > -   channel_num = i ? i - 1 : 0;
 > > -   for (i = 0; i < channel_num; i++) {
 > > -           struct rz_dmac_chan *channel = &dmac->channels[i];
 > > -
 > > -           dma_free_coherent(&pdev->dev,
 > > -                             sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
 > > -                             channel->lmdesc.base,
 > > -                             channel->lmdesc.base_dma);
 > > -   }
 > > -
 > >     reset_control_assert(dmac->rstc);
 > >  err_pm_runtime_put:
 > >     pm_runtime_put(&pdev->dev);
 > > @@ -1232,18 +1219,9 @@ static int rz_dmac_probe(struct platform_device *pdev)
 > >  static void rz_dmac_remove(struct platform_device *pdev)
 > >  {
 > >     struct rz_dmac *dmac = platform_get_drvdata(pdev);
 > > -   unsigned int i;
 > >
 > >     dma_async_device_unregister(&dmac->engine);
 > >     of_dma_controller_free(pdev->dev.of_node);
 > > -   for (i = 0; i < dmac->n_channels; i++) {
 > > -           struct rz_dmac_chan *channel = &dmac->channels[i];
 > > -
 > > -           dma_free_coherent(&pdev->dev,
 > > -                             sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
 > > -                             channel->lmdesc.base,
 > > -                             channel->lmdesc.base_dma);
 > > -   }
 > >     reset_control_assert(dmac->rstc);
 > >     pm_runtime_put(&pdev->dev);
 > >     pm_runtime_disable(&pdev->dev);
 > >  }
 > While this patch fixes the initialization races, does it leave a similar
 > vulnerability exposed during teardown?
 > Since devm_request_threaded_irq() is used to allocate the interrupts, they
 > will remain active until after rz_dmac_remove() and the rz_dmac_probe() error
 > paths complete.
 > If an interrupt fires during or just after rz_dmac_remove(), could the handler
 > attempt to access hardware registers while the device is in reset or powered
 > down by pm_runtime_put()?
 > Would it be safer to explicitly free or disable the IRQs before asserting the
 > hardware reset and disabling runtime PM, or perhaps manage the reset and PM
 > states via devm actions to guarantee correct teardown ordering?

On either failure or remove path the device is with runtime PM put (clocks being 
disabled) and in reset state. The controller cannot generate interrupts from 
this state.

However, to keep this series simple, I'll add this in a cleanup patch after the 
current series will be merged.


