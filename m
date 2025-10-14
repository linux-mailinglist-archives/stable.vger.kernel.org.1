Return-Path: <stable+bounces-185574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B34DEBD75DD
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 07:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0748918A5A6C
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 05:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5076723B62C;
	Tue, 14 Oct 2025 05:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1qhyp8dm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B6B1E9905
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 05:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760418653; cv=none; b=NlmNY7T/h6xxQ+wsEMdIQe/WPrLnaw0uX799BVa+7ygjR0Vyacap3t/ugYFER04VwlAaYiNJreTyWpVypqXLTWspil6LcKEo28zKdSV97bVZz1zAsrjzNUj5jDEdk6YvE3V1zBdHf7WgKnwRL7tg7IwU9evuOvew7LFb1YQFeng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760418653; c=relaxed/simple;
	bh=W/AafAdDrtZsfYTSvvq5M4QbBbJ+Q4BH+pjCWy3Q7q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knm0IE0O/ABe5XN7p7Pn9iYWsLjcv5Tp4mW9hkiBtTDn+jNM+MLt2i/glO7R8u9gXO1o+uElSPr6wVxQ/p+JhJXFm/vpMMv7GsQi18DxdhUY8Jto0eErTEYnhKRVvbkdbwwhcmFA1WK117HNseun1D6EpJ8LX+JxmiIQAEDskxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1qhyp8dm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFE2C4CEE7;
	Tue, 14 Oct 2025 05:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760418652;
	bh=W/AafAdDrtZsfYTSvvq5M4QbBbJ+Q4BH+pjCWy3Q7q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1qhyp8dmBU1qWvJtoLm/ejxhQjD+AxDMBgZ/Hat2c5y7P9w9DYeQUkQEJn1CgewT2
	 DCxlm6R+6NdW1XD3+MOefUqTWm5f6fqNl6BZqoJzYqjAtd23nvqLaKK3Iol9pX3WG+
	 sJ2oR8hBJ8Jp4t8fzKMiHkcfYS7nlrHW8s+FORHY=
Date: Tue, 14 Oct 2025 07:10:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Saravana Kannan <saravanak@google.com>
Cc: rostedt@goodmis.org, luogengkun@huaweicloud.com,
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
	runpinglai@google.com, torvalds@linux-foundation.org,
	wattson-external@google.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] tracing: Have trace_marker use per-cpu
 data to read user" failed to apply to 6.12-stable tree
Message-ID: <2025101418-buckle-morally-2eb9@gregkh>
References: <2025101354-eject-groove-319c@gregkh>
 <CAGETcx_6c_wMbBWTOEzJ-uX2o8-dodPDAsjmsJyvNd+dp1zoUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx_6c_wMbBWTOEzJ-uX2o8-dodPDAsjmsJyvNd+dp1zoUw@mail.gmail.com>

On Mon, Oct 13, 2025 at 12:42:19PM -0700, Saravana Kannan wrote:
> On Mon, Oct 13, 2025 at 1:27 AM <gregkh@linuxfoundation.org> wrote:
> >
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
> > git cherry-pick -x 64cf7d058a005c5c31eb8a0b741f35dc12915d18
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101354-eject-groove-319c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> >
> > Possible dependencies:
> 
> IIRC, this is a fix for something that went in after 6.12. So, don't
> need to backport it 6.12 or older.

The "Fixes:" tag references a commit that is in the following releases
already:
	5.10.245 5.15.194 6.1.153 6.6.107 6.12.48 6.16.8 6.17
so that's what triggered this message.

thanks,

greg k-h

