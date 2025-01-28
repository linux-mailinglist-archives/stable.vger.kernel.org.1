Return-Path: <stable+bounces-110925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3D1A20358
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 04:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A6C165868
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 03:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4C51DA4E;
	Tue, 28 Jan 2025 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtKwE+YX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C834A1D
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738035038; cv=none; b=RidH7wI3WZeWJVvXXIkgNQUR3csjOs2IPgTy1/4kXNedt+z9XqP+SPt3iz8RTUeDGO3lNdOqANzR5y8GWSdieAVjp2v7d1E9pcHFYX4VrcrU2SDJS3UxZLikJF6n0lqXMhM8uRL8zsFJvMV85JvuIm9lDe4PFYBnCWVuG8RdsEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738035038; c=relaxed/simple;
	bh=fFpgf3BzW6nJFY3bP+LtA2WAQmJ5Pn+P0AcD5DvSntw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUU3hrpIoySSQjU0A0nRONJCn7/eQSOpXpOBG1gSO2XcXxElwOESk8oOlzn0WSZNJZ5fmIHZURZ9Xu+9LiULagvQ70IJekPN84EBeeas67BR6GZf8bsz0gaKcsJ5wfe6QeYdBs2Pps5GmKehCMQ7Yrz0PTodVCIZQ0V5r0Ij1z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtKwE+YX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so57268066b.2
        for <stable@vger.kernel.org>; Mon, 27 Jan 2025 19:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738035035; x=1738639835; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67F838oc+dojbhnQEcvwv7YodRtpbtCE6Z6PyI/ngN8=;
        b=KtKwE+YX0U2/9AjObPxc2DdiQ4eU7o8kRzD+5zksoomkHXMKtCxbUkBbgA99G5qBO6
         zqgzo570a+dPJNyQpWi8slusv79LW8n2aQ7vNcfE2M6cC6f++z0tzRxAZSHJfqKWvMe8
         mhppTQ4QuyO45J6ngP8ZZl3tzapyqF/zAzu0H8VoxR6S+2VW9a0tn3ul4KEOX4LTQrqM
         UO7PdtBpFafu9qFHn6rffNqVSEz4w5x261qUSmrL7O2jy1xX/CEV3ewPjECU3Ew6usIx
         olCwdJ+T3gPEyUkbFPKViwKrlv8w/LlzBNazz8YBhcpL7V8pmdtNnotE/llcVEHh9XHW
         CicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738035035; x=1738639835;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=67F838oc+dojbhnQEcvwv7YodRtpbtCE6Z6PyI/ngN8=;
        b=GXciDjvkWOXiJM1DWX2+IbUzCKhVIGs3vk5EHBg1R0hY17pqWNf4WdedGGhVnmuW2l
         39zWHV0iWHUXZN8T4HIFQXazpanbl+FSk+C9DJo24uG9bCahL8L82D7nPmLP6RH/jnPe
         FaNFHI5MCVdRDf3u+iL74JqiK/RdoVyCLYWNoy5y8asXrF8ptjknfNYhq/OtGMnTHey5
         lhXGlpQ1jAWZU5UrMd68AsTslxB6Jpe0IU4XdLCduq69Uun9VEyDCUEGVByCeog9fXtZ
         X88oxIyasAMWL11eRvRPpRmaxfhUtEU2CAneffuOX9+cmN8d0kTF3tTAuVtxMX9UFXO/
         ymaw==
X-Forwarded-Encrypted: i=1; AJvYcCXXFC0vi/Dn6x/FKtVEeBXJmdCBgvaeK4ibiN5O7dxO3nPC4qI7bu5QNJpMvfs49GRo/GtWpPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZORkv5HzOmUbp27xBG7kxcm4YIDaO3QYZcQRA48PHL/4kAnUU
	hCRCky9wiNtTtOOLn8YUXsWO5pqaPux4cD52eHbHHdRCiyfMii3Z
