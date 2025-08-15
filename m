Return-Path: <stable+bounces-169826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEA7B28775
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 22:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF9BAE16A3
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F417243946;
	Fri, 15 Aug 2025 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI8Jlx8+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9D323C4EA;
	Fri, 15 Aug 2025 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755291455; cv=none; b=XKu2Zdf75oaoyi9MupzDqkQDEfBSIgs+vtfFO88GqcnmXOCKAHbKJX3drhiaoLsY85heOoiXha1/YRt4VwfGNMDnjVF4MHYZyvllm0GD10KGGyoRzJle6ufWG/Bp+ESV2sr0j5LXGbuP+UOx3R9GM+z4DSzskYxO1973lraqPzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755291455; c=relaxed/simple;
	bh=BV2i9bTImMy1rgp5jv7+5mpj/pVe7ucb3EUOIBIWTbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUqmw3QkK7R2CGqn2dBHweoHiW0VxvbwIjU/9Wxa9VMP6pXIL1uuVSQF9ZN9VrbI3x6sbXSOJ2N7Wyphw9WF2gCa3F8QIuLbXfbn+JF/Ue9roHYKFQ6bRkRD33z5Igsl4cy5+Phj48AvhrBs0309YuysoD9NMldPCvzP9qIC+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uI8Jlx8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BC2C4CEEB;
	Fri, 15 Aug 2025 20:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755291454;
	bh=BV2i9bTImMy1rgp5jv7+5mpj/pVe7ucb3EUOIBIWTbo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uI8Jlx8+PL29U1PLyI0ROPRaY9QHtX4+Wsa3JxXnae8Pw+1FmS7Gs1pGACscxY9fD
	 L5zCivpUGY2ldegPZr1JPbBZlJJNOn3GdfmlrK67VRfJ30Yb7u/42/LKa2Ipg3RV97
	 L4K5ejBOvhcFT/+DzXMCEWBZ1HA/+57cP+YyrpXCObBYXUtGZV4At8sJBhaFTQIH+1
	 jr/NsI+uGDfWnZhgRNPG9LwJfv9e9HRplYi22piFPcV7aHELIxJefGozx8WyYLQpwa
	 HB0wQT6nX5+2JM+iEVpVfjGBzl6E/AtE8e7mkuAvBfJn1Ci106HnpyoKIXVepcXsV+
	 vAOQV3SizOBXQ==
Message-ID: <6dfcf686-d212-4768-91d7-992f34932980@kernel.org>
Date: Fri, 15 Aug 2025 22:57:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/nouveau/gsp: fix mismatched alloc/free for
 kvmalloc()
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
 Timur Tabi <ttabi@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250813125412.96178-1-rongqianfeng@vivo.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250813125412.96178-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 2:54 PM, Qianfeng Rong wrote:
> Replace kfree() with kvfree() for memory allocated by kvmalloc().
> 
> Compile-tested only.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8a8b1ec5261f ("drm/nouveau/gsp: split rpc handling out on its own")
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> Reviewed-by: Timur Tabi <ttabi@nvidia.com>
> Acked-by: Zhi Wang <zhiw@nvidia.com>

Applied to drm-misc-fixes, thanks!

