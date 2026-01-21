Return-Path: <stable+bounces-211174-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P6AIYo5cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-211174-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:39:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE155D6C5
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E238B50E199
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9FE3B530C;
	Wed, 21 Jan 2026 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T9Z63GkQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF80F34CFBE;
	Wed, 21 Jan 2026 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026721; cv=none; b=dePfmHY/xH1kWK0HOhNypd6yaAnyvGXnsmT4FfbDrpu8v1EZW+vv/UD046NXebVW+9aCfTNWDjx8SjToEvqvWrEu1KTXNxvqhuWThU5lZ6y/eBzvrMIp4W3tntEzUylncL2D6wb0QhrzY3/FtHc9hL1CV4EQneGM89Tz0r4dfl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026721; c=relaxed/simple;
	bh=RjVJSr08KQWPUErgvOR4YOw+Oupxn3K4eJnPIwhMvQs=;
	h=Date:To:From:Subject:Message-Id; b=NWTAzLZZbN/GuD5FWciY6LLnLUj+udnsCfrI7zjcUaWUuT17AARPx3LMwOJYSWPgaB8jPwmtFdkzz052TZQxV9G1dB2iVmJ/qxBOIRj3pqNyIPPUn5bHhlsymOve5x3xbcws2zscQJJ5Y5TkUuvqT0VW2ElYScgT2S+6R+eADA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T9Z63GkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7260DC4CEF1;
	Wed, 21 Jan 2026 20:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769026721;
	bh=RjVJSr08KQWPUErgvOR4YOw+Oupxn3K4eJnPIwhMvQs=;
	h=Date:To:From:Subject:From;
	b=T9Z63GkQZY9hfSYz55QTx9Bw8kjcMs6pAGVj74HyoAw7Iw0PvsewOQ90yqQNRzZdi
	 DhZoptjEsWwrUP7wOxN51jpeEbpE2qg+CMfe9lrxhufJieaJw3LQp58xN/FmWr6buj
	 TUBKUG6UVMLcdsEcxrQ8eMLgPBZJMuy1wzA8FfVQ=
Date: Wed, 21 Jan 2026 12:18:40 -0800
To: mm-commits@vger.kernel.org,willy@infradead.org,stable@vger.kernel.org,miklos@szeredi.hu,joannelkoong@gmail.com,bernd@bsbernd.com,jack@suse.cz,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + flex_proportions-make-fprop_new_period-hardirq-safe.patch added to mm-hotfixes-unstable branch
Message-Id: <20260121201841.7260DC4CEF1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211174-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,infradead.org,szeredi.hu,gmail.com,bsbernd.com,suse.cz,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,linux-foundation.org:dkim,suse.cz:email,infradead.org:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,bsbernd.com:email,szeredi.hu:email]
X-Rspamd-Queue-Id: EFE155D6C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch titled
     Subject: flex_proportions: make fprop_new_period() hardirq safe
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     flex_proportions-make-fprop_new_period-hardirq-safe.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/flex_proportions-make-fprop_new_period-hardirq-safe.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

------------------------------------------------------
From: Jan Kara <jack@suse.cz>
Subject: flex_proportions: make fprop_new_period() hardirq safe
Date: Wed, 21 Jan 2026 12:27:30 +0100

Bernd has reported a lockdep splat from flexible proportions code that is
essentially complaining about the following race:

<timer fires>
run_timer_softirq - we are in softirq context
  call_timer_fn
    writeout_period
      fprop_new_period
        write_seqcount_begin(&p->sequence);

        <hardirq is raised>
        ...
        blk_mq_end_request()
	  blk_update_request()
	    ext4_end_bio()
	      folio_end_writeback()
		__wb_writeout_add()
		  __fprop_add_percpu_max()
		    if (unlikely(max_frac < FPROP_FRAC_BASE)) {
		      fprop_fraction_percpu()
			seq = read_seqcount_begin(&p->sequence);
			  - sees odd sequence so loops indefinitely

Note that a deadlock like this is only possible if the bdi has configured
maximum fraction of writeout throughput which is very rare in general but
frequent for example for FUSE bdis.  To fix this problem we have to make
sure write section of the sequence counter is irqsafe.

Link: https://lkml.kernel.org/r/20260121112729.24463-2-jack@suse.cz
Fixes: a91befde3503 ("lib/flex_proportions.c: remove local_irq_ops in fprop_new_period()")
Signed-off-by: Jan Kara <jack@suse.cz>
Reported-by: Bernd Schubert <bernd@bsbernd.com>
Link: https://lore.kernel.org/all/9b845a47-9aee-43dd-99bc-1a82bea00442@bsbernd.com/
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/flex_proportions.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/lib/flex_proportions.c~flex_proportions-make-fprop_new_period-hardirq-safe
+++ a/lib/flex_proportions.c
@@ -64,13 +64,14 @@ void fprop_global_destroy(struct fprop_g
 bool fprop_new_period(struct fprop_global *p, int periods)
 {
 	s64 events = percpu_counter_sum(&p->events);
+	unsigned long flags;
 
 	/*
 	 * Don't do anything if there are no events.
 	 */
 	if (events <= 1)
 		return false;
-	preempt_disable_nested();
+	local_irq_save(flags);
 	write_seqcount_begin(&p->sequence);
 	if (periods < 64)
 		events -= events >> periods;
@@ -78,7 +79,7 @@ bool fprop_new_period(struct fprop_globa
 	percpu_counter_add(&p->events, -events);
 	p->period += periods;
 	write_seqcount_end(&p->sequence);
-	preempt_enable_nested();
+	local_irq_restore(flags);
 
 	return true;
 }
_

Patches currently in -mm which might be from jack@suse.cz are

flex_proportions-make-fprop_new_period-hardirq-safe.patch


