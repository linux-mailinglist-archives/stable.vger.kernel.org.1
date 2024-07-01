Return-Path: <stable+bounces-56293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D355291EBBC
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 02:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 719B7B22164
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 00:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E481C27;
	Tue,  2 Jul 2024 00:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4YNstuF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D895A3D66;
	Tue,  2 Jul 2024 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719879502; cv=none; b=UFLakK8G7Vx7Ky7StUP6lxrAtJ0whtbtf/5g340fMpDpMhECgADqNGiVRbZq34J+5i0beMO4POc4WhCHJ7oIjhaFezjSpFaEmWv7ZyLOsgmQWCtSFgdIZRE1SNdh0qTT86QnSAaDkKloFHFGxHzHGKkCPWAOvWyRiyzrUZYkirc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719879502; c=relaxed/simple;
	bh=BCxrRHFz+mfS8zhZMqfybrYBeYMtp+Qos4XRuFQ2o6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhN6S1BQA0cIvzhoAf6JaaDmJD8sI7ChDhTgVePj1591fVI2rnCtqLqxN/vHPdTu0j6Kzm77ku++pN1od5L2Lecp4u4i2dAH0x9IqH6xFy8UIeZRwmgN2sfcmfpirzPhY0EzfKFub28VMAKtls7TcCTMvu1qCQ7Ax54ECLMkpuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4YNstuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269E7C116B1;
	Tue,  2 Jul 2024 00:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719879502;
	bh=BCxrRHFz+mfS8zhZMqfybrYBeYMtp+Qos4XRuFQ2o6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A4YNstuFU+PSWqwR82hySMNfRaw2y0Mll7Z2m1Z6+soZ3Qv0Qi7AUN/7FbeyP+/TM
	 4giuMYniZm7FkFTN2gwdFR5W0l8jPghytVUk9wPmpkWjnDtGRraWbFB/d61Mx/mDIe
	 F2au1zgUlQKX+++I9TkclgqVF12lzsj3M0aVZa8C+aOKjLmeLckEQg2aVeoZevrrgB
	 8fsYIPrYMWYTD+4tE81/SKY9qhiXxcq+JyjD9NqyuC6TuU3dJoZlmNIrSO3y0gF9+Q
	 1hAlBDBNzA0XbEogPnajWfMN9bk31tZd12B9wKE8xK9Ky1/Zz8YlWHGppqRKQ0Ukde
	 HcfNXqUWRESiw==
Date: Mon, 1 Jul 2024 17:35:33 -0400
From: Sasha Levin <sashal@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>
Subject: Re: Patch "parisc: use generic sys_fanotify_mark implementation" has
 been added to the 6.1-stable tree
Message-ID: <ZoMhJesfCtolHBC5@sashalap>
References: <20240701001033.2919894-1-sashal@kernel.org>
 <ebe6268b-3ea9-4490-8b12-09c200bb2e4a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ebe6268b-3ea9-4490-8b12-09c200bb2e4a@app.fastmail.com>

On Mon, Jul 01, 2024 at 07:16:26AM +0200, Arnd Bergmann wrote:
>On Mon, Jul 1, 2024, at 02:10, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     parisc: use generic sys_fanotify_mark implementation
>>
>> to the 6.1-stable tree which can be found at:
>>
>> http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      parisc-use-generic-sys_fanotify_mark-implementation.patch
>> and it can be found in the queue-6.1 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>This patch caused a build time regression, the fix is still on
>the way into mainline, I plan to send a pull request today:
>
>https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?h=asm-generic

For the record, the fix was merged into the relevant branches earlier
today.

-- 
Thanks,
Sasha

