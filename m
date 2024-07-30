Return-Path: <stable+bounces-62644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD25A940A12
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5ADB1C2340E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 07:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BB718EFFB;
	Tue, 30 Jul 2024 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diHIv3wb"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE3318EFF3
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325193; cv=none; b=q9VY3S3yWsSxeE74udvQa5xwsuQlXk4ccHLo33TYsO6WJuq2ShHD6iA1tPX6C9RTyE26xIEhX0IjikpjMEIvbYETNV35nI8tNTdWoC5m/VVwInv5PRJxnwgBQx4OshV78iwfL5QdG6peGxAdXTJftIGiJJIpOrep8g1QxVvumP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325193; c=relaxed/simple;
	bh=FIvn3VBhlItBKROtq0Sk5a20UG1sxhpe/DEFCdS6yTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FrBxryx8q1Wh1hmcu9KoUYw0f1n9vHEeZ1SUSQxYVFXP4+JXM+z/ia8VE4PJbbW5SUa8bpNT+OFRtijJhejWh6YEw3LgfxhsysGYBLp+QDxEtneTE4ZLr2/7i87BgoDuUvEUognjOkcCMhKu3OYHJI9CIL08kQSFlFvE5eCGRxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=diHIv3wb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722325190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aUZPwDjvCNuvdtbiS5aTn8Kyj+I15Nv8TBu2F0oVisY=;
	b=diHIv3wbD3Xf/PgcLAIzKrKkj3xuvvqJmBLtLOL5icVaaS/CT/2LaiwjAvNMw2ZZIg9x6B
	p5HpNvpAD/b4w7gXNgPuQB/44a4ccZ1j8U9TiBuXE+5MmSK5YgoOUeUcknc0w+fT6yv0jJ
	/GfuVOP2WNgfvCaDRH+CcTRG2d4eTrc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-TODrmbLvP_a1opaJEqD67A-1; Tue, 30 Jul 2024 03:39:48 -0400
X-MC-Unique: TODrmbLvP_a1opaJEqD67A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36875698d0dso1999101f8f.3
        for <stable@vger.kernel.org>; Tue, 30 Jul 2024 00:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722325187; x=1722929987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUZPwDjvCNuvdtbiS5aTn8Kyj+I15Nv8TBu2F0oVisY=;
        b=VnoC+wxVArEQ4vYkN9TeJhT7SWr9NXniUEWstDM45RJetS6OmhKcImkjXDwRKdVdpH
         IuQcvFVI2KrCezYCkccfJQq5TrttSIZMDMbDBBO6VL+0aRFDEGOOP5MyXqnuK1zyj/cQ
         R6YwnXBBQBPhsbE0eiyfG0d3KwnrKqyU8fMnohitKW0bVJMx1nJxHCtKr+Q1BeGf1swW
         T84xG7Q3QmINkmFU7V6MnMGaXo0vfTKqBMuHhekkfGg//Ekygu/uXxffRyUvST02d9vz
         PeVk0fvL+PvIAgtszNPtbGhDlH+34VexD3ljitTTJdScYrWtyQcYdeg25vEVRZKJjGg/
         RR6w==
X-Forwarded-Encrypted: i=1; AJvYcCVN1NF+So9vjuY2TpsxZqxPPbtRLlYqHU6zcndbpMcZ3lQbtNEeoilzIG+TncHLREJCx9aUOluwnlXzAf0547mnY+lDNY5X
X-Gm-Message-State: AOJu0Ywyuw4DZSg4qvai9R0fb2ThnRgAxsbAGQHsj/vWaaG+i49GUtiz
	zmI7bTs3KK0irLRb7hjUYBwzCDLmrR2J+/RkXu7w90XDeckFTiaT4IL1vhjCAN1+uQgU2pVdfQJ
	bf5B2CgZm+iCMhmBBEX7P5T1kYgx3iMJAOEk6faoKAVPnE4QFDsvodQ==
X-Received: by 2002:a5d:64ed:0:b0:368:6b28:5911 with SMTP id ffacd0b85a97d-36b5cefd512mr6645316f8f.2.1722325186655;
        Tue, 30 Jul 2024 00:39:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6FvzK9O4osBRDPn7KTIhgJWdregInCISkYcU6ZaQWQ+9Ipp/gxcHDxA2pnW/GZViF/YvC/w==
