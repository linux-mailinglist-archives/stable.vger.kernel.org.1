Return-Path: <stable+bounces-242881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN9pEGpb+GlStQIAu9opvQ
	(envelope-from <stable+bounces-242881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:40:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D09114BA5C3
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A24543003EA3
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C135F340D9A;
	Mon,  4 May 2026 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2OWGchrQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B92340A57
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883852; cv=none; b=kos90wpytirEoTpIldbltQcr6r04sMxcKvnPOkrUbE2L593+DNzJP3aSl51uhKFPXKCmaqbGcqherpcOzxvXr+6RCAZiVA3/2mLWILN5WTuIuZXjjy3RFxBp/w6gppDApW0M9DsbO2SgXh96ah+OBPjmBiapPl85HCXFi7RmFHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883852; c=relaxed/simple;
	bh=dK8T/5y+G9T945AkjjyyiSScAjC29Y0sH988Z7npqCo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HlRcWj9UY/e6gvjBK0bQfu8qxjFeGpHdIxbLqxTM6YbOi/9lvnDzyORo78dIW4Qo6O36c7DSseifLvJbJH8fvJ+YRj+ciQSNeXztJURVBe8ZWfR1kUCgg/GwPWCHo1tX3mmtL0lUoJIb9YlGRa13pjKQYCCxvVOzr+tudwshzBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2OWGchrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1235C2BCB8;
	Mon,  4 May 2026 08:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777883852;
	bh=dK8T/5y+G9T945AkjjyyiSScAjC29Y0sH988Z7npqCo=;
	h=Subject:To:Cc:From:Date:From;
	b=2OWGchrQ7NZkJisjfR90w8Ls5eDAb9rj6u5RiQK1kTKeM+0aej6xL+5X4jGTd59ms
	 MZ61+ii6hGswSEdd1BQxsd3dFVQs3s1aXYBsTlaEFW6MHJe3/A2iQYvh1A7EvkcvD9
	 Aq7KzXmBZUR5F275f5tmmu2qXPZUrnawsJ9agzx8=
Subject: FAILED: patch "[PATCH] udf: fix partition descriptor append bookkeeping" failed to apply to 6.1-stable tree
To: bioloidgp@gmail.com,jack@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 May 2026 10:37:25 +0200
Message-ID: <2026050425-sage-prelaunch-0822@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D09114BA5C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242881-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 08841b06fa64d8edbd1a21ca6e613420c90cc4b8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050425-sage-prelaunch-0822@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


