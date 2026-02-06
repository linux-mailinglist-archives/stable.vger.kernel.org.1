Return-Path: <stable+bounces-214617-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMQRET2lhWmSEQQAu9opvQ
	(envelope-from <stable+bounces-214617-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 09:24:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 694FFFB710
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 09:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7EEC53013781
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 08:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF5734887B;
	Fri,  6 Feb 2026 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mgml.me header.i=@mgml.me header.b="vCZ+vreC";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ELBJjd9h"
X-Original-To: stable@vger.kernel.org
Received: from e234-52.smtp-out.ap-northeast-1.amazonses.com (e234-52.smtp-out.ap-northeast-1.amazonses.com [23.251.234.52])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A439B34847A;
	Fri,  6 Feb 2026 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770366207; cv=none; b=ga34r1cYDAnLhaS2peGHXicxuPmxQIXHT2ElzHuz0Dv9ek3cEROtuUM3LBn+yXhkynQYfDrt5br10qTC9dq+POuKO7X781UfI0nM9maZTrrkgmixsMd+cTtF0dEp9u7kyS+AvuLeD2q/vnaC5Q7s93SAl0wu8ikOF42ib3AOJg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770366207; c=relaxed/simple;
	bh=cAA85mXgihgT5EqXdE/1zzC9GDxcWUf9+c4NQoMN/L4=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=sYWmk7unmvX9Z2yC515SaEEhUyfqx9/a1Amp11cYi+hnaT242LgbMdyxdhXfnl3J7+cgt6Uo+MvTM8Is+5hZUV6BtArm7R004DQ2tCfYXaecg7dYsLTVogFrfSGFrozPKtaDMazL9GwMbjK6CJIY7IJPdkVlxY4ZvXOkrs710UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=send.mgml.me; dkim=pass (1024-bit key) header.d=mgml.me header.i=@mgml.me header.b=vCZ+vreC; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=ELBJjd9h; arc=none smtp.client-ip=23.251.234.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.mgml.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=mgml.me; t=1770366205;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=cAA85mXgihgT5EqXdE/1zzC9GDxcWUf9+c4NQoMN/L4=;
	b=vCZ+vreCX066BG9U2rpQoM/BH1Hiozx2GZW+ehKtRpAWLUHSWD7HxHgwQCcJwy92
	dCjONg3SLEBVHLTkBr4FQKcvQy3lmhrcqjv/xwgYpnN4nXjoj4g/24Brsx4Z0EeKkct
	muK8PlGk1cXjYNlhEKz06US0wdL9VryoKAO9zB7o=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=suwteswkahkjx5z3rgaujjw4zqymtlt2; d=amazonses.com; t=1770366205;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=cAA85mXgihgT5EqXdE/1zzC9GDxcWUf9+c4NQoMN/L4=;
	b=ELBJjd9hqJVrYr99RzSeXeFrejJqUyM9MgC2Ig7WaAHsQDAHnMvKPUhKL2dCzQYl
	AWiP9SjxzcA1KjI1ccjgoNNpVhXqQjeMXk0qbNVEI5NcME+a2cxEKN72fw6mxaYu6LN
	M9KTk2R2aDE46MEwduBXvcX7dSa9hQZw++8aGmNo=
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <aYTYUZXJjQV1BBAk@mail.minyard.net>
From: Kenta Akagi <k@mgml.me>
To: corey@minyard.net
Cc: k@mgml.me, openipmi-developer@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RFC 0/1] ipmi: Fix double list_add when sender returns
 an error
Message-ID: <0106019c320c7d2b-10ca1cdd-c2ab-407b-90b0-0eaf05fa16be-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 6 Feb 2026 08:23:25 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: ::1.ap-northeast-1.TOS0vxEE3Ar6ai29fkp2i/jb+l2iigajCGeLfF7S3sk=:AmazonSES
X-SES-Outgoing: 2026.02.06-23.251.234.52
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mgml.me,none];
	R_DKIM_ALLOW(-0.20)[mgml.me:s=resend,amazonses.com:s=suwteswkahkjx5z3rgaujjw4zqymtlt2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214617-lists,stable=lfdr.de];
	FORGED_MUA_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[k@mgml.me,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mgml.me:+,amazonses.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amazonses.com:dkim,mgml.me:dkim,ap-northeast-1.amazonses.com:mid]
X-Rspamd-Queue-Id: 694FFFB710
X-Rspamd-Action: no action



