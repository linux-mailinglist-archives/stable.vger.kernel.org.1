Return-Path: <stable+bounces-125999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A586AA6EC0C
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 10:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3495716BB23
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 09:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714F919E7F8;
	Tue, 25 Mar 2025 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bY+Fl2Sl"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E9D18A6A8
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893274; cv=none; b=Iiq7sDUzPrbGLYAo1+JDl2/L7ada54q3DmzmVAeNj4nf4yXToRKv4LwWrnOWlaBWQnY3U7goDI97Oko7ZGEKxQuUFlhEH9Z9O8r9bVxFUuQbO+toq87tF1qXRgKcZRmrRl4Vpg80GTSMJyNbITu9nmOJTn14QhV4tmKMIZnskEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893274; c=relaxed/simple;
	bh=o5P6LrrE4R8q9wkJhrAPfE+TefXYFgu7QPcjkCm2tKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qa6UfBCIs3qc3BGoZVFskb+Dkx+psvue7ZsOYSnVp90BJxEVk6yODrQoQxJIvGR7HJFCjx8XcUp9BOwWdpnBUro1dBm1gYA0U/BrQEdAVOtiS4rTMBHil5SxqfKwBsoBamcUvWBbkyWoyRvy5xhTxmq0IKiIcyRoxWHR17rUlyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bY+Fl2Sl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742893271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1j1ooVFaTIz+Ag3IxO/2LQz1vPByp2zpNenvgrYOIio=;
	b=bY+Fl2SljRhevYq2BzVRpEJDna7AazcxdfxjRn9TJNbgltx8nqdkB0lEx0KBoKj6BxNJyt
	OxFmflqDvce/GyTVkpFA8U22d6rqh85qeRDP7pMLSN35M9Csanzfzqz1mfiD9A/HnDflmx
	gL9tJ310bEVRzE249euptABkQrP6Hjo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-mpoQ6uclPimIG_mh-FyzgQ-1; Tue, 25 Mar 2025 05:01:10 -0400
X-MC-Unique: mpoQ6uclPimIG_mh-FyzgQ-1
X-Mimecast-MFC-AGG-ID: mpoQ6uclPimIG_mh-FyzgQ_1742893269
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912fc9861cso2287008f8f.1
        for <stable@vger.kernel.org>; Tue, 25 Mar 2025 02:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742893269; x=1743498069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1j1ooVFaTIz+Ag3IxO/2LQz1vPByp2zpNenvgrYOIio=;
        b=v8h4YPg0K3frmPRAQv8TMluUQTuvSrdyrXfhQflGJ4JrkBUu3oh/bxgIQ9k8IgyQSE
         lyVOsV+z39XAcRrEE1HmGdEAzUluLYJv+4PqcB/rU00zuHAa8R4+m2JoE1gDAtyw8uYD
         4jjG+g0mIZPZwomb0tqsBQpCjKmjsOtRUgBfKNIgPIIvAJlJNt6w38EfJIkdWqb1loUa
         gsY5EsmC7M36uMF3RdepVzpWBBIpJO99R+ozHfWwKvcxwiX9aWzHJ4Km34OCxv3Pem8k
         qitPY7RmAIevOmbrko/rmBmdiBiWQDTkW0lhGeRU3ZFCiDdCJh5hrA904OMKS+EycK3t
         na8w==
X-Forwarded-Encrypted: i=1; AJvYcCXEbfFzPmJbsr7fhmZbrlzqZJy+NtGF9u5hbXPMsZsKZEY7l8IC4S+BPVinv/S5snRRt5ullo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+2uuBxQqaRKWBlE+sEqyEMmNveSovk6fsHKhpj3vh0l63SY3v
	K1+Z5euQPyfrIEtVyFNxdOdYrMHIrZmrV2ZkGztjFE2ZQmaO5H2lXkwJDgG+kaHC2rjhu8pZteg
	Hg/CnX/wXLbKee+NkpgJotlKtlmK1fsoVwd3mWcgneTn4Bx5L60FS9Q==
X-Gm-Gg: ASbGncs+X+oahQCeh7czfr2UBqcwlsDPq99Bnqz06mP/nYezbhyEsyojJsq7fB02RG2
	AH4+VZHlEynDIOpe4vBx8DudXVpShz89VvQW7i/0NFEjvhXKba/1GTytSrMEN3YZA7Mg4pUVNrC
	vFnilTjLaIACKwsU4cJ1JxkZRrlj76DYDvmg7L6q14cv37jzXOica5vDz/ek2HQkW5TPbNMCybF
	wqPIlDGJ5WgnSkkJUef46vh5I+iYsHx9L2gxa6ZKpVCsYj1m2aCCJ7fix7/2mGahbnCoe8jl42C
	dUXWJdRtNEIYIAvD57b5+QkI3Z2g8iVoNCT8d4FD1e9tmvBF2zRNZBA=
X-Received: by 2002:a5d:6c61:0:b0:38f:2856:7d96 with SMTP id ffacd0b85a97d-3997f8f605cmr14709905f8f.1.1742893268506;
        Tue, 25 Mar 2025 02:01:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm5G7j/HXCRX+Mtin++Mmvo/4nbXyGoEvepSzjyEZb9r9psaOAvFHJsZNo7u5I5/q56BD5CQ==
X-Received: by 2002:a5d:6c61:0:b0:38f:2856:7d96 with SMTP id ffacd0b85a97d-3997f8f605cmr14709852f8f.1.1742893268029;
        Tue, 25 Mar 2025 02:01:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f99561dsm13355974f8f.12.2025.03.25.02.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 02:01:07 -0700 (PDT)
Message-ID: <3dc6aa2b-8e03-4e43-b150-e8148b83c066@redhat.com>
Date: Tue, 25 Mar 2025 10:01:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/ast: Fix comment on modeset lock
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20250324094520.192974-1-tzimmermann@suse.de>
 <20250324094520.192974-2-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250324094520.192974-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/03/2025 10:44, Thomas Zimmermann wrote:
> The ast driver protects the commit tail against concurrent reads
> of the display modes by acquiring a lock. The comment is misleading
> as the lock is not released in atomic_flush, but at the end of the
> commit-tail helper. Rewrite the comment.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 1fe182154984 ("drm/ast: Acquire I/O-register lock in atomic_commit_tail function")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.2+
> ---
>   drivers/gpu/drm/ast/ast_mode.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
> index 4cac5c7f4547..20fbea11b710 100644
> --- a/drivers/gpu/drm/ast/ast_mode.c
> +++ b/drivers/gpu/drm/ast/ast_mode.c
> @@ -939,9 +939,9 @@ static void ast_mode_config_helper_atomic_commit_tail(struct drm_atomic_state *s
>   
>   	/*
>   	 * Concurrent operations could possibly trigger a call to
> -	 * drm_connector_helper_funcs.get_modes by trying to read the
> -	 * display modes. Protect access to I/O registers by acquiring
> -	 * the I/O-register lock. Released in atomic_flush().
> +	 * drm_connector_helper_funcs.get_modes by reading the display
> +	 * modes. Protect access to registers by acquiring the modeset
> +	 * lock.
>   	 */
>   	mutex_lock(&ast->modeset_lock);
>   	drm_atomic_helper_commit_tail(state);


