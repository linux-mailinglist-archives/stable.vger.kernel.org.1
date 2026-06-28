Return-Path: <stable+bounces-269478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id THHdG8idQGrgggkAu9opvQ
	(envelope-from <stable+bounces-269478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 06:06:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAB56D324E
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 06:06:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269478-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269478-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48AAE303AF3B
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 04:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0098235DA67;
	Sun, 28 Jun 2026 04:03:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E6135C1AD;
	Sun, 28 Jun 2026 04:03:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619426; cv=none; b=FgY9aB8pDuAXWa8jqNWAVxu/Qtq9DEfoBLkdjOW4tAqEbGO4Rx+rT/HvWdbolsDo4TLPrNdNanS29k1hm7+XZFbY8F4kRjDZ8IPENQ9DA6JFynpv4ekRxsSm+av/IMmz83TNl5KV3kIpNenqPKeUW/CYWWuh1RDuVzU4NP5N6Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619426; c=relaxed/simple;
	bh=tRxPMyBvFu+oM9d7ijSfmhojyYCgrc4OhOcvwCBk6Vg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tYTKuwLp5xOYx2xz32Yv7c/H2nGRJ9yjPKiNVrCEPTHUVL/rpZejYAPaohgtzs3qYYdcV02TlO5oOmWa+d0QZZrcusuIp6bUFqQvU+fanqoH+RA9SDE0XEDWOmI1Po0IbmZuynLTsDqrY6z/TuwtAmaeIIxPOTGn/D0LPqSAxuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAD3j8h4nEBq+V6qAw--.55335S13;
	Sun, 28 Jun 2026 12:03:33 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: drm/vmwgfx: vmw_user_shader_alloc: fix base object
 refcount leak on   ttm_base_object_init failure
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626150142.49732-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 12:03:22 +0800
Cc: bcm-kernel-feedback-list@broadcom.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Thomas Hellstrom <thellstrom@vmware.com>,
 stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <11591F0D-3407-4B30-803C-30F7A98DB5AC@iscas.ac.cn>
References: <20260626150142.49732-1-vulab@iscas.ac.cn>
To: Zack Rusin <zack.rusin@broadcom.com>,
 dri-devel@lists.freedesktop.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAD3j8h4nEBq+V6qAw--.55335S13
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1UXrW8Xw1fAFyfWr4xXrb_yoW8Xr4Dpr
	4ftay7JryfJFWxKa9rZa1kZFyS9w1qgayrKFy0vwn3uwsIva4DJ398JFZ09F17uryIyr4a
	qr1vvrs3uF1jyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMMA2pAhrYlHgAAsr
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269478-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[broadcom.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,vmware.com,vger.kernel.org];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:bcm-kernel-feedback-list@broadcom.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:thellstrom@vmware.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zack.rusin@broadcom.com,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCAB56D324E



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 23:01=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> ttm_base_object_init unconditionally acquires a base object reference =
via
>  kref_init. When it fails, the error path in vmw_user_shader_alloc =
only
>  calls vmw_resource_unreference but never calls ttm_base_object_unref =
to
>  release the base object reference, causing a refcount leak.
>=20
> Add ttm_base_object_unref in the error path to properly release the =
base
>  object reference when ttm_base_object_init fails.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 0b8762e997df ("drm/ttm, drm/vmwgfx: Move the lock- and object =
functionality to the vmwgfx driver")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/gpu/drm/vmwgfx/vmwgfx_shader.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c =
b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
> index eca4e3e97eb4..d82ec43c8901 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
> @@ -724,6 +724,7 @@ static int vmw_user_shader_alloc(struct =
vmw_private *dev_priv,
>=20
> 	if (unlikely(ret !=3D 0)) {
> 		vmw_resource_unreference(&tmp);
> +		ttm_base_object_unref(&ushader->base);
> 		goto out_err;
> 	}
>=20
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=


