Return-Path: <stable+bounces-76938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A8197F1BA
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 22:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA0CB20F83
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 20:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F88DDA8;
	Mon, 23 Sep 2024 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMsxwI8h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED74A1C3D
	for <stable@vger.kernel.org>; Mon, 23 Sep 2024 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727123967; cv=none; b=MiXuT0V48uYYC7B6stbOMJQsetd9AfYCG8JC11xqRTXxLmgNvStHqSBUzdQlhJ2Gq1E1XZB2HYCSdnG4kB2+90LX7GgaEv0NAE/2W/wVzoXXQI4BonN1OwIMvTZ3Iwu31H9tIIEjht0ffDZy3sCo6sV2hUZv3Mw2XP/VcoyULec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727123967; c=relaxed/simple;
	bh=Vok+nUD9jwQiUS6fQwWSLCfiD8EF+9DguVhUw6Hibh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlXNL3FKfLfoYuOuYyi2surQCDqDw4x4/mD9ACS+6e347RaXLv0iHV6U1XYMl+wslGEG9m7Ytk7Y6VnOZuhdGb1IDPxuXZk1E2FCm++K/sEQBeLnd8bT1GcD3QMsNikhBOGQ65CP/w17dZcMf1v4lCDkpKkH6Jzm1X+fF3dIDUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMsxwI8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31373C4CEC4;
	Mon, 23 Sep 2024 20:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727123965;
	bh=Vok+nUD9jwQiUS6fQwWSLCfiD8EF+9DguVhUw6Hibh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rMsxwI8h9blXT4p6/Mi7BdfxaKLTxBHcbzw4v73zDiFVkNphi71Nh353lPJ1Wp/nT
	 Qt6V1peYs2URxrTuIGPxQzinlgNSHDKy011v9mvO87/eqb2LUydIK5UV6Aq08bQ+KQ
	 /HTr+4KwFn5BPtp2fFNn/mbJ4zf3/pyOVP+oLHSyJxU1ddyddlxSdsiWkIlC2h6A08
	 zWBqY0sG3ecUhsk54hQavuUUOKh6gjOU6cdXDntY2GlG9XG6AUiTRnA+sGYnPO6YgU
	 5vGsIFBlHZW7xImYi5lhHGknncCcR3fKzdvDhou7zfA1XkNGeylRzEpEc7uNrEJCui
	 eydU9DcytEuxg==
Date: Mon, 23 Sep 2024 13:56:43 -0400
From: Sasha Levin <sashal@kernel.org>
To: Pascal Ernster <git@hardfalcon.net>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Patch "ASoC: SOF: mediatek: Add missing board compatible" has
 been added to the 6.10-stable tree
Message-ID: <ZvGr21XDAVwnnAlt@sashalap>
References: <20240919193644.756037-1-sashalkernel!org>
 <178b4702-101e-4ca4-856a-c9fd5401670a@hardfalcon.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <178b4702-101e-4ca4-856a-c9fd5401670a@hardfalcon.net>

On Mon, Sep 23, 2024 at 11:37:10AM +0200, Pascal Ernster wrote:
>[2024-09-19 21:36] Sasha Levin:
>>This is a note to let you know that I've just added the patch titled
>>
>>     ASoC: SOF: mediatek: Add missing board compatible
>>
>>to the 6.10-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>>The filename of the patch is:
>>      asoc-sof-mediatek-add-missing-board-compatible.patch
>>and it can be found in the queue-6.10 subdirectory.
>>
>>If you, or anyone else, feels it should not be added to the stable tree,
>>please let <stable@vger.kernel.org> know about it.
>
>
>Hi Sasha,
>
>
>it seems that in your commits to the stable-queue repo on 2024-09-19 
>around 15:36 -0400 / 19:36 UTC, every patch was added twice. This 
>affects all supported stable version branches from 6.10 down to 4.19 
>(a single commit per version branch):
>
>https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=19260ab5db68912b2983aecb3a5e778a908e4a30
>
>https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=f95efa9ab525da0bfaa852bfd27ed453c1bde67e
>
>https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=e9452f2ddd7affa8424fcd7cbc8816d92a74bd70
>
>https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=678cff8b6a095767aee1c6b750ccd10362bcbe82
>
>https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=0f5b9efe8e5fcd26d35af38d43a459a99b648c67
>
>https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=0c554a1406f2ce8c4d5357fc474af50857cead46
>
>https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=8ce8b1c9dcf3f5625be3a6a4afd5815c55c0ea49

You're right, fixed now.

I blame jetlag...

Thanks!

-- 
Thanks,
Sasha

