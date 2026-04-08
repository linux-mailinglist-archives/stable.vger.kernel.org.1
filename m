Return-Path: <stable+bounces-233761-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COo0Adfr1Wkd/QcAu9opvQ
	(envelope-from <stable+bounces-233761-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 07:47:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E483B75B3
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 07:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9CA43030D15
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 05:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7BD342CB1;
	Wed,  8 Apr 2026 05:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ErwHqYpb"
X-Original-To: stable@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9C41EB5C2;
	Wed,  8 Apr 2026 05:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775627215; cv=none; b=XCfTsZVp7HH6nZ7BDEYxlKl+nr+SfiynTT4T6zsDdx+yAN5oP6n0xxen28tvz5ARF27DXJlQwTDqgQg1jJAipTtYWJJjRVRH+syokOkuTWHQVWW5N8nOrQK+xBwEOvNNwsWLPUbVxICqEaruBR2WVV0sV7SUe62kS75wj//sWhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775627215; c=relaxed/simple;
	bh=VL1LgjlwyVlXEU5Va58s7183yT4IePlmOBYPJ676uGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtEO2MSLLaeJzn04bLn6PxuNmsndt089++GDmHhkiEAdnCOD6I2gnGUrOpa9HEcjlE2ijX41cDX7NcWdVQsm90f/ATDqjBBlzs90NOZVRdgi4B7uXKOBzI2L0vTqSOqj7UV6BQyG7AFL/W4znBNKw1HjY4wAgxQY4XxKEBMdaJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ErwHqYpb; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775627209; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8HxFDS85wN9rvHZG9v5M3rk30ZGnshODqB3BJaGAY/w=;
	b=ErwHqYpbrN+98Eh0VrWiJvF+CfPfB7WUsZ+kOHzeKmr6sampwVBaK70MoI6pcBtwaihpB+fN3JwtW0BrIcnfBdF02tSgAkqPI9iLEtSrIAvfFX9K32CqhAYd1PhiCDzZXPBIBD2eSYjzO55tpOu4fyk6G/shdFzTInwiXX7aSIo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X0dlaHW_1775627208;
Received: from 30.221.145.30(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X0dlaHW_1775627208 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Apr 2026 13:46:48 +0800
Message-ID: <214f9901-a153-47d8-a099-847fb2c97aa4@linux.alibaba.com>
Date: Wed, 8 Apr 2026 13:46:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ocfs2: fix use-after-free in ocfs2_fault() when
 VM_FAULT_RETRY
To: tejas bharambe <tejas.bharambe@outlook.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Tejas Bharambe <thbharam@gmail.com>,
 "ocfs2-devel@lists.linux.dev" <ocfs2-devel@lists.linux.dev>,
 "mark@fasheh.com" <mark@fasheh.com>, "jlbec@evilplan.org"
 <jlbec@evilplan.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com"
 <syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260403035333.136824-1-tejas.bharambe@outlook.com>
 <20260403122947.2afc337b5333fb1990a78a65@linux-foundation.org>
 <JH0PR06MB66320ABCFAD8F239FE5112B2895CA@JH0PR06MB6632.apcprd06.prod.outlook.com>
 <20260404175040.40a746040ddb0cb5ce347fe3@linux-foundation.org>
 <JH0PR06MB6632F1A4381AB798FED980CE895BA@JH0PR06MB6632.apcprd06.prod.outlook.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <JH0PR06MB6632F1A4381AB798FED980CE895BA@JH0PR06MB6632.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233761-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,fasheh.com,evilplan.org,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joseph.qi@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,a49010a0e8fcdeea075f];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,fasheh.com:email]
X-Rspamd-Queue-Id: 46E483B75B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/8/26 11:50 AM, tejas bharambe wrote:
> Hi Andrew,
> 
> You're right, I missed that scenario.
> 
> The inode can be freed if the file descriptor is closed after mmap() and munmap() races with the fault handler.
> 
> I can do one of the following:
> 1. I can skip the trace firing when VM_FAULT_RETRY is set as I did in v1. It was changed to v4 after Joseph's suggestion to keep traces.
> 2. If we want to keep traces, we can use ihold()/iput() as shown below:
> 
> ihold(inode);   //pin inode
> ret = filemap_fault(vmf);
> trace_ocfs2_fault(OCFS2_I(inode)->ip_blkno, ...);  // safe, refcount held
> iput(inode);  //release inode
> 
> 
> Which approach do you prefer?
> 
It seems theoretically possible.
Since we only want to trace ip_blkno here, not inode itself, we can
simply save it at first.

Thanks,
Joseph

> Thanks,
> Tejas
> ________________________________________
> From: Andrew Morton <akpm@linux-foundation.org>
> Sent: Saturday, April 4, 2026 5:50 PM
> To: tejas bharambe <tejas.bharambe@outlook.com>
> Cc: Tejas Bharambe <thbharam@gmail.com>; ocfs2-devel@lists.linux.dev <ocfs2-devel@lists.linux.dev>; mark@fasheh.com <mark@fasheh.com>; jlbec@evilplan.org <jlbec@evilplan.org>; joseph.qi@linux.alibaba.com <joseph.qi@linux.alibaba.com>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com <syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com>; stable@vger.kernel.org <stable@vger.kernel.org>
> Subject: Re: [PATCH v4] ocfs2: fix use-after-free in ocfs2_fault() when VM_FAULT_RETRY
> 
> On Sun, 5 Apr 2026 00:30:14 +0000 tejas bharambe <tejas.bharambe@outlook.com> wrote:
> 
>> Following is my response for question posted on https://sashiko.dev/#/patchset/20260403035333.136824-1-tejas.bharambe%40outlook.com
>>
>>
>> No. For ocfs2_fault() to be executing, the file must be open and
>> the process holds an active file descriptor. The inode's lifetime
>> is tied to the file's reference count, which remains held by the
>> file descriptor for the duration of the fault handler. munmap()
>> can free the VMA (decrementing vm_file's refcount) but cannot
>> free the inode as long as the file descriptor is open. The faulting
>> thread cannot call close() while it is inside the fault handler,
>> so the inode is guaranteed to outlive the trace call.
> 
> I don't think that's the scenario which Sashiko is suggesting.
> 
> Suppose userspace does
> 
>         fd = open(...);
>         p = mmap(fd, ...);
>         close(fd);
> 
> Now, that mmap is the only ref against fd.
> 
> Now, suppose that userspace does munmap() while another thread is in
> the fault handler.


