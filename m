Return-Path: <stable+bounces-60695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AF5938F73
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 14:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C64F1F21D4A
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 12:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC9F16D4E0;
	Mon, 22 Jul 2024 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dO5bk3Ec"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6911516D30E;
	Mon, 22 Jul 2024 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652954; cv=none; b=NeoCY17P8xlCASFOBwHfU2qwVHbvcesXnVta8JKfD0qSYmOXCosOs7FQZtt8hN0CtxHyrU4mEfbilE91ihR97jkusV/nzPor0n7BNKxV02O8FVSLTBUdtzONLNzBq3ukCOJINeVE1gC1954F13d63zP9YHJH2VclKhZeZt+0eBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652954; c=relaxed/simple;
	bh=XEr1R9iOxtde4IqHwns90ckqnpkrizp/7tl7omPCH9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfjDY9yVHCZTa9VlbbFOHEraAq4Z8ur4ncdk8LP5hUeT9MVbqhLCO+boPUOHBG6iiJfthCIe5ewdbszJ/e2dbGCO+zNQUVBAJJ1bGvmgnG0IBwau3slzDd4t8Bb6DLivXmQRDZCCb2yqhw9FR9zpSLYtTKmSHKVCWuvt5ke3OdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dO5bk3Ec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4A7C116B1;
	Mon, 22 Jul 2024 12:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721652953;
	bh=XEr1R9iOxtde4IqHwns90ckqnpkrizp/7tl7omPCH9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dO5bk3Eci+cstrckuFXddKynl3is4BpUi4nBExxwJ3k9ZzafTjF1Q2wbfJnPI+1lZ
	 m2MBNVA8mFDDgf1ekeqwkPVPGp2/6WnZlv/WnpCNd6u8uTyqXiOHqpPGoj6WNNWmGJ
	 5pFCTXYM8hqMpRmrGRmt7FmZt45ellyEaQqZgvYuKP4QTiUYy8Mr8FLQcR1R7mL4JZ
	 0IJfoRzyFLKRQGR339F5T2cNeJyQpt1EhCHdxVO4q++7YcK5P6t3KN4ycT3zxgpIlC
	 SOSL8YblC5TKdkt8F2sfWQu91nzSXjf7UVPUcHR5qdJTHAIEnRD0pqZRRt2+e1BfVI
	 gA2C0nQqJJ83A==
Date: Mon, 22 Jul 2024 08:55:52 -0400
From: Sasha Levin <sashal@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jesse Zhang <jesse.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, Xinhui.Pan@amd.com,
	airlied@gmail.com, daniel@ffwll.ch, Felix.Kuehling@amd.com,
	shashank.sharma@amd.com, guchun.chen@amd.com, Philip.Yang@amd.com,
	mukul.joshi@amd.com, xiaogang.chen@amd.com,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 6.1 13/14] drm/amdgpu: fix dereference null
 return value for the function amdgpu_vm_pt_parent
Message-ID: <Zp5W2GE3G3j-0bjP@sashalap>
References: <20240605120455.2967445-1-sashal@kernel.org>
 <20240605120455.2967445-13-sashal@kernel.org>
 <ZnFPL2BeQOEGPO6Q@duo.ucw.cz>
 <6b933c16-5ddb-4b09-b367-3cf42ae94304@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b933c16-5ddb-4b09-b367-3cf42ae94304@amd.com>

On Tue, Jun 18, 2024 at 01:42:56PM +0200, Christian König wrote:
>Am 18.06.24 um 11:11 schrieb Pavel Machek:
>>Hi!
>>
>>>[ Upstream commit a0cf36546cc24ae1c95d72253c7795d4d2fc77aa ]
>>>
>>>The pointer parent may be NULLed by the function amdgpu_vm_pt_parent.
>>>To make the code more robust, check the pointer parent.
>>If this can happen, it should not WARN().
>>
>>If this can not happen, we don't need the patch in stable.
>
>Right, that patch shouldn't be backported in any way.

I'll drop it, thanks!

-- 
Thanks,
Sasha

