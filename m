Return-Path: <stable+bounces-100820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD69A9EDCFE
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 02:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BCF167D9B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 01:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1981638396;
	Thu, 12 Dec 2024 01:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="zwmFQjWP"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A91DFFD
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 01:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733966246; cv=none; b=WzKPoKYBT/OhTUjrLpMLl1zqZGXA+DzQkAEV+efnGJ+LGsZQ2Ngqi3r1/8LSXB548TKgAHEiciHz0nKiCo9z8h6gRBM7N8iq9hpIlumH/xiIJy4IP/T4hcqDlJ2aMAyg3C1Cgl5dAx/6JVY3qYHVrJi4l9wgHhvN5aS6lxol9Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733966246; c=relaxed/simple;
	bh=MvKagAzNUAOxChvHrOFpcJiYAyut8t9DL+GIvcj3XxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqKXfzPV689dEh8KN/12oaIwJLFP912vc5Jq3d64wYmx8q0qgHlWSVD5c62v1aUafEl0tmacddHd0v8dqaIPvXRHuaLDolC5dsWyBICqw9FS38b3Yc49/2W8/EwdC9cSMaN3Sjp2PE7tAMepmBkcld2TSY9Q/2tzDkHT6WXgzUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=zwmFQjWP; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467918c35easo1093821cf.2
        for <stable@vger.kernel.org>; Wed, 11 Dec 2024 17:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1733966242; x=1734571042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=djWQoJOklaLH0BLuJ8p0AL7/ItgSiiuZQ01XKXXCzcE=;
        b=zwmFQjWPIQ/ZCWJaEHQD4dRgzdgNdyqEGCh1OCIyQ2ss11AckZnocFl86q1PCVzNxw
         Yp1RLQq9u64Obw8q51az/txvhmQDPhvoJNpTjZXNaZ3sDJLJSekrE47INhnfW/BBXvvn
         Pub9wHh65Dn/LOuCUmUs8x1ttN2SAfU5uJd1xHtv75K6o2yMFMy+tCUfD4HKfT91Dfh7
         oow30SqjMv2wkDd6zeaYZhKI7inFywq+cC0tKzxuIvl90k5I3S55nzUAOJIlwAnXOghY
         9AtkTkWwgB2TEQt8oSwdpdRxr0kq3rsGkuPkN+JCBXGU+z2gpsYfNsRax4szJoZiMPP2
         nfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733966242; x=1734571042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djWQoJOklaLH0BLuJ8p0AL7/ItgSiiuZQ01XKXXCzcE=;
        b=RCq+cjd1qIjCfzJIugbuLMtfVGrOw7glbbZDZXjw4fo0H/CnlgIcAK6BeYp8Coe7Sd
         l6VwSpyj8X3K6rPRlfuNvSm0g4kg+tpdypv+O4uh9uFg3oT6VBi1xJB2r0LpVY1sT1wS
         vh4m3o6mN5hcfZcoB8gPkWkMgK7msoIFTLRGTuQ49pIeQF9zXf/hS/XlF/KSab2D+aYe
         lWxUXzuBxyGV3v/kkkqCYt4IYqpcQoLbkivS2Fm529vKHkF2QZbr3RtdLaIOWeKQlTOY
         LoDjwVJPB9K0olkum3D0KML3c4+TLpSBXl7O1SnPImCWbxpWjF+fwP8pmKek2wGKhMoP
         D+9g==
X-Forwarded-Encrypted: i=1; AJvYcCXQoFE3OLNmrhvd+csUdEV+j9GLtI05/ZPNkY6V9usU65ENtb6L+RKvDxgybySAa5Ol80vrKQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7YbyKVTZXnSd5POGOq3vUcyW2pW+Jtw6OF/1WPDyA0KkLql35
	26L40Ph5+v2pWAMP8qzZI46Y9DS9mwnIOEx/67H7myPf8Y0g89mxdmK7LDFAcEX3dKS9GsacyFE
	h
X-Gm-Gg: ASbGncsDuM8CK386A1+WEA3TWq9D6wJQmr65AaEJa09jCPWRZClRZHtvMHcOyhAcGTo
	e9MeTAH89XgUAhD6N0bVdj8uFQu57rdq9IyenJiasHkmU2KiS5LnRWU0asnAguRSa7WbD2d0fZT
	AnYsog+ErtcP61xZoiY6e4IflqhU4mnyM/fNODfutTg5ehganGvEbC7xEOkrajNioHQNzKw54BY
	3eIXwe7376at0M4RM9vNwpgJxL/PAMsf2NgKhi6HYLEmTxodyU20Ik=
X-Google-Smtp-Source: AGHT+IEnJPekbYQNH9UrAAv3zHb1sBsf3vy+46DjthV6gdW4FwtIgcVe9aICG/pyjcXAlON52ZvNYQ==
X-Received: by 2002:a05:622a:1243:b0:467:6226:bfc1 with SMTP id d75a77b69052e-467961afa32mr29536261cf.29.1733966242116;
        Wed, 11 Dec 2024 17:17:22 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46780a93029sm21262041cf.84.2024.12.11.17.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 17:17:20 -0800 (PST)
Date: Wed, 11 Dec 2024 20:17:19 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] vmalloc: Fix accounting with i915
Message-ID: <20241212011719.GA1026@cmpxchg.org>
References: <20241211202538.168311-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211202538.168311-1-willy@infradead.org>

On Wed, Dec 11, 2024 at 08:25:37PM +0000, Matthew Wilcox (Oracle) wrote:
> If the caller of vmap() specifies VM_MAP_PUT_PAGES (currently only the
> i915 driver), we will decrement nr_vmalloc_pages and MEMCG_VMALLOC in
> vfree().  These counters are incremented by vmalloc() but not by vmap()
> so this will cause an underflow.  Check the VM_MAP_PUT_PAGES flag before
> decrementing either counter.
> 
> Fixes: b944afc9d64d (mm: add a VM_MAP_PUT_PAGES flag for vmap)
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Nice, thanks, looks good to me.

