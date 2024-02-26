Return-Path: <stable+bounces-23600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253CA8669CA
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 07:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1E6EB20D91
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 05:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB92F1B948;
	Mon, 26 Feb 2024 05:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m8OnWd4H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7376518EA8;
	Mon, 26 Feb 2024 05:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708927193; cv=none; b=F4oNyPmuFN4BWGqgcqs1pBRr2mAjymdykxmDki3vBDGbdT4CIUVFyTA1Q3lq77DNHY4FZQIanhPFSmmg9nhrISjblSL/daqfG3rQRIllbyXQ+Jvr1FfPuAdtXSsPjLz6PM26WPtpby1liC3qQcuQAH1VrJKach3va+YwC/bmVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708927193; c=relaxed/simple;
	bh=ZOF6Mjfjfv69QgQBxttRskbojXF3d4dpzyo7ILU9wd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qi4I0d8h4fP90F1zPNyolOP8f8YKLuzIVou3YLVJ4W6OvhIw277i44iPctwAK1TLVqIRXJAyihHUqDFrOx72jeoPQUkP42h532cU8KkXlPV5xfVBah3BELkcKGYEA2ZETBrR65IEKgvxBgPU3BnmUJEyEK4Ws4HVNsQijTcTHdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m8OnWd4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD7AC433F1;
	Mon, 26 Feb 2024 05:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708927192;
	bh=ZOF6Mjfjfv69QgQBxttRskbojXF3d4dpzyo7ILU9wd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m8OnWd4HYPYIhWGftV8PnrEAAYvQiOEjrwUYZ1Pr4VuRGHZxcwgoQWJa9PA1/cxPN
	 NOjg8f13YKqXZGHBLF6XzopAGzHKuQYd7Bk1L4D96xFmKzsjrPVLY923J9s/HJ1T2k
	 h8dKfJ47f4hD5Hk0NPy5O2afaBhgxAKfwbjgT2Yc=
Date: Mon, 26 Feb 2024 06:59:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, David Gow <davidgow@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Erhard Furtner <erhard_f@mailbox.org>, stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: Please apply 56778b49c9a2cbc32c6b0fbd3ba1a9d64192d3af to
 linux-6.7.y
Message-ID: <2024022637-snowbound-fedora-e8e7@gregkh>
References: <20240225194735.GA498058@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225194735.GA498058@dev-arch.thelio-3990X>

On Sun, Feb 25, 2024 at 12:47:35PM -0700, Nathan Chancellor wrote:
> Hi Greg and Sasha,
> 
> Please apply commit 56778b49c9a2 ("kunit: Add a macro to wrap a deferred
> action function") to the 6.7 branch, as there are reported kCFI failures
> that are resolved by that change:
> 
> https://github.com/ClangBuiltLinux/linux/issues/1998
> 
> It applies cleanly for me. We may want this in earlier branches as well
> but there are some conflicts that I did not have too much time to look
> at, we can always wait for other reports to come in before going further
> back as well.

Now queued up, thanks.

greg k-h

