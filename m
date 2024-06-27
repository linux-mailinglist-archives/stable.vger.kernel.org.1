Return-Path: <stable+bounces-55986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C1591AF7B
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 21:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7641B1C21D6B
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 19:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9974019ADBC;
	Thu, 27 Jun 2024 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og2Tmu+r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C011E4A4;
	Thu, 27 Jun 2024 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719515515; cv=none; b=AStrcmumcUiH7YfsL1T50qPFq9RMtTAW7db8mNqjPzTLknyHECNj76MxLvqAAMhi+MS3I3ofHtW8N5zshMvyl4Hvz2YQ5N5botAGM97cat2MhsbjHPtNSU2UWRl4SRMYWDUqZCCTt3BmQFhghjryS53Vg22MbeSQhJ33conS7DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719515515; c=relaxed/simple;
	bh=RxfMVXVfttfnJX6U/j+G9gHbH5kPU34aMzIpkJ65OJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2KExbE+RsebmLMtLteYFPCSKnzromzwCPupYtRbcLMcnN50MaUaZ9AyVIx/v4wjNSN38tW4MI2pOjfT4+DPIwCKWeJ91gjfHUw6RTp6RKW/dBRdzXxN75/Z9Mo2JQfORlowqkG2i7Lxj7s0uPdsEfxouUSNodFpd41IwXw8utE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og2Tmu+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED18C2BBFC;
	Thu, 27 Jun 2024 19:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719515515;
	bh=RxfMVXVfttfnJX6U/j+G9gHbH5kPU34aMzIpkJ65OJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=og2Tmu+rtWRXytnScfhXfY2wR5UUEjEJxmZPOT6OwcnucRU9ZEUUz9HNzUQIMqGhS
	 IrNvTGWN8uu4KUUIHhUkJ0mECiA3Gqo+FP3c2qR+ooU3ABgJMtvohT0OdK/qwFt+4Y
	 hIqo6wKRGy2qdo9m4RFM38TNjLv6moiEvUeCVYDtuv13vg3LVcMn/SYswpzK3VvXxa
	 Q69ENDhcMS+hUqzvNSvHleW0LWCCU8yFp+5gadoSYU1CR3o1wigJy+XNlMGfUGgL+9
	 McJjRpShLNbkAWxkZ/8MzNdDkz5qGoG8MvoBi4TewLd77e/Z37UOgHUpu9xCuV0LOO
	 QaehqzIdn9n4w==
Date: Thu, 27 Jun 2024 15:11:53 -0400
From: Sasha Levin <sashal@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Patch "scsi: mpt3sas: Add ioc_<level> logging macros" has been
 added to the 4.19-stable tree
Message-ID: <Zn25eTIrGAKneEm_@sashalap>
References: <20240626190750.2060180-1-sashal@kernel.org>
 <58432885e0b4b5c781be6a83787edd4779a41aad.camel@perches.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <58432885e0b4b5c781be6a83787edd4779a41aad.camel@perches.com>

On Wed, Jun 26, 2024 at 12:25:35PM -0700, Joe Perches wrote:
>On Wed, 2024-06-26 at 15:07 -0400, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     scsi: mpt3sas: Add ioc_<level> logging macros
>>
>> to the 4.19-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      scsi-mpt3sas-add-ioc_-level-logging-macros.patch
>> and it can be found in the queue-4.19 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>[]
>>    Stable-dep-of: 4254dfeda82f ("scsi: mpt3sas: Avoid test/set_bit() operating in non-allocated memory")
>
>Huh?  This doesn't make sense as far as I can tell.

Heh, the dependency chain looks like this:

4254dfeda82f ("scsi: mpt3sas: Avoid test/set_bit() operating in non-allocated memory")
ffedeae1fa54 ("scsi: mpt3sas: Gracefully handle online firmware update")
645a20c6821c ("scsi: mpt3sas: Add ioc_<level> logging macros")

I got rid of the patch in middle, not realizing I could get rid of
this one too.

-- 
Thanks,
Sasha

