Return-Path: <stable+bounces-155613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD772AE42E7
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBE53B3823
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9950125393C;
	Mon, 23 Jun 2025 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC/RYrsG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575B4239E63
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684887; cv=none; b=q43FfroVS5OuWl97H90xYiXlL2cYdsXMwCsih9LrktelZnFa75UKtNZ/GURCZ04UOQIcabNu4GIKCy6eP56TCDvBxWTHhjGvWoEOQc+PaYZLrclC01unqXPVvk/OfW9M45jic81RI7hU8Yt6OvmHg6xin1lF4U9a/hnfZDHvj/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684887; c=relaxed/simple;
	bh=ynRkoITAYl2AS3psMrMY/hKN1rkBytxr166qV7LbmVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pStv1KcOQbxBbS3D4+P9E/SYu3z75Ig3a3kR/ksiis0NXfsz5XdxIdrGK6cofCKtmraf6tCKV/lt4B/N6FPEI2BZFmm8dBoY8QImvV1n1LV8Rx02BIYn2hIpQzNrCgeAHvjaxrOuls1rpIrAol1prMj8t5Tl2tqhxEKO3MEgS+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZC/RYrsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF50EC4CEEA;
	Mon, 23 Jun 2025 13:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750684887;
	bh=ynRkoITAYl2AS3psMrMY/hKN1rkBytxr166qV7LbmVU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZC/RYrsGYzvqs26qMDm75U0CFFjlZLA4zf//pgxvqR/JZ19S0xzEDNAxpWu74XPYU
	 3FCU5IX+LsiT88v9QdXlnU9N6lxCovfiQLceaYbbGi4S9E2OS6q9A9PDFEER5zkApX
	 UfJnKWRQmyKMaMd7qbvJadx9RxNFuwUueuyQYx07yvI4VemJgbM0bX/hDd3GAnJ72L
	 bY4EkeSuE1bc9yKpRNdj4j9TJAE8RDBQbkz3JWNB0Uzn/MlcgmUsseBe6+CYj5wsfu
	 wiKdKMt2WT+dBnMDbTBcMiyyLbfrF/kiCr6XPChzZUP5S6orR5nC4+qEU3aYu6lfnu
	 Gqu+crmSTJPBg==
Message-ID: <0b61c829-a41f-47b4-91c2-e8a7babe7060@kernel.org>
Date: Mon, 23 Jun 2025 09:21:25 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y 0/2] Apply commit 358de8b4f201 to 6.6.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <2024021932-lavish-expel-58e5@gregkh>
 <20250617193853.388270-1-cel@kernel.org>
 <2025062314-modular-robust-7b94@gregkh>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <2025062314-modular-robust-7b94@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/25 2:33 AM, Greg KH wrote:
> On Tue, Jun 17, 2025 at 03:38:51PM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Tested: "make binrpm-pkg" on Fedora 39 then installed with "rpm
>> -ivh ...". Newly installed kernel reboots as expected.
>>
>> I will have a look at origin/linux-6.1.y next.
>>
>> Jose Ignacio Tornos Martinez (1):
>>   kbuild: rpm-pkg: simplify installkernel %post
>>
>> Masahiro Yamada (1):
>>   scripts: clean up IA-64 code
>>
>>  scripts/checkstack.pl        |  3 ---
>>  scripts/gdb/linux/tasks.py   | 15 +++------------
>>  scripts/head-object-list.txt |  1 -
>>  scripts/kconfig/mconf.c      |  2 +-
>>  scripts/kconfig/nconf.c      |  2 +-
>>  scripts/package/kernel.spec  | 28 +++++++++++-----------------
>>  scripts/package/mkdebian     |  2 +-
>>  scripts/recordmcount.c       |  1 -
>>  scripts/recordmcount.pl      |  7 -------
>>  scripts/xz_wrap.sh           |  1 -
>>  10 files changed, 17 insertions(+), 45 deletions(-)
> 
> Why is this needed in 6.6.y?  Is this just a new feature or fixing
> something that has always been broken?  It looks to me like a new
> feature...

Hi Greg -

TL;DR: This commit fixes something that is broken.

Reference bug: https://bugzilla.redhat.com/show_bug.cgi?id=2239008

The LTS v6.6 kernel's "make binrpm-pkg" target is broken on Fedora 39
and 40 due to a change in grubby. This breaks some CI environments.

The commits in this series address the kernel install problem.

Agreed, I should have mentioned that in this cover letter. I assumed
readers would remember my question about backporting these commits
from last week, and I was perhaps also leaning on the patch
descriptions, which have turned out to be obscure. Apologies.


-- 
Chuck Lever

