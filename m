Return-Path: <stable+bounces-269476-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nsCeBb2dQGrfggkAu9opvQ
	(envelope-from <stable+bounces-269476-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 06:06:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E476D324B
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 06:06:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269476-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269476-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A9613022D3F
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 04:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5F0351C2E;
	Sun, 28 Jun 2026 04:03:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D1349CE9;
	Sun, 28 Jun 2026 04:03:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619408; cv=none; b=FCInvhGLNrFA2x7HkvjV35oaq3eIboFpyMzc4D1D81AO+y6g1cg7enjUooBAq0YG8KXIhEBcblx5Vme+OmAp45ePmFbsYULNqkjFLFPwttM6idfz/tc11xo3xaS+pP52EvQqAroMvITxvEoZfKgajcJnkRu44hfoYb/dZhOIcis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619408; c=relaxed/simple;
	bh=dgCGGosrsK4BrAhN1/0HhLVgaxeS2a8CeQUzDMUVLLU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Q7AyhB89liN0Z5NPGFLfkpdDrsgjVUIsv1B2/KQ8IDv2DVdbMEZh6/qWulW7WxNjVyQ6YQUNXHJtvWRGcRKqsgBzGQpu8kBLR6146P8U9tOLHn2p1CImAvSgDGAVpWy8Lhr6w1MbqD1O50NBassZqjJ70/A3N76rr6+B4Sk2JC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAD3j8h4nEBq+V6qAw--.55335S11;
	Sun, 28 Jun 2026 12:03:11 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: drm/vmwgfx: ttm_base_object_init: fix tfile
 reference leak on error   paths
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626145946.49620-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 12:03:00 +0800
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Thomas Hellstrom <thellstrom@vmware.com>,
 Christian Koenig <christian.koenig@amd.com>,
 stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B116FACE-0C4E-45BE-AE4F-FAACF4F3959E@iscas.ac.cn>
References: <20260626145946.49620-1-vulab@iscas.ac.cn>
To: Zack Rusin <zack.rusin@broadcom.com>,
 dri-devel@lists.freedesktop.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAD3j8h4nEBq+V6qAw--.55335S11
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4kCry3JFyUZw1Dtr4kXrb_yoW8CF1fpr
	W3X347AryrJr4xKrsrZan5XF9xt3sF9r15KFyYvwn3urn8ZasxJrs0qa1DWF4UGrs7Ar42
	qa1j9F98ZFWUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm2b7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07j0OJ5UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUMA2pAiNkg-wABs2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	TAGGED_FROM(0.00)[bounces-269476-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	URIBL_MULTI_FAIL(0.00)[iscas.ac.cn:server fail,vger.kernel.org:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bcm-kernel-feedback-list@broadcom.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:thellstrom@vmware.com,m:christian.koenig@amd.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zack.rusin@broadcom.com,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,vmware.com,amd.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17E476D324B



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 22:59=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> ttm_base_object_init calls ttm_object_file_ref(tfile) to acquire a =
tfile
>  reference early in the function. On error paths (idr_alloc failure =
and
>  ttm_ref_object_add failure), the function returns without calling
>  ttm_object_file_unref to release this reference, causing a tfile
>  reference leak.
>=20
> Add proper cleanup in the error paths to release the tfile reference =
via
>  ttm_object_file_unref.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 0b8762e997df ("drm/ttm, drm/vmwgfx: Move the lock- and object =
functionality to the vmwgfx driver")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/gpu/drm/vmwgfx/ttm_object.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c =
b/drivers/gpu/drm/vmwgfx/ttm_object.c
> index 2421b0dd057c..93ae5a07d70a 100644
> --- a/drivers/gpu/drm/vmwgfx/ttm_object.c
> +++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
> @@ -204,7 +204,7 @@ int ttm_base_object_init(struct ttm_object_file =
*tfile,
> 	spin_unlock(&tdev->object_lock);
> 	idr_preload_end();
> 	if (ret < 0)
> -		return ret;
> +		goto err_unref_tfile;
>=20
> 	base->handle =3D ret;
> 	ret =3D ttm_ref_object_add(tfile, base, NULL, false);
> @@ -218,6 +218,10 @@ int ttm_base_object_init(struct ttm_object_file =
*tfile,
> 	spin_lock(&tdev->object_lock);
> 	idr_remove(&tdev->idr, base->handle);
> 	spin_unlock(&tdev->object_lock);
> +	ttm_object_file_unref(&base->tfile);
> +	return ret;
> +err_unref_tfile:
> +	ttm_object_file_unref(&base->tfile);
> 	return ret;
> }
>=20
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang


