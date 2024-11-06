Return-Path: <stable+bounces-90104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643119BE4BA
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 11:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881D91C23624
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 10:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523171DE8B3;
	Wed,  6 Nov 2024 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jTpJ+aDn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MpFvolMY"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB9A1DE4F4;
	Wed,  6 Nov 2024 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890110; cv=none; b=qMSlOiMu4sWlmQLGT04XFXpaJlU2oKEvdF1AJSSLKrZwdw9CBMl504TMy4J7QzDVczS/E/H84MNJlQOsO9U2uBnKM7yY2VQ1I1kZb3VtFRO+81lWCEt91WGRcw1aWIpXXjBcqLkAeCVtn7GFrzZJW3nV+PwKEc9HkOplPTUhewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890110; c=relaxed/simple;
	bh=jXN6Z9zBVlTjYr4IfE3T0R8QowuR5UVoey4+zDa+ZKM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V9KGWhNZZ0IGuPhQrWvxtq84bml+YInqPmUuXKionP2GG/vxiimdCk5X++zlpncjxLDbOLUjPBzpQ4PdZm35QD78+/MVivljHnZj6OGcYuzzUrnsqFSZGmlw9DFGJbKbwgLznYOEqD/em7+XVoAgme5S+dcH0uezQgiCNF49oos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jTpJ+aDn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MpFvolMY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 10:48:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730890106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kmb5GZXviE53vqm21iDKDxWzClzjrvR8zT5pEl939jM=;
	b=jTpJ+aDnd4JpnHGxKOGu4uYmHoU45QIiEbtNx1Vv0KkNcqjh0d674kF6Xvvy8iXiIuok1B
	CbtJseYTSYGPYTp2h9zMsDoqsPTBgTUcoFAj3JeHQqHcQ0n1IQ3rUJiyEaYigCY5Dz313F
	Vik7jlhrMH3S74fYfyuAJBnOplWkk7WqpsUZ3G5beUdFW/qO4NLL+GymO0eBw9qM68elAq
	yR83owLE9f+1oE4mrx8DqTGGUwSLPujq2i8S35Y18dOGs2zCYi1+9DXvRNMEBsyLvBFbQh
	cFKEIIyhxgprwKUoi4oZFiL+DdpSwTD9GtSipXzZN172aUS424XKJSv+WgWVeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730890106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kmb5GZXviE53vqm21iDKDxWzClzjrvR8zT5pEl939jM=;
	b=MpFvolMYtHNFeMpFZmD94Ipup/Drvj2FZnwlbujSIfNkZWFVYurm3Snk1xgGseLs+ITqqx
	G75Gfi74o8LA3SDQ==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel/pt: Fix buffer full but size is 0 case
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241022155920.17511-2-adrian.hunter@intel.com>
References: <20241022155920.17511-2-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173089010558.32228.9070400624093862803.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5b590160d2cf776b304eb054afafea2bd55e3620
Gitweb:        https://git.kernel.org/tip/5b590160d2cf776b304eb054afafea2bd55e3620
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Tue, 22 Oct 2024 18:59:07 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Nov 2024 12:55:43 +01:00

perf/x86/intel/pt: Fix buffer full but size is 0 case

If the trace data buffer becomes full, a truncated flag [T] is reported
in PERF_RECORD_AUX.  In some cases, the size reported is 0, even though
data must have been added to make the buffer full.

That happens when the buffer fills up from empty to full before the
Intel PT driver has updated the buffer position.  Then the driver
calculates the new buffer position before calculating the data size.
If the old and new positions are the same, the data size is reported
as 0, even though it is really the whole buffer size.

Fix by detecting when the buffer position is wrapped, and adjust the
data size calculation accordingly.

Example

  Use a very small buffer size (8K) and observe the size of truncated [T]
  data. Before the fix, it is possible to see records of 0 size.

  Before:

    $ perf record -m,8K -e intel_pt// uname
    Linux
    [ perf record: Woken up 2 times to write data ]
    [ perf record: Captured and wrote 0.105 MB perf.data ]
    $ perf script -D --no-itrace | grep AUX | grep -F '[T]'
    Warning:
    AUX data lost 2 times out of 3!

    5 19462712368111 0x19710 [0x40]: PERF_RECORD_AUX offset: 0 size: 0 flags: 0x1 [T]
    5 19462712700046 0x19ba8 [0x40]: PERF_RECORD_AUX offset: 0x170 size: 0xe90 flags: 0x1 [T]

 After:

    $ perf record -m,8K -e intel_pt// uname
    Linux
    [ perf record: Woken up 3 times to write data ]
    [ perf record: Captured and wrote 0.040 MB perf.data ]
    $ perf script -D --no-itrace | grep AUX | grep -F '[T]'
    Warning:
    AUX data lost 2 times out of 3!

    1 113720802995 0x4948 [0x40]: PERF_RECORD_AUX offset: 0 size: 0x2000 flags: 0x1 [T]
    1 113720979812 0x6b10 [0x40]: PERF_RECORD_AUX offset: 0x2000 size: 0x2000 flags: 0x1 [T]

Fixes: 52ca9ced3f70 ("perf/x86/intel/pt: Add Intel PT PMU driver")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20241022155920.17511-2-adrian.hunter@intel.com
---
 arch/x86/events/intel/pt.c | 11 ++++++++---
 arch/x86/events/intel/pt.h |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index fd4670a..a087bc0 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -828,11 +828,13 @@ static void pt_buffer_advance(struct pt_buffer *buf)
 	buf->cur_idx++;
 
 	if (buf->cur_idx == buf->cur->last) {
-		if (buf->cur == buf->last)
+		if (buf->cur == buf->last) {
 			buf->cur = buf->first;
-		else
+			buf->wrapped = true;
+		} else {
 			buf->cur = list_entry(buf->cur->list.next, struct topa,
 					      list);
+		}
 		buf->cur_idx = 0;
 	}
 }
@@ -846,8 +848,11 @@ static void pt_buffer_advance(struct pt_buffer *buf)
 static void pt_update_head(struct pt *pt)
 {
 	struct pt_buffer *buf = perf_get_aux(&pt->handle);
+	bool wrapped = buf->wrapped;
 	u64 topa_idx, base, old;
 
+	buf->wrapped = false;
+
 	if (buf->single) {
 		local_set(&buf->data_size, buf->output_off);
 		return;
@@ -865,7 +870,7 @@ static void pt_update_head(struct pt *pt)
 	} else {
 		old = (local64_xchg(&buf->head, base) &
 		       ((buf->nr_pages << PAGE_SHIFT) - 1));
-		if (base < old)
+		if (base < old || (base == old && wrapped))
 			base += buf->nr_pages << PAGE_SHIFT;
 
 		local_add(base - old, &buf->data_size);
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index f5e46c0..a1b6c04 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -65,6 +65,7 @@ struct pt_pmu {
  * @head:	logical write offset inside the buffer
  * @snapshot:	if this is for a snapshot/overwrite counter
  * @single:	use Single Range Output instead of ToPA
+ * @wrapped:	buffer advance wrapped back to the first topa table
  * @stop_pos:	STOP topa entry index
  * @intr_pos:	INT topa entry index
  * @stop_te:	STOP topa entry pointer
@@ -82,6 +83,7 @@ struct pt_buffer {
 	local64_t		head;
 	bool			snapshot;
 	bool			single;
+	bool			wrapped;
 	long			stop_pos, intr_pos;
 	struct topa_entry	*stop_te, *intr_te;
 	void			**data_pages;

