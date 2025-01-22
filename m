Return-Path: <stable+bounces-110110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7C2A18CC4
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 08:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE2F188881D
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 07:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619A016E863;
	Wed, 22 Jan 2025 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MgPGTJuD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E136A33E4
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737531029; cv=none; b=pS2i8U01gekho8Z29TWBxeM4Iqg4nNc5pJZem4rMqc9g66yxd1iDr49vZa91d+f4+dsGuRrZ4ffPrra0Wd53dqnrr5IncQzQwSXs32bM6HX2F6+fLOafunInQQg3cvmPyGqsLU9rH9C5SLHkjzukegk2SuvoYtRfOPqdGZLARHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737531029; c=relaxed/simple;
	bh=9dz3WWkzt7kS9Wq3q6oODDRCrwEhJC3OIxnyjGvFZC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvY6ZlYHDL9D3Yfd86+ZaeEh/VZ53E/je5z7FZmudJJjrhol957s+1qsu1YLfkTDbbXd1yPuhe/62hegI6aEYRLHKMOUvPey0Lf/yvQ5hrxA/VXQtCAAeHKjfXrAANoL9d4Cam5UFtF6AZuXK3r/2pvdiG4nyWyKRuJLkYblIxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MgPGTJuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33B6C4CED6;
	Wed, 22 Jan 2025 07:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737531028;
	bh=9dz3WWkzt7kS9Wq3q6oODDRCrwEhJC3OIxnyjGvFZC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgPGTJuD5VGxR/DEL0Z9/5O6UpChL3B4pG8arDuwujJuE39YSOYwjx1PdYjyc+5r/
	 WJbfMtk8mS3CX3tCQpHMNvlLib7bofvjREC+I8wMeY01Jkuwwt2yQHVZlA7zp1ohvr
	 UM0idyNbW6RqYNEt5dWyDV0gkGOjGKtK7SLbnAdE=
Date: Wed, 22 Jan 2025 08:30:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xingyu Li <xli399@ucr.edu>
Cc: stable@vger.kernel.org, pablo@netfilter.org, pabeni@redhat.com,
	Zheng Zhang <zzhan173@ucr.edu>
Subject: Re: Patch "net: flow_dissector: use DEBUG_NET_WARN_ON_ONCE" should
 probably be ported to 5.4, 5.10 and 5.15 LTS.
Message-ID: <2025012201-stray-swore-9ffb@gregkh>
References: <CALAgD-4_rpg=yZ9+7a9E5mDkOdFsz8Jjx13Shju-SEO74nOjsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAgD-4_rpg=yZ9+7a9E5mDkOdFsz8Jjx13Shju-SEO74nOjsg@mail.gmail.com>

On Tue, Jan 21, 2025 at 11:07:48PM -0800, Xingyu Li wrote:
> Hi,
> 
> We noticed that the patch 120f1c857a73 should be ported to 5.4, 5.10
> and 5.15 LTS according to bug introducing commits. Also, they can be
> applied to the latest version of these three branches without
> conflicting.
> Its bug introducing commit is 9b52e3f267a6. According to our manual
> analysis,  the  commit (9b52e3f267a6) introduced a
> `WARN_ON_ONCE(!net);` statement in the `__skb_flow_dissect` function
> within `net/core/flow_dissector.c`. This change began triggering
> warnings (splat messages) when `net` is `NULL`, which can happen in
> legitimate use cases, such as when `__skb_get_hash()` is called by the
> nftables tracing infrastructure to identify packets in traces. The
> patch provided replaces this `WARN_ON_ONCE(!net);` with
> `DEBUG_NET_WARN_ON_ONCE(!net);`, which is more appropriate for
> situations where `net` can be `NULL` without it indicating a critical
> issue. This change prevents unnecessary warning messages from
> appearing, which can clutter logs and potentially mask real issues.
> Therefore, the prior commit introduced the issue (the unnecessary
> warnings when `net` is `NULL`), and the patch fixes this by adjusting
> the warning mechanism.

Have you tested the commit to ensure that it actually works?

Hint, I just tried, it breaks the build on all of the above branches,
which is probably why it was not backported.

Please test stuff before asking others to test it for you :(

thanks,

greg k-h