On 2026/02/06 2:50, Corey Minyard wrote:
> On Thu, Feb 05, 2026 at =
11:47:38PM +0900, Kenta Akagi wrote:
>> In kernel 6.18.7, we encountered =
the following panic.
>>
>>     [164050.860241] list_add double add: =
new=3Dffff8a5833cd0000, prev=3Dffff8a5833cd0000, next=3Dffff8a387b2491b0.
>>     [164050.869744] ------------[ cut here ]------------
>>     [164050.874698] kernel BUG at lib/list_debug.c:35!
>>     [164050.879435] Oops: invalid opcode: 0000 [#1] SMP NOPTI
>>     [164050.884742] CPU: 5 UID: 0 PID: 99228 Comm: kworker/5:2 Kdump: =
loaded Tainted: G S          E       6.18.7-20260127.el9.x86_64 #1 =
PREEMPT(voluntary)
>>     [164050.899481] Tainted: [S]=3DCPU_OUT_OF_SPEC, =
[E]=3DUNSIGNED_MODULE
>>     [164050.905470] Hardware name: Dell Inc. =
PowerEdge R640/0X45NX, BIOS 2.15.1 06/15/2022
>>     [164050.913285] =
Workqueue: events smi_work [ipmi_msghandler]
>>     [164050.918865] RIP: =
0010:__list_add_valid_or_report+0xb6/0xc0
>>     [164050.924609] Code: c7 =
e8 b1 c3 89 48 8b 16 48 89 f1 4c 89 e6 e8 e1 16 a9 ff 0f 0b 48 89 f2 4c 89 =
e1 48 89 fe 48 c7 c7 40 b2 c3 89 e8 ca 16 a9 ff <0f> 0b 0f 1f 84 00 00 00 =
00 00 90 90 90 90 90 90 90 90 90 90 90 90
>>     [164050.943787] RSP: =
0018:ffffceacac91fdc0 EFLAGS: 00010246
>>     [164050.949271] RAX: =
0000000000000058 RBX: ffff8a5833cd0000 RCX: 0000000000000000
>>     [164050.956665] RDX: 0000000000000000 RSI: 0000000000000001 RDI: =
ffff8a773f89c1c0
>>     [164050.964054] RBP: ffff8a5833cd0000 R08: =
0000000000000000 R09: ffffceacac91fc78
>>     [164050.971441] R10: =
ffffceacac91fc70 R11: ffffffff8a7e10c8 R12: ffff8a387b2491b0
>>     [164050.978837] R13: 0000000000000000 R14: ffff8a387b249190 R15: =
ffff8a387b2491b0
>>     [164050.986229] FS:  0000000000000000(0000) =
GS:ffff8a77b459d000(0000) knlGS:0000000000000000
>>     [164050.994581] CS:=
  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>     [164051.000597] CR2: =
00007ff95841be6c CR3: 000000063b022001 CR4: 00000000007726f0
>>     [164051.007997] PKRU: 55555554
>>     [164051.010970] Call Trace:
>>     [164051.013690]  <TASK>
>>     [164051.016055]  ? =
mutex_lock+0xe/0x30
>>     [164051.019724]  deliver_response+0x59/0x100 =
[ipmi_msghandler]
>>     [164051.025495]  smi_work+0xa0/0x370 =
[ipmi_msghandler]
>>     [164051.030563]  process_one_work+0x19d/0x3d0
>>     [164051.034844]  worker_thread+0x23e/0x360
>>     [164051.038873]  ?=
 __pfx_worker_thread+0x10/0x10
>>     [164051.043423]  kthread+0xfb/0x230
>>     [164051.046850]  ? __pfx_kthread+0x10/0x10
>>     [164051.050872]  ?=
 __pfx_kthread+0x10/0x10
>>     [164051.054894]  ret_from_fork+0xe9/0x100
>>     [164051.058826]  ? __pfx_kthread+0x10/0x10
>>     [164051.062852]  =
ret_from_fork_asm+0x1a/0x30
>>     [164051.067065]  </TASK>
>>
>> Because kdump was not properly configured, I was unable to inspect the
>> vmcore, but based on the oops and the current implementation, I infer
>> that the issue occurred via the following mechanism.
>=20
> A fix for this is already queued in the next tree.  I should have it
> out soon.

Ah, sorry for I didn't notice that.
I'll wait for the "ipmi: =
Fix use-after-free and list corruption on sender error".

Thanks,
Akagi

>=20
> -corey
>=20
>>
>> - The BMC becomes unstable
>> - Some kind of msg is queued in (hp_)xmit_msgs and smi_work runs
>> - (Because the BMC is unstable) intf->handlers->sender returns an error
>> - deliver_err_response() queues newmsg into intf->user_msg
>> - goto restart, but since intf->curr_msg is naturally non-NULL, no
>>   dequeue is performed from (hp_)xmit_msgs
>> - The same newmsg as =
before the restart goes through the same flow and
>>   deliver_err_response=
 is executed, leading to a double add
>>
>> I took a quick look at the BMC =
logs and there was a watchdog BMC reset
>> around the time of the panic, so=
 I'm pretty sure the BMC was unstable.
>>
>> I'm not sure if this is the =
correct approach, but I submit a RFC PATCH
>> in the spirit of a bug report=
. I would appreciate your feedback. You
>> can completely discard mine and =
fix it as a separate patch if you
>> prefer.
>>
>> Thanks.
>>
>> =20
>> Kenta Akagi (1):
>>   ipmi: Fix double list_add when sender returns an =
error
>>
>>  drivers/char/ipmi/ipmi_msghandler.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> --=20
>> 2.50.1
>>
>=20


