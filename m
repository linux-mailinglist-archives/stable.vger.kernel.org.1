Return-Path: <stable+bounces-71632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88F4966041
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 13:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0FD1C214DD
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 11:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BD417C7D9;
	Fri, 30 Aug 2024 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dw9Y4AFj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906FB192D7A
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016168; cv=none; b=H7FC/jXIJmtchkii4JTyRuu9+Oo/8Wx6Uxlbq/n7RDGKcP8MRsSqI5cKHMXrfIvwvy7DTmJ7mP95Tu4uy6SwbxGhW696uNBYMT9Us3KjZfwMLFXG1nkQvgbtAuE+7VLpnZWSYJpuiUUTe9xjCRWv6phkBuwT3476ZPW+O70ccWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016168; c=relaxed/simple;
	bh=CWZNjZraKuL4NPV9TM89PSzmnUCqGjGtSsIHD6K3d2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nodrJ5E4tt33ZJhTfCHYwBext06PKxKhJxZQDphA1qSg+RtCnd2nU8kw7e/fEXoZdPukksp/qilVRRTGfgF6fsCpSTYQh/Flvh0A3tE0hCF+sjBTWrPC8xUUK9rJNfmtAN1kDqLsc9ybKhOm/hx28ukAIENLEwc8FnrKfsmQ6DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dw9Y4AFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09C5C4CEC2;
	Fri, 30 Aug 2024 11:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725016168;
	bh=CWZNjZraKuL4NPV9TM89PSzmnUCqGjGtSsIHD6K3d2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dw9Y4AFj5YpKBDx1O5x2GTA6rBsKeW6l+nQhaXaQUHBA9ubO/cksHKavivDXKRwSN
	 FAcs9LnN9t4W/GvHXB8RUU5+VWuTHss2RN3Gia5gHzP3IGybjxZubYb10pP/YzH1qp
	 R2M8wB4fwxdPkFCW7gvZ6rIO7JWqtLSU29l+Ha3A=
Date: Fri, 30 Aug 2024 13:09:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 5.15.y] drm/amdkfd: don't allow mapping the MMIO HDP page
 with large pages
Message-ID: <2024083002-lesser-surprise-d61b@gregkh>
References: <2024081202-hastily-panic-ee65@gregkh>
 <20240815194629.2074349-1-felix.kuehling@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815194629.2074349-1-felix.kuehling@amd.com>

On Thu, Aug 15, 2024 at 03:46:29PM -0400, Felix Kuehling wrote:
> From: Alex Deucher <alexander.deucher@amd.com>
> 
> We don't get the right offset in that case.  The GPU has
> an unused 4K area of the register BAR space into which you can
> remap registers.  We remap the HDP flush registers into this
> space to allow userspace (CPU or GPU) to flush the HDP when it
> updates VRAM.  However, on systems with >4K pages, we end up
> exposing PAGE_SIZE of MMIO space.
> 
> Fixes: d8e408a82704 ("drm/amdkfd: Expose HDP registers to user space")
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> (cherry picked from commit 24e82654e98e96cece5d8b919c522054456eeec6)

Wrong git id, this should be be4a2a81b6b9 ("drm/amdkfd: don't allow
mapping the MMIO HDP page with large pages"), right?

{sigh}


