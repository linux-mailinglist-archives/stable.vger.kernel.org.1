Return-Path: <stable+bounces-128549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAC5A7E05C
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 16:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823401886B53
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 13:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E7F17A302;
	Mon,  7 Apr 2025 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSK4Fq/L"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C9418C322
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034338; cv=none; b=awh/RFX+51nYIZnCc2yJuKL2B0l4bwNgs8Z7fRM+Sqj518oU7UpWqWhpmyA7zdINwn12M7JdUWsRVZsQVJzUeyYnDtB7kCTpXr1zAerjqqbziOlM/FTW9UbRRBMjlE7XqU5s4joQimC9CJ7VqJswoXBL2TEUjTiuUPE5FI5MVCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034338; c=relaxed/simple;
	bh=UiyirE3CA3b8LjdPzEUkui1NKAeDxqhz1KkYIHN00BU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ccwjzVMSD5pOHV55LJnfUdNeCud4OFTG2Ao3fV819Lkux/SHZ902x2q1xf4YcTHQQWR01ntQ8RuI/wLsHW2QgnsnjcEsd0e3nDwa1qDQWs1jBO1XhX0owcl1d5wyvOiEEuWveDbD8lSFSOtblj9JgUEaFicbURcTJ26XUFe2YVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSK4Fq/L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744034335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NKQaxm+8dbF4nb2OYVZtaNLSz1NxmABEoTvWQVFR0f4=;
	b=eSK4Fq/Ls+tg8vhvloyxN9yl2kVL9U7qoW2oOUUwmzu7k6hYU6qdMrkLRuPf9QQUDFanUn
	YeW6CWodcFRAZV0FCHvTLJ/MjSS32/w0VgcaG1QyP+nt1HMAnor+5lKEO8CxTLV1bUdP5N
	6V+mJBLHTV2iyrVHJnMxq7aybOih/wk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-hUUXtIYZMIuXqi314HgA7w-1; Mon, 07 Apr 2025 09:58:48 -0400
X-MC-Unique: hUUXtIYZMIuXqi314HgA7w-1
X-Mimecast-MFC-AGG-ID: hUUXtIYZMIuXqi314HgA7w_1744034327
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d733063cdso37275135e9.0
        for <stable@vger.kernel.org>; Mon, 07 Apr 2025 06:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744034327; x=1744639127;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKQaxm+8dbF4nb2OYVZtaNLSz1NxmABEoTvWQVFR0f4=;
        b=juW72vrQGmHdTm2UArnQJuL0h+zcBueDkg+3xVYmDHnzfG4GTQlOeWLZpyM/BNlMcl
         ty+QMeoIoONy5/UeeQm6P5qpjKyJxTGi6Uunnh/6ijYuFxkBc36o1eF+J2+uoew1Wtd0
         e8866kxtsAhjqvusqr/Xh7Jw/dMZ4NMdedEkOyMJzi/qDJ8Df7p5bkx1fIA53ovtAnzd
         mHHtRt1xAFOSySIShBl1VB6NcoCwUmDzQSaiXiHr65dFALttc9Z0XKNm3ZPW/Y6AkZ4H
         rUTYumjbgcXzFhoAcZSta5UaGhXh3f/AKzlXg4EHmQpcs9iGDVo1BmyCmdRQjBx0fT+q
         EayA==
X-Forwarded-Encrypted: i=1; AJvYcCV43u3M22CUbVyUnK9Ch+dX5seWDACbAKZo5BaGp8CmgkZ3+5laa9p4BmeTAi0TRIYuv22h5AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhQdfAs+2JDyd3xD6XiJyyOWN5yt+3W3u8cBOcVcSk6f+U/Jdy
	d/5feXAZ2fG2Oj/UK9V3wJGcLy2fmxlDoR7Y145XffUtFf1PUWyxJ/DQOWoNZf9gADTLhHHMcWO
	L1FSyaB6XlpT8AeM34J1j6qKEbelFLPSq7ClmXXD96MVKBuPmfe5kYw==
X-Gm-Gg: ASbGncsZkJrLTKStNeWqF/z0a24i7xrtCV2+OQLryuneWpnKq41ZMDiH/yps+ZwM7aN
	gUJ1Y3LLypuGGvY93nB/E4In8zEB7GRtJ+7tCpJvhSIdihWV4QjD+JSrMdZzOK5hkvdy01FIxTG
	Ci+d+RURQAMmLk6FADHuEdnyUEt5LrwlOpeDU68E0XOO/0t42uwLLNTuvT4K3wocz6Sc740prNr
	DqzKSwTnd0uCLEPx8OdmPen4V1kEPJNY5jxpNfvbJo2n1MCi8yRcrMeWVmvmnYTRP4TST/OIE6Y
	aiOHJHg2szYIGMliUpLAxpII4oQ7iyiWnuyQTbZDFxjR9imSS/Qq38hY+6+gP4NXuuPJdIrGGA=
	=
X-Received: by 2002:a05:6000:40dd:b0:39c:1efc:1c1c with SMTP id ffacd0b85a97d-39d6fc85bcdmr7500122f8f.34.1744034327186;
        Mon, 07 Apr 2025 06:58:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5QgaUxNWjuEtXsBlHixyWJCdpw1rSkd5MpsB3uA7GVZiOCsyohCshMX6qfj8sEJwl/CAiMQ==
X-Received: by 2002:a05:6000:40dd:b0:39c:1efc:1c1c with SMTP id ffacd0b85a97d-39d6fc85bcdmr7500100f8f.34.1744034326836;
        Mon, 07 Apr 2025 06:58:46 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226ecdsm12673154f8f.99.2025.04.07.06.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 06:58:46 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, Thomas Zimmermann
 <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/simpledrm: Do not upcast in release helpers
In-Reply-To: <20250407134753.985925-2-tzimmermann@suse.de>
References: <20250407134753.985925-1-tzimmermann@suse.de>
 <20250407134753.985925-2-tzimmermann@suse.de>
Date: Mon, 07 Apr 2025 15:58:44 +0200
Message-ID: <87y0wcoyy3.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The res pointer passed to simpledrm_device_release_clocks() and
> simpledrm_device_release_regulators() points to an instance of
> struct simpledrm_device. No need to upcast from struct drm_device.
> The upcast is harmless, as DRM device is the first field in struct
> simpledrm_device.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
> Cc: <stable@vger.kernel.org> # v5.14+
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


