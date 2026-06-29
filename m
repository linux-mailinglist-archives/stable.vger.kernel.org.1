Return-Path: <stable+bounces-269835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +QeBHgLmQmqQHQoAu9opvQ
	(envelope-from <stable+bounces-269835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 23:39:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C89F96DEEC5
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 23:39:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=imviU+FJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269835-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269835-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=collabora.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E3B13023DE8
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 21:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9893CA4A0;
	Mon, 29 Jun 2026 21:39:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164103AE1A9;
	Mon, 29 Jun 2026 21:39:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782769150; cv=pass; b=UZI+TdEnyDapiW0KsfK8w0oBHAJkkfONio79sS4OUCDTMUknQSN/MWTUb84gaDeOwVOul/m0+BhyYfRlNL8Jappk+30LecP0RAcCKGdVf7zC8MFJqJILMnyjOMvOp3QpL2bNgCxRDPs/nuNonDI+LT//M2fKnec11A9kon1C0M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782769150; c=relaxed/simple;
	bh=MG7URKinLILQgqbXAb09lkk9Apc2dNsIP7hZWloi3ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rF/MN+tjAyI47OA9hJsQwvpxyzNdqd5PwIPt10sUHlWn8yVC1r1cDJ7Oya/DlRZuHISIwCAFFyGFiNHiE4d9C9kekbTzd6Kt+N10+1/OQU/ig+oMx/9W8KKdJt164gtzMSoYO3NbUJP4tstnnf9VEBEH0RHhr1t7rArPyoFb2G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=imviU+FJ; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1782769140; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DD/G1CVE2B7GRYG27hevrGTBCBUP1rcQjQvxFbuW/RfJ6BAdLNR38g1SsBl16uXFxv+wYk8FAJ5sVAdwrSSWKDQXQpLFvGRW1vd/NiVnko+G65ObN+CxGz9rZjtfMeJso9u/JeFjiiHGkHhXNLIAwRUEwaRQAlXyxOlm6ppSFzE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782769140; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=V2dWuEpkhVjMLm2lL6us2OpMnJ/fy5SE2u+UJZd6w+A=; 
	b=RRlCaK/WngedPTBqZDaiRyn9RHPWfXwDvw7G+zK4WRKIxMPqy9dH1u6REDwFeEzMLfWY9bLj/MY7n3zIt0DzlcrqdRLeltMv0rA07APljGu+LWb6cYHLjcYjP9/JcJ8Ug9WlrJJa5UmPA3HNN4wfTnsLJN8ylcXifi+U0RfO/O0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782769140;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=V2dWuEpkhVjMLm2lL6us2OpMnJ/fy5SE2u+UJZd6w+A=;
	b=imviU+FJpvekMZlnS7Pal/ELSKOzwENl6rbn16EmzQk4C/PmZvw3I/+JrF+k+mhr
	Z0F+4ZuT11T/VGsUQxJPh1UKNqXvXzfVfH4q81QhlT3UMejF9gl6KWVidFvfBYwD85e
	6dvbJiiHSohVPgq1p9vpdtETUIyBsa/5SPzAw1X8=
Received: by mx.zohomail.com with SMTPS id 1782769138029866.4526666587577;
	Mon, 29 Jun 2026 14:38:58 -0700 (PDT)
Message-ID: <7202d2dc-b6fe-440e-88b0-aefb26c38b86@collabora.com>
Date: Tue, 30 Jun 2026 00:38:54 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Don't detach GEM from a non-created context
To: Jason Macnak <natsu@google.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260625170828.3335431-1-natsu@google.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260625170828.3335431-1-natsu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269835-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[dmitry.osipenko@collabora.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:natsu@google.com,m:airlied@redhat.com,m:kraxel@redhat.com,m:gurchetansingh@chromium.org,m:dri-devel@lists.freedesktop.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.osipenko@collabora.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C89F96DEEC5

Hi,

On 6/25/26 20:08, Jason Macnak wrote:
> Applies the same treatment as commit 7cf6dd467e87 ("drm/virtio:
> Don't attach GEM to a non-created context in gem_object_open()")
> to virtio_gpu_gem_object_close() to avoid trying to detach
> a resource that was never attached due to a context
> never being created when context_init is supported.
> 
> Fixes: 086b9f27f0ab ("drm/virtio: Don't create a context with default param if context_init is supported")
> Cc: <stable@vger.kernel.org> # v6.14+
> Signed-off-by: Jason Macnak <natsu@google.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_gem.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
> index 435d37d36034..66c3f6f74e9c 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -139,13 +139,15 @@ void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
>  	if (!vgdev->has_virgl_3d)
>  		return;
>  
> -	objs = virtio_gpu_array_alloc(1);
> -	if (!objs)
> -		return;
> -	virtio_gpu_array_add_obj(objs, obj);
> +	if (vfpriv->context_created) {
> +		objs = virtio_gpu_array_alloc(1);
> +		if (!objs)
> +			return;
> +		virtio_gpu_array_add_obj(objs, obj);
>  
> -	virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
> -					       objs);
> +		virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
> +						       objs);
> +	}
>  	virtio_gpu_notify(vgdev);
>  }

The following scenario still will be troubling:

1. vgdev->has_context_init = true
2. virtio_gpu_gem_object_open() invoked, GEM created and not attached to ctx
3. virtio_gpu_context_init_ioctl() invoked, now vfpriv->context_created
= true
4. virtio_gpu_gem_object_close() will detach resource that wasn't attached

Add obj->ctx_attached member to struct virtio_gpu_object. See
virtio_gpu_object_attach() that uses obj->attached, do the same for
virtio_gpu_cmd_context_attach_resource().

-- 
Best regards,
Dmitry

