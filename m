Return-Path: <stable+bounces-163388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58914B0A934
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 19:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80911C47145
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 17:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773992E6D2C;
	Fri, 18 Jul 2025 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQGamUG3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327342DEA74;
	Fri, 18 Jul 2025 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858813; cv=none; b=EkMAKu2sia3zubLKzf6s5c0bnIknvyQ5pbyg0zKD00u6GdEK+RG18A5jrROH4Ef7Z7TdaCiJZJzaU9qYq4TCiikfLNXgkCBxCN84eM0O210nmfGYckjLzqNORVxKsNve3yphnmot0h0SAzuj7aAVjm6DQej+zV+K81aRKxN1qRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858813; c=relaxed/simple;
	bh=2pMGWRUOR5c7ZDdNY06BPXHKdFbDc8dujXWYjj01bJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIITH1apfe9QUI9lpbovxgANUgsYJ9x7ZY+EIUl9VZS+coWEaSzNQe+QBKPpY1/jhtPJaji+CZrWynUF6TIr/EvBg9dgV7hiWnAwb8MHsjAFXcKye4Bkrcw4I3RvcsjfWAJNMN12/iMxxd+PpDq/FwU2SVZmFDOPU5Jm10Tg0Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQGamUG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06757C4CEEB;
	Fri, 18 Jul 2025 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752858812;
	bh=2pMGWRUOR5c7ZDdNY06BPXHKdFbDc8dujXWYjj01bJw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mQGamUG3MbPPT3I1fdY9Esh2CwwC9tagkypvGkQlqv0/Vc/1oVyZyY0CqQGYCIggq
	 fQS/4Hg4dFpwa7v6OTh0V2mhoq6AUM1Z8WuFOCey4/CC1pRu2Mtuw5MrUoVOh9e6rH
	 D15hgvG2aPdwnAWfkJcG8VTRmtWmBErgGe4Fyvq6td77p5j5zaAVeoL4dhOzvtdH7t
	 ML06TOWq18T5fWrwrXWFUdiCbagnZ/8uEKz0r1Wugg7Hcc+L3NDF4zPqRIL8LcbDaT
	 3+HwpqWSGUBz2wzuYphpJUA7YKXTzaQHsA3/WX2HdzU5Qx+2vloxgySMKR5kET9lZd
	 lAw6rTVHS5T0Q==
Message-ID: <46de4f2a-8836-42cd-a621-ae3e782bf253@kernel.org>
Date: Fri, 18 Jul 2025 12:13:30 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/amd/display: backlight brightness set to 0 at
 amdgpu initialization
To: Lauri Tirkkonen <lauri@hacktheplanet.fi>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Wayne Lin <wayne.lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <aHn33vgj8bM4s073@hacktheplanet.fi>
 <d92458bf-fc2b-47bf-b664-9609a3978646@kernel.org>
 <aHpb4ZTZ5FoOBUrZ@hacktheplanet.fi>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aHpb4ZTZ5FoOBUrZ@hacktheplanet.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/2025 9:36 AM, Lauri Tirkkonen wrote:
> On Fri, Jul 18 2025 08:10:06 -0500, Mario Limonciello wrote:
>> Do you by chance have an OLED panel?  I believe what's going on is that
>> userspace is writing zero or near zero and on OLED panels with older kernels
>> this means non-visible.
> 
> Yes, this is an OLED panel. But I don't believe it's userspace writing
> anything at this point in the boot; before the bisected commit,
> brightness was set to 32 (out of max 255) on this hardware when I
> checked from the initramfs rescue shell. At the bisected commit, it's 0
> (out of max 255).
> 
>> There is another commit that fixes the behavior that is probably missing.
> 
> Which commit is that? It's not in 6.15.7?
> 

https://github.com/torvalds/linux/commit/39d81457ad3417a98ac826161f9ca0e642677661

No; it's not currently backported.  Assuming it helps your issue I think 
it's a good argument to backport.

