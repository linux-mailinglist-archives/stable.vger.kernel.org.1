Return-Path: <stable+bounces-216771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOYaM1kylGkNAgIAu9opvQ
	(envelope-from <stable+bounces-216771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 10:18:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF8214A4D7
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 10:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D79F3023A60
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 09:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB86302779;
	Tue, 17 Feb 2026 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgDqj/XV"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B383430274B
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319882; cv=none; b=r4TPtXd8OygkcnJbZBl9ux8z2PyRJKaCN7LlMm75UNntyA2yJLRdJx7eixvo8zqdBBowg9iPmNnhgz4jBwSi7loj9GixEqFlpP4DWt92kzgHvJ4++e6icFqCaShQImvySIVHpzICCt/R2jrcv7Qpsp6mT50+PDcg8TDOxlIviGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319882; c=relaxed/simple;
	bh=uovPVI/DUAp2MRXl1xQ7HbOjSw0yaNs43XWyTeYWhZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvbECWOjsPeXejknMwyA5WNTftO3MaV5vaBP6zzAZXsf8VCMMZihcjbB7vryxH0DuL+Rml3zQnTuFvUZ2+ZWWRFvzys9Ssay4SbakFBcBBaLhmXCT6Y/XXF1XyOpjSlo+9OGHyuwOaHFu/o1v/yQ0wZaOPUVHJUL8iaAx1WhhDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgDqj/XV; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb3bae8d3eso414272385a.1
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 01:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771319880; x=1771924680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQC4QGyn7yz+oQacobtpM7v4lkiFx0ImzuBkcxsb/Rg=;
        b=EgDqj/XVa16XXGpNlaTD7QI3SjX2e66aSFwCkV41z81etID1eEf/zIi5y2AIZIxd5I
         lfLMKqnMzGkXTzKStbDcEjor7mBZ3oj5yEdao7Mme7y2+1PQbR8WINlFxyX1+KM4EUDD
         gPkFAkgZ/d6w4vkIkAlMjuSmkTTp6hKjADtcD7hxbM8+U3dpqop/UdECLxqBm0vSfJH4
         9RV/GlQDwCXC6SxJXsjsZGoGQB3g+Emvo3uxwJVNRKnq8RVil1Y8g8QnL9hjZeZN4ysj
         dGfg+v8HVv8tkLO3svYvZUxiD2lLKSTMDcPBzygnOH9HIc0neW0VzVdMxv9Aq2QFFc8o
         Pd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771319880; x=1771924680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQC4QGyn7yz+oQacobtpM7v4lkiFx0ImzuBkcxsb/Rg=;
        b=HVLXj4np5kUGre23PzC3Z2RiVufTCNIYYvcphuLoiV6ArtDnetuZ6SnuyP9Hv7KcVG
         XXnNCcMFe1r1fON3ZwcZeF/4NRy91y5KAwdPDyShQ5LdlGRVgyZklPi1cEJOmbb8KarD
         22kwnak1HZ+E7LR8fSUOBfk0Vjel5GTIxEfJ2eyRolKHA4Im2dwjv9fZ8Z9jufJvgeqC
         /la6p8JV3lDGr9vXpSM2yS1uvpkbf7SFJXJjF2JkkUh/rO7k+aCdbOWeWhYe4mRm+t2Z
         5oJ3ZIVUeG+IUYckt7CchbAhPl41ECpDkiabW2HmQRVf9Mv47Ee3OFfjtLn/g29mOfSR
         WgFA==
X-Forwarded-Encrypted: i=1; AJvYcCXc+J10sRTYOhPr/hr5ESpj2qCno74QBnfLGztualjbMx6R8E5ExScmoyND+EEe8Uk2hgRYg9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiDcXNrX8HErnId8XfaXwieRc2ZQ1Ioj6XjTq+KZ+ksJlMdtkJ
	wYcPvx/A3Q9LR9GgXSPs/vWvhPCavOzdbUITri7fXwKPtRZnurfvnP48
X-Gm-Gg: AZuq6aI+uzB/kalb7+VXnt0QMRGzjKJdvvrH+r4ptOmpWxB/wG6mgNtbbezdqHuSR8b
	HL4K8plNnBYlp3eGzL5a8395sc3w0efqtkVa06jbIhBaW9FAw7LlJyWnFuhIxpK2bUSocO8AZ8i
	1Ka8i8kW/f7o1ytEftUCZgsIA+L0LrvijOw0QmbgTfV8xRf7ila/0BwSjEIVZPW68UmoiHUlReP
	8UruHXlrxhinS1cXAq90q5oVxzocnElyF6F9ZYXUhRiaNUpZJLZrLoFlsGlVUAN/UPS5YoFnbqG
	ScjEJn62KtLhFYof6Et87YThk4yS7YVbhZK3YzuNWkp66lc+rUP5FTcMY819vfS+L5QBA07mBcQ
	aXxhYKjochY2XhmJRZg4LhjuWt/MMe9pgvEuaXYCZq6rI/nwte43Rh23pLfvNnoH+OStFuoAorm
	6+SgUs2cqKemvDcSodVcebzuCZAt0UmL8vm9Yyzzu1KQTZLuWNRGfbPg==
X-Received: by 2002:a05:622a:4d0:b0:506:98c9:a3e5 with SMTP id d75a77b69052e-506a6a4c880mr163726741cf.35.1771319879599;
        Tue, 17 Feb 2026 01:17:59 -0800 (PST)
Received: from [10.254.121.53] (mkmvpn.amd.com. [165.204.54.211])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50684bc39e6sm174448991cf.31.2026.02.17.01.17.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Feb 2026 01:17:59 -0800 (PST)
Message-ID: <285b8a06-9b61-4a92-8b4b-206537d10dbb@gmail.com>
Date: Tue, 17 Feb 2026 10:17:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Prevent cursor bo's from being pinned to
 VRAM address zero
To: Mario Kleiner <mario.kleiner.de@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20260216044735.6814-1-mario.kleiner.de@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20260216044735.6814-1-mario.kleiner.de@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216771-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ckoenigleichtzumerken@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EF8214A4D7
X-Rspamd-Action: no action

On 2/16/26 05:47, Mario Kleiner wrote:
> Why?
> 
> On some AMD gpu's in some configurations, the start of the VRAM domain, as
> reported by amdgpu_ttm_domain_start(adev, AMDGPU_GEM_DOMAIN_VRAM), is
> placed at address 0 during GMC init. This is a problem if, during a cursor
> plane update, the cursor image bo, which gets always pinned into VRAM,
> is placed at offset zero of the VRAM domain, and thereby at the
> absolute address afb->address 0.
> 
> The display hw apparently doesn't like such a zero start address for at
> least native cursor mode, as various checks inside DC are in place, e.g.,
> high level dc_stream_check_cursor_attributes(), and lower level DCN
> version specific cursor hw programming checks, which do reject cursor
> attribute updates with attributes->address.quad_part == 0.
> 
> User visible symptoms of this are seriously broken mouse cursors under
> both X11 and Wayland (tested with KDE/KWin, GNOME/Mutter, GDM login
> manager): Mouse cursor flickers, is invisible, randomly becomes invisible,
> or fails to adapt the cursor shape to the context, e.g., when moving from
> a text input field to other windows, or window decorations etc. This makes
> the cursor irritating and impossible to use.
> 
> The drm.debug=4 log shows DRM KMS debug messages of the form
> "DC: Cursor address is 0!", and the general syslog prints errors like
> "[drm:amdgpu_dm_plane_handle_cursor_update [amdgpu]] *ERROR* DC failed to
> set cursor attributes"
> 
> I observe this bug on my dual-gpu Apple 2017 MacBookPro since Linux 4.11,
> where the kernels early EFI setup force-enables both the Intel iGPU and
> AMD dGPU. This leads to the AMD VRAM start being placed at 0x0 and then
> causes massive cursor problems. On earlier kernels, only the AMD dGPU was
> exposed, the Intel iGPU was disabled / hidden from Linux by EFI firmware.
> This caused the AMD gpu to place VRAM start at the non-zero
> address 0x000000F400000000, and the mouse cursor worked fine. I confirmed
> with umr that the mmMC_VM_FB_LOCATION register of my Polaris 11 gpu indeed
> read back 0x0000 in the lower 16 bits in the dual-gpu case, causing
> gmc_v8_0_vram_gtt_location() to setup start of VRAM domain at zero.
> I don't know what causes the change, but most likely the UEFI firmware
> somehow triggers this change before main kernel boot - calling into the
> VBIOS, I guess.
> 
> There is at least one 8 months old bug report in AMD's issue tracker,
> reporting the same symptoms on other AMD setups, cfe.:
> https://gitlab.freedesktop.org/drm/amd/-/issues/4302

Wow, impressive debugging work. That is a really good catch!

> So unless there is another more clean and reliable way to prevent the
> cursor bo from being placed at address zero, or unless the display hw
> is actually fine with address zero and those checks in DC are overly
> cautious, this needs to be fixed.

I don't know the DCN block that well, but I'm pretty sure the assumption in the DC code that the cursor address can't be zero is simply incorrect.

> Note that simply removing the "zero address -> reject cursor update"
> checks worked on my Polaris11 with DCE 11.2 display engine, fixing the
> cursor without causing any other obvious trouble. So maybe this is only
> a limitation of recent DCN engine versions, or a pointless check.

My educated guess is you just missed some check, explicitely checking if the addr is zero would make the HW more complex and that is usually something HW engineers try to avoid really hard.

In other words you usually have a separate "valid" bit in a register somewhere instead of the HW checking for a specific value.

> How?
> 
> Add a new AMD bo placement flag which requests bo pinning / placement at
> non-zero VRAM address only during amdgpu_bo_pin(). Use this flag for bo's
> on the cursor plane during amdgpu_dm_plane_helper_prepare_fb().
> 
> I don't know if this is the best approach. It feels hacky, but it is the
> only approach I was able to do and it seems to work fine enough.
> 
> If this is a good enough fix, it should be backported, but backporting
> to earlier than Linux 6.12 might be cumbersome due to changes to the
> amdgpu_bo_pin() implementation.

I strongly suggest to follow Alex workaround for now, but maybe add a big code comment explaining why we have that.

Regards,
Christian.

> Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Tested-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c            | 11 +++++++++++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  6 ++++--
>  include/uapi/drm/amdgpu_drm.h                         |  7 +++++++
>  3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 1fb956400696..97131fc8fbdf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -975,6 +975,17 @@ int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain)
>  		if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
>  		    bo->placements[i].mem_type == TTM_PL_VRAM)
>  			bo->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
> +
> +		/* Ensure bo is never pinned at amdgpu_bo_gpu_offset() == 0
> +		 * for VRAM allocations, as some of the DC code does not
> +		 * like that, e.g., mouse cursor display image bo's.
> +		 */
> +		if (bo->flags & AMDGPU_GEM_CREATE_VRAM_NON_ZERO_ADDRESS &&
> +		    bo->placements[i].mem_type == TTM_PL_VRAM &&
> +		    !bo->placements[i].fpfn &&
> +		    !amdgpu_ttm_domain_start(adev, TTM_PL_VRAM)) {
> +			bo->placements[i].fpfn = 1;
> +		}
>  	}
>  
>  	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 394880ec1078..cd7f53d3036c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -959,10 +959,12 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
>  		goto error_unlock;
>  	}
>  
> -	if (plane->type != DRM_PLANE_TYPE_CURSOR)
> +	if (plane->type != DRM_PLANE_TYPE_CURSOR) {
>  		domain = amdgpu_display_supported_domains(adev, rbo->flags);
> -	else
> +	} else {
>  		domain = AMDGPU_GEM_DOMAIN_VRAM;
> +		rbo->flags |= AMDGPU_GEM_CREATE_VRAM_NON_ZERO_ADDRESS;
> +	}
>  
>  	rbo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>  	r = amdgpu_bo_pin(rbo, domain);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 1d34daa0ebcd..6dee7653c54e 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -181,6 +181,13 @@ extern "C" {
>  #define AMDGPU_GEM_CREATE_EXT_COHERENT		(1 << 15)
>  /* Set PTE.D and recompress during GTT->VRAM moves according to TILING flags. */
>  #define AMDGPU_GEM_CREATE_GFX12_DCC		(1 << 16)
> +/* Flag that BO must not be placed in VRAM domain at offset zero if the
> + * VRAM domain itself starts at address zero.
> + *
> + * Used internally to prevent placement of cursor image BO at that location,
> + * as the display hardware doesn't like that for hardware cursors.
> + */
> +#define AMDGPU_GEM_CREATE_VRAM_NON_ZERO_ADDRESS (1 << 17)
>  
>  struct drm_amdgpu_gem_create_in  {
>  	/** the requested memory size */


