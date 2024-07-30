Return-Path: <stable+bounces-62820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB2F9413B9
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F154CB22C9F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 13:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0151A08AF;
	Tue, 30 Jul 2024 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1PSY17Hg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185F19580A
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347804; cv=none; b=NSx/ZUEiVmtHvMnaX/PmAGXj93bjmr1TDlXAqC6ueM/rnCD1yz4L/4cZqlGg0RWUK/XrOYiXygjULZyxwb6zFclHe3hIuK1B7ggTEfm0hUup4oiteJjazzRGDDbMxMW3QZ789COp0b0lmdvTyPUACaP5vN3yhqIVCy1vUBhpaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347804; c=relaxed/simple;
	bh=0de1Vq58p22oXepoqM5OPBeIcbYz6LolOnvRwXGqGpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfSFI/0UuPq8KDkf2Q61SFrhGQ3ojuh3McAO3OtlXIit29tJCy2M5Cz+I83vFHGnse9jMFljZS5ka/dCkTLCEKK/smw0ln3FwiC0NVT4e8YXs6HhnSIxlTwWVIPx4iiLYjUgC1avvTVuhp7RLRy0X5ccK3bz8+hmxv42D8Y5isc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1PSY17Hg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C46C4AF0A;
	Tue, 30 Jul 2024 13:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722347803;
	bh=0de1Vq58p22oXepoqM5OPBeIcbYz6LolOnvRwXGqGpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1PSY17Hg0BISHOU3T/opCfBAULJrztx3/sHHSoZimHsTUKiFfNjPMTCnIgvwtx3zr
	 qJ5peEjhxZ+zWj/LbYDFS4Brm2kMp3FTe7Kl4MBU4X/0zVDC9XAcIV+PZvyzEJhCNj
	 dNZ7s6YVYOw1zhbudWzBr/rWnwEL7YWy5SNjoNkY=
Date: Tue, 30 Jul 2024 15:56:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: asml.silence@gmail.com, ju.orth@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/io-wq: limit retrying worker
 initialisation" failed to apply to 5.15-stable tree
Message-ID: <2024073033-amusable-creme-1125@gregkh>
References: <2024072924-robin-manger-e92b@gregkh>
 <51475de9-bb8c-495c-b556-3c1379e69687@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51475de9-bb8c-495c-b556-3c1379e69687@kernel.dk>

On Mon, Jul 29, 2024 at 12:02:14PM -0600, Jens Axboe wrote:
> On 7/29/24 1:55 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 0453aad676ff99787124b9b3af4a5f59fbe808e2
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072924-robin-manger-e92b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Here's the 5.10 and 5.15-stable variant of this.
> 

Now queued up,t hanks.

greg k-h

