Return-Path: <stable+bounces-45670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A2A8CD1BC
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 14:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B8C2824E7
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 12:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ECC13B7A1;
	Thu, 23 May 2024 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zI+xxVBd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A9A13B5B0
	for <stable@vger.kernel.org>; Thu, 23 May 2024 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465968; cv=none; b=T3tnRK7LuCcdlGYri+aEzwipwuKoLQK34nMYz+DziCfuVMonK+F1ZF+pdT0waLhIRQHSak93Fnl3SKM04bMZ350fB5yCK3z16RQ00DJQPhl1zETlSTrfaQKnub/1iI3hfz3DrEflDgNaSW04V4toXCRZeaVnVuOu1OWTPYKU4H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465968; c=relaxed/simple;
	bh=zGYbaI2Te9iBvUsdDfPlCxgkx8mcdB0J2FZPmdPk/hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNQcKhL/aRmHMcH90RfskaQabSKeC/OWXyoeXar0I1WCE9JMRB5Rr5jkc54UuXSn0PB3oHAobLBsEhvLDhTgLak1J4+1S04TH7zkIkPKCoL1AB2MmMcITGPsqmTsc4AGCYZbgjK9gsAGpg0+jtIS8jcEPnky4kZOIZnYz9f3swg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zI+xxVBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAA2C2BD10;
	Thu, 23 May 2024 12:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716465968;
	bh=zGYbaI2Te9iBvUsdDfPlCxgkx8mcdB0J2FZPmdPk/hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zI+xxVBdPAJoEjk6+TavmqfaFCliCXzJQBt8BEj8ySmfm695p5BxJmCwSZfHgS1hI
	 GQiCTVAZFTTjH/kAQVWZybWmbDeQ0QFWZbAWaDM+fCLlBtM2sveoqALHB7bjef3s82
	 SmMS52/iVeZhCt0OIi9huuIs0iq7UCIaVOvAL9sU=
Date: Thu, 23 May 2024 14:06:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: stable@vger.kernel.org, alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com, Tao Zhou <tao.zhou1@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: Re: [PATCH v5.10, v5.4] drm/amdgpu: Fix possible NULL dereference in
 amdgpu_ras_query_error_status_helper()
Message-ID: <2024052358-unleash-thieving-86f8@gregkh>
References: <1716294141-48647-1-git-send-email-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1716294141-48647-1-git-send-email-ajay.kaher@broadcom.com>

On Tue, May 21, 2024 at 05:52:19PM +0530, Ajay Kaher wrote:
> From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> 
> [ Upstream commit b8d55a90fd55b767c25687747e2b24abd1ef8680 ]
> 
> Return invalid error code -EINVAL for invalid block id.
> 
> Fixes the below:
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1183 amdgpu_ras_query_error_status_helper() error: we previously assumed 'info' could be null (see line 1176)
> 
> Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Tao Zhou <tao.zhou1@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> [Ajay: applied AMDGPU_RAS_BLOCK_COUNT condition to amdgpu_ras_error_query()
>        as amdgpu_ras_query_error_status_helper() not present in v5.10, v5.4
>        amdgpu_ras_query_error_status_helper() was introduced in 8cc0f5669eb6]
> Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
>  1 file changed, 3 insertions(+)

All now queued up, thanks.

greg k-h

