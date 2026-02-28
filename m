Return-Path: <stable+bounces-221204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mExiBNpIo2l//AQAu9opvQ
	(envelope-from <stable+bounces-221204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:58:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7271C7A8A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3B1C34D68A1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4F8375246;
	Sat, 28 Feb 2026 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szh/88JX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C389F375241;
	Sat, 28 Feb 2026 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301560; cv=none; b=nuIQOSZKjrRzYMpOH69f0+3gd1pc3VuFIaSn6/KAYRTcRu2KTYJhzz2kvFqCxYkUzC0iwa83IhpyvuaSfPQSFmsXoOXRX+d8q39rgLsmmNIz/ixmWdI6QUCWf9cTwJjKY141GboESxFAYuPBWitrUBCQZfAcDcGvbz4k0k49TxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301560; c=relaxed/simple;
	bh=sJfuBX6VYbPqMzLg2pC8OYm4UGV1OA4OKUuxO8jfG+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuSo/6RXoKDtTl+xEWqdn4zMJlgRbdTzaUPzrQOzHb/arnqFHaJQXdkX6zC360GaNOPwGlAQ5GmRLhCO5qdPB4hC+SIw1B6QTsvMCLbz/yVp011TYiMm9WKnFmCagJDwtQkwnrYU5/i0TQT6Zs7zXj12M+zoCXY9gai3SUUamYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szh/88JX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CCBC116D0;
	Sat, 28 Feb 2026 17:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301560;
	bh=sJfuBX6VYbPqMzLg2pC8OYm4UGV1OA4OKUuxO8jfG+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=szh/88JXv7ig/NghYji6VG078MOqKFeev3Pq92CXsQ1q2hPCL5KLV6K8n2qvuZ+jd
	 60xK0So9rCsv/WS8c9sC/jbAP1lI4f0P5djiZEOcMI96UNDvPgZqpHRHKpaSdVWCTk
	 9DILfMenqWA9a9EwJcU9tGgSGhynbOKaUFkqPJc2edLB/mYx/0qOQU9nHUpU01wQHp
	 qvl+UEq0sUX7aib4uf9qf/203CSVal3TqtXDwob8AAAnljz5wMr8I8r0Hi4u6WFWR8
	 xRyHXh8zshEnrn4ih6g9YuoyfeEutTj5yCCNKE8P55XO9f934RLFHdnv24TIu6XyUG
	 XxI5xLltwPdpQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	stable@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 744/752] tracing: ring-buffer: Fix to check event length before using
Date: Sat, 28 Feb 2026 12:47:35 -0500
Message-ID: <20260228174750.1542406-744-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-221204-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,efficios.com:email,goodmis.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C7271C7A8A
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
index fdb3153bbf487..54d70bd0a3cb9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1813,6 +1813,7 @@ static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu
 	struct ring_buffer_event *event;
 	u64 ts, delta;
 	int events = 0;
+	int len;
 	int e;
 
 	*delta_ptr = 0;
@@ -1820,9 +1821,12 @@ static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu
 
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


