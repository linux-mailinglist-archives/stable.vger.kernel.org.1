Return-Path: <stable+bounces-100314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B28C9EAB10
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2A018884FE
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 08:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32C4230D34;
	Tue, 10 Dec 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1IjN3unp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C6012DD88
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820775; cv=none; b=M0tSiQy6b3JhIAjCLVPYzJsx0aXbkQhx9B+uzisESp27D+2+Gi+mPEP/TTDk5IxX8CZ3+D/pBJG2KBCYLXu/fjPaFs+GFipPC1Y/8RjkDJdBHqYaGOjY4kg6B4v295fO4jBy8IbJz5RhchCa6BUabkflL5N4cGueiVPUYLaevqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820775; c=relaxed/simple;
	bh=rYRdA5McwYFv7X0820nSAfZvQ8EG7r+3OH+j9lnqIP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5FYOkja7LR2OmqmTgvF7l4vVh6jbl9a3FC+Un0IHiMKQxIrdmAtkg3xItztWhqHr8s6BZ1gnxEDYKJEh713CWqlUzfk+IhLeAEwmtmvSzQjuf3e+T1h5a2HJINqSYSW60BRbS/9nkKiQh6GNMvWVKJrX0h5W/j3XM8VtlJew/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1IjN3unp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83F0C4CED6;
	Tue, 10 Dec 2024 08:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733820774;
	bh=rYRdA5McwYFv7X0820nSAfZvQ8EG7r+3OH+j9lnqIP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1IjN3unpsHMQn39M4eF5kbr4mkr+QLYwKy6I5fuOVQBk6HGvbJlsldKAAzinXUIic
	 7g/rkHJw4Ttq0+2YfxtsSRBZ9QsnG9vEZHf0I6diEBL1OlSyQzmhU0hbcQ/jsNo/kv
	 jKs7sldQkgr1r9cu7ha4BxlmjZWG3/Yc93pAnc/8=
Date: Tue, 10 Dec 2024 09:52:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: Apply 60fc1e675013 to 6.12.y
Message-ID: <2024121012-molehill-announcer-8ebc@gregkh>
References: <CANiq72k9A-adJy8uzog_NdrrfLh6+EgHY0kqPcA5Y45Hod+OkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72k9A-adJy8uzog_NdrrfLh6+EgHY0kqPcA5Y45Hod+OkQ@mail.gmail.com>

On Mon, Dec 09, 2024 at 10:55:23PM +0100, Miguel Ojeda wrote:
> Hi Greg, Sasha,
> 
> Please consider applying commit 60fc1e675013 ("rust: allow
> `clippy::needless_lifetimes`") to 6.12.y.
> 
> It is meant to avoid Clippy warnings with Rust 1.83.0 (released two
> weeks ago), since 6.12 LTS is the first stable kernel that supports a
> minimum Rust version, thus users may use newer compilers. Older LTSs
> do not need it, for that reason.
> 
> It applies cleanly.

Now queued up, thanks.

greg k-h

