Return-Path: <stable+bounces-185586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EFCBD7F86
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 09:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B563AEB5B
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 07:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7865B2D3EC1;
	Tue, 14 Oct 2025 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DyIZGQ3B"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEE32C3274
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427394; cv=none; b=Wf6jmXI+UmdeD7A0xKzsS7m8XxnBEqCRYcXHLT9rRMJeinbNgmtYW2v2dra441r2e5x+23GLS/0Tqf3dglXZby5TZaifyOuilNddQ8VrbN/vd3DTHo1evyuR1cIM7cedVKIQK192Aw/WPyLP+ax6NtRr5mo4pkNeONxrlWK4SdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427394; c=relaxed/simple;
	bh=L1dhanDEfnANs9rAUgFl6wjAaNE0DKoPAlHcF4Xsjdg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bAgYlale65KNuq7+aZxdnpJjwzuoggxtSQAwWVPsl/x0PFa9Ngn8JVGOShDpezqwoaSm+C2U+qfdkTLrvI49S72b0BlucFlIkJRl4iFrxpftg+RRDaUq3kbCpY4biot15ExtT+GOf+ny20CWOj7l7V8cIdjAoVUi0KWId9SQx6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DyIZGQ3B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760427391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1vjIWoi/164XsR7x2ZrPuJ9XjGOCw1cRW5cuBw3diZE=;
	b=DyIZGQ3BaciLf4qde9B+41Us1tMbmliByoNhNXKYgYzzqwe8Qr9fY4oMI3o32nglDftm27
	49NvkYCYZIqcse8IzNoQG2VOGRTxgeAQi2tcE36ZJcj+9HWTlA6Gw54pIMZu4AKjDxcHOH
	rJ20qccjt4R7irUWWNM52ezMv8OBzwQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-7eK270OHP4uAPe50TJvmuQ-1; Tue, 14 Oct 2025 03:36:30 -0400
X-MC-Unique: 7eK270OHP4uAPe50TJvmuQ-1
X-Mimecast-MFC-AGG-ID: 7eK270OHP4uAPe50TJvmuQ_1760427389
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee10a24246so4139324f8f.3
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 00:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427389; x=1761032189;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1vjIWoi/164XsR7x2ZrPuJ9XjGOCw1cRW5cuBw3diZE=;
        b=MOtkARBKGkgEpvYFoc5Q7vqFPgidgo9AhIXe4B51KEHSb4js5YJrGESQvgzpPHTV6+
         vNgKvNZsWcSRn9zMBdGrQPyhaLDA1/pOfdX2W3VcL8zLhWXFYsfksDTYEJ9ttmu7Z8Ak
         Wwb4znMmcGnXeqNAvcT4IorJ1OLSS6cxTSY059HuI3/+2SaX86falSOInFU7+wHoXb+2
         5GrOhxIuWq3m9jzAAMlmM8SVOWmA6P1dALKWh8+Sttqc0QLfWilwzzjYhBa7JYfyZDrB
         +s0XTsklixBGM3f615RYY0ieLon5+f6tFbZ0JGU0pH+1/CTkz6i4IOllSlBGBSyGMTR3
         Q14Q==
X-Gm-Message-State: AOJu0Yy8YzzusbHAI8tsTu1WtGxJyV0pqgqNmGiaiIYSinv+F4jk4sr6
	8ELPnjj4Q495zGlvwXQrqGLXBzPS33epWEE+gXKBk7aNOBXV6JnJ7XEHhIglYCG+aqDRt48NsqM
	1ShCU+2fW3ESJxTCRizNwAoHSgpBLDwzPkMDa5YB33/RqTCNNNfPGXDhB5Q==
X-Gm-Gg: ASbGncszG9oajyXB5ww8p19x7FgRSszFaXPkX+eRWfPjN6vpXD6+SVsoQFoyC/wa0za
	kEFtLlLv4LGdTTSETuEa/QI/sQofEcCpSXXbNrrtxb+5D/HReluRPD2H0sIsQnNFXCTsOLf4rRg
	BCjJ4O6zyByUFeOsAyIrkobOhuBB0hIxLrJ/tsKGfcCXBCktq3//MDpe0d9BVkKc4p80M4YSJxW
	IaRe2w8k0PanZzDURBc+Gu/3eCO+Sh9A+7HTV3Z8pf1wK4xej1Dt6AxNGSJ1rQKHU/pW5U7eBZM
	TZcguEtstYIhegAIPVxzPTE2XIuLTVxgTwROvt/74AeIqbOD6Vnm54LGINzrD6sqtN2s+6B4Gns
	knLmMD1J1cinMuPA0aponPK4=
X-Received: by 2002:a05:6000:18a6:b0:425:8538:d3f6 with SMTP id ffacd0b85a97d-42667177dfcmr14861353f8f.19.1760427388939;
        Tue, 14 Oct 2025 00:36:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgR6EeBgIxPIYN/rDHcLYirWOSSsnc3zChf7HMTDBNzJiYe4qrbYdh+J6TafB+G4Nqz7GOTA==
X-Received: by 2002:a05:6000:18a6:b0:425:8538:d3f6 with SMTP id ffacd0b85a97d-42667177dfcmr14861334f8f.19.1760427388571;
        Tue, 14 Oct 2025 00:36:28 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm21846822f8f.35.2025.10.14.00.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:36:28 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jocelyn Falempe <jfalempe@redhat.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5/6] drm/panic: Fix divide by 0 if the screen width <
 font width
In-Reply-To: <20251009122955.562888-6-jfalempe@redhat.com>
References: <20251009122955.562888-1-jfalempe@redhat.com>
 <20251009122955.562888-6-jfalempe@redhat.com>
Date: Tue, 14 Oct 2025 09:36:27 +0200
Message-ID: <877bwyq6is.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

> In the unlikely case that the screen is tiny, and smaller than the
> font width, it leads to a divide by 0:
>
> draw_line_with_wrap()
> chars_per_row = sb->width / font->width = 0
> line_wrap.len = line->len % chars_per_row;
>
> This will trigger a divide by 0
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


