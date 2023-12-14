Return-Path: <stable+bounces-6761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19FD8139E4
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 19:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A96A1C20CFC
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 18:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97BA68B82;
	Thu, 14 Dec 2023 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uWkrr++r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9245F67E94
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 18:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F08C433C8;
	Thu, 14 Dec 2023 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702578221;
	bh=iV7qUVHvKZu/hWCXWoq8D8wdTApeMolIft6Aw07MxbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uWkrr++rlhOBrb2KsOwuXb5jcR3xbaPD2KvA90PtPKBbYvpIkcKvgGBAQeK0Ptw8x
	 rGeYN6Kywbj9CZpr5zBBNtgU6vnadwTyNMxbqbMHDaEDQCG6GtlSk8ytTkpfxLQobe
	 CEhRGcnJTKvbjyUKzLhB4IkUa7RybANmKGqNK9NU=
Date: Thu, 14 Dec 2023 19:23:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: stable@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 5.10 0/2] checkpatch: fix repeated word annoyance
Message-ID: <2023121442-cold-scraggly-f19b@gregkh>
References: <20231214181505.2780546-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214181505.2780546-1-cmllamas@google.com>

On Thu, Dec 14, 2023 at 06:15:02PM +0000, Carlos Llamas wrote:
> The checkpatch.pl in v5.10.y still triggers lots of false positives for
> REPEATED_WORD warnings, particularly for commit logs. Can we please
> backport these two fixes?

Why is older versions of checkpatch being used?  Why not always use the
latest version, much like perf is handled?

No new code should be written against older kernels, so who is using
this old tool?

thanks,

greg k-h

