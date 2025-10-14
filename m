Return-Path: <stable+bounces-185609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E479BD84B9
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 10:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C65A44E51D1
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 08:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21472D248E;
	Tue, 14 Oct 2025 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOSdCEFN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26522D73BE
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432072; cv=none; b=rkAXhfqPnnmxfGFQ3IcmdFilVxFL1cVFzxt4ffxjxpT4k1afMCF3O/3GwrS00QpeAoPmmSMDCq+sAZygnsJRFGmFE7FnHOx18sVzcXDFGG9a8sjVK2naGhpoG1Le9OSZ5dtqKYjB7BSxgH7ZdHbQgDnRw+6q3TF6fY+XF+xAoCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432072; c=relaxed/simple;
	bh=cUl1QO68HpA4Pphs0fDbNPwsf587wWviVRMSWG0EdBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=giwPdJnI0kfty2otCu7qMxFEURw1Mp9dBV/vBgHhggWeMB4wjuLSHtOEbMOuHOdgBRKNOktCY4xVfLso7Qgb7a6oWzG78JBSzxCTJWW+BIqhPn8dawjoXuzbRxtxpE2tAHanXX4DKYqVtSDDTV6wbvzLwJK+PRWtynr/SQkkLkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOSdCEFN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760432069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAy88YMnGtIP/uqwpz5GQHTqHQIlvLAglo0Pv+LXXqc=;
	b=SOSdCEFN3QajJOqwlvggNPfUIlnd8j9fknf8OMRbDdIQpUrQBXEXwL0ZE4Ad0AhaBHkdYO
	RRbaOcf8xfSaA9XPbBSWIAY39OLIbr7XmqVrunqQi+CslHz7fqf6ss2rCQleQRX/x43wOV
	W02+D2cVtdwqrfWHqVz2YAUa2AmaLyE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-UKqINstkPnSJUqjlZPjckg-1; Tue, 14 Oct 2025 04:54:28 -0400
X-MC-Unique: UKqINstkPnSJUqjlZPjckg-1
X-Mimecast-MFC-AGG-ID: UKqINstkPnSJUqjlZPjckg_1760432067
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-426d2cd59e4so2955508f8f.1
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 01:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760432067; x=1761036867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAy88YMnGtIP/uqwpz5GQHTqHQIlvLAglo0Pv+LXXqc=;
        b=fsRRUTWNhGx+6YJ9w2Zh/tYxUOnU/1THhxi3DSS3h/i/g45Ff0aDcUY2dY92XqDWEv
         TurULFty+7R9B1aVAGJ5uxRvmizzquxooyTiJBJCUz4X2KKOKKQ7sCzgOgcs6bCeBdNe
         +FuuIdaUvhi6PnHTaOSnaVASVbKr2w+/tirk5rrN5IwTpHL8MtD3aUUhA6w/nY37qp2/
         R31Gn5G4YkWsX6BSVmF0sUiOnLU4/X3XpLglRPdbNtgzi+Uy9JrWhUBBQG26d1FG+JDN
         dwZU0ReXMg7busWBj1tu0ArRAVtmUzIIrAOH2vWY+Udflu4+X3Cs7Va5lq5CBpe1oHyC
         5WMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe/zpeG2qlQmkF8JlAUHvR1ldSIbEJ1rg46pdtcRb3/bwDHo4P+JqcZbO9X5Wdnbxyq/qdEiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzId8GKezAEiE6eqj0EzPL8n7n+fYc53G2RxKh3IKeZxfn+IO74
	rTU9k+5oYNf7upDqpp/400P5LDyO0vA41C3o3X+AkRL+pQx2L48abXkrO8QsW2HILPE9mto2f8m
	Aqbi7V2wk24zWapLNDVRtdx+AoBn4MG3InwiXhtjMiXYfaKI6G/4+0LDCVQ==
X-Gm-Gg: ASbGncvQzfEabYjbC2VcRil0lU/bUDtAKQot7kdk0vL7reQzV9vKVNo2Fnh3qnob5U5
	NX62P3N4LNr7ZgY0vj7/SWst/RfiZQkZDuGOuUWsAQm3y2EJ5mEMP2u7q+jvOVH/VisMCODpexX
	pZJsZtBZBcvw6vG3y/fcItlKGBPmJAwPUE+EWlzg+eMBlxx9WRTsWw/IUZg0HG0Rip4yZDiSIsX
	uTAkJDI7B6XNGlZDbsJ6FGGJ+XA+U51rfDq5pi54zOUtGAv9SP0pkwjVqgjpTrI0noN+Xz1jHgr
	qAfrELOnJUzPChI3SVGORtBxNCC8XNcCVW0TkSQCJtc3QPdBoC8guCrmTz8Z5vK0v7K6Z2ix/54
	pSDMZ
X-Received: by 2002:a05:6000:240d:b0:425:7c3c:82cf with SMTP id ffacd0b85a97d-4266e7cdc8fmr17010194f8f.11.1760432066929;
        Tue, 14 Oct 2025 01:54:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsn0T1UJGNN+DMCPRU7lJk5Itt5x7z0YHqju+V9yATaC5KHWal8J0l4vDY6qI1Yqyz0I9Uyg==
