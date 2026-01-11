Return-Path: <stable+bounces-208024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 958B6D0F9A7
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 19:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5274B30389B2
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 18:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3B934D3BF;
	Sun, 11 Jan 2026 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OEuAMT+k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E51234F470
	for <stable@vger.kernel.org>; Sun, 11 Jan 2026 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768157494; cv=none; b=Z3dvpKr45tmpiqEaeNAVvnatkLyGIninKt7Gl3l4cRWQuYjiXlS8VDUjvKhH0NOERhxcgDUVYS1cc4VehxeXL0VJTkDmvfMg+lgaZjPSg78AO+lM52bZBOMYcJZQFymesR+WYG/t5aXiCQ5uhpe/BPqqOeTz70KKaom/6YDNCCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768157494; c=relaxed/simple;
	bh=+QM3HcEjFLws+IOa0dvQQvsuwbvSSIF28hR4n5kGrDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Saab/bfUZxf9vOXUzW4zqfzbnOJNWifN1kPm1QIRDjAtj0gRCIgatGgU1PGOQY56u3jR/fim9G7bTVYGvBzj8tCm5ZCbo9EVYq98g/ZFq2HOJtkGL1dU8pTAifpcTG1App5rfdTRTax7YjlNwW8vcuAjpvSukwN0+PbFlZMR1HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OEuAMT+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A66FC4CEF7;
	Sun, 11 Jan 2026 18:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768157494;
	bh=+QM3HcEjFLws+IOa0dvQQvsuwbvSSIF28hR4n5kGrDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEuAMT+ka6FyPaY3L+eUYwmPJqlFLiJqFJTscNTraL4quSZB5HXIw+lE/0sq2WiIX
	 gDJEPHR61IpplJhKDm4FWEdd8npqMzjhNZasn+tC0RXMnRI7hS4p0KSWt6dd5h6b9G
	 2UIMnUbGE3OrnsumqCcCtlenw2zAgsaKs2TwqxAA=
Date: Sun, 11 Jan 2026 19:51:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: kernel-team@lists.ubuntu.com, Kent Russell <kent.russell@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: Re: [SRU][Q][PATCH 2/2] drm/amdkfd: Export the cwsr_size and
 ctl_stack_size to userspace
Message-ID: <2026011115--624e@gregkh>
References: <20260111184001.23241-1-mario.limonciello@amd.com>
 <20260111184001.23241-3-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111184001.23241-3-mario.limonciello@amd.com>

On Sun, Jan 11, 2026 at 12:40:01PM -0600, Mario Limonciello wrote:
> This is important for userspace to avoid hardcoding VGPR size.
> 
> BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2134491
> Reviewed-by: Kent Russell <kent.russell@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 71776e0965f9f730af19c5f548827f2a7c91f5a8)
> Cc: stable@vger.kernel.org
> (cherry picked from commit 8fc2796dea6f1210e1a01573961d5836a7ce531e)
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 ++++
>  1 file changed, 4 insertions(+)

What stable kernel(s) is this supposed to be applied to?

thanks,

greg k-h

