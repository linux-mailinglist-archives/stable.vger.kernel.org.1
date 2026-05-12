Return-Path: <stable+bounces-245423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC74NL/gAmpEyQEAu9opvQ
	(envelope-from <stable+bounces-245423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 10:11:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C38251C7A5
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 10:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8DAD3000FCD
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 08:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CB148C413;
	Tue, 12 May 2026 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoCe+lHa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912E748BD3F
	for <stable@vger.kernel.org>; Tue, 12 May 2026 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573497; cv=none; b=rJbr2qCx8lR/6b6hRn2SPebDW7OSXZGZCRA111podDUJm47uizo3t0VZaFKNllakxlBkvNqnY8To56Mlu4LSL0BAmSqZSMH/vvi3qhDqmC2eSz2fXiwUoVkejcw8Tn4c7QGwntadbS0TFyvfRRixnDWqVKed+FriA9Vtu2z7PgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573497; c=relaxed/simple;
	bh=6BojsxZOLjEhtqKTz9EoHvQznoagFeTE9NbkgrQer+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qn3dfOWaYEBOWArLBegl8YQKgBge1tiHe6rSzRtwSQFd5wKNj2FRG/RynggkeXpi95pxtAJoTpKUpz02iEAiQrlwuod1ShEQxqnG/7fX497hZQO6XOAx8ezYGx50zrICu607fOcOTPhyKpdAzNCY/48FFu1QLpu4TzIDcvdqHfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoCe+lHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F65C2BCC7
	for <stable@vger.kernel.org>; Tue, 12 May 2026 08:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778573497;
	bh=6BojsxZOLjEhtqKTz9EoHvQznoagFeTE9NbkgrQer+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MoCe+lHay61HbM27yL6DeHJkNWyRrVr/biDl9iI9kjIXhEZyNNbw924m5YGTbNxHo
	 /h5sLBprl2iDAItcVSjwjFQyyWrLyNYEkv53esGQChCeQEJHuGS1YwV2Dh3C0fCsfh
	 n3/+NGQYmf/yvTItRH+czg9MNaREvHnFpKz2q3TXOrCw2Ks9qGOLKAZy2h7IxTcOwb
	 3tztjEwqZzj+jRhjHXEaydn2OaFIbhXVKFLyaefuwTcPzSLzsBvGCVEDRF9ku/kX2u
	 kg9szORz4TYJtxs8TK9l72zUq/hDUoajAWpRbnd/CTGNU9kPTDfGVwzatHbo9too2C
	 S4IMvIWWhDwjA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bcceb394417so319263866b.0
        for <stable@vger.kernel.org>; Tue, 12 May 2026 01:11:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Sui/I/YHO+PTNgb057/jTSKD3PFMIWF70NRHLRgwz7UxuXes598xExmm792CgWoXJ4pNBWlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWwLApdOIsplbHblrfu9eRI8Xzc7QpPU7Gu3TsL5Fq3F0FcHc3
	khbFHbc5Qco+0YJZWEWW2l14uPoYoNI4TKMQW0AppuPUeAW4I1xvZG6x9unuJgPwARdbYUmAwvK
	3bPxhgHLcyFg4sgPEOKdl3MZBNe6u2j4=
X-Received: by 2002:a17:906:ee8d:b0:bd2:1995:3a91 with SMTP id
 a640c23a62f3a-bd28e318fd7mr108583966b.12.1778573495594; Tue, 12 May 2026
 01:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512063657.53100-1-mhun512@gmail.com>
In-Reply-To: <20260512063657.53100-1-mhun512@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 12 May 2026 16:11:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Q5_xgi8WDgGGYLo4ivXv7tKeK2i97sZng2LzncsmgTw@mail.gmail.com>
X-Gm-Features: AVHnY4KHOlgA72xsxa1aNNyu6NufzzZ9v5aH1Cxl-mXiJUGXiIjUAXap3V-wddY
Message-ID: <CAAhV-H5Q5_xgi8WDgGGYLo4ivXv7tKeK2i97sZng2LzncsmgTw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/loongson: use managed KMS polling
To: Myeonghun Pak <mhun512@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Sui Jingfeng <suijingfeng@loongson.cn>, 
	Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>, 
	Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7C38251C7A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,iscas.ac.cn,suse.de,loongson.cn,aosc.io,xry111.site,linux.intel.com,kernel.org,gmail.com,ffwll.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-245423-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,loongson.cn:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 2:37=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com> w=
rote:
>
> lsdc_pci_probe() initializes KMS polling before setting up vblank support=
,
> requesting the IRQ and registering the DRM device. If any of those later
> steps fails, probe returns without finalizing polling. The driver also
> never finalizes polling on regular removal.
>
> Use drmm_kms_helper_poll_init() so polling is tied to the DRM device
> lifetime and automatically finalized on probe failure and device removal.
>
> This issue was identified during our ongoing static-analysis research whi=
le
> reviewing kernel code.
In the subject line please s/use/Use/g, others LGTM.
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

>
> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller=
")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> Changes in v2:
> - Switch to drmm_kms_helper_poll_init() as suggested by Icenowy Zheng
>   and Thomas Zimmermann instead of adding manual cleanup paths.
>
>  drivers/gpu/drm/loongson/lsdc_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongs=
on/lsdc_drv.c
> index abf5bf68ee..4b97750897 100644
> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
> @@ -292,7 +292,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>
>         vga_client_register(pdev, lsdc_vga_set_decode);
>
> -       drm_kms_helper_poll_init(ddev);
> +       drmm_kms_helper_poll_init(ddev);
>
>         if (loongson_vblank) {
>                 ret =3D drm_vblank_init(ddev, descp->num_of_crtc);
> --
> 2.47.1
>

