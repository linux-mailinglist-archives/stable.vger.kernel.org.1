Return-Path: <stable+bounces-100311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BA29EAB06
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4825A2821CE
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 08:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E0F23098B;
	Tue, 10 Dec 2024 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oSZFSJBd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F55C12DD88
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820696; cv=none; b=quoAQBrk+aZ6CMRdz7I25m/PUMZNQ93RLNoCeizDTOId7giXOJbe//QvM3Pyubi0AnDWm8ADRaICjBT86VQzsZHdeYkyJs6S6J0mz7gUr+OoNNRZeu/qDaJ3rN2xbOjcezQCDX56shFL6VhyXWbZrccbPTkuVN8B3NrPfzp+W/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820696; c=relaxed/simple;
	bh=GvjM53S08qxx3l9uh6dJ2Jzg6cQqvKhoMUV2RHRrE1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxWSYpZqKkcD9aQbUlcheAB2BEozbzSByIt8tNA/tvdt/MGkSqFTZEnITXq/ZUSpBnIsZygBw7+KOrutUOOr9hJA2x4glRyMQsHR4+Xw1wh62RigRwEMOpe2eLgzF/ZBgpt+h/z+2APD6eSzBenuFEFy5jXJmdxbZWWjcWtDaYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oSZFSJBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E28EC4CED6;
	Tue, 10 Dec 2024 08:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733820695;
	bh=GvjM53S08qxx3l9uh6dJ2Jzg6cQqvKhoMUV2RHRrE1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oSZFSJBdCr8NgPA5E5mxwmabmnVwvyq+zKMwWESsfV4lRAn+fns9iXPm7oxo4OHN5
	 Q7Jllps3woDwYnfOUn2MNY+7rtj0tT3v3sx7plD+jYaZlnsXx1PZbIS5TvoewOpu7m
	 7sX4P9h6z2hl6vCEJ5L1dYmm2HxZTh7nAs43trxc=
Date: Tue, 10 Dec 2024 09:50:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: Apply c95bbb59a9b2 to 6.12.y
Message-ID: <2024121039-sizing-drivable-5ccc@gregkh>
References: <CANiq72=ryzv+5UT2jXALNebpYjxm_guSsU-XXm-0BM4WULPYhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=ryzv+5UT2jXALNebpYjxm_guSsU-XXm-0BM4WULPYhw@mail.gmail.com>

On Tue, Dec 10, 2024 at 03:03:50AM +0100, Miguel Ojeda wrote:
> Hi Greg, Sasha,
> 
> Please consider applying commit c95bbb59a9b2 ("rust: enable
> arbitrary_self_types and remove `Receiver`") to 6.12.y.
> 
> It is meant to support the upcoming Rust 1.84.0 compiler (to be
> released in a month), since 6.12 LTS is the first stable kernel that
> supports a minimum Rust version, thus users may use newer compilers.
> Older LTSs do not need it, for that reason.
> 
> It applies almost cleanly (there is a simple conflict).

Please submit a working version, we don't want to have to fix conflicts
in a way that you don't agree with :)

thanks,

greg k-h

