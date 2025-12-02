Return-Path: <stable+bounces-198108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63874C9C091
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 16:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1858F3A77BE
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 15:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC0A3242B5;
	Tue,  2 Dec 2025 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zWo6/0J9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D36322DCB;
	Tue,  2 Dec 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764690769; cv=none; b=gsQ4po2zov/QbiQN2sxFofog5hEPOD6K4SfJx1usZ2szPtrZalVfCnQ2hA+oDnEyTm28tP54iUrRp2qSKlMLs4Spkts9h1dTRtZjMW47V2nYFW6uVKRcX3yzFLoiR7b9Ya+E4S6ykNOpsOWoCqu39YhrsFz9RObYLVMQ3vYHxeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764690769; c=relaxed/simple;
	bh=a41Hc214ofss5go4vtnnf3ogCFKJwntca4v/HMvtCyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gg4cb97IkHZFlmUH8d8iM2x8Tr+vFhaHddNBImh+wn/zhq2BUqhBoHkHNWLQMEuqOylLnt9NPYHXFyrs5KjuuXCMvQelpHVaQtu6TgJiCMk93t1WKbhjKvUDLuauFC7F6SpBqokOHDQDCNylCtZuOmjmp+DpYP/MylAD7nhjeYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zWo6/0J9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B39DC116B1;
	Tue,  2 Dec 2025 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764690768;
	bh=a41Hc214ofss5go4vtnnf3ogCFKJwntca4v/HMvtCyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zWo6/0J9iS7xicf0oIqwu5Ban7CvuP/EVNgTHUTLUd9ksrLbR/7SXHfxJdkUkA0sc
	 cswn8w8i/9Jd8m3K5ZSe9fjcOPe7O09I43iY87/HobDCLg+FMhysn+uAyHEhKX9flP
	 qxkIiMoEOFt+7PLVKfhFrbV51L1cGiQ5DWUfOfic=
Date: Tue, 2 Dec 2025 16:52:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Javier Martinez Canillas <javierm@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 6.12.y] drm, fbcon, vga_switcheroo: Avoid race condition
 in fbcon setup
Message-ID: <2025120235-quartet-shrubs-0862@gregkh>
References: <2025120119-edgy-recycled-bcfe@gregkh>
 <20251201221055.1281985-1-sashal@kernel.org>
 <4dd8e529-4777-4cfc-a536-dbe0d0a90419@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dd8e529-4777-4cfc-a536-dbe0d0a90419@suse.de>

On Tue, Dec 02, 2025 at 08:40:43AM +0100, Thomas Zimmermann wrote:
> Hi,
> 
> thanks for backporting.
> 
> You also have to remove the calls to vga_switcheroo_client_fb_set() from
> these files
> 
> https://elixir.bootlin.com/linux/v6.12/source/drivers/gpu/drm/i915/display/intel_fbdev.c
> https://elixir.bootlin.com/linux/v6.12/source/drivers/gpu/drm/radeon/radeon_fbdev.c

Can you send a fixed up patch instead?

thanks,

greg k-h

