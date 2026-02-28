Return-Path: <stable+bounces-220471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kgi+Nyg4o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F391C63EE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE7AA30F286C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2CA3BF4EA;
	Sat, 28 Feb 2026 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPellaVt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2BC3BFDBB;
	Sat, 28 Feb 2026 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300358; cv=none; b=Zte4MO5AvFurFw05Vc7lF6d2ujXFF9qhnw+XaEZ5jrjbk9mcfMQO/WV/ervBo1MlZFS2MuI6wZNNpO3vpYX9kbeEiV31/TMckca07vW7pczVjw6X5Y04Y6uGe7sVVvf3ViogFcgB/Xml96B/m8vCAaecwu5Mz8q9G9xWkx44peI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300358; c=relaxed/simple;
	bh=yBO+1gdi5CQ4aTFRj9PBxz+kigfQ1PcO4Qqr4ognvF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwHFbD9kEnNXM31sm401+kywY79bRAFXQ3NxKtwUZQJ7YLir0WKQZWZ5lS1PoIdXqhcBfKlPWvfWrUaPjH4lIMRmaE3oXP/aARmWs98OAxjTGG0JWA4VKLmlPAu36CGE4cTA3rZzYFyrx68BK+TmBocd/EiUUdxoWCNgdjpOQjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPellaVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DED1C19424;
	Sat, 28 Feb 2026 17:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300358;
	bh=yBO+1gdi5CQ4aTFRj9PBxz+kigfQ1PcO4Qqr4ognvF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SPellaVtipo35qUywzs0Ejci7dFJlgih0nvkih/aj6HIqUuysJ+bNhf+kQ5k+eomR
	 kNx8Vpg6rya6McK0TKuJYycRjY/rDNinbXpbseBGoegkZMXecOnZpGJsdgZyJmIMnl
	 ZNL6GLteUKH1QFzcX48kaW4s+Eu2OKdw17SmjH3J8mhJqAPeuUYnYq754qd9EsOsOT
	 z080utaUN8+tMRkHjrtHIEGqddgfbm03ijdY7XmfeCECLR2UpTtBwrF02Ysjbcivpz
	 b2Zg5zDvgLVASN8H2dTSgZGixNRy4P9vrxJXQOj9AbjOHaJYHJ7a2oWorZJChst7Nr
	 puTZ5kFHEiiTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Carlos Llamas <cmllamas@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 392/844] binder: don't use %pK through printk
Date: Sat, 28 Feb 2026 12:25:05 -0500
Message-ID: <20260228173244.1509663-393-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220471-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 77F391C63EE
X-Rspamd-Action: no action

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

[ Upstream commit 56d21267663bad91e8b10121224ec46366a7937e ]

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log. Since commit ad67b74d2469 ("printk: hash
addresses printed with %p") the regular %p has been improved to avoid
this issue. Furthermore, restricted pointers ("%pK") were never meant
to be used through printk(). They can still unintentionally leak raw
pointers or acquire sleeping locks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.

There are still a few users of %pK left, but these use it through
seq_file, for which its usage is safe.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://patch.msgid.link/20260107-restricted-pointers-binder-v1-1-181018bf3812@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/android/binder.c       | 2 +-
 drivers/android/binder_alloc.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index b356c9b882544..33e4dad0915bb 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4523,7 +4523,7 @@ static int binder_thread_write(struct binder_proc *proc,
 				}
 			}
 			binder_debug(BINDER_DEBUG_DEAD_BINDER,
-				     "%d:%d BC_DEAD_BINDER_DONE %016llx found %pK\n",
+				     "%d:%d BC_DEAD_BINDER_DONE %016llx found %p\n",
 				     proc->pid, thread->pid, (u64)cookie,
 				     death);
 			if (death == NULL) {
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 979c96b74cad3..d5ed64543bbf4 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -81,7 +81,7 @@ static void binder_insert_free_buffer(struct binder_alloc *alloc,
 	new_buffer_size = binder_alloc_buffer_size(alloc, new_buffer);
 
 	binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-		     "%d: add free buffer, size %zd, at %pK\n",
+		     "%d: add free buffer, size %zd, at %p\n",
 		      alloc->pid, new_buffer_size, new_buffer);
 
 	while (*p) {
@@ -572,7 +572,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	}
 
 	binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-		     "%d: binder_alloc_buf size %zd got buffer %pK size %zd\n",
+		     "%d: binder_alloc_buf size %zd got buffer %p size %zd\n",
 		      alloc->pid, size, buffer, buffer_size);
 
 	/*
@@ -748,7 +748,7 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 		ALIGN(buffer->extra_buffers_size, sizeof(void *));
 
 	binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
-		     "%d: binder_free_buf %pK size %zd buffer_size %zd\n",
+		     "%d: binder_free_buf %p size %zd buffer_size %zd\n",
 		      alloc->pid, buffer, size, buffer_size);
 
 	BUG_ON(buffer->free);
-- 
2.51.0


