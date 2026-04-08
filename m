Return-Path: <stable+bounces-234067-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM8uGF6a1mmTGggAu9opvQ
	(envelope-from <stable+bounces-234067-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:11:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 300BD3C020D
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B4143014FE8
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2693D8917;
	Wed,  8 Apr 2026 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m4d4gnT6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0062F37F8C2;
	Wed,  8 Apr 2026 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671900; cv=none; b=CoaEWzYpS4w0UV48beP12ty7wM5XlCGiRXdOh3DouS6aalfuARFSHtvShQ+WhJ9MkJ4hHqcGTZMvxbgz2wn3Y24PWiDQL/qCRBeoyO82AE0+MqKfGWCo7NFmNpc44H1WxC0AlP8aDAqb1a/tPAbu8f3KQS1RJe4GvACf8yVx9/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671900; c=relaxed/simple;
	bh=xYzVZKNk6pneEnkdU4dGTq5ntB1j5mVNY1DbUSWrR7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMUlbOXmrJR4oVP+488xRzK3N7UhgDBVZWqKNuW11URF2T5UuEWLWyyn2vUKBuB5q0jCYrUl3XrsQ4sEWUOlbrxCF6YsSdiZNh7uiCpXF8lQc+AOD7K+LxISfK4MrE+HhvtLg0gfEqxtUtTY18tlrn6ZxQe75k7zgx9GooNpBUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m4d4gnT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2BDC19421;
	Wed,  8 Apr 2026 18:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775671899;
	bh=xYzVZKNk6pneEnkdU4dGTq5ntB1j5mVNY1DbUSWrR7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m4d4gnT6kmnfXuVZcCsQahE9XAy4zx8cw4+1aVWzNPKgIss8Ap4zthicJ1iOL5nF2
	 nxhDJt4G/AGT29sMTf8T89PDf3sEVBssSenfZpQNBLszOzE36GxHeuU3fFEf0PuRgQ
	 2hTLX+mdubkfY+Stvxr5H7FYd4XM+p1ccRiuTkQU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Long Li <leo.lilong@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 6.1 111/312] xfs: fix ri_total validation in xlog_recover_attri_commit_pass2
Date: Wed,  8 Apr 2026 20:00:28 +0200
Message-ID: <20260408175937.912547922@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234067-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,huawei.com:email]
X-Rspamd-Queue-Id: 300BD3C020D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <leo.lilong@huawei.com>

commit d72f2084e30966097c8eae762e31986a33c3c0ae upstream.

The ri_total checks for SET/REPLACE operations are hardcoded to 3,
but xfs_attri_item_size() only emits a value iovec when value_len > 0,
so ri_total is 2 when value_len == 0.

For PPTR_SET/PPTR_REMOVE/PPTR_REPLACE, value_len is validated by
xfs_attri_validate() to be exactly sizeof(struct xfs_parent_rec) and
is never zero, so their hardcoded checks remain correct.

This problem may cause log recovery failures. The following script can be
used to reproduce the problem:

 #!/bin/bash
 mkfs.xfs -f /dev/sda
 mount /dev/sda /mnt/test/
 touch /mnt/test/file
 for i in {1..200}; do
         attr -s "user.attr_$i" -V "value_$i" /mnt/test/file > /dev/null
 done
 echo 1 > /sys/fs/xfs/debug/larp
 echo 1 > /sys/fs/xfs/sda/errortag/larp
 attr -s "user.zero" -V "" /mnt/test/file
 echo 0 > /sys/fs/xfs/sda/errortag/larp
 umount /mnt/test
 mount /dev/sda /mnt/test/  # mount failed

Fix this by deriving the expected count dynamically as "2 + !!value_len"
for SET/REPLACE operations.

Cc: stable@vger.kernel.org # v6.9
Fixes: ad206ae50eca ("xfs: check opcode and iovec count match in xlog_recover_attri_commit_pass2")
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_attr_item.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -739,8 +739,8 @@ xlog_recover_attri_commit_pass2(
 	switch (op) {
 	case XFS_ATTRI_OP_FLAGS_SET:
 	case XFS_ATTRI_OP_FLAGS_REPLACE:
-		/* Log item, attr name, attr value */
-		if (item->ri_total != 3) {
+		/* Log item, attr name, optional attr value */
+		if (item->ri_total != 2 + !!attri_formatp->alfi_value_len) {
 			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 					     attri_formatp, len);
 			return -EFSCORRUPTED;



