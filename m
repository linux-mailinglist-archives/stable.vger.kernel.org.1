Return-Path: <stable+bounces-212971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMvAE46bfmnGbQIAu9opvQ
	(envelope-from <stable+bounces-212971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 01:17:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D63FC4791
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 01:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18799303CA54
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 00:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483961946BC;
	Sun,  1 Feb 2026 00:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ALFtWV7B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1063EBF1D;
	Sun,  1 Feb 2026 00:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769905020; cv=none; b=KhJnQHdSjr1g2R7N/FsvNIQdTHBD1dWjxsYu72xOR1KBBVNuB0u4Dop5Sw0dGoWc/e12Gn3Jnlq79WTctyZJ8qTllI+zJJ/oukKYxQ3jm2cw72IDW3q9rRu9a1YtGNcpZIHdYmjFk62A5xwxF2cPfFTD9JW1T1Xfn5ZQJ4/5CPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769905020; c=relaxed/simple;
	bh=3j/CgG7yX+aDv5FeHL+HHhNbaPpI4aoBqklLvglNgDU=;
	h=Date:To:From:Subject:Message-Id; b=bUSdcvadoXeaqZs75UlPtUadliwNUYWJsIIMD5iX0A+Ch7ufGeRVMstbEYOh7T01xo6++XJ+LLlTDUcZsfv0ZHC7HTl9UaWeb0VG6rmtZpuasaw8mSMFJZt9pH7w1HHjXOeQKrIV9mWn8bzaLBwSGJtxSf/UT/YiCQYLnj+YPAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ALFtWV7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0EAC4CEF1;
	Sun,  1 Feb 2026 00:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769905019;
	bh=3j/CgG7yX+aDv5FeHL+HHhNbaPpI4aoBqklLvglNgDU=;
	h=Date:To:From:Subject:From;
	b=ALFtWV7BTId3C3oW4hLqSc3mdxg0ksgvhd+HhNj9JEHMa6bUWlEEuihiCHavFqVCI
	 BHDrGR1h59ltfQP2qFFzK7e+fXBChANiEyuagvyzkPaEp30CDH8I6FF1POIK8+BQCF
	 g6VZPHILfTb2XpdZA6SZyePjGRaJZEaRa7ZiRXzM=
Date: Sat, 31 Jan 2026 16:16:59 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,piaojun@huawei.com,mark@fasheh.com,junxiao.bi@oracle.com,jlbec@evilplan.org,jiangqi903@gmail.com,gechangwei@live.cn,heming.zhao@suse.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-nonmm-stable] ocfs2-fix-reflink-preserve-cleanup-issue.patch removed from -mm tree
Message-Id: <20260201001659.CD0EAC4CEF1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212971-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,huawei.com,fasheh.com,oracle.com,evilplan.org,gmail.com,live.cn,suse.com,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,linux-foundation.org:email,linux-foundation.org:dkim,live.cn:email,suse.com:email,fasheh.com:email]
X-Rspamd-Queue-Id: 6D63FC4791
X-Rspamd-Action: no action


The quilt patch titled
     Subject: ocfs2: fix reflink preserve cleanup issue
has been removed from the -mm tree.  Its filename was
     ocfs2-fix-reflink-preserve-cleanup-issue.patch

This patch was dropped because it was merged into the mm-nonmm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Heming Zhao <heming.zhao@suse.com>
Subject: ocfs2: fix reflink preserve cleanup issue
Date: Wed, 10 Dec 2025 09:57:24 +0800

commit c06c303832ec ("ocfs2: fix xattr array entry __counted_by error")
doesn't handle all cases and the cleanup job for preserved xattr entries
still has bug:
- the 'last' pointer should be shifted by one unit after cleanup
  an array entry.
- current code logic doesn't cleanup the first entry when xh_count is 1.

Note, commit c06c303832ec is also a bug fix for 0fe9b66c65f3.

Link: https://lkml.kernel.org/r/20251210015725.8409-2-heming.zhao@suse.com
Fixes: 0fe9b66c65f3 ("ocfs2: Add preserve to reflink.")
Signed-off-by: Heming Zhao <heming.zhao@suse.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/ocfs2/xattr.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/ocfs2/xattr.c~ocfs2-fix-reflink-preserve-cleanup-issue
+++ a/fs/ocfs2/xattr.c
@@ -6395,6 +6395,10 @@ static int ocfs2_reflink_xattr_header(ha
 					(void *)last - (void *)xe);
 				memset(last, 0,
 				       sizeof(struct ocfs2_xattr_entry));
+				last = &new_xh->xh_entries[le16_to_cpu(new_xh->xh_count)] - 1;
+			} else {
+				memset(xe, 0, sizeof(struct ocfs2_xattr_entry));
+				last = NULL;
 			}
 
 			/*
_

Patches currently in -mm which might be from heming.zhao@suse.com are



