Return-Path: <stable+bounces-244849-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPVkHhF5/mmmrQAAu9opvQ
	(envelope-from <stable+bounces-244849-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 02:00:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D11F44FCF28
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 02:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA07B3028EC2
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 23:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCFE36B05E;
	Fri,  8 May 2026 23:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quTtqRVO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414C236A035
	for <stable@vger.kernel.org>; Fri,  8 May 2026 23:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778284796; cv=none; b=Ys1JeHNlk8/IdpJ3VbeKPqAZPD2eWEMyIdMneCL/vNBnEOIkNyejG4R5YgueNsRZABduKeQQKSlAvGkveMOwPBLo4x6YSUhf0SlTWiynq8lNFPvAM76iUikj3KUnKulEq4BQo/NDgGzsFccOj1HvofRlWibaKq2x8zACopISsxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778284796; c=relaxed/simple;
	bh=LZbXy52Bpf10VHA6DpZrZY1yZD+Af8ktVU8N4xDMcgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOQasUn1gulPPHgFoKf2IflUk+J41ov4r2uRO68S7LnOt9INxUegEn1VKChmbVMRAboEpt/4iGECBWCa3ReXyRP9pQlUUoV7haskIWunUkHd4X+yHpiojNT13QG+thD//C8lxACK8ss5AyKi6RlPotml0xJptPm0R8Kk1eIOL3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quTtqRVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E1DC2BCB0;
	Fri,  8 May 2026 23:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778284795;
	bh=LZbXy52Bpf10VHA6DpZrZY1yZD+Af8ktVU8N4xDMcgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=quTtqRVOC+U7j/c5Ocj1LFCq2hKrkiHkm6zqZNSCWP6ycrUz6oMDWI7PX2XvFjqrT
	 +iPGWV+YrQGSSFFT+v91cnG4S5FvF6aRDzP8SaSUyWdj34D829XpsuQHJ9R1HLdq7G
	 z2q3T9oGLTFI7aGpLpKg2+hrXvATc1PEXV8p8uLTVLyqLprHnSMKTjAM+BaRk12JS2
	 h0mqO7cMmKMQsiTYt7xrbNKmNdCvrbzO0RE104dKseArZ6NseoAxwAvy0BqHInXlk4
	 OzZklYerW8vaaGq1/TvNAYouuAR3hyaCr6k+vOo98WNC0uhhqFAJu4huKMCEsvbeau
	 s2wnxcpNpkDpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Seohyeon Maeng <bioloidgp@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] udf: fix partition descriptor append bookkeeping
Date: Fri,  8 May 2026 19:59:53 -0400
Message-ID: <20260508235953.2245198-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050426-sprinkler-crestless-202a@gregkh>
References: <2026050426-sprinkler-crestless-202a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D11F44FCF28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244849-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
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
index 69e4f00ce791b..f58a48fc0ade0 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1658,8 +1658,9 @@ static struct udf_vds_record *handle_partition_descriptor(
 			return &(data->part_descs_loc[i].rec);
 	if (data->num_part_descs >= data->size_part_descs) {
 		struct part_desc_seq_scan_data *new_loc;
-		unsigned int new_size = ALIGN(partnum, PART_DESC_ALLOC_STEP);
+		unsigned int new_size;
 
+		new_size = data->num_part_descs + PART_DESC_ALLOC_STEP;
 		new_loc = kcalloc(new_size, sizeof(*new_loc), GFP_KERNEL);
 		if (!new_loc)
 			return ERR_PTR(-ENOMEM);
@@ -1669,6 +1670,7 @@ static struct udf_vds_record *handle_partition_descriptor(
 		data->part_descs_loc = new_loc;
 		data->size_part_descs = new_size;
 	}
+	data->part_descs_loc[data->num_part_descs].partnum = partnum;
 	return &(data->part_descs_loc[data->num_part_descs++].rec);
 }
 
-- 
2.53.0


