Return-Path: <stable+bounces-47831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFC68D7413
	for <lists+stable@lfdr.de>; Sun,  2 Jun 2024 09:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155471F215A8
	for <lists+stable@lfdr.de>; Sun,  2 Jun 2024 07:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268A418622;
	Sun,  2 Jun 2024 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cwnJCQRS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB362EBE
	for <stable@vger.kernel.org>; Sun,  2 Jun 2024 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717312519; cv=none; b=rnBZmuk4Aj8rYdH2MNeFIrYrQRtM7p/EyC6XcF8CcjpCUYNhLr34YSun+sIaMXoYCDK0zDLgWvmi4iJclbaiFU/ruGKGn+o21bBx5dk2K/X/xoy3UM3iymoNPp61zA6LlXfeny+guxYvl7/AwoI/ZRPa3ofNGQP5EaMbfjfI9R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717312519; c=relaxed/simple;
	bh=FmpRAWwcMuVblmBGTfrfKLkjxJ9IvPmKcqtyqPQB2og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgMY6fWdvTn8N0Wm7rZ/PdLMrPKlImChv87ZEuA+kn0jqIlFy+OF7RucvNVhH2idNd1uStY7aW/sIxrYwHcngMVImfOTUCHyzhumR94DuNHQ+QvBxIIYaY98CskNPxfRV/JD3f35TEkxD6KdrAI09rjIaZR19ZqpjWIIIDiQs5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cwnJCQRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA47C2BBFC;
	Sun,  2 Jun 2024 07:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717312519;
	bh=FmpRAWwcMuVblmBGTfrfKLkjxJ9IvPmKcqtyqPQB2og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cwnJCQRSaJNAN882tp/UGe1PvGgl3S/4iycc4B4MI0GH6pZ3mgi8vk/Q3ln+EqL0c
	 PrvM/gBbwkZoy+GQbnvRwzKajfw3bX7+usIFFpyv+6PmrUnuLQw4TAc8V0VFeCmO0M
	 Yv+lHhFDmxKvCyzshaeuGtxbicO752t8PX2ofG6o=
Date: Sun, 2 Jun 2024 09:15:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: hailong.liu@oppo.com
Cc: hailong.liu.linux@outlook.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/vmalloc: fix corrupted list of vbq->free
Message-ID: <2024060248-unsold-growing-8ec7@gregkh>
References: <20240601161819.8229-1-hailong.liu@oppo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601161819.8229-1-hailong.liu@oppo.com>

On Sun, Jun 02, 2024 at 12:18:19AM +0800, hailong.liu@oppo.com wrote:
> From: "Hailong.Liu" <hailong.liu@oppo.com>
> 
> The function xa_for_each() in _vm_unmap_aliases() loops through all
> vbs. However, since commit 062eacf57ad9 ("mm: vmalloc: remove a global
> vmap_blocks xarray") the vb from xarray may not be on the corresponding
> CPU vmap_block_queue. Consequently, purge_fragmented_block() might
> use the wrong vbq->lock to protect the free list, leading to vbq->free
> breakage.

<snip>

Did you forget to cc: the relevant developers for this change?
stable@vger.kernel.org is not the proper place to do mm development
work.

thanks,

greg k-h

