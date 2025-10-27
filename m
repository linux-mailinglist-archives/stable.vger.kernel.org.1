Return-Path: <stable+bounces-190034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C61C0F2E2
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 17:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 163094F25F9
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D0D30DD2A;
	Mon, 27 Oct 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ajGTKZTt"
X-Original-To: stable@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C518A30EF67;
	Mon, 27 Oct 2025 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581202; cv=none; b=uO2xf2Jk9pXvS0llNhqL37eYz4bGDahHkfUVnH30DVV8MA79uZIORiGhORn7LPV7TKvz2G+dIXmxI30UZSepH92b7o9hfJcf1CAJvzoeeax5BPjJt+GsWRqaq8PKSgRHGeT9arwMPeA1XkXphkzAHLVz7aViV+OZMnasnsgbaQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581202; c=relaxed/simple;
	bh=U7hGCQMZzCKM4zX96RoFePsPI76AOR86oQ82PJVm/Xw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aVIi3ATMoFeYlmOH/doz2mTHAVC0ltgiyNVfDa1B3p15MM79MyvhpCRJCm5vrQt83/QNTWwuZNyO6S4jvpQsu7di4OK1kbGYBVCd47gJclCsiuo2Hca8X2aTAAwzBUy9yaJuz1vtE5drB4srRH0tAWkiypC91CKYD/GZR741Mws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ajGTKZTt; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5085840B18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761581194; bh=vQOKca11sHg2oiUoYPo4YwicPuO1vRZcUgu5szp3BLk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ajGTKZTt1t4ord0I/77m/rA+UjQ15SG6KQSDiCEHXRkpM/M5Zaq1DHaJSJRYzVoxF
	 bBCRLZCzY+kg6KqPSbrA408oIODkZLNBoVF5eInaqasgjVcZSP2cZ0VPLv4CTPptjg
	 XgLtfA0JxmMXUc+7dMhRjFdRy4LjxMrKrxIgGtS26J7MoGtyv/BE9LLi+ocqNHZZQZ
	 BWyRHinzHt0W0t0kli7vCp5iHnafHidJa2zVQLGi9RWZDPKXnqsu1Bpjk8+Ndkw22l
	 tN8IYpYgzXfPf18IQKrPradVMfVaCQPiVwjI+LVjNr6NCMkL1/wkcDUz8b6GqyCnae
	 z6seuczk7pn2w==
Received: from localhost (c-73-14-55-248.hsd1.co.comcast.net [73.14.55.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5085840B18;
	Mon, 27 Oct 2025 16:06:34 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Salvatore Bonaccorso <carnil@debian.org>, Andreas Radke
 <andreas.radke@mailbox.org>
Cc: stable <stable@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, Zhixu Liu
 <zhixu.liu@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: Please backport commit 00d95fcc4dee ("docs: kdoc: handle the
 obsolescensce of docutils.ErrorString()") to v6.17.y
In-Reply-To: <aP4amn4YQDnzBBCU@eldamar.lan>
References: <aPUCTJx5uepKVuM9@eldamar.lan>
 <DDS2XJZB0ECJ.N4LNABSIJHAJ@mailbox.org> <aP4amn4YQDnzBBCU@eldamar.lan>
Date: Mon, 27 Oct 2025 10:06:33 -0600
Message-ID: <87wm4gpbw6.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Salvatore Bonaccorso <carnil@debian.org> writes:

> Hi,
>
> On Sun, Oct 26, 2025 at 08:36:00AM +0100, Andreas Radke wrote:
>> For kernel 6.12 there's just one more place required to add the fix:
>> 
>> --- a/Documentation/sphinx/kernel_abi.py        2025-10-23 16:20:48.000000000 +0200
>> +++ b/Documentation/sphinx/kernel_abi.py.new    2025-10-26 08:08:33.168985951 +0100
>> @@ -42,9 +42,11 @@
>>  from docutils import nodes, statemachine
>>  from docutils.statemachine import ViewList
>>  from docutils.parsers.rst import directives, Directive
>> -from docutils.utils.error_reporting import ErrorString
>>  from sphinx.util.docutils import switch_source_input
>> 
>> +def ErrorString(exc):  # Shamelessly stolen from docutils
>> +    return f'{exc.__class__.__name}: {exc}'
>> +
>>  __version__  = '1.0'
>> 
>>  def setup(app):
>
> Yes this is why I asked Jonathan, how to handle backports to older
> series, if it is wanted to pick specifically as well faccc0ec64e1
> ("docs: sphinx/kernel_abi: adjust coding style") or a partial backport
> of it, or do a 6.12.y backport of 00d95fcc4dee with additional
> changes (like you pointed out).
>
> I'm just not sure what is preferred here. 

I'm not sure it matters that much...the additional change suggested by
Andreas seems fine.  It's just a backport, and it shouldn't break
anything, so doesn't seem worth a lot of worry.

Thanks,

jon

