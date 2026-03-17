Return-Path: <stable+bounces-225738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPr5EGreuGmpkgEAu9opvQ
	(envelope-from <stable+bounces-225738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 05:54:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B796D2A3D64
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 05:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D946830333B0
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 04:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C1634FF47;
	Tue, 17 Mar 2026 04:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="PyqfIhz2"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6449D33986F;
	Tue, 17 Mar 2026 04:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773722782; cv=pass; b=C5w11Xt287igygiXK0nLfbNHuYYDUzL4KXfafXXxst7NuP0jWC18HOFmo8dKBcS3YFhld8+CBkj2sga8pfOLQzVRD4Q69YAI96gJOTATxntIzWCOpBuXFYUb00vkkKCKgANinE6Jx1O/7tJ64HtkGNvYr/t6GHfZvJ0hkRfONvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773722782; c=relaxed/simple;
	bh=kVg/3qBxeC7RIRHRbkFU60OP6mqSFzjx+ICsDZMOv08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAJWZ1h4N2ObAYf9C8DVY6CcjJomskCYWvkiPUAs64k+VMFAzheZrDIC+FVEP4ARtSiXBv+PO4eDD/45Iyr+wBRhncHbSV8He61whfxd+udKaVxyKGGV+YXkW+OFYXlGvlSlVcxLHIrty5wIxK9b5rtD06iXLeka88uxrKYCHW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=PyqfIhz2; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1773722720; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RvD/C0178NU1LwJEkSg2UFnPK19fryVEEEn4KH1SuSSNoKbCxy9CLexhK+PWYoMvqFtvy9AEretvZR5Q+W53mvYc1Q3uTjxfrcau3ZYo7nLcsF7qcFYdlx2zfl9e/bPy65olb/oW4z0lC/mFwSLlWj3M9F3HWdvPoCYgocBQfK4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773722720; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MZtGcjgstCOwi90UqZfYqyQ9iZiBcfojTGxX5RIebuY=; 
	b=JlP1Q9OoOBvGuVB4qdDtUbzeSCIQFGCsWGwfLhDcmeCWkQt8eIWr4mFE0T3kny7nqYzxJv6vYc77IN1iBxJyPrY8zwfoWS+c89X/KVhr6I4CoSthUJ32n4nhs+Ye0of2hteJ23YzAydUsXIatKAKhznE9CxUEtMWECvlvsnLuV4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773722720;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=MZtGcjgstCOwi90UqZfYqyQ9iZiBcfojTGxX5RIebuY=;
	b=PyqfIhz2A+D4PU3lO2lI8y/tSQIinoROefawYKrjEtzapgOROW0tQOakEFk2ZAcc
	xAPFyKTDxclE6kiWf3fINMPhdWHqGErfmylRD+Bu8j27sSIwbTFEPaimumoXYZmbeXc
	1EAZc0aPk0qLhwZU9sf4Jc4gTc3zECp4f/UPY6zw=
Received: by mx.zohomail.com with SMTPS id 1773722718208506.92900941934556;
	Mon, 16 Mar 2026 21:45:18 -0700 (PDT)
Date: Tue, 17 Mar 2026 04:45:05 +0000
From: Yao Zi <me@ziyao.cc>
To: Paul Chaignon <paul.chaignon@gmail.com>, rsworktech@outlook.com
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Amery Hung <ameryhung@gmail.com>, linux-riscv@lists.infradead.org,
	stable@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH bpf v3] bpf: do not use kmalloc_nolock when
 !HAVE_CMPXCHG_DOUBLE
Message-ID: <abjcUSXWiShiuMvH@pie>
References: <20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com>
 <abgcKvuSQc2ZYKw4@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abgcKvuSQc2ZYKw4@mail.gmail.com>
X-ZohoMailClient: External
X-Spamd-Result: default: False [9.34 / 15.00];
	URIBL_BLACK(7.50)[ziyao.cc:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[ziyao.cc:s=zmail];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225738-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,linutronix.de,goodmis.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,vger.kernel.org,lists.linux.dev];
	DMARC_POLICY_ALLOW(0.00)[ziyao.cc,quarantine];
	TAGGED_RCPT(0.00)[stable];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@ziyao.cc,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[ziyao.cc:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.372];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,ziyao.cc:dkim]
X-Rspamd-Queue-Id: B796D2A3D64
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

On Mon, Mar 16, 2026 at 04:05:14PM +0100, Paul Chaignon wrote:
> On Sun, Mar 15, 2026 at 12:02:48AM +0800, Levi Zim via B4 Relay wrote:
> > From: Levi Zim <rsworktech@outlook.com>
> > 
> > kmalloc_nolock always fails for architectures that lack cmpxchg16b.
> > For example, this causes bpf_task_storage_get with flag
> > BPF_LOCAL_STORAGE_GET_F_CREATE to fails on riscv64 6.19 kernel.
> > 
> > Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
> > But leave the PREEMPT_RT case as is because it requires kmalloc_nolock
> > for correctness. Add a comment about this limitation that architecture's
> > lack of CMPXCHG_DOUBLE combined with PREEMPT_RT could make
> > bpf_local_storage_alloc always fail.
> > 
> > Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock() in local storage")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Levi Zim <rsworktech@outlook.com>
> > ---
> 
> Note there may be something broken with your setup as lore is reporting
> that you sent this v3 email three times. Not sure if it could be an
> issue.

Once is because linux-riscv@lists.infradead.org adds a trailer when
forwarding messages but keeps the Message-ID unchanged, so lore indexed
one extra message with the same ID but different content, it was not
Levi doing something wrong.

The other message has the same content but a different From line, not
sure what happened to it. Differences of the messages could be viewed
here[1].

Regards,
Yao Zi

[1]: https://lore.kernel.org/all/20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com/d/

