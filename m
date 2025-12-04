Return-Path: <stable+bounces-200073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B21DCA561B
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 21:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10CE930AB86A
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 20:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495572F3624;
	Thu,  4 Dec 2025 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4WuCAYE1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8875229B8DD
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764881646; cv=none; b=aSbO8DIt3JQJbFjQHunb7c3k31VeWkt/wlFQ7PkU6OnPQ0RIhfmXt10iq6yECO8QFZp67alXWMFKUVjQzReBA2fAUaDQM4TiNBcMHUMt/QB6pye96QU3pOOyRyViLR6OfMw0+kllG8dyIl4ySWJx3r/sNPbT2MuelY7TtGCE7Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764881646; c=relaxed/simple;
	bh=di83QS8+oAT1E+aWv+KEAdublIK6kGyoYIU9ovp0L/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5mqAZIodW5bG5eZKxbUNrlK7u6O+zT8ZbVp7tIr2Zm+a5Bxvqj712378YZKIvgf3J9G04yO0rCp9ugH/XgLyoUENrUKxU3JpG92O4JF/t9xwlSuGNqR++XJ16jotmcUNoBJ+hqY/+VIqSc1LUJahLy3YorES4Ao9uktT21R4CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4WuCAYE1; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c6cc44ff62so1087469a34.3
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 12:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764881643; x=1765486443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FjxV1GGIN9looIm8lhU6Qg0odw82tyPmLwTXfLVcqr4=;
        b=4WuCAYE1daK8qDMlL7BH94Uic09vDhfBEmj4HRVqS1ND4ts/SankNt82TRZQ2MvYZS
         NVNgBmIX+vIzqiOqMRjRMvhtn1y3t4gfNtQPJ/2DJwVL1O1eDhN874CTO5dO8wAR+D7h
         9Fu76chQuNI2IAKP5AJn6tDgsBjI51NXSzgT/y5eOOiPVcqqaHOompl+ndhCfyK0w/zl
         /Lz4/zAd/Q2hnROdi/oqrl3Z3IN7tzC6g3D7myorhvonvzKtVyNxgKsNW++lUMe/DJfB
         xF0n2758VAOM/Xwnm63VqdhrMQomm72FumR0ao7DigjtJh8yQXHfJU2fSoBNOLHzTV+L
         J8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764881643; x=1765486443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjxV1GGIN9looIm8lhU6Qg0odw82tyPmLwTXfLVcqr4=;
        b=keTOTHlbe4sNNuCZDjmOcGFF5y9+hIsrAAYalvOkpQCiEPR4AP+RjCQ0reI8nCQ5PA
         1pk9B3VZr3FUd9rQonou0Ciy3kvI3hI1ixwnI6UvYFOrtLX9wClIXcenB6/Mc8BssXGR
         vx+pza1pi+atKhayHZH00wd+EbFbxzUZXfO7/V6GQL4EC8yv9YomvTf9QnodUoC4RkB2
         LICm/OliIYl05UbwbOYpuTzi6XQeWUeaZ0IgMx3eGwvn2N7NR3Nt8KX7UsZ8khrIW2D0
         HRtN1s+8M5cDQUJSRng7sSQh/g0XCZyUrayfZNB6I9HKL+I64fJ7xYaZ25HCWthzMJ2v
         0m0w==
X-Forwarded-Encrypted: i=1; AJvYcCXLz/3sSJJFflOfEV3PU6lSxYcv8ADshkYFx0pgDCuwY5YURCseYAIvvVSx+9V/5JtqS4VQTa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgl0lUGk7jb16xnz5kheNs/EBLh3UmOWAkA6G/RLvnpoddA2T8
	9My4AcT1F4JQeuddKD/eOQGwtqgxHHfbobrmdATACrygClBNES8CSmUrduF7JF2Z4w==
X-Gm-Gg: ASbGncsPK206Ip2uw4KZjmKWJJJRwQU1Ziu5oa4Wuwlna76Bs6DZHQmVpx4hUuDoNxd
	0HvXE6ZWUEbQPKJVH2XVbuxw6pzCToFCmZDLpJm0HRGJoOik6T3aoHWkIfIqkTmjZzu8BVCcYqP
	NuGN4B/POr5q+OBRjy72tHJuYTMllIF8OwFpNAH21qIlUD4kQhUe5eHqfCdOYHxE4N2bRaHRlP0
	n+0XKJOY45hmHpRv7ABDihNzJHhQfJE8YqmCHGo39Exma8QtCYd3Vn34nyM9OuWHZzRj35rCd9J
	z+wm4sosOIstTq+LDNwyDCL+9s8tlknTuzQYS9PyjIBT63H3vejlPorXGdWuW1pXkRS3evTq/v8
	CeMF3j/FdQA25zqjslKA0Pb4tSZiO+Cpkfn9eetP2Enq3RRIbi7/FvYUtOKfrygt0bKeL2XA7nk
	rDZ44CfUmDB2SPCiI7CZTjzmLLcetuuHTca62+FP42Xcl0ZBL5q0ni6XPP
X-Google-Smtp-Source: AGHT+IFc4WbzNmVwBOO7OsptYXIZilhlzYjJdJRMxyn1AGPFNdJAn0xtmay3Ejl641B+vFs75D2TtQ==
X-Received: by 2002:a05:6830:24a:b0:7c9:5810:92db with SMTP id 46e09a7af769-7c958bc42acmr1961422a34.29.1764881643438;
        Thu, 04 Dec 2025 12:54:03 -0800 (PST)
Received: from google.com (122.130.171.34.bc.googleusercontent.com. [34.171.130.122])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c95acb0565sm2127096a34.24.2025.12.04.12.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 12:54:03 -0800 (PST)
Date: Thu, 4 Dec 2025 12:53:58 -0800
From: Justin Stitt <justinstitt@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Will Deacon <will@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Christopher Covington <cov@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y RESEND] KVM: arm64: silence
 -Wuninitialized-const-pointer warning
Message-ID: <2lse2swdqrovimdsakgtriadki2fsvikhuetjzxztoui5hpsai@6mmc64ugt22k>
References: <20251204-b4-clidr-unint-const-ptr-v1-1-95161315ad92@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204-b4-clidr-unint-const-ptr-v1-1-95161315ad92@google.com>

Quick correction:

On Thu, Dec 04, 2025 at 12:50:11PM -0800, Justin Stitt wrote:
> A new warning in Clang 22 [1] complains that @clidr passed to
> get_clidr_el1() is an uninitialized const pointer. get_clidr_el1()
> doesn't really care since it casts away the const-ness anyways.
> 
> Silence the warning by initializing the struct.
> 
> This patch won't apply to anything past v6.1 as this code section was
> reworked in Commit 7af0c2534f4c ("KVM: arm64: Normalize cache
> configuration"). There is no upstream equivalent so this patch only
> needs to be applied (stable only) to 6.1.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7c8c5e6a9101e ("arm64: KVM: system register handling")
> Link: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e [1]
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Resending this with Nathan's RB tag, an updated commit log and better
> recipients from checkpatch.pl.

My usage of $ b4 trailers must've not been correct because this 6.1
version didn't pick up Nathan's RB tag. Whoops! Hopefully whoever picks
this up can add that for me :)

<snip>

