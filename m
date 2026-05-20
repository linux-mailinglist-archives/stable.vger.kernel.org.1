Return-Path: <stable+bounces-252878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFssE50YDmqA6AUAu9opvQ
	(envelope-from <stable+bounces-252878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:25:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 661415998D7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59454306FA51
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60051342CB3;
	Wed, 20 May 2026 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T2DavBXA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DEC270545;
	Wed, 20 May 2026 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301825; cv=none; b=Q6fTL2UPk57ze7GeDvOd/35uqgULEoyzgAgROR7MaZgRgwn7vKMIa9Bocfjk5i+qnXEEiYDamociOLVnAJ5ok05rVcLcopW3S+/FkPVAx3uvOwo8i0qo5DE00aXFd2Xs9PE3xbBvZzXIO3p1jjtEUkLCAgFejUfMa9aISf5oekI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301825; c=relaxed/simple;
	bh=DqrJq3GqzmAlaMMGzuxSkgeFzTrwy/XSXlEPzeLJEac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsXA8wQDkAadLs4fCIBKw26ErJgP9YojGvqF5PNSyvi83WqWHy3+6ZilruB2hKU7bDKONicxDetFEFTfrpEsMzKfZaPPbjhQTs/K2rv0d0xKrFVOthWTZw2DWUwxhN5IDERErJxcT5lz3Ja44UZ7JgU4zPcv0H1bAPzCj92AWoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T2DavBXA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8726D1F000E9;
	Wed, 20 May 2026 18:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301824;
	bh=iRvcfsWH+L8XAmwaD0+eUM83TQ3JTgLOEhj8pR0oPgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T2DavBXAdnTtKIbQnNeB9InWBJXA3VL99xjHe+pfefXEFFuI/a0FI20+uppBfmWgu
	 pMkqbVgWCn5Mfj0dd6jzq/yLk4480Y1FcIhWkDQi0ooIuZD4llMR8QRPND+bUihiWn
	 97jzRHvWpI6yaApwQMuH2RZXi/vO0F+gwKXb9uDw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jackie Liu <liuyun01@kylinos.cn>,
	Tejun Heo <tj@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 006/508] blk-cgroup: fix disk reference leak in blkcg_maybe_throttle_current()
Date: Wed, 20 May 2026 18:17:09 +0200
Message-ID: <20260520162058.719552735@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252878-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,kylinos.cn:email,kernel.dk:email,lst.de:email]
X-Rspamd-Queue-Id: 661415998D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jackie Liu <liuyun01@kylinos.cn>

[ Upstream commit 23308af722fefed00af5f238024c11710938fba3 ]

Add the missing put_disk() on the error path in
blkcg_maybe_throttle_current(). When blkcg lookup, blkg lookup, or
blkg_tryget() fails, the function jumps to the out label which only
calls rcu_read_unlock() but does not release the disk reference acquired
by blkcg_schedule_throttle() via get_device(). Since current->throttle_disk
is already set to NULL before the lookup, blkcg_exit() cannot release
this reference either, causing the disk to never be freed.

Restore the reference release that was present as blk_put_queue() in the
original code but was inadvertently dropped during the conversion from
request_queue to gendisk.

Fixes: f05837ed73d0 ("blk-cgroup: store a gendisk to throttle in struct task_struct")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20260331085054.46857-1-liu.yun@linux.dev
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 40c9d5805b88b..4ac2f53e7f51f 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1993,6 +1993,7 @@ void blkcg_maybe_throttle_current(void)
 	return;
 out:
 	rcu_read_unlock();
+	put_disk(disk);
 }
 
 /**
-- 
2.53.0




