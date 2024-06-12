Return-Path: <stable+bounces-50249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4C39052CC
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D52B4B21EA1
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F256416FF3E;
	Wed, 12 Jun 2024 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WRP3bIWo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33C516F0F9
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196273; cv=none; b=Avp3osdARWRYuQFWjbHXKjibRWKnrWkI5uVwOBwRqSho2GfrKOtrN/lx27lx5NkBwquogXurFH+ABlMuyutJeY7/WQzqjdYy2ah2mtHcaXn+0VZxfK/E8Lf3yDkuLduzbPz1Q+TSXLT+oGcdCs8APzpNplj84KlntE6no7lbFCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196273; c=relaxed/simple;
	bh=1/B4yRI/9Xj67nhFRukq/WUcqq8ryLg3lr4o7PviOdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAoSysvVm1Tue6g1MtVrOH2fJXF2YQGL+dk9HVkyjVzJ1TI1VRPdBq1dFaCkvtF6Ntoltu/2PI18lWCPzOgK90V63zS1ruOYdWYD9fufEecOUP9CmsTT547/Sw2y2igC9EbkYP1RD/6HQ578re8Qi/vJbQ1H9Sn4NWG+FkBy4nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WRP3bIWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E17C3277B;
	Wed, 12 Jun 2024 12:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718196273;
	bh=1/B4yRI/9Xj67nhFRukq/WUcqq8ryLg3lr4o7PviOdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WRP3bIWoLvdDYRQGgU4uiucjc4e2iPFQNQ6DMeckRyZWZLY6B1bOFoRhJ5+6K9Pik
	 fGjx4BE5kxTqZzWCT/7vb43Uj8ZPtB5LbGGIC77vstcNAjytKCxpmBK3j832ndU0bc
	 /6xOxA91rAKX9pa4MRRlhstaTYvQh6PlMwfyf/io=
Date: Wed, 12 Jun 2024 14:44:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthew Ruffell <matthew.ruffell@canonical.com>
Cc: w_armin@gmx.de, Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
	Felix.Kuehling@amd.com, Prike.Liang@amd.com, Xinhui.Pan@amd.com,
	Yifan1.Zhang@amd.com, amd-gfx@lists.freedesktop.org,
	bkauler@gmail.com, dri-devel@lists.freedesktop.org,
	sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "drm/amdgpu: init iommu after amdkfd device init"
Message-ID: <2024061223-suitable-handler-b6f2@gregkh>
References: <fe03d95a-a8dd-4f4c-8588-02a544e638e7@gmx.de>
 <20240612001037.10409-1-matthew.ruffell@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612001037.10409-1-matthew.ruffell@canonical.com>

On Wed, Jun 12, 2024 at 12:10:37PM +1200, Matthew Ruffell wrote:
> Hi Greg KH, Sasha,
> 
> Please pick up this patch for 5.15 stable tree. I have built a test kernel and
> can confirm that it fixes affected users.
> 
> Downstream bug:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2068738

Sorry for the delay, now picked up.

greg k-h

