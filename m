Return-Path: <stable+bounces-124335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E778CA5FB0C
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 17:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1BF3BCDC2
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 16:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE51126B2C3;
	Thu, 13 Mar 2025 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="04T1g/1/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0F22698A3
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881822; cv=none; b=VkPmTjD3EJxWA84zT8Ubpf4StyNHZBGt8PG7n8r5yytor4TBhkyjnlqh9LRfJL05c2HMexg6H+aKEOrJx2rGHFSwm48SYZrhfYKGmXu8nPNhPBraf0R4ePre3Ij8YBR+AV5+7z4zz8C9F76/PhouGrqFHBTPYvEaxrv/0MYMyQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881822; c=relaxed/simple;
	bh=BghmhwF6MQnf1uuA4Ju5RZzDL3oCIWy9Rx8irl5gshw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXnAwB68H3ZqdbOg3nMULDcM4FOuw67SXbtTWCknC6RJdMYC4sYTDdG+QCjqtJ1YRtNGsiFaFf1HyGo7Lna7uFJAJTgR5qw8bNuztCLTsQUNDI+SucTTrTtEktQq0bftatdni5aswj9cM/xyO4zlGOXeJhfRkay+j4VkViskXPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=04T1g/1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2D4C4CEDD;
	Thu, 13 Mar 2025 16:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741881821;
	bh=BghmhwF6MQnf1uuA4Ju5RZzDL3oCIWy9Rx8irl5gshw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=04T1g/1/NdwJwLfkMMTXvnHLdeyZH1N5kBKKGJk+c9tQomZGfpdIsg7EgMSIqVC0A
	 r/BmAmbRBu6omL/5EEFxsMHm016lfZSONDskZu3K/ims5FOQcDyRZOtcUvEIjnx+my
	 sjQAlhKc8SceurOr7i9i9XgdERRlQM7oO3MSvPWg=
Date: Thu, 13 Mar 2025 17:03:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: 21cnbao@gmail.com, Liam.Howlett@oracle.com, aarcange@redhat.com,
	akpm@linux-foundation.org, david@redhat.com, hughd@google.com,
	jannh@google.com, kaleshsingh@google.com, lokeshgidra@google.com,
	lorenzo.stoakes@oracle.com, peterx@redhat.com,
	stable@vger.kernel.org, v-songbaohua@oppo.com, willy@infradead.org
Subject: Re: FAILED: patch "[PATCH] userfaultfd: fix PTE unmapping
 stack-allocated PTE copies" failed to apply to 6.12-stable tree
Message-ID: <2025031324-mayday-autism-c604@gregkh>
References: <2025030948-playhouse-strongman-c9c3@gregkh>
 <CAJuCfpG5ovkVXHsxB+L_Spjs1hMYuA725+BgjiQGkqzb1Uiymw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpG5ovkVXHsxB+L_Spjs1hMYuA725+BgjiQGkqzb1Uiymw@mail.gmail.com>

On Mon, Mar 10, 2025 at 12:02:12PM -0700, Suren Baghdasaryan wrote:
> On Sun, Mar 9, 2025 at 11:15 AM <gregkh@linuxfoundation.org> wrote:
> >
> >
> > The patch below does not apply to the 6.12-stable tree.
> 
> Hi Greg,
> Similar to linux-6.13.y, I just posted linux-6.12.y backport [1] for
> an earlier patch and with
> that and with 37b338eed10581784e854d4262da05c8d960c748 which you
> already backported into linux-6.12.y this patch should merge cleanly.
> Could you please try cherry-picking it again after merging [1] into
> linux-6.12.y?

Now done, thanks.

greg k-h

