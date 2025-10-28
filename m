Return-Path: <stable+bounces-191551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EDBC170AF
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 22:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2351C634B5
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 21:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AC5355804;
	Tue, 28 Oct 2025 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="AgTgAoD1"
X-Original-To: stable@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E26355800;
	Tue, 28 Oct 2025 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686977; cv=none; b=jooqjWJ2ORqPhdqUZZ2+4NfxWhSjL7IX3wcB0i54H/2R9FfWJ5ruovFaSMNxeu851Q/Rdksj64jgXJUhbBJ28dgqbj7KQOetw6LwydxdhlxNHIGw3X53w8DypJ1P4SWDN5PUt/z09VcIn9NRbXKJsIsXbPJxWAWIkxZrioxvW4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686977; c=relaxed/simple;
	bh=2cRxgpIZZ3R1U1+fXcCGdHCMSEqlAZLjZTGagJ7WVyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tBX5l1ccykiQX1Q3qMnxOXBWXI7sYX+oM8VKPKenVnFtXVfmVRiyT3B+1OcRD9j/e6HbPUPd+MuIi7Qj8Xp2YwFfgvf4nq/iubb9xjvGJB2If3HuIBDB0etgzHIwKwCQYrtxpNKVFrnzQFdXuCZjnoj/vnIrz/gwLEktN2xQcFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=AgTgAoD1; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D346D406FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761686969; bh=Uof/S9nau0OGfu0ax8VPooo+NHrFd32syHYzwyYM+3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AgTgAoD1G21vqZJGnE0v1C61iVaSvqTe7ZPhL480SsJmOhlcWF2rK/WBGi2eqRJTX
	 Y1NKWGz3kxaxrUcYX63WxDE2GHGq6Jj9xStHDXiCf+4FZohT9MWXRwOMvn4qKR2zku
	 rBGw3WYMrlP2p1a1CS2imuFZmzufj8dqxCrvXMz0slsdC0WdUU+vAdeUiQz3jKwbx3
	 Mw8YH/nR0TEtojPLw4ftwM3S+9z4TkLP/s1eJpSJvkfTkEKAERyGtnkx4ytFnbNub6
	 Wjcdra+flTuGJNTU8DiEDtRO8Y7x3QbfHQOKZRILvtGXzxoi+ZFpUb4xzTBfYZlh6E
	 EtcLLShsKf1FQ==
Received: from localhost (c-73-14-55-248.hsd1.co.comcast.net [73.14.55.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D346D406FB;
	Tue, 28 Oct 2025 21:29:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Andreas Radke <andreas.radke@mailbox.org>, stable
 <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Zhixu Liu <zhixu.liu@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Please backport commit 00d95fcc4dee ("docs: kdoc: handle the
 obsolescensce of docutils.ErrorString()") to v6.17.y
In-Reply-To: <aQEjRT5JBLYiBTaL@eldamar.lan>
References: <aPUCTJx5uepKVuM9@eldamar.lan>
 <DDS2XJZB0ECJ.N4LNABSIJHAJ@mailbox.org> <aP4amn4YQDnzBBCU@eldamar.lan>
 <87wm4gpbw6.fsf@trenco.lwn.net> <aQEjRT5JBLYiBTaL@eldamar.lan>
Date: Tue, 28 Oct 2025 15:29:27 -0600
Message-ID: <87v7jyk954.fsf@trenco.lwn.net>
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
> On Mon, Oct 27, 2025 at 10:06:33AM -0600, Jonathan Corbet wrote:
>> Salvatore Bonaccorso <carnil@debian.org> writes:
>> 
>> > Hi,
>> >
>> > On Sun, Oct 26, 2025 at 08:36:00AM +0100, Andreas Radke wrote:
>> >> For kernel 6.12 there's just one more place required to add the fix:
>> >> 
>> >> --- a/Documentation/sphinx/kernel_abi.py        2025-10-23 16:20:48.000000000 +0200
>> >> +++ b/Documentation/sphinx/kernel_abi.py.new    2025-10-26 08:08:33.168985951 +0100
>> >> @@ -42,9 +42,11 @@
>> >>  from docutils import nodes, statemachine
>> >>  from docutils.statemachine import ViewList
>> >>  from docutils.parsers.rst import directives, Directive
>> >> -from docutils.utils.error_reporting import ErrorString
>> >>  from sphinx.util.docutils import switch_source_input
>> >> 
>> >> +def ErrorString(exc):  # Shamelessly stolen from docutils
>> >> +    return f'{exc.__class__.__name}: {exc}'
>> >> +
>> >>  __version__  = '1.0'
>> >> 
>> >>  def setup(app):
>> >
>> > Yes this is why I asked Jonathan, how to handle backports to older
>> > series, if it is wanted to pick specifically as well faccc0ec64e1
>> > ("docs: sphinx/kernel_abi: adjust coding style") or a partial backport
>> > of it, or do a 6.12.y backport of 00d95fcc4dee with additional
>> > changes (like you pointed out).
>> >
>> > I'm just not sure what is preferred here. 
>> 
>> I'm not sure it matters that much...the additional change suggested by
>> Andreas seems fine.  It's just a backport, and it shouldn't break
>> anything, so doesn't seem worth a lot of worry.
>
> Okay here is a respective backported change for the 6.12.y series as
> well.
>
> Does that look good for you?

I haven't actually tried it, but it looks OK to me.

jon

