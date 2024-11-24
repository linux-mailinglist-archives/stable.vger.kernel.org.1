Return-Path: <stable+bounces-95320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC4E9D768A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 18:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06AC2164D5C
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD24762EB;
	Sun, 24 Nov 2024 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mrhdaA5I"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252F553365
	for <stable@vger.kernel.org>; Sun, 24 Nov 2024 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732468732; cv=none; b=TqwTLuX9Wdd4ZumzWztWkM2rYY3P3cFqsYAxDq3xObvPlS991L2jF10jJF9wVAeNa4mFifvELmeCmGlgbfX+ZyUMOVEnE9sjEDYv5uF+hw3INkocVGkn0YM0k1rdnNS8ukxsW4ugHDyBZr+nrGlDNExfoD1csBqdNUSiL0G+mgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732468732; c=relaxed/simple;
	bh=ANAnCIYHAWmite6yRXvMGFMZIrDwaBsUx0Ghfk8jkLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JoDpjfTdqAGxRknR/2URHy3+yQqHDkIIgbgBCsteeU3Qo5Hd2ZNmDZGLi4PVUkks9siocQ2PoR8y7e3sVND+Nc7XIl1VIEqdNngLL15OD2Or0XjVZ7Kl80lTqW9owCU5Qh2+EBjAuOAH1nYADOHaBqMBIlR6pyN/T3UdEHFneA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mrhdaA5I; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e2828b26-8ee9-4140-a377-647f5ae12e2f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732468723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ieKeNrjRlWIp/ahnSzxx5vcgmp88GQGFoU97oRvhtNg=;
	b=mrhdaA5IQLSwh/ZdBDKZw/omZH5HciRWHjkJoprV2SXDl4T5dBeGXVTz61hTN0zhjK6GDm
	ybbVdOotVhexvWgHgydcXCP1lI7FuX6DegRitY+q9oN1Ark9xmK+ub7lO7C3OY/m///6xM
	iWQcXEZPcEH5Ot9ojIVqgUnNthGhIcA=
Date: Sun, 24 Nov 2024 22:48:35 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/7] drm/tidss: Fix issue in irq handling causing
 irq-flood issue
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Devarsh Thakkar <devarsht@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jonathan Cormier <jcormier@criticallink.com>, Bin Liu <b-liu@ti.com>,
 stable@vger.kernel.org
References: <20241021-tidss-irq-fix-v1-0-82ddaec94e4a@ideasonboard.com>
 <20241021-tidss-irq-fix-v1-1-82ddaec94e4a@ideasonboard.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
In-Reply-To: <20241021-tidss-irq-fix-v1-1-82ddaec94e4a@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Tomi, Devarsh,

On 10/21/24 19:37, Tomi Valkeinen wrote:
> It has been observed that sometimes DSS will trigger an interrupt and
> the top level interrupt (DISPC_IRQSTATUS) is not zero, but the VP and
> VID level interrupt-statuses are zero.

Does this mean that there was a legitimate interrupt that potentially
went unrecognized? Or that there was a, for the lack of a better word,
fake interrupt trigger that doesn't need handling but just clearing?

> 
> As the top level irqstatus is supposed to tell whether we have VP/VID
> interrupts, the thinking of the driver authors was that this particular
> case could never happen. Thus the driver only clears the DISPC_IRQSTATUS
> bits which has corresponding interrupts in VP/VID status. So when this
> issue happens, the driver will not clear DISPC_IRQSTATUS, and we get an
> interrupt flood.
> 
> It is unclear why the issue happens. It could be a race issue in the
> driver, but no such race has been found. It could also be an issue with
> the HW. However a similar case can be easily triggered by manually
> writing to DISPC_IRQSTATUS_RAW. This will forcibly set a bit in the
> DISPC_IRQSTATUS and trigger an interrupt, and as the driver never clears
> the bit, we get an interrupt flood.
> 
> To fix the issue, always clear DISPC_IRQSTATUS. The concern with this
> solution is that if the top level irqstatus is the one that triggers the
> interrupt, always clearing DISPC_IRQSTATUS might leave some interrupts
> unhandled if VP/VID interrupt statuses have bits set. However, testing
> shows that if any of the irqstatuses is set (i.e. even if
> DISPC_IRQSTATUS == 0, but a VID irqstatus has a bit set), we will get an
> interrupt.

Does this mean if VID/VP irqstatus has been set right around the time
the equivalent DISPC_IRQSTATUS bit is being cleared, the equivalent
DISPC_IRQSTATUS bit is going to get set again, and make the driver
handle the event as we expect it to?

> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Co-developed-by: Bin Liu <b-liu@ti.com>
> Signed-off-by: Bin Liu <b-liu@ti.com>
> Co-developed-by: Devarsh Thakkar <devarsht@ti.com>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> Co-developed-by: Jonathan Cormier <jcormier@criticallink.com>
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/tidss/tidss_dispc.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index 1ad711f8d2a8..f81111067578 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -780,24 +780,20 @@ static
>  void dispc_k3_clear_irqstatus(struct dispc_device *dispc, dispc_irq_t clearmask)
>  {
>  	unsigned int i;
> -	u32 top_clear = 0;
>  
>  	for (i = 0; i < dispc->feat->num_vps; ++i) {
> -		if (clearmask & DSS_IRQ_VP_MASK(i)) {
> +		if (clearmask & DSS_IRQ_VP_MASK(i))
>  			dispc_k3_vp_write_irqstatus(dispc, i, clearmask);
> -			top_clear |= BIT(i);
> -		}
>  	}
>  	for (i = 0; i < dispc->feat->num_planes; ++i) {
> -		if (clearmask & DSS_IRQ_PLANE_MASK(i)) {
> +		if (clearmask & DSS_IRQ_PLANE_MASK(i))
>  			dispc_k3_vid_write_irqstatus(dispc, i, clearmask);
> -			top_clear |= BIT(4 + i);
> -		}
>  	}

nit: Maybe these for-loop braces could be dropped as well.

Otherwise, LGTM,

Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>

Regards
Aradhya


[..]

