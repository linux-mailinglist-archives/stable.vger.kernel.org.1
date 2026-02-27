Return-Path: <stable+bounces-219994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJPkOKjnoWlRxAQAu9opvQ
	(envelope-from <stable+bounces-219994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 19:51:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8019C1BC2F6
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 19:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D53A3019814
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 18:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B7A3A1CF9;
	Fri, 27 Feb 2026 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="MdxcoxYm"
X-Original-To: stable@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3F3A1A57;
	Fri, 27 Feb 2026 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772218278; cv=none; b=d21RbaPq2vyQTWLRjnVgOYDehC2P5tmjeMUTizgG6Lm91Pcm1CEKBftVewvukcUDjlXdjyOCEdSblm+CF2svZ6ePqTm6M711PUNwTxJlE33XtxD6d2L9xX2fxEjJwA/kFg6qhR0iWUMqaBoBtabp3avo17SXhnB/JxJmK9Vcx2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772218278; c=relaxed/simple;
	bh=6NwCqR4Dptp89r49YrGoc8zwxP3f29Y/sZQ/FjoS1js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIanHw8dShpGIWDMMf5rfXUWdCvSCh7Q85wPbSrX8sapkhb7gRjmVTt4SQhC9Kc2xgiG2vdB2Ik4wi63e8G5pQD3QvoI+i0XuX/croPZkHAe/g4TrlIaQONxEwhH98IMGLPcdWVsDR8qgncDYZ6nt84mBNNUwg4emt6IaBFw050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=MdxcoxYm; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B6F2041F8B;
	Fri, 27 Feb 2026 19:51:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1772218274; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=jgwlh8QKIjyXE+L3WRPk37ZeQTkkboOydjCCWnLLQT8=;
	b=MdxcoxYmGns33o6GA3qLo++97gnkwvNMVwowIyOchBSQhrMBir/93B9l8V/bVGwtnucf5+
	qbvqF17BNIo67gOgwrfgN9rglObui4BgObTeZ+YuC/h9YgwB2rzX/JaZ94p8e4KMkrhXwx
	nlhay43Yr/YRq8oS09ap0DAXjMdycgY1jlAs1s4ZV9JIBYihfvFnqFHm47lcJJHtTxgeJ5
	DT9irEifqQJIUJNhNrlIvHdRhOba0uajq5Fcwx0dRlWh6xFB+xznk2rT24HXHEAQTav72H
	kvHG4vkjYeXzilKAkMqFQNJgMkBknqTTmQmsnYqxicPw8biP4fPpLUeRlnW2MQ==
Message-ID: <0f744313-d13b-4de3-9cf1-de97e9b8fb3d@manjaro.org>
Date: Fri, 27 Feb 2026 19:51:09 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.19.4 - Oops, regression
To: Genes Lists <lists@sapience.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>,
 akpm@linux-foundation.org, jslaby@suse.cz, linux-kernel@vger.kernel.org,
 lwn@lwn.net, stable@vger.kernel.org, torvalds@linux-foundation.org
References: <2026022657-clambake-mountable-8175@gregkh>
 <eb2d1da9-0b4b-4887-83a4-0e2a65e703aa@moonlit-rail.com>
 <2026022612-buckskin-surfacing-d854@gregkh>
 <bb9ab61c-3bed-4c3d-baf0-0bce4e142292@moonlit-rail.com>
 <67d9f732a55a31f3073675164e8d7ada46da3dbe.camel@sapience.com>
 <0a77c13e74493b786c5fe4e1ebdf55b14e5ff496.camel@sapience.com>
 <2026022750-everyone-huff-8fd0@gregkh>
 <95fea1bd0ded180bb79285ec8416053c614150f8.camel@sapience.com>
 <afe24af8ae3913f8988dc551629e8f598313a29d.camel@sapience.com>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <afe24af8ae3913f8988dc551629e8f598313a29d.camel@sapience.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.54 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[manjaro.org,quarantine];
	R_DKIM_ALLOW(-0.20)[manjaro.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219994-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[manjaro.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[philm@manjaro.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[manjaro.org:mid,manjaro.org:dkim]
X-Rspamd-Queue-Id: 8019C1BC2F6
X-Rspamd-Action: no action

On 2/27/26 15:44, Genes Lists wrote:
> On Fri, 2026-02-27 at 08:59 -0500, Genes Lists wrote:
>> On Fri, 2026-02-27 at 08:32 -0500, Greg KH wrote:
>>> On Fri, Feb 27, 2026 at 08:18:52AM -0500, Genes Lists wrote:
>>>> On Fri, 2026-02-27 at 07:09 -0500, Genes Lists wrote:
>>>>> On Fri, 2026-02-27 at 01:26 -0500, Kris Karas (Bug Reporting)
>>>>> w...
> ...
>>
>> Sorry if was not clear.  Only 6.19.4 has kernel crash.
>> The summary is:
>> ...
>> - 6.19.4 - crashes whenever nftables is invoked.
>>    Does not matter which userspace nftables is used, older or newer
> ...
>> I will report back soon as have finished testing 6.19.4 with commit
>> f175b46d9134
> I confirm that
>
>     6.19.4 plus git cherry-pick f175b46d9134f708358b5404730c6dfa200fbf3c
>
> works fine and resolves the crash in nf_tables_abort_release seen in
> 6.19.4.
>
> gene
>
>
>
>
>
Most likely 6.18.14 might be affected here as well. Same patch was added 
there also: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/diff/releases/6.18.14/netfilter-nft_set_rbtree-translate-rbtree-to-array-f.patch?id=08f2c72545fd46526226105230449470db503ecf

-- 
Best, Philip


