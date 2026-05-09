Return-Path: <stable+bounces-244858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGH/HmSB/mnyrwAAu9opvQ
	(envelope-from <stable+bounces-244858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 02:35:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E1A4FD11E
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 02:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 535A6301467E
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 00:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEAF1DB13A;
	Sat,  9 May 2026 00:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/d1qKVs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C531A6807
	for <stable@vger.kernel.org>; Sat,  9 May 2026 00:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778286940; cv=none; b=MOiAfRPijJkkiO1bCqLnYNp5+lZ0yvzWXoz7UlLblq5/sOrb4T+d8G618TwV9UpIzljmJxJqYGV3VJo4xO71m+ryFxQPdi7wFiq4YZiArzRx/xIIAv6+nI8aPh6TtN4rYypTCXfMxaFXVJb7ia3/Pre8pJeA0nWtWqq/FknmoKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778286940; c=relaxed/simple;
	bh=l1CkBlz3iBoWk6wp8qZtr753VDtNkjeIvcYdii39cFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5myUd3fQn9VfN4jN5IBKmM17dRw6xMv42rGdrMAmz0Q5e3SufrJ0bCPvhSjUHLkL0dTTuOxJsPrHsDDlHnUM4/+ac/2CfgQoJy76egqaGcgOvXkMmjBm8PIb3xhTZS2qIrysypJ25H19l/aYbd7jiQCWw14RNG96fyEhz5+4uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/d1qKVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D9AC2BCB0;
	Sat,  9 May 2026 00:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778286940;
	bh=l1CkBlz3iBoWk6wp8qZtr753VDtNkjeIvcYdii39cFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/d1qKVsbquR/gRvBmuG6R6EMUZBpC61tFhmlkPqVUtBYbXkm/xZxlX5eVf0Y2Dia
	 e0Pmuf/yxuxZ173/B/msmSAMEzuIBXZ2bWNeRjOs8MaDX8d5lFvMDaUUel0mSfhNkA
	 2cXF65GhA5dsA7YVIq1ueuCgezw8vkkMOm67V/3FgG2j11CxOkeSh63OeRugUBKpkd
	 zxtNNok00T12QmioWVQOozVysmtymNUu4nuPVkGWqdLcpovYnfkDjBMa+ma+D8nd2a
	 b496TARW2RhYglgBlmO9E8GHKWAvzuxR1mpt1wERyu6KCWonZ+y3tUnFQU8S03ioWo
	 wAud6/IdpUiVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Seohyeon Maeng <bioloidgp@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] udf: fix partition descriptor append bookkeeping
Date: Fri,  8 May 2026 20:35:37 -0400
Message-ID: <20260509003537.2360522-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050427-dreamless-halogen-0749@gregkh>
References: <2026050427-dreamless-halogen-0749@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D2E1A4FD11E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244858-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Action: no action

From: Seohyeon Maeng <bioloidgp@gmail.com>

[ Upstream commit 08841b06fa64d8edbd1a21ca6e613420c90cc4b8 ]

Mounting a crafted UDF image with repeated partition descriptors can
trigger a heap out-of-bounds write in part_descs_loc[].

handle_partition_descriptor() deduplicates entries by partition number,
but appended slots never record partnum. As a result duplicate
Partition Descriptors are appended repeatedly and num_part_descs keeps
growing.

Once the table is full, the growth path still sizes the allocation from
partnum even though inserts are indexed by num_part_descs. If partnum is
already aligned to PART_DESC_ALLOC_STEP, ALIGN(partnum, step) can keep
the old capacity and the next append writes past the end of the table.

Store partnum in the appended slot and size growth from the next append
count so deduplication and capacity tracking follow the same model.

Fixes: ee4af50ca94f ("udf: Fix mounting of Win7 created UDF filesystems")
Cc: stable@vger.kernel.org
Signed-off-by: Seohyeon Maeng <bioloidgp@gmail.com>
Link: https://patch.msgid.link/20260310081652.21220-1-bioloidgp@gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
[ replaced kzalloc_objs() helper with equivalent kcalloc() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 723184b1201f8..33d66da17922f 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1657,8 +1657,9 @@ static struct udf_vds_record *handle_partition_descriptor(
 			return &(data->part_descs_loc[i].rec);
 	if (data->num_part_descs >= data->size_part_descs) {
 		struct part_desc_seq_scan_data *new_loc;
-		unsigned int new_size = ALIGN(partnum, PART_DESC_ALLOC_STEP);
+		unsigned int new_size;
 
+		new_size = data->num_part_descs + PART_DESC_ALLOC_STEP;
 		new_loc = kcalloc(new_size, sizeof(*new_loc), GFP_KERNEL);
 		if (!new_loc)
 			return ERR_PTR(-ENOMEM);
@@ -1668,6 +1669,7 @@ static struct udf_vds_record *handle_partition_descriptor(
 		data->part_descs_loc = new_loc;
 		data->size_part_descs = new_size;
 	}
+	data->part_descs_loc[data->num_part_descs].partnum = partnum;
 	return &(data->part_descs_loc[data->num_part_descs++].rec);
 }
 
-- 
2.53.0


