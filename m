Return-Path: <stable+bounces-66393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D6394E34D
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 23:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C77A28101A
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5860158526;
	Sun, 11 Aug 2024 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPnUDQTc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF5779F4;
	Sun, 11 Aug 2024 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723411157; cv=none; b=TE+pAoRKidMGopTAoiGX6zSOoSQl9Kf/fRYTAjNXcmRMQ4+mieSQNUwp4kSHs7ZHTxRm9I6EW56Fe/MrexEV/4fei/LdljPkSGJhej5oroJKkhqNzBimQNSlUvnqadbpOkC86CXvM5n8CyJZcJj6tYXr+v70cW9pu+BJAsH9cZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723411157; c=relaxed/simple;
	bh=wfLRyFdY3r1ia41XHbgCg1yrPmMOPCYnC0tXla6Bmvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6Zgg3Rgp1Pesl9+bdA0TSRY15zbKp+EWnNwYDoPrsOuuCW5XsH0fBjvq4Xt4b0UAz8lqJW9DH9epHTQmD73HkbzUr/+VTIwJehdb8qFdrpPdd7dxCNDn1qSQloHQ9b/Wa8U+EI96guq8kcuTZKmnIgVJQ8xRstMgDimZq3MPYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPnUDQTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD8AC32786;
	Sun, 11 Aug 2024 21:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723411157;
	bh=wfLRyFdY3r1ia41XHbgCg1yrPmMOPCYnC0tXla6Bmvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPnUDQTcgHRw3rMwo1bD+w6dc5WgCT8Ww/WEaXrPBuNvlhgVdwntF+2lJIbml1urD
	 GQM3AHiBHbqZu2WOWT05RIavS/TUpXdvaEFNVkJe4TVqcGJvJTMCFKErlhlX8K6xu2
	 dEeHKLeIGlfNh8mKWeVgQtpUp86XyA9L1ORTqb4INqgmJgn6zkNhghJOWCrrHajKP8
	 9k9XceSVRMLN2MhBRGD+Frzut/imM7CTCxLEGJcGaJMece/PFNWiSz7GGxo+S35Z3o
	 vtyDNhl8MCVbVe2/c7hHQqI3pHOZBK6VNrADIhe5kvtMlM/L2L9OkVGOzKTJXqY3mQ
	 CrxL3KlsCIlPg==
Date: Sun, 11 Aug 2024 17:19:15 -0400
From: Sasha Levin <sashal@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	james.morse@arm.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Patch "irqchip/gic-v3: Don't return errors from
 gic_acpi_match_gicc()" has been added to the 6.10-stable tree
Message-ID: <Zrkq049NtrgLjQ0y@sashalap>
References: <20240811125745.1264050-1-sashal@kernel.org>
 <865xs626cz.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <865xs626cz.wl-maz@kernel.org>

On Sun, Aug 11, 2024 at 08:43:08PM +0100, Marc Zyngier wrote:
>On Sun, 11 Aug 2024 13:57:45 +0100,
>Sasha Levin <sashal@kernel.org> wrote:
>>
>> This is a note to let you know that I've just added the patch titled
>>
>>     irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()
>>
>> to the 6.10-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      irqchip-gic-v3-don-t-return-errors-from-gic_acpi_mat.patch
>> and it can be found in the queue-6.10 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>Why, oh why???
>
>Yesterday, you agreed *not* to merge this patch as:
>
>https://lore.kernel.org/r/Zrcuvkiol0PsKu0l@sashalap
>
>And yet you picked it up again?

Yes, technical error on my end: I dropped it from the wrong local
branches. Sorry.

-- 
Thanks,
Sasha

