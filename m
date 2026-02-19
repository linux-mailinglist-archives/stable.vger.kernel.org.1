Return-Path: <stable+bounces-217504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMyZFn13l2nVywIAu9opvQ
	(envelope-from <stable+bounces-217504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:50:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EA11626FD
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD1583024101
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 20:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77536324B1B;
	Thu, 19 Feb 2026 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQxpxRiV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A066305046;
	Thu, 19 Feb 2026 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771534198; cv=none; b=bIxrN29LHiqjFtb1MSAqUbT+Sz0RUXwhiv8bUXZ8gvENb35O8wOCLLua0IWchVBNO2FBRYCt/UKlij3pOlOIR+qn/yFLvC6gpkcPNovu7oJAKiuj0xnRIEkPQlUlSkSYj+Jc4MNltP3NKO1IafrgEqHTf6kJiye1W73t1behBFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771534198; c=relaxed/simple;
	bh=Zx0ti0jVzUuhmoWynho4C2x3w4ZJLsTXibCqmw70nTs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fP+KjzZm1wWgYGI+tmcI3RvBeHAoUS7fQdPS5/o9LGNGjhLOz5+Xb8Xpvaxc4PIpEO5ir8TcBtlWKNmxwJAtRjneXd8OPdyFNQuyWedPpY8geltb3oAR0H2QCB5AoRHcm6d7YuBhS0TU3vVmbjeUpCS24VeIMdU4uX++nuJwra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQxpxRiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEFAC19424;
	Thu, 19 Feb 2026 20:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771534198;
	bh=Zx0ti0jVzUuhmoWynho4C2x3w4ZJLsTXibCqmw70nTs=;
	h=Date:From:To:Cc:Subject:References:From;
	b=kQxpxRiV6kaBqqatfhUs8BfTJri+s7x16LjppowASSDxcgwZuj+10AiOlEW7vbpyo
	 r9nlSpTF1gkVS7sGhp+0J/rvlbIXVRMxWJvjaV/wOUG7YzWrsT7aYN2Rq0KL3MqaIg
	 C0eRCQadqJ8l0qerxR+1g6lE9fD7s4gPfv0yCGDSp7YnPIiHHpSFPuggb4DX0B+I/9
	 bIWygVRbe/rd2R9YVRCWQWxCnvtpXFoe0fzSIHJzHHieQ8qh9qa2kAtbdjXklM7iXV
	 zPOaBkGGkNVL2eWR1hWF3y/3eOuZkC7pxwgucLNgVnzNUIsCi8JJDRWgebQwsyrRjb
	 N/tY1AvnkEcgg==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vtAyL-00000000kfo-02aj;
	Thu, 19 Feb 2026 15:50:05 -0500
Message-ID: <20260219205004.867911772@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 19 Feb 2026 15:49:49 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 2/5] tracing: ring-buffer: Fix to check event length before using
References: <20260219204947.830172370@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-217504-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goodmis.org:email]
X-Rspamd-Queue-Id: 70EA11626FD
X-Rspamd-Action: no action

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Check the event length before adding it for accessing next index in
rb_read_data_buffer(). Since this function is used for validating
possibly broken ring buffers, the length of the event could be broken.
In that case, the new event (e + len) can point a wrong address.
To avoid invalid memory access at boot, check whether the length of
each event is in the possible range before using it.

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 5f3b6e839f3c ("ring-buffer: Validate boot range memory events")
Link: https://patch.msgid.link/177123421541.142205.9414352170164678966.stgit@devnote2
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index bdc8010d8f48..1e7a34a31851 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1849,6 +1849,7 @@ static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu
 	struct ring_buffer_event *event;
 	u64 ts, delta;
 	int events = 0;
+	int len;
 	int e;
 
 	*delta_ptr = 0;
@@ -1856,9 +1857,12 @@ static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu
 
 	ts = dpage->time_stamp;
 
-	for (e = 0; e < tail; e += rb_event_length(event)) {
+	for (e = 0; e < tail; e += len) {
 
 		event = (struct ring_buffer_event *)(dpage->data + e);
+		len = rb_event_length(event);
+		if (len <= 0 || len > tail - e)
+			return -1;
 
 		switch (event->type_len) {
 
-- 
2.51.0



