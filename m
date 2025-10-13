Return-Path: <stable+bounces-184233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D679BD3384
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23EB3BE647
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 13:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DF9307AEE;
	Mon, 13 Oct 2025 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vh+huvgH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E014307AE9;
	Mon, 13 Oct 2025 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362448; cv=none; b=FtuKcLr4tOdZ+akLs1DuLV34bnJRhsBKHWhohygNYvwrWD46y59a6cN0h3e8T+zIB1mef5RCINYUzOtfqHJLg5l5Z3FFlWU43q+1pi/yfluRZwS92ZKnZqRn430cyD9lSzDuyuSRYsXccw8xoreBX9lm5VLMUQY2PpZ9cwRjXpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362448; c=relaxed/simple;
	bh=Y8LIaOsMMpz7Kq4NcZEvijRqPYNIaZDlbNbbex5bj8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXT2chagQ3mlziYeFJE47kWF1xl1coktMlF+zT7LgKzFzB+OBR6N3OjBSZkIF7UfWckXWq0GILBC44riRJhNGaBhvz3HFkY1kJX3MN5fi31e9zIdsb754YIRTYkhC76tLBdWqYLHqrcDAyPkcIX3UpqglL9IWwKehUuyY+Mz5ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vh+huvgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2078CC4CEE7;
	Mon, 13 Oct 2025 13:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760362444;
	bh=Y8LIaOsMMpz7Kq4NcZEvijRqPYNIaZDlbNbbex5bj8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vh+huvgHGCJjnFxCNtMSXdY3sCP/DvKy3RQQ3RgNYuOqu0w0xaqgRrgeMdxQd2oFd
	 tPQ8guVlyNYgW2a/cK7OsptUJZwWrdwgvyoGZpUDGYJUn15jaJv1H79u2iIpewOPmp
	 jXb8jRjm1r+BoucO9LC1ZWmSdXovWUmam+fYfacw=
Date: Mon, 13 Oct 2025 15:34:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	geert+renesas@glider.be, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Patch "gpio: TODO: remove the task for converting to the new
 line setters" has been added to the 6.17-stable tree
Message-ID: <2025101353-charred-squishier-6f0e@gregkh>
References: <20251012135727.2876348-1-sashal@kernel.org>
 <CAMRc=MeD1FgCxEwSUgOJythtKU2R=6OZ0vJg0_rjhdJOneW+5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeD1FgCxEwSUgOJythtKU2R=6OZ0vJg0_rjhdJOneW+5w@mail.gmail.com>

On Mon, Oct 13, 2025 at 09:38:37AM +0200, Bartosz Golaszewski wrote:
> On Sun, Oct 12, 2025 at 3:57 PM Sasha Levin <sashal@kernel.org> wrote:
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     gpio: TODO: remove the task for converting to the new line setters
> >
> > to the 6.17-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      gpio-todo-remove-the-task-for-converting-to-the-new-.patch
> > and it can be found in the queue-6.17 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> >
> 
> As per commit message: this is neither a fix nor even a new feature,
> this is just a change in the TODO file. Please drop it, this has no
> place in stable branches.

Now dropped, thanks for the review.

greg k-h

