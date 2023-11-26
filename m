Return-Path: <stable+bounces-2676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 655BF7F91D4
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 09:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7B11C20A4F
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 08:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF10611E;
	Sun, 26 Nov 2023 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B223C8
	for <stable@vger.kernel.org>; Sun, 26 Nov 2023 00:24:37 -0800 (PST)
Message-ID: <58ef6746-e46e-4a6d-8875-8375f5b9d89c@hardfalcon.net>
Date: Sun, 26 Nov 2023 09:24:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.6 205/530] af_unix: fix use-after-free in
 unix_stream_read_actor()
Content-Language: en-US
To: =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
 Rao Shoaib <rao.shoaib@oracle.com>, Paolo Abeni <pabeni@redhat.com>,
 Sasha Levin <sashal@kernel.org>,
 syzbot+7a2d546fa43e49315ed3@syzkaller.appspotmail.com
References: <20231124172028.107505484@linuxfoundation.org>
 <20231124172034.306582342@linuxfoundation.org>
 <6db03eba-abd3-41ff-a2af-9fca0ca24c31@hardfalcon.net>
 <2fbf23b8-8046-4f10-abf8-294bbe261c5d@hardfalcon.net>
 <9bc5b07c-5f81-7d06-6837-6ba13109dda6@applied-asynchrony.com>
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <9bc5b07c-5f81-7d06-6837-6ba13109dda6@applied-asynchrony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[2023-11-26 01:54] Holger Hoffstätte:
> On 2023-11-26 00:49, Pascal Ernster wrote:
>> I've now tested with a clean/vanilla kernel 6.6.2 with all the
>> patches from
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.6?id=2da2670346795f8fe06acbf499606941303b9cbe
>> applied on top, but *excluding* the "af_unix: fix use-after-free in
>> unix_stream_read_actor()" patch, and my VM boots cleanly, without any
>> crashes.
>>
>> When I try to boot a build of the exact same kernel, but *including*
>> the "af_unix: fix use-after-free in unix_stream_read_actor()" patch,
>> the VM crashes during boot (as stated in my previous email), so I'm
>> now 100% certain that this patch is causing the crashes.
>>
> 
> Can you try booting the latest 6.7-rc and see what happens? That might give
> us a further clue. I'm running 6.6.3-rc with this patch, various apps use
> Unix sockets and there is not problem so far.


I can try 6.7-rc, but compiling will take a while.

At least with 6.6.3-rc, The crashes seem occur only with the specific 
config that I had attached to my first email. I had originally tried 
with a localmodconfig to speed up compiling when tracking down the 
crashes, but I couldn't reproduce the crashes with the localmodconfig 
kernel.


Regards
Pascal

