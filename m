Return-Path: <stable+bounces-47876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7948D85B7
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 17:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C5D282442
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 15:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D3FB65F;
	Mon,  3 Jun 2024 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TQPqZWhT"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1780391
	for <stable@vger.kernel.org>; Mon,  3 Jun 2024 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427078; cv=none; b=bI1zSTi8Pviss9X5/Ikj53kul/OM6NpaZi9NLDrFOmAIt6rLD8pLJic1roFOJKRwFfY2jLK8KtQBhGDLW6S7keE+Zr4VvN5QUKCE1qODyR0iIDgecEFfHKKejJ9wLu6jZ7ddAbCL1BOqRWL8+Q2bd3PLiPenY+JyhUkLLDZDEZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427078; c=relaxed/simple;
	bh=EcqIhGlVUbQfz5ALesOBex6iPRZO4bsLk1BjsG2tgOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h68QtI53gVAW/SY9JyDgo6ihS6HA1w4InmPbBWnmvDHDUHRQyF9uwzhBxS+S7j9stXEYQ52jt5Q0uirDPdRp4AqOrxfORkOtS04NbPZz2DiZtlkXKCY0T52FuqiZ7pdxBYlbifCamlAYAwAccMJhawSh6A5guyeR0WhxFivL2zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TQPqZWhT; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717427073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qts32yh1q6JkSbgrbFUOSqR348gistj/bnY7s7orHog=;
	b=TQPqZWhTXkI9TFla7IIt6+k9Pcomc56r7GNzfegObLV+c/T/fPc4VWhXhf1xUA/HIhnT6P
	f/MjJozXmaGUwMJWGuSvP0Pj0uB3lrrJBFeqEmUpby/1Hb2dNI3bv7KFNgfMytV8qbRpRh
	jLxRz2IO75vgunryzYQUt1V9yjUoqAA=
X-Envelope-To: stable-commits@vger.kernel.org
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: tomi.valkeinen@ideasonboard.com
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: mripard@kernel.org
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: airlied@gmail.com
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: michal.simek@amd.com
Message-ID: <12c2adcf-cc18-48a8-8411-0ba9ec3551e0@linux.dev>
Date: Mon, 3 Jun 2024 11:04:28 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Patch "drm: zynqmp_dpsub: Always register bridge" has been added
 to the 6.9-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Michal Simek <michal.simek@amd.com>
References: <20240603114605.1823279-1-sashal@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240603114605.1823279-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Sasha,

Please also pick [1] when it is applied.

--Sean

[1] https://lore.kernel.org/all/974d1b062d7c61ee6db00d16fa7c69aa1218ee02.1716198025.git.christophe.jaillet@wanadoo.fr/

