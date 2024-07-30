Return-Path: <stable+bounces-62819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFAF9413B3
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C102850C4
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 13:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696001A08A2;
	Tue, 30 Jul 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AhXJtv8q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8A31A08A0
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347715; cv=none; b=MbG7DAyCgKw6ENs1ullR/p+6t32bCTENyqSmUCVH3pLO/tnuaRRbMG+KyS9HsJArgYMr+JrBCiu7NidsajgntadUG2/QP8NoTgemAZXb4S26zM0w5b7YBrbLLLw6L0PBfF93Q/k3cdsIuf3roNi9gtMjBhAVxj9CSfM1CZF6oGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347715; c=relaxed/simple;
	bh=Rogg9SteGeUSP0qWJpYugdTfKB8dOmuQDZW1VS+NvLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwHNidh61rtt3MQx6s6vD2dhH6NFp24U5mDx8gUVoAkjf5wCXdcYpDsxj/UF8cpOG8s5C7ngZoD+ANcNR5vjft18SpsiZf6NI9Bdf9niABWw1mRqIKFlh2b2FSTievTIOZIYFNl1VCKZ/71HzRUmni1RRmrwfbHB4BammB+Xpxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AhXJtv8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831C8C4AF0A;
	Tue, 30 Jul 2024 13:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722347714;
	bh=Rogg9SteGeUSP0qWJpYugdTfKB8dOmuQDZW1VS+NvLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AhXJtv8qLD4hdKUWr1lKlckTEZnPdmDotbAOM5+CBIUzxxbQQQBQgJHQgQCSIft+L
	 Typ4FHGsPIyMipDtf7ntn9bCGJnyG8zzUPop/aCo4k8kQ6sRL+NCav/4GFXuA9dOTQ
	 J86taUth/UBshCiTTVI+7fVq8fP2edxQzM9cQcP0=
Date: Tue, 30 Jul 2024 15:55:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: asml.silence@gmail.com, ju.orth@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/io-wq: limit retrying worker
 initialisation" failed to apply to 6.1-stable tree
Message-ID: <2024073003-cubicle-pod-1e67@gregkh>
References: <2024072923-bodacious-claw-442b@gregkh>
 <2f9bc94b-2c6b-46b9-b772-8ec00a637de9@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f9bc94b-2c6b-46b9-b772-8ec00a637de9@kernel.dk>

On Mon, Jul 29, 2024 at 11:45:52AM -0600, Jens Axboe wrote:
> On 7/29/24 1:55 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 0453aad676ff99787124b9b3af4a5f59fbe808e2
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072923-bodacious-claw-442b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Here's a 6.1 variant.

Now queued up, thanks.

greg k-h

