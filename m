Return-Path: <stable+bounces-217962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAVXHJYbnmntTQQAu9opvQ
	(envelope-from <stable+bounces-217962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 22:43:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DDD18CDAA
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 22:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C188530848E1
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 21:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA05433E346;
	Tue, 24 Feb 2026 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g+8YycEA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEEF33B6F5
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771969425; cv=none; b=TYzRADElV3NmKzEbieUZE03MLpifj9u/oePRgBuHrJV8Fd81HotU0SIWVYCwTe7CV7zZepnPgD0vmI6Tp+gi5Ip+ojdJVWDqN70I4mQtU08jsPKJqTZi4m04eZkQsPO/2foUpzFlQnQykt4gZfarMWs0fap1vaWULwmuRS5vJcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771969425; c=relaxed/simple;
	bh=qLybutPbKNFNj/fNi7cLnk+J6sFVPJH21qBbZqbxf3Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f3S+nYXe1fJagtlWeZ8I4y0Yo4waNlemFcYfxxQhTr24rPGY85IhbKVB0F4cGYv5/j0PmlNU0rhsUy7MM0RO+qjJscFd15STI6rUTkkb+rec4dcD9cjrpZ9hi3EpZfzC+rYbY+m5WLyQhDy6Oy5JOp4lC6oBFNxGMZi3JVvvKMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g+8YycEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360C4C116D0;
	Tue, 24 Feb 2026 21:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771969425;
	bh=qLybutPbKNFNj/fNi7cLnk+J6sFVPJH21qBbZqbxf3Y=;
	h=Subject:To:Cc:From:Date:From;
	b=g+8YycEAa0Orq1v9fZEAIMHtftkdUutw5hJZEvI9P2UKW1LHHDe4D27azAHOpXKrK
	 MMn4VCPQo+b9QEIJGWkrCc+MbNhC7YGxMFmvWFhbRuLoHzWr/rV+LXLHa5DKwMCtU8
	 9EWrK4z5DNZkg3nNcxfyIXo5+62YY8t44Z5ulh8Q=
Subject: FAILED: patch "[PATCH] ext4: don't zero the entire extent if" failed to apply to 6.6-stable tree
To: yi.zhang@huawei.com,libaokun1@huawei.com,ojaswin@linux.ibm.com,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Feb 2026 13:43:38 -0800
Message-ID: <2026022438-resample-unlit-c02b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217962-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huaweicloud.com:email,linuxfoundation.org:dkim,huawei.com:email]
X-Rspamd-Queue-Id: D7DDD18CDAA
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1bf6974822d1dba86cf11b5f05498581cf3488a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026022438-resample-unlit-c02b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1bf6974822d1dba86cf11b5f05498581cf3488a2 Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Sat, 29 Nov 2025 18:32:34 +0800
Subject: [PATCH] ext4: don't zero the entire extent if
 EXT4_EXT_DATA_PARTIAL_VALID1

When allocating initialized blocks from a large unwritten extent, or
when splitting an unwritten extent during end I/O and converting it to
initialized, there is currently a potential issue of stale data if the
extent needs to be split in the middle.

       0  A      B  N
       [UUUUUUUUUUUU]    U: unwritten extent
       [--DDDDDDDD--]    D: valid data
          |<-  ->| ----> this range needs to be initialized

ext4_split_extent() first try to split this extent at B with
EXT4_EXT_DATA_ENTIRE_VALID1 and EXT4_EXT_MAY_ZEROOUT flag set, but
ext4_split_extent_at() failed to split this extent due to temporary lack
of space. It zeroout B to N and mark the entire extent from 0 to N
as written.

       0  A      B  N
       [WWWWWWWWWWWW]    W: written extent
       [SSDDDDDDDDZZ]    Z: zeroed, S: stale data

ext4_split_extent() then try to split this extent at A with
EXT4_EXT_DATA_VALID2 flag set. This time, it split successfully and left
a stale written extent from 0 to A.

       0  A      B   N
       [WW|WWWWWWWWWW]
       [SS|DDDDDDDDZZ]

Fix this by pass EXT4_EXT_DATA_PARTIAL_VALID1 to ext4_split_extent_at()
when splitting at B, don't convert the entire extent to written and left
it as unwritten after zeroing out B to N. The remaining work is just
like the standard two-part split. ext4_split_extent() will pass the
EXT4_EXT_DATA_VALID2 flag when it calls ext4_split_extent_at() for the
second time, allowing it to properly handle the split. If the split is
successful, it will keep extent from 0 to A as unwritten.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Cc: stable@kernel.org
Message-ID: <20251129103247.686136-3-yi.zhang@huaweicloud.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 8d5ca450aa5d..1fee84ea20af 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3310,6 +3310,15 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 		}
 
 		if (!err) {
+			/*
+			 * The first half contains partially valid data, the
+			 * splitting of this extent has not been completed, fix
+			 * extent length and ext4_split_extent() split will the
+			 * first half again.
+			 */
+			if (split_flag & EXT4_EXT_DATA_PARTIAL_VALID1)
+				goto fix_extent_len;
+
 			/* update the extent length and mark as initialized */
 			ex->ee_len = cpu_to_le16(ee_len);
 			ext4_ext_try_to_merge(handle, inode, path, ex);
@@ -3379,7 +3388,9 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
 				       EXT4_EXT_MARK_UNWRIT2;
 		if (split_flag & EXT4_EXT_DATA_VALID2)
-			split_flag1 |= EXT4_EXT_DATA_ENTIRE_VALID1;
+			split_flag1 |= map->m_lblk > ee_block ?
+				       EXT4_EXT_DATA_PARTIAL_VALID1 :
+				       EXT4_EXT_DATA_ENTIRE_VALID1;
 		path = ext4_split_extent_at(handle, inode, path,
 				map->m_lblk + map->m_len, split_flag1, flags1);
 		if (IS_ERR(path))


