Return-Path: <stable+bounces-176831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C049CB3E004
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 12:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3F1D7A1DAC
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 10:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536363043DA;
	Mon,  1 Sep 2025 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHnmmQhj"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE8817C203;
	Mon,  1 Sep 2025 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722220; cv=none; b=huH7uj4sRJFf0C7NCZtZMDMSCxOs0fp+vkxw2sUna08zmRz9TFI5kOlO2fbKzmQmO2Fx9UyHIZxqciaEsGozPWXkexFozVzgUsEuJHQiAyzQNIQaUUC7YJnkgEDsuv6S4RfhXRE4rHSmhlwuoBIRIaSXihZyYb+G8S/hyBfK8Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722220; c=relaxed/simple;
	bh=F13tNTAIWTCSuQlqdmuQv3cZ56a3rTILB9GS33rMeoM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yz2lFtnRbYgtBNx0vLbgvAm2ueh7HF/y+KFSk34FxHSKQWtHVug2cUUapc42LQVjhqs5bhV+prIeQdPCsUgI6T7tL63QvpKy1gJO+gDxI8nNRwLvewMoUkItsLnI90IEHSECu4HGUJQ7flMG1JrFQ+fIth81m4tmZ1OEexRCH6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHnmmQhj; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-336b071e806so25884111fa.1;
        Mon, 01 Sep 2025 03:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756722217; x=1757327017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IKqd7PpE3yly34arj4SP6XhH3xgSPkbGcUhsqf+SkXE=;
        b=AHnmmQhjEPl68S0pr8NZfs2/u3ueoTzWuXwmpjFAE5iQeVH9nKECenmXeUSN+VN5B1
         jpP74bDx5CpKuYNy0jMwg+EuwjOs9t6znX1+Ad5A3HJCSZqU2cFmvTqaekrrLx2Q+Xs7
         3fEmogZ5zgArYrhldv5FrVNNRnQZ54HTqbWrM+0m2tfufulyaSQR7iuq0ogbetr/vXGp
         ZVmDINugusJxxVA5MrpUV+9QohR6TEK2//PWk37eOjr2CY7nbbPNTBdjD2KQ7ruM6t63
         xTLnPts4C99FdGi9+hB6IOxABgAiYe/XrM6mm8qe3GBcYhUpCi1O7Lxeu5LBGFa2DLR2
         SBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756722217; x=1757327017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKqd7PpE3yly34arj4SP6XhH3xgSPkbGcUhsqf+SkXE=;
        b=KS8986+qEKYgBvAASyjDUB9uL8LsV5CLknQGY/LwUMDrB3N3/9x5EfkSYWcPB/cLgr
         5kfV33q0nQM9ckCbq/c/HBDuHZtZS6CDxEqKunfNtmcnt7q74Tv3cxm3PVexK+tKPbt3
         YoyCqXzJkyOYPNuMn1k4Cei8CNJ1WDKt8AHNk+5PfhI9Remc/6DBT2RFK6vjHB6DDvnp
         HplBd/v+CHWG1MkJtw1PGOrynhUtShKYaUl9/drhF71GiCvs2qewU0eOytRzMr12YeEl
         CWJOzcrogZGC2df6WFcSPYn1Y27RZoNCmRFFIGSndmHuhiuFd4qhVdmrk6n5Em2dx712
         SK6A==
X-Forwarded-Encrypted: i=1; AJvYcCWRRC3timWBuSKmsD7pgz9zoLkj1m0wHG/0WJD6vfi7JVkQOh4MArkbAYJMn7IQYni61cIZJPcn@vger.kernel.org, AJvYcCXcRTzm2QNpk67mWC3LWXNDdlpzE7Q4uno5O6zQcOQxorAFqIQK03dDMifGttRCmXLSGLsU8UspocOxZb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq+mzENiOkQDTQf7e9CgBrReYaJOpqc9iGIn7PvqzCGIkRV1kj
	1o0Uq8i2h5lhvidy34DrPWyM3Q0YpKgRMhCwj0zh2NMx0NXwWPFXnn/M
X-Gm-Gg: ASbGncuN9Tpu52/pezGV4boUfh3XZTMAM/DZ8G4sAZ8H0DE7wdegw7Svp9azOTEkVIY
	9t5JHL09bPgfDqqDkEPuv5XNC+n9VojgIUZtnSQMcG6Dp8emCjIWBgeuJUQt4N3xlI6PEQTB9rl
	m6dp8K5QfiT/V9pFDDYFkUxccwOe/nYk674658/Y+8SZVBJ42pLvofHuW1ha0Wa/R8za3oL7Hfi
	Gj5HeZNiITFxpifvrSzCINAm0X6j2gbnfqEG6eimJiqLsQdjaMYgdANNXL1cSltdOP0d8I7pv05
	1+pvnmvRZcxXuHpHbGEg8OhBYQK2oLQxzS8WmPgO0r17XcFS0+E71BfejpDPE/o2VNIJmqwAX8i
	UaeELwUWZA+kUALGVKGDxcLfzQfQp
X-Google-Smtp-Source: AGHT+IEofX/eNnkXm26e6KDt8g+jikWgXxGGcfHBANCoOLg4hL3QjuemdJNTszKyuEhhug5qw4amEw==
X-Received: by 2002:a2e:b88f:0:b0:332:5fc0:24ae with SMTP id 38308e7fff4ca-336ca98d99amr15516571fa.15.1756722216273;
        Mon, 01 Sep 2025 03:23:36 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-336d0c583absm13691161fa.2.2025.09.01.03.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 03:23:35 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Mon, 1 Sep 2025 12:23:34 +0200
To: Baoquan He <bhe@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc, mm/kasan: respect gfp mask in
 kasan_populate_vmalloc()
Message-ID: <aLV0JrSPfitu1jFV@pc638.lan>
References: <20250831121058.92971-1-urezki@gmail.com>
 <aLVyia16eyoYftAw@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLVyia16eyoYftAw@MiWiFi-R3L-srv>

On Mon, Sep 01, 2025 at 06:16:41PM +0800, Baoquan He wrote:
> Hi Uladzislau,
> 
> On 08/31/25 at 02:10pm, Uladzislau Rezki (Sony) wrote:
> > kasan_populate_vmalloc() and its helpers ignore the caller's gfp_mask
> > and always allocate memory using the hardcoded GFP_KERNEL flag. This
> > makes them inconsistent with vmalloc(), which was recently extended to
> > support GFP_NOFS and GFP_NOIO allocations.
> 
> Is this patch on top of your patchset "[PATCH 0/8] __vmalloc() and no-block
> support"? Or it is a replacement of "[PATCH 5/8] mm/kasan, mm/vmalloc: Respect
> GFP flags in kasan_populate_vmalloc()" in the patchset?
> 
> I may not get their relationship clearly.
> 
It is out of series which i posted to support no-block for vmalloc. 
I will base a new version based on this patch because it is rather
a fix.

It is to address and complete GFP_NOFS/GFP_NOIO flags for vmalloc.

--
Uladzislau Rezki

