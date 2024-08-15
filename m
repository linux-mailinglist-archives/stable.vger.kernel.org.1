Return-Path: <stable+bounces-67751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B88952AFE
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 10:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851AF282AB3
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 08:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393291AAE34;
	Thu, 15 Aug 2024 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="imNiikgi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF943214;
	Thu, 15 Aug 2024 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710588; cv=none; b=Ts8boulOnmOvWN1aSO5j7wvLqfC5XSyZfUPaJ+TtYFWSRlvCd3AVUxTzj8SDriljiwkXC6c/jeMbiQp0rlimF+Jr595Gvh3e+drnWj+OaPBifKi1U3nQAd0IcGr8CXbcHf/5yHKrzPy3c33xNZn4SdckVOBFdgvk5pQqYbqzd5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710588; c=relaxed/simple;
	bh=YB8j6VR0j3xiLwfhDIQPPAgR2+ZnGywVsnWJa0tjuH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhqIrZYVldyDR7qqUeiTlMq/8wKpNG+NCZMh7mMMHAAYvQ6fxvAHNG107Gfm5DUuuMW2Aq+NReN1qRiRfmZbWpVXQ7Hi269tL6mpPZbabC5r0Y2wdLfAFsYI7M6STrLlVMkYQw2EKX1ZVsVNlUnqeccHseJEA5IToEN9K7T/jQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=imNiikgi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08556C4AF0D;
	Thu, 15 Aug 2024 08:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723710587;
	bh=YB8j6VR0j3xiLwfhDIQPPAgR2+ZnGywVsnWJa0tjuH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=imNiikgiyJuAVRHWO1z/gnBOrVtO1vSNUGJQsHjZKv6I2V2Xl51/99LytgzQ/LhoN
	 c5H7NMs5rvF0NoMnnjbLSgpvDHZ2tCZSgrnuP3r2eCrjhtIFuVj5zhn22Ja2u+/0lY
	 kfKK4k5/f6rZYBRLC8mATHoqsOIVuuTtxpbeXD5A=
Date: Thu, 15 Aug 2024 10:29:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: sashal@kernel.org, yangge1116@126.com, hch@infradead.org,
	david@redhat.com, peterx@redhat.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v2 v6.6-stable PATCH] mm: gup: stop abusing try_grab_folio
Message-ID: <2024081538-buckshot-captivity-f0f8@gregkh>
References: <20240812181238.1882310-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812181238.1882310-1-yang@os.amperecomputing.com>

On Mon, Aug 12, 2024 at 11:12:37AM -0700, Yang Shi wrote:
> commit f442fa6141379a20b48ae3efabee827a3d260787 upstream
> 
> A kernel warning was reported when pinning folio in CMA memory when
> launching SEV virtual machine.  The splat looks like:

Now queued up, thanks.

greg k-h

