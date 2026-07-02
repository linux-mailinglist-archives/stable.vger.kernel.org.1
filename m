Return-Path: <stable+bounces-271479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N3HcMTanRmpFbAsAu9opvQ
	(envelope-from <stable+bounces-271479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 20:00:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F496FBC6D
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 20:00:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=wqyin96c;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271479-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271479-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CB503315E14
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 17:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C174E30B53E;
	Thu,  2 Jul 2026 17:00:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E84D433E87;
	Thu,  2 Jul 2026 17:00:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011652; cv=none; b=AEV05gJ1DAGX6krGY1NJsBblPYRfLom9CAYzshv39NtVy2L/fNu3AOoivb1MzwT3N/rxral7bip02zOYSTZeZ6r/L4MHKY0jR7DmrmA34PCDbqNcqYKYOR1WqsazjLc6CN7wbJq/E1smOd+8ApJWWUxw2aCdplKQnXfibK1S+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011652; c=relaxed/simple;
	bh=PiyIF8mIdnipiYcObKZw793xKZ7MVTUyN3ppmLGRQWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocM7Hcybt2mpAQUYE5yrji6ZFDQgJU0uk+Rcl77wecEQJCTS+bF+uNXr6pTxrLHvoPudIEOsU1Of7LSLXXTpGj3pIsRPC2AnsUj5Pt5BFZDgeX7l2+1MToZ+rQnlegphgZ60IrwI2MOHd2T7SPHGiudJokfYzhdB1R7XrutSveo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wqyin96c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012451F000E9;
	Thu,  2 Jul 2026 17:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011651;
	bh=JvHj066W9GUM936W4IUoy+TgtS7j0tcgzH/ALBLTTqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wqyin96cEFFgh1d9UtnD4fFpbmhE+ikzOfSJmh69uwqoyPIiiPzU6eHaNhG9F6KV7
	 URUnUF154OBGOkuws6GZ+tLVgszfDtVDsDmQO+KR4SVKyZh0Iwh+9aYH8ymQV768NV
	 kODX/JNq/Cxa1mRqDu7SElokrmCGKBSkLVKwAbZk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com,
	Tristan Madani <tristan@talencesecurity.com>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 7.1 080/120] gfs2: fix use-after-free in gfs2_qd_dealloc
Date: Thu,  2 Jul 2026 18:21:16 +0200
Message-ID: <20260702155114.615729554@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.964534952@linuxfoundation.org>
References: <20260702155112.964534952@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-271479-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com,m:tristan@talencesecurity.com,m:agruenba@redhat.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,42a37bf8045847d8f9d2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,appspotmail.com:email,talencesecurity.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11F496FBC6D

7.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tristan Madani <tristan@talencesecurity.com>

commit f9c9ec2c319f843b70ecdf939d48b52d189bc081 upstream.

gfs2_qd_dealloc(), called as an RCU callback from gfs2_qd_dispose(),
accesses the superblock object sdp through qd->qd_sbd after freeing qd.
It does so to decrement sd_quota_count and wake up sd_kill_wait.

However, by the time the RCU callback runs, gfs2_put_super() may have
already freed sdp via free_sbd().  This can happen when
gfs2_quota_cleanup() is called during unmount: it disposes of quota
objects via call_rcu() and then waits on sd_kill_wait with a 60-second
timeout.  If the timeout expires, or if gfs2_gl_hash_clear() triggers
additional qd_put() calls that schedule more RCU callbacks after the
wait completes, gfs2_put_super() will proceed to free the superblock
while RCU callbacks referencing it are still pending.

Add an rcu_barrier() before free_sbd() in gfs2_put_super() to ensure
all pending RCU callbacks (including gfs2_qd_dealloc) have completed
before the superblock is freed.

Fixes: a475c5dd16e5 ("gfs2: Free quota data objects synchronously")
Reported-by: syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=42a37bf8045847d8f9d2
Tested-by: syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/gfs2/super.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -643,6 +643,7 @@ restart:
 	gfs2_delete_debugfs_file(sdp);
 
 	gfs2_sys_fs_del(sdp);
+	rcu_barrier();
 	free_sbd(sdp);
 }
 



