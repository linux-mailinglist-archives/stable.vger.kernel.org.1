Return-Path: <stable+bounces-36080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB1F899AFB
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 12:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 816B1B21B78
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 10:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCE9537E9;
	Fri,  5 Apr 2024 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="MCpDgc7N"
X-Original-To: stable@vger.kernel.org
Received: from email.studentenwerk.mhn.de (dresden.studentenwerk.mhn.de [141.84.225.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6A9535B6
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 10:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.84.225.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313320; cv=none; b=lsHKsFzMjSQ7cHeTjLrCNLOhTHqDdUzPBBHuD1L+HI9DKVf6IR3kzAPFAjH0meyPbPy0V91y+aoRq5L33r1UztzhRih0iEA0Dd9tqnchB/5cVW6WtestGBItc2j+V0kv/bnC1Q+wA4IJHws3MP/uR2dBSq5o0a7nENyAEG1NdfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313320; c=relaxed/simple;
	bh=aFdXO2Aju7ThYT9XIc/lLpF+FHXofJPmOCibYp9gj2c=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=b94CfK0oUBeU43WgXwqZ6eDtfxqwB/UJePzwqaabON9iWP/P/1WR9khHD84fBgKHwZvUam+f4FjCOSV5Exo8jfBsVy8qb1tUGd7dEM7Zbh+RF3D08uBY78azVDNxhm/qnDz/F+BKwbmH/GvGrO54siuBP+MtmCC8IgIRBfTnPcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de; spf=none smtp.mailfrom=stwm.de; dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b=MCpDgc7N; arc=none smtp.client-ip=141.84.225.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=stwm.de
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
	by email.studentenwerk.mhn.de (Postfix) with ESMTPS id 4V9vy81pFtzRhTB;
	Fri,  5 Apr 2024 12:35:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de; s=stwm-20170627;
	t=1712313312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLLO4pfXaKxhlN0Tw9DlvCKFMgjPfZ7S6MHkO3fx93w=;
	b=MCpDgc7NuIutG1yJE3XsUO387NuH6fGiWDPR+CWP2BhuR4qGVjb84mBtIqzCc2yfjcB3eP
	cMn5cDPEvfONEFyk0VsAx6EVNuF0/ZqLETJNznxXxyxoBhCd0P8iut/iWKH/d8bovVVZ9H
	SJ7kzMNfMxFknSAQ4hISrcdwkjLge94G981egPUF8k2AQfgfgPi/5Jw367xJfoZgvkbME9
	VtJYuOvXK4u2VnddnH9ILeMf8U7Z81x/CRK15JAj2XI6MAJG+XM0HZGmdd1IE52rTsGsmL
	X75dYWK8D9MsgSrs2MJIM9DpCzYHZKM2/rVDl8quJcifu9qoY88oFXc6RUjfug==
Received: from roundcube.studentenwerk.mhn.de (roundcube.studentenwerk.mhn.de [10.148.7.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailhub.studentenwerk.mhn.de (Postfix) with ESMTPS id 4V9vy81fhlzHnGf;
	Fri,  5 Apr 2024 12:35:12 +0200 (CEST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 05 Apr 2024 12:35:12 +0200
From: Wolfgang Walter <linux@stwm.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org
Subject: Re: stable v6.6.24 regression: boot fails: bisected to "x86/mpparse:
 Register APIC address only once"
In-Reply-To: <2024040445-promotion-lumpiness-c6c8@gregkh>
References: <23da7f59519df267035b204622d32770@stwm.de>
 <2024040445-promotion-lumpiness-c6c8@gregkh>
Message-ID: <899b7c1419a064a2b721b78eade06659@stwm.de>
X-Sender: linux@stwm.de
Organization: =?UTF-8?Q?Studierendenwerk_M=C3=BCnchen_Oberbayern?=
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Am 2024-04-04 17:57, schrieb Greg Kroah-Hartman:
> On Thu, Apr 04, 2024 at 02:07:11PM +0200, Wolfgang Walter wrote:
>> Hello,
>> 
>> after upgrading to v6.6.24 from v6.6.23 some old boxes (i686; Intel 
>> Celeron
>> M) stop to boot:
>> 
>> They hang after:
>> 
>> Decompressing Linux... Parsing ELF... No relocation needed... done.
>> Booting the kernel (entry_offset: 0x00000000).
>> 
>> After some minutes they reboot.
>> 
>> I bisected this down to
>> 
>> commit bebb5af001dc6cb4f505bb21c4d5e2efbdc112e2
>> Author: Thomas Gleixner <tglx@linutronix.de>
>> Date:   Fri Mar 22 19:56:39 2024 +0100
>> 
>>     x86/mpparse: Register APIC address only once
>> 
>>     [ Upstream commit f2208aa12c27bfada3c15c550c03ca81d42dcac2 ]
>> 
>>     The APIC address is registered twice. First during the early 
>> detection
>> and
>>     afterwards when actually scanning the table for APIC IDs. The APIC 
>> and
>>     topology core warn about the second attempt.
>> 
>>     Restrict it to the early detection call.
>> 
>>     Fixes: 81287ad65da5 ("x86/apic: Sanitize APIC address setup")
>>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>     Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>>     Tested-by: Guenter Roeck <linux@roeck-us.net>
>>     Link: 
>> https://lore.kernel.org/r/20240322185305.297774848@linutronix.de
>>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>> 
>> 
>> Reverting this commit in v6.6.24 solves the problem.
> 
> Is this also an issue in 6.9-rc1 or newer or 6.8.3 or newer?
> 

It is not an issue with 6.9-rc1. 6.9-rc1 just boots fine.

Regards,
-- 
Wolfgang Walter
Studierendenwerk München Oberbayern
Anstalt des öffentlichen Rechts

