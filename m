Return-Path: <stable+bounces-232175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMR9A7gEzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:30:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFAE36ED4F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A72B316A6CF
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBC7425CC5;
	Tue, 31 Mar 2026 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gWQ61184"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E78423149;
	Tue, 31 Mar 2026 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976070; cv=none; b=L/1Xt9B71yurF+7i3gWgvrXFVMInOAO9qTtF1hJFsCzKRIzmqVY62kZFPU8zZH77VGrYZbup3VEz++WPdzrI6+dEIsvWwBuG6LtGkGVDjVgUoBeZI8iip5jBDyO18h1s6yiK/2Y7thLbait4WIlurhU7X9exjhQ+ip5jn84KiAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976070; c=relaxed/simple;
	bh=DkNZK3DX7OTvmlLSUPfoNd1hgr0L+k8OdEpKUECWPaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJ5Tzj0cd57vKD0+khkcP42HtLrb0CsjQED+dO051PNvnLLv3Llp3SDdPfs80sM5M9FegTSHP7FhB8SMJDEb4cOfG770GST2k3CNq1GtQoVOevQ+7ltcM1sJCcG3vUlwZv+C5qZADq6dtEd+bsUTir04U9UBh5vFWSx6+2SLK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gWQ61184; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2B2C19423;
	Tue, 31 Mar 2026 16:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976070;
	bh=DkNZK3DX7OTvmlLSUPfoNd1hgr0L+k8OdEpKUECWPaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWQ61184HFxfR6oi1tu8XbiPzwSwevscKZBmlSLBeicnbDoxMqdamuHma7/luwWA8
	 6DGuRuhmKtr3q8/BH4GIb61C3Mkj80ga5RvbPAjzFgbmP3CWLYQuz+X1E12NHo0BTE
	 COVcZ+7Vof/psNY8mDEMAs6PUw8//1rKv8uF2dFs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 6.12 195/244] ext4: handle wraparound when searching for blocks for indirect mapped blocks
Date: Tue, 31 Mar 2026 18:22:25 +0200
Message-ID: <20260331161748.951850225@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232175-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,suse.cz:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6EFAE36ED4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit bb81702370fad22c06ca12b6e1648754dbc37e0f upstream.

Commit 4865c768b563 ("ext4: always allocate blocks only from groups
inode can use") restricts what blocks will be allocated for indirect
block based files to block numbers that fit within 32-bit block
numbers.

However, when using a review bot running on the latest Gemini LLM to
check this commit when backporting into an LTS based kernel, it raised
this concern:

   If ac->ac_g_ex.fe_group is >= ngroups (for instance, if the goal
   group was populated via stream allocation from s_mb_last_groups),
   then start will be >= ngroups.

   Does this allow allocating blocks beyond the 32-bit limit for
   indirect block mapped files? The commit message mentions that
   ext4_mb_scan_groups_linear() takes care to not select unsupported
   groups. However, its loop uses group = *start, and the very first
   iteration will call ext4_mb_scan_group() with this unsupported
   group because next_linear_group() is only called at the end of the
   iteration.

After reviewing the code paths involved and considering the LLM
review, I determined that this can happen when there is a file system
where some files/directories are extent-mapped and others are
indirect-block mapped.  To address this, add a safety clamp in
ext4_mb_scan_groups().

Fixes: 4865c768b563 ("ext4: always allocate blocks only from groups inode can use")
Cc: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Link: https://patch.msgid.link/20260326045834.1175822-1-tytso@mit.edu
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/mballoc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1199,6 +1199,8 @@ static int ext4_mb_scan_groups(struct ex
 
 	/* searching for the right group start from the goal value specified */
 	start = ac->ac_g_ex.fe_group;
+	if (start >= ngroups)
+		start = 0;
 	ac->ac_prefetch_grp = start;
 	ac->ac_prefetch_nr = 0;
 



