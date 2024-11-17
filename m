Return-Path: <stable+bounces-93742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4559D0649
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 22:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BFD2821E8
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA6E1DDA33;
	Sun, 17 Nov 2024 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IR+MJL4X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6A1D89F1
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731878959; cv=none; b=pz775c6/ro6rRIHCZvQvAwrlFjel7ciwrNDTRJAMnuX5N2BNNThm9ASgf7wir/0RaUdboflLQux/UmgYcnlCwf0M5oxN162OAvc5rH/wlQ9GyHVSHEHaICf1ihnSXJZkIgrrepztDCeQYUSp2uu5efOOsUd2kOUCvVRk5ZnSNmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731878959; c=relaxed/simple;
	bh=FzIzN85AkYYpU4cSosOy8FkaoJQqSG/ZcywNbtP4moE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZukYy6JlD06I6Ncss+4/sEWeGSu+lADaoMTxsY+hOCxoGnZxmckwdmyR4Eps/eAkGR0PY4lZ7qBw0tA0z1YHtOV0V4kxRT8Vtwo7a0duk4IjcYBe61LkTHrX2BxbaS9+Gk/ShEKvW5ZekJSDnoJOVkASCe50ddDS+o0Vo0cjvE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IR+MJL4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A42AC4CECD;
	Sun, 17 Nov 2024 21:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731878958;
	bh=FzIzN85AkYYpU4cSosOy8FkaoJQqSG/ZcywNbtP4moE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IR+MJL4X0dxSRmWnh9bGaM1ZhV8TPVB+QozJvf2Sa3Z0CzeohREbSoIbntsFpg13K
	 e7BmFqa/MuYFcQK+MeO4tXqI/OhYR1Go3Y5sWg/Umd9QibAhX643iTmaa4XsfqZXpR
	 +OPCgxm/hhTuHOfYwCoVtevUQau1D8ZDjvjTTLkW8FSkHYNJGmax3UXicYLmHb2lKP
	 BlM3dp4FZSXxsh3yVG2OYoloHuT/09kcl+WEiOhA+v+rS3nMzgH6og9jZVdufBkdhe
	 aZH9EYH70WIjuyA2ZpcEi3atr46QpdyGy3zD5+7udushqqzs56nQ4zDU6KQIQMbP6Y
	 ozomkrS18FrMw==
Message-ID: <64e3126b-0c43-480b-b7b2-80b95a27dc94@kernel.org>
Date: Sun, 17 Nov 2024 15:29:12 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Additional panel replay fixes for 6.11
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, james.dutton@gmail.com
References: <62a02199-5213-4a6f-b2d4-7898a26344c6@kernel.org>
 <2024111725-grooving-pretended-7b61@gregkh>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <2024111725-grooving-pretended-7b61@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/17/24 14:21, Greg KH wrote:
> On Sun, Nov 17, 2024 at 09:20:29AM -0600, Mario Limonciello wrote:
>> Hi,
>>
>> A few more panel replay fixes have been made for issues reported on 6.11.y
>>
>> commit 17e68f89132b ("drm/amd/display: Run idle optimizations at end of
>> vblank handler")
>> commit b8d9d5fef4915 ("drm/amd/display: Change some variable name of psr")
>> commit bd8a957661743 ("drm/amd/display: Fix Panel Replay not update screen
>> correctly")
>>
>> There were tested by
>> Tested-By: James Courtier-Dutton <james.dutton@gmail.com>
>> on 6.11.8 base.
> 
> 2 were already tagged for stable, I would have gotten to them this week.
> All now queued up, thanks.
> 
> greg k-h

Thanks! I knew at least one was tagged, but when I was testing without 
the whole series I couldn't apply it alone.

So I figured I should preempt the failure emails since I knew this 
series was coming and important.  Hopefully one less failure email :)

