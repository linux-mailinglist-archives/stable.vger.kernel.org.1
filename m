Return-Path: <stable+bounces-40414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DD18AD954
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 01:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ED60B24632
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 23:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B8445C06;
	Mon, 22 Apr 2024 23:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjJQPO2X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7A045BE7;
	Mon, 22 Apr 2024 23:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829864; cv=none; b=SejBKyNAK+CFpoXXZNPACwas8ZPovGMl6wESO16PYqP+huZS0zeMg8BqnhwZYIh7jQZjV6a3hukZmfGtUvHEfnUnG52NRqXIgibczr065DdD+3H1pDUyk2mNBy7qum0AhRiDEzhh8q2lGeZZLETOzrWyu6vaQ5zJ+jRXKYWybN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829864; c=relaxed/simple;
	bh=/gb6hHMRi2scXJ1KawQoJVrIEQhpWZ8kHOHqwWrhhUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkWKOccJmGL1zmsH2bIt6BuGbGB7JIV6chAtevzz0fA206avBQsPxhNXMZA3+oNhdsZw1RSMkwRrmsR0ws954purln0reDCfsfDbcLQI6GIu4pZlBITtoFZOgl0wbaHliAAeQjoSwIgFWQJwmNAfPNynFCHbQAkah/oVtO6xJRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjJQPO2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB301C4AF07;
	Mon, 22 Apr 2024 23:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713829864;
	bh=/gb6hHMRi2scXJ1KawQoJVrIEQhpWZ8kHOHqwWrhhUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UjJQPO2XzvpcbqQdiM0AGkhh7E/GNov2kVF0a9TnTceyfsz03lDC2qhyTBs8Ku8Hu
	 nbgCrZFj66GFiDjraBjwLilNaKdnNnEqexqPf82/B5L1cicLtDyNV68VLI/8EbHBF8
	 n26lodhOz2fJ//UszKOF4gUOi4Trl3QT+hJZR3o/7qYPfj2Rz+HGPX9kYFyZzct+aJ
	 Z3NY6SHCjRAfRHLvK4iezkqWdAY5+rhGZC6Lh0eO6VJmD6ZYaOwkQ/dl72m62zP2LC
	 5JZiy9Le+udxDqeFwGWtQipz7XY9ANkRMHJCOTFpd4MFtXm1Rx4wV9851p97d5PJ7J
	 rd7kgZ8YdANcg==
Date: Mon, 22 Apr 2024 19:12:21 -0400
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: Patch "configs/hardening: Fix disabling UBSAN configurations"
 has been added to the 6.8-stable tree
Message-ID: <Zibu1T0d8IEuf0UQ@sashalap>
References: <20240421171119.1444407-1-sashal@kernel.org>
 <20240422185433.GA10996@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240422185433.GA10996@dev-arch.thelio-3990X>

On Mon, Apr 22, 2024 at 11:54:33AM -0700, Nathan Chancellor wrote:
>On Sun, Apr 21, 2024 at 01:11:19PM -0400, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     configs/hardening: Fix disabling UBSAN configurations
>>
>> to the 6.8-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      configs-hardening-fix-disabling-ubsan-configurations.patch
>> and it can be found in the queue-6.8 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>>
>> commit a54fba0bb1f52707b423c908e153d6429d08db58
>> Author: Nathan Chancellor <nathan@kernel.org>
>> Date:   Thu Apr 11 11:11:06 2024 -0700
>>
>>     configs/hardening: Fix disabling UBSAN configurations
>>
>>     [ Upstream commit e048d668f2969cf2b76e0fa21882a1b3bb323eca ]
>
>While I think backporting this makes sense, I don't know that
>backporting 918327e9b7ff ("ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL") to
>resolve the conflict with 6.8 is entirely necessary (or beneficial, I
>don't know how Kees feels about it though). I've attached a version that
>applies cleanly to 6.8, in case it is desirable.

I usually wouldn't do it, but 918327e9b7ff ("ubsan: Remove
CONFIG_UBSAN_SANITIZE_ALL") indicated that it's mostly a noop rather
than a change in behavior for existing config files.

-- 
Thanks,
Sasha

