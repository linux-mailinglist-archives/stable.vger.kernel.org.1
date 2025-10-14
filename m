Return-Path: <stable+bounces-185592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D82FBD7FDE
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 09:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49533AA66C
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 07:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A3B2609DC;
	Tue, 14 Oct 2025 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJtBd2mQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD4F2AD0D
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427968; cv=none; b=gOyjaFpNcZyU7oto0JEPPAmgZomOCxggWzuZjjobNWoQLnEfgc3yksmgooWhFMlfv5W8tlcts7hMSD8+ARWktLM6x/jC2nAg6VmDBkCMlQrOeO3cIwr2k6YiNxyh8tDK2k+RRM/eX0Ugl4QGIGVXjAF1RV6W3tu8Uf2JBZzsPFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427968; c=relaxed/simple;
	bh=IPxqQvpHJfvZEWlcxqJlazd4WBZ4/Mvlw54Qz969+Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyK11EGMzwGS/ppeP+G5FDxLGcri9HWFV0oEwCoht3mf5MqFDxo7spk6de1BbDjJ8rjhg7QsJCXEptbNIF3eU2SR3kcC/GkRyq5+JKh2cKj0JAZmGVEAfUwTOTqn17nUVLbAG6oE7Q5ts8zq5KsXAeR2aP2/J3/Pb5BXsw19WXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJtBd2mQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760427964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZuL2StPvoHqfPKlji0n6gMA9cQYlL86+raj4IYDsJ3U=;
	b=YJtBd2mQMtfOQvCOcI0/aq88rJCcKwItsH4f/g3uMAwhA+3vrfxamvHeNxtNvtB8MKmlUh
	ZzHrL7AbCHYDk1yTjrqkYVHIBkr6F6GU9FRaCM6Ypw3SVtFVYwxX5wq1h7+7kSsSlmiNK2
	34yXvTZalYJGOrxi8UVJI5SnpPRYHYw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-L_5-AhtUNTG7Il6gqfgSLQ-1; Tue, 14 Oct 2025 03:46:03 -0400
X-MC-Unique: L_5-AhtUNTG7Il6gqfgSLQ-1
X-Mimecast-MFC-AGG-ID: L_5-AhtUNTG7Il6gqfgSLQ_1760427962
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f384f10762so4312736f8f.3
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 00:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427962; x=1761032762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuL2StPvoHqfPKlji0n6gMA9cQYlL86+raj4IYDsJ3U=;
        b=D+XKaWFz7DTMvWL7KRPuXFMcyCaauW801NvHfKX3xZjzwWMEazEYmJzY+kwHjLRkx1
         B2rSZqXX2nm1Pgr74BkB51LFzLDQJdUURfs3/HL7aWGJBIc1xwgUYsCVzKSH2t2aDjg3
         9hudRjV5wk3/+7opMSPN98lOBcop8ViF8uxEvAbvHMwUc6f5H3H5dwoXZX5kAevUBNs+
         J8bZxSlKSrXgHQ1aVPjLuUYeDozbwiTEGFLZBNAb50f2Va7BCLEFMG/KVrW51JUb3rik
         6CW3g/BCgEFL3nmSrOf0LK8FhdBJSXoF4VLZWZaKIl1m/bd0oA1ZgHRMqxJMGkK8ISiA
         8doA==
X-Forwarded-Encrypted: i=1; AJvYcCUuKC8noWO6Sd2kgf3uD/SgqjU+j72NZIe8QzDei2ZxFy9JqehzZNGQQn2LDyBJyMjJsHZvlEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaBX2MJCyXSMFSOiDM/cbhNwHAgfuuyOpgF6VNShi1xMZOkxQj
	gAfJtIzSwXOQiNsDxh9al1CKp8TIqIZqbJcA2DHdk99cK28HrFso0Z8XJJylk6qpBc0j+GflPpc
	Su7/6ybMFZdkj1gqon8mdaO9rcmqo7lw9FbWev2b6U4sR1kDmV+k/jOFuWQ==
