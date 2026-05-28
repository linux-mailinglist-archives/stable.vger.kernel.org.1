Return-Path: <stable+bounces-254895-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LeXAA8tGGqyfQgAu9opvQ
	(envelope-from <stable+bounces-254895-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:54:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 578BB5F1A2B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF6CB31BC682
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D393E63BD;
	Thu, 28 May 2026 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y/0Z0els"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED643E63B9
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968870; cv=none; b=t0PBTTDxeRz6zFRmHDntSaivMV/1DJ5jXeNU5+yix1ywDl0kGZX4jAd+NW7WcAHn5TvZdrpPOm8QahOrVeRYb3I7Ka2HXtGDHFUoYxq1Z+eKVYGCThBFve1E/J0EpiT2X5HnT5PnLBbdcuxFhSqT9akDKa3v8N1JDnepJF9P03g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968870; c=relaxed/simple;
	bh=nSAc6Y2UFiDq50jJ79GWUSjN7VX1dbYluXwrAT+l/Vc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Pj8r9vPCigg6DPsGHMr9R0KkLTSEMLH0sD7Wje0btM0ezLnfRtot4K6jI+l6AzXsOBiYglsePI316iVTMh3ArM+Cc4jjSa0/BXL4SdQcFOQbKp52+iqQQwQd+Jy0ppa2y3oRJiYEpA4XxD6soxESYFaryZLK5mwgWADFhIhoZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y/0Z0els; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B950C1F000E9;
	Thu, 28 May 2026 11:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779968868;
	bh=xlZ+yj0hR4NiE81y358bSUr/g3xLQP4nsG3uLjG4HSI=;
	h=Subject:To:Cc:From:Date;
	b=y/0Z0elsFloT43xg9qb9lJuLwgSwFPeAXtsYocfMKcQkCBUx9q//lIgD6FE5Q99w+
	 TDPVPK3JFKqvavG21e+GwAN0fidxBQrh0frZ2THpmiSayCNAqvI+9KjYn2TAVGhJwZ
	 x5D0ptu6u0iEWCQs3LzjQg6MCVuk0SgyNw+hGs8k=
Subject: FAILED: patch "[PATCH] s390/pai: Fix missing PAI counter increments under heavy load" failed to apply to 6.12-stable tree
To: tmricht@linux.ibm.com,agordeev@linux.ibm.com,sumanthk@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:46:46 +0200
Message-ID: <2026052846-nibble-mankind-862a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254895-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: 578BB5F1A2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 99269799bf2448aebccee164df56c22a7b85b02c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052846-nibble-mankind-862a@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 99269799bf2448aebccee164df56c22a7b85b02c Mon Sep 17 00:00:00 2001
From: Thomas Richter <tmricht@linux.ibm.com>
Date: Tue, 5 May 2026 12:34:33 +0200
Subject: [PATCH] s390/pai: Fix missing PAI counter increments under heavy load
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Machines with a larger number of CPUs and under heavy load sometimes
loose PAI counter increments during recording using events
-e CRYPTO_ÂLL or -e NNPA_ALL. Counting is not affected.
This happens when several PAI crypto counters are incremented during
the same cryptographic operation.

During schedule out the functions

paiXXX_sched_task() (with XXX either crypt or ext)
+--> pai_have_samples()
   +--> pai_have_sample()
	+--> pai_copy()
	+--> pai_push_sample()

are called to read out PAI counter values.
In pai_copy() the current values of PAI counters are read from the
PMU memory mapped page and compared to the values read during last
schedule out operation, which have been saved in a backup page
named PAI_SAVE_AREA(event). For each PAI counter a delta is calculated
and when the delta is positive, that PAI counter was incremented by
hardware. This positve delta is reported as raw data record attached
to a sample.
After all deltas have been calculated, the new PAI counter values
are saved in the backup page PAI_SAVE_AREA(event). However this is
done in pai_push_sample(), leaving a small window for missing hardware
triggered updates. Here is one scenario:

  PAI counter idx:   0   1   2   3   4   5   6   7  ....  N
                   +---+---+---+---+---+---+---+---+    +---+
  PAI counter page:|   |   | X |   |   |   |   |   |....| Y |
                   +---+---+---+---+---+---+---+---+    +---+

In pai_copy() each PAI counter value is read and compared
to its old value. This is done in a loop. When PAI counter indexed
N is read, the hardware might increment PAI counter indexed 2 again,
updating its value from X to X+1.
Later pai_push_sample() simply mem-copies the complete PAI counter
page to a backup page and the increment of X+1 is lost, because the
backup page now contains the new value.

Read each PAI counter and save this value in the backup page when
there is a positive delta. This omits any time window between read
and store. This also reduced the work load as only modified PAI
counters are saved.

Cc: stable@vger.kernel.org
Fixes: fe861b0c8d06 ("s390/pai: save PAI counter value page in event structure")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
index f13c5c5fbea6..cdb8006220ca 100644
--- a/arch/s390/kernel/perf_pai.c
+++ b/arch/s390/kernel/perf_pai.c
@@ -186,6 +186,13 @@ static u64 pai_getctr(unsigned long *page, int nr, unsigned long offset)
 	return page[nr];
 }
 
