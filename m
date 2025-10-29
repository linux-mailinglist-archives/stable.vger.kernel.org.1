Return-Path: <stable+bounces-191633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA35C1B614
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 15:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 540FD5837E4
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012BE290DBB;
	Wed, 29 Oct 2025 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vidcva6t"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6DF19D08F
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748600; cv=none; b=oY+CPBWtqPEM/h5BvwqlP2Z1LmWyCu7PReAonotbj3nxXi+a+qrypXIEogmHpG3gNUdUqmdHa7xlvU+KjntO9xDmPeInayY3+6z9jMCjZh9Glbzs4XPikI7AV0VE6asVdcfiJD6DmLJ0yMbo1Pu2bENom05LT5MK55lDz36nmtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748600; c=relaxed/simple;
	bh=oHJlg5Z1ODa4YRFNqoiOQMwC4YO9v08tbXK53/bV4NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oz5IqtGwtOiAKPZmduEbg0wd/HYhRdnJjSwW3SwDwnHxsu7183Z2Hcvm/HnREQXOuRVafc/05TUdHRmg0NHU5hKMu179EQ6L7188s+6jLIUa7DBhcAQfHWq9M2PlatAvpuCMl9y3/wTTBy0dh97XhAl1tjsE1gzxRa4BvKKOkds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vidcva6t; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-378df5bf75cso7001201fa.0
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761748596; x=1762353396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMm3nDEHqh0Duo/pCGz7alBh4a7cGfmIeQ4bIaczRPI=;
        b=Vidcva6tSsDhOx3m6P/dXqjxH6nAYRuqIhBAxEWHw7j06mk7WHikQP2DdT/7PXdi+Q
         5ylcocJLpaWQC7vYPyBmEZkwZS0t73Zq1HF5R/oRJFaibbTtqVL4gQyr/t0JQCbf1BbN
         mtqYWH7qyGUSMjACwX5+xCmRlTyea8Z2ph9iywc4viRoeLJyypTybCG1PxmvCfp0nbYE
         3KSiXZJSRvySN36l8GtL8tfryL8tWypUtUs3aTXPiKvEm0okaba+zZA6sk5nK17+0/eK
         pYeoIogpeU7TNMZ1k0iwPkWCjHkrByP51G2xE5F/amydjNzQShUdgGXJk9GSgq3GJ5om
         Vg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748596; x=1762353396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMm3nDEHqh0Duo/pCGz7alBh4a7cGfmIeQ4bIaczRPI=;
        b=P+0Bv+mOQ+Mwdn8iDeKXtcHtm/BCSf/E1Z5OkGh4z/F5ywXBqlpcbGSOixGFtrjti7
         jN7NeUR8DXL2tOI6RPswq7xMoPXnaPD2MuNHyUSbKp8kIG8VHCvqAbmLryzQk2ANtwXs
         dpyfbC1OEsj5v1etv5ZLRpIzbWQQqh9NrXW0ucycrZfkhBrLYHvLCeNtW9I0wzumTUPJ
         02i2l8dUv7AB4iBgZcHXgE6egvjA9v37rlzPV3aiz/s1JbiCAFolWPFf3T9OdFzMPKt2
         t6AuWXOI6uB1VuWaFo+O+D/HBm9xKn5S5rZol2JLwaterfO2MejG24dkV7t4vc2YrEBs
         DzCA==
X-Forwarded-Encrypted: i=1; AJvYcCXToJfN7baa1iALDDNVLMFES5HloqfZ7qX1KPFzT54KoCCAqBnWVgfoyId4EYsw4VHEuCQgdgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA+cpFLERyd/En4dUL/6AKZktA1qrNlfP/mQkg8bRo5IcmgER5
	TSzuGv2hab1TnO367ArCJZ/M3SheMURqzpOmIUEIpzQXxtTZLm0xGAyO
