Return-Path: <stable+bounces-240099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lPJDIyxE52ls6AEAu9opvQ
	(envelope-from <stable+bounces-240099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:32:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCA6438E6B
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F41CC300C9B0
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6742F3A9013;
	Tue, 21 Apr 2026 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cg19Uvk7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3DD3A7F75;
	Tue, 21 Apr 2026 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776763930; cv=none; b=gBkCQdiBjANRSGAzXfubb02p/xozJfTwb9uKakiPrLmGCLTpE6tCMlJ/FUQZBfheVSQcnBxAMzBqtC26cY80skaNkkmOOkLeM/8iFyl3tJchdqCsEs/S2PsrpoZ7pinXh4pthCTlls4tGQ6J/VUcW1K1mc7iphZ152kioxmDWos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776763930; c=relaxed/simple;
	bh=Sq0s3Ai9Uj6WEHE5GsmPeZpiF/Xu9DQRsx09i8yUIR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJsOcAIe8Qt7adQpQCgWo0uKXBH+qWQP5lSP7k+lYIIAtObgcaCEZeubv0pz3AgGBmdmjipcsEwWedT6bNOvSur5QsXfcF5wjFti1YLZYzIIWIxKVjao9iqaHscEQSlFHY63wDE8zkAfhLm0NY+XfLE608716rnKOdqpFJubado=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cg19Uvk7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776763929; x=1808299929;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sq0s3Ai9Uj6WEHE5GsmPeZpiF/Xu9DQRsx09i8yUIR0=;
  b=Cg19Uvk7j+YOkBTWAdlhRj6PwfWgYO/U/9lC33gC/9sFIjPFX4QOTR6K
   Fiw/hq+wxn09HIal7WCx+14W8aBz4f5/OQ2I3/+BFJr9Ng33yGZt4i0P+
   0queH4+ivMaJFSGxRD++i/Y8kNPw/dGd6wL21qCgo4dpLw8fu8maWbUXu
   feoOLXi0kGPF2/9kJy8Tywh87ZY+Vy3SBFkO6rV4CG7pS2K/PBta6o/SW
   TknKBAGHncp+8yZ1b375rPYdNEHEJPuxUMfgjBcnAonyGYHblBky0u+f7
   d2ItoUgsLN54VR92T/nUA+rcWRzLhAX68VxDtOH8ysEE0kZ3g89RMnDGo
   w==;
X-CSE-ConnectionGUID: PsWEmFW+TU2iIogeGMj+SA==
X-CSE-MsgGUID: uGi7M2K2R9GXoqPF46Xi2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88769816"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="88769816"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 02:32:07 -0700
X-CSE-ConnectionGUID: mplqvNn6T1eSQ+PEm4AuZA==
X-CSE-MsgGUID: mgZbQ6OJTRqQZoZo5msFpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="236971344"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 02:32:03 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	jack@suse.cz,
	libaokun@linux.alibaba.com,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+26c4a8cab92d0cda3e3b@syzkaller.appspotmail.com,
	junjie.cao@intel.com
Subject: [PATCH] ext4: prevent out-of-bounds read in ext4_read_inline_data()
Date: Tue, 21 Apr 2026 17:31:38 +0800
Message-ID: <20260421093138.906266-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240099-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[dilger.ca,suse.cz,linux.alibaba.com,linux.ibm.com,gmail.com,huawei.com,vger.kernel.org,syzkaller.appspotmail.com,intel.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[junjie.cao@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable,26c4a8cab92d0cda3e3b];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BCA6438E6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ext4_read_inline_data() reads e_value_offs from the inode buffer_head on
each call, but the decision to enter the xattr value path depends on
i_inline_size cached in EXT4_I(inode) at iget time. If the buffer
contents change after the initial validation, e_value_offs can point
beyond the inode body while i_inline_size still directs the code into
the xattr value path, causing an out-of-bounds read in the memcpy.

Add a bounds check before the memcpy, consistent with
ext4_xattr_ibody_get(). Also guard folio_mark_uptodate() in
ext4_read_inline_folio() since ext4_read_inline_data() can now return
-EFSCORRUPTED.

Fixes: 67cf5b09a46f ("ext4: add the basic function for inline data support")
Cc: stable@vger.kernel.org
Reported-by: syzbot+26c4a8cab92d0cda3e3b@syzkaller.appspotmail.com
Tested-by: syzbot+26c4a8cab92d0cda3e3b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=26c4a8cab92d0cda3e3b
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 fs/ext4/inline.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 408677fa8196..18c678df0a6e 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -211,6 +211,14 @@ static int ext4_read_inline_data(struct inode *inode, void *buffer,
 	len = min_t(unsigned int, len,
 		    (unsigned int)le32_to_cpu(entry->e_value_size));
 
+	if (unlikely((void *)IFIRST(header) + le16_to_cpu(entry->e_value_offs) +
+		     len > (void *)ITAIL(inode, raw_inode))) {
+		EXT4_ERROR_INODE(inode,
+			"inline data value out of bounds (offs %u len %u)",
+			le16_to_cpu(entry->e_value_offs), len);
+		return -EFSCORRUPTED;
+	}
+
 	memcpy(buffer,
 	       (void *)IFIRST(header) + le16_to_cpu(entry->e_value_offs), len);
 	cp_len += len;
@@ -535,7 +543,8 @@ static int ext4_read_inline_folio(struct inode *inode, struct folio *folio)
 	ret = ext4_read_inline_data(inode, kaddr, len, &iloc);
 	kaddr = folio_zero_tail(folio, len, kaddr + len);
 	kunmap_local(kaddr);
-	folio_mark_uptodate(folio);
+	if (ret >= 0)
+		folio_mark_uptodate(folio);
 	brelse(iloc.bh);
 
 out:
-- 
2.43.0