X-Received: by 2002:a5d:64ed:0:b0:368:6b28:5911 with SMTP id ffacd0b85a97d-36b5cefd512mr6645292f8f.2.1722325186194;
        Tue, 30 Jul 2024 00:39:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:d5:a000:d3ea:62cf:3052:fac6? ([2a01:e0a:d5:a000:d3ea:62cf:3052:fac6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b3686fdc5sm13798420f8f.114.2024.07.30.00.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 00:39:45 -0700 (PDT)
Message-ID: <b1d2c7da-a545-4963-9b74-fbd34c3ce089@redhat.com>
Date: Tue, 30 Jul 2024 09:39:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/ast: astdp: Wake up during connector status
 detection
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20240717143319.104012-1-tzimmermann@suse.de>
 <20240717143319.104012-2-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240717143319.104012-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/07/2024 16:24, Thomas Zimmermann wrote:
> Power up the ASTDP connector for connection status detection if the
> connector is not active. Keep it powered if a display is attached.
> 
> This fixes a bug where the connector does not come back after
> disconnecting the display. The encoder's atomic_disable turns off
> power on the physical connector. Further HPD reads will fail,
> thus preventing the driver from detecting re-connected displays.
> 
> For connectors that are actively used, only test the HPD flag without
> touching power.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Fixes: f81bb0ac7872 ("drm/ast: report connection status on Display Port.")
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.6+
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/ast/ast_dp.c   |  7 +++++++
>   drivers/gpu/drm/ast/ast_drv.h  |  1 +
>   drivers/gpu/drm/ast/ast_mode.c | 29 +++++++++++++++++++++++++++--
>   3 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
> index 1e9259416980..e6c7f0d64e99 100644
> --- a/drivers/gpu/drm/ast/ast_dp.c
> +++ b/drivers/gpu/drm/ast/ast_dp.c
> @@ -158,7 +158,14 @@ void ast_dp_launch(struct drm_device *dev)
>   			       ASTDP_HOST_EDID_READ_DONE);
>   }
>   
> +bool ast_dp_power_is_on(struct ast_device *ast)
> +{
> +	u8 vgacre3;
> +
> +	vgacre3 = ast_get_index_reg(ast, AST_IO_VGACRI, 0xe3);
>   
> +	return !(vgacre3 & AST_DP_PHY_SLEEP);
> +}
>   
>   void ast_dp_power_on_off(struct drm_device *dev, bool on)
>   {
> diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
> index ba3d86973995..47bab5596c16 100644
> --- a/drivers/gpu/drm/ast/ast_drv.h
> +++ b/drivers/gpu/drm/ast/ast_drv.h
> @@ -472,6 +472,7 @@ void ast_init_3rdtx(struct drm_device *dev);
>   bool ast_astdp_is_connected(struct ast_device *ast);
>   int ast_astdp_read_edid(struct drm_device *dev, u8 *ediddata);
>   void ast_dp_launch(struct drm_device *dev);
> +bool ast_dp_power_is_on(struct ast_device *ast);
>   void ast_dp_power_on_off(struct drm_device *dev, bool no);
>   void ast_dp_set_on_off(struct drm_device *dev, bool no);
>   void ast_dp_set_mode(struct drm_crtc *crtc, struct ast_vbios_mode_info *vbios_mode);
> diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
> index dc8f639e82fd..049ee1477c33 100644
> --- a/drivers/gpu/drm/ast/ast_mode.c
> +++ b/drivers/gpu/drm/ast/ast_mode.c
> @@ -28,6 +28,7 @@
>    * Authors: Dave Airlie <airlied@redhat.com>
>    */
>   
> +#include <linux/delay.h>
>   #include <linux/export.h>
>   #include <linux/pci.h>
>   
> @@ -1687,11 +1688,35 @@ static int ast_astdp_connector_helper_detect_ctx(struct drm_connector *connector
>   						 struct drm_modeset_acquire_ctx *ctx,
>   						 bool force)
>   {
> +	struct drm_device *dev = connector->dev;
>   	struct ast_device *ast = to_ast_device(connector->dev);
> +	enum drm_connector_status status = connector_status_disconnected;
> +	struct drm_connector_state *connector_state = connector->state;
> +	bool is_active = false;
> +
> +	mutex_lock(&ast->modeset_lock);
> +
> +	if (connector_state && connector_state->crtc) {
> +		struct drm_crtc_state *crtc_state = connector_state->crtc->state;
> +
> +		if (crtc_state && crtc_state->active)
> +			is_active = true;
> +	}
> +
> +	if (!is_active && !ast_dp_power_is_on(ast)) {
> +		ast_dp_power_on_off(dev, true);
> +		msleep(50);
> +	}
>   
>   	if (ast_astdp_is_connected(ast))
> -		return connector_status_connected;
> -	return connector_status_disconnected;
> +		status = connector_status_connected;
> +
> +	if (!is_active && status == connector_status_disconnected)
> +		ast_dp_power_on_off(dev, false);
> +
> +	mutex_unlock(&ast->modeset_lock);
> +
> +	return status;
>   }
>   
>   static const struct drm_connector_helper_funcs ast_astdp_connector_helper_funcs = {


