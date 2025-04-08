Return-Path: <stable+bounces-128873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803ADA7FA37
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91081898694
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 09:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0E1266EE4;
	Tue,  8 Apr 2025 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="QSmeYnIx"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDD8265630;
	Tue,  8 Apr 2025 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105209; cv=none; b=T1HZwCd4mtmkkAJjkFWUJvBecP44mrseBSaH5okMcAw5WIbH/jP7UCVbax7AW04ttxaGV9AX9mzJtJfW/PHbcDx4keBO4eGInUfQk8u1bLa8W7y3c85zx+NuqDxbyAOUKJfpO5Xruu69SLSufkSGI6rh1VyQV5w9ZoXBucUO+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105209; c=relaxed/simple;
	bh=SvPZcPWxTgGZARLHtjCk4wEyd6DaiH37dYFfkOSMEzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnfIyfJQU3sMBzDfB9E7rtH8OBq26iNpE0F3kHObLDrroL+WHKxxo4NrhkATbr2fVCACdvBwYrp/0lfT/l8sfaCK0e1wlBvv5V3FfmbKD54ZgZuHJB407P6h/Ya0AKeCKBeesLswixNb1yST8ks81A/FMZwgyCEWydSxbDwtQtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=QSmeYnIx; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id C2AB64076198;
	Tue,  8 Apr 2025 09:39:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C2AB64076198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1744105196;
	bh=9Ov35EzHv3WpWg/xb8In8OfhQ22RLgTulCR2ZE4izEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QSmeYnIxURQx8gw0NtmJ8hubnpEVgfIcxoJbqWh7UwBGPjzJnmisCwh7dF7hdD/BM
	 y9Uo0hEXbtEUeoqkfvDUTw+xBR7K2afLIkseikjLZO3CtUvsPe+/KHPsvIHwL/MkD9
	 8E+8krjUSNKPDor7QFgr6c78pozR0HzO0IVQ5yB0=
Date: Tue, 8 Apr 2025 12:39:56 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Denis Arefev <arefev@swemel.ru>, 
	Alex Deucher <alexander.deucher@amd.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrey Grodzovsky <andrey.grodzovsky@amd.com>, lvc-project@linuxtesting.org, 
	Chunming Zhou <david1.zhou@amd.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, stable@vger.kernel.org, David Airlie <airlied@gmail.com>
Subject: Re: [lvc-project] [PATCH] drm/amdgpu: check a user-provided number
 of BOs in list
Message-ID: <bmdour3gw4tuwqgvvw764p4ot3nnltqm4e7n3edlbtpfazvp5c@cqe5dwgc66uy>
References: <20250408091755.10074-1-arefev@swemel.ru>
 <e6ccef21-3ca5-4b5a-b18a-3ba45859569c@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6ccef21-3ca5-4b5a-b18a-3ba45859569c@amd.com>

On Tue, 08. Apr 11:26, Christian König wrote:
> Am 08.04.25 um 11:17 schrieb Denis Arefev:
> > The user can set any value to the variable ‘bo_number’, via the ioctl
> > command DRM_IOCTL_AMDGPU_BO_LIST. This will affect the arithmetic
> > expression ‘in->bo_number * in->bo_info_size’, which is prone to
> > overflow. Add a valid value check.
> 
> As far as I can see that is already checked by kvmalloc_array().
> 
> So adding this additional check manually is completely superfluous.

Note that in->bo_number is of type 'u32' while kvmalloc_array() checks for
an overflow in 'size_t', usually 64-bit.

So it looks possible to pass some large 32-bit number, then multiply it by
(comparatively small) in->bo_info_size and still remain in 64-bit bounds.

And later that would likely result in a WARNING in

void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
{
...
	/* Don't even allow crazy sizes */
	if (unlikely(size > INT_MAX)) {
		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
		return NULL;
	}

But the commit description lacks such details, I admit.