X-Gm-Gg: ASbGncsdK24QjXr6F0U21R2Z5Fw487woNApmKK1ee+TaLr6srIfndqozDPSuggR2xlE
	yhR4nPWp/LoaiZ4ymtO628mrmOgWbuBUqKyVNZGkdjeRpTN58HcRr24j2g1uB+NdJT0nMs4hG1A
	ryz5kG+HLPYxv8CJ5yEPGUEIiCxHqcRvCfUoUchYz5FHXVEbzek0XLKjRo8lVvW8oruHtpmHvEv
	/Unjhvfd6EZaN17NCoPDEjWASqy169ISDUFjl2C0AR3peE/qxL+KbBWZrYsFsU+M3Qrsjo7rF+6
	0i0Zz+LJgcjtpG+wdwkjVHA95MU3kcFqMfKWOJgqE56bx5hpGFhtT0X6YWtwTg5fXWMPPPPGABM
	FJept
X-Received: by 2002:a05:6000:18a9:b0:3f7:ce62:ce17 with SMTP id ffacd0b85a97d-4266e7d4406mr16641440f8f.38.1760427961677;
        Tue, 14 Oct 2025 00:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNM2xo5ZLQVou/pRRKjxY8bstP/7kfFBfLgBcA4Pk8KnQSXsywIOTGa19BsGCsqd8RxGUA8g==
X-Received: by 2002:a05:6000:18a9:b0:3f7:ce62:ce17 with SMTP id ffacd0b85a97d-4266e7d4406mr16641422f8f.38.1760427961280;
        Tue, 14 Oct 2025 00:46:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf71dsm21480168f8f.29.2025.10.14.00.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 00:46:00 -0700 (PDT)
Message-ID: <9ad17cb1-3e09-4082-b52b-0b218812f114@redhat.com>
Date: Tue, 14 Oct 2025 09:45:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ast: Blank with VGACR17 sync enable, always clear
 VGACRB6 sync off
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 dianders@chromium.org, nbowler@draconx.ca
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20251010080233.21771-1-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20251010080233.21771-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/2025 10:02, Thomas Zimmermann wrote:
> Blank the display by disabling sync pulses with VGACR17<7>. Unblank
> by reenabling them. This VGA setting should be supported by all Aspeed
> hardware.
> 
> Ast currently blanks via sync-off bits in VGACRB6. Not all BMCs handle
> VGACRB6 correctly. After disabling sync during a reboot, some BMCs do
> not reenable it after the soft reset. The display output remains dark.
> When the display is off during boot, some BMCs set the sync-off bits in
> VGACRB6, so the display remains dark. Observed with Blackbird AST2500
> BMC. Clearing the sync-off bits unconditionally fixes these issues.
> 
> Also do not modify VGASR1's SD bit for blanking, as it only disables GPU
> access to video memory.

One comment below:>
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
> index 6b9d510c509d..fe8089266db5 100644
> --- a/drivers/gpu/drm/ast/ast_mode.c
> +++ b/drivers/gpu/drm/ast/ast_mode.c
> @@ -836,22 +836,24 @@ ast_crtc_helper_atomic_flush(struct drm_crtc *crtc,
>   static void ast_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_state *state)
>   {
>   	struct ast_device *ast = to_ast_device(crtc->dev);
> +	u8 vgacr17 = 0x00;
> +	u8 vgacrb6 = 0x00;
>   
> -	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xb6, 0xfc, 0x00);
> -	ast_set_index_reg_mask(ast, AST_IO_VGASRI, 0x01, 0xdf, 0x00);
> +	vgacr17 |= AST_IO_VGACR17_SYNC_ENABLE;
> +	vgacrb6 &= ~(AST_IO_VGACRB6_VSYNC_OFF | AST_IO_VGACRB6_HSYNC_OFF);
As vgacrb6 is 0, then this "&=" shouldn't do anything?

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


