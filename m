Return-Path: <stable+bounces-12293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D7F832E21
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 18:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E34D28809C
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D976055E6D;
	Fri, 19 Jan 2024 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="quGWsSGd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2821F60B
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685245; cv=none; b=UyIn4Df6kulCaqYjimWn0f+8jViQkaTMH7f9eOO0Aqf+nEDXQ/HTHd0wfL0RMlYTVfi0PBCzs0V0NKlptYLXDk5vInmBHgXi4gTdCmCs5c2Cnxt2bTy5fdASITPK5UlG3J4DIP3XQGRfsUPE12u1OtzbTQN+jvwP8enkfWEEZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685245; c=relaxed/simple;
	bh=hQAkoZXDTSlJOPauCujJoN2NrBGM5OoV2NNA7O0qjTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8/6pUy1QtaUuM8AaMkHvRZdr1r9zjZG5BXV5jqPda52LgsYLqJ552KPeWXZbd/yxHu21V9dfGMARJgpy7GQJtTtQaLR5cnUW3JVkc6yvD6lg6qNWUjalYyP/Mz/vM3bnUOMUt+kf7dONpqQnKZwYvBNL1aZwOb09/VzGuVdORE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=quGWsSGd; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6dbbcb1aff8so723350b3a.3
        for <stable@vger.kernel.org>; Fri, 19 Jan 2024 09:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705685242; x=1706290042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7a9skkOJDoeDAzXAlrhaoQRm2nSLoLLiCg9+PzsFlc=;
        b=quGWsSGdOEtcTU9ih2drDjVvCefQO4cs7BSRcO4Es0flrcpXliW1PexXT+RbsXAYEF
         p2Epbf3X7YseqN8BVVE9nWp55HO44LKdPh1UnVrk72dvv9JHoCxPm7PwahZLLKvbEQMl
         186aMJYA/K2dhm8KXAe3K2m3BuPATWBn5eC0mLCqVVGNLGFeCpqMxpeiyJGbHoG41CqS
         u8j2fGGL4z1RBR2KqICyfEBKy2jN6jzbPDsjjJsxUfKinWrY5vfLE6pmn3JIlCa9awjN
         A5qlk/LUfiMO89gmfIeAKxFw84J/DsLteTI5jJFc6nZUn+T7seFtUGzYtXTWXp1l2TQ9
         DyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705685242; x=1706290042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7a9skkOJDoeDAzXAlrhaoQRm2nSLoLLiCg9+PzsFlc=;
        b=H0tI/bZrk2u3RhsAabu8Y4rfT+hR2F2w1IxQOKXhYCd8mYH+/RknMlCUTh0bOogu8W
         88Ny0LExCHtylZsEizTCSTPvIHQYPIderXTechjPQIrirFVdxvARnYSokEMb2Ko9kJT4
         1JjAh37OBHKQwrHrg362udYz9Fj19e+2xKrKZN36IZth+I2o+Mjr90pvZp04lUcQnXzD
         azBtV4NlYGsWgPHaSdn3VEUR59hoAmzBaZOvsqqCVMPiMev8k5QXWHbjHNonGjUGdl+w
         ErDg8zv5YmMy4G1j1vFUOEAT/SA6ABMMA3U+bRueAb4TCzNGqxrRPaZclk77XWGHCrdc
         D//A==
X-Gm-Message-State: AOJu0Yzt2N7hHcsvxNq50db3EhJIFcgnEc2z6ZHYm2GlA69MQqtZ7XuD
	CnC1a18HCEes0RCxX47H6i8CR+yVb6Y1uDeJCd5hYZizFaSaCgRzUBEla2Rx9g==
X-Google-Smtp-Source: AGHT+IHbPj5dmEcO+DPizzQGXx6W1/gkhwSh7+VkZCpN/lNtDGV1jDgPXi6RNH85CfIegjQ4SZ61pA==
X-Received: by 2002:a05:6a20:e123:b0:19a:e66e:b155 with SMTP id kr35-20020a056a20e12300b0019ae66eb155mr155863pzb.74.1705685242498;
        Fri, 19 Jan 2024 09:27:22 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id i124-20020a62c182000000b006dadc436071sm5574807pfg.36.2024.01.19.09.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 09:27:22 -0800 (PST)
Date: Fri, 19 Jan 2024 17:27:18 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Sherry Yang <sherryy@android.com>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 05/28] binder: fix unused alloc->free_async_space
Message-ID: <Zaqw9k4x7IUh6ys-@google.com>
References: <20231201172212.1813387-1-cmllamas@google.com>
 <20231201172212.1813387-6-cmllamas@google.com>
 <Zal9HFZcC3rFjogI@google.com>
 <2024011955-quotation-zone-7f20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024011955-quotation-zone-7f20@gregkh>

On Fri, Jan 19, 2024 at 06:49:00AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 18, 2024 at 07:33:48PM +0000, Carlos Llamas wrote:
> > On Fri, Dec 01, 2023 at 05:21:34PM +0000, Carlos Llamas wrote:
> > > Each transaction is associated with a 'struct binder_buffer' that stores
> > > the metadata about its buffer area. Since commit 74310e06be4d ("android:
> > > binder: Move buffer out of area shared with user space") this struct is
> > > no longer embedded within the buffer itself but is instead allocated on
> > > the heap to prevent userspace access to this driver-exclusive info.
> > > 
> > > Unfortunately, the space of this struct is still being accounted for in
> > > the total buffer size calculation, specifically for async transactions.
> > > This results in an additional 104 bytes added to every async buffer
> > > request, and this area is never used.
> > > 
> > > This wasted space can be substantial. If we consider the maximum mmap
> > > buffer space of SZ_4M, the driver will reserve half of it for async
> > > transactions, or 0x200000. This area should, in theory, accommodate up
> > > to 262,144 buffers of the minimum 8-byte size. However, after adding
> > > the extra 'sizeof(struct binder_buffer)', the total number of buffers
> > > drops to only 18,724, which is a sad 7.14% of the actual capacity.
> > > 
> > > This patch fixes the buffer size calculation to enable the utilization
> > > of the entire async buffer space. This is expected to reduce the number
> > > of -ENOSPC errors that are seen on the field.
> > > 
> > > Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
> > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > ---
> > 
> > Sorry, I forgot to Cc: stable@vger.kernel.org.
> 
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

Oops, here is the complete info:

Commit ID: c6d05e0762ab276102246d24affd1e116a46aa0c
Subject:   "binder: fix unused alloc->free_async_space"
Reason:    Fixes an incorrect calculation of available space.
Versions:  v4.19+

Note this patch will also have trivial conflicts in v4.19 and v5.4
kernels as commit 261e7818f06e is missing there. Please let me know and
I can send the corresponding patches separately.

Thanks,
--
Carlos Llamas

