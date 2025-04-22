Return-Path: <stable+bounces-135037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68704A95E6E
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A891712A7
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315B022B8D2;
	Tue, 22 Apr 2025 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wGv7QB1o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B091F09AD
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303936; cv=none; b=JBW4dJyad9bU7z36DLxrmfAbMUcbhL0hHjoabqZpv1HC34xEzPT8JL44Bwbtu3DGtF1kC25EJXXiZ4u9Xy2nHV/wbJyhyXshwxqkbYtBNHUyAg9GoMikykgsHdqknuaqvpT5R3KiItPVUTceRjyVsSRr8pa+bNmHkILFHtW9vnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303936; c=relaxed/simple;
	bh=My0HPs5PCFgm9Te5xuNjog8DrLJrJLl20++b6AIIYSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBY8nsyYhwf94/MqYRZb/U2g3ozWrGhsVsz4LYsW0WEoDi73H/M+8HyDhypKwZdXAEmViVfX8OK1t2LWFbXRqlPXYSUHxco4FSDhOjBSuW4CHShYZ6mtgaKgPrhuzopZAGTBn8Od7jeWu/rub/bzbOpaJ15mrOI1BEkBFaPtVGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wGv7QB1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FA4C4CEEC;
	Tue, 22 Apr 2025 06:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745303934;
	bh=My0HPs5PCFgm9Te5xuNjog8DrLJrJLl20++b6AIIYSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wGv7QB1ofT7yklC+WpmNZT/C5SsrvldbBRDqKSwV4aKSTMpZaVSOxWyrDd/GmbRu8
	 AC2sAX9QXX7a0VkEC3e4Bw+684J/o6UbzoKfbgdSMUP13dc2OqCNhx9B/Hw5HcvvSo
	 fq2Uon2z/4xyTffd1DLDGjHAWl+J1BlazacV0gp8=
Date: Tue, 22 Apr 2025 08:38:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: asml.silence@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: don't post tag CQEs on
 file/buffer registration" failed to apply to 6.13-stable tree
Message-ID: <2025042239-connected-depose-d518@gregkh>
References: <2025041712-bribe-portly-c54b@gregkh>
 <6bf72a95-ef71-432b-ab81-9ebc0110d493@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bf72a95-ef71-432b-ab81-9ebc0110d493@kernel.dk>

On Thu, Apr 17, 2025 at 12:45:45PM -0600, Jens Axboe wrote:
> On 4/17/25 4:47 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.13-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> 
> This one will apply to both the 6.13 and 6.14 stable branches, can
> you pick it up for both? Thanks!

6.13 is now end-of-life, but added to 6.14, thanks,

greg k-h

