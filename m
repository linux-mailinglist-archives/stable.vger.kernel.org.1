Return-Path: <stable+bounces-159249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B873CAF5B15
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 16:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D5B188D9FC
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 14:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0804F2F5337;
	Wed,  2 Jul 2025 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XaSMB1hg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A6E2F5310
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751466358; cv=none; b=kdcF0tMxQi8uJ1xUy5YC454r2KXIvmOfpO1ewyHwt0/j58PJ5sQQnPBtTBpSG8TbzkI5k6eRg/xK+GmHDfsSa72+nttL13dFfZMZEGxIqLqyMMcuNtF8UW0vOAcPXfM/nxZAyg0mkT2o+PRkL0k10b2AYKNG9RGopzp+kGw31oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751466358; c=relaxed/simple;
	bh=lM07I3rLJEShqxBHv4Do5aV6YDI6UAp6Crr+5ZKHjuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ia6NePdhLBehdMnRby+DVh4Gky8bhcs4c6tYoDalfp6U2zXuNxuXDf3aWhrh3AIiT1A40lxQaiQd3eEbO2guwuvYqUwR7Daca7VpvKKuoeIouZT6Aw2Jm6bLFVYNVlKn0MIvD/nuJkACgTVFaUaEd1IbOSgKqEVIMPBIyaZf8bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XaSMB1hg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CA6C4CEED;
	Wed,  2 Jul 2025 14:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751466358;
	bh=lM07I3rLJEShqxBHv4Do5aV6YDI6UAp6Crr+5ZKHjuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XaSMB1hgOVFhNmO+FicuBqw1uv/beD9tqdPaTxPtILkk98QUD4mKYvzfh4+KOqele
	 KNiaeS13+jKSdgcVyNhOdUAlSMNE2r8VI56XAyWXfRgS/nHN6fM3gBuUPWYGWNkNpB
	 UJ0WMH98vuFLXZw9hxS9kaUs4SxZKbSA+3pctqhU=
Date: Wed, 2 Jul 2025 16:25:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] nvme: always punt polled uring_cmd end_io
 work to task_work" failed to apply to 6.1-stable tree
Message-ID: <2025070249-iodine-genetics-00bc@gregkh>
References: <2025062012-veggie-grout-8f7e@gregkh>
 <a527c502-4cd6-477d-b77e-7e987486c52e@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a527c502-4cd6-477d-b77e-7e987486c52e@kernel.dk>

On Fri, Jun 27, 2025 at 10:09:56AM -0600, Jens Axboe wrote:
> On 6/20/25 9:10 AM, gregkh@linuxfoundation.org wrote:
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
> > git cherry-pick -x 9ce6c9875f3e995be5fd720b65835291f8a609b1
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062012-veggie-grout-8f7e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Here's a 6.1-stable variant.

Now applied, thanks.

greg k-h

