Return-Path: <stable+bounces-165517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3958DB161C6
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 15:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94FFF18C7052
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 13:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D144A2C324A;
	Wed, 30 Jul 2025 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYtzMhfk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912BA6DCE1
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883407; cv=none; b=WwQRAShb7kXgn8syAAMqwRe8lIAvKOZMUnlEscX/FPN3Zq3nCKU/pjoaNE7GQbSDwPFZhZI8ZWzi0b3qeIXmH45Wi60fhntLJO6uxi9eSCjW4fXnB+cyv8XIxbfreDBFjYV0HZASrcQAeInSqEc3/8py6OVqe7nLtuBASpELLgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883407; c=relaxed/simple;
	bh=67Fwnrt2OjCambcH3HhvufQwngw6pKpN4OByyI2lXzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikS+JaW/ongDijNYEfBsQ8z518sNWmdVijUCFIPoLzcTTT+lawwBDuk2U70x8doH7PsYXkMvQBZHkZxmZ1okXxbTAd+koyfsdV2Po/Ab7eUU6yP32vvLZJXPsbXFDEXTBuxyU9puky9NaZrrHt2wGzlwNgRekzzOwnfmHdyhcXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYtzMhfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC8AC4CEE3;
	Wed, 30 Jul 2025 13:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753883407;
	bh=67Fwnrt2OjCambcH3HhvufQwngw6pKpN4OByyI2lXzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cYtzMhfkOaf9yZWFIgtIDHVOttgLh/YRsIIvSs6yyIx3hOCQ1THvEf9xbmzuezz3Y
	 ykcqmkOSvq3+D6nPqYf7si3eJ5fCTUyDKNQYXfS1ZwDDz9KzHG6SLECL1Cm11B+sqL
	 sZdhR+ymvMAKUM4DI4eC0fqc+Nm4xLXrd1pxtfppy3WuxhoU7I3wYlqgreV+KIvEqW
	 9Ho8BAeww/CDxsZwBPP+Rag1L4tQ3spFz8Db/9MgVryCZsBgQB1oNELdxoecCynpHy
	 UBLDVFxK4NJ14w844zhcLr9x6GmdD5YAAJFkurIw0U/zQGZI3eTQYuDf33ck+1NDra
	 XhIr7PKDANKgg==
Date: Wed, 30 Jul 2025 09:50:04 -0400
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	=?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH 6.6.y 5/6] i2c: stm32: fix the device used for the DMA map
Message-ID: <aIojDG3rheLDMVzC@lappy>
References: <2025072104-bacteria-resend-dcff@gregkh>
 <20250723001942.1010722-1-sashal@kernel.org>
 <20250723001942.1010722-5-sashal@kernel.org>
 <2025073007-swapping-upcountry-fd02@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025073007-swapping-upcountry-fd02@gregkh>

On Wed, Jul 30, 2025 at 11:03:34AM +0200, Greg KH wrote:
>On Tue, Jul 22, 2025 at 08:19:41PM -0400, Sasha Levin wrote:
>> From: Clément Le Goffic <clement.legoffic@foss.st.com>
>>
>> [ Upstream commit c870cbbd71fccda71d575f0acd4a8d2b7cd88861 ]
>>
>> If the DMA mapping failed, it produced an error log with the wrong
>> device name:
>> "stm32-dma3 40400000.dma-controller: rejecting DMA map of vmalloc memory"
>> Fix this issue by replacing the dev with the I2C dev.
>>
>> Fixes: bb8822cbbc53 ("i2c: i2c-stm32: Add generic DMA API")
>> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
>> Cc: <stable@vger.kernel.org> # v4.18+
>> Acked-by: Alain Volmat <alain.volmat@foss.st.com>
>> Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
>> Link: https://lore.kernel.org/r/20250704-i2c-upstream-v4-1-84a095a2c728@foss.st.com
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/i2c/busses/i2c-stm32.c   | 8 +++-----
>>  drivers/i2c/busses/i2c-stm32f7.c | 4 ++--
>>  2 files changed, 5 insertions(+), 7 deletions(-)
>
>This is already in 6.6.100, so are you sure you want it again?  :)
>
>Care to redo this series?

Looks like we raced on that one. I'l send out a v2.

-- 
Thanks,
Sasha

