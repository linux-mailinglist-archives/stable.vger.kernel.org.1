Return-Path: <stable+bounces-220559-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFLPJZY+o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220559-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:14:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA651C6BAE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0890631918B1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90EA481FD7;
	Sat, 28 Feb 2026 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/WjtO0O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F143D8358;
	Sat, 28 Feb 2026 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300440; cv=none; b=juTXX/qWerGqyPKBj+YVqwAVrWQ7Bo1z1aVkgoVc8JHX9u5NhQUaanT080Wh6V86yiMNaIONsZalnHtFRlVeC125srq1IgeFw3BFCvzH6Q/wlxb2gg1Lp+9AMh2MQhyJPbP0EXL+01mjU60BfKCreEoUrkn/erszSxppHbTjg4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300440; c=relaxed/simple;
	bh=KC4k2oJe8InnAy4iSiJf0CgxbA7L6xle0i7Jgq9Ivr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQvIEkpeO7mne1yzogQxrLTHe/14v8f0jkBeMTO9V7Au1GXXZxthDUVhICu4/2Gl0fa0bu6VAxBTqOvlcT2GzK97449pEcM7AKb0CUyH8iFBEBgGu1pvfRaz4HbqTcTS8iA+5vSpCStnjR48bSzdV+Sv4fFM+UM2r4sVDlESDFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/WjtO0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD111C19423;
	Sat, 28 Feb 2026 17:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300440;
	bh=KC4k2oJe8InnAy4iSiJf0CgxbA7L6xle0i7Jgq9Ivr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/WjtO0OKq7etolDBucE75ghglawTgd7uxM9/7y71a9UCcFnyxBfbiaaXY6kqg8v5
	 juDwVofrfFR+1IxeXEsWd8nsT1ogVzoImhZizybThNskc+8Iw3uMa5AYwM4C/s+y2c
	 ywByWkGvcOYNLanlX3Z45vr+yN5DgafF0tkZFvQGLSGXovYYPOaMwEcs/kWhG3+eYi
	 eIR0dcNUXA/phnYkM6I1E4rPGgF38ehPxfobAABQXyqBvwUCjHLO4lx9uPSWJrCESU
	 blXxFminlWKIy40IEYyyobinGJ4hhVYlRuq7D6PHxFZ5O+bkZejJK/o/gHOedSgRgx
	 JCKWWrH4H9XQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tung Nguyen <tung.quang.nguyen@est.tech>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 480/844] tipc: fix duplicate publication key in tipc_service_insert_publ()
Date: Sat, 28 Feb 2026 12:26:33 -0500
Message-ID: <20260228173244.1509663-481-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-220559-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EEA651C6BAE
X-Rspamd-Action: no action

From: Tung Nguyen <tung.quang.nguyen@est.tech>

[ Upstream commit 3aa677625c8fad39989496c51bcff3872c1f16f1 ]

TIPC uses named table to store TIPC services represented by type and
instance. Each time an application calls TIPC API bind() to bind a
type/instance to a socket, an entry is created and inserted into the
named table. It looks like this:

named table:
key1, entry1 (type, instance ...)
key2, entry2 (type, instance ...)

In the above table, each entry represents a route for sending data
from one socket to the other. For all publications originated from
the same node, the key is UNIQUE to identify each entry.
It is calculated by this formula:
key = socket portid + number of bindings + 1 (1)

where:
 - socket portid: unique and calculated by using linux kernel function
                  get_random_u32_below(). So, the value is randomized.
 - number of bindings: the number of times a type/instance pair is bound
                       to a socket. This number is linearly increased,
                       starting from 0.

While the socket portid is unique and randomized by linux kernel, the
linear increment of "number of bindings" in formula (1) makes "key" not
unique anymore. For example:
- Socket 1 is created with its associated port number 20062001. Type 1000,
instance 1 is bound to socket 1:
key1: 20062001 + 0 + 1 = 20062002

Then, bind() is called a second time on Socket 1 to by the same type 1000,
instance 1:
key2: 20062001 + 1 + 1 = 20062003

Named table:
key1 (20062002), entry1 (1000, 1 ...)
key2 (20062003), entry2 (1000, 1 ...)

- Socket 2 is created with its associated port number 20062002. Type 1000,
instance 1 is bound to socket 2:
key3: 20062002 + 0 + 1 = 20062003

TIPC looks up the named table and finds out that key2 with the same value
already exists and rejects the insertion into the named table.
This leads to failure of bind() call from application on Socket 2 with error
message EINVAL "Invalid argument".

This commit fixes this issue by adding more port id checking to make sure
that the key is unique to publications originated from the same port id
and node.

Fixes: 218527fe27ad ("tipc: replace name table service range array with rb tree")
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260220050541.237962-1-tung.quang.nguyen@est.tech
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/name_table.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
index e74940eab3a47..7f42fb6a8481f 100644
--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -348,7 +348,8 @@ static bool tipc_service_insert_publ(struct net *net,
 
 	/* Return if the publication already exists */
 	list_for_each_entry(_p, &sr->all_publ, all_publ) {
-		if (_p->key == key && (!_p->sk.node || _p->sk.node == node)) {
+		if (_p->key == key && _p->sk.ref == p->sk.ref &&
+		    (!_p->sk.node || _p->sk.node == node)) {
 			pr_debug("Failed to bind duplicate %u,%u,%u/%u:%u/%u\n",
 				 p->sr.type, p->sr.lower, p->sr.upper,
 				 node, p->sk.ref, key);
@@ -388,7 +389,8 @@ static struct publication *tipc_service_remove_publ(struct service_range *r,
 	u32 node = sk->node;
 
 	list_for_each_entry(p, &r->all_publ, all_publ) {
-		if (p->key != key || (node && node != p->sk.node))
+		if (p->key != key || p->sk.ref != sk->ref ||
+		    (node && node != p->sk.node))
 			continue;
 		list_del(&p->all_publ);
 		list_del(&p->local_publ);
-- 
2.51.0


