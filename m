Return-Path: <stable+bounces-43609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DB48C3E06
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 11:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB581F2271C
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 09:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFBB1487D9;
	Mon, 13 May 2024 09:22:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2E91474CF;
	Mon, 13 May 2024 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715592147; cv=none; b=XXF1V1c+g855/EjAeli+YM4eqHu5I+vpz5JyfxLs/08y7Mw2g45Q2HmkEAFSSfKTtWkcmyyhDn670SUmXV4fEcvxQV+GuAAYwhYtCqck5MzAVCxlcsNrgyZFJmEemqfZk1LP5dS3LRePHnJ5sYBViT3VOA/SW14MXRmKcyfV6bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715592147; c=relaxed/simple;
	bh=5dfdm9Vk9P5CiArU2QhD4a6bzcQ7+TFM9CMFHzaxjVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0mStU40oUPu6oE4iRUhoVvMNyQbzetzBJBaZCNGfYh57rvDbe6CdZPrUpmggGDTDJ9aU+sszjP7eNESSRfu7a20tzqV/U4609mOQCjo0NJCHlpYyhVvMrIr2NXFSkWG7kiDtxh50n2ta3Sa13tw+lW1rP5BWyjcMCSK0RJ/KT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B36B1007;
	Mon, 13 May 2024 02:22:50 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D7353F762;
	Mon, 13 May 2024 02:22:24 -0700 (PDT)
Date: Mon, 13 May 2024 10:22:21 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH 5.4 / 5.10] firmware: arm_scmi: Harden accesses to the
 reset domains
Message-ID: <ZkHbzRahnQgptrVr@bogus>
References: <20240513003837.810709-1-dominique.martinet@atmark-techno.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513003837.810709-1-dominique.martinet@atmark-techno.com>

On Mon, May 13, 2024 at 09:38:37AM +0900, Dominique Martinet wrote:
> From: Cristian Marussi <cristian.marussi@arm.com>
>
> [ Upstream commit e9076ffbcaed5da6c182b144ef9f6e24554af268 ]
>
> Accessing reset domains descriptors by the index upon the SCMI drivers
> requests through the SCMI reset operations interface can potentially
> lead to out-of-bound violations if the SCMI driver misbehave.
>
> Add an internal consistency check before any such domains descriptors
> accesses.
>
> Link: https://lore.kernel.org/r/20220817172731.1185305-5-cristian.marussi@arm.com
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> ---
> This is the backport I promised for CVE-2022-48655[1]
> [1] https://lkml.kernel.org/r/Zj4t4q_w6gqzdvhz@codewreck.org
>

The backport looks good and thanks for doing that. Sometimes since we
know all the users are in the kernel, we tend to ignore the facts that
they need to be backport as this was considered as theoretical issue when
we pushed the fix. We try to keep that in mind and add fixes tag more
carefully in the future. Thanks for your effort and bring this to our
attention.

--
Regards,
Sudeep

