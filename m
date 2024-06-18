Return-Path: <stable+bounces-52657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0684090C971
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02EE81C233BC
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B5B13C3F4;
	Tue, 18 Jun 2024 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="vcKuoDVj"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30BB1B966;
	Tue, 18 Jun 2024 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706623; cv=none; b=Rj3BidP1B6L5oKLYzv1PV/uy0qsIRL7P0cgrXr50I3OXo27bbCtpCbqMDmDadg7RL5huEKkdBU18G7RRgQD/z5T/uPIvBzhpplp3ZGW41zMYL+2PpWLfiGX8C8w+Upc+hmokfxdmVytBe1UjI1uNkshLmYn2kKXYBFj/LOoMKJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706623; c=relaxed/simple;
	bh=SabcJjudxXLkszJUyYOi0DlrMsxTRRvN6zmEYuRvPDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0cO/nO89Zf3/rlO3kxnwS87b8uOfzumdOMuPOt+bOM7IuSYp1VpgDy4MlPdcY6qBFemgOaPDMV+8SRRXSYUXm96ejY5naCAVjNaIeF8GDPlAIu85M1YY+hlj3ZMFbt4lJZG04IeH1T8Gdcs3NIiMqfLI9ZB56Zs4IfZx2iUO54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=vcKuoDVj; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=WEJw5KzI2DTw//TdeTa5hGT3iNUEWTfTI8neMQtrapU=; t=1718706621;
	x=1719138621; b=vcKuoDVj7k4IVLjo/2GAC4/h5dtfHWGfpWmnYsCHmzpJrxeRKKQTqci0lrmCZ
	rpKw1OYS5MGiSQot95HDmjsKSJKQt4Iew7Hh3ZH8BFC9IGICRr7yOq99lXYrmkIWGuqGaR1GtmSVF
	bHhxsXas0/FXjCEpxWG+Llt9mFD7AME5DgvgsiywzJiREp/HdEzC1Z3/xN1mjUokYm6De0R8CNzTn
	IHSERW4OBPZ0NwduG1sdQXCjpwjQft8UQMXHObdexoSSsrTjvXRRyGQoNeuO6zQO5Jb9/pz3FlSbL
	NSzejZLWRE8cfV0oPJnzxb+/VbIyzLCts5eKpTKjD24uNqTAFQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sJW6U-0000L9-NW; Tue, 18 Jun 2024 12:30:18 +0200
Message-ID: <d5aa11c9-6326-4096-9c29-d9f0d11f83b4@leemhuis.info>
Date: Tue, 18 Jun 2024 12:30:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
To: Mike <user.service2016@gmail.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
 Sasha Levin <sashal@kernel.org>, =?UTF-8?Q?Jeremy_Lain=C3=A9?=
 <jeremy.laine@m4x.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Greg KH <gregkh@linuxfoundation.org>
References: <30f4b18f-4b96-403c-a0ab-d81809d9888a@gmail.com>
 <c09d4f5b-0c4b-4f57-8955-28a963cc7e16@leemhuis.info>
 <2024061258-boxy-plaster-7219@gregkh>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <2024061258-boxy-plaster-7219@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718706621;8161b518;
X-HE-SMSGID: 1sJW6U-0000L9-NW

On 12.06.24 14:04, Greg KH wrote:
> On Thu, Jun 06, 2024 at 12:18:18PM +0200, Thorsten Leemhuis wrote:
>> On 03.06.24 22:03, Mike wrote:
>>> On 29.05.24 11:06, Thorsten Leemhuis wrote:
>>> [...]
>>> I understand that 6.9-rc5[1] worked fine, but I guess it will take some
>>> time to be
>>> included in Debian stable, so having a patch for 6.1.x will be much
>>> appreciated.
>>> I do not have the time to follow the vanilla (latest) release as is
>>> likely the case for
>>> many other Linux users.
>>>
>> Still no reaction from the bluetooth developers. Guess they are busy
>> and/or do not care about 6.1.y. In that case:
>>
>> @Greg: do you might have an idea how the 6.1.y commit a13f316e90fdb1
>> ("Bluetooth: hci_conn: Consolidate code for aborting connections") might
>> cause this or if it's missing some per-requisite? If not I wonder if
>> reverting that patch from 6.1.y might be the best move to resolve this
>> regression. Mike earlier in
>> https://lore.kernel.org/all/c947e600-e126-43ea-9530-0389206bef5e@gmail.com/
>> confirmed that this fixed the problem in tests. Jeremy (who started the
>> thread and afaics has the same problem) did not reply.
> 
> How was this reverted?  I get a bunch of conflicts as this commit was
> added as a dependency of a patch later in the series.
> 
> So if this wants to be reverted from 6.1.y, can someone send me the
> revert that has been tested to work?

Mike, can you help out here, as you apparently managed a revert earlier?
Without you or someone else submitting a revert I fear this won't be
resolved...

Ciao, Thorsten