On 6/3/24 07:46, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     drm: zynqmp_dpsub: Always register bridge
> 
> to the 6.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      drm-zynqmp_dpsub-always-register-bridge.patch
> and it can be found in the queue-6.9 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit d6817dc61b3b6a1e4f098b25109e7f2ecaaf0ee8
> Author: Sean Anderson <sean.anderson@linux.dev>
> Date:   Fri Mar 8 15:47:41 2024 -0500
> 
>     drm: zynqmp_dpsub: Always register bridge
>     
>     [ Upstream commit be3f3042391d061cfca2bd22630e0d101acea5fc ]
>     
>     We must always register the DRM bridge, since zynqmp_dp_hpd_work_func
>     calls drm_bridge_hpd_notify, which in turn expects hpd_mutex to be
>     initialized. We do this before zynqmp_dpsub_drm_init since that calls
>     drm_bridge_attach. This fixes the following lockdep warning:
>     
>     [   19.217084] ------------[ cut here ]------------
>     [   19.227530] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>     [   19.227768] WARNING: CPU: 0 PID: 140 at kernel/locking/mutex.c:582 __mutex_lock+0x4bc/0x550
>     [   19.241696] Modules linked in:
>     [   19.244937] CPU: 0 PID: 140 Comm: kworker/0:4 Not tainted 6.6.20+ #96
>     [   19.252046] Hardware name: xlnx,zynqmp (DT)
>     [   19.256421] Workqueue: events zynqmp_dp_hpd_work_func
>     [   19.261795] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>     [   19.269104] pc : __mutex_lock+0x4bc/0x550
>     [   19.273364] lr : __mutex_lock+0x4bc/0x550
>     [   19.277592] sp : ffffffc085c5bbe0
>     [   19.281066] x29: ffffffc085c5bbe0 x28: 0000000000000000 x27: ffffff88009417f8
>     [   19.288624] x26: ffffff8800941788 x25: ffffff8800020008 x24: ffffffc082aa3000
>     [   19.296227] x23: ffffffc080d90e3c x22: 0000000000000002 x21: 0000000000000000
>     [   19.303744] x20: 0000000000000000 x19: ffffff88002f5210 x18: 0000000000000000
>     [   19.311295] x17: 6c707369642e3030 x16: 3030613464662072 x15: 0720072007200720
>     [   19.318922] x14: 0000000000000000 x13: 284e4f5f4e524157 x12: 0000000000000001
>     [   19.326442] x11: 0001ffc085c5b940 x10: 0001ff88003f388b x9 : 0001ff88003f3888
>     [   19.334003] x8 : 0001ff88003f3888 x7 : 0000000000000000 x6 : 0000000000000000
>     [   19.341537] x5 : 0000000000000000 x4 : 0000000000001668 x3 : 0000000000000000
>     [   19.349054] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff88003f3880
>     [   19.356581] Call trace:
>     [   19.359160]  __mutex_lock+0x4bc/0x550
>     [   19.363032]  mutex_lock_nested+0x24/0x30
>     [   19.367187]  drm_bridge_hpd_notify+0x2c/0x6c
>     [   19.371698]  zynqmp_dp_hpd_work_func+0x44/0x54
>     [   19.376364]  process_one_work+0x3ac/0x988
>     [   19.380660]  worker_thread+0x398/0x694
>     [   19.384736]  kthread+0x1bc/0x1c0
>     [   19.388241]  ret_from_fork+0x10/0x20
>     [   19.392031] irq event stamp: 183
>     [   19.395450] hardirqs last  enabled at (183): [<ffffffc0800b9278>] finish_task_switch.isra.0+0xa8/0x2d4
>     [   19.405140] hardirqs last disabled at (182): [<ffffffc081ad3754>] __schedule+0x714/0xd04
>     [   19.413612] softirqs last  enabled at (114): [<ffffffc080133de8>] srcu_invoke_callbacks+0x158/0x23c
>     [   19.423128] softirqs last disabled at (110): [<ffffffc080133de8>] srcu_invoke_callbacks+0x158/0x23c
>     [   19.432614] ---[ end trace 0000000000000000 ]---
>     
>     Fixes: eb2d64bfcc17 ("drm: xlnx: zynqmp_dpsub: Report HPD through the bridge")
>     Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>     Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>     Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>     Link: https://patchwork.freedesktop.org/patch/msgid/20240308204741.3631919-1-sean.anderson@linux.dev
>     (cherry picked from commit 61ba791c4a7a09a370c45b70a81b8c7d4cf6b2ae)
>     Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> index 88eb33acd5f0d..face8d6b2a6fb 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> @@ -256,12 +256,12 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_dp;
>  
> +	drm_bridge_add(dpsub->bridge);
> +
>  	if (dpsub->dma_enabled) {
>  		ret = zynqmp_dpsub_drm_init(dpsub);
>  		if (ret)
>  			goto err_disp;
> -	} else {
> -		drm_bridge_add(dpsub->bridge);
>  	}
>  
>  	dev_info(&pdev->dev, "ZynqMP DisplayPort Subsystem driver probed");
> @@ -288,9 +288,8 @@ static void zynqmp_dpsub_remove(struct platform_device *pdev)
>  
>  	if (dpsub->drm)
>  		zynqmp_dpsub_drm_cleanup(dpsub);
> -	else
> -		drm_bridge_remove(dpsub->bridge);
>  
> +	drm_bridge_remove(dpsub->bridge);
>  	zynqmp_disp_remove(dpsub);
>  	zynqmp_dp_remove(dpsub);
>  


