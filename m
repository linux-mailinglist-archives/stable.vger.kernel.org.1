Return-Path: <stable+bounces-245422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOmiIvvfAmpEyQEAu9opvQ
	(envelope-from <stable+bounces-245422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 10:08:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D773251C6FB
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 10:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9FBE305C619
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 08:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C884648C40C;
	Tue, 12 May 2026 08:03:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A5D47DFAA;
	Tue, 12 May 2026 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573018; cv=none; b=iYABOsh7t+lskkkIrqt+3xusYEhp5itJfK33OtUTIqP/sws13YHitx3raU7jl/G4G2TBbzjsisrkzGLWIKCsXEtL2ytH9266rT74gh4H6ltNF8ymQvt4z6gEp1cEeGQrBLrm6US5GIn2Hfb8oagqLz1kOBSteYHXPQaGy6daKQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573018; c=relaxed/simple;
	bh=PFdINq5tBxJFdWoSQnV6OUJBETX2J7YLEI4iZ4wH5zU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GkGVNDDIrAHzo8yPeT/HCXbrpI1KN6ClQe7d2EBxY+wzSSjG+J1UsdHsLYeEyzLRPb/NS4S4bp+iRwjvbzPOvYr6rvupCDyHfOT9HgdYqlmui+miP/RjqkMsy/I7t3XLpXyFUBJoK/x1VySS/abOyBpPX3xbYKnOSOVMDwHB0sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.129])
	by gateway (Coremail) with SMTP id _____8Ax_unE3gJqRgoJAA--.27270S3;
	Tue, 12 May 2026 16:03:16 +0800 (CST)
Received: from [10.20.42.129] (unknown [10.20.42.129])
	by front1 (Coremail) with SMTP id qMiowJCx+8HC3gJqvv9_AA--.47188S3;
	Tue, 12 May 2026 16:03:14 +0800 (CST)
Subject: Re: [PATCH v2] drm/loongson: use managed KMS polling
To: Myeonghun Pak <mhun512@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Thomas Zimmermann <tzimmermann@suse.de>, Qianhai Wu <wuqianhai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
References: <20260512063657.53100-1-mhun512@gmail.com>
From: Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <89da8981-fd0d-9e0b-78e1-a1d10f03685a@loongson.cn>
Date: Tue, 12 May 2026 15:55:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260512063657.53100-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx+8HC3gJqvv9_AA--.47188S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFy7uF45JF4Dur1ktFW3XFc_yoW8AF1kpF
	ZxC3WjyrWUJF17Cw1UJa48J3WS9ayDJFWfurs3A34DuwnxAa47uFyjvF45ZF9rAFWjyF4a
	qFyvkayru3W3ArXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUU
	U==
X-Rspamd-Queue-Id: D773251C6FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245422-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[iscas.ac.cn,suse.de,loongson.cn,kernel.org,aosc.io,xry111.site,linux.intel.com,gmail.com,ffwll.ch,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lvjianmin@loongson.cn,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.974];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,loongson.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 2026/5/12 下午2:36, Myeonghun Pak wrote:
> lsdc_pci_probe() initializes KMS polling before setting up vblank support,
> requesting the IRQ and registering the DRM device. If any of those later
> steps fails, probe returns without finalizing polling. The driver also
> never finalizes polling on regular removal.
> 
> Use drmm_kms_helper_poll_init() so polling is tied to the DRM device
> lifetime and automatically finalized on probe failure and device removal.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Acked-by: Jianmin Lv <lvjianmin@loongson.cn>

> ---
> Changes in v2:
> - Switch to drmm_kms_helper_poll_init() as suggested by Icenowy Zheng
>    and Thomas Zimmermann instead of adding manual cleanup paths.
> 
>   drivers/gpu/drm/loongson/lsdc_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
> index abf5bf68ee..4b97750897 100644
> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
> @@ -292,7 +292,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   
>   	vga_client_register(pdev, lsdc_vga_set_decode);
>   
> -	drm_kms_helper_poll_init(ddev);
> +	drmm_kms_helper_poll_init(ddev);
>   
>   	if (loongson_vblank) {
>   		ret = drm_vblank_init(ddev, descp->num_of_crtc);
> 


