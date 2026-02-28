Return-Path: <stable+bounces-220326-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLLnI80xo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220326-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:19:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCF31C5AC2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B6823012D2C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539A2395B8A;
	Sat, 28 Feb 2026 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7418eiy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1443A395B7A;
	Sat, 28 Feb 2026 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300227; cv=none; b=FkjImo2Qi8IjQt8vv5RohPRPIsbW2//L88pcNPFvYkqWkchqRu7VVZuOtr0PMEFlUgwCIk46b4GHBxBAyBwhrVW/LmyQCyod/AZLg1Wkik05iz0m8aragjja9KF39R3xYM9x16pCHHDAhUmZbAN0Z0Zz51Pu/srAOcPIkw5DwFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300227; c=relaxed/simple;
	bh=LyZ/27qtiTLH0I9CxW4AZjmAEqEIB2XWjddTJGCZlFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRb+Xpsig5A6YTRN9cy13D4WUWpEw0JRMpcgarhpOcUniURHOQ48IUPccLBiaZ1jUMgKZoqK85LbWAnJ+ebXXQ2MgLyKTzYff6XDeAMFW7NhLBFFPM0Wu5vc0ihxSg09yuLayXcIsJGp8MaDIKziE6JU/AgIeuoVwW3ObIXRN4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7418eiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE1BC116D0;
	Sat, 28 Feb 2026 17:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300227;
	bh=LyZ/27qtiTLH0I9CxW4AZjmAEqEIB2XWjddTJGCZlFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R7418eiyEN1UZdKOzG8ymEHH/S94Fe+sAbKBV0kF9aaDzcjuLyiR7CRmULrph0mg7
	 nIZAJzK0eTlQ2ovBB2kuPvR9uUR6oUW+NwCKdagmlnW6akofZap8hMlhib+sQD+3Lb
	 JYRzTJvZA6QpdTi4GgiQFw2QZlMqmX3sDF1/kcnF4zcsDAWYD8c2+ZUfy9+gd74+Nj
	 SHENqzPmRQNvqco4htT7otvr4l+2yux3UhYSw1jg5uGElApssRjqZL5ZKNYU3h9s5x
	 L2A9z7JWEBWG8NLn+2o5CyxObCO07S+4xlSUmvFD53S+cQtmJq02BfpMSwCbXrIMv3
	 kuIiKn15HRyZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Haotian Zhang <vulab@iscas.ac.cn>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 248/844] jfs: Add missing set_freezable() for freezable kthread
Date: Sat, 28 Feb 2026 12:22:41 -0500
Message-ID: <20260228173244.1509663-249-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-220326-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FCF31C5AC2
X-Rspamd-Action: no action

From: Haotian Zhang <vulab@iscas.ac.cn>

[ Upstream commit eb0cfcf265714b419cc3549895a00632e76732ae ]

The jfsIOWait() thread calls try_to_freeze() but lacks set_freezable(),
causing it to remain non-freezable by default. This prevents proper
freezing during system suspend.

Add set_freezable() to make the thread freezable as intended.

Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_logmgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index b343c5ea11592..5b1c5da041630 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -2311,6 +2311,7 @@ int jfsIOWait(void *arg)
 {
 	struct lbuf *bp;
 
+	set_freezable();
 	do {
 		spin_lock_irq(&log_redrive_lock);
 		while ((bp = log_redrive_list)) {
-- 
2.51.0


