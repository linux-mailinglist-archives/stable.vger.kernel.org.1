Return-Path: <stable+bounces-221564-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HX3NQOZo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221564-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:40:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 206601CB479
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E35830639CF
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC1C2BEFE8;
	Sun,  1 Mar 2026 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRYcZQCx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB8D430BB5;
	Sun,  1 Mar 2026 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328589; cv=none; b=X6ek9W3+yuIEf/O7V0T/yODDJBsjNZhjIIbsAJLk3n6rqqdz5aAqYBepj/xCEloT+zaon+HAq0FtY5KBvsY6gmMQ3IyMjBSeidu6r5J14hJRylzUWTsLAwAXuhz0KaE7run3ERac3U1EWOTL9yHPSjudREZi4QrZPPGze+mY5Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328589; c=relaxed/simple;
	bh=ylevKCBCWcRYXoqDCQYKjh/MazvjuVPCqwnZmq72niI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vns7jyC2/sbWIdkH8/rclHFqkT37gwpFHV2FFiQgPGNHmlQjOAcn4Ndw5ZGzJaBJ9PcQ+rXOsZTlRhwKio4ooGkYWGTiab060xcjObmLNxKCPrsBU+r5EIo7C4LvTX+G3zKUEIVWW7gORktFJJNCZ/GikzAgnEn0LLSpPPtg2wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRYcZQCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFE7C19421;
	Sun,  1 Mar 2026 01:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328589;
	bh=ylevKCBCWcRYXoqDCQYKjh/MazvjuVPCqwnZmq72niI=;
	h=From:To:Cc:Subject:Date:From;
	b=BRYcZQCxd1cqbaqv37KZXaFZGoZbTuM9qws7gmn/BwaO3L6SdpzuuieEWZ8yL1F79
	 KPFYbcyh/lMWuKYOFAG+4pNdJ2Rh4K23nzgEsvPL+dyJhtMDLr7uQA113fFs2FLCjt
	 fIdVlT4RUPSR2VnxVq0+XpEqDc4SyJvzDaeaN5p9LlHyp61BSLpBYz/hxXL3W493Uu
	 C5GPwh5Kx3Aq+CSXugXcP7fWISXA9hI0apsCgyCRspwClsbWqba6UEQ0t7kNaQ+Pff
	 pT9+AESUGOLC5VJLPHYjfKqFgzCVu0kw73HNPubjCfIirlfCoR+5Q7lHfrmK2jOJEV
	 14HjSNYOfxyZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mhiramat@kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Subject: FAILED: Patch "tracing: ring-buffer: Fix to check event length before using" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:29:47 -0500
Message-ID: <20260301012947.1687657-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221564-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 206601CB479
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 912b0ee248c529a4f45d1e7f568dc1adddbf2a4a Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Mon, 16 Feb 2026 18:30:15 +0900
Subject: [PATCH] tracing: ring-buffer: Fix to check event length before using

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
index bdc8010d8f482..1e7a34a31851c 100644
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





