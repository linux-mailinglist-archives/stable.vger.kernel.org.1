Return-Path: <stable+bounces-110114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DFEA18CF7
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 08:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B003A944F
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 07:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334A71C3C00;
	Wed, 22 Jan 2025 07:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J6hLvSZZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15371C3C17
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737531910; cv=none; b=FgFqC50v9pPMQQgHsXuIrMKB4+NEGURZ3sDWrutPYLInpiOQh5ymI9rtHL8momLnl13V9VCNGGgG9a29nkhi51ib9BFbPeJwoPYuY6TIezF0gYsoHgiEXKwttk2yJy+9a08Bn+snzjuiZ1TX0vPyyjxL5WtDhElwySWmVDs1qHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737531910; c=relaxed/simple;
	bh=6RZyfuz6lhQK19gAQVSgYquO/z9AT9OpNNPY6buKVto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWNcNkTUdX93LflN2kRUSnrCl28pp27c+TgjQIjOw75HZvxiHYOCzMFBK1K7C64CHW6ylh+df35P+LLm0zgCcEgBjtSY2uNklSjSCj3jWfaVH7x4k66o519VgxVLFGOatZFB2xrErkG7HFYyMKSBmcloBFY+Hxw+j+oE2pJjo4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J6hLvSZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10848C4CEE3;
	Wed, 22 Jan 2025 07:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737531909;
	bh=6RZyfuz6lhQK19gAQVSgYquO/z9AT9OpNNPY6buKVto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J6hLvSZZ14+eevJBqRIkRlW0NStPezOAdzrWxwGXvZ1HFjcd0QT4+N5dhrsgzFOkv
	 PgKCYo3YlbVFNtX4rqQg7jbA0c2oCc4mVmZlqAHhcitB0IecMe10Z5LvhFb/mZDK4k
	 BWS9h36nwFPWaimy0WL8b829cJm0g6nKVCKBKe4I=
Date: Wed, 22 Jan 2025 08:45:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xingyu Li <xli399@ucr.edu>
Cc: stable@vger.kernel.org, tung.q.nguyen@dektech.com.au,
	Jakub Kicinski <kuba@kernel.org>, Zheng Zhang <zzhan173@ucr.edu>
Subject: Re: Patch "tipc: fix kernel warning when sending SYN message" should
 be probably ported to 5.10 and 5.15 LTS
Message-ID: <2025012231-tiger-litigate-a372@gregkh>
References: <CALAgD-4Wd2M01V2P8DRCMU0Lg+zJzGYSNgGQCdEpRWxrrkjHvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAgD-4Wd2M01V2P8DRCMU0Lg+zJzGYSNgGQCdEpRWxrrkjHvA@mail.gmail.com>

On Tue, Jan 21, 2025 at 11:13:38PM -0800, Xingyu Li wrote:
> Hi,
> 
> We noticed that the patch 11a4d6f67cf5 should be ported to  5.10 and
> 5.15 LTS according to the bug introducing commit. Also, it can be
> applied
> to the latest version of these two LTS branches without conflicts. Its
> bug introducing commit is f25dcc7687d4. The kernel warning and stack
> trace indicate a problem when sending a SYN message in TIPC
> (Transparent Inter-Process Communication). The issue arises because
> `copy_from_iter()` is being called with an uninitialized `iov_iter`
> structure, leading to invalid memory operations. The commit
> (`f25dcc7687d4`) introduces the vulnerability by replacing the old
> data copying mechanisms with the new `copy_from_iter()` function
> without ensuring that the `iov_iter` structure is properly initialized
> in all code paths. The patch adds initialization of `iov_iter` with
> "iov_iter_kvec(&m.msg_iter, ITER_SOURCE, NULL, 0, 0);", which ensures
> that even when there's no data to send, the `iov_iter` is correctly
> set up, preventing the kernel warning/crash when `copy_from_iter()` is
> called.

This change fails to build on those older kernels, which is perhaps why
it was not backported there.  If you wish to see it there, please
provide a working backport.

thanks,

greg k-h

