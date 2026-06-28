Return-Path: <stable+bounces-269460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id maAwLGebQGpmggkAu9opvQ
	(envelope-from <stable+bounces-269460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 05:56:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CC66D3134
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 05:56:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269460-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269460-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AFF8301A7D6
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 03:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30972D876A;
	Sun, 28 Jun 2026 03:56:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21C12D2496;
	Sun, 28 Jun 2026 03:56:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782618971; cv=none; b=XvG/LmftGQtN9yfwOxK6z/yBz/We0kXOXGFuNcOCg8eFscpHRNt6dlWqugTfkkF1DJR1YDaTW+aCMyuLyW5TWexSrtZhALpFX6uC0bt/zEsjW+q2HmmvuXFC3ANESWhPvOhOkEULBc+MPbmpLPjoPCrbFn+swaRKyuyjdA4vPdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782618971; c=relaxed/simple;
	bh=AwD2SmGCGrhFskUtOr9xHfN/0h+Bv80mMDZ2WEH/tRo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=es1GyHhDpenXlUzByGYTrqrnpSKwET/Imsg+vbX+wnqHsB3q9IG5AVDOcrlXNLja4A0sX8E+wZZDHckwWqv1F1WnGSktvRE1gdOSTPJO5VFdbzIIG5sQJd8xrX7R1owxNkjamB3vgsV2yj7rgKSlkENKO4fpKOVBKiAOmkLpkao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowADXfdYKm0BqqCuqAw--.7249S7;
	Sun, 28 Jun 2026 11:55:57 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: drm/mediatek: mtk_drm_probe: of_node_get in loop
 overwrites previous   node references without release
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626132849.38694-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:55:46 +0800
Cc: dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6172B26B-FC2B-4886-8578-E981C4FF14F6@iscas.ac.cn>
References: <20260626132849.38694-1-vulab@iscas.ac.cn>
To: chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de,
 airlied@gmail.com,
 simona@ffwll.ch,
 matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowADXfdYKm0BqqCuqAw--.7249S7
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyUArW7ur4fXr17KrWrGrg_yoW8AF4kpF
	WUKFWYyrW8Kr4xKFyvyFn8uFySy3WSq3y8Wa10q3W8uwn0yFyUXFy5Xa17tFZ7AFyIkF13
	Jan8JF93ur12vFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm2b7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07jj5lbUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBggMA2pAhrYiZAAAsd
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269460-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,gmail.com,ffwll.ch,collabora.com];
	FORGED_RECIPIENTS(0.00)[m:dri-devel@lists.freedesktop.org,m:linux-mediatek@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,m:chunkuang.hu@kernel.org,m:p.zabel@pengutronix.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63CC66D3134



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 21:28=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> In the for_each_child_of_node loop, private->comp_node[comp_id] and
>  private->mutex_node are assigned via of_node_get without first =
releasing
>  any previously stored reference for the same index. When the same =
comp_id
>  or mmsys_id matches multiple nodes, earlier node references are
>  overwritten and permanently leaked.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 1ef7ed48356c ("drm/mediatek: Modify mediatek-drm for mt8195 =
multi mmsys support")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/gpu/drm/mediatek/mtk_drm_drv.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c =
b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index c86a3f54f35b..2c0d8db9ade2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -1138,6 +1138,7 @@ static int mtk_drm_probe(struct platform_device =
*pdev)
>=20
> 			id =3D of_alias_get_id(node, "mutex");
> 			if (id < 0 || id =3D=3D private->data->mmsys_id) =
{
> +				of_node_put(private->mutex_node);
> 				private->mutex_node =3D =
of_node_get(node);
> 				dev_dbg(dev, "get mutex for mmsys %d", =
private->data->mmsys_id);
> 			}
> @@ -1153,7 +1154,7 @@ static int mtk_drm_probe(struct platform_device =
*pdev)
>=20
> 		if (!mtk_drm_find_mmsys_comp(private, comp_id))
> 			continue;
> -
> +		of_node_put(private->comp_node[comp_id]);
> 		private->comp_node[comp_id] =3D of_node_get(node);
>=20
> 		/*
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang


