Return-Path: <stable+bounces-254118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCgzOa8hFGpjKAcAu9opvQ
	(envelope-from <stable+bounces-254118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:17:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 122A85C92AB
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAABC3016B2C
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C53349CF2;
	Mon, 25 May 2026 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="NcpNvr/k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B3E34887E
	for <stable@vger.kernel.org>; Mon, 25 May 2026 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779704080; cv=none; b=K25/w1SuwwQOChRFD7xZiAI38pcRqIz5Q29N+b6gMmS0778885jZxlSgdioSZsZmIroN38N523zTLq8wQjs9mLKGG3qugtmF45YgP5ggjIqm2lwGUKlJ0uwMiuuThbwD07tMUSoU5j8/KQt6diKFjXGXVDbuXehpxQ6ENdwcg6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779704080; c=relaxed/simple;
	bh=Ipp0kkfthINGpW3s+qD1mOApPHFjk2fjvLSUNv6kR4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTPDQbY5DgTx6oDGMN4sVlZHRBwnyAI3Kgnk36rz2jTmNwTg5DZKuZd7ZeyATV7o/qNPP4vYhsPJXaiMaF6n2RxXiePxgoi1wif5hEMhEFm3QwByKPN7+jkLgTcDsrUEDxEcTyNmrDC4XQODek9AIpkkNrXEFRQFfkT0j7me+pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=NcpNvr/k; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662] ([10.64.95.113])
	by smtp.orange.fr with ESMTP
	id RSKMw1KmpI5dgRSKMwQon0; Mon, 25 May 2026 12:14:30 +0200
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPSA
	id RSKCwSmE60vWHRSKCwRtyp; Mon, 25 May 2026 12:14:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1779704063;
	bh=RHF5/7UJVhD27Lwb3tHM9Ryg0OTUsaGFuxHHVJkuPxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=NcpNvr/k0+PeOZaoW4Nk+Iybpzmi6ytDHvD3XA9jydeEmW1P78wZ0USD+CLdeAkuk
	 ai4y2JPxyZaViQI8SK+BkPTe4+ykrdzO1mTOrZ5qGqe4hUHCVgq4Q0b2u7P5iIcGuj
	 rVLOQ8OZcaOYRJ5f1yhHkKFQskNW47SimzDKmBXgFwy4yFqQKG4JA/2NcwFz7WnrKj
	 Yxr3iCo2J4Mrnwr373rlBZWNMWbbe0z6p5R/QC+dTybMbizogzsDRkb2DpoPQWJPTR
	 WYBs8pEp0/Q28im+9cWb764Z3e6YEUsCti2zPMKtIoh9qS4WkT5JCMLV/g22LGGBQ6
	 ZZ3CbCAMRr5Pg==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 25 May 2026 12:14:23 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <f90481df-c68e-4c3c-be50-ad4e5e97d19b@wanadoo.fr>
Date: Mon, 25 May 2026 12:14:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/panel: novatek-nt36523: use devm_drm_panel_add()
To: Myeonghun Pak <mhun512@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jianhua Lu <lujianhua000@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
References: <cover.1779640137.git.mhun512@gmail.com>
 <c6fe4a162692b4df5525353dbdac5b88eda91a79.1779640137.git.mhun512@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <c6fe4a162692b4df5525353dbdac5b88eda91a79.1779640137.git.mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wanadoo.fr,quarantine];
	R_DKIM_ALLOW(-0.20)[wanadoo.fr:s=t20230301];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254118-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linaro.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[wanadoo.fr:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[wanadoo.fr];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophe.jaillet@wanadoo.fr,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 122A85C92AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 24/05/2026 à 18:36, Myeonghun Pak a écrit :
> nt36523_probe() adds the DRM panel before attaching the DSI devices. If
> one of the devm_mipi_dsi_attach() calls fails, probe returns with the
> panel still registered.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: 0993234a0045 ("drm/panel: Add driver for Novatek NT36523")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-novatek-nt36523.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> index 226d91daf8..f6592b01df 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> @@ -1047,13 +1047,6 @@ static int nt36523_unprepare(struct drm_panel *panel)
>   	return 0;
>   }
>   
> -static void nt36523_remove(struct mipi_dsi_device *dsi)
> -{
> -	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);

Hi,

Not looked in details, but the:
	mipi_dsi_set_drvdata(dsi, pinfo);
in the probe now looks useless.

CJ

> -
> -	drm_panel_remove(&pinfo->panel);
> -}
> -
>   static int nt36523_get_modes(struct drm_panel *panel,
>   			       struct drm_connector *connector)
>   {
> @@ -1225,7 +1218,9 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
>   			return dev_err_probe(dev, ret, "Failed to get backlight\n");
>   	}
>   
> -	drm_panel_add(&pinfo->panel);
> +	ret = devm_drm_panel_add(dev, &pinfo->panel);
> +	if (ret)
> +		return ret;
>   
>   	for (i = 0; i < DSI_NUM_MIN + pinfo->desc->is_dual_dsi; i++) {
>   		pinfo->dsi[i]->lanes = pinfo->desc->lanes;
> @@ -1259,7 +1254,6 @@ MODULE_DEVICE_TABLE(of, nt36523_of_match);
>   
>   static struct mipi_dsi_driver nt36523_driver = {
>   	.probe = nt36523_probe,
> -	.remove = nt36523_remove,
>   	.driver = {
>   		.name = "panel-novatek-nt36523",
>   		.of_match_table = nt36523_of_match,


