Return-Path: <stable+bounces-249087-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PwNOQHICWropQQAu9opvQ
	(envelope-from <stable+bounces-249087-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:52:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7C45614A7
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 747CB30086FE
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 13:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009E9260580;
	Sun, 17 May 2026 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJ3SyzNg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B865B25E469
	for <stable@vger.kernel.org>; Sun, 17 May 2026 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779025913; cv=none; b=PfaN9I7P7xIOkuaCHpiZAxhbB4d2Cafr/MD1PJDhoS4V6oJgGmRNur2IvEVXydeSIsMjHj4w8zmK+2W5vVnHg0uOyXlUIOzS0ACS4P/lNtv9MNY8dpGAHePf1OhvuvaWLsoW5A86KkQcPfxklYocxAeRojm/9wzM3DbgeBoK6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779025913; c=relaxed/simple;
	bh=dzhM0BGO5IIv/LaxbsIYy0zYqqVt8dTV1QE5i7pWYls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7Zsadc21bkYgCXjLlrOOLkI79P3kVmHFeDyotdkuEbY58HA4W4wvlbc1WSTkD3q0ViNv1qjL16eT+35rfDZU1YP9iFiU37UNDG958zg5kNPd12NZ6e71ACi/5cELcg3jbW8LAU6yaE55p8ficuH96R2KZ/J9r/bjC2ndObh2KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJ3SyzNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F018C2BCF5;
	Sun, 17 May 2026 13:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779025913;
	bh=dzhM0BGO5IIv/LaxbsIYy0zYqqVt8dTV1QE5i7pWYls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FJ3SyzNgDJclbvrn/NikRSqbt1sKfNQs0V3Sll9T05RBn1t+avh9ThrOOwgwO61i4
	 G4doYDUq3+LosN5/UCJtSROQDViOpDJz2Rh70gGD14cOmmKxWtIQrbC3GTCVT6h/eh
	 fkrlN/7fZf1oXzVyY4gWUNw0IsKiu0WXJIJlO9cNE41spnXFmnD6XK2B2wZ6ld8A48
	 duwSqdezLUcPNUs/jl/wfPweFG9Jc3f6fE6aw3GTIT0ponwcm3/vvD6NIAzr0ZpfUe
	 p2wR1eRBlr1tiBfJegYyN8e+xbNrYPwRiovnfrMC8toqcGmyS2Aj4lnTnWsjaZtaFR
	 /Vp66pAQgF45A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] dm-thin: fix metadata refcount underflow
Date: Sun, 17 May 2026 09:51:49 -0400
Message-ID: <20260517135149.147613-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517135149.147613-1-sashal@kernel.org>
References: <2026051203-outbreak-showgirl-7530@gregkh>
 <20260517135149.147613-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4E7C45614A7
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
	TAGGED_FROM(0.00)[bounces-249087-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 09a65adc7d8bbfce06392cb6d375468e2728ead5 ]

There's a bug in dm-thin in the function rebalance_children. If the
internal btree node has one entry, the code tries to copy all btree
entries from the node's child to the node itself and then decrement the
child's reference count.

If the child node is shared (it has reference count > 1), we won't free
it, so there would be two pointers to each of the grandchildren nodes.
But the reference counts of the grandchildren is not increased, thus the
reference count doesn't match the number of pointers that point to the
grandchildren. This results in "device mapper: space map common: unable
to decrement block" errors.

Fix this bug by incrementing reference counts on the grandchildren if the
btree node is shared.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 3241b1d3e0aa ("dm: add persistent data library")
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/persistent-data/dm-btree-remove.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/md/persistent-data/dm-btree-remove.c b/drivers/md/persistent-data/dm-btree-remove.c
index 63f2baed3c8a6..1cf31861020b4 100644
--- a/drivers/md/persistent-data/dm-btree-remove.c
+++ b/drivers/md/persistent-data/dm-btree-remove.c
@@ -415,12 +415,20 @@ static int rebalance_children(struct shadow_spine *s,
 
 	if (le32_to_cpu(n->header.nr_entries) == 1) {
 		struct dm_block *child;
+		int is_shared;
 		dm_block_t b = value64(n, 0);
 
+		r = dm_tm_block_is_shared(info->tm, b, &is_shared);
+		if (r)
+			return r;
+
 		r = dm_tm_read_lock(info->tm, b, &btree_node_validator, &child);
 		if (r)
 			return r;
 
+		if (is_shared)
+			inc_children(info->tm, dm_block_data(child), vt);
+
 		memcpy(n, dm_block_data(child),
 		       dm_bm_block_size(dm_tm_get_bm(info->tm)));
 
-- 
2.53.0


