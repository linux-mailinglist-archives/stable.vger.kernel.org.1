Return-Path: <stable+bounces-98736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE579E4E77
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C91283C24
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 07:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5477B1B87C2;
	Thu,  5 Dec 2024 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XtRnLJJp"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12B31AF0DD;
	Thu,  5 Dec 2024 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383963; cv=none; b=D6pzAxyjrUUexYZBPaFGNVOkK/4SaD3OjYhELma5utmKrLzPrwO9AO6TlFpXS/FJixSPYRLVRk/ED9eiTnJRg+yJ4bAzHR5p2ur6rRJyoS+DmTVZ3H1pWzCARrlx7+t5KFRJQqOT0vceCN4f06mcVH/oHCY8ic+j3AeyTHGOLN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383963; c=relaxed/simple;
	bh=QP/wqp6Ij1Z7DZhBDfa6gv+EOrB5ILBBIm4EoiR84ds=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:Cc:In-Reply-To; b=ryueOKZFQGZMC8c184N5NI0jOlj5SpH7PDYuJb22/N8qRPk365oeU2JMMHyr+EHszPbi9BseDXx8vH5NWFcmMNVWjFCtW0jNZJHmOtC8Hv0axxniCw0KzX14TLaM7imwan32zCXG+MbVItNll7jbayGZoKrRfua4XIQuvttfT6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XtRnLJJp; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Content-Type:Message-ID:Date:MIME-Version:Subject:
	From; bh=lwIb7lYxLhF0mY4AbJgOSUXB84EqcKDHlgRExWuAjlM=; b=XtRnLJJ
	pUaAyKFF0Fa9iK6ljmpjYAeOyvN4BwRK+lTan7QUTSXUmudwvD4ScqdDoo0ayxco
	Dggbj2G7RLXvhyEzwjKA9Cgc+Vwb0ZdrU94JGtFmXIDPTZDT33+/nKTnESq4Zr6v
	mZCuLPhajMcvCdB7btriZkJKKzXjp4/r5i6Y=
Received: from [10.100.3.67] (unknown [14.153.182.146])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3P+bjVlFnpDZvGQ--.6053S2;
	Thu, 05 Dec 2024 15:31:48 +0800 (CST)
Content-Type: multipart/mixed; boundary="------------eeeusMGOxTWC0yGMAG98c7bD"
Message-ID: <dcdeaf17-c3ce-4677-a0c0-c391d8bd951f@163.com>
Date: Thu, 5 Dec 2024 15:31:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: Check space before adding MPTCP options
To: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
References: <20241204085801.11563-1-moyuanhao3676@163.com>
 <80b6603d-ed52-43b7-a434-0253e5de784a@kernel.org>
Content-Language: en-US
From: Mo Yuanhao <moyuanhao3676@163.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 mptcp@lists.linux.dev, stable@vger.kernel.org
In-Reply-To: <80b6603d-ed52-43b7-a434-0253e5de784a@kernel.org>
X-CM-TRANSID:_____wD3P+bjVlFnpDZvGQ--.6053S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWxtryDZFWkZrWkXry3twb_yoW5Ar45pF
	98KrnYkr4kJa48Gw4xX3Wvyr1rZa1rCrZ8K3W5Ww12ywn8WFyI9ryIkw4YvrnrWr48tw12
	vr47Z3s3ua1UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jxMa8UUUUU=
X-CM-SenderInfo: 5pr13t5qkd0jqwxwqiywtou0bp/xtbBZxCsfmdRKpMBzwABsl

