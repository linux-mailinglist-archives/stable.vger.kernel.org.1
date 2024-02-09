Return-Path: <stable+bounces-19392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE5C84FC4F
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 19:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F56285A89
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 18:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492C580C03;
	Fri,  9 Feb 2024 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Npqp7Eu5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBA47E770
	for <stable@vger.kernel.org>; Fri,  9 Feb 2024 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504720; cv=none; b=mGNZawlRD3Lb3N1nZpQWkfRaw+USH4M2jGJwY3mTeeRG0HEuvhZBYW3ibpDbKewT+Qr3RBDiGbgTsRKDfPZ47LDi6cFfp0fhjBu4+7bgQSLpE0/8dLNrwLxuV7f3DRY9hsy89j1kajko8rSDgEHvX+xjWMJtNsvn3fReUJr+kA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504720; c=relaxed/simple;
	bh=shagwgmxXC1jtgg1o/Z4BIGTSy91HUch0hmc3QzxJQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCs/mLMz4B6foxiiSaXRHBjmAAeXPfUoC68DEdTtveQYSF7MnbxrhmZkXxvitv6BN/8AbTmPJxkXhm8KJtisQ0U7F2JT7Zf5ZAfLeBo9YsVbU4/q4C6P7xixo9UpHpycp8BKN+NEFL1xFhlTsMZa765vHQB6aKi2sBz6brSvBco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Npqp7Eu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5279CC433F1;
	Fri,  9 Feb 2024 18:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707504719;
	bh=shagwgmxXC1jtgg1o/Z4BIGTSy91HUch0hmc3QzxJQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Npqp7Eu5ErC4831+6Tpmw/3YMdj29vqT0cUEOfl+0XTvWrQ9/6uJxIyFVhzEVwwYE
	 mKCWAHNgx2TB00omVb2A70nrqrVPliWs2vb0chY7qVlQcxjTPfAajiT2CnXHlBhBAc
	 jPM+XD4fLLqDMGovLmXzGK6bqRAkaU7LR+0r0pxbztdvu63YW7ciugL/SkVN1I5qQs
	 8jLUWVWP/Gx1UYc4xLQiU87MxdLkZBC1BwZ26DVSpXaCxcV1+76b0i3WotdLIhnA+7
	 G0wUwiqEYKhd/mvUIkPcqmM5Vl21agPaIA/C1aEV34quJdVON5rLmW8re6DA/6pefD
	 ro/AE9hAupEiw==
Date: Fri, 9 Feb 2024 13:51:57 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jordan Rife <jrife@google.com>
Cc: stable@vger.kernel.org, ccaulfie@redhat.com, teigland@redhat.com,
	cluster-devel@redhat.com, valentin@vrvis.at, aahringo@redhat.com,
	carnil@debian.org
Subject: Re: [PATCH 6.1.y] dlm: Treat dlm_local_addr[0] as sockaddr_storage *
Message-ID: <ZcZ0Tb13ZG9knz_P@sashalap>
References: <20240209162658.70763-2-jrife@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240209162658.70763-2-jrife@google.com>

On Fri, Feb 09, 2024 at 10:26:57AM -0600, Jordan Rife wrote:
>Backport e11dea8 ("dlm: use kernel_connect() and kernel_bind()") to
>Linux stable 6.1 caused a regression. The original patch expected
>dlm_local_addrs[0] to be of type sockaddr_storage, because c51c9cd ("fs:
>dlm: don't put dlm_local_addrs on heap") changed its type from
>sockaddr_storage* to sockaddr_storage in Linux 6.5+ while in older Linux
>versions this is still the original sockaddr_storage*.

Or we can just take c51c9cd8addc ("fs: dlm: don't put dlm_local_addrs on
heap") into the relevant trees?

-- 
Thanks,
Sasha

