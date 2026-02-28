Return-Path: <stable+bounces-220786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHm9NpFEo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:40:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4F51C73A9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44DF1317E301
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A75940BDB2;
	Sat, 28 Feb 2026 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1heH1P3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEC440BDAA;
	Sat, 28 Feb 2026 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300670; cv=none; b=YTHDOIOTq+DdZwkRUbDaFdP9vLHcS4zk7MPKRe9GgC8OQWnnRkThb19uOt6tC7dr8kFaIwqIAN/UNv0zKQtFvoA/owk8xaUpY0ST6THfzVuVFnOuD9ohS+9LG4djFr1jCMf/RAifPhDCbNa/Pouu17EeWAn9SThxZSbp2cj6tf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300670; c=relaxed/simple;
	bh=wkeDulKa8F111M35HYlkOg2bAaaqRdcXiuwCNUn7jwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRB+FnMR+zmEmK0hKRxCoMTkyqOJxz62EfqKith6Ajx23Cf0nXGj4CgmFNeGIwu0/sLkh+jpYhgFH0ucW/b51ztyazQh03gd1W86lVEstR0v1X4XDXW/gqiaWFj0UYCOEYKRpnImxnIZQ7Hf0/DTD9cmG69Ih2r9fYeVQ6tzOgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1heH1P3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B414C116D0;
	Sat, 28 Feb 2026 17:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300669;
	bh=wkeDulKa8F111M35HYlkOg2bAaaqRdcXiuwCNUn7jwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K1heH1P3KJykwgxdhQ5aFca1Vx7BV2ITypLeUymu2Mkx5qkpha6bWs5drDrOjhd19
	 0KKljnKethFWSfPW4yaUKuuv0co/7tXtiWppY4VAdUfq3iurT3FLlv62euYngFPVon
	 am7ytTfRo07rXDy+itJiFDLPMK9x21QzI1uw8TJPQMNyLJ1n+tty/77dwV+qVan6cY
	 bboXEutCMr9aLbYisT4WqsCwdN65YTnglrEbMVsn80z+NGtsQ8PowpzNU2XPwMc8Ci
	 2XGhEfqBizJnpiDjH0JcyjWG/jRnwP1/NwRsmjibR1wwUaX79DrKYfXUxZO1RE4Kph
	 D0fG+L/A60P8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Marzinski <bmarzins@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 707/844] dm mpath: make pg_init_delay_msecs settable
Date: Sat, 28 Feb 2026 12:30:20 -0500
Message-ID: <20260228173244.1509663-708-sashal@kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220786-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B4F51C73A9
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
index b739894f01807..aa9a88a9aa768 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -225,6 +225,7 @@ static struct multipath *alloc_multipath(struct dm_target *ti)
 		mutex_init(&m->work_mutex);
 
 		m->queue_mode = DM_TYPE_NONE;
+		m->pg_init_delay_msecs = DM_PG_INIT_DELAY_DEFAULT;
 
 		m->ti = ti;
 		ti->private = m;
@@ -251,7 +252,6 @@ static int alloc_multipath_stage2(struct dm_target *ti, struct multipath *m)
 	set_bit(MPATHF_QUEUE_IO, &m->flags);
 	atomic_set(&m->pg_init_in_progress, 0);
 	atomic_set(&m->pg_init_count, 0);
-	m->pg_init_delay_msecs = DM_PG_INIT_DELAY_DEFAULT;
 	init_waitqueue_head(&m->pg_init_wait);
 	init_waitqueue_head(&m->probe_wait);
 
-- 
2.51.0


