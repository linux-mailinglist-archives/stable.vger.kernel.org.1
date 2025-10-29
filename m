Return-Path: <stable+bounces-191658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33756C1BF19
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 17:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1B4C34B51A
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 16:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C6433F379;
	Wed, 29 Oct 2025 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RbJUlx+B"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E0C29CB57
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753927; cv=none; b=g+Dc4/d6+3OyJDiuE5b8pVnfLB3A7VBnOEPeR2kDOawwNAoVCF+Gz5knf5Z2B6oVS4rWWt9zfZ6H0A/sUEaw9eOwTUtqQ/9KYFTExDfUgRrAgSFvSeXoJqyJ3vzN0iwkxauJfcPlc1xbr/I0Vn13ghiIhoL2P8rdXQo279w/6WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753927; c=relaxed/simple;
	bh=kEAK7ZhSRGbUNqWaJ0QQiDiz9fmOk+Njl0pXJH3ABMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1CbUkOgC2KCuMm96OlVAGdRZQAL2kYWdGmi+QUZ3fl02auebmWSpdHav6EOWNtemDm4LDWKWhC5c8yCu4MgbbnGm1+SlefMzgl00Yd97c/grdB5e5hA1wEV5wu/hue5IxWFmp5FOCH7tY+/Oln5FlYpQGu5KfjT5z6rMYPzvNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RbJUlx+B; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290d48e9f1fso221285ad.1
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761753925; x=1762358725; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BIU8Um8BPgL2WzCtUTTPlVESfJGh0Y3j8A6kvteAFhw=;
        b=RbJUlx+B7JliffCG+cvzKGnTwLbDswo8oSxrXU/qhSw1lAQyE6gvry1IQTKwQ/ImyQ
         Y62nyky/FBfpDq18g62nCyMOvJ4Vv+JjaIuiI375QvSbCYzVfefBgV9nnVuS174Tcxko
         0sFoVENhQ8ILoqejO+KOV5i2gsv5yV112AmRp7pTcKDMb4Z9VoauO9FMLCt/vgWaJvmf
         jsOw4lc99FP4yigQM56AapoawY1RRtFsAJ2zHsMDikgqfZtYbDbcUiVGE6M9emHzNrnL
         R0638q0s5broUdhYvAxARZv2E3JGMKHPDUp9XHeXsj41g5gjcfyInSTVU590ZuJISrYU
         DN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753925; x=1762358725;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIU8Um8BPgL2WzCtUTTPlVESfJGh0Y3j8A6kvteAFhw=;
        b=pUHu7IppXYc27eh5K5IGyzxito5p5vM1nXa5/1fScSMHKEO2MLw3CIw1V9d51upZyx
         diY2GS27YsGy60GBl7XlGi48X+vVXeVWZQpzb6nJJdpDXL/jnjJ/66ebcmp9L1axHHqU
         htFQ+UXWmEQkuYrqz8iuU+sWQkL7cRL+nRf2ZP3dOIfXlzgxkAafyyUfIe7/j+CRaddz
         QmtIomAFAICVUgR+/Fio3+KKJvc1wbBeDkaKHXxm94yeJ51NJn+3brMXwxi6GK6aNcbf
         ijCF9dlpux4/8OKaxu/co3JIDySTgjDY/SYsjI2p2IFd9EGeZy2WxRLclWe91SMyWexB
         sRmA==
X-Forwarded-Encrypted: i=1; AJvYcCXNSds+QZ2F9uuYUTr8FgQRhFNvGQ0sVVYPrq85JtqHjeb5tbV0yqDbh27gR9D05e9nyaRrzOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy73a0OLrXPeGcZT5yohkb5pprPBoGttnzl5kuqojVx40pMuZTz
	YTe3iiKipJBsVtZkNcTwH8tAfz82IiZ7JSr0aJwfJRDht/6RkydjRms6Xq0brNtjrQ==