X-Gm-Gg: ASbGncs9IeFmDoTorSriTiBb+ZP6MY+MFTDDDgmUrho6TehSJ4qh7UCzNpGL3+urOQQ
	2L6hF2cnzz9xLyAXRYuX/iX5Wig/XjTZRMD0PXkbmVX4ZTAXCY3RNUpyaSi+pczhrTBWxPdT2FQ
	prF7RLgS5ksux6OrsxAw261V+Wu73cNbgjGe5ie3knjfRYge/SRv8rMtby7lKqR13y97If6a3Vp
	Gc4WX2jP1Oi3CxmIN6zyq5+LdW0m6itoM+w8eqSEHu+IZqoTtBywNX7yavNNsJTNG3HBlV45QEi
	oCntfBJwa37NEP0=
X-Google-Smtp-Source: AGHT+IEf2qKuHXTYcAUUhGXUpk0g7e8L3G11lWnZRuVGroEYxi0LMHlRQA9QLELJdipbR0xO2rwuBA==
X-Received: by 2002:a17:907:72cf:b0:aa6:8676:3b33 with SMTP id a640c23a62f3a-ab38b3f8f45mr3795472466b.47.1738035034510;
        Mon, 27 Jan 2025 19:30:34 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e126eesm697978366b.14.2025.01.27.19.30.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jan 2025 19:30:32 -0800 (PST)
Date: Tue, 28 Jan 2025 03:30:30 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	Liam.Howlett@oracle.com, vbabka@suse.cz, jannh@google.com,
	linux-mm@kvack.org, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/vma: fix gap check for unmapped_area with
 VM_GROWSDOWN
Message-ID: <20250128033030.syh64kqq3xoigl7v@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250127075527.16614-1-richard.weiyang@gmail.com>
 <20250127075527.16614-2-richard.weiyang@gmail.com>
 <ae776b38-1446-439b-9597-a83c4be096ab@lucifer.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae776b38-1446-439b-9597-a83c4be096ab@lucifer.local>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Jan 27, 2025 at 12:08:04PM +0000, Lorenzo Stoakes wrote:
>You have a subject line of 'fix gap check for unmapped_area with
>VM_GROWSDOWN'. I'm not sure this is quite accurate.
>
>I don't really have time to do a deep dive (again, this is why it's so
>important to give a decent commit message - explaining under what _real
>world_ circumstances this will be used etc.).
>
>But anyway, it seems it will only be the case if MMF_TOPDOWN is not set in
>the mm flags, which usually requires an mmap compatibility mode to achieve
>unless the arch otherwise forces it.
>
>And these arches would be ones where the stack grows UP, right? Or at least
>ones where this is possible?
>
>So already we're into specifics - either arches that grow the stack up, or
>ones that intentionally use the old mmap compatibility mode are affected.
>
>This happens in:
>
>[ pretty much all unmapped area callers ]
>-> vm_unmapped_area()
>-> unmapped_area() (if !(info->flags & VM_UNMAPPED_AREA_TOPDOWN)
>
>Where VM_UNMAPPED_AREA_TOPDOWN is only not set in the circumstances
>mentioned above.
>
>So, for this issue you claim is the case to happen, you have to:
>
>1. Either be using a stack grows up arch, or enabling an mmap()
>compatibility mode.
>2. Also set MAP_GROWSDOWN on the mmap() call, which is translated to
>VM_GROWSDOWN.
>
>We are already far from 'fix gap check for VM_GROWSDOWN' right? I mean I
>don't have the time to absolutely dive into the guts of this, but I assume
>this is correct right?
>
>I'm not saying we shouldn't address this, but it's VITAL to clarify what
>exactly it is you're tackling.
>

Thanks for taking a look.

If my understanding is correct, your concern here is the case here never
happen in real world.

  We are searching a gap bottom-up, while the vma wants top-down.

This maybe possible to me. Here is my understanding, (but maybe not correct).

We have two separate flags affecting the search:

  * mm->flags:      MMF_TOPDOWN  or not
  * vma->vm_flags:  VM_GROWSDOWN or VM_GROWSUP

To me, they are independent.

For mm->flags, arch_pick_mmap_layout() could set/clear MMF_TOPDOWN it based on
the result of mmap_is_legacy(). Even we provide a sysctl file
/proc/sys/vm/legacy_vm_layout for configuration.


For vma->vm_flags, for general, VM_STACK is set to VM_GROWSDOWN by default.
And we use the flag in __bprm_mm_init() and setup_arg_pages().

So to me the case is real and not a very specific one.

But maybe I missed some background. Would you mind telling me the miss part,
if it is not too time wasting?

-- 
Wei Yang
Help you, Help me

