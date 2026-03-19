Return-Path: <stable+bounces-227340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAH9LjInvGkxtgIAu9opvQ
	(envelope-from <stable+bounces-227340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:41:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BA62CEF93
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B79253065AD4
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 16:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B97D3ED5C8;
	Thu, 19 Mar 2026 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sbw8KOHG"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174F82D7DDC
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937363; cv=none; b=eJK5OuCvIzsNPsa7mbf5dM7m2WNJRzFd/jmDZQTieZ8+wLqCwRAKiyDxjC0y8DvJSf3n2/bOlf1EcPrwDOLjXjC8w7yzvOtutJ4rZJ26ZKsauCHHhOoAMYUouYcjRCpiA2tUyPchoI+BQ02Yy6FduUibWDYsSzUATIQIky9gaQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937363; c=relaxed/simple;
	bh=BnVx0e4sHUG2CxvPexFEtjwoJjLDYgxZk+AFIqdD7Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/ps2uVV+AVQqblNlWCA+jgEWuoH674CuWfkTE1MoqwDnD5K3qX8gEkQFQ0ov9mFylTh0DuIC73H4Dj8Fq5iscQliXhVNkCp3oFPy4xJw+74jUtJOTd+sYrJIPt7eAfOZRzAstvYDqz1epGPdDlqrMtLWJFeyG48YnZ6Iw8rQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sbw8KOHG; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773937350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t0iie7bEOScOeBpsKCJ5AujwIH+1zOg24zDax1kXgG8=;
	b=Sbw8KOHGrxkAxghoE5N85VkV9v+aCyn3VtHcG6hfcyyaG9cynsR9ECTZLAz/8kPzFd++ip
	q+kj8uzvgUWxHCDtNVzCvzpdNGgi7SdcJESNL14RtsREbP645eLlbRz6oaD4dVOBwsYXNA
	fzYzn1+7fhGSwiZrcmmAcb/ZD7thuqM=
From: Junjie Cao <junjie.cao@linux.dev>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+466a45fcfb0562f5b9a0@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Junjie Cao <junjie.cao@linux.dev>
Subject: [PATCH] nilfs2: skip blocks with no bmap entry in nilfs_ioctl_mark_blocks_dirty()
Date: Fri, 20 Mar 2026 00:21:59 +0800
Message-ID: <20260319162159.302104-1-junjie.cao@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227340-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,dubeyko.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.849];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[junjie.cao@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,466a45fcfb0562f5b9a0];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 28BA62CEF93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In nilfs_ioctl_mark_blocks_dirty(), called during garbage collection,
nilfs_bmap_lookup_at_level() may return -ENOENT when a block no longer
exists in the DAT bmap.  In that case the code sets bd_blocknr to 0 but
falls through to the liveness check that compares bd_blocknr against
bd_oblocknr.  If bd_oblocknr also happens to be 0, the descriptor is
incorrectly treated as live and the code attempts to get or mark the
non-existent block, triggering a WARN_ON.

Fix this by adding a continue statement so that a block descriptor is
immediately skipped when its bmap lookup returns -ENOENT, since there
is no block in the DAT to mark dirty.

Fixes: 7942b919f732 ("nilfs2: ioctl operations")
Reported-by: syzbot+466a45fcfb0562f5b9a0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=466a45fcfb0562f5b9a0
Cc: stable@vger.kernel.org
Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 fs/nilfs2/ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 1bfe8a2..d71a0a5 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -744,6 +744,7 @@ static int nilfs_ioctl_mark_blocks_dirty(struct the_nilfs *nilfs,
 		if (ret < 0) {
 			if (ret != -ENOENT)
 				return ret;
 			bdescs[i].bd_blocknr = 0;
+			continue;
 		}
 		if (bdescs[i].bd_blocknr != bdescs[i].bd_oblocknr)
 			/* skip dead block */
-- 
2.43.0

