Return-Path: <stable+bounces-62821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A619413BC
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72F42842A7
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 13:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F471A08AF;
	Tue, 30 Jul 2024 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IO+gVkVo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A111A08AC
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347845; cv=none; b=UgtJ4VaXr0MLWkB5K1lsA9Wegg6SQwadFpIZhqU2xP/qjsO6P8xzZAqqNm9gMKlwK1SnaURlE5wG6O9wrvsh2ooKiMi4JxZGI7u9Sp3WOaPW9GQOwZoBG7juGyv1i6FLNSgo7oQZPRCvRcGgYsKYPiP/hhCstI7kNh1yRc6f0jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347845; c=relaxed/simple;
	bh=ynDBxdCgL9r6OoVp93Yibukg44a5j4j29MmFoiPQNsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKnEoLc+4/6jgBwCvOkJ8yPuIRvC3N++NQEYDvQPMompDyNaXR0RiWM9BU0/7nY6YuUFMYL/2NKLLmUFiZvF3zqrJU16czl2EZVTJYLT5SgNVg9+m95Chq/KPZGyaWwzN1md9sjfjilRjGiXRlqiJuBKRwdxwaOm5qEsK3gybF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IO+gVkVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD62C32782;
	Tue, 30 Jul 2024 13:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722347843;
	bh=ynDBxdCgL9r6OoVp93Yibukg44a5j4j29MmFoiPQNsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IO+gVkVoBLvuK9aMx3edl6GffHGp8Y0JYH/VDJ6ALO8gElLQWD8kd4ZPDb0cEqiRO
	 Ox/G6TbgmypVqpFfMuUBe00HQv9fLsstqeH3zyYmNuTankBfzXmS4sStVwdSpXfx0h
	 wuV9rpbTn8paPquXMKl01Z5vES12TTLNdteibLK4=
Date: Tue, 30 Jul 2024 15:57:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: asml.silence@gmail.com, ju.orth@gmail.com, oleg@redhat.com,
	tj@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] kernel: rerun task_work while freezing in
 get_signal()" failed to apply to 5.15-stable tree
Message-ID: <2024073012-icky-collage-6983@gregkh>
References: <2024072940-parish-shirt-3e49@gregkh>
 <30041ada-0d2d-41ff-939d-038eb900c649@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30041ada-0d2d-41ff-939d-038eb900c649@kernel.dk>

On Mon, Jul 29, 2024 at 12:02:01PM -0600, Jens Axboe wrote:
> On 7/29/24 1:49 AM, gregkh@linuxfoundation.org wrote:
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
> > git cherry-pick -x 943ad0b62e3c21f324c4884caa6cb4a871bca05c
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072940-parish-shirt-3e49@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Here's the 5.10-stable and 5.15-stable variant of this. For some
> reason this wasn't queued for 5.10 (probably because of the long
> ago 5.15-stable backport of io_uring to 5.10), but it should go
> there too.

Now queued up, thanks.

greg k-h

