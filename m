Return-Path: <stable+bounces-235817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD+FI0+W22njDgkAu9opvQ
	(envelope-from <stable+bounces-235817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 14:55:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E613E3DE8
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 14:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6180F301187F
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F10A37B3F9;
	Sun, 12 Apr 2026 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9+xhokJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E649118EB0
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775998521; cv=none; b=fM07Qs3zPo9l60/I8ySxd2vyYDQJfGsB0Gkf9NBUVM+BW6Umwka+Xi69EhT09qPPVgJEs46BYPXotwfL/YYRssSzFQJUpoeT/s0ujbW0QaCq1tHjK1wWsHh+I6zwJbzeUwnHdpuVU1V6jVFbGLKRCi3eGgmdPmB4xnk4yLo+Ojo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775998521; c=relaxed/simple;
	bh=t9pcu/BxHumYlDpQNug/I2j6mNXaAorDcOX31eY+VwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4DWTLUQu1r6GvMT3j9sFj94osmlGlkkc1QRpi+SI2q1zN8dBLnKR7L7QknS7ESHOW3VioDUWgRTy1USTjqZqYj4dWxsPImezHTe5iQp9jq+N2foxkq6wQmZuWodSkT2CspYBZTc2LMBsgH1gxKvBBe8eqHyicqV0j3Y+lhh9ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9+xhokJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481F2C2BCB3;
	Sun, 12 Apr 2026 12:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775998520;
	bh=t9pcu/BxHumYlDpQNug/I2j6mNXaAorDcOX31eY+VwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M9+xhokJMfOrLPKcFhgNFv0WyddpO6beFFDTK26WBOGC8kwevc4QrJD/BE90Mhj4U
	 tFN9MWPatXoJxEk6tpfiYVHdfVQ9RbvvPpOdjJ29/6r+PvfyTNDoKDOi3QOXQarMU/
	 J12iaCXGs+PFe3FYqAWT1b+KGdpOvDk1iPsUFgxuErWechVkF21Qvj26uBWt8IG/j1
	 GrWfzgk+HnzFTvsRnLWOCKCbl/OMNuZBA0+iQ+4KjM4zDuViuiMS9rOPgZaEme5ham
	 eEbrbHZC6CUZL7G03CqD1p9eNa4W0aTybhm2W58DH39VlWhbbXmYeT4pnGAtwp2e7Q
	 IR2vFSqIuf0Ng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+509238e523e032442b80@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] net: rfkill: reduce data->mtx scope in rfkill_fop_open
Date: Sun, 12 Apr 2026 08:55:16 -0400
Message-ID: <20260412125517.2219007-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412125517.2219007-1-sashal@kernel.org>
References: <2026041215-clamp-serpent-1558@gregkh>
 <20260412125517.2219007-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235817-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,509238e523e032442b80];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7E613E3DE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit f2ac54ebf85615a6d78f5eb213a8bbeeb17ebe5d ]

In syzbot runs, lockdep reports that there's a (potential)
deadlock here of data->mtx being locked recursively. This
isn't really a deadlock since they are different instances,
but lockdep cannot know, and teaching it would be far more
difficult than other fixes.

At the same time we don't even really _need_ the mutex to
be locked in rfkill_fop_open(), since we're modifying only
a completely fresh instance of 'data' (struct rfkill_data)
that's not yet added to the global list.

However, to avoid any reordering etc. within the globally
locked section, and to make the code look more symmetric,
we should still lock the data->events list manipulation,
but also need to lock _only_ that. So do that.

Reported-by: syzbot+509238e523e032442b80@syzkaller.appspotmail.com
Fixes: 2c3dfba4cf84 ("rfkill: sync before userspace visibility/changes")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: ea245d78dec5 ("net: rfkill: prevent unlimited numbers of rfkill events from being created")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rfkill/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 981771598f1eb..7ec100adf5945 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -1180,7 +1180,6 @@ static int rfkill_fop_open(struct inode *inode, struct file *file)
 	init_waitqueue_head(&data->read_wait);
 
 	mutex_lock(&rfkill_global_mutex);
-	mutex_lock(&data->mtx);
 	/*
 	 * start getting events from elsewhere but hold mtx to get
 	 * startup events added first
@@ -1192,10 +1191,11 @@ static int rfkill_fop_open(struct inode *inode, struct file *file)
 			goto free;
 		rfkill_sync(rfkill);
 		rfkill_fill_event(&ev->ev, rfkill, RFKILL_OP_ADD);
+		mutex_lock(&data->mtx);
 		list_add_tail(&ev->list, &data->events);
+		mutex_unlock(&data->mtx);
 	}
 	list_add(&data->list, &rfkill_fds);
-	mutex_unlock(&data->mtx);
 	mutex_unlock(&rfkill_global_mutex);
 
 	file->private_data = data;
@@ -1203,7 +1203,6 @@ static int rfkill_fop_open(struct inode *inode, struct file *file)
 	return stream_open(inode, file);
 
  free:
-	mutex_unlock(&data->mtx);
 	mutex_unlock(&rfkill_global_mutex);
 	mutex_destroy(&data->mtx);
 	list_for_each_entry_safe(ev, tmp, &data->events, list)
-- 
2.53.0


