Return-Path: <stable+bounces-233781-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPc9F2H61Wn4/gcAu9opvQ
	(envelope-from <stable+bounces-233781-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 08:49:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F31B43B7B7B
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 08:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0F3E30156DD
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 06:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E232F2D0C63;
	Wed,  8 Apr 2026 06:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tt7cVkv/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D3B22370A
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 06:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775630936; cv=none; b=oJvKPvKvE5voVryPKMplt4hP/kHnYA8MUrnGn5sE4aUrIHc3pyuMfqeEkJNv63/b9R1wlKJUwbPVwL7evb4TYQeeNlEF6bSiz/42lQMYJbaKu/coJxelmzf4a0jzc+ARCCFWjTOupmMF/8adykwSYZRF51Zt72glnH+P/mmCqlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775630936; c=relaxed/simple;
	bh=jZNCjH41g5kyzOhrD+WS3N6pA9KECsVLdomfNqlwwJQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f1MJzY0HXHjpgwihqXq6IoI4U/4jF6gisJJ1IJvHNXWAqUcQvwaiU04yuS2/tRJo7WP7G9sNtWzNEz5NrwwznS00VHCsfe6fi7XITBgwvP5y1nKDnxQ7tM3QNWnZ4jLZL2B9KohWQ6kv3x5sP0LjEet134gloVpooPuIfrQ+Z6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tt7cVkv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018B0C19424;
	Wed,  8 Apr 2026 06:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775630936;
	bh=jZNCjH41g5kyzOhrD+WS3N6pA9KECsVLdomfNqlwwJQ=;
	h=Subject:To:Cc:From:Date:From;
	b=Tt7cVkv/ac3UbN1Q5XV9nrb92pH59WD1i/+P5OlXXoEhWQo3xMm0MBLnSW8+Uxn+8
	 TpdFAyvEsUz8kOdOU/sWJxOc4M9rJkXdtHN+6asvl6DpLWM4WNR2VTUBNP4To33g/3
	 vMaEY+DeFx9AzdumyXLIxzGoi5zdGxsf+FgUWl3U=
Subject: FAILED: patch "[PATCH] s390/cpum_sf: Cap sampling rate to prevent lsctl exception" failed to apply to 5.10-stable tree
To: tmricht@linux.ibm.com,brueckner@linux.ibm.com,gor@linux.ibm.com,sumanthk@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 08:48:42 +0200
Message-ID: <2026040842-raging-spruce-08f8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233781-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: F31B43B7B7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 57ad0d4a00f5d3e80f33ba2da8d560c73d83dc22
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040842-raging-spruce-08f8@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 57ad0d4a00f5d3e80f33ba2da8d560c73d83dc22 Mon Sep 17 00:00:00 2001
From: Thomas Richter <tmricht@linux.ibm.com>
Date: Fri, 6 Mar 2026 13:50:31 +0100
Subject: [PATCH] s390/cpum_sf: Cap sampling rate to prevent lsctl exception

commit fcc43a7e294f ("s390/configs: Set HZ=1000") changed the interrupt
frequency of the system. On machines with heavy load and many perf event
overflows, this might lead to an exception. Dmesg displays these entries:
  [112.242542] cpum_sf: Loading sampling controls failed: op 1 err -22
One line per CPU online.

The root cause is the CPU Measurement sampling facility overflow
adjustment. Whenever an overflow (too much samples per tick) occurs, the
sampling rate is adjusted and increased. This was done without observing
the maximum sampling rate limit. When the current sampling interval is
higher than the maximum sampling rate limit, the lsctl instruction raises
an exception. The error messages is the result of such an exception.
Observe the upper limit when the new sampling rate is recalculated.

Cc: stable@vger.kernel.org
Fixes: 39d4a501a9ef ("s390/cpum_sf: Adjust sampling interval to avoid hitting sample limits")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index c92c29de725e..7bfeb5208177 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1168,6 +1168,7 @@ static void hw_collect_samples(struct perf_event *event, unsigned long *sdbt,
 static void hw_perf_event_update(struct perf_event *event, int flush_all)
 {
 	unsigned long long event_overflow, sampl_overflow, num_sdb;
+	struct cpu_hw_sf *cpuhw = this_cpu_ptr(&cpu_hw_sf);
 	struct hw_perf_event *hwc = &event->hw;
 	union hws_trailer_header prev, new;
 	struct hws_trailer_entry *te;
@@ -1247,8 +1248,11 @@ static void hw_perf_event_update(struct perf_event *event, int flush_all)
 	 * are dropped.
 	 * Slightly increase the interval to avoid hitting this limit.
 	 */
-	if (event_overflow)
+	if (event_overflow) {
 		SAMPL_RATE(hwc) += DIV_ROUND_UP(SAMPL_RATE(hwc), 10);
+		if (SAMPL_RATE(hwc) > cpuhw->qsi.max_sampl_rate)
+			SAMPL_RATE(hwc) = cpuhw->qsi.max_sampl_rate;
+	}
 }
 
 static inline unsigned long aux_sdb_index(struct aux_buffer *aux,


