Return-Path: <stable+bounces-267022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VN+MJM6jM2pBEgYAu9opvQ
	(envelope-from <stable+bounces-267022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 09:52:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDA569E3A0
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 09:52:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=i40fXJYc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267022-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267022-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D13530923A5
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2743D6CCF;
	Thu, 18 Jun 2026 07:49:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3783D669C
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 07:49:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768972; cv=none; b=Gh6PLPIWDdVGc4mOFs4B0l0yuqOwJYhaRY9MB1E+6odXnJ01cEOvQIJvNXkzrdr7UP64KOxAwIAD0uiKgzVw5pNRHjlPqlX7dLAiL41Sqzh+hTh4UMy35RAxmMpiBUCs8ksFC/7XH3/7vZ5fdLk4sin/3zY0W7SCe9nVH8X6mHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768972; c=relaxed/simple;
	bh=zD16fMf0ZMJoNAbDkUkjkvBtlSpglsJNvNSt8JU7lxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARmYtRzSN7BUg+oQpIqHyXz4IUM/m4DtripGmNsT1g2Ab67NflxGZa+2Vo39rQDRlAG1lIHTYGX47WYrZBDk7nugCRgiuYn2eYzDWg24m7I31DfDU+OddCdx0DnkyROO+tBvDPEQT9I0RYtksEVfIT7DBfHTuSdzBlXBKUjfeHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i40fXJYc; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781768969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfHVYwJjeckBljNNeVdi/xVk7ybji0LvQllDM/zHzBw=;
	b=i40fXJYcwCsmqgA3OVlNd0otyxwDyFvAkwZee33aCDaiwB3Ez2wiW41PrQHEm5I47myzP0
	WS0wdcDOzlyrGR4IbpkowIwlY397O6HeXqBtn7cMYp3fZC7XAHbO900h9hFnxpEcalbQtw
	2vgbOW/5c2sO79zmPFxIi0aE7HBYM6o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-GwN2JcrROYW-jJgfoeTfMQ-1; Thu,
 18 Jun 2026 03:49:26 -0400
X-MC-Unique: GwN2JcrROYW-jJgfoeTfMQ-1
X-Mimecast-MFC-AGG-ID: GwN2JcrROYW-jJgfoeTfMQ_1781768965
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28EB61956044;
	Thu, 18 Jun 2026 07:49:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4A9F0180058D;
	Thu, 18 Jun 2026 07:49:20 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matvey Kovalev <matvey.kovalev@ispras.ru>,
	stable@vger.kernel.org
Subject: [PATCH v2 03/17] afs: fix NULL pointer dereference in afs_get_tree()
Date: Thu, 18 Jun 2026 08:48:46 +0100
Message-ID: <20260618074903.2374756-4-dhowells@redhat.com>
In-Reply-To: <20260618074903.2374756-1-dhowells@redhat.com>
References: <20260618074903.2374756-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dhowells@redhat.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267022-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:christian@brauner.io,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:linux-afs@lists.infradead.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:matvey.kovalev@ispras.ru,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,auristor.com:email,ispras.ru:email,infradead.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFDA569E3A0

From: Matvey Kovalev <matvey.kovalev@ispras.ru>

afs_alloc_sbi() uses kzalloc for memory allocation. And, if
ctx->dyn_root is not null, as->cell and as->volume are null.
In trace_afs_get_tree() they are dereferenced.

KASAN error message:

KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 2 PID: 18478 Comm: syz-executor.7 Not tainted 5.10.246-syzkaller #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1
04/01/2014
RIP: 0010:perf_trace_afs_get_tree+0x1d9/0x550
include/trace/events/afs.h:1365

Call Trace:
trace_afs_get_tree include/trace/events/afs.h:1365 [inline]
afs_get_tree+0x922/0x1350 fs/afs/super.c:599
vfs_get_tree+0x8e/0x300 fs/super.c:1572
do_new_mount fs/namespace.c:3011 [inline]
path_mount+0x14a5/0x2220 fs/namespace.c:3341
do_mount fs/namespace.c:3354 [inline]
__do_sys_mount fs/namespace.c:3562 [inline]
__se_sys_mount fs/namespace.c:3539 [inline]
__x64_sys_mount+0x283/0x300 fs/namespace.c:3539
 do_syscall_64+0x33/0x50 arch/x86/entry/common.c:46
entry_SYSCALL_64_after_hwframe+0x67/0xd1

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 80548b03991f5 ("afs: Add more tracepoints")
Cc: stable@vger.kernel.org
Signed-off-by: Matvey Kovalev <matvey.kovalev@ispras.ru>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index 942f3e9800d7..dec091e569c4 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -587,7 +587,8 @@ static int afs_get_tree(struct fs_context *fc)
 	}
 
 	fc->root = dget(sb->s_root);
-	trace_afs_get_tree(as->cell, as->volume);
+	if (!ctx->dyn_root)
+		trace_afs_get_tree(as->cell, as->volume);
 	_leave(" = 0 [%p]", sb);
 	return 0;
 


