Return-Path: <stable+bounces-246834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IiEGOdqBGprIQIAu9opvQ
	(envelope-from <stable+bounces-246834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:13:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A382E532DDA
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEA7130D858E
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 12:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212363FFACB;
	Wed, 13 May 2026 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gh9vx97A"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42663FF8A1;
	Wed, 13 May 2026 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674187; cv=none; b=pIMwxw2NEBk8OeFuKW3tiHzD6RrfkvDDIt6jdpmKUQz1W3FvbFWg3TdU8hJZrKbrWRGhkVME7swmjzlip3puRVyuTWzHov4tEBP7UZxTeIHR5bf64M7MGV/DRos+yt9q3SkSrYeXVKLC75G6u2zwhtoUJUJwE8ARovmqNXzR7bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674187; c=relaxed/simple;
	bh=JKwN8dmZXEClE+fK8GUPvuEHt9gjM8rK2QbGN3Uo7gA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CxbsXiwCDNy9Y97e4PdosduiXY2hu+eRHmEWTCtjOfNhdjh9Ua8ZkzkMC9wsuvuiT+U0Xv/8DJPXhNYuyt63qqHETm732OqEMNSjHjuPO0f8uZfRhQiuieiWJSVrgDIchAWhkaFPhN32k6xWuH84wL70hIzStuodjVLpgKNsltU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gh9vx97A; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778674172;
	bh=vpbQGnXHQ6rbRoqrWc3zGGoA7XdxcAEv1U4GtZxM2bw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gh9vx97AwQUdmO02nOXX855aOsM6onpANAaQ/yztrt9p7VWWCXb46/1clNu5SR0AI
	 gBjRqX6RP4/yeqAxBHGpFB2pWESMmO1NeO8dvrQcPHv3y5StrcLExhN4wp19ZFy/tu
	 K9zrLCN+0HiBSsuWGRK8ckvIYKRTHwj/KkWza/f4=
X-QQ-mid: zesmtpip3t1778674167t5c855f5e
X-QQ-Originating-IP: hcVhJ1pdrvfrXKoRsasb6OQdrv5przJNpiKckO5dNVs=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 May 2026 20:09:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1320149752102977563
EX-QQ-RecipientCnt: 14
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: chenhuacai@kernel.org,
	chenhuacai@loongson.cn,
	dave.hansen@linux.intel.com,
	guanwentao@uniontech.com,
	kvm@vger.kernel.org,
	lixianglai@loongson.cn,
	loongarch@lists.linux.dev,
	maobibo@loongson.cn,
	ojeda@kernel.org,
	patches@lists.linux.dev,
	seanjc@google.com,
	stable@vger.kernel.org,
	zhaotianrui@loongson.cn
Subject: Re: Re: [PATCH 6.18 091/270] LoongArch: KVM: Compile switch.S directly into the kernel
Date: Wed, 13 May 2026 20:08:08 +0800
Message-Id: <20260513120808.339792-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2026051311-lullaby-wrecker-7d23@gregkh>
References: <2026051311-lullaby-wrecker-7d23@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N33rQ3fZU7lTiiiVgBRHqjfnjOR6aM2PvQy5mFRR/wU7BPjFK17mmr/e
	biN1cHRFrtLOXbAO0SxgDa6zipiHu1rAOfPZ0gzQ2FXhUu+BA9DbFD3+QMbEGi7VS0F0Ldx
	xq8aD4SS8wrUXHtQ6JwtySWo+Zc79JaASi0mIPcS7O1QtLVdqwRlffUEdaApcYCwmvRWSK2
	lS6n74Sq43wE2HOBHdSq1XIkzLGsYW7IDBniDZhAI4h++nGRXpcJpWMrwenPO6rtchYFtgN
	LnfOG9R5kjvTXKgeSXkddwyzZ9jHf8adYbKB0floAxFbjtlZ+qo+mK9eBDdhco7pOzhFvoo
	sj6ak5S0JFVTdLL3BVQMCd8POXYsfXkcXI4DvM6ufHDCEwD//9aGWYtkQQ481YMEweJxWyF
	hTADe4L9noD45lqFx416mmP4dp/Xmb7+WsbbENjR6lZoVP9wCcB7Gmsqy7/l3wtt+OJH23s
	6b+2iJEIompzvhyNJxGqtwJDzTMDfMQUrQWsGflbNnAV88T8LgoH7eoIX3hecoJLt+WDdF4
	h9yde3izGISDst6rqlUgvV0B2KHQQYt8pT8Nx0XJ4fwE1i1jREWfQcvEwfuLtB22KnEgbHk
	WI8vZJkQ+ThLkfsrwBJDjHMRU5TeyCrwRactcnm5ZePTXD0ZXk1esuM1ldDR109SB19E5Bc
	qci6uK8UNZoKR+L2x7OB56E8D1brY+cku4pZ0ZYKkzX1nq0/e3DCW2gcoFNo35UMLWDytx9
	sbG8hzNB5wViriyDXZT9o3Uj3CxwNAfbwqg9fWL0OjnMl3AQ4R3qHyPewOlQ+K2WZ9M1FOW
	oHcVzthiVTH6queEc9UAnJ3JJUBB17oDxqAC7zQSwUd8rJFjF3nEAKDAu6jNTzaeP/pglA2
	qaPcK/RPVgGPI+tGWHr39A5CUL+D7Gl4uikJWf6L5/LXt3+RvvQ+JmdQLxkE5ItPj90Mxkx
	AkIRcUHubNY73GF5EfY3ZW2lOcIHqmZqJvs9lkV0FgRMUKA5Qudacaqa3+ztfRTLrTW34mL
	pd8u8TCTTAxjKdPTxyopusAh/jwl27kkQzfs/eGB1HH8JJ6tOmUYaNHNYTXivPwCFdGdiXv
	9UyYwlBKLVTbTPvPOwOcb96PYp75VO8/tBuvAc6owHUniJJuSTlHIXom7PaPy857+VT74AJ
	5iO0focjLYX7C/g=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: A382E532DDA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246834-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,uniontech.com:mid,uniontech.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email]
