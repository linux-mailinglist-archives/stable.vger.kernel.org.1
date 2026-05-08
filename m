Return-Path: <stable+bounces-244816-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPmGJwk7/mkroAAAu9opvQ
	(envelope-from <stable+bounces-244816-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 21:35:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 134E14FB2C5
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 21:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4A7630A7289
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 19:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7986A34D90C;
	Fri,  8 May 2026 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPo4FYBY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7ED1474CC
	for <stable@vger.kernel.org>; Fri,  8 May 2026 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268747; cv=none; b=BhrLFoIRGRnoalkSQY4CzU3ECejxlbXqZFQ0BLPSnUsafaZjFYhuTwKe4ffnjDO/Mwot/ucRRi/dHMxc5XoX1phktCJqN0wSuG8Ul4DXlYOkX4sAQQzQO+YCLnVw+Y4aCNFSnbF+1N/ej2DWoBxzG2ZGLMmlgejvwHCTw6G5q2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268747; c=relaxed/simple;
	bh=faMpgrUSAa968+kk2re4ABT7k6aUYuV873gA7cBYBdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vs1Tifil3MN9gg+IT7xOyl3oRl7zvub/3nJ02x/zjSqO66Giw9nABxn+Dy512tcP0hvvsX7zwoGUtgWYHixEghfaYRawizZJm5miQ0xau8v2BX2UHZwmV0+l3/pokfhBP4uKp2Wx+Q9rCLfreZLr2GdHmpdhnGgBoJQmYbB6qoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPo4FYBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B58BC2BCB0;
	Fri,  8 May 2026 19:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778268746;
	bh=faMpgrUSAa968+kk2re4ABT7k6aUYuV873gA7cBYBdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iPo4FYBY8fPkBQWeJax2cmT7KRgLmneuZH82+DnHcQ+uZc9ua2B15amoK3enSZrWE
	 Fodke+qS1ym+tt98W6mGiReIpATlTLa8W035uCM6BKJFyb4QamvafVnaPDgIKWaOpH
	 SS/y8ZIDXXdqYf2NRNR47t+TuegV91k+bAb5+ufDFvO4lTWAZGs+uCCrKgsJxkwL0O
	 QCmak9avgsiuVuemQ5n2jHEJy1GJWaYAvs+Nr5xAekLP/QE6UYEcHN4dColB3c3LO4
	 TpxyhDx6k3QC5rohtMn8EVR6OcdZX6npHBcmoK6AVfVx3WdEB9UTGDkGrvZ2oY2BLg
	 mJGYf8lHufmxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Seohyeon Maeng <bioloidgp@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] udf: fix partition descriptor append bookkeeping
Date: Fri,  8 May 2026 15:32:24 -0400
Message-ID: <20260508193224.1851208-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050424-rally-sectional-8651@gregkh>
References: <2026050424-rally-sectional-8651@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 134E14FB2C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244816-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
index b2f168b0a0d18..1518b37f25940 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1695,8 +1695,9 @@ static struct udf_vds_record *handle_partition_descriptor(
 			return &(data->part_descs_loc[i].rec);
 	if (data->num_part_descs >= data->size_part_descs) {
 		struct part_desc_seq_scan_data *new_loc;
-		unsigned int new_size = ALIGN(partnum, PART_DESC_ALLOC_STEP);
+		unsigned int new_size;
 
+		new_size = data->num_part_descs + PART_DESC_ALLOC_STEP;
 		new_loc = kcalloc(new_size, sizeof(*new_loc), GFP_KERNEL);
 		if (!new_loc)
 			return ERR_PTR(-ENOMEM);
@@ -1706,6 +1707,7 @@ static struct udf_vds_record *handle_partition_descriptor(
 		data->part_descs_loc = new_loc;
 		data->size_part_descs = new_size;
 	}
+	data->part_descs_loc[data->num_part_descs].partnum = partnum;
 	return &(data->part_descs_loc[data->num_part_descs++].rec);
 }
 
-- 
2.53.0


