Return-Path: <stable+bounces-83055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 081B199536B
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 17:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13C41F23301
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7186374C4;
	Tue,  8 Oct 2024 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JhwuSztq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E76249E5
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728401521; cv=none; b=nXEuoq78vJIWEXVDiUxIPPXH+GFg1WU/zse2SpHtjcKE+3vyRWlaPv8kAFqBQM/guD5ugJ75HbjV8IJtzRoJ6PBPrxMYZrfyb75frear8LvwtaWvsx18QdGXIJqAfxIfMWi9y5hJKb3kFiiAs/KKdkldX0B8rCysu3/HPu8d2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728401521; c=relaxed/simple;
	bh=04VuZOC+W1mCyp7RNhImM05elvsMud4AYc16CxH00ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZzJmWUi60qcvLnVmRT50yyCG0TyvL1jMBDzg7XQYlvTmtcqtpZSvHfXyOg32pDYxyqQL++z/RxccwXMyGkaTLKdAafaTGbHxSvAWUihmcjng5zBC0+F+cGEFjn2azOUth1+fMXTToeTq5tlGREhwHmsQODW+rZqNX0Zi89FAOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JhwuSztq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B3AC4CEC7;
	Tue,  8 Oct 2024 15:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728401521;
	bh=04VuZOC+W1mCyp7RNhImM05elvsMud4AYc16CxH00ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JhwuSztqzyf7XyXs01J/Mo0SUWmOaATNfn0QFbf1RpIFPc7tRiweVwkwI/sBua1i4
	 6x4cYdg/0VZRNfUoMlbQE3mmegL9DTx5xeM/CuFs7EkIJJil8Krnxq05aZYlsayiK1
	 j0Cc7rQdPkizPz84LYQoEiEdiUB1aQA2f2v8Ml5g=
Date: Tue, 8 Oct 2024 17:31:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: matthew.auld@intel.com, matthew.brost@intel.com, nirmoy.das@intel.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] drm/xe/vm: move xa_alloc to prevent UAF"
 failed to apply to 6.11-stable tree
Message-ID: <2024100817-quarrel-retread-b7a3@gregkh>
References: <2024100727-compacted-armored-bbce@gregkh>
 <au2yg6xpydfomljjfmll6j6h6mwpzm73kojc5zjck3im6grson@e3ajgznra66s>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <au2yg6xpydfomljjfmll6j6h6mwpzm73kojc5zjck3im6grson@e3ajgznra66s>

On Tue, Oct 08, 2024 at 09:29:49AM -0500, Lucas De Marchi wrote:
> On Mon, Oct 07, 2024 at 07:45:27PM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.11-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 74231870cf4976f69e83aa24f48edb16619f652f
> 
> did this change for sending patches to stable?  Is this an alternative
> only for using --in-reply-to to a failed patch or can
> `git cherry-pick -x` be used as alternative to the
> "commit 74231870cf4976f69e83aa24f48edb16619f652f upstream." in the body?

I'll take either/any/some kind of hint as to what the commit id is.  If
you want to hand-write it, wonderful, if you want to use git to
automatically include it like here, even better, it's your choice.

greg k-h

