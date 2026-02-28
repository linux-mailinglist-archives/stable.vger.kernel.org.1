Return-Path: <stable+bounces-221009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCTcCEFNo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C204D1C8239
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17ABE3204027
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1A94BC02D;
	Sat, 28 Feb 2026 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG9YvKk7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF354BC002;
	Sat, 28 Feb 2026 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301352; cv=none; b=cMCUzqLYSjVlHquVCy9lGGHsJ59WMhObrzEP4cTXUMYMlpDiAYQekDrp1QRD+7tYIgz80ZYqe5ZKwXmfH3r5Oc0PjkHVsGe9ysQ7hjR06GGF95iCoJA+q8MptupjMPwoLEcMkBvLvcROG/gsVEZSLChHWoHlLul45J6cTtThmMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301352; c=relaxed/simple;
	bh=wiFr3cqew56q6DCv9ENOeggq/XEDhHnvSs/Luebh4zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/5qUC71koz9G1HHObUR2PeypNDTX8mo1eDgbXegjbtcmnVhpYmlIjCzXHz5Vd2igfhGndJQHeyN1MZuZOW6I/upbDLD5lAXnahQaWh7mWQmh/HrniWrL8Epqpvp1YkHBkAdu5Tb9WxRROkP9W50eag98x4ycwPSnGItNJDFGv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG9YvKk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0A5C116D0;
	Sat, 28 Feb 2026 17:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301352;
	bh=wiFr3cqew56q6DCv9ENOeggq/XEDhHnvSs/Luebh4zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FG9YvKk7WEUt5YyBeRD3H8MOpF5zScI5iCBq615Ycm/A+GemQZv7r5PPrc9UZG3Wq
	 LrxB+/NQ0YgpLh1UV6YkLX2eEJ+6V6zrPM7ia58PIavGO2VQc0mRttrsupMteGKlGV
	 SB2wYsp91PNq8H97dZ0mP4xqL5pBzt2AB+bTd/V59QjoZVgZUteqZ5c5+buQuBqeNn
	 dYqTRsWB+WIpTnejrfHGagY7bXPt9LSfsZz3C5mCt5wMKy8//16Gsujr1NR7P+IzRG
	 kdAHg8KKVV+8wB3KdibGXWR8caXYyS5g7jmSFG/EDfDjFDiD2G0F8c17wIyyL2VOSL
	 9+lSe7EYC9LpA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 540/752] dm-integrity: fix a typo in the code for write/discard race
Date: Sat, 28 Feb 2026 12:44:11 -0500
Message-ID: <20260228174750.1542406-540-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221009-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: C204D1C8239
X-Rspamd-Action: no action

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit c698b7f417801fcd79f0dc844250b3361d38e6b8 ]

If we send a write followed by a discard, it may be possible that the
discarded data end up being overwritten by the previous write from the
journal. The code tries to prevent that, but there was a typo in this
logic that made it not being activated as it should be.

Note that if we end up here the second time (when discard_retried is
true), it means that the write bio is actually racing with the discard
bio, and in this situation it is not specified which of them should win.

Cc: stable@vger.kernel.org
Fixes: 31843edab7cb ("dm integrity: improve discard in journal mode")
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 170bf67a2edd9..79d60495454a5 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2411,7 +2411,7 @@ static void dm_integrity_map_continue(struct dm_integrity_io *dio, bool from_map
 
 		new_pos = find_journal_node(ic, dio->range.logical_sector, &next_sector);
 		if (unlikely(new_pos != NOT_FOUND) ||
-		    unlikely(next_sector < dio->range.logical_sector - dio->range.n_sectors)) {
+		    unlikely(next_sector < dio->range.logical_sector + dio->range.n_sectors)) {
 			remove_range_unlocked(ic, &dio->range);
 			spin_unlock_irq(&ic->endio_wait.lock);
 			queue_work(ic->commit_wq, &ic->commit_work);
-- 
2.51.0


