Return-Path: <stable+bounces-269352-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bdezCnVlP2r0SgkAu9opvQ
	(envelope-from <stable+bounces-269352-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 07:53:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB3D6D13B7
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 07:53:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Tz1GJq1X;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269352-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269352-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66ABF301D961
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 05:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA915319852;
	Sat, 27 Jun 2026 05:53:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CFF13AA2D;
	Sat, 27 Jun 2026 05:53:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782539634; cv=none; b=efr5574ssjbTtlDwEQSa/6baXqJ6HhSoEsJod8gO3KcmlMu+6bwREjk0HkWejTdM4m0aoH5Djm3pbqsruFLo3lCpX4RT2/S8Qhb0P1oo2sJ47ji6YTuN0wsmiNsNfh25EwImOM9UHKtDJiEbRJStD+434UJUUOEfwdfycVysqJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782539634; c=relaxed/simple;
	bh=G0FkXdJLzyYIoHCSWSwOw2xpQzbT5rcDjYOazbKiTCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RoZjZy7UPs+OgIv6D06XzWLf4b/KJ0hfIGsQLAfHfQF3QqXuho3epridEMHxIp4WKyownKkYjhITkLanncTDwhPMaZNzbxyvPMFD3sAYD2RjhaVD2VK5q10WNC6sywFFiD5mtCTZSmNnVGoCsJarWsoMPLpFuLx+yhjbZDSvfZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tz1GJq1X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6302D1F000E9;
	Sat, 27 Jun 2026 05:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782539633;
	bh=y2XSyq3zGZGOpkJqqW0NdquWFNvEnloCi4JZ+AgNhN4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Tz1GJq1XTI30zHIi88et+AM4I5pSenf2DsPEkrTQaTh7PptDGh+k+TRHA+vkeoT3B
	 J0EnHmsMF5S7e4La7BnaYTv7FIRw689k0zwzHDhMx9gR6r4+yhhunojdvy/TgmSeFZ
	 XqgX0+ZJDmVjvbRJZZquJqEdQ48mM3XaGIJTnEtCJckQgtPaWe3g74hn5JNeFhyzCM
	 Rt7ZF6yqF1vVi6pf9qLa0NCNG3zagR2N5Drh/AmHldyo2TGn5IesjxYRBi9l3GwrvY
	 A68J5YCCcG1onvar6Xu7B8BMTWC4mXkVVZmZWV4mIvS7f/9bAwrMrF2rhGjolDoajg
	 ZpoNLhB4BsD7w==
Message-ID: <9f91ba0b-519b-48f3-822e-a2b08d7e6feb@kernel.org>
Date: Sat, 27 Jun 2026 00:53:51 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: Fix resource leak in
 amdgpu_gfx_run_cleaner_shader_job()
Content-Language: en-US
To: Wentao Liang <vulab@iscas.ac.cn>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Lijo Lazar <lijo.lazar@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260624124731.37479-1-vulab@iscas.ac.cn>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260624124731.37479-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:alexander.deucher@amd.com,m:christian.koenig@amd.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:lijo.lazar@amd.com,m:aurabindo.pillai@amd.com,m:xiaogang.chen@amd.com,m:amd-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[superm1@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[iscas.ac.cn,amd.com,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-269352-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[superm1@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AB3D6D13B7

On 6/24/26 07:47, Wentao Liang wrote:
> When amdgpu_job_alloc_with_ib() fails in
> amdgpu_gfx_run_cleaner_shader_job(), the function returns directly
> without destroying the scheduler entity, causing a resource leak.
> 
> Fix this by moving the entity cleanup to a common error path. Set r = 0
> on success and use a single cleanup point at the err label to ensure the
> entity is always destroyed regardless of whether the function succeeds
> or fails.
> 
> Also remove the unnecessary error check for dma_fence_wait() since it
> never fails with intr=false and infinite timeout.
> 
> Cc: stable@vger.kernel.org
> Fixes: 559a285816af ("drm/amdgpu: Replace 'amdgpu_job_submit_direct' with 'drm_sched_entity' in cleaner shader")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 523b681d0da9..29a07af6f5f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1689,9 +1689,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>   
>   	dma_fence_put(f);
>   
> -	/* Clean up the scheduler entity */
> -	drm_sched_entity_destroy(&entity);
> -	return 0;
> +	r = 0;
>   
>   err:
>       /* Clean up the scheduler entity */

What tree is this against?  It doesn't apply against amd-staging-drm-next.

Applying: drm/amdgpu: Fix resource leak in 
amdgpu_gfx_run_cleaner_shader_job()
Patch failed at 0001 drm/amdgpu: Fix resource leak in 
amdgpu_gfx_run_cleaner_shader_job()
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
error: patch failed: drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:1689
error: drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch

