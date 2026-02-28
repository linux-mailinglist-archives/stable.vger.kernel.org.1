Return-Path: <stable+bounces-220346-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC1zFqY0o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220346-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C50941C5E88
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 399163161004
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2105447F2F0;
	Sat, 28 Feb 2026 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5KW0X4N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D549939B97D;
	Sat, 28 Feb 2026 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300244; cv=none; b=tBXKN1rVVSU49M40Wo9paBcEKwKvUs6lgKZIfdJYc6/YbPDkpeq6X0IOVesMHEo4erxd0VDlLm7pKCVr+MItUvVIQ8LOBfu9FsypzCGRjHTIRyRDIBuYhI/orKjXh5ZcoTiQu5fwOMauvfNvRpM+x89Apdy/7SsaKVPZP1rGwvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300244; c=relaxed/simple;
	bh=nzItiEz8QVYN0Ia+mYqox2oKSRk3JCPx68U3AHsJe1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hN3cEZvKNMjBfEK2rN5qU5gSNJNRJhbMwvuIuWqBvjC5un31OD0BpP0ki82Nf649BZdwmUqAKUC3sAUDLTuHBh6mnEgRIbm6BrTZvCzWYxLqxjYt1pkZKt2y/Lz67ZnW45jTkGdjPuwAc2hKmD8+Dijvc8XDAlaugPlIwUz61tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5KW0X4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED3DC19423;
	Sat, 28 Feb 2026 17:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300244;
	bh=nzItiEz8QVYN0Ia+mYqox2oKSRk3JCPx68U3AHsJe1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5KW0X4NAOm1XgmrL/tHUukxDBfAh+4LwfOQTw1nYNZCSg/1R67pjevxZb0pJdVr/
	 /wtFfrR6Ln4AgkgAOXBIkfH6NjlhCI97qCk2zB6xIcdOjYCiOD1420XJu4fqPa0vI6
	 e8vB7LDmfNqiDqQYSl1qberfUa2U52VUlsUJ3ffuJJvHJuSUeLSGG/nBBr8Py19e8U
	 W3gvCqTjjRE08fiMNTjBlBWA8yKXcOhqLAQkiRY455V8iDLyf2I9g4EwfrU27nu1uA
	 eSYz/ZWdr6M4503YhQ2VXBiC6k5jEjc5Z0qTltbQg8e81F8TdOasBDHa2VeagaiPsy
	 mLVk5krfzZUNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 268/844] rtla: Fix NULL pointer dereference in actions_parse
Date: Sat, 28 Feb 2026 12:23:01 -0500
Message-ID: <20260228173244.1509663-269-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220346-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C50941C5E88
X-Rspamd-Action: no action

From: Wander Lairson Costa <wander@redhat.com>

[ Upstream commit a0890f9dbd24b302d327fe7dad9b9c5be0e278aa ]

The actions_parse() function uses strtok() to tokenize the trigger
string, but does not check if the returned token is NULL before
passing it to strcmp(). If the trigger parameter is an empty string
or contains only delimiter characters, strtok() returns NULL, causing
strcmp() to dereference a NULL pointer and crash the program.

This issue can be triggered by malformed user input or edge cases in
trigger string parsing. Add a NULL check immediately after the strtok()
call to validate that a token was successfully extracted before using
it. If no token is found, the function now returns -1 to indicate a
parsing error.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Link: https://lore.kernel.org/r/20260106133655.249887-13-wander@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/tracing/rtla/src/actions.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index 8945aee58d511..15986505b4376 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -141,6 +141,8 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 
 	strcpy(trigger_c, trigger);
 	token = strtok(trigger_c, ",");
+	if (!token)
+		return -1;
 
 	if (strcmp(token, "trace") == 0)
 		type = ACTION_TRACE_OUTPUT;
-- 
2.51.0