X-Gm-Gg: ASbGnctOvUB3tAbOaQtTm+qT8o7wSuJQRPHHEbTzfQV6yp0y1zQKYYQ6Fpuqfmj234d
	WeDFNiLBqD3VZCtJx2y4NuBJ5eZ1t9VRnOdyaj6Kj42E7hCq+aYISvrIYZJXLwj3xXdXN+0jTOT
	BGqQggeZ4yKDQkU1oMIrUVrXKKJH6SQq929iKqSD1RhUhPElSjxlONjM7Y5489GmVgcynn+gXQF
	wsf0JXnzKrG8zmBpx2WwfdvCw3VMRSGHY1tI6GwDEHh/sTXleWhKXHGJGlbJuQilRaTReGuDJRt
	yXymU1omEWDAbsxqcWe0iXRNASBOvijT2ZNiXbu1eDM2a/Pr5wwlJFLGbCIiIJ39PJawGBvuO9v
	Br3YLkIhRRzdWENG85EvYwugRc1BDq5IKSovXjaWxbQtXa2K8bctICFzJ/2mR6+mvqra9cAqdMm
	ScnsjaZJTzYybHLKEqt5WgiwDbDditXD0iLEGUDksCDv4xHWjSJk0O
X-Google-Smtp-Source: AGHT+IH50H8XZUhKOk1BG6ZMwEmt+C2yXsqtYcWtxAtNyDfESNv0JPO8bpdkgmBdrdB3py/5H6vBcA==
X-Received: by 2002:a17:902:d4d0:b0:290:dc44:d6fa with SMTP id d9443c01a7336-294de776f6bmr6222625ad.16.1761753924749;
        Wed, 29 Oct 2025 09:05:24 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e51:8:9ab7:9682:d77a:f311])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414087d2asm16040138b3a.63.2025.10.29.09.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:05:24 -0700 (PDT)
Date: Wed, 29 Oct 2025 09:05:18 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
	kernel-team@android.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/mm_init: Fix hash table order logging in
 alloc_large_system_hash()
Message-ID: <aQI7PvFcpxFd_IHv@google.com>
References: <20251028191020.413002-1-isaacmanjarres@google.com>
 <dcceca48-bbdc-4318-8c07-94bb7c2f75ff@redhat.com>
 <aQI3z0x0gZ3T1fij@google.com>
 <b13bf4ce-a6fb-491e-a8c7-ecce0d4d87d2@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b13bf4ce-a6fb-491e-a8c7-ecce0d4d87d2@redhat.com>

On Wed, Oct 29, 2025 at 04:58:37PM +0100, David Hildenbrand wrote:
> On 29.10.25 16:50, Isaac Manjarres wrote:
> > On Wed, Oct 29, 2025 at 11:03:18AM +0100, David Hildenbrand wrote:
> > > On 28.10.25 20:10, Isaac J. Manjarres wrote:
> > > > When emitting the order of the allocation for a hash table,
> > > > alloc_large_system_hash() unconditionally subtracts PAGE_SHIFT from
> > > > log base 2 of the allocation size. This is not correct if the
> > > > allocation size is smaller than a page, and yields a negative value
> > > > for the order as seen below:
> > > > 
> > > > TCP established hash table entries: 32 (order: -4, 256 bytes, linear)
> > > > TCP bind hash table entries: 32 (order: -2, 1024 bytes, linear)
> > > > 
> > > > Use get_order() to compute the order when emitting the hash table
> > > > information to correctly handle cases where the allocation size is
> > > > smaller than a page:
> > > > 
> > > > TCP established hash table entries: 32 (order: 0, 256 bytes, linear)
> > > > TCP bind hash table entries: 32 (order: 0, 1024 bytes, linear)
> > > > 
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Cc: stable@vger.kernel.org # v5.4+
> > > 
> > > This is a pr_info(), why do you think this is stable material? Just curious,
> > > intuitively I'd have said that it's not that critical.
> > > 
> > 
> > Hi David,
> > 
> > Thank you for taking the time to review this patch! I was just under the
> > impression that any bug--even those for informational logging--should be
> > sent to stable as well.
> 
> See https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 
> In particular:
> 
> "
> It fixes a problem like an oops, a hang, data corruption, a real security
> issue, a hardware quirk, a build error (but not for things marked
> CONFIG_BROKEN), or some “oh, that’s not good” issue.
> 
> Serious issues as reported by a user of a distribution kernel may also be
> considered if they fix a notable performance or interactivity issue. ...
> "
> 
> -- 
> Cheers
> 
> David / dhildenb
> 

Thank you for pointing that out, sorry about that. I'll keep that in
mind moving forward.

Thanks,
Isaac

