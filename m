Return-Path: <stable+bounces-152643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0BAAD9D35
	for <lists+stable@lfdr.de>; Sat, 14 Jun 2025 15:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A783A518D
	for <lists+stable@lfdr.de>; Sat, 14 Jun 2025 13:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B532D878B;
	Sat, 14 Jun 2025 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsYk4wRs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A142C08D8;
	Sat, 14 Jun 2025 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749909264; cv=none; b=aM0nDOdsPHhuRUMc9XhqTAADqZCpqllgHZG0qQp7o60T0X+Pwfzsfd3K0aJizDBaTmuXW6BIQEi1T7eqzzlSX6yMBc9hFkBqTs0OauTL9S4byLGr7mVlZQyAVOuxrvB5MYgg3m5HUq/KGabDpeZu2pJKvep8oa/qZCpbd71eSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749909264; c=relaxed/simple;
	bh=9U5U9HMbIfjlTvZGtB4LaoD/UGwzp2Hk/JApUwBh8pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ereh+F8cXQ7u6NdtN6H6e5fu5SoUWNJN4l0TyUADbnb8zf4DmHvx+0cvN3sLLaCRd8LmwK15LoNwIizccQqV7bB9v8Qkoqkj9tmkUJPs7NJqp2abkhUeCGOqSM76u9armLFwW49dAAgtd4Ut7wO0hThX/kHQty73R70EW3s7zwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsYk4wRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D1AC4CEEB;
	Sat, 14 Jun 2025 13:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749909264;
	bh=9U5U9HMbIfjlTvZGtB4LaoD/UGwzp2Hk/JApUwBh8pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RsYk4wRsRs2WyV373EQe0p29wsFSoQOf7j5oTWSASJKvD+nhCA0V6hMrYq1DIDMkH
	 ny0eBvEJJmdauoXla8zLRNXm32fNiQ+ndGps+F8gWake/8OrPWsoC6mVoP7WZgtUIs
	 r2yEeiXOnpCYydnXNHtdRWfuXQ0EHt1CoPGDtLOusw66uHB9eix3veCl2+xqVxqeJz
	 ZkVIOfvmK6LyW6JPG4TiSN74Cc+KnsK0zhUFD2Ztj3NOFEi7hfDpt4MYypzoQPSIhZ
	 s4VUskF0uEnR3k1i3UMbAxXXTa3c765Pea+lwkG8AMY3y3s6Hsh+A3AAwFsLpaVdfi
	 SfLTdFOFKjxHg==
Date: Sat, 14 Jun 2025 09:54:22 -0400
From: Sasha Levin <sashal@kernel.org>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: stable@vger.kernel.org, xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com, catherine.hoang@oracle.com,
	djwong@kernel.org
Subject: Re: [PATCH 6.1 00/23] fixes from 6.11 for 6.1.y
Message-ID: <aE1_DlwiLbq6KsRl@lappy>
References: <20250611210128.67687-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250611210128.67687-1-leah.rumancik@gmail.com>

On Wed, Jun 11, 2025 at 02:01:04PM -0700, Leah Rumancik wrote:
>Hello again,
>
>This is a series for 6.1.y for fixes from 6.11. It corresponds to the
>6.6.y series here:
>https://lore.kernel.org/linux-xfs/20241218191725.63098-1-catherine.hoang@oracle.com/

Queued up, thanks!

-- 
Thanks,
Sasha

