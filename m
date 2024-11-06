Return-Path: <stable+bounces-90082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559769BE005
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 09:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879571C20898
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 08:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30C01D278C;
	Wed,  6 Nov 2024 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ciWqqZVN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC31D1E87
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730880744; cv=none; b=J1OHzVs7sykAdNb3cyx24S90xBDXsWZIfRuL1E4u9vIYUcc6VVLxf9UZ5dW8oQY58N1hC4XsmdebZM0SU095OBvl6sdu9sW6JLsX4+iMJ6Cm2qgO1SLjZnPCPBLtenBKYCoUZ7mrLLDExl/iyv00BXGb2Gzu1M0qiisWJB3fAKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730880744; c=relaxed/simple;
	bh=KTGqMcCgBpzSnPwacDQ/CNe4IEswubzh/wjQJib0m+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqaHR4wYn7V9IKtjzoFOQKHHNea+7rP4DPqxvtDWvZUnltAprYN2xpfaa1OAakOkbQFwD+YG9OQrOGXOfeJWsUKeSFIUsTVlOfTW01vkLR+j7DXtZflrw9oQ902ZcUKRIKdPQKK9eRQQb5ivH7gXWjLy31OOKnXb2wlB/3+woDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ciWqqZVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CF1C4CECD;
	Wed,  6 Nov 2024 08:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730880744;
	bh=KTGqMcCgBpzSnPwacDQ/CNe4IEswubzh/wjQJib0m+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ciWqqZVNjTrA3QMbFQlC2rvy7Md9NkDucUtmHjp4fjHf2zauofyyCecYHrmSHYEuY
	 l6+ntxoY6B5VXnZcVtY3br2LAlNZCxnuLruSxYlvxNr0153ZpPQdcN0jvUjyN3QBXe
	 UnoArxOnLZcUiVkhZw5ywobaHCkcUhkixJcB5r+s=
Date: Wed, 6 Nov 2024 09:12:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: Default profile performance issue on Navi 3x
Message-ID: <2024110658-eclipse-aside-2a77@gregkh>
References: <94581271-d8f2-4c4a-8a62-961b78941f9a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94581271-d8f2-4c4a-8a62-961b78941f9a@kernel.org>

On Fri, Nov 01, 2024 at 10:03:40PM -0500, Mario Limonciello wrote:
> Hi,
> 
> A performance issue on AMD Navi3x dGPUs in 6.10.y and 6.11.y has been
> improved by patches that landed in 6.12-rc.
> 
> Can you please bring these 3 patches back to 6.11.y to help performance
> there as well?
> 
> commit b932d5ad9257 ("drm/amdgpu/swsmu: fix ordering for setting
> workload_mask")
> commit ec1aab7816b0 ("drm/amdgpu/swsmu: default to fullscreen 3D profile for
> dGPUs")
> commit 7c210ca5a2d7 ("drm/amdgpu: handle default profile on on devices
> without fullscreen 3D")

All now queued up, thanks.

greg k-h

