Return-Path: <stable+bounces-231175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEsYIB1Zymn27gUAu9opvQ
	(envelope-from <stable+bounces-231175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:06:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B24359E87
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A76CD301E94D
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963003ACA72;
	Mon, 30 Mar 2026 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xZEfo1Qr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4C33BED70
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868760; cv=none; b=XrlhWZZiXosTtw+9vwK2ljvajveH5/Y/h1FsvYHBemqK7ltYWT4ZE28RAVtc0Ccpj2t/RZW3ffFcIBLzRyDkb/JoILcqwz4t5zysDzwBJ5hM9isuGmoO9R7sH0cZIpe/6+ypYeCHP1i3Zg1k4u9nQEiCRbNRvHlbahmMpHW47vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868760; c=relaxed/simple;
	bh=stbTGPf3TokBs+T05b4JfWEnZdBJwRO96lVBg2viC6g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AHTuLJ/zhlCIXHjpdCwZgACt0M5Et0Zei8Cubj2GJGy8dyhVuFuDvTBDk54NsieqWcV6PADbFFYSul3aj3M1zkQLv4UeNwS3hTHUXuDN2D+FhM5+YL3H6KOoLQPCk52ygaBYvSYxgGiEP33HYHG+bOxZWxxx7dvkXbR7B3Czn2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xZEfo1Qr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF38DC2BCB0;
	Mon, 30 Mar 2026 11:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774868759;
	bh=stbTGPf3TokBs+T05b4JfWEnZdBJwRO96lVBg2viC6g=;
	h=Subject:To:Cc:From:Date:From;
	b=xZEfo1QrjU/m9GBdlrCSN3S6ViS8aClWw7T2aHNs4Owk+ANfry7xbaVAcf5+rq0Dh
	 CY4Adg59fG0oEh9rhL5R7XwNxCr6HFZOyCylkxUj9IwTHct3j/X53l3lk6fO/UyQ7D
	 Cl0ZA723AZm+z/QKqmeP32eUgh1ssUhe9NHgqzv8=
Subject: FAILED: patch "[PATCH] ext4: handle wraparound when searching for blocks for" failed to apply to 5.15-stable tree
To: tytso@mit.edu,jack@suse.cz,libaokun@linux.alibaba.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 13:05:45 +0200
Message-ID: <2026033045-backlands-hunk-0977@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-231175-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,msgid.link:url,gregkh:email,suse.cz:email]
X-Rspamd-Queue-Id: E5B24359E87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x bb81702370fad22c06ca12b6e1648754dbc37e0f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033045-backlands-hunk-0977@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bb81702370fad22c06ca12b6e1648754dbc37e0f Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Thu, 26 Mar 2026 00:58:34 -0400
Subject: [PATCH] ext4: handle wraparound when searching for blocks for
 indirect mapped blocks

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

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index bb6faebf9b6d..cb2bd87c355c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1199,6 +1199,8 @@ static int ext4_mb_scan_groups(struct ext4_allocation_context *ac)
 
 	/* searching for the right group start from the goal value specified */
 	start = ac->ac_g_ex.fe_group;
+	if (start >= ngroups)
+		start = 0;
 	ac->ac_prefetch_grp = start;
 	ac->ac_prefetch_nr = 0;
 


