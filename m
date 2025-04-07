Return-Path: <stable+bounces-128551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDBEA7E061
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 16:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CAB164D4E
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 13:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5F41BD03F;
	Mon,  7 Apr 2025 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AikOFIAg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C57A1B414B
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034368; cv=none; b=tkmNHdjNqaFEmESqOjPDfIDFix/g4M1rfSVlmrz+NJcQ3u/LEHwtowOmCSRTRtHkA/zF6rHelWlYvsAqOGB993YyAdw95nKZm1C99ryrMGk1jUiauJe/GJCXgv4RKkq5TfjdsO9eGMuuyAgJmFHUX1iK/fi/8lRgI8SVvxNZR94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034368; c=relaxed/simple;
	bh=rOzZg1CPyzICx9FsDGFu+sfUm37wAMd2wxcBUX2W3Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQvdxQp0U6b18L4qfMYGNttu8bptP2u7OkONwlWO3KrIJFG88lMS61nzdn2/Oj4CHH+LeC6HW1+zS/9ZC3Z2rYesvTHlfpDcKSjBLDV9DxwlBziNWo0tBRvp9YGBLa2xk4jmYP8zBQAoAjCFs65VZk3Mk6sWt/YTZc2eQ/a2ZHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AikOFIAg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744034365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=swDbcea4TipT9nblctrkNfnrLjUIGyAQtn4f7FEMyIM=;
	b=AikOFIAggfwHUw8ZyZl2UG69KtI1IFj/T/BTH6tHm4esgoxnkeWeJkCbmTxZmWzS+5NZ8z
	JJ0IAQQUKkF3Z4CrrnbJ1LKfcVYA/6WkdBtXUYve2PNQpdjs9HRxdpvOvLN0ivU+ApwtP5
	nm54Cv671q9tmFTl8wCyNr5raXomLE8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-zuxnxwQSNgChP9lw5wqqNQ-1; Mon, 07 Apr 2025 09:59:23 -0400
X-MC-Unique: zuxnxwQSNgChP9lw5wqqNQ-1
X-Mimecast-MFC-AGG-ID: zuxnxwQSNgChP9lw5wqqNQ_1744034362
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-391425471d6so1568250f8f.3
        for <stable@vger.kernel.org>; Mon, 07 Apr 2025 06:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744034362; x=1744639162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swDbcea4TipT9nblctrkNfnrLjUIGyAQtn4f7FEMyIM=;
        b=K/3+tBh5izZebJtS9KKRHRSgjTil/O5SuEpsAh5eX23hb+l0V/8eQGwIsFe8s9ERlD
         IU1uuWCdKLNhJ0W0JuDZlSC6Sq0Bc/1blElx50lJO4vI33IsEuMAx3HPM2Aw8ZiczCPc
         IJcqOCxCM3Iq7yyjId2NJGvpXQybBsYIDeZbxcRXou/hmYRPwX2/LD5A89gsIDTbZyLk
         KIVpgYRf/UhiTvJDptrxBRpOaANvUm/GsJZZKzxM9TJ/YhMDmSJinbOnLN8P6HBM4GPV
         MwUuzvzT6RK6rAkPjrS28dFnN/WniWQofqv02z/1rWIyvfbazWrTr7JaKNTXPmNQI/uu
         dZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVwNnR4Ok+RtkH9LhPWCNIofoPFHE9nuCBCJZfM0DBpvhpFsLaF0ewns0+w/KgILlVSiQFyBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrpCOv90IIaFE5mRpX5ZXvLGdTLMEFKqcuwxt7lnbJTKBz5fWZ
	/jp0x3fzOOSz2Q0WIuqGkMkdv7bFUxWnMIpcNdEln1q+wYMnE0lmKhscUsEVf5MF+JSmMzRzRf1
	fHwymxkVPDuv+KudaIG94xCsRo8EU5RDYEDkizQdBK6HEsGjbc2oQHA==
X-Gm-Gg: ASbGnctxOxBWY+cqDN63wmTVgqfNQ+V6jpv05CvqTXoZoY7tpWwxTG2rTggtNDgsBmm
	yD05Yo0rLupiib6wz2B0dR/CRc5qgAwraDZMYNr6CG/nbuj57imrbGm2xxU43w787BVOkcZ0cS6
	HDOi6sGBVVdVZOaa4ydo4bQuizuLZ6BOjGcPmsNGlICgCvBZYH2VhdG5s7GagLlcbonp8mEWHRg
	kZfW2Dd9q6M2Ghsln/Bh+SUAxYO/Nqx5lYcu8mqnDWc0JF0RZli7iUlGdQjl5l6AzJ5gH55FP+p
	kgXl8Wg2zd9LiavW0IAKTjg8BZ6ENhyblqBlBzYiu3qNmuBO2o3Hcwo=
X-Received: by 2002:a05:6000:2489:b0:391:4873:7943 with SMTP id ffacd0b85a97d-39cb35aaaeamr10085985f8f.32.1744034362096;
        Mon, 07 Apr 2025 06:59:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw2emtkUQsGZRx29I6DAM0QANpQ6u2DCnwRNVRC+w8OR50X1TALVDqwjuf7VIZBgHdswRKsQ==
X-Received: by 2002:a05:6000:2489:b0:391:4873:7943 with SMTP id ffacd0b85a97d-39cb35aaaeamr10085951f8f.32.1744034361427;
        Mon, 07 Apr 2025 06:59:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec3669002sm132582065e9.33.2025.04.07.06.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 06:59:20 -0700 (PDT)
Message-ID: <86cfa8ab-8f20-4e29-81c8-358012261270@redhat.com>
Date: Mon, 7 Apr 2025 15:59:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/simpledrm: Do not upcast in release helpers
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20250407134753.985925-1-tzimmermann@suse.de>
 <20250407134753.985925-2-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250407134753.985925-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/04/2025 15:47, Thomas Zimmermann wrote:
> The res pointer passed to simpledrm_device_release_clocks() and
> simpledrm_device_release_regulators() points to an instance of
> struct simpledrm_device. No need to upcast from struct drm_device.
> The upcast is harmless, as DRM device is the first field in struct
> simpledrm_device.
> 
Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
> Cc: <stable@vger.kernel.org> # v5.14+
> ---
>   drivers/gpu/drm/sysfb/simpledrm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
> index cfb1fe07704d7..78672422bcada 100644
> --- a/drivers/gpu/drm/sysfb/simpledrm.c
> +++ b/drivers/gpu/drm/sysfb/simpledrm.c
> @@ -275,7 +275,7 @@ static struct simpledrm_device *simpledrm_device_of_dev(struct drm_device *dev)
>   
>   static void simpledrm_device_release_clocks(void *res)
>   {
> -	struct simpledrm_device *sdev = simpledrm_device_of_dev(res);
> +	struct simpledrm_device *sdev = res;
>   	unsigned int i;
>   
>   	for (i = 0; i < sdev->clk_count; ++i) {
> @@ -373,7 +373,7 @@ static int simpledrm_device_init_clocks(struct simpledrm_device *sdev)
>   
>   static void simpledrm_device_release_regulators(void *res)
>   {
> -	struct simpledrm_device *sdev = simpledrm_device_of_dev(res);
> +	struct simpledrm_device *sdev = res;
>   	unsigned int i;
>   
>   	for (i = 0; i < sdev->regulator_count; ++i) {


