Return-Path: <stable+bounces-104506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DB99F4D66
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 15:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9EB16B80A
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B31B145A09;
	Tue, 17 Dec 2024 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fN9yW8A1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE2B2B2DA;
	Tue, 17 Dec 2024 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444962; cv=none; b=g5cDvxnXbsz3/2EW8wAyIStLQmnpLAq6CjP0tIYrGKiYDKosj8qSbrMDiEKKtcuVtHUhfdIh6EOJW383pjgTGZHBeqOKzTDUWkbbsLPIt422oNcpmHsWdy2C4zkVJMy77q16cQJxWyeJqzWJM4UTzYGcfeYp/Hk5dQR0raL7jbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444962; c=relaxed/simple;
	bh=NqvE7NB5xW/yNTOuRo+CP4oKquaYLKTQlrj9rhzthrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQymuZT65YPjuxfYXp/ure44wWH6ooLwyIhFpN1nt8rnpVNkBy7Q57q3PlI7q+GS/e2Ut+eoA1NFWoLGTX78EXeczu/2JTLBAz59kkUi/rqd0bfAuAyltjM+bu9HVynGuaUgtvz2wP5FdggiCaRaXeBV9l02/5yhH7XcvxCZqe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fN9yW8A1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705D3C4CED3;
	Tue, 17 Dec 2024 14:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734444961;
	bh=NqvE7NB5xW/yNTOuRo+CP4oKquaYLKTQlrj9rhzthrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fN9yW8A1zXVM16bnFrTjKxzWyKoUGndTNLmEP63dGBPZ9zjBd83lWoQUdXwXCjPxV
	 u/b0DgzkNwF2fJDKf2Dk7RPFiiEBZind3mBSbWmAoStPlI9c2ooRhrYtcW0Q+yem9a
	 ERomowE0NrVFlbZ4kHaMBV5q/rYXa2pQXg2L9GlU=
Date: Tue, 17 Dec 2024 15:15:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gustavo Padovan <gus@collabora.com>
Cc: sashal <sashal@kernel.org>,
	"kernelci lists.linux.dev" <kernelci@lists.linux.dev>,
	stable <stable@vger.kernel.org>,
	Engineering - Kernel <kernel@collabora.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: add 'X-KernelTest-Commit' in the stable-rc mail header
Message-ID: <2024121731-famine-vacate-c548@gregkh>
References: <193d4f2b9cc.10a73fabb1534367.6460832658918619961@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <193d4f2b9cc.10a73fabb1534367.6460832658918619961@collabora.com>

On Tue, Dec 17, 2024 at 11:08:17AM -0300, Gustavo Padovan wrote:
> Hey Greg, Sasha,
> 
> 
> We are doing some work to further automate stable-rc testing, triage, validation and reporting of stable-rc branches in the new KernelCI system. As part of that, we want to start relying on the X-KernelTest-* mail header parameters, however there is no parameter with the git commit hash of the brach head.
> 
> Today, there is only information about the tree and branch, but no tags or commits. Essentially, we want to parse the email headers and immediately be able to request results from the KernelCI Dashboard API passing the head commit being tested.
> 
> Is it possible to add 'X-KernelTest-Commit'?

Not really, no.  When I create the -rc branches, I apply them from
quilt, push out the -rc branch, and then delete the branch locally,
never to be seen again.

That branch is ONLY for systems that can not handle a quilt series, as
it gets rebased constantly and nothing there should ever be treated as
stable at all.

So my systems don't even have that git id around in order to reference
it in an email, sorry.  Can't you all handle a quilt series?

thanks,

greg k-h

