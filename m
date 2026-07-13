Return-Path: <stable+bounces-273878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xCMpIiwQVWpBjgAAu9opvQ
	(envelope-from <stable+bounces-273878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 18:19:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F1974D85F
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 18:19:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=VNlQsw9J;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273878-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273878-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=collabora.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A365F3049E1E
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 16:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BD33F413E;
	Mon, 13 Jul 2026 16:18:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A500339872;
	Mon, 13 Jul 2026 16:18:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959510; cv=pass; b=brfFeYoQyEKp6ID6U1ioLZs07hqJdtvqULU0j2i2urIfJnoD07xg08cBBxSaY72T9OAsO0izDPEhvXRxeERD2OGdYLlAIOyxVv47P2oPfwc5yHDIPXzZPsu1oEP+dGnZDmRX5Mbvzn9qPOG9AWMqvpmBSdd5B6bdwEqOy+ufc0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959510; c=relaxed/simple;
	bh=MDnJQKJbccup7eQA9NUb0j+v7/4PCyahAr6LdgyYPTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1R4At8jx/LEVmRrAJ9p88D1c1Fhyk40cgtebo1mDPNstRVvxXk4i8zoWzX+LurxHY7rIsW5vfDyXy+Qn8UfrcmkWEvtIF/rchng0A9LnGaqo6u5OvE692laKDgNMxTnuwBSTSh8iI8S5gW1xgBB4CflUJEeGTu50BLf6fx+GCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=VNlQsw9J; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783959498; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lgDVtytGLlN0y8fHBEBHfbb5uHP8X5/45bErC93a/x2Jl2INqbyqaJSSdeNibrMh3Y/0o1kMJAVDC10a1YdBXZ8dS8MK9ulVWmIFGNYqHX/WiAYoY+RBw8t2mDj1k3IXoYMHjgvNoCnIvxgwluCoEbUo+R6UPFwQr58PFG6GeWg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783959498; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lniYWsZgOOiMUaNjxoy7acQxun7Tot8w2aRKqsFovEQ=; 
	b=cp+FRW+rAJz4X5Rs2ONRmYNEIq7aQ/5EXjTqqT2EQc38TbEPfp1IKAPYkqy74Kr9K1ne4w4p1SLyzgXftuCCiqwde9psGhHIa2K0mOUouv2ri9EeMS8UQbw18GnH+5YISPOHCWAtFAIPtdVK+013hRbotL+M6y7Ep+jyyiwce3U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783959498;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=lniYWsZgOOiMUaNjxoy7acQxun7Tot8w2aRKqsFovEQ=;
	b=VNlQsw9JLVxFTTdLCKyoWOZ93rVmHAwcnDA5foFdXSyePo8dWUovv3S9r977h6Ig
	Y/11SLmVjJjaQ3fShVCf9Smpm2NGMCut9O2lBOyytTyXDHt5DhbuR8CvMXEh5ReY/3a
	1ZcPI4JDF74M0NjBgfZP2UA5Yjr5doCDt1nxVfRM=
Received: by mx.zohomail.com with SMTPS id 1783959496461525.9083738973383;
	Mon, 13 Jul 2026 09:18:16 -0700 (PDT)
Message-ID: <3198148a-0343-4fcd-b671-809d33f541bd@collabora.com>
Date: Mon, 13 Jul 2026 19:18:12 +0300
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
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Yiwei Zhang <zzyiwei@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273878-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[dmitry.osipenko@collabora.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:natsu@google.com,m:airlied@redhat.com,m:kraxel@redhat.com,m:gurchetansingh@chromium.org,m:zzyiwei@google.com,m:dri-devel@lists.freedesktop.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:from_mime,collabora.com:dkim,collabora.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18F1974D85F

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
>  

Applied to misc-fixes, thanks!

-- 
Best regards,
Dmitry

