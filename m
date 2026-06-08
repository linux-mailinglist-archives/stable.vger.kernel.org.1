Return-Path: <stable+bounces-262098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id onQLBU8RJ2p5rAIAu9opvQ
	(envelope-from <stable+bounces-262098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 21:00:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DEC659EF4
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 21:00:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=MMfof25i;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262098-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262098-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=collabora.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 143CC300F53E
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 18:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF2B3E51D3;
	Mon,  8 Jun 2026 18:43:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8583E51D7;
	Mon,  8 Jun 2026 18:43:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944237; cv=pass; b=XGrgRhPLUHw3gE9QoBkK8ECQhvluC+vM5oK6wwZozE6+iS/SbMFOIXQOInwNB4s2irDJO7br0/RZd/qxGJo+JXoPOI7vtyY6/VXKxnBYxcK9KfWOKy1BtmV+UGcQdimNxXcxoXJEZLxu2of6M2qKOVqRcujI9CfmSKI2mijUoro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944237; c=relaxed/simple;
	bh=LAAEL/uQvQLUyYsSEgmE451cvsCdy5wNdAbM934OQwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJUdInIx0bK7/Xhqq2gnoeK9y6KikF1xodthX28Ox7xysg6hlwWVy4tGN5b3Y32O3M/rjHnpR0jHd2VbE+Lqaw5mOQebgh/GjsJ0B4bwNtr2SOcURUjmApWMX2hNubAOteiqxXcib2oXMSreQQ/Ys2AciB7mN62EJi0AjiLtm8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=MMfof25i; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1780944216; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P2rvk3o8Jv1SXwelTg391zoiLcoauDOizR9xIcTkZg0GMr4xq8jytbwVBcW2maVin2SwVq4Q6wvTebYivPAsGgJY78IY2oLLCbWooJ2v6jTTL0uf02rmrP/Xl5bNOvKyhx9Gm7c88Qela+tr0VItL+2dIOUcIVjchPtv81e7NEM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780944216; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1TItcepfYVHjxsSTVOZI5lwtRS8/gPoghn4XLWwtdUc=; 
	b=FI2jyiMUCVzCeZwfh4Qr7rU+8KoFcs6pMfHHqqL91MatUiKiMc9z7GA9eXcIcK2esRwL08Y21R4/ucIlzW8cZf1e8Kom9BFBWu4QxOEKa9HYRWpw23ebs9Gar5jB36d/cx7BvkY3n20mipVFjgSKlElRqXXQd5aFg14whZ1Lc5I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780944216;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1TItcepfYVHjxsSTVOZI5lwtRS8/gPoghn4XLWwtdUc=;
	b=MMfof25iAZEbEIB2WmXXV7HiT05vkJQXjWSS0yIy/nBY6as/QNxvPiwdg5Fk/GPG
	K+Km6PEAGC626xVYwsiRA7iE7/iuqPnQQzcQsqrv77wvRArTmkcokUESrzHx0cJrUxF
	/m/J8/uQWsEs4+O9Kw1zhgWV/QdmOpWnIFra6uIw=
Received: by mx.zohomail.com with SMTPS id 1780944213677272.5663450188657;
	Mon, 8 Jun 2026 11:43:33 -0700 (PDT)
Message-ID: <fbac3db0-2ed3-460e-b638-ed46a64f358a@collabora.com>
Date: Mon, 8 Jun 2026 21:43:29 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: fix dma_fence refcount leak on error in
 virtio_gpu_dma_fence_wait()
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@redhat.com, kraxel@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 simona@ffwll.ch
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260607090303.92423-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260607090303.92423-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-262098-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:airlied@redhat.com,m:kraxel@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:simona@ffwll.ch,m:gurchetansingh@chromium.org,m:olvaffe@gmail.com,m:dri-devel@lists.freedesktop.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dmitry.osipenko@collabora.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[chromium.org,gmail.com,lists.freedesktop.org,lists.linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.osipenko@collabora.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,collabora.com:dkim,collabora.com:mid,collabora.com:from_mime,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75DEC659EF4

On 6/7/26 12:03, Wentao Liang wrote:
> dma_fence_unwrap_for_each() internally calls dma_fence_unwrap_first()
> which does cursor->chain = dma_fence_get(head), taking an extra
> reference. On normal loop completion, dma_fence_unwrap_next()
> releases this via dma_fence_chain_walk() -> dma_fence_put().
> 
> When virtio_gpu_do_fence_wait() fails and the function returns early
> from inside the loop, the cursor->chain reference is never released.
> This is the only caller in the entire kernel that does an early return
> inside dma_fence_unwrap_for_each.
> 
> Add dma_fence_put(itr.chain) before the early return.
> 
> Cc: stable@vger.kernel.org
> Fixes: eba57fb5498f ("drm/virtio: Wait for each dma-fence of in-fence array individually")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/virtio/virtgpu_submit.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
> index dae761fa5788..32cb1e4aa425 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_submit.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
> @@ -65,8 +65,10 @@ static int virtio_gpu_dma_fence_wait(struct virtio_gpu_submit *submit,
>  
>  	dma_fence_unwrap_for_each(f, &itr, fence) {
>  		err = virtio_gpu_do_fence_wait(submit, f);
> -		if (err)
> +		if (err) {
> +			dma_fence_put(itr.chain);
>  			return err;
> +		}
>  	}
>  
>  	return 0;

Applied to misc-fixes, thanks!

-- 
Best regards,
Dmitry

