Return-Path: <stable+bounces-221097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KdYBHNdo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:26:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F5E1C90AA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9784B3031AD3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114F147CC9A;
	Sat, 28 Feb 2026 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBuOCgu+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9193301F0B;
	Sat, 28 Feb 2026 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301445; cv=none; b=LpIuIIndfYgG3fKHMnp2lxCRzWWlBIKF49AKY/2PQGLUkhx8Q2zlvDbp/kf8YgyGjOYwhQ3yQoQCq3g7XYgZdBXpK1jr/OP9kzFDCDm3KgdyWekfDkNbL22fi33VreLK0N0NiiUSkmFkhswxXi1NDQvM6o7CfP3lcARtjtlhm6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301445; c=relaxed/simple;
	bh=ldOvbmv9YEPXSrA15THO6yB0XLoHUNyToVoc74OHx9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6/OyyCShkN3d/n8rEjm6EE3y/SIHL2yIF0GuHspKuLSEQuvO7AC2/023EzA3fkO5K3eD02dHFG9tgE4xaYztcz2AyZrBOhPOArYwWW1rwpDqffz1hFAalRvO6HP1lc8wKJ/EHViVPoKawH7m3VZiLuco4uzI73Oqex5GCoYUEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBuOCgu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A849C19423;
	Sat, 28 Feb 2026 17:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301445;
	bh=ldOvbmv9YEPXSrA15THO6yB0XLoHUNyToVoc74OHx9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nBuOCgu+13l9lTRp97VorwCVxVqOoejWQjlTRaP/g2tAHuTz88bP6ABVgDygWsSAQ
	 pWslT9B4UVKuxH0ya7ryGABcQfZH1wbpH95XQTJEWsfjLOVDOM3Q8ylZiWPsCbrUj4
	 fxO8SjitgGnCuX7TEyA0oC9EWw6zweJAO5eHlyM6zs26h3ZYHvgBR6vJbJN7oDXffz
	 pp3IQGQD3G43BTPxCXHTxH3uVyo8+KLr2NFq5qEqUchZzPARYpFT6fSwgVhWatiEnQ
	 ToMjx3UK7XzGxp9nA6/8qgTBzg8NsY1xn/reaBBPoYYeDrEcY0ei1Q3IqV4WralA7Q
	 bltywVcoqu8JQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Benjamin Marzinski <bmarzins@redhat.com>,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 632/752] dm mpath: make pg_init_delay_msecs settable
Date: Sat, 28 Feb 2026 12:45:43 -0500
Message-ID: <20260228174750.1542406-632-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221097-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5F5E1C90AA
X-Rspamd-Action: no action

From: Benjamin Marzinski <bmarzins@redhat.com>

[ Upstream commit 218b16992a37ea97b9e09b7659a25a864fb9976f ]

"pg_init_delay_msecs X" can be passed as a feature in the multipath
table and is used to set m->pg_init_delay_msecs in parse_features().
However, alloc_multipath_stage2(), which is called after
parse_features(), resets m->pg_init_delay_msecs to its default value.
Instead, set m->pg_init_delay_msecs in alloc_multipath(), which is
called before parse_features(), to avoid overwriting a value passed in
by the table.

Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-mpath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index aaf4a0a4b0ebb..7d3fdd96f4edf 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -225,6 +225,7 @@ static struct multipath *alloc_multipath(struct dm_target *ti)
 		mutex_init(&m->work_mutex);
 
 		m->queue_mode = DM_TYPE_NONE;
+		m->pg_init_delay_msecs = DM_PG_INIT_DELAY_DEFAULT;
 
 		m->ti = ti;
 		ti->private = m;
@@ -257,7 +258,6 @@ static int alloc_multipath_stage2(struct dm_target *ti, struct multipath *m)
 	set_bit(MPATHF_QUEUE_IO, &m->flags);
 	atomic_set(&m->pg_init_in_progress, 0);
 	atomic_set(&m->pg_init_count, 0);
-	m->pg_init_delay_msecs = DM_PG_INIT_DELAY_DEFAULT;
 	init_waitqueue_head(&m->pg_init_wait);
 	init_waitqueue_head(&m->probe_wait);
 
-- 
2.51.0


