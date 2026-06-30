Return-Path: <stable+bounces-269984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /0voAY/QQ2qSjAoAu9opvQ
	(envelope-from <stable+bounces-269984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 16:19:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6AB6E5572
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 16:19:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=goodmis.org (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269984-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269984-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B54731142DF
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 14:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF00A34041C;
	Tue, 30 Jun 2026 14:14:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B4A368D4B;
	Tue, 30 Jun 2026 14:14:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828872; cv=none; b=eZnxxqjIH0yfUWYU370xd9R2wwFvmPn9T/qIzQX+NH0cSfEDIaxZXIH2uKQovHG7v2dGL3HoH7ys5CXsKFb5Tj2HUvC5SbCJgYjiwmaTwSufucy74MJeJk3gT2hk/FiGIOpZ+4fiu6kO1zk+S8PGujne/1YkgssJfuxd5WTZfkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828872; c=relaxed/simple;
	bh=PwH310FBQTBvdHCoLfGzmSrANp3Bqt2FpZDKA7Nhyk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUZKrjzc0X7Vl9Q2LOaS+mfaBTQw2lq7EqoOyviD+sxoWv7bA5G1R6ZTgXikg/h/NSw4IUcE5k/DNgLwVtEv/A6Xdxyr5jJKMDqa4xDW3p9wEGkbGp9xj65QOpK6iPrzm8GCINrFu2yxXVewnvTlOVxvJEAoKFK2WHWL0qDtOak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 0FEBF403E0;
	Tue, 30 Jun 2026 14:14:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id DCA7332;
	Tue, 30 Jun 2026 14:14:26 +0000 (UTC)
Date: Tue, 30 Jun 2026 10:14:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Petr Pavlu <petr.pavlu@suse.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com
Subject: Re: [PATCH] ring-buffer: serialize read-page order with subbuffer
 resize
Message-ID: <20260630101425.2f7cfbea@robin>
In-Reply-To: <20260628004653.28065-1-alhouseenyousef@gmail.com>
References: <20260628004653.28065-1-alhouseenyousef@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7cyemezwwtjp9i8xnwhcd9wdf9fqtk7h
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19L+GwPBECdO2so7eCvp2QiHCbJnt0mzyA=
X-HE-Tag: 1782828866-826489
X-HE-Meta: U2FsdGVkX1+K2fEh98m5XirtWDc/lRmH2GJcUL11VG+llqtyQQg8h+Fzi4h47dG1P77zbXgabiZ+wTsJ8ZVfPszC0FkZ2+lFCUBqZvnktLuSyHMS2o+TTra7oGpVh7ncx8cL1uPCDHubH+/0mN2cKVdFG+YZ0yQ1fopaWMs1eBdyOi12ZRnXrKE/gTKKiqE7mt+/PMwj4/YYSui4ua4jYVMS8dGGe44P4QGVFZmPOpW1oJ1mODVjzLuIjLMNaLjq30wLnyh2f60gxr5hPEHBvb+WZNKJ+AxLUbDuD6Mudye1LY0quxDwvLUCKf9G0c3+8wZjukV1WFIuxMD4p/g2kzaChxM8ji+0groZCrAYlsVdZ2lSdlAV8njxOHQLNzoaxE9dnswBCw1GjmhAURfUXK8h8BUa4fbZ8l8F+9+KFo5ztZ7eiPCyw8A984kCMPgT347ez1U0pMru0Z5eyvE7XlLtr0Zogcs1ajVd27L0m1g=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269984-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:petr.pavlu@suse.com,m:linux-trace-kernel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rostedt@goodmis.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,2dd9d02f60775ce5c1fb];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,syzkaller.appspot.com:url,appspotmail.com:email,goodmis.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E6AB6E5572

On Sun, 28 Jun 2026 02:46:53 +0200
Yousef Alhouseen <alhouseenyousef@gmail.com> wrote:

> ring_buffer_read_page() checks that its spare page has the current
> subbuffer order before taking cpu_buffer->reader_lock. A concurrent
> ring_buffer_subbuf_order_set() can change the order and replace the
> reader page after that check. The reader then copies a larger subbuffer
> into the old allocation, causing an out-of-bounds write.
> 
> Keep spare-page allocation and release under buffer->mutex, which already
> serializes order changes. Move the read-side order check under
> reader_lock, the lock used by resize when replacing per-CPU pages.
> 
> Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
> Reported-by: syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2dd9d02f60775ce5c1fb
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  kernel/trace/ring_buffer.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 56a328e94395..eed5d7cffdee 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6950,6 +6950,8 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
>  	if (!cpumask_test_cpu(cpu, buffer->cpumask))
>  		return ERR_PTR(-ENODEV);
>  
> +	guard(mutex)(&buffer->mutex);
> +
>  	bpage = kzalloc_obj(*bpage);

First, do not grab locks around allocations unless the are really needed.
This is bad practice, as it extends the critical section and may even add
the allocation locking to the lock chain.

That said, just moving things around the current locks should work.

Like this (not compiled nor tested):

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 56a328e94395..8352f935a223 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6954,11 +6954,11 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (!bpage)
 		return ERR_PTR(-ENOMEM);
 
-	bpage->order = buffer->subbuf_order;
 	cpu_buffer = buffer->buffers[cpu];
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
+	bpage->order = buffer->subbuf_order;
 	if (cpu_buffer->free_page) {
 		bpage->data = cpu_buffer->free_page;
 		cpu_buffer->free_page = NULL;
@@ -7007,13 +7007,13 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 	 * is different from the subbuffer order of the buffer -
 	 * we can't reuse it
 	 */
-	if (page_ref_count(page) > 1 || data_page->order != buffer->subbuf_order)
+	if (page_ref_count(page) > 1)
 		goto out;
 
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
-	if (!cpu_buffer->free_page) {
+	if (!cpu_buffer->free_page && data_page->order == buffer->subbuf_order)
 		cpu_buffer->free_page = dpage;
 		dpage = NULL;
 	}
@@ -7091,15 +7091,15 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	if (!data_page || !data_page->data)
 		return -1;
 
-	if (data_page->order != buffer->subbuf_order)
-		return -1;
-
 	dpage = data_page->data;
 	if (!dpage)
 		return -1;
 
 	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 
+	if (data_page->order != buffer->subbuf_order)
+		return -1;
+
 	reader = rb_get_reader_page(cpu_buffer);
 	if (!reader)
 		return -1;

-- Steve