X-Received: by 2002:a05:6000:240d:b0:425:7c3c:82cf with SMTP id ffacd0b85a97d-4266e7cdc8fmr17010170f8f.11.1760432066481;
        Tue, 14 Oct 2025 01:54:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e833dsm22538021f8f.53.2025.10.14.01.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:54:26 -0700 (PDT)
Message-ID: <34466c59-cea5-4a09-9dfa-83e25dbc49eb@redhat.com>
Date: Tue, 14 Oct 2025 10:54:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ast: Blank with VGACR17 sync enable, always clear
 VGACRB6 sync off
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 dianders@chromium.org, nbowler@draconx.ca
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20251014084743.18242-1-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20251014084743.18242-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2025 10:46, Thomas Zimmermann wrote:
> Blank the display by disabling sync pulses with VGACR17<7>. Unblank
> by reenabling them. This VGA setting should be supported by all Aspeed
> hardware.
> 
> Ast currently blanks via sync-off bits in VGACRB6. Not all BMCs handle
> VGACRB6 correctly. After disabling sync during a reboot, some BMCs do
> not reenable it after the soft reset. The display output remains dark.
> When the display is off during boot, some BMCs set the sync-off bits in
> VGACRB6, so the display remains dark. Observed with  Blackbird AST2500
> BMCs. Clearing the sync-off bits unconditionally fixes these issues.
> 
> Also do not modify VGASR1's SD bit for blanking, as it only disables GPU
> access to video memory.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> v2:
> - init vgacrb6 correctly (Jocelyn)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: ce3d99c83495 ("drm: Call drm_atomic_helper_shutdown() at shutdown time for misc drivers")
> Tested-by: Nick Bowler <nbowler@draconx.ca>
> Reported-by: Nick Bowler <nbowler@draconx.ca>
> Closes: https://lore.kernel.org/dri-devel/wpwd7rit6t4mnu6kdqbtsnk5bhftgslio6e2jgkz6kgw6cuvvr@xbfswsczfqsi/
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.7+
> ---
>   drivers/gpu/drm/ast/ast_mode.c | 18 ++++++++++--------
>   drivers/gpu/drm/ast/ast_reg.h  |  1 +
>   2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
> index 6b9d510c509d..9b6a7c54fbb5 100644
> --- a/drivers/gpu/drm/ast/ast_mode.c
> +++ b/drivers/gpu/drm/ast/ast_mode.c
> @@ -836,22 +836,24 @@ ast_crtc_helper_atomic_flush(struct drm_crtc *crtc,
>   static void ast_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_state *state)
>   {
>   	struct ast_device *ast = to_ast_device(crtc->dev);
> +	u8 vgacr17 = 0x00;
> +	u8 vgacrb6 = 0xff;
>   
> -	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xb6, 0xfc, 0x00);
> -	ast_set_index_reg_mask(ast, AST_IO_VGASRI, 0x01, 0xdf, 0x00);
> +	vgacr17 |= AST_IO_VGACR17_SYNC_ENABLE;
> +	vgacrb6 &= ~(AST_IO_VGACRB6_VSYNC_OFF | AST_IO_VGACRB6_HSYNC_OFF);
> +
> +	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0x17, 0x7f, vgacr17);
> +	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xb6, 0xfc, vgacrb6);
>   }
>   
>   static void ast_crtc_helper_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_state *state)
>   {
>   	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(state, crtc);
>   	struct ast_device *ast = to_ast_device(crtc->dev);
> -	u8 vgacrb6;
> +	u8 vgacr17 = 0xff;
>   
> -	ast_set_index_reg_mask(ast, AST_IO_VGASRI, 0x01, 0xdf, AST_IO_VGASR1_SD);
> -
> -	vgacrb6 = AST_IO_VGACRB6_VSYNC_OFF |
> -		  AST_IO_VGACRB6_HSYNC_OFF;
> -	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xb6, 0xfc, vgacrb6);
> +	vgacr17 &= ~AST_IO_VGACR17_SYNC_ENABLE;
> +	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0x17, 0x7f, vgacr17);
>   
>   	/*
>   	 * HW cursors require the underlying primary plane and CRTC to
> diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
> index e15adaf3a80e..30578e3b07e4 100644
> --- a/drivers/gpu/drm/ast/ast_reg.h
> +++ b/drivers/gpu/drm/ast/ast_reg.h
> @@ -29,6 +29,7 @@
>   #define AST_IO_VGAGRI			(0x4E)
>   
>   #define AST_IO_VGACRI			(0x54)
> +#define AST_IO_VGACR17_SYNC_ENABLE	BIT(7) /* called "Hardware reset" in docs */
>   #define AST_IO_VGACR80_PASSWORD		(0xa8)
>   #define AST_IO_VGACR99_VGAMEM_RSRV_MASK	GENMASK(1, 0)
>   #define AST_IO_VGACRA1_VGAIO_DISABLED	BIT(1)


