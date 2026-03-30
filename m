Return-Path: <stable+bounces-231174-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHCNHxlZymn27gUAu9opvQ
	(envelope-from <stable+bounces-231174-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:06:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DDF359E80
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9036F301D6AB
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4DA3C3430;
	Mon, 30 Mar 2026 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fT/2na89"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F167B3BE653
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868757; cv=none; b=e07LjvnFsZTgeQ2OvQCz8OKHsVDMyfZD7+pFHfkR/lRAOrv1xbhhjcikpCmKxj7Eewv+sPcud9m4pe7Palodr/mrJdTfclzEcAPl/Dg120mGHvaNQF956yuQkpx9mWAHp7whPHL/bj3OlD0lITZK+ffE3OlEvAAQ5sKHsUTktd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868757; c=relaxed/simple;
	bh=SODvWe8PgAxEho98GoEyBH57/2Y6gGCiiTtG1vF9HDc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kYmbrQAxbkY2n19IFT/356NrlgnQ9Bz7dMng820y93YXXhJOJgbKBfmLZ+6QBsa7ydU7qthwwh+7VGW4Z5Gfo1kXYEAgQx4JqQgO8MYC4qBH2H0MJbO7DbySHKBwEofl/7ifgawLXTaCeh2O6rOQ+6psV4uQQphSzTiZYCe9VCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fT/2na89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7D1C4CEF7;
	Mon, 30 Mar 2026 11:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774868756;
	bh=SODvWe8PgAxEho98GoEyBH57/2Y6gGCiiTtG1vF9HDc=;
	h=Subject:To:Cc:From:Date:From;
	b=fT/2na89XUgvWB42CH6F8t8mYDmkr8JcmwY73S1Gif7purHyN4A0g3KoEPJJgwGaY
	 z1WuIVEfV8nilCulAeoQdYNXtEu5rFUYad0cNjd5D64734gh18DCrwMQizjGknJ1Mq
	 go/cxYDvE6t+lXN09BBusFSENiiGMdzJlnjJZsw8=
Subject: FAILED: patch "[PATCH] ext4: handle wraparound when searching for blocks for" failed to apply to 6.1-stable tree
To: tytso@mit.edu,jack@suse.cz,libaokun@linux.alibaba.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 13:05:44 +0200
Message-ID: <2026033044-doctrine-facelift-8da0@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231174-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,suse.cz:email,msgid.link:url,alibaba.com:email]
X-Rspamd-Queue-Id: D6DDF359E80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x bb81702370fad22c06ca12b6e1648754dbc37e0f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033044-doctrine-facelift-8da0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


