Return-Path: <stable+bounces-10502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C8C82AC67
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 11:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA1EB277F5
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D0D14AB9;
	Thu, 11 Jan 2024 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NTsOzYs2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDAD14A92
	for <stable@vger.kernel.org>; Thu, 11 Jan 2024 10:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC03C433F1;
	Thu, 11 Jan 2024 10:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704969967;
	bh=0ScNN4lO6pY3pCvEbVVscLZn7UO6nqQIv4/T/DCDYCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTsOzYs2bwS7xxTzQEiBfoTDi2lZRjE9m+q8/FVdWwfLv7SddP2QkaUKrl34Gv5Y/
	 GgHM1c8JsUzLyiG0lxPc4jiMRSgQ+h4gO3jhUnYRprvlwB5igp6lVGYwNA+KkuSbjs
	 dO0+vSRPW9h8Xq0/LnpVMR5+fAQAXErQSnxWqoUI=
Date: Thu, 11 Jan 2024 11:46:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: ruan.meisi@zte.com.cn, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] fuse: nlookup missing decrement in
 fuse_direntplus_link" failed to apply to 4.19-stable tree
Message-ID: <2024011144-pectin-lavish-e44f@gregkh>
References: <2023091601-spotted-untie-0ba4@gregkh>
 <CAOssrKe9GKw7yOhWnHDjx1poiG=g_iU5qLLNWnB8fLatkGGaJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOssrKe9GKw7yOhWnHDjx1poiG=g_iU5qLLNWnB8fLatkGGaJQ@mail.gmail.com>

On Tue, Jan 09, 2024 at 12:58:01PM +0100, Miklos Szeredi wrote:
> On Sat, Sep 16, 2023 at 2:19 PM <gregkh@linuxfoundation.org> wrote:
> >
> >
> > The patch below does not apply to the 4.19-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following commands:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x b8bd342d50cbf606666488488f9fea374aceb2d5
> 
> Attaching the backport.  This applies cleanly to  v4.14 and v4.19.

Now queued up, thanks, but note that 4.14.y is now end-of-life so I
can't apply it there.

greg k-h

