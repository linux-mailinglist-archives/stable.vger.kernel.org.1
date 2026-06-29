Return-Path: <stable+bounces-269782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6yOUHEyKQmq+9QkAu9opvQ
	(envelope-from <stable+bounces-269782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 17:07:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1436DC766
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 17:07:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UTWtaIYq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269782-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269782-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 401693147205
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 14:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919A1426D0E;
	Mon, 29 Jun 2026 14:44:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563734218B8;
	Mon, 29 Jun 2026 14:44:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744282; cv=none; b=eFgY8X+2MMvGDrldNGgrLpYGtfs9f76r/aIFrTe5rj4ei7DUh2jlwZQwASWI6wPI87nQ4eTeqRqzRGkPuqj/Agq1Erke1hISMSOUw2mmFq+VwpTe6tEGavOi11QSjBV3+oUT/VpJNRF945wISgLGWjAh+8YbMBtpr+tsNQkv8vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744282; c=relaxed/simple;
	bh=P6RH3uPza7/i5npkvxetS0N9j86oYtT4K5gIPNjKzVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NyZQ4YFVfgmvSvw+tO3BDoFjEKGEfCQR6/slVYZqFdk8qqHYKwyfDnxYEZu74tOraJ2H1aQwUToGFiRHSNJwNfHu+RCzrQs4D+nc5UdR7Rto790+yj3s1EBrAdqS4zpC5dfEjjj7ulzoxyu4QphUvvrFYw9IBI7pUjLBZakOQss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTWtaIYq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899B81F000E9;
	Mon, 29 Jun 2026 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744280;
	bh=Kd7LVRXhQqayNdQaCsVNZXfiEHFjU+l0jmqRhEGwXDg=;
	h=From:To:Cc:Subject:Date;
	b=UTWtaIYqyHgFCVTDkmRR45eFK42+RqOpV3re+1jd3KS79Sp3M4K+ZiuhLtRWwk4Qd
	 aKQQ4R64rEd1TknW7eV9p2gTLWNyu8HNDkFcmJBgd9GAswNC+k3Abvi/CT04uPMo3W
	 y9XPNuUtXgGJS1wAa21xEzVk74TnJF/xlocVKLgMmlJj0fPy92WQks7zyLoyi5rZKh
	 tEytiM2ItM1+2pDQ61EVDjhU2U9R2yYj3Raz06K99THaxdRX5q/1Nc2+CgLwNzodLF
	 09z9r9CEQledrfb5WAADN0HHUR58VtjRIe+kaXBhy91tA07FATCiBppXicTlXYg5dx
	 eLQGxjrn8AsOA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zenghui Yu <yuzenghui@huawei.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH v3] samples/damon/mtier: fail early if address range parameters are invalid
Date: Mon, 29 Jun 2026 07:44:31 -0700
Message-ID: <20260629144432.133962-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269782-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:yuzenghui@huawei.com,m:sj@kernel.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB1436DC766

From: Zenghui Yu <yuzenghui@huawei.com>

The comment on top of `struct damon_region` clearly says that

    For any use case, @ar should be non-zero positive size.

which is now verified in damon_verify_new_region() if the kernel is built
with DAMON_DEBUG_SANITY.

The WARN_ONCE() can be triggered if the mtier sample module is enabled
before node{0,1}_{start,end}_addr have been properly initialized, which is
obviously not good.

 ------------[ cut here ]------------
 start 0 >= end 0
 WARNING: mm/damon/core.c:217 at damon_new_region+0xf4/0x118, CPU#59: bash/341468
 Call trace:
  damon_new_region+0xf4/0x118 (P)
  damon_set_regions+0xfc/0x3c0
  damon_sample_mtier_build_ctx+0xe8/0x3a8
  damon_sample_mtier_start+0x1c/0x90
  damon_sample_mtier_enable_store+0x98/0xb0
  param_attr_store+0xb4/0x128
  module_attr_store+0x2c/0x50
  sysfs_kf_write+0x58/0x90
  kernfs_fop_write_iter+0x16c/0x238
  vfs_write+0x2c0/0x370
  ksys_write+0x74/0x118
  __arm64_sys_write+0x24/0x38
  invoke_syscall+0xa8/0x118
  el0_svc_common.constprop.0+0x48/0xf0
  do_el0_svc+0x24/0x38
  el0_svc+0x54/0x370
  el0t_64_sync_handler+0xa0/0xe8
  el0t_64_sync+0x1ac/0x1b0
 ---[ end trace 0000000000000000 ]---

Note that the same issue can happen if detect_node_addresses is true, and
node 0 or 1 is memoryless. Fix it together by checking the validity of
parameters right before damon_new_region() and fail early if they're
invalid.

Fixes: 82a08bde3cf7 ("samples/damon: implement a DAMON module for memory tiering")
Cc: <stable@vger.kernel.org> # 6.16.x
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v2
- v2: https://lore.kernel.org/20260609064653.1829-1-yuzenghui@huawei.com
- Collect R-b: from SJ.
- Add Fixes: and Cc: stable@.
- Rebase to latest mm-new.
Changes from v1
- v1: https://lore.kernel.org/20260608111534.264-1-yuzenghui@huawei.com
- take into account the detect_node_addresses case (Sashiko)
- based on mm-new (SJ)

This is a fix Cc-ing stable@.  Nonetheless, because it is for a sample
module, not necessarily "super hot".  7.3 should also be a reasonable
target, like the other sample module fixes [1].

[1] https://lore.kernel.org/20260629132641.159851-1-sj@kernel.org

 samples/damon/mtier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index faaaaa12e6206..e567f4edd80ea 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -120,6 +120,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 		addr.end = promote ? node1_end_addr : node0_end_addr;
 	}
 
+	if (addr.start >= addr.end)
+		goto free_out;
+
 	range.start = addr.start;
 	range.end = addr.end;
 

base-commit: c1922f6a1a8b9a120b46051c3c5e3b81b4b75d92
-- 
2.47.3

