Return-Path: <stable+bounces-220915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG+yON9bo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:19:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA001C8EDF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16C2133C3E83
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7F74A139F;
	Sat, 28 Feb 2026 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6667ocq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A2942B3AD;
	Sat, 28 Feb 2026 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300803; cv=none; b=joh/RT/a15j9fWXbI5zXCabZSp1nNkXEphcXiwNy/GN0XphfLvc5ICKXyJwnwXFfkT2SOps4zi8J87N9c1bMn/07vtUqSvbILzBMYTr0Xv8xKZry4W+T/ixL2kx+9fzAuycwTrwNix/BYg/9vWtG4vWx0565wZZTFxqKUimA0N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300803; c=relaxed/simple;
	bh=jMounPxqv3isWkbawRiFG1IEvs2hnYQdhs0x/ep8b94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRDW/QHQDmdrIBp6dqcFbQG/onrrsJNlOIauX+l8wCUacdBEjoP+o237Hzev2e860mFqzO9BP5oK0LUAA4LFyGOeSEaL/ldG/SgP0xj6nf/mxfnQxb0s9MBFvaY/RsKpFFi+nf8EiUImu+KpryUJynbZKbDDMzFXU7Mbj4bkSvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6667ocq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130F3C19425;
	Sat, 28 Feb 2026 17:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300803;
	bh=jMounPxqv3isWkbawRiFG1IEvs2hnYQdhs0x/ep8b94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o6667ocq2xA1hNZtjjuUOWqpkkcUMj+7cWGjPReKscthlxolZEYILTMfXscst5bpp
	 WoMg6qrEXolA2R+fZEVxx/ZtxDTG22hoWOqs2O0029BseDK3ponHOwG9ru7WN7n3BD
	 U7n8u+zABqCaJYigwAsZLk4r02mf2QGyeJP5RqlQPEBA79fyaIVjfETmHlHtTR1Sg7
	 JMMr9/oOLAuA4xMEm+pVRiYxhti/hAFnAKP+y36C17/oMKgrLS6TF9uo5ZcmySm+eK
	 5OgyjFzPqMHFuTd2J6IAfTReBbSMkXcx8YTgjG/09BcdIB60zQ0FJM1IvWyp1tQ6LM
	 KGrHt0iXCC8kg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 836/844] tracing: ring-buffer: Fix to check event length before using
Date: Sat, 28 Feb 2026 12:32:29 -0500
Message-ID: <20260228173244.1509663-837-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220915-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goodmis.org:email,msgid.link:url,efficios.com:email]
X-Rspamd-Queue-Id: 5EA001C8EDF
X-Rspamd-Action: no action

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit 912b0ee248c529a4f45d1e7f568dc1adddbf2a4a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ad08430347b06..2f44063c666f2 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1848,6 +1848,7 @@ static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu
 	struct ring_buffer_event *event;
 	u64 ts, delta;
 	int events = 0;
+	int len;
 	int e;
 
 	*delta_ptr = 0;
@@ -1855,9 +1856,12 @@ static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu
 
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


