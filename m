Return-Path: <stable+bounces-155207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4358AAE27EB
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165B417942F
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C0A1DB124;
	Sat, 21 Jun 2025 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CntZqTvE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC3878F3A;
	Sat, 21 Jun 2025 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750493449; cv=none; b=u14d+kgKQDm6gbfc/SjVfRPyINjat0KTspz209+ZgDBCQXfq5FwJRMtog+hPYM7eIeb/h46wYRigjRvI1IMkBvh1peksqIj8Pwr53tdon2jD1C6QnFGwjLn0qNSGVroSS1XKCzzrPbhViEuWgYgBJDWE2ScYU3Nrz0lAIKtgjHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750493449; c=relaxed/simple;
	bh=7bcPNxis9hQRoaQ3LDPJ9abd8u9MskKaXygRSa5BxYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Whmph2klaM2ha4evw5n2U7ArWYG8i3825j4tvHGEzH8UcZPwqV1FmSE6PhBue18F7W+ftZ/MnuKtD/cngPj1lk2jZ22VKsHdIe8KiGpMQmD8SzsrOtTTLqdy43gYwbequncjdgkFoxm/meEpEtO1/7+beHhGvzo20jVBN1jWqr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CntZqTvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2133C4CEE7;
	Sat, 21 Jun 2025 08:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750493448;
	bh=7bcPNxis9hQRoaQ3LDPJ9abd8u9MskKaXygRSa5BxYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CntZqTvEfXupMJAydV2Eze4joWTmhg2kDisOZH7PxuBETclD748HRZk9wnNi3r/zJ
	 xfIIIbqj36x/yGH/Oi3kSOTJWMCXCAQLrs8dCrvgHI7ACk3rC9nEvBGu7ql65Cx8m+
	 zfDWJVqUSCrGcS0HurGEb1qiel6QmrDtNa3Eg3asIu30h3DVjqKYpKC/6oPP119WFV
	 BZrHucr7JDq7As4cqE53yt1y9sV15VhVvYNfO24yc2/sAhc9ankAVn3QBL+z1n9/Wj
	 yS0UgCpwFESfsLYW1hglWUBRCasMzBkoVVtWE9Df7i237JQ9B2LiVI2BKboNuWeWsc
	 BWL+H7a6OYdDw==
Date: Sat, 21 Jun 2025 04:10:47 -0400
From: Sasha Levin <sashal@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	echaudro@redhat.com, Aaron Conole <aconole@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: Patch "openvswitch: Stricter validation for the userspace
 action" has been added to the 6.15-stable tree
Message-ID: <aFZpB3maNj3z2t18@lappy>
References: <20250620023232.2605858-1-sashal@kernel.org>
 <6d21ab64-88f9-4380-9e28-63700bddbe30@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6d21ab64-88f9-4380-9e28-63700bddbe30@ovn.org>

On Fri, Jun 20, 2025 at 10:04:44AM +0200, Ilya Maximets wrote:
>On 6/20/25 4:32 AM, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     openvswitch: Stricter validation for the userspace action
>>
>> to the 6.15-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      openvswitch-stricter-validation-for-the-userspace-ac.patch
>> and it can be found in the queue-6.15 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>FWIW, backporting of this change was previously discussed here:
>  https://lore.kernel.org/netdev/2025060520-slacking-swimmer-1b31@gregkh/
>
>With the conclusion to drop it as it's not a bug fix and hence there is
>no reason to backport it.

Dropped, thanks!

-- 
Thanks,
Sasha

