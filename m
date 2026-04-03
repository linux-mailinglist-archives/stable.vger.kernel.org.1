Return-Path: <stable+bounces-233184-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB78IS7Dz2lH0QYAu9opvQ
	(envelope-from <stable+bounces-233184-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 15:39:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF93E3949C6
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 15:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ACDF30CAFB8
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 13:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E46361DB4;
	Fri,  3 Apr 2026 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcTnu8qg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBFA1F8723
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223338; cv=none; b=HLqMbRyLhcODng3QLavC/G4tRzI8vVtOggBJrmJwaqllxnUghDnYIChiWLDgQLG+v6d2tfrdmv6h8tyPsGFq7zDC0imVq2mN2A8ygQJNo87eM9fASjRNLcMwAiEDXSOe7RZ7V4JEQiNzpL3aeI5Cq5PBqgbPDrSp6Gxb9V+2s9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223338; c=relaxed/simple;
	bh=7AwDxCI8Ac/HrpnGkphWnVPYA1JYevd6Hj68Hl/bGrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtrdxACpPEtNj2DnqKwOyYt/Cgsp+8GovZGMS32+4pAZQvDchjmqlJ8t1VtlqmHa7YawpDRX5Sn4rs0wQzDmJIE6ASTkaSWOnFN/Q/AYA63pHrrBw5ZXIXEOw96ZZuU1ZZ40k2qhsC55iO4rpWVJ7U64iXTDB56y/Pamd0i+1Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcTnu8qg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDB0C4CEF7;
	Fri,  3 Apr 2026 13:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775223338;
	bh=7AwDxCI8Ac/HrpnGkphWnVPYA1JYevd6Hj68Hl/bGrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QcTnu8qgXqvLdhR2M+iNsFvgFt+GoL4Apna9MBJ2Bv5iHzMgXVHvxCRkgi73fEw0V
	 BXng/lzlt50mn59AqFCtE6NFUrFp+nawfYhVfPB8tg0fyjaruwvQ3mcYrhrShhGhmM
	 wWMheWZoh8D5Y5SpTB/jZGUf8BwSAIfncrG/QcyvtTaZVxPffDLpWBEBmEd0O7Ddyz
	 q+L5Jr/EHwiu1t7/QXNGhmtqjPYuF/UdlYGUfoQ0ORSJ/az+ng6f5931lYXHZRZkIH
	 wILSS/T2EDTbCXjum6wHdxL/I14nx3cEaj/qHTArf8ni5ljQKEodRUm1uxFi5FCk/m
	 xwfuWUi3iazWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun@linux.alibaba.com>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ext4: handle wraparound when searching for blocks for indirect mapped blocks
Date: Fri,  3 Apr 2026 09:35:36 -0400
Message-ID: <20260403133536.2143135-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033044-doctrine-facelift-8da0@gregkh>
References: <2026033044-doctrine-facelift-8da0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233184-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,alibaba.com:email,msgid.link:url]
X-Rspamd-Queue-Id: DF93E3949C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit bb81702370fad22c06ca12b6e1648754dbc37e0f ]

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
[ adapted fix from ext4_mb_scan_groups() to inline equivalent in ext4_mb_regular_allocator() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e204f16e33ad3..6df1416a60a5e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2729,6 +2729,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		 * from the goal value specified
 		 */
 		group = ac->ac_g_ex.fe_group;
+		if (group >= ngroups)
+			group = 0;
 		ac->ac_groups_linear_remaining = sbi->s_mb_max_linear_groups;
 		prefetch_grp = group;
 
-- 
2.53.0


