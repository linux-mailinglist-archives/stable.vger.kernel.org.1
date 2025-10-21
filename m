Return-Path: <stable+bounces-188848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F405CBF8FBA
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 23:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD7204E2E68
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCFA23EA9B;
	Tue, 21 Oct 2025 21:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="SYy35YpB"
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A9241665
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761083592; cv=none; b=bAEvhxX0VIc+KoXO3tR0HucwkzwZArIwbLkwklNJznlDYPJXjJOLMkEfaEAmUnzDghT0nhOVBdd0WFrdqLmBz+SSiUbnNnDAvDdMs7aknqFTw26mY4q77vuMhvv61LdJTl4OuyKxpEEnwcSr/8NDK376+M8Q3vxBROUTaFoqGVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761083592; c=relaxed/simple;
	bh=l9ZYVX95LGhTdGY/AdLGKCqXypgRReYL1oZfjL+RzdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gzmy/X8SO3poWEf9HEwoLBRgA4vKOp39x5DdohS7FR4mDFYzJ/vyp5Bcc5vlsgIABx0wtkk2OtXXXEagp4Y/p/q1U+W1mIbJ1rM4i+860duUfwu7yk24TOEG72b7/MQMlFrstVk1GdcBPrKuBNTTIqjdnuJnU2LQCkpugeiNnLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=SYy35YpB; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1761083587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7UvSLVPJoNzvzJqaHF65H3yaU3SzqsscVV2EXHW5Z0=;
	b=SYy35YpB11zkMH3EaoQpJJhUsMUevz1aTsstv92o2VBOrVZoWCpXf8KwlG3096Gm3d0zBx
	27KGGXtVymAy9XCQ==
Message-ID: <c5038e5a-ebb1-464f-9b79-905168ac7e44@hardfalcon.net>
Date: Tue, 21 Oct 2025 23:53:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Patch "PM: hibernate: Add pm_hibernation_mode_is_suspend()" has
 been added to the 6.17-stable tree
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
References: <2025102032-crescent-acuteness-5060 () gregkh>
 <2745b827-b831-4964-8fc5-368f7446d73e@hardfalcon.net>
 <8c4d1326-512c-4b98-bac0-aa207b54aa2a@kernel.org>
 <19c7ba58-7300-4e10-bd81-367354f826db@hardfalcon.net>
 <1f15260b-684e-4b8c-807f-244bbfd31f1c@kernel.org>
 <edffeaca-e52a-4ecc-b788-3120e11bbef2@kernel.org>
Content-Language: en-US, de-DE, en-US-large
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <edffeaca-e52a-4ecc-b788-3120e11bbef2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[2025-10-21 23:34] Mario Limonciello (AMD) (kernel.org):
> On 10/21/2025 4:19 PM, Mario Limonciello (AMD) (kernel.org) wrote:
>> It looks to me that you have CONFIG_HIBERNATE_CALLBACKS set but not CONFIG_HIBERNATION set.
>>
>> How does this happen?  HIBERNATE_CALLBACKS is hidden, and it's only selected by CONFIG_HIBERNATE.

Excerpt from "make menuconfig":

> │ Symbol: HIBERNATE_CALLBACKS [=y]
> │ Type  : bool
> │ Defined at kernel/power/Kconfig:35
> │ Selected by [y]:
> │   - XEN_SAVE_RESTORE [=y] && HYPERVISOR_GUEST [=y] && XEN [=y]
> │ Selected by [n]:
> │   - HIBERNATION [=n] && SWAP [=y] && ARCH_HIBERNATION_POSSIBLE [=y]


>> The fix for now for you is to either turn off CONFIG_HIBERNATE_CALLBACKS or turn on CONFIG_HIBERNATION.
> 
> Alternatively does picking https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bbfe987c5a2854705393ad79813074e5eadcbde6 help your issue?


Thanks for the hint! :)

I'll give that patch a try, but compiling will take a while.


Regards
Pascal

