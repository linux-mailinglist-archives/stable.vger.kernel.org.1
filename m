Return-Path: <stable+bounces-83229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E39996E7B
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 16:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DEA286EF5
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 14:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB5918BBB0;
	Wed,  9 Oct 2024 14:44:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B907012EBEA
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485089; cv=none; b=qqi8UwEa7d1W7feKhkZEgvyhLUZuiFgZX5SSlatA8HZvSnYoILk3vtsjzOakn/5vAzpvcolxbwxduIRdvdKXIreEf1ZqH92ORVdOLI9CYSsswKs42RfjHe92nJjTrXkVrDVD1QrlcrNn4B8Itabq3y6XT3KN8NYZg9V6j75CThk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485089; c=relaxed/simple;
	bh=YZVYIRy2eoUC95EYiNoBLTffXApTU/zHjSqjIU/hK+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2z/ftaThEeTNdRycDaQbjWnowtG3oSdxDULkjSMxYEKFU0X1fode8rw14ZqaQIKtxEvEla6Zv00R+dqMTQ0JqB3y8Wztn4Ez9GPyXEhRTqKRGJd+8y97+hzk+rEzRwDYM86wYxirxIZU4iLM4V3Lz2q1eQ4fgyXXgAhH2UY0Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B3CC4CEC3;
	Wed,  9 Oct 2024 14:44:47 +0000 (UTC)
Date: Wed, 9 Oct 2024 10:44:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sherry Yang <sherry.yang@oracle.com>, stable@vger.kernel.org,
 sashal@kernel.org, jeyu@kernel.org, mingo@redhat.com, ast@kernel.org,
 jolsa@kernel.org, mhiramat@kernel.org, flaniel@linux.microsoft.com
Subject: Re: [PATCH 5.10.y 0/4] Backport fix commit for
 kprobe_non_uniq_symbol.tc test failure
Message-ID: <20241009104453.092e1458@gandalf.local.home>
In-Reply-To: <2024100909-neatness-kennel-c24d@gregkh>
References: <20241008222948.1084461-1-sherry.yang@oracle.com>
	<2024100909-neatness-kennel-c24d@gregkh>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 15:36:42 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Oct 08, 2024 at 03:29:44PM -0700, Sherry Yang wrote:
> > 5.10.y backported the commit 
> > 09bcf9254838 ("selftests/ftrace: Add new test case which checks non unique symbol")
> > which added a new test case to check non-unique symbol. However, 5.10.y
> > didn't backport the kernel commit 
> > b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")to support the functionality from kernel side. Backport it in this patch series.
> > 
> > The first two patches are presiquisites. The 4th commit is a fix commit
> > for the 3rd one.  
> 
> Should we just revert the selftest test instead?  That seems simpler
> instead of adding a new feature to this old and obsolete kernel tree,
> right?

The selftest is just testing to see if the kernel has the bug. The bug is
that if there's more than one function with the same name, and someone
attaches a kprobe to one of them, the user doesn't know which function it
is attaching to, and the kernel doesn't tell the user that it's picking
some random function. This can have undesirable results.

I don't know how much this kernel is still used. But if it's supported and
still taking fixes, I would consider this a fix and not a feature.

-- Steve

