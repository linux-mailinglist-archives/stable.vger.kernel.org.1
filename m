Return-Path: <stable+bounces-4632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC80804885
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 05:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5061F213FD
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6D6CA5F;
	Tue,  5 Dec 2023 04:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQ4stgLp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CC9D260
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 04:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A695BC433C7;
	Tue,  5 Dec 2023 04:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701750311;
	bh=Jsp797QrY43cmAXZZXSoXO4WVJz03OTlJ4dLJhsYhJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qQ4stgLpuvhbi+r5OKcn/+9iC63lI8H9UbpuHugQ/JarTchazINrKbpvg3ZEnJjRe
	 CRxaSRlRZql2gN9RAgSZ8xrL7Ob3hIMtMfUnifXPWyfFZc1jZMvtuMl27v5MvonY3Y
	 R1VCOFC32toDb6UM17K6774opzmDbvpMDNSMrdBeXHzxO0SeGVxcfcEWTilkbqA5N9
	 0a9bjS3CY+ubwQodOpG/aFv47I8bHBFq2ebX91gIu8f3AQqgbdAZzpe6IJv1pPCZbz
	 JGhRIKovbAZ9pnmn5QmUG4BXIIwuDCNI8dRLGzaIJkhR61K5u+ed0ChFW2KMvyyahN
	 2eL9WmvzTIrdw==
Date: Mon, 4 Dec 2023 23:25:08 -0500
From: Sasha Levin <sashal@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH AUTOSEL 6.6 15/32] debugfs: annotate debugfs handlers vs.
 removal with lockdep
Message-ID: <ZW6mJFCFIvEdrnoW@sashalap>
References: <20231204203317.2092321-1-sashal@kernel.org>
 <20231204203317.2092321-15-sashal@kernel.org>
 <1a7a8caa3fe9b4e3271239b86ebd24a41464b79f.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1a7a8caa3fe9b4e3271239b86ebd24a41464b79f.camel@sipsolutions.net>

On Mon, Dec 04, 2023 at 09:45:55PM +0100, Johannes Berg wrote:
>On Mon, 2023-12-04 at 20:32 +0000, Sasha Levin wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> [ Upstream commit f4acfcd4deb158b96595250cc332901b282d15b0 ]
>>
>> When you take a lock in a debugfs handler but also try
>> to remove the debugfs file under that lock, things can
>> deadlock since the removal has to wait for all users
>> to finish.
>>
>> Add lockdep annotations in debugfs_file_get()/_put()
>> to catch such issues.
>>
>
>This (and the previous patch) probably got picked up as dependencies for
>the locking things, but ... we reverted this.
>
>For 6.6, _maybe_ it's worth backporting this including the revert, but
>then I'd do that only when the revert landed to have them together. But
>then you should apply all the six patches listed below _and_ the revert,
>the set as here doesn't do anything useful.
>
>However ... given that debugfs is root-only, and you have to be
>reading/writing a file _while_ disconnecting and the file is removed,
>perhaps the whole thing isn't worth backporting at all.
>
>
>
>For 6.1 and earlier, I believe it's not needed at all, so please drop
>from there all of these:
>
> - debugfs: fix automount d_fsdata usage
> - debugfs: annotate debugfs handlers vs. removal with lockdep
> - debugfs: add API to allow debugfs operations cancellation
> - wifi: cfg80211: add locked debugfs wrappers
> - wifi: mac80211: use wiphy locked debugfs helpers for agg_status
> - wifi: mac80211: use wiphy locked debugfs for sdata/link
>
>
>I'd kind of think just dropping all of these completely makes more
>sense.

Will do, thanks!

-- 
Thanks,
Sasha

