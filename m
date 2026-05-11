Return-Path: <stable+bounces-245310-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJt0HFQXAmoZnwEAu9opvQ
	(envelope-from <stable+bounces-245310-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:52:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CAA513D88
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D91A5304D5EF
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F0A43636B;
	Mon, 11 May 2026 17:23:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8352442882C;
	Mon, 11 May 2026 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520187; cv=none; b=LmTWEzw3iUF6qUv5pqn3pCN4jmWy3VE0hoFkVXG7IDaDt17DiUcTuLzJUez39R/iNNkUjqcpglLsm8gvc+0FWlgqywLjp3wdXYePn4FWxVw5eMeUy9/7Awe0X58LIVEgCYRV8kiepdbNlSibgvQt8JUWjJ25b1CAiRshep8V2iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520187; c=relaxed/simple;
	bh=mT99ulOMYhhBNtA2BSd3bQ5V6JrrYvcD32B1OO8rpPM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A13YE3DkxEiEnNjRTmg60ViLm7VvZltpdyBD7NeNIan7m5GgGXeZLlA/9Ub/0Xw6hkyTD7uVriKBpe3cNGY/aAKrX7YS/r/d+FEWJp0X9IYtWMwdGrWL682Mr/Y05pE/4gWdFbCJ+3Uql18SJvKuJtM/xRY42gDtscbUUOjDDEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.82])
	by APP-03 (Coremail) with SMTP id rQCowAA3G+JhEAJq99uzEA--.13588S2;
	Tue, 12 May 2026 01:22:42 +0800 (CST)
Message-ID: <3ee00ebc4ff5bcf2a8754466f8d9d04b24f81858.camel@iscas.ac.cn>
Subject: Re: [PATCH] drm/loongson: clean up KMS polling on probe failure
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Myeonghun Pak <mhun512@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Sui Jingfeng <suijingfeng@loongson.cn>, Jianmin Lv
 <lvjianmin@loongson.cn>,  Qianhai Wu <wuqianhai@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>,  Xi Ruoyao
 <xry111@xry111.site>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard	 <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie	 <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 	linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Date: Tue, 12 May 2026 01:22:41 +0800
In-Reply-To: <20260511170152.16957-1-mhun512@gmail.com>
References: <20260511170152.16957-1-mhun512@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:rQCowAA3G+JhEAJq99uzEA--.13588S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF48WFWkXF1xKrWUWrWktFb_yoW5Xw18pF
	s3Ga4Ykry0qrs7KryDXFyDZa4aqrWxta4S9rs7J340gr1qyrWvqFy0vF12qw15JFZYkF1a
	q3WvqrWru347C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU56yI5UUUUU==
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
X-Rspamd-Queue-Id: C1CAA513D88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245310-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[loongson.cn,kernel.org,aosc.io,xry111.site,linux.intel.com,suse.de,gmail.com,ffwll.ch,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhengxingda@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:mid]
X-Rspamd-Action: no action

=E5=9C=A8 2026-05-12=E4=BA=8C=E7=9A=84 02:01 +0900=EF=BC=8CMyeonghun Pak=E5=
=86=99=E9=81=93=EF=BC=9A
> lsdc_pci_probe() initializes KMS polling before setting up vblank
> support,
> requesting the IRQ and registering the DRM device. If any of those
> later
> steps fails, probe returns without finalizing polling. The remove
> path has
> the same lifetime gap when tearing down a successfully registered
> device.
>=20
> Route those probe failures through a poll cleanup label. Also
> finalize
> polling from remove before unregistering the DRM device.

Interesting, but it looks like a `drmm_kms_helper_poll_init` function
exists (while rarely used).

Maybe it's better to switch to this? Or maybe there's some reason not
to use this?

Thanks,
Icenowy

>=20
> This issue was identified during our ongoing static-analysis research
> while
> reviewing kernel code.
>=20
> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display
> controller")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/loongson/lsdc_drv.c | 11 ++++++++---
> =C2=A01 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c
> b/drivers/gpu/drm/loongson/lsdc_drv.c
> index abf5bf68ee..3db1f8690a 100644
> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
> @@ -297,7 +297,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
> =C2=A0	if (loongson_vblank) {
> =C2=A0		ret =3D drm_vblank_init(ddev, descp->num_of_crtc);
> =C2=A0		if (ret)
> -			return ret;
> +			goto err_poll_fini;
> =C2=A0
> =C2=A0		ret =3D devm_request_irq(&pdev->dev, pdev->irq,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 descp->funcs->irq_handler,
> @@ -305,7 +305,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name(&pdev->dev), ddev=
);
> =C2=A0		if (ret) {
> =C2=A0			drm_err(ddev, "Failed to register interrupt:
> %d\n", ret);
> -			return ret;
> +			goto err_poll_fini;
> =C2=A0		}
> =C2=A0
> =C2=A0		drm_info(ddev, "registered irq: %u\n", pdev->irq);
> @@ -313,17 +313,22 @@ static int lsdc_pci_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
> =C2=A0
> =C2=A0	ret =3D drm_dev_register(ddev, 0);
> =C2=A0	if (ret)
> -		return ret;
> +		goto err_poll_fini;
> =C2=A0
> =C2=A0	drm_client_setup(ddev, NULL);
> =C2=A0
> =C2=A0	return 0;
> +
> +err_poll_fini:
> +	drm_kms_helper_poll_fini(ddev);
> +	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static void lsdc_pci_remove(struct pci_dev *pdev)
> =C2=A0{
> =C2=A0	struct drm_device *ddev =3D pci_get_drvdata(pdev);
> =C2=A0
> +	drm_kms_helper_poll_fini(ddev);
> =C2=A0	drm_dev_unregister(ddev);
> =C2=A0	drm_atomic_helper_shutdown(ddev);
> =C2=A0}


