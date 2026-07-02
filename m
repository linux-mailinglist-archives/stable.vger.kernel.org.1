Return-Path: <stable+bounces-270489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T4odHzZmRmrnSgsAu9opvQ
	(envelope-from <stable+bounces-270489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 15:23:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C77896F8481
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 15:23:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=PUgz620n;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270489-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270489-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD1D7314E9A1
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 13:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9323C35E1A9;
	Thu,  2 Jul 2026 13:12:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692602E737B
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:12:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997949; cv=none; b=pTlo8cOzEXZkhNeTqvVp1IXZWCBTvS1oej5/+Q9xU7dGVuN9MmV79nwH8DyRf52Zkjl3OHCg9/75F/uxBvRMd5BOM1XCgBiHJ+ZRyFRac7Kqw2yKBR6txbXm4Q9NmDKE88pkfTACc5pThOJ+Q9vNg/3AmLmhM/+0Ecu5bRDauYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997949; c=relaxed/simple;
	bh=wEBdJYryoba+N7JnsIeOVZRRDph/dwEC32bCLnzcXEE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u39lCg6x0SFqEmC6KDrqXudrXKAWlm0sNqg+4k2zwkVqesfN3ope3Yq14cLg/KLS/G0S8MzJMwntBSH9y+h5YLg5m3u9ZPrK/j7ybevmzSWIS2vVCo2qgvHWXU15v4IZAk9aZCMo+Uajfsj7KG5OdXag+S2oRWAi5iU3E7cLMUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PUgz620n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75091F000E9;
	Thu,  2 Jul 2026 13:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782997948;
	bh=Fx9+LpFy3LlkYwD++M8K7O/VVkdr5BDwhGRiBniZwIM=;
	h=Subject:To:Cc:From:Date;
	b=PUgz620np/9fq2ETXdYP9riAYAux4ni6oxXfSg0o5Pm10unEVzSjWpraOxI8O6N5O
	 7gTXYf4knK2ky7RlixDhR1gBQf7ytIVjx3TS3wsuwASxjA8hUbopSnmCVQU6hEin/l
	 bvxWIYzidE376F855wwgg4KqaITMxctWl61A0Xho=
Subject: FAILED: patch "[PATCH] f2fs: fix listxattr handling of corrupted xattr entries" failed to apply to 5.15-stable tree
To: iganschel@gmail.com,chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:12:02 +0200
Message-ID: <2026070202-tint-clean-159e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270489-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:iganschel@gmail.com,m:chao@kernel.org,m:jaegeuk@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C77896F8481


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5ef5bc304f23c3fe255d4936472378dcb74d0e94
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070202-tint-clean-159e@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5ef5bc304f23c3fe255d4936472378dcb74d0e94 Mon Sep 17 00:00:00 2001
From: Keshav Verma <iganschel@gmail.com>
Date: Mon, 22 Jun 2026 20:44:21 +0530
Subject: [PATCH] f2fs: fix listxattr handling of corrupted xattr entries

Validate the xattr entry before reading its fields in f2fs_listxattr().
Return -EFSCORRUPTED when the entry is outside the valid xattr storage
area instead of returning a successful partial result.

Fixes: 688078e7f36c ("f2fs: fix to avoid memory leakage in f2fs_listxattr")
Cc: stable@kernel.org
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Keshav Verma <iganschel@gmail.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 24cef7e1f56a..ed33e5110f2a 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -583,8 +583,6 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 		size_t prefix_len;
 		size_t size;
 
-		prefix = f2fs_xattr_prefix(entry->e_name_index, dentry);
-
 		if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
 			(void *)XATTR_NEXT_ENTRY(entry) > last_base_addr) {
 			f2fs_err(F2FS_I_SB(inode), "list inode (%llu) has corrupted xattr",
@@ -594,9 +592,11 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 						ERROR_CORRUPTED_XATTR);
 			fserror_report_file_metadata(inode,
 						-EFSCORRUPTED, GFP_NOFS);
-			break;
+			error = -EFSCORRUPTED;
+			goto cleanup;
 		}
 
+		prefix = f2fs_xattr_prefix(entry->e_name_index, dentry);
 		if (!prefix)
 			continue;
 


