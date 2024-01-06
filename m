Return-Path: <stable+bounces-9952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55834825F62
	for <lists+stable@lfdr.de>; Sat,  6 Jan 2024 13:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331591C211F3
	for <lists+stable@lfdr.de>; Sat,  6 Jan 2024 12:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890F46FC8;
	Sat,  6 Jan 2024 12:02:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD4E6FAE;
	Sat,  6 Jan 2024 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rM5Na-0002BV-Si; Sat, 06 Jan 2024 13:02:18 +0100
Message-ID: <13a70cc5-78fc-49a4-8d78-41e5479e3023@leemhuis.info>
Date: Sat, 6 Jan 2024 13:02:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression 6.1.y] From "cifs: Fix flushing, invalidation and
 file size with copy_file_range()"
Content-Language: en-US, de-DE
To: Salvatore Bonaccorso <carnil@debian.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 "Jitindar Singh, Suraj" <surajjs@amazon.com>
Cc: "rohiths.msft@gmail.com" <rohiths.msft@gmail.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "stfrench@microsoft.com" <stfrench@microsoft.com>,
 "dhowells@redhat.com" <dhowells@redhat.com>,
 "pc@manguebit.com" <pc@manguebit.com>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "nspmangalore@gmail.com" <nspmangalore@gmail.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
 stable@vger.kernel.org, linux-cifs@vger.kernel.org
References: <2023121124-trifle-uncharted-2622@gregkh>
 <a76b370f93cb928c049b94e1fde0d2da506dfcb2.camel@amazon.com>
 <ZZhrpNJ3zxMR8wcU@eldamar.lan>
 <8e59220d-b0f3-4dae-afc3-36acfa6873e4@leemhuis.info>
 <ZZk6qA54A-KfzmSz@eldamar.lan>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZZk6qA54A-KfzmSz@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1704542545;f69b91b9;
X-HE-SMSGID: 1rM5Na-0002BV-Si

On 06.01.24 12:34, Salvatore Bonaccorso wrote:
> On Sat, Jan 06, 2024 at 11:40:58AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
>>
>> Does this problem also happen in mainline, e.g. with 6.7-rc8?
> 
> Thanks a lot for replying back. So far I can tell, the regression is
> in 6.1.y only 

Ahh, good to know, thx!

> For this reason I added to regzbot only "regzbot ^introduced
> 18b02e4343e8f5be6a2f44c7ad9899b385a92730" which is the commit in
> v6.1.68.

Which was the totally right thing to do, thx. Guess I sooner or later
will add something like "#regzbot tag notinmainline" to avoid the
ambiguity we just cleared up, but maybe that's overkill.

Ciao, Thorsten!