X-Rspamd-Action: no action

> On Wed, May 13, 2026 at 07:58:10PM +0800, Wentao Guan wrote:
> > Hello,
> > 
> > > On Wed, May 13, 2026 at 11:06:20AM +0800, Huacai Chen wrote:
> > > > On Wed, May 13, 2026 at 5:53 AM Sean Christopherson <seanjc@google.com> wrote:
> > > > >
> > > > > On Tue, May 12, 2026, Miguel Ojeda wrote:
> > > > > > On Tue, 12 May 2026 19:38:12 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > 6.18-stable review patch.  If anyone has any objections, please let me know.
> > > > > > >
> > > > > > > ------------------
> > > > > > >
> > > > > > > From: Xianglai Li <lixianglai@loongson.cn>
> > > > > > >
> > > > > > > commit 5203012fa6045aac4b69d4e7c212e16dcf38ef10 upstream.
> > > > > > >
> > > > > > > If we directly compile the switch.S file into the kernel, the address of
> > > > > > > the kvm_exc_entry function will definitely be within the DMW memory area.
> > > > > > > Therefore, we will no longer need to perform a copy relocation of the
> > > > > > > kvm_exc_entry.
> > > > > > >
> > > > > > > So this patch compiles switch.S directly into the kernel, and then remove
> > > > > > > the copy relocation execution logic for the kvm_exc_entry function.
> > > > > > >
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> > > > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > >
> > > > > > For loongarch64, I am seeing a bunch of errors like:
> > > > > >
> > > > > >     arch/loongarch/kvm/switch.S:201:1: error: unrecognized instruction mnemonic
> > > > > >     EXPORT_SYMBOL_FOR_KVM(kvm_exc_entry)
> > > > > >     ^
> > > > > >
> > > > > > `EXPORT_SYMBOL_FOR_KVM` does not exist in 6.18. Does this need a subset
> > > > > > of commit 6276c67f2bc4 ("x86: Restrict KVM-induced symbol exports to KVM
> > > > > > modules where obvious/possible")?
> > > > >
> > > > > Either that or just convert EXPORT_SYMBOL_FOR_KVM() => EXPORT_SYMBOL_GPL().  If
> > > > > that's somewhat scriptable for ongoing LTS backports, that's probably the best
> > > > > option.  EXPORT_SYMBOL_FOR_KVM() will only work for 6.18, and the list of backports
> > > > > needed to get EXPORT_SYMBOL_FOR_MODULES() working on older LTS kernels looks to
> > > > > be non-trivial
> > > > >
> > > > > If we do end up backporting EXPORT_SYMBOL_FOR_KVM() and others, we might as well
> > > > > also grab a subset of 01122b89361e ("perf: Use EXPORT_SYMBOL_FOR_KVM() for the
> > > > > mediated APIs") to ensure a kvm_types.h stub is present on all archs.  That way
> > > > > EXPORT_SYMBOL_FOR_KVM() usage in arch-neutral code will also work.
> > > > I have already noticed Greg about this before.
> > > 
> > > You did?  Where?
> > 
> > Small problem, I guess where he means is 'stable-commits@vger.kernel.org', is a
> > not public maillist? I want to find it in 'lore.kernel.org' but not found... 
> 
> It's a public list, anyone can sign up for it.  Don't know if lore
> archives it, but I'm sure that someone does...

Thanks for your reply. It is interesting that now i found them in
https://marc.info/?l=linux-stable-commits&m=177859589029820&w=2,
and https://marc.info/?l=linux-stable-commits&m=177859840800303

BRs
Wentao Guan

