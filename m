Return-Path: <stable+bounces-220341-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJiwDOMyo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220341-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:24:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CC42B1C5C03
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A56BB30E8E1E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DAD39A4AB;
	Sat, 28 Feb 2026 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7+prBhl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA2739A4A2;
	Sat, 28 Feb 2026 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300240; cv=none; b=M3n2wSs8uf7avnKPulhnv9O/YL9Y2rJHVZVHyMoSy9Myg90r4ahRL5Y+y5tqmptCqz7kAL9iNRxnV+tvpFncg2SGrXRwNI9dhtxkTKtN0xKOSpoZFiTOPmjK07NUE2Nx01+PzJBhHiGux9yHHkH3C+7SACWtCtbFNudnQHFYaxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300240; c=relaxed/simple;
	bh=cHUYixm8h1kdxcHkyLLsIHClUhF9li/px0bV+qqgbyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPq2e4+4JjHJ+bI+Nt1GjPka3XJXRWIi6epCyz4sJ8DlTvRDKIjzNPIxw+n2TjUPHgQCW1EkCOXgSZ2AZJJ1LzNN1Qu5solwSNhib7VzyNT79+DOsY1x3InIaASGR9EK6vbIC+VZ9Z1MLykv3gM2J4Ho+HKjS67J17m8Jxtjovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7+prBhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8421EC19424;
	Sat, 28 Feb 2026 17:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300240;
	bh=cHUYixm8h1kdxcHkyLLsIHClUhF9li/px0bV+qqgbyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7+prBhlBNwuoZTm2q4BgwydfWKcZcT+iTCj1Kw36bk+ahvGUSAOTe/I1cXSnL8PG
	 tvilIqylBni/0GunyfAHvQMUGUx4ldG9naUZhNRquSuUiRex9k54g+NcEa2J7YdwD3
	 CpG6oMHHieqTzSpCWm9HDZ+yILi8iuGJjFMa9pQgmf8/HIQlmGtVzdkSakqx21bYTU
	 wQ47REJmMP6F97m8vcq3hj3QzDVJiSEx4cIKCb2/OFN5j0Pm7fTDraASjCKw+urrjv
	 +OcQ5gVaeTAjbhh97fbDVbsbiJ6WXq0DVRRWgN60Ee/xqUXW3erjTWm/5dKgYNYbOd
	 JYC689jQTG0RA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Gomez <da.gomez@samsung.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 263/844] dm: replace -EEXIST with -EBUSY
Date: Sat, 28 Feb 2026 12:22:56 -0500
Message-ID: <20260228173244.1509663-264-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220341-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: CC42B1C5C03
X-Rspamd-Action: no action

From: Daniel Gomez <da.gomez@samsung.com>

[ Upstream commit b13ef361d47f09b7aecd18e0383ecc83ff61057e ]

The -EEXIST error code is reserved by the module loading infrastructure
to indicate that a module is already loaded. When a module's init
function returns -EEXIST, userspace tools like kmod interpret this as
"module already loaded" and treat the operation as successful, returning
0 to the user even though the module initialization actually failed.

This follows the precedent set by commit 54416fd76770 ("netfilter:
conntrack: helper: Replace -EEXIST by -EBUSY") which fixed the same
issue in nf_conntrack_helper_register().

Affected modules:
  * dm_cache dm_clone dm_integrity dm_mirror dm_multipath dm_pcache
  * dm_vdo dm-ps-round-robin dm_historical_service_time dm_io_affinity
  * dm_queue_length dm_service_time dm_snapshot

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-exception-store.c | 2 +-
 drivers/md/dm-log.c             | 2 +-
 drivers/md/dm-path-selector.c   | 2 +-
 drivers/md/dm-target.c          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-exception-store.c b/drivers/md/dm-exception-store.c
index c3799757bf4a0..88f119a0a2ae0 100644
--- a/drivers/md/dm-exception-store.c
+++ b/drivers/md/dm-exception-store.c
@@ -116,7 +116,7 @@ int dm_exception_store_type_register(struct dm_exception_store_type *type)
 	if (!__find_exception_store_type(type->name))
 		list_add(&type->list, &_exception_store_types);
 	else
-		r = -EEXIST;
+		r = -EBUSY;
 	spin_unlock(&_lock);
 
 	return r;
diff --git a/drivers/md/dm-log.c b/drivers/md/dm-log.c
index 9d85d045f9d9d..bced5a783ee33 100644
--- a/drivers/md/dm-log.c
+++ b/drivers/md/dm-log.c
@@ -121,7 +121,7 @@ int dm_dirty_log_type_register(struct dm_dirty_log_type *type)
 	if (!__find_dirty_log_type(type->name))
 		list_add(&type->list, &_log_types);
 	else
-		r = -EEXIST;
+		r = -EBUSY;
 	spin_unlock(&_lock);
 
 	return r;
diff --git a/drivers/md/dm-path-selector.c b/drivers/md/dm-path-selector.c
index d0b883fabfeb6..2b0ac200f1c02 100644
--- a/drivers/md/dm-path-selector.c
+++ b/drivers/md/dm-path-selector.c
@@ -107,7 +107,7 @@ int dm_register_path_selector(struct path_selector_type *pst)
 
 	if (__find_path_selector_type(pst->name)) {
 		kfree(psi);
-		r = -EEXIST;
+		r = -EBUSY;
 	} else
 		list_add(&psi->list, &_path_selectors);
 
diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
index 8fede41adec00..1fd41289de367 100644
--- a/drivers/md/dm-target.c
+++ b/drivers/md/dm-target.c
@@ -88,7 +88,7 @@ int dm_register_target(struct target_type *tt)
 	if (__find_target_type(tt->name)) {
 		DMERR("%s: '%s' target already registered",
 		      __func__, tt->name);
-		rv = -EEXIST;
+		rv = -EBUSY;
 	} else {
 		list_add(&tt->list, &_targets);
 	}
-- 
2.51.0