X-Gm-Gg: ASbGncsGcIqqT9SyyJFdoe6zl4E9e9XGqj3OeWo5x67RQFlvK1Xl6rmXFBMtNcd0gpa
	QJTm4f5tMHyrTBuHvaIyMkNBZZfugBnnrpCOMROgxggh2S+QkFKqJQbgWksDwfFah1xmOTvNkDH
	FSbApB+Ns+pXjiGeBbY+XYqVrb+IQrnzLzZoFsQ+F8yJR7oz23wbWqzNhhD0JI3/plACjBghPId
	og0Q0bijquF4BLUOOfMs3bMAQPm5UaQbisQPC2m2uPzcaOzzTByNGmiFtJz1PDrX5y3jo+wj5Yh
	DghOddvYNxEz4/VHDvxoH6xZO8i2o90MtEw10gjA8EG9FWHdagCX0ITUWcKaDeR8PhQh+LvDWgG
	07xOBFGF2r39615N8T3aPCOtMH3++paIwDl7Gmt9kwHXDQwv43LxzkZEj5mvJJxKIbYuH1iZhjC
	Pe9zfbXcw7DKUQcYq1
X-Google-Smtp-Source: AGHT+IFLiz5xmWOhoWEAxRsXVnqSuOwatKraLudgPyAUhj3vj9LKZLHRoICq06za6lOxdckgCWiUCg==
X-Received: by 2002:a05:6512:3f0e:b0:57d:720:9eb0 with SMTP id 2adb3069b0e04-594128e00b4mr758281e87.10.1761748595850;
        Wed, 29 Oct 2025 07:36:35 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f700fbsm3962183e87.81.2025.10.29.07.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:36:35 -0700 (PDT)
Message-ID: <1bc9a01a-24b3-40a0-838c-9337151e55c5@gmail.com>
Date: Wed, 29 Oct 2025 15:36:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/slab: ensure all metadata in slab object are
 word-aligned
To: Harry Yoo <harry.yoo@oracle.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>,
 Alexander Potapenko <glider@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Feng Tang <feng.79.tang@gmail.com>, Christoph Lameter <cl@gentwo.org>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 linux-mm@kvack.org, Pedro Falcato <pfalcato@suse.de>,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 stable@vger.kernel.org
References: <20251027120028.228375-1-harry.yoo@oracle.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20251027120028.228375-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/27/25 1:00 PM, Harry Yoo wrote:
> When the SLAB_STORE_USER debug flag is used, any metadata placed after
> the original kmalloc request size (orig_size) is not properly aligned
> on 64-bit architectures because its type is unsigned int. When both KASAN
> and SLAB_STORE_USER are enabled, kasan_alloc_meta is misaligned.
> 

kasan_alloc_meta is properly aligned. It consists of 4 32-bit words,
so the proper alignment is 32bit regardless of architecture bitness.

kasan_free_meta however requires 'unsigned long' alignment
and could be misaligned if placed at 32-bit boundary on 64-bit arch

> Note that 64-bit architectures without HAVE_EFFICIENT_UNALIGNED_ACCESS
> are assumed to require 64-bit accesses to be 64-bit aligned.
> See HAVE_64BIT_ALIGNED_ACCESS and commit adab66b71abf ("Revert:
> "ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS"") for more details.
> 
> Because not all architectures support unaligned memory accesses,
> ensure that all metadata (track, orig_size, kasan_{alloc,free}_meta)
> in a slab object are word-aligned. struct track, kasan_{alloc,free}_meta
> are aligned by adding __aligned(__alignof__(unsigned long)).
> 

__aligned() attribute ensures nothing. It tells compiler what alignment to expect
and affects compiler controlled placement of struct in memory (e.g. stack/.bss/.data)
But it can't enforce placement in dynamic memory.

Also for struct kasan_free_meta, struct track alignof(unsigned long) already dictated
by C standard, so adding this __aligned() have zero effect.
And there is no reason to increase alignment requirement for kasan_alloc_meta struct.

> For orig_size, use ALIGN(sizeof(unsigned int), sizeof(unsigned long)) to
> make clear that its size remains unsigned int but it must be aligned to
> a word boundary. On 64-bit architectures, this reserves 8 bytes for
> orig_size, which is acceptable since kmalloc's original request size
> tracking is intended for debugging rather than production use.
I would suggest to use 'unsigned long' for orig_size. It changes nothing for 32-bit,
and it shouldn't increase memory usage for 64-bit since we currently wasting it anyway
to align next object to ARCH_KMALLOC_MINALIGN.

