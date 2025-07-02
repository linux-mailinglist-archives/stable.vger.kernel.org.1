Return-Path: <stable+bounces-159216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FB0AF1101
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 12:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7A4188D799
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 10:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BD11E3775;
	Wed,  2 Jul 2025 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wEcOu4FJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4010BDF42
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450482; cv=none; b=iTXm9cLmjfmVp4VCD+2wsLV3kzscQKWELmpYAev80pel7pVZy8xL9kaRC3t4sFv9svoyqL/cqecO2/krsHqBAGwJ9Qf31QG0ceshEk3gAkBL5F/8kQbLif60xviSYYCuNIaNdZGsS5LuclpGm+hwO2hiTj1Ye7I9+jojj9V3pEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450482; c=relaxed/simple;
	bh=RgQFStYlYlslBKrhBZbNt8FxeUd0M2Dfg/D3xy3NFuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txKlR0CkJz3k8rxm/VHznM5gsuR4o2g321jD3QtQJ8DpWpBVOMcl9VUkN61v6wjdO+pT1NzF8TgZjGXC+AJfqv3VegcjVHm+vPEfDgcl7Ta1uLXb6dtQkf1sCIS6CMW8h7WqP6JVvbuP8oESrRWWTivO+QRPcjwPNJ/L9cE8TvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wEcOu4FJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A267C4CEF4;
	Wed,  2 Jul 2025 10:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751450481;
	bh=RgQFStYlYlslBKrhBZbNt8FxeUd0M2Dfg/D3xy3NFuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wEcOu4FJ9Vk7DlRVlR/usB1M12LAhEoiQ3M/yWO5jbOfwO2hXc4wyfGN5+opsVp5P
	 uuF6q4qpT9iF50Gg53arkIAD246pyFSMfyEd5KvdPjw45p+pNlge6kEV7vKNV8xItJ
	 5SQOAPjHjKdbEcKcYlqQ+QHYOZ3pay3w4VEB2zkg=
Date: Wed, 2 Jul 2025 12:01:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: flag partial buffer
 mappings" failed to apply to 6.12-stable tree
Message-ID: <2025070212-duplex-synapse-ef8a@gregkh>
References: <2025062921-froth-singing-509c@gregkh>
 <9e257146-d7a5-4221-a784-3b1cf543a932@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e257146-d7a5-4221-a784-3b1cf543a932@kernel.dk>

On Sun, Jun 29, 2025 at 01:20:31PM -0600, Jens Axboe wrote:
> On 6/29/25 6:42 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 178b8ff66ff827c41b4fa105e9aabb99a0b5c537
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062921-froth-singing-509c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> 
> 6.12-stable is missing a few backports here. Here's this one, with the
> prior ones added first.

All now queued up, thanks.

greg k-h

