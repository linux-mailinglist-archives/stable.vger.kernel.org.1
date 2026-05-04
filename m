Return-Path: <stable+bounces-242884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMVZCNpa+GlStQIAu9opvQ
	(envelope-from <stable+bounces-242884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:37:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4254BA517
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C19A03004D8D
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F1D34028F;
	Mon,  4 May 2026 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m+drsMux"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FF4340280
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883860; cv=none; b=b4SxcDxdZ0nqZ+3IaWyDjLKvedcU8SDnT0N0g3oSAMBSF7zdzJopNUKgUaBSfHpLA/aePCVgLYY0oGkCknWxSpkGiI8UCMDhMtzozX/vtHA7oHPOUcC7zbs2coieUpiUqbsxED1eAsqMxaWJiPmhqCHpKVP0SC4ha/4MI3aBgQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883860; c=relaxed/simple;
	bh=2e2O8as/KqvBuxNtowDoot0l9Q4MzxoyjBez6URMaYw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O45xGBHIy8BRHka/MI1E9hha7RjNKJeZqbTLDHPlWabYLc0mFA/t8se16Gz3D6IYFJQiR8eh2+af5+qGjHFUgh0DDT6UldNDnElV5+WcePI6cbLZi3H3MB4Kt1Y0b4d/I5PXJsdoxd0qCNB5AXbuOXXkXvtIg7ZdozkaNnBwd2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m+drsMux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF61C2BCB9;
	Mon,  4 May 2026 08:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777883859;
	bh=2e2O8as/KqvBuxNtowDoot0l9Q4MzxoyjBez6URMaYw=;
	h=Subject:To:Cc:From:Date:From;
	b=m+drsMuxpG57l4b1aQPX7KE2iKi2RnNtN7PowBIBDL9UwRY/FeqjIFOL1nc61cWzw
	 amiq981gHFfvHEVTFW4WDGTKIoMho7R5Er157KNNc9SnlM5fQQ3zN5ORfPzQfj1B1O
	 DaR9k3oBtMKlQ6TCBLOarKZtGUbKRpNsjHhw+XFw=
Subject: FAILED: patch "[PATCH] udf: fix partition descriptor append bookkeeping" failed to apply to 5.10-stable tree
To: bioloidgp@gmail.com,jack@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 May 2026 10:37:27 +0200
Message-ID: <2026050427-dreamless-halogen-0749@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1E4254BA517
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242884-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,suse.cz];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 08841b06fa64d8edbd1a21ca6e613420c90cc4b8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050427-dreamless-halogen-0749@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 08841b06fa64d8edbd1a21ca6e613420c90cc4b8 Mon Sep 17 00:00:00 2001
From: Seohyeon Maeng <bioloidgp@gmail.com>
Date: Tue, 10 Mar 2026 17:16:52 +0900
Subject: [PATCH] udf: fix partition descriptor append bookkeeping

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

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 27f463fd1d89..df2b62eddfc0 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1694,8 +1694,9 @@ static struct udf_vds_record *handle_partition_descriptor(
 			return &(data->part_descs_loc[i].rec);
 	if (data->num_part_descs >= data->size_part_descs) {
 		struct part_desc_seq_scan_data *new_loc;
-		unsigned int new_size = ALIGN(partnum, PART_DESC_ALLOC_STEP);
+		unsigned int new_size;
 
+		new_size = data->num_part_descs + PART_DESC_ALLOC_STEP;
 		new_loc = kzalloc_objs(*new_loc, new_size);
 		if (!new_loc)
 			return ERR_PTR(-ENOMEM);
@@ -1705,6 +1706,7 @@ static struct udf_vds_record *handle_partition_descriptor(
 		data->part_descs_loc = new_loc;
 		data->size_part_descs = new_size;
 	}
+	data->part_descs_loc[data->num_part_descs].partnum = partnum;
 	return &(data->part_descs_loc[data->num_part_descs++].rec);
 }
 