This is a multi-part message in MIME format.
--------------eeeusMGOxTWC0yGMAG98c7bD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/12/4 19:01, Matthieu Baerts 写道:
> Hi MoYuanhao,
> 
> +Cc MPTCP mailing list.
> 
> (Please cc the MPTCP list next time)
> 
> On 04/12/2024 09:58, MoYuanhao wrote:
>> Ensure enough space before adding MPTCP options in tcp_syn_options()
>> Added a check to verify sufficient remaining space
>> before inserting MPTCP options in SYN packets.
>> This prevents issues when space is insufficient.
> 
> Thank you for this patch. I'm surprised we all missed this check, but
> yes it is missing.
> 
> As mentioned by Eric in his previous email, please add a 'Fixes' tag.
> For bug-fixes, you should also Cc stable and target 'net', not 'net-next':
> 
> Fixes: cec37a6e41aa ("mptcp: Handle MP_CAPABLE options for outgoing
> connections")
> Cc: stable@vger.kernel.org
> 
> 
> Regarding the code, it looks OK to me, as we did exactly that with
> mptcp_synack_options(). In mptcp_established_options(), we pass
> 'remaining' because many MPTCP options can be set, but not here. So I
> guess that's fine to keep the code like that, especially for the 'net' tree.
> 
> 
> Also, and linked to Eric's email, did you have an issue with that, or is
> it to prevent issues in the future?
> 
> 
> One last thing, please don’t repost your patches within one 24h period, see:
> 
>    https://docs.kernel.org/process/maintainer-netdev.html
> 
> 
> Because the code is OK to me, and the same patch has already been sent
> twice to the netdev ML within a few hours, I'm going to apply this patch
> in our MPTCP tree with the suggested modifications. Later on, we will
> send it for inclusion in the net tree.
> 
> pw-bot: awaiting-upstream
> 
> (Not sure this pw-bot instruction will work as no net/mptcp/* files have
> been modified)
> 
> Cheers,
> Matt
Hi Matt,

Thank you for your feedback!

I have made the suggested updates to the patch (version 2):

I’ve added the Fixes tag and Cc'd the stable@vger.kernel.org list.
The target branch has been adjusted to net as per your suggestion.
I will make sure to Cc the MPTCP list in future submissions.

Regarding your question, this patch was created to prevent potential 
issues related to insufficient space for MPTCP options in the future. I 
didn't encounter a specific issue, but it seemed like a necessary 
safeguard to ensure robustness when handling SYN packets with MPTCP options.

Additionally, I have made further optimizations to the patch, which are 
included in the attached version. I believe it would be more elegant to 
introduce a new function, mptcp_set_option(), similar to 
mptcp_set_option_cond(), to handle MPTCP options.

This is my first time replying to a message in a Linux mailing list, so 
if there are any formatting issues or mistakes, please point them out 
and I will make sure to correct them in future submissions.

Thanks again for your review and suggestions. Looking forward to seeing 
the patch applied to the MPTCP tree and later inclusion in the net tree.

Best regards,

MoYuanhao
--------------eeeusMGOxTWC0yGMAG98c7bD
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-tcp-Check-space-before-adding-MPTCP-options.patch"
Content-Disposition: attachment;
 filename="0001-tcp-Check-space-before-adding-MPTCP-options.patch"
Content-Transfer-Encoding: base64

RnJvbSAxMjkwNGRiNTQ4YmRkODAxMTg5NWZlMDcxZDdhNDIwY2NjNjU4NGY4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNb1l1YW5oYW8gPG1veXVhbmhhbzM2NzZAMTYzLmNv
bT4KRGF0ZTogVGh1LCA1IERlYyAyMDI0IDEwOjE4OjE1ICswODAwClN1YmplY3Q6IFtQQVRD
SCBuZXQgdjJdIHRjcDogQ2hlY2sgc3BhY2UgYmVmb3JlIGFkZGluZyBNUFRDUCBvcHRpb25z
CgpFbnN1cmUgZW5vdWdoIHNwYWNlIGJlZm9yZSBhZGRpbmcgTVBUQ1Agb3B0aW9ucyBpbiB0
Y3Bfc3luX29wdGlvbnMoKQpBZGRlZCBhIGNoZWNrIHRvIHZlcmlmeSBzdWZmaWNpZW50IHJl
bWFpbmluZyBzcGFjZQpiZWZvcmUgaW5zZXJ0aW5nIE1QVENQIG9wdGlvbnMgaW4gU1lOIHBh
Y2tldHMuClRoaXMgcHJldmVudHMgaXNzdWVzIHdoZW4gc3BhY2UgaXMgaW5zdWZmaWNpZW50
LgoKRml4ZXM6IGNlYzM3YTZlNDFhYSAoIm1wdGNwOiBIYW5kbGUgTVBfQ0FQQUJMRSBvcHRp
b25zIGZvciBvdXRnb2luZyBjb25uZWN0aW9ucyIpClNpZ25lZC1vZmYtYnk6IE1vWXVhbmhh
byA8bW95dWFuaGFvMzY3NkAxNjMuY29tPgotLS0KIG5ldC9pcHY0L3RjcF9vdXRwdXQuYyB8
IDI0ICsrKysrKysrKysrKysrKystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2lwdjQvdGNwX291
dHB1dC5jIGIvbmV0L2lwdjQvdGNwX291dHB1dC5jCmluZGV4IDU0ODVhNzBiNWZlNS4uNDAx
ZWIxNGM4NzBkIDEwMDY0NAotLS0gYS9uZXQvaXB2NC90Y3Bfb3V0cHV0LmMKKysrIGIvbmV0
L2lwdjQvdGNwX291dHB1dC5jCkBAIC03OTIsNiArNzkyLDIxIEBAIHN0YXRpYyB2b2lkIHNt
Y19zZXRfb3B0aW9uX2NvbmQoY29uc3Qgc3RydWN0IHRjcF9zb2NrICp0cCwKICNlbmRpZgog
fQogCitzdGF0aWMgdm9pZCBtcHRjcF9zZXRfb3B0aW9uKHN0cnVjdCBzb2NrICpzaywgY29u
c3Qgc3RydWN0IHNrX2J1ZmYgKnNrYiwKKwkJCQlzdHJ1Y3QgdGNwX291dF9vcHRpb25zICpv
cHRzLCB1bnNpZ25lZCBpbnQgKnJlbWFpbmluZykKK3sKKwlpZiAoc2tfaXNfbXB0Y3Aoc2sp
KSB7CisJCXVuc2lnbmVkIGludCBzaXplOworCisJCWlmIChtcHRjcF9zeW5fb3B0aW9ucyhz
aywgc2tiLCAmc2l6ZSwgJm9wdHMtPm1wdGNwKSkgeworCQkJaWYgKCpyZW1haW5pbmcgPj0g
c2l6ZSkgeworCQkJCW9wdHMtPm9wdGlvbnMgfD0gT1BUSU9OX01QVENQOworCQkJCSpyZW1h
aW5pbmcgLT0gc2l6ZTsKKwkJCX0KKwkJfQorCX0KK30KKwogc3RhdGljIHZvaWQgbXB0Y3Bf
c2V0X29wdGlvbl9jb25kKGNvbnN0IHN0cnVjdCByZXF1ZXN0X3NvY2sgKnJlcSwKIAkJCQkg
IHN0cnVjdCB0Y3Bfb3V0X29wdGlvbnMgKm9wdHMsCiAJCQkJICB1bnNpZ25lZCBpbnQgKnJl
bWFpbmluZykKQEAgLTg3OSwxNCArODk0LDcgQEAgc3RhdGljIHVuc2lnbmVkIGludCB0Y3Bf
c3luX29wdGlvbnMoc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLAogCiAJ
c21jX3NldF9vcHRpb24odHAsIG9wdHMsICZyZW1haW5pbmcpOwogCi0JaWYgKHNrX2lzX21w
dGNwKHNrKSkgewotCQl1bnNpZ25lZCBpbnQgc2l6ZTsKLQotCQlpZiAobXB0Y3Bfc3luX29w
dGlvbnMoc2ssIHNrYiwgJnNpemUsICZvcHRzLT5tcHRjcCkpIHsKLQkJCW9wdHMtPm9wdGlv
bnMgfD0gT1BUSU9OX01QVENQOwotCQkJcmVtYWluaW5nIC09IHNpemU7Ci0JCX0KLQl9CisJ
bXB0Y3Bfc2V0X29wdGlvbihzayxza2Isb3B0cywgJnJlbWFpbmluZyk7CiAKIAlicGZfc2tv
cHNfaGRyX29wdF9sZW4oc2ssIHNrYiwgTlVMTCwgTlVMTCwgMCwgb3B0cywgJnJlbWFpbmlu
Zyk7CiAKLS0gCjIuMjUuMQoK

--------------eeeusMGOxTWC0yGMAG98c7bD--