+static void pai_setctr(unsigned long *page, int nr, unsigned long offset, u64 v)
+{
+	if (offset)
+		nr += offset / sizeof(*page);
+	page[nr] = v;
+}
+
 /* Read the counter values. Return value from location in CMP. For base
  * event xxx_ALL sum up all events. Returns counter value.
  */
@@ -551,6 +558,8 @@ static void paicrypt_del(struct perf_event *event, int flags)
 /* Create raw data and save it in buffer. Calculate the delta for each
  * counter between this invocation and the last invocation.
  * Returns number of bytes copied.
+ * After reading from PAI counter page, save the read value to the old
+ * page to calculate PAI counter deltas.
  * Saves only entries with positive counter difference of the form
  * 2 bytes: Number of counter
  * 8 bytes: Value of counter
@@ -562,16 +571,22 @@ static size_t pai_copy(struct pai_userdata *userdata, unsigned long *page,
 	int i, outidx = 0;
 
 	for (i = 1; i <= pp->num_avail; i++) {
-		u64 val = 0, val_old = 0;
+		u64 val = 0, val_old = 0, val_k = 0, val_old_k = 0;
 
 		if (!exclude_kernel) {
-			val += pai_getctr(page, i, pp->kernel_offset);
-			val_old += pai_getctr(page_old, i, pp->kernel_offset);
+			val_k = pai_getctr(page, i, pp->kernel_offset);
+			val_old_k = pai_getctr(page_old, i, pp->kernel_offset);
+			if (val_k != val_old_k)
+				pai_setctr(page_old, i, pp->kernel_offset, val_k);
 		}
 		if (!exclude_user) {
-			val += pai_getctr(page, i, 0);
-			val_old += pai_getctr(page_old, i, 0);
+			val = pai_getctr(page, i, 0);
+			val_old = pai_getctr(page_old, i, 0);
+			if (val != val_old)
+				pai_setctr(page_old, i, 0, val);
 		}
+		val += val_k;
+		val_old += val_old_k;
 		if (val >= val_old)
 			val -= val_old;
 		else
@@ -602,8 +617,6 @@ static size_t pai_copy(struct pai_userdata *userdata, unsigned long *page,
 static int pai_push_sample(size_t rawsize, struct pai_map *cpump,
 			   struct perf_event *event)
 {
-	int idx = PAI_PMU_IDX(event);
-	struct pai_pmu *pp = &pai_pmu[idx];
 	struct perf_sample_data data;
 	struct perf_raw_record raw;
 	struct pt_regs regs;
@@ -634,8 +647,6 @@ static int pai_push_sample(size_t rawsize, struct pai_map *cpump,
 
 	overflow = perf_event_overflow(event, &data, &regs);
 	perf_event_update_userpage(event);
-	/* Save crypto counter lowcore page after reading event data. */
-	memcpy((void *)PAI_SAVE_AREA(event), cpump->area, pp->area_size);
 	return overflow;
 }
 


